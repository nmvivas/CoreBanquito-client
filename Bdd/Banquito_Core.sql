PGDMP  &                    |            Banquito_Core    16.3 (Debian 16.3-1.pgdg120+1)    16.3 q    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16628    Banquito_Core    DATABASE     z   CREATE DATABASE "Banquito_Core" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE "Banquito_Core";
                postgres    false            `           1247    16630    client_type    DOMAIN     :   CREATE DOMAIN public.client_type AS character varying(3);
     DROP DOMAIN public.client_type;
       public          postgres    false            c           1247    16632    confirmation    DOMAIN     ;   CREATE DOMAIN public.confirmation AS character varying(1);
 !   DROP DOMAIN public.confirmation;
       public          postgres    false            f           1247    16634    gender    DOMAIN     5   CREATE DOMAIN public.gender AS character varying(1);
    DROP DOMAIN public.gender;
       public          postgres    false            i           1247    16636    passive_active    DOMAIN     =   CREATE DOMAIN public.passive_active AS character varying(3);
 #   DROP DOMAIN public.passive_active;
       public          postgres    false            l           1247    16638    state    DOMAIN     4   CREATE DOMAIN public.state AS character varying(3);
    DROP DOMAIN public.state;
       public          postgres    false            o           1247    16640    temporality    DOMAIN     :   CREATE DOMAIN public.temporality AS character varying(3);
     DROP DOMAIN public.temporality;
       public          postgres    false            �            1259    16641    account    TABLE     3  CREATE TABLE public.account (
    account_id integer NOT NULL,
    code_product_type character varying(20) NOT NULL,
    code_product character varying(30) NOT NULL,
    client_id integer NOT NULL,
    code_unique_account character varying(32) NOT NULL,
    code_internal_account character varying(10) NOT NULL,
    code_international_account character varying(16) NOT NULL,
    number character varying(13),
    state public.state NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    activation_date timestamp without time zone,
    last_modified_date timestamp without time zone NOT NULL,
    current_balance numeric(17,2) DEFAULT 0 NOT NULL,
    available_balance numeric(17,2) DEFAULT 0 NOT NULL,
    blocked_balance numeric(17,2) DEFAULT 0 NOT NULL,
    closed_date timestamp without time zone
);
    DROP TABLE public.account;
       public         heap    postgres    false    876            �            1259    16649    account_account_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.account_account_id_seq;
       public          postgres    false    215            �           0    0    account_account_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.account_account_id_seq OWNED BY public.account.account_id;
          public          postgres    false    216            �            1259    16650    account_interest_accrued    TABLE       CREATE TABLE public.account_interest_accrued (
    account_interest_accrued_id integer NOT NULL,
    account_id integer NOT NULL,
    unique_key character varying(32) NOT NULL,
    execution_date timestamp without time zone NOT NULL,
    ammount numeric(17,2) NOT NULL,
    interest_rate numeric(5,2) NOT NULL,
    state character varying(3) DEFAULT 'PEN'::character varying NOT NULL,
    CONSTRAINT ckc_state_account_ CHECK (((state)::text = ANY (ARRAY[('PAI'::character varying)::text, ('PEN'::character varying)::text])))
);
 ,   DROP TABLE public.account_interest_accrued;
       public         heap    postgres    false            �            1259    16655 8   account_interest_accrued_account_interest_accrued_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_interest_accrued_account_interest_accrued_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 O   DROP SEQUENCE public.account_interest_accrued_account_interest_accrued_id_seq;
       public          postgres    false    217            �           0    0 8   account_interest_accrued_account_interest_accrued_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.account_interest_accrued_account_interest_accrued_id_seq OWNED BY public.account_interest_accrued.account_interest_accrued_id;
          public          postgres    false    218            �            1259    16656    account_transaction    TABLE     �  CREATE TABLE public.account_transaction (
    account_transaction_id integer NOT NULL,
    account_id integer NOT NULL,
    code_channel character varying(10) NOT NULL,
    unique_key character varying(32) NOT NULL,
    transaction_type character varying(3) NOT NULL,
    transaction_subtype character varying(12) NOT NULL,
    reference character varying(50) NOT NULL,
    ammount numeric(17,2) NOT NULL,
    creditor_bank_code character varying(20),
    creditor_account character varying(16),
    debtor_bank_code character varying(20),
    debtor_account character varying(16),
    creation_date timestamp without time zone NOT NULL,
    booking_date timestamp without time zone NOT NULL,
    value_date timestamp without time zone NOT NULL,
    apply_tax boolean NOT NULL,
    parent_transaction_key character varying(32),
    state character varying(3) NOT NULL,
    notes character varying(200),
    CONSTRAINT ckc_state_account_ CHECK (((state)::text = ANY (ARRAY[('POS'::character varying)::text, ('EXE'::character varying)::text, ('REV'::character varying)::text]))),
    CONSTRAINT ckc_transaction_subty_account_ CHECK (((transaction_subtype)::text = ANY (ARRAY[('ADJUSTMENT'::character varying)::text, ('DEPOSIT'::character varying)::text, ('WITHDRAWAL'::character varying)::text, ('TRANSFER'::character varying)::text, ('PAYMENT'::character varying)::text, ('FEE_APPLIED'::character varying)::text, ('INTEREST_AP'::character varying)::text, ('WITHHOLD_TA'::character varying)::text]))),
    CONSTRAINT ckc_transaction_type_account_ CHECK (((transaction_type)::text = ANY (ARRAY[('DEB'::character varying)::text, ('CRE'::character varying)::text])))
);
 '   DROP TABLE public.account_transaction;
       public         heap    postgres    false            �            1259    16662 .   account_transaction_account_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_transaction_account_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.account_transaction_account_transaction_id_seq;
       public          postgres    false    219            �           0    0 .   account_transaction_account_transaction_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.account_transaction_account_transaction_id_seq OWNED BY public.account_transaction.account_transaction_id;
          public          postgres    false    220            �            1259    16663    bank    TABLE     �   CREATE TABLE public.bank (
    code_bank character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    start_date date NOT NULL
);
    DROP TABLE public.bank;
       public         heap    postgres    false            �            1259    16666 	   bank_user    TABLE     =  CREATE TABLE public.bank_user (
    bank_user_id integer NOT NULL,
    code_bank character varying(20),
    code_role character varying(10),
    user_name character varying(20) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    full_name character varying(100) NOT NULL,
    type_user character varying(3) NOT NULL,
    password character varying(64) NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    state character varying(3) NOT NULL,
    last_login timestamp without time zone NOT NULL,
    email character varying(100) NOT NULL,
    CONSTRAINT ckc_type_user_bank_use CHECK (((type_user)::text = ANY (ARRAY[('TEL'::character varying)::text, ('BAC'::character varying)::text, ('SAL'::character varying)::text, ('CSU'::character varying)::text])))
);
    DROP TABLE public.bank_user;
       public         heap    postgres    false            �            1259    16670    bank_user_bank_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bank_user_bank_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.bank_user_bank_user_id_seq;
       public          postgres    false    222            �           0    0    bank_user_bank_user_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.bank_user_bank_user_id_seq OWNED BY public.bank_user.bank_user_id;
          public          postgres    false    223            �            1259    16671    channel    TABLE     �   CREATE TABLE public.channel (
    code_channel character varying(10) NOT NULL,
    code_bank character varying(20),
    name character varying(20) NOT NULL
);
    DROP TABLE public.channel;
       public         heap    postgres    false            �            1259    16674    client    TABLE     H  CREATE TABLE public.client (
    client_id bigint NOT NULL,
    code_segment character varying(10) NOT NULL,
    client_type character varying(3) NOT NULL,
    identification_type character varying(3) NOT NULL,
    identification character varying(20) NOT NULL,
    last_name character varying(50),
    first_name character varying(50),
    full_name character varying(100),
    email character varying(100) NOT NULL,
    birth_date date,
    company_name character varying(100),
    tradename character varying(100),
    company_type character varying(16),
    state character varying(3) NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    last_status_date timestamp without time zone NOT NULL,
    nationality character varying(50),
    marital_status character varying(3),
    monthly_avg_income numeric(17,2),
    notes character varying(1000),
    CONSTRAINT ckc_client_type_client CHECK (((client_type)::text = ANY (ARRAY[('PER'::character varying)::text, ('BUS'::character varying)::text]))),
    CONSTRAINT ckc_identification_ty_client CHECK (((identification_type)::text = ANY (ARRAY[('CED'::character varying)::text, ('RUC'::character varying)::text, ('PAS'::character varying)::text]))),
    CONSTRAINT ckc_marital_status_client CHECK (((marital_status IS NULL) OR ((marital_status)::text = ANY (ARRAY[('MAR'::character varying)::text, ('DIV'::character varying)::text, ('SIN'::character varying)::text, ('CUN'::character varying)::text, ('WID'::character varying)::text])))),
    CONSTRAINT ckc_monthly_avg_incom_client CHECK ((((monthly_avg_income >= (0)::numeric) AND (monthly_avg_income <= (399)::numeric)) OR ((monthly_avg_income >= (400)::numeric) AND (monthly_avg_income <= (999)::numeric)) OR ((monthly_avg_income >= (1000)::numeric) AND (monthly_avg_income <= (2999)::numeric)) OR (monthly_avg_income >= (3000)::numeric)))
);
    DROP TABLE public.client;
       public         heap    postgres    false            �            1259    16683    client_address    TABLE       CREATE TABLE public.client_address (
    client_address_id bigint NOT NULL,
    client_id bigint,
    type_address character varying(3) NOT NULL,
    line1 character varying(100) NOT NULL,
    line2 character varying(100),
    latitude real,
    longitude real,
    zip_code character varying(10),
    is_default boolean NOT NULL,
    state character varying(3) NOT NULL,
    CONSTRAINT ckc_is_default_client_a CHECK ((is_default = ANY (ARRAY[true, false]))),
    CONSTRAINT ckc_state_client_a CHECK (((state)::text = ANY (ARRAY[('ACT'::character varying)::text, ('INA'::character varying)::text]))),
    CONSTRAINT ckc_type_address_client_a CHECK (((type_address)::text = ANY (ARRAY[('HOM'::character varying)::text, ('OFF'::character varying)::text, ('OTH'::character varying)::text])))
);
 "   DROP TABLE public.client_address;
       public         heap    postgres    false            �            1259    16689 $   client_address_client_address_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_address_client_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.client_address_client_address_id_seq;
       public          postgres    false    226            �           0    0 $   client_address_client_address_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.client_address_client_address_id_seq OWNED BY public.client_address.client_address_id;
          public          postgres    false    227            �            1259    16690    client_client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.client_client_id_seq;
       public          postgres    false    225            �           0    0    client_client_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;
          public          postgres    false    228            �            1259    16691    client_phone    TABLE     �  CREATE TABLE public.client_phone (
    client_phone_id bigint NOT NULL,
    client_id bigint,
    phone_type character varying(3) NOT NULL,
    phone_number character varying(20) NOT NULL,
    is_default boolean NOT NULL,
    state character varying(3) NOT NULL,
    CONSTRAINT ckc_is_default_client_p CHECK ((is_default = ANY (ARRAY[true, false]))),
    CONSTRAINT ckc_phone_type_client_p CHECK (((phone_type)::text = ANY (ARRAY[('HOM'::character varying)::text, ('MOB'::character varying)::text, ('OFF'::character varying)::text, ('OTH'::character varying)::text]))),
    CONSTRAINT ckc_state_client_p CHECK (((state)::text = ANY (ARRAY[('ACT'::character varying)::text, ('INA'::character varying)::text])))
);
     DROP TABLE public.client_phone;
       public         heap    postgres    false            �            1259    16697     client_phone_client_phone_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_phone_client_phone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.client_phone_client_phone_id_seq;
       public          postgres    false    229            �           0    0     client_phone_client_phone_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.client_phone_client_phone_id_seq OWNED BY public.client_phone.client_phone_id;
          public          postgres    false    230            �            1259    16698 
   debit_card    TABLE     �  CREATE TABLE public.debit_card (
    debit_card_id integer NOT NULL,
    client_id integer NOT NULL,
    account_id integer NOT NULL,
    card_number character varying(20) NOT NULL,
    ccv character varying(3) NOT NULL,
    expiration_date date NOT NULL,
    cardholder_name character varying(50) NOT NULL,
    card_unique_key character varying(32) NOT NULL,
    pin character varying(64) NOT NULL
);
    DROP TABLE public.debit_card;
       public         heap    postgres    false            �            1259    16701    debit_card_debit_card_id_seq    SEQUENCE     �   CREATE SEQUENCE public.debit_card_debit_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.debit_card_debit_card_id_seq;
       public          postgres    false    231            �           0    0    debit_card_debit_card_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.debit_card_debit_card_id_seq OWNED BY public.debit_card.debit_card_id;
          public          postgres    false    232            �            1259    16702    interest_rate    TABLE     �   CREATE TABLE public.interest_rate (
    code_interest_rate character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    days_in_month numeric(2,0) NOT NULL,
    days_in_year numeric(3,0) NOT NULL
);
 !   DROP TABLE public.interest_rate;
       public         heap    postgres    false            �            1259    16705    interest_rate_log    TABLE     �   CREATE TABLE public.interest_rate_log (
    interest_log_id integer NOT NULL,
    code_interest_rate character varying(8) NOT NULL,
    value numeric(5,2) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    state public.state NOT NULL
);
 %   DROP TABLE public.interest_rate_log;
       public         heap    postgres    false    876            �            1259    16710 %   interest_rate_log_interest_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.interest_rate_log_interest_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.interest_rate_log_interest_log_id_seq;
       public          postgres    false    234            �           0    0 %   interest_rate_log_interest_log_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.interest_rate_log_interest_log_id_seq OWNED BY public.interest_rate_log.interest_log_id;
          public          postgres    false    235            �            1259    16711    product    TABLE     �  CREATE TABLE public.product (
    code_product_type character varying(20) NOT NULL,
    code_product character varying(30) NOT NULL,
    code_interest_rate character varying(10) NOT NULL,
    code_segment character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    state public.state DEFAULT 'DRA'::character varying NOT NULL,
    start_date date NOT NULL,
    end_date date,
    allow_debit_card boolean,
    allow_transferences boolean,
    min_opening_balance numeric(17,2) DEFAULT 0 NOT NULL,
    CONSTRAINT ckc_allow_debit_card_product CHECK (((allow_debit_card IS NULL) OR (allow_debit_card = ANY (ARRAY[true, false])))),
    CONSTRAINT ckc_allow_transferenc_product CHECK (((allow_transferences IS NULL) OR (allow_transferences = ANY (ARRAY[true, false])))),
    CONSTRAINT ckc_state_product CHECK (((state)::text = ANY (ARRAY[('INA'::character varying)::text, ('ACT'::character varying)::text, ('DRA'::character varying)::text])))
);
    DROP TABLE public.product;
       public         heap    postgres    false    876    876            �            1259    16721    product_type    TABLE     �  CREATE TABLE public.product_type (
    code_product_type character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    account_type character varying(3) NOT NULL,
    allow_earn_interest boolean NOT NULL,
    temporality_interest public.temporality,
    CONSTRAINT ckc_account_type_product_ CHECK (((account_type)::text = ANY (ARRAY[('AHO'::character varying)::text, ('COR'::character varying)::text]))),
    CONSTRAINT ckc_allow_earn_intere_product_ CHECK ((allow_earn_interest = ANY (ARRAY[true, false]))),
    CONSTRAINT ckc_temporality_inter_product_ CHECK (((temporality_interest IS NULL) OR ((temporality_interest)::text = ANY (ARRAY[('DLY'::character varying)::text, ('MON'::character varying)::text]))))
);
     DROP TABLE public.product_type;
       public         heap    postgres    false    879            �            1259    16729    role    TABLE     t   CREATE TABLE public.role (
    code_role character varying(10) NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    16732    segment    TABLE     i  CREATE TABLE public.segment (
    code_segment character varying(10) NOT NULL,
    name character varying(50) NOT NULL,
    client_type character varying(3) NOT NULL,
    description character varying(500),
    CONSTRAINT ckc_client_type_segment CHECK (((client_type)::text = ANY (ARRAY[('PER'::character varying)::text, ('BUS'::character varying)::text])))
);
    DROP TABLE public.segment;
       public         heap    postgres    false            �           2604    16738    account account_id    DEFAULT     x   ALTER TABLE ONLY public.account ALTER COLUMN account_id SET DEFAULT nextval('public.account_account_id_seq'::regclass);
 A   ALTER TABLE public.account ALTER COLUMN account_id DROP DEFAULT;
       public          postgres    false    216    215            �           2604    16739 4   account_interest_accrued account_interest_accrued_id    DEFAULT     �   ALTER TABLE ONLY public.account_interest_accrued ALTER COLUMN account_interest_accrued_id SET DEFAULT nextval('public.account_interest_accrued_account_interest_accrued_id_seq'::regclass);
 c   ALTER TABLE public.account_interest_accrued ALTER COLUMN account_interest_accrued_id DROP DEFAULT;
       public          postgres    false    218    217            �           2604    16740 *   account_transaction account_transaction_id    DEFAULT     �   ALTER TABLE ONLY public.account_transaction ALTER COLUMN account_transaction_id SET DEFAULT nextval('public.account_transaction_account_transaction_id_seq'::regclass);
 Y   ALTER TABLE public.account_transaction ALTER COLUMN account_transaction_id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    16741    bank_user bank_user_id    DEFAULT     �   ALTER TABLE ONLY public.bank_user ALTER COLUMN bank_user_id SET DEFAULT nextval('public.bank_user_bank_user_id_seq'::regclass);
 E   ALTER TABLE public.bank_user ALTER COLUMN bank_user_id DROP DEFAULT;
       public          postgres    false    223    222            �           2604    16742    client client_id    DEFAULT     t   ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);
 ?   ALTER TABLE public.client ALTER COLUMN client_id DROP DEFAULT;
       public          postgres    false    228    225            �           2604    16743     client_address client_address_id    DEFAULT     �   ALTER TABLE ONLY public.client_address ALTER COLUMN client_address_id SET DEFAULT nextval('public.client_address_client_address_id_seq'::regclass);
 O   ALTER TABLE public.client_address ALTER COLUMN client_address_id DROP DEFAULT;
       public          postgres    false    227    226            �           2604    16744    client_phone client_phone_id    DEFAULT     �   ALTER TABLE ONLY public.client_phone ALTER COLUMN client_phone_id SET DEFAULT nextval('public.client_phone_client_phone_id_seq'::regclass);
 K   ALTER TABLE public.client_phone ALTER COLUMN client_phone_id DROP DEFAULT;
       public          postgres    false    230    229            �           2604    16745    debit_card debit_card_id    DEFAULT     �   ALTER TABLE ONLY public.debit_card ALTER COLUMN debit_card_id SET DEFAULT nextval('public.debit_card_debit_card_id_seq'::regclass);
 G   ALTER TABLE public.debit_card ALTER COLUMN debit_card_id DROP DEFAULT;
       public          postgres    false    232    231            �           2604    16746 !   interest_rate_log interest_log_id    DEFAULT     �   ALTER TABLE ONLY public.interest_rate_log ALTER COLUMN interest_log_id SET DEFAULT nextval('public.interest_rate_log_interest_log_id_seq'::regclass);
 P   ALTER TABLE public.interest_rate_log ALTER COLUMN interest_log_id DROP DEFAULT;
       public          postgres    false    235    234            �          0    16641    account 
   TABLE DATA           &  COPY public.account (account_id, code_product_type, code_product, client_id, code_unique_account, code_internal_account, code_international_account, number, state, creation_date, activation_date, last_modified_date, current_balance, available_balance, blocked_balance, closed_date) FROM stdin;
    public          postgres    false    215   c�       �          0    16650    account_interest_accrued 
   TABLE DATA           �   COPY public.account_interest_accrued (account_interest_accrued_id, account_id, unique_key, execution_date, ammount, interest_rate, state) FROM stdin;
    public          postgres    false    217   �       �          0    16656    account_transaction 
   TABLE DATA           H  COPY public.account_transaction (account_transaction_id, account_id, code_channel, unique_key, transaction_type, transaction_subtype, reference, ammount, creditor_bank_code, creditor_account, debtor_bank_code, debtor_account, creation_date, booking_date, value_date, apply_tax, parent_transaction_key, state, notes) FROM stdin;
    public          postgres    false    219   >�       �          0    16663    bank 
   TABLE DATA           ;   COPY public.bank (code_bank, name, start_date) FROM stdin;
    public          postgres    false    221   �       �          0    16666 	   bank_user 
   TABLE DATA           �   COPY public.bank_user (bank_user_id, code_bank, code_role, user_name, first_name, last_name, full_name, type_user, password, creation_date, state, last_login, email) FROM stdin;
    public          postgres    false    222   �       �          0    16671    channel 
   TABLE DATA           @   COPY public.channel (code_channel, code_bank, name) FROM stdin;
    public          postgres    false    224   ��       �          0    16674    client 
   TABLE DATA           '  COPY public.client (client_id, code_segment, client_type, identification_type, identification, last_name, first_name, full_name, email, birth_date, company_name, tradename, company_type, state, creation_date, last_status_date, nationality, marital_status, monthly_avg_income, notes) FROM stdin;
    public          postgres    false    225   ݳ       �          0    16683    client_address 
   TABLE DATA           �   COPY public.client_address (client_address_id, client_id, type_address, line1, line2, latitude, longitude, zip_code, is_default, state) FROM stdin;
    public          postgres    false    226   ��       �          0    16691    client_phone 
   TABLE DATA           o   COPY public.client_phone (client_phone_id, client_id, phone_type, phone_number, is_default, state) FROM stdin;
    public          postgres    false    229   �       �          0    16698 
   debit_card 
   TABLE DATA           �   COPY public.debit_card (debit_card_id, client_id, account_id, card_number, ccv, expiration_date, cardholder_name, card_unique_key, pin) FROM stdin;
    public          postgres    false    231   D�       �          0    16702    interest_rate 
   TABLE DATA           ^   COPY public.interest_rate (code_interest_rate, name, days_in_month, days_in_year) FROM stdin;
    public          postgres    false    233   Ƶ       �          0    16705    interest_rate_log 
   TABLE DATA           t   COPY public.interest_rate_log (interest_log_id, code_interest_rate, value, start_date, end_date, state) FROM stdin;
    public          postgres    false    234   �       �          0    16711    product 
   TABLE DATA           �   COPY public.product (code_product_type, code_product, code_interest_rate, code_segment, name, state, start_date, end_date, allow_debit_card, allow_transferences, min_opening_balance) FROM stdin;
    public          postgres    false    236   @�       �          0    16721    product_type 
   TABLE DATA           x   COPY public.product_type (code_product_type, name, account_type, allow_earn_interest, temporality_interest) FROM stdin;
    public          postgres    false    237   ��       �          0    16729    role 
   TABLE DATA           /   COPY public.role (code_role, name) FROM stdin;
    public          postgres    false    238   ض       �          0    16732    segment 
   TABLE DATA           O   COPY public.segment (code_segment, name, client_type, description) FROM stdin;
    public          postgres    false    239   �       �           0    0    account_account_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.account_account_id_seq', 1, false);
          public          postgres    false    216            �           0    0 8   account_interest_accrued_account_interest_accrued_id_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('public.account_interest_accrued_account_interest_accrued_id_seq', 1, false);
          public          postgres    false    218            �           0    0 .   account_transaction_account_transaction_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.account_transaction_account_transaction_id_seq', 1, false);
          public          postgres    false    220            �           0    0    bank_user_bank_user_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.bank_user_bank_user_id_seq', 3, true);
          public          postgres    false    223            �           0    0 $   client_address_client_address_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.client_address_client_address_id_seq', 6, true);
          public          postgres    false    227            �           0    0    client_client_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.client_client_id_seq', 21, true);
          public          postgres    false    228            �           0    0     client_phone_client_phone_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.client_phone_client_phone_id_seq', 7, true);
          public          postgres    false    230            �           0    0    debit_card_debit_card_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.debit_card_debit_card_id_seq', 1, false);
          public          postgres    false    232            �           0    0 %   interest_rate_log_interest_log_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.interest_rate_log_interest_log_id_seq', 1, false);
          public          postgres    false    235            �           2606    16748    account pk_account 
   CONSTRAINT     X   ALTER TABLE ONLY public.account
    ADD CONSTRAINT pk_account PRIMARY KEY (account_id);
 <   ALTER TABLE ONLY public.account DROP CONSTRAINT pk_account;
       public            postgres    false    215                       2606    16750 4   account_interest_accrued pk_account_interest_accrued 
   CONSTRAINT     �   ALTER TABLE ONLY public.account_interest_accrued
    ADD CONSTRAINT pk_account_interest_accrued PRIMARY KEY (account_interest_accrued_id);
 ^   ALTER TABLE ONLY public.account_interest_accrued DROP CONSTRAINT pk_account_interest_accrued;
       public            postgres    false    217                       2606    16752 *   account_transaction pk_account_transaction 
   CONSTRAINT     |   ALTER TABLE ONLY public.account_transaction
    ADD CONSTRAINT pk_account_transaction PRIMARY KEY (account_transaction_id);
 T   ALTER TABLE ONLY public.account_transaction DROP CONSTRAINT pk_account_transaction;
       public            postgres    false    219                       2606    16754    bank pk_bank 
   CONSTRAINT     Q   ALTER TABLE ONLY public.bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (code_bank);
 6   ALTER TABLE ONLY public.bank DROP CONSTRAINT pk_bank;
       public            postgres    false    221            	           2606    16756    bank_user pk_bank_user 
   CONSTRAINT     ^   ALTER TABLE ONLY public.bank_user
    ADD CONSTRAINT pk_bank_user PRIMARY KEY (bank_user_id);
 @   ALTER TABLE ONLY public.bank_user DROP CONSTRAINT pk_bank_user;
       public            postgres    false    222                       2606    16758    channel pk_channel 
   CONSTRAINT     Z   ALTER TABLE ONLY public.channel
    ADD CONSTRAINT pk_channel PRIMARY KEY (code_channel);
 <   ALTER TABLE ONLY public.channel DROP CONSTRAINT pk_channel;
       public            postgres    false    224                       2606    16760    client pk_client 
   CONSTRAINT     U   ALTER TABLE ONLY public.client
    ADD CONSTRAINT pk_client PRIMARY KEY (client_id);
 :   ALTER TABLE ONLY public.client DROP CONSTRAINT pk_client;
       public            postgres    false    225                       2606    16762     client_address pk_client_address 
   CONSTRAINT     m   ALTER TABLE ONLY public.client_address
    ADD CONSTRAINT pk_client_address PRIMARY KEY (client_address_id);
 J   ALTER TABLE ONLY public.client_address DROP CONSTRAINT pk_client_address;
       public            postgres    false    226                       2606    16764    client_phone pk_client_phone 
   CONSTRAINT     g   ALTER TABLE ONLY public.client_phone
    ADD CONSTRAINT pk_client_phone PRIMARY KEY (client_phone_id);
 F   ALTER TABLE ONLY public.client_phone DROP CONSTRAINT pk_client_phone;
       public            postgres    false    229                       2606    16766    debit_card pk_debit_card 
   CONSTRAINT     a   ALTER TABLE ONLY public.debit_card
    ADD CONSTRAINT pk_debit_card PRIMARY KEY (debit_card_id);
 B   ALTER TABLE ONLY public.debit_card DROP CONSTRAINT pk_debit_card;
       public            postgres    false    231                       2606    16768    interest_rate pk_interest_rate 
   CONSTRAINT     l   ALTER TABLE ONLY public.interest_rate
    ADD CONSTRAINT pk_interest_rate PRIMARY KEY (code_interest_rate);
 H   ALTER TABLE ONLY public.interest_rate DROP CONSTRAINT pk_interest_rate;
       public            postgres    false    233                       2606    16770 &   interest_rate_log pk_interest_rate_log 
   CONSTRAINT     q   ALTER TABLE ONLY public.interest_rate_log
    ADD CONSTRAINT pk_interest_rate_log PRIMARY KEY (interest_log_id);
 P   ALTER TABLE ONLY public.interest_rate_log DROP CONSTRAINT pk_interest_rate_log;
       public            postgres    false    234                       2606    16772    product pk_product 
   CONSTRAINT     m   ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product PRIMARY KEY (code_product, code_product_type);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT pk_product;
       public            postgres    false    236    236                       2606    16774    product_type pk_product_type 
   CONSTRAINT     i   ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT pk_product_type PRIMARY KEY (code_product_type);
 F   ALTER TABLE ONLY public.product_type DROP CONSTRAINT pk_product_type;
       public            postgres    false    237                       2606    16776    role pk_role 
   CONSTRAINT     Q   ALTER TABLE ONLY public.role
    ADD CONSTRAINT pk_role PRIMARY KEY (code_role);
 6   ALTER TABLE ONLY public.role DROP CONSTRAINT pk_role;
       public            postgres    false    238                       2606    16778    segment pk_segment 
   CONSTRAINT     Z   ALTER TABLE ONLY public.segment
    ADD CONSTRAINT pk_segment PRIMARY KEY (code_segment);
 <   ALTER TABLE ONLY public.segment DROP CONSTRAINT pk_segment;
       public            postgres    false    239                       1259    16779    idxu_us_email    INDEX     K   CREATE UNIQUE INDEX idxu_us_email ON public.bank_user USING btree (email);
 !   DROP INDEX public.idxu_us_email;
       public            postgres    false    222                       1259    16780    idxu_us_usrname    INDEX     Q   CREATE UNIQUE INDEX idxu_us_usrname ON public.bank_user USING btree (user_name);
 #   DROP INDEX public.idxu_us_usrname;
       public            postgres    false    222            "           2606    16781 6   account_interest_accrued fk_account__reference_account    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_interest_accrued
    ADD CONSTRAINT fk_account__reference_account FOREIGN KEY (account_id) REFERENCES public.account(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 `   ALTER TABLE ONLY public.account_interest_accrued DROP CONSTRAINT fk_account__reference_account;
       public          postgres    false    217    3327    215            #           2606    16786 1   account_transaction fk_account__reference_account    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_transaction
    ADD CONSTRAINT fk_account__reference_account FOREIGN KEY (account_id) REFERENCES public.account(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.account_transaction DROP CONSTRAINT fk_account__reference_account;
       public          postgres    false    215    219    3327            $           2606    16791 1   account_transaction fk_account__reference_channel    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_transaction
    ADD CONSTRAINT fk_account__reference_channel FOREIGN KEY (code_channel) REFERENCES public.channel(code_channel) ON UPDATE RESTRICT ON DELETE RESTRICT;
 [   ALTER TABLE ONLY public.account_transaction DROP CONSTRAINT fk_account__reference_channel;
       public          postgres    false    219    224    3339                        2606    16796 #   account fk_account_reference_client    FK CONSTRAINT     �   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_account_reference_client FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 M   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_account_reference_client;
       public          postgres    false    3341    225    215            !           2606    16801    account fk_account_to_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fk_account_to_product FOREIGN KEY (code_product, code_product_type) REFERENCES public.product(code_product, code_product_type) ON UPDATE RESTRICT ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.account DROP CONSTRAINT fk_account_to_product;
       public          postgres    false    215    215    236    3353    236            %           2606    16806 $   bank_user fk_bank_use_reference_bank    FK CONSTRAINT     �   ALTER TABLE ONLY public.bank_user
    ADD CONSTRAINT fk_bank_use_reference_bank FOREIGN KEY (code_bank) REFERENCES public.bank(code_bank) ON UPDATE RESTRICT ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public.bank_user DROP CONSTRAINT fk_bank_use_reference_bank;
       public          postgres    false    3333    222    221            &           2606    16811 $   bank_user fk_bank_use_reference_role    FK CONSTRAINT     �   ALTER TABLE ONLY public.bank_user
    ADD CONSTRAINT fk_bank_use_reference_role FOREIGN KEY (code_role) REFERENCES public.role(code_role) ON UPDATE RESTRICT ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public.bank_user DROP CONSTRAINT fk_bank_use_reference_role;
       public          postgres    false    238    3357    222            '           2606    16816 !   channel fk_channel_reference_bank    FK CONSTRAINT     �   ALTER TABLE ONLY public.channel
    ADD CONSTRAINT fk_channel_reference_bank FOREIGN KEY (code_bank) REFERENCES public.bank(code_bank) ON UPDATE RESTRICT ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.channel DROP CONSTRAINT fk_channel_reference_bank;
       public          postgres    false    3333    224    221            )           2606    16821 +   client_address fk_client_a_reference_client    FK CONSTRAINT     �   ALTER TABLE ONLY public.client_address
    ADD CONSTRAINT fk_client_a_reference_client FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.client_address DROP CONSTRAINT fk_client_a_reference_client;
       public          postgres    false    3341    225    226            *           2606    16826 )   client_phone fk_client_p_reference_client    FK CONSTRAINT     �   ALTER TABLE ONLY public.client_phone
    ADD CONSTRAINT fk_client_p_reference_client FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.client_phone DROP CONSTRAINT fk_client_p_reference_client;
       public          postgres    false    229    225    3341            (           2606    16831 "   client fk_client_reference_segment    FK CONSTRAINT     �   ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_client_reference_segment FOREIGN KEY (code_segment) REFERENCES public.segment(code_segment) ON UPDATE RESTRICT ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.client DROP CONSTRAINT fk_client_reference_segment;
       public          postgres    false    225    239    3359            +           2606    16836 (   debit_card fk_debit_ca_reference_account    FK CONSTRAINT     �   ALTER TABLE ONLY public.debit_card
    ADD CONSTRAINT fk_debit_ca_reference_account FOREIGN KEY (account_id) REFERENCES public.account(account_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.debit_card DROP CONSTRAINT fk_debit_ca_reference_account;
       public          postgres    false    215    3327    231            ,           2606    16841 '   debit_card fk_debit_ca_reference_client    FK CONSTRAINT     �   ALTER TABLE ONLY public.debit_card
    ADD CONSTRAINT fk_debit_ca_reference_client FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.debit_card DROP CONSTRAINT fk_debit_ca_reference_client;
       public          postgres    false    225    231    3341            -           2606    16846 /   interest_rate_log fk_intratelog_to_interestrate    FK CONSTRAINT     �   ALTER TABLE ONLY public.interest_rate_log
    ADD CONSTRAINT fk_intratelog_to_interestrate FOREIGN KEY (code_interest_rate) REFERENCES public.interest_rate(code_interest_rate) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Y   ALTER TABLE ONLY public.interest_rate_log DROP CONSTRAINT fk_intratelog_to_interestrate;
       public          postgres    false    234    233    3349            .           2606    16851 $   product fk_product_reference_segment    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_reference_segment FOREIGN KEY (code_segment) REFERENCES public.segment(code_segment) ON UPDATE RESTRICT ON DELETE RESTRICT;
 N   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_product_reference_segment;
       public          postgres    false    3359    236    239            /           2606    16856 "   product fk_product_to_interestrate    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_to_interestrate FOREIGN KEY (code_interest_rate) REFERENCES public.interest_rate(code_interest_rate) ON UPDATE RESTRICT ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_product_to_interestrate;
       public          postgres    false    233    236    3349            0           2606    16861 !   product fk_product_to_producttype    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_to_producttype FOREIGN KEY (code_product_type) REFERENCES public.product_type(code_product_type) ON UPDATE RESTRICT ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_product_to_producttype;
       public          postgres    false    237    236    3355            �   {   x�3��w100�v��s�4�4426153��4��8Q(�8�0�tt�4202�50�54P00�#�����!�`"Ə��yF�f�&�F���T�!b`��<#��gu���b���� '<v      �   @   x�3�4���100�4202�50�54P00�#NC=�gj����e�iQm�]�)��=... ^GS      �   �   x��α
�0��������q�5P�ؒtp�P�.}��;~88��>&& L��i��@�N���L��31P��)�(n�֍i;�.aJF�9?��T�VG��u/XŶ/��ѻH�^nSH��,[��kM�ka؏�Q[��z�w9c      �   &   x�3004�tJ�+,�,��4202�50�50����� u��      �   �   x�3�4004�tt����,N-N�I�J�NMJ,.�L��!D`"N�Μ�FƜFF&�f��
V`����U��\�f���Cznbf�^r~.�����A�E��y@\����R���U�s�q@�=�H����� b�I�      �      x�3000�bCN�_�=... !�*      �   �   x����
�P���S�^�^�[e&�"	o��L&)�jA=}fZ���0�;���6�VG	~�.tôl�E�TЃ���.������N��o����,�K஋�>�c<� ����qTCfY�AnC�&"�{xMo��yZu�"&�}��:�e���gT%�!��<^��We�X���f/��΋�mN8f��<��`@      �   M   x�3�4�����tN��IUpK�)NT042�t,(Q0�4 A�,�tt�2�4BR�Z����Z��`bj�a��#F��� ���      �   (   x�3�4���w�4���NG�.#N#��@%b���� +|
�      �   r   x�3�4A#cS3s�4202�50�54�NMJ,.�L�SN�I�J,���u500�����2�As3Sc#C�	�H%�T*8g$�%g$V�M1�T����� ��!�      �   ,   x�rq500���+I-J-.QJ,IU0�46�463����� ���      �   .   x�3�rq500�4�35�4202�50�54����tt����� �j�      �   Q   x��w100�v��s�rq�]��TbYf^z��crr~i^	��s����������g�g	�p��qqq STU      �   '   x��w100�N,��K/�t���,��������� �v�      �   .   x�st����tL����,.)JL�/�
v�-.M,������� ��      �   a   x�vu700�NM�M�+�W��p�t���S�A
��y
I�y�i�ə��
��9�ře��\� �F�A��9�E�N��#� ���\1z\\\ J%�     