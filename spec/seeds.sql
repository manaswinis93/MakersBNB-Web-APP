-- users

DROP TABLE IF EXISTS public.users;

CREATE SEQUENCE IF NOT EXISTS users_id_seq;

CREATE TABLE public.users (
    "id" SERIAL,
    "email" text,
    "password" text,
    PRIMARY KEY ("id")
);

INSERT INTO public.users ("email", "password") VALUES
(
    'samm@makersacademy.com',
    '$2a$12$KOS94zwuzuH6qnOkj.cmzuooSE.dO7J.f8BIVwCiwqTsl6EwO/ECm'
),(
    'john@example.com',
    '$2a$12$KOS94zwuzuH6qnOkj.cmzuooSE.dO7J.f8BIVwCiwqTsl6EwO/ECm'
);

-- spaces

DROP TABLE IF EXISTS public.spaces;

CREATE SEQUENCE IF NOT EXISTS spaces_id_seq;

CREATE TABLE public.spaces (
    "id" SERIAL,
    "name" text,
    "description" text,
    "price" text,
    "user_id" int,
    PRIMARY KEY (id)
);

INSERT INTO public.spaces ("name", "description", "price", "user_id") VALUES
(
    'Space1',
    'The first space',
    '15',
    '1'
),(
    'Space2',
    'The second space',
    '15',
    '1'
);

-- bookings

DROP TABLE IF EXISTS public.bookings;

CREATE SEQUENCE IF NOT EXISTS bookings_id_seq;

CREATE TABLE public.bookings (
    "id" SERIAL,
    "space_id" int,
    "user_id" int,
    "date" text,
    "status" text,
    PRIMARY KEY (id)
);
