-- Insert into Customer
INSERT INTO Customer (Name, CardID, Address, PhoneNumber, Email)
VALUES 
('Ali Rahman', 'ID123456', 'Jl. Merdeka No.10', '081234567890', 'ali@example.com'),
('Budi Santoso', 'ID234567', 'Jl. Sudirman No.20', '081345678901', 'budi@example.com'),
('Citra Dewi', 'ID345678', 'Jl. Gajah Mada No.30', '081456789012', 'citra@example.com'),
('Dewi Lestari', 'ID456789', 'Jl. Thamrin No.40', '081567890123', 'dewi@example.com'),
('Eko Prasetyo', 'ID567890', 'Jl. Kuningan No.50', '081678901234', 'eko@example.com');

-- Insert into Car
INSERT INTO Car (Model, Type, BasePrice, Color)
VALUES
('Zentra X1', 'SUV', 350000000, 'Midnight Blue'),
('Voltara S', 'Sedan', 280000000, 'Crimson Red'),
('Ravon Terra', 'Hatchback', 220000000, 'Matte Black'),
('Eldrix V9', 'SUV', 420000000, 'Silver Metallic'),
('Nuvix Aero', 'Coupe', 390000000, 'Pearl White'),
('Karnyx T5', 'Sedan', 265000000, 'Deep Green'),
('Zephra GT', 'Sport', 470000000, 'Glossy Orange'),
('Trivon Luma', 'Hatchback', 210000000, 'Sunset Yellow'),
('Lumina ZR', 'Electric', 520000000, 'Sky Blue'),
('Orion Pulse', 'SUV', 360000000, 'Charcoal Grey');

-- Insert into Dealer
INSERT INTO Dealer (Name, City, PhoneNumber)
VALUES 
('AutoDealer Jakarta', 'Jakarta', '0218887766'),
('AutoDealer Bandung', 'Bandung', '0225554433'),
('AutoDealer Surabaya', 'Surabaya', '0311234567'),
('AutoDealer Medan', 'Medan', '0617654321'),
('AutoDealer Bali', 'Bali', '0361765432');

-- Insert into DealerCar
INSERT INTO DealerCar (DealerID, CarID, LocalPrice, TaxRate)
VALUES 
(1, 1, 360000000, 0.1),
(1, 2, 295000000, 0.1),
(1, 3, 230000000, 0.1),
(2, 4, 440000000, 0.1),
(2, 5, 410000000, 0.1),
(3, 6, 275000000, 0.1),
(3, 7, 490000000, 0.1),
(4, 8, 225000000, 0.1),
(4, 9, 540000000, 0.1),
(5, 10, 375000000, 0.1);

-- Insert into SalesPerson
INSERT INTO SalesPerson (Name, PhoneNumber, Email)
VALUES
('Rina Wulandari', '081234567891', 'rina@dealer.com'),
('Andi Nugroho', '081345678902', 'andi@dealer.com'),
('Maya Sari', '081456789013', 'maya@dealer.com'),
('Fajar Hidayat', '081567890124', 'fajar@dealer.com'),
('Sinta Dewi', '081678901235', 'sinta@dealer.com');

-- Insert into ConsultHistory
INSERT INTO ConsultHistory (CustomerID, DealerID, SalesPersonID, CarID, Budget, Note)
VALUES
(1, 1, 1, 1, 360000000, 'Looking for family SUV'),
(2, 2, 2, 4, 400000000, 'Interested in luxury car'),
(3, 3, 3, 6, 300000000, 'Budget-focused inquiry'),
(4, 4, 4, 8, 220000000, 'Wants hatchback for city drive'),
(5, 5, 5, 10, 550000000, 'Electric vehicle interest');

-- Insert into TestDrive
INSERT INTO TestDrive (CustomerID, DealerID, SalesPersonID, CarID, Feedback)
VALUES
(1, 1, 1, 1, 'Smooth drive, liked the comfort'),
(2, 2, 2, 4, 'Very luxurious feel'),
(3, 3, 3, 6, 'Handled well on turns'),
(4, 4, 4, 8, 'Compact and efficient'),
(5, 5, 5, 10, 'Impressive acceleration');

-- Insert into LetterOfIntent
INSERT INTO LetterOfIntent (CustomerID, SalesPersonID, PaymentMethod, DateSigned)
VALUES
(1, 1, 'Credit', '2025-07-01'),
(2, 2, 'Cash', '2025-07-02'),
(3, 3, 'Transfer', '2025-07-03');

-- Insert into LOICar
INSERT INTO LOICar (LOIID, DealerCarID, ProposedPrice)
VALUES
(1, 1, 156000000),
(1, 2, 159000000),
(2, 3, 165000000),
(3, 4, 170000000);

-- Insert into Agreement
INSERT INTO Agreement (CustomerID, DealerCarID, SalesPersonID, LoiID, Date)
VALUES
(1, 1, 1, 1, '2025-07-05'),
(2, 3, 2, 2, '2025-07-06'),
(3, 4, 3, 3, '2025-07-07');

-- Insert into Credit
INSERT INTO Credit (AgreementID, CreditAmount, Tenor, InterestRate, MonthlyPaymentAmount, CreditStatus, PaidFully)
VALUES
(1, 100000000, 36, 5.5, 3020000, 'Smooth', 0),
(2, 120000000, 24, 6.0, 5300000, 'Late', 0),
(3, 130000000, 48, 7.0, 3100000, 'Smooth', 0);

-- Insert into PaymentHistory
INSERT INTO PaymentHistory (AgreementID, CreditID, Amount, PaymentNumber, Date)
VALUES
(1, 1, 3020000, 1, '2025-08-01'),
(1, 1, 3020000, 2, '2025-09-01'),
(2, 2, 5300000, 1, '2025-08-05'),
(3, 3, 3100000, 1, '2025-08-10');
