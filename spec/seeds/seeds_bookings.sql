TRUNCATE TABLE bookings RESTART IDENTITY; 

INSERT INTO bookings (space_id, user_id, date, status) VALUES (
    '3',
    '1',
    '05/11/2022',
    'Approved'
);
INSERT INTO bookings (space_id, user_id, date, status) VALUES (
    '2',
    '1',
    '05/11/2022',
    'Approved'
);
INSERT INTO bookings (space_id, user_id, date, status) VALUES (
    '3',
    '1',
    '06/11/2022',
    'Approved'
);
INSERT INTO bookings (space_id, user_id, date, status) VALUES (
    '4',
    '1',
    '06/11/2022',
    'Approved'
);