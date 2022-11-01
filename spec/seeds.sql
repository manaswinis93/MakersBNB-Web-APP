-- users

DROP TABLE IF EXISTS public.users;

CREATE SEQUENCE IF NOT EXISTS users_id_seq;

CREATE TABLE public.users (
    "id" SERIAL,
    "email" text,
    "password" text,
    PRIMARY KEY ("id")
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
