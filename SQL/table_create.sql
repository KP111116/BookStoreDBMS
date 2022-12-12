DROP TABLE public.admin;

CREATE TABLE public.admin (
  admin_id       bigint                NOT NULL DEFAULT nextval('admin_admin_id_seq'::regclass),
  admin_name     character varying(20) NOT NULL,
  admin_password character varying(10) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.admin ADD
  CONSTRAINT "PK_admin" PRIMARY KEY ( admin_id );

DROP TABLE public.book;

CREATE TABLE public.book (
  isbn               character varying(13) NOT NULL,
  book_name          character varying(30) NOT NULL,
  price              numeric(2,4)          NOT NULL,
  quantity_inventory bigint                NOT NULL,
  no_of_pages        bigint                NOT NULL,
  genre              character varying(20) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.book ADD
  CONSTRAINT "PK_book" PRIMARY KEY ( isbn );

DROP TABLE public.wrote;

CREATE TABLE public.wrote (
  author_id bigint                NOT NULL,
  isbn      character varying(13) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.wrote ADD
  CONSTRAINT "PK_wrote" PRIMARY KEY ( author_id, isbn );

ALTER TABLE public.wrote ADD
  CONSTRAINT author_id FOREIGN KEY ( author_id )
    REFERENCES public.author ( author_id );

ALTER TABLE public.wrote ADD
  CONSTRAINT isbn FOREIGN KEY ( isbn )
    REFERENCES public.book ( isbn );

DROP TABLE public.author;

CREATE TABLE public.author (
  author_id   bigint                NOT NULL DEFAULT nextval('author_author_id_seq'::regclass),
  author_name character varying(20) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.author ADD
  CONSTRAINT "PK_author" PRIMARY KEY ( author_id );

DROP TABLE public.publisher;

CREATE TABLE public.publisher (
  publisher_id   bigint                NOT NULL DEFAULT nextval('publisher_publisher_id_seq'::regclass),
  publisher_name character varying(20) NOT NULL,
  bank_info      character varying(9)  NOT NULL
)
TABLESPACE pg_default;

COMMENT ON COLUMN public.publisher.bank_info IS 'bank account number';

ALTER TABLE public.publisher ADD
  CONSTRAINT "PK_publisher" PRIMARY KEY ( publisher_id );

DROP TABLE public.published;

CREATE TABLE public.published (
  publisher_id bigint                NOT NULL,
  isbn         character varying(13) NOT NULL,
  year         character varying(4)      NULL
)
TABLESPACE pg_default;

ALTER TABLE public.published ADD
  CONSTRAINT "PK_published" PRIMARY KEY ( publisher_id, isbn );

ALTER TABLE public.published ADD
  CONSTRAINT isbn FOREIGN KEY ( isbn )
    REFERENCES public.book ( isbn );

ALTER TABLE public.published ADD
  CONSTRAINT publisher_id FOREIGN KEY ( publisher_id )
    REFERENCES public.publisher ( publisher_id );

DROP TABLE public.user;

CREATE TABLE public.user (
  user_id       bigint                NOT NULL DEFAULT nextval('user_user_id_seq'::regclass),
  user_name     character varying(20) NOT NULL,
  address_id    bigint                    NULL,
  phone_number  character varying(10) NOT NULL,
  user_password character varying(10) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.user ADD
  CONSTRAINT "PK_user" PRIMARY KEY ( user_id );

ALTER TABLE public.user ADD
(
  CONSTRAINT address_id UNIQUE ( address_id )
);

DROP TABLE public.basket;

CREATE TABLE public.basket (
  basket_id       bigint                NOT NULL,
  user_id         bigint                NOT NULL,
  isbn            character varying(13) NOT NULL,
  quantity_basket bigint                NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.basket ADD
  CONSTRAINT "PK_basket" PRIMARY KEY ( basket_id, user_id );

ALTER TABLE public.basket ADD
  CONSTRAINT basket_id FOREIGN KEY ( basket_id )
    REFERENCES public.order ( basket_id );

ALTER TABLE public.basket ADD
  CONSTRAINT isbn FOREIGN KEY ( isbn )
    REFERENCES public.book ( isbn );

ALTER TABLE public.basket ADD
  CONSTRAINT user_id FOREIGN KEY ( user_id )
    REFERENCES public.user ( user_id );

DROP TABLE public.address;

CREATE TABLE public.address (
  address_id   bigint                NOT NULL,
  user_id      bigint                NOT NULL,
  address_line character varying(50) NOT NULL,
  postal_code  character varying(6)  NOT NULL,
  province     character varying(2)  NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.address ADD
  CONSTRAINT user_address PRIMARY KEY ( user_id );

ALTER TABLE public.address ADD
(
  CONSTRAINT address_user UNIQUE ( address_id )
);

ALTER TABLE public.address ADD
  CONSTRAINT address_of_user FOREIGN KEY ( address_id )
    REFERENCES public.user ( address_id );

ALTER TABLE public.address ADD
  CONSTRAINT user_id FOREIGN KEY ( user_id )
    REFERENCES public.user ( user_id );

DROP TABLE public.commission;

CREATE TABLE public.commission (
  order_id     bigint       NOT NULL,
  publisher_id bigint       NOT NULL,
  commission   numeric(2,5) NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.commission ADD
  CONSTRAINT "PK_commission" PRIMARY KEY ( order_id, publisher_id );

ALTER TABLE public.commission ADD
  CONSTRAINT order_id FOREIGN KEY ( order_id )
    REFERENCES public.order ( order_id );

ALTER TABLE public.commission ADD
  CONSTRAINT publisher_id FOREIGN KEY ( publisher_id )
    REFERENCES public.publisher ( publisher_id );

DROP TABLE public.order;

CREATE TABLE public.order (
  order_id     bigint                NOT NULL DEFAULT nextval('order_order_id_seq'::regclass),
  date         date                  NOT NULL,
  total_amount numeric(2,4)          NOT NULL,
  status       character varying(10) NOT NULL,
  basket_id    bigint                NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE public.order ADD
  CONSTRAINT "PK_order" PRIMARY KEY ( order_id );

ALTER TABLE public.order ADD
(
  CONSTRAINT id_basket UNIQUE ( basket_id )
);
