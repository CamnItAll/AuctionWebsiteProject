-- Sample database items

-- 1. Users
-- ----------------------------
INSERT INTO users (username, password, first_name, last_name, address_street, address_no, city, country, postal_code, created_at)
VALUES
  ('aliceWL','$2a$10$QJvOyEvcbH0s74cIGi3z9OBcVF..3N6w.ThVsUUbWLDx19XEdivtC', 
    'Alice', 'Anderson', 'Maple St', '12', 'Toronto', 'Canada', 'M1A 1A1', NOW()),
  ('bob1234','$2a$10$QJvOyEvcbH0s74cIGi3z9OBcVF..3N6w.ThVsUUbWLDx19XEdivtC', 
    'Bob',   'Brown',    'Oak Ave',  '55', 'Toronto', 'Canada', 'M2B 2B2', NOW()),
  ('charlie','$2a$10$QJvOyEvcbH0s74cIGi3z9OBcVF..3N6w.ThVsUUbWLDx19XEdivtC', 
    'Charlie','Clark',   'Pine Rd',  '78', 'Toronto', 'Canada', 'M3C 3C3', NOW());
-- Note: All passwords in this example are "1234567890"

-- 2. Items
-- ----------------------------
INSERT INTO items
(name, description, start_price, current_price, auction_status, start_date, end_date, auction_type, reserve_price,
 shipping_price, expedited_shipping_price, shipping_days, owner_id, highest_bidder_id)
VALUES
  -- Item 1: Forward auction, open, no highest bidder yet
  ('Vintage Camera',
   'A vintage 1960s film camera in working condition.',
   50.00, 50.00, 'OPEN',
   NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY),
   'FORWARD', 60.00,
   10.00, 20.00, 5,
   1, NULL),

  -- Item 2: Forward auction with active bidding
  ('Gaming Laptop',
   'High-end 15-inch gaming laptop with RTX graphics.',
   900.00, 1050.00, 'OPEN',
   NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY),
   'FORWARD', 1000.00,
   15.00, 30.00, 3,
   2, 3),

  -- Item 3: Dutch auction
  ('Smartphone',
   'Unlocked smartphone, lightly used.',
   500.00, 450.00, 'OPEN',
   NOW(), DATE_ADD(NOW(), INTERVAL 12 HOUR),
   'DUTCH', NULL,
   8.00, 16.00, 4,
   1, NULL),

  -- Item 4: Open auction, Alice owns it, Bob winning
  ('Electric Guitar',
   'Electric guitar in great condition with carrying case.',
   200.00, 260.00, 'OPEN',
   NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY),
   'FORWARD', 250.00,
   12.00, 25.00, 5,
   1, 2);
