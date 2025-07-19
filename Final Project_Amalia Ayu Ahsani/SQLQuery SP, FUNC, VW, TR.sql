-- ================================================
-- FUNCTIONS
-- ================================================

-- 1. Function: Auto Admin Fee based on price
CREATE FUNCTION fn_AutoAdminFee (@Price MONEY)
RETURNS MONEY
AS
BEGIN
    RETURN CASE 
        WHEN @Price >= 500000000 THEN 500000
        ELSE 250000
    END
END;
GO

-- 2. Function: Monthly Installment including tax, discount, and admin fee
CREATE FUNCTION fn_MonthlyInstallmentWithFees
(
    @LocalPrice MONEY,
    @TaxRate DECIMAL(5,2),
    @DiscountRate DECIMAL(5,2),
    @AdminFee MONEY,
    @Tenor INT,
    @InterestRate DECIMAL(5,2)
)
RETURNS MONEY
AS
BEGIN
    DECLARE @TotalPrice MONEY
    DECLARE @DiscountedPrice MONEY
    DECLARE @CreditAmount MONEY
    DECLARE @MonthlyInterestRate DECIMAL(10,8)
    DECLARE @MonthlyPayment MONEY

    SET @TotalPrice = @LocalPrice + (@LocalPrice * @TaxRate)
    SET @DiscountedPrice = @TotalPrice - (@TotalPrice * @DiscountRate)
    SET @CreditAmount = @DiscountedPrice + @AdminFee
    SET @MonthlyInterestRate = (@InterestRate / 100.0) / 12.0

    IF @MonthlyInterestRate = 0
        SET @MonthlyPayment = @CreditAmount / @Tenor
    ELSE
        SET @MonthlyPayment = 
            @CreditAmount * @MonthlyInterestRate / 
            (1 - POWER(1 + @MonthlyInterestRate, -@Tenor))

    RETURN ROUND(@MonthlyPayment, 0)
END;
GO

-- ================================================
-- STORED PROCEDURES
-- ================================================

-- 1. Register new customer
CREATE PROCEDURE RegisterCustomer
    @Name VARCHAR(100),
    @CardID VARCHAR(50),
    @Address VARCHAR(200),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO Customer (Name, CardID, Address, PhoneNumber, Email)
    VALUES (@Name, @CardID, @Address, @PhoneNumber, @Email)
END;
GO

EXEC RegisterCustomer 'Test User', 'ID999999', 'Test Address', '081234567000', 'test@example.com';

-- Check inserted result
SELECT * FROM Customer WHERE Name = 'Test User';

-- 2. Credit application with auto calculation
CREATE PROCEDURE ApplyCredit_AutoCalc
    @AgreementID INT,
    @Tenor INT,
    @InterestRate DECIMAL(5,2),
    @DiscountRate DECIMAL(5,2) = 0.0
AS
BEGIN
    DECLARE @DealerCarID INT;
    DECLARE @LocalPrice FLOAT;
    DECLARE @TaxRate FLOAT;
    DECLARE @AdminFee FLOAT;
    DECLARE @MonthlyInstallment FLOAT;
    DECLARE @CreditAmount FLOAT;

    -- Get DealerCarID from Agreement.ID
    SELECT @DealerCarID = DealerCarID
    FROM Agreement
    WHERE ID = @AgreementID;

    -- Get LocalPrice and TaxRate from DealerCar
    SELECT 
        @LocalPrice = LocalPrice,
        @TaxRate = TaxRate
    FROM DealerCar
    WHERE ID = @DealerCarID;

    -- Admin fee via function
    SET @AdminFee = dbo.fn_AutoAdminFee(@LocalPrice + (@LocalPrice * @TaxRate));

    -- Calculate total credit amount
    SET @CreditAmount = 
        (@LocalPrice + (@LocalPrice * @TaxRate)) 
        - ((@LocalPrice + (@LocalPrice * @TaxRate)) * @DiscountRate) 
        + @AdminFee;

    -- Monthly installment
    SET @MonthlyInstallment = dbo.fn_MonthlyInstallmentWithFees(
        @LocalPrice, @TaxRate, @DiscountRate, @AdminFee, @Tenor, @InterestRate
    );

    -- Insert into Credit
    INSERT INTO Credit (
        AgreementID, CreditAmount, Tenor, InterestRate, 
        MonthlyPaymentAmount, CreditStatus, PaidFully
    )
    VALUES (
        @AgreementID, @CreditAmount, @Tenor, @InterestRate, 
        @MonthlyInstallment, 'Pending', 0
    );
END;


-- 3. Mark delivery of a car
CREATE PROCEDURE DeliverCar
    @AgreementID INT,
    @DeliveryDate DATE
AS
BEGIN
    UPDATE Agreement
    SET DeliveryDate = @DeliveryDate
    WHERE ID = @AgreementID
END;
GO


-- ================================================
-- VIEWS
-- ================================================

-- 1. Sales Report View
CREATE VIEW vw_SalesReport AS
SELECT 
    A.ID AS AgreementID,
    C.Name AS CustomerName,
    SP.Name AS SalesPerson,
    D.Name AS Dealer,
    DC.LocalPrice,
    A.Date AS AgreementDate
FROM Agreement A
JOIN Customer C ON A.CustomerID = C.ID
JOIN SalesPerson SP ON A.SalesPersonID = SP.ID
JOIN DealerCar DC ON A.DealerCarID = DC.ID
JOIN Dealer D ON DC.DealerID = D.ID;
GO

-- 2. Credit Status View
CREATE VIEW vw_CreditStatus AS
SELECT 
    CR.ID AS CreditID,
    C.Name AS Customer,
    CR.CreditAmount,
    CR.Tenor,
    CR.MonthlyPaymentAmount,
    CR.CreditStatus,
    CR.PaidFully
FROM Credit CR
JOIN Agreement A ON CR.AgreementID = A.ID
JOIN Customer C ON A.CustomerID = C.ID;
GO

-- 3. Available Cars View
CREATE VIEW vw_AvailableCars AS
SELECT 
    DC.ID AS DealerCarID,
    D.Name AS Dealer,
    CA.Model,
    CA.Type,
    DC.LocalPrice,
    DC.TaxRate
FROM DealerCar DC
JOIN Dealer D ON DC.DealerID = D.ID
JOIN Car CA ON DC.CarID = CA.ID
WHERE DC.ID NOT IN (
    SELECT DealerCarID FROM Agreement
);
GO

--SELECT * FROM vw_SalesReport;
--SELECT * FROM vw_CreditStatus;
--SELECT * FROM vw_AvailableCars;

-- ================================================
-- TRIGGERS
-- ================================================

-- Add Stock column to DealerCar if not present

-- 1. Trigger to reduce stock when agreement is created
CREATE TRIGGER tr_UpdateStockOnTransaction
ON Agreement
AFTER INSERT
AS
BEGIN
    UPDATE DealerCar
    SET Stock = Stock - 1
    WHERE ID IN (SELECT DealerCarID FROM INSERTED)
END;
GO

-- 2. Prevent creating agreement if car is out of stock
CREATE TRIGGER tr_PreventZeroStock
ON Agreement
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED I
        JOIN DealerCar DC ON I.DealerCarID = DC.ID
        WHERE DC.Stock <= 0
    )
    BEGIN
        RAISERROR ('Car is out of stock!', 16, 1)
        ROLLBACK
    END
    ELSE
    BEGIN
        INSERT INTO Agreement (CustomerID, DealerCarID, SalesPersonID, LoiID, Date)
        SELECT CustomerID, DealerCarID, SalesPersonID, LoiID, Date
        FROM INSERTED
    END
END;
GO