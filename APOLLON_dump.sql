/*
                                                                                         
 ____  _____ _____ _____      _     _    ____  _____ _____ _____ _____ _____ _____ _____ 
|    \|  |  |     |  _  |   _| |___| |  |    \|  _  |_   _|  _  | __  |  _  |   __|   __|
|  |  |  |  | | | |   __|  | . | -_| |  |  |  |     | | | |     | __ -|     |__   |   __|
|____/|_____|_|_|_|__|     |___|___|_|  |____/|__|__| |_| |__|__|_____|__|__|_____|_____|
                                                                                         
*/
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-06-15 16:28:51 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3730 (class 1262 OID 16553)
-- Name: APOLLON; Type: DATABASE; Schema: -; Owner: derekgusatto
--

CREATE DATABASE "APOLLON" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE "APOLLON" OWNER TO derekgusatto;

\connect "APOLLON"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16706)
-- Name: abbonamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abbonamento (
    id character(6) NOT NULL,
    premium boolean NOT NULL,
    metodopagamento character varying(15),
    annuale boolean
);


ALTER TABLE public.abbonamento OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16593)
-- Name: album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album (
    id character(5) NOT NULL,
    titolo character varying(40) NOT NULL,
    anno integer NOT NULL,
    prezzo numeric NOT NULL
);


ALTER TABLE public.album OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16600)
-- Name: artista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artista (
    cf character(16) NOT NULL,
    nome character varying(40) NOT NULL,
    cognome character varying(40) NOT NULL,
    nazionalita character(2) NOT NULL,
    datanascita date NOT NULL,
    nomedarte character varying(40),
    contratto character(11) NOT NULL
);


ALTER TABLE public.artista OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16747)
-- Name: ascolto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ascolto (
    numascolto integer NOT NULL,
    idutente character(7) NOT NULL,
    idbrano character(7) NOT NULL,
    orainizio timestamp without time zone NOT NULL,
    orafine timestamp without time zone NOT NULL,
    CONSTRAINT ascolto_check CHECK ((orafine > orainizio))
);


ALTER TABLE public.ascolto OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16746)
-- Name: ascolto_numascolto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ascolto_numascolto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ascolto_numascolto_seq OWNER TO postgres;

--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 226
-- Name: ascolto_numascolto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ascolto_numascolto_seq OWNED BY public.ascolto.numascolto;


--
-- TOC entry 219 (class 1259 OID 16645)
-- Name: brano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brano (
    id character(7) NOT NULL,
    titolo character varying(40) NOT NULL,
    durata integer NOT NULL,
    guadagnosecondo numeric NOT NULL,
    datarilascio date NOT NULL
);


ALTER TABLE public.brano OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16731)
-- Name: contiene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contiene (
    idbrano character(7) NOT NULL,
    idplaylist character(7) NOT NULL,
    idutente character(7) NOT NULL
);


ALTER TABLE public.contiene OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16588)
-- Name: etichetta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etichetta (
    piva character(11) NOT NULL,
    nome character varying(40) NOT NULL,
    citta character varying(40) NOT NULL
);


ALTER TABLE public.etichetta OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16610)
-- Name: genere; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genere (
    nome character varying(15) NOT NULL,
    cf character(16) NOT NULL
);


ALTER TABLE public.genere OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16721)
-- Name: playlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlist (
    id character(7) NOT NULL,
    idutente character(7) NOT NULL,
    nome character varying(40) NOT NULL,
    privata boolean NOT NULL
);


ALTER TABLE public.playlist OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16765)
-- Name: premio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.premio (
    codice character(4) NOT NULL,
    titolo character varying(40) NOT NULL,
    societa character varying(40) NOT NULL,
    data date,
    titoloconcorso character varying(40),
    passaggiradio integer,
    numerostream integer,
    totalevendite integer
);


ALTER TABLE public.premio OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16671)
-- Name: raccogliere; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raccogliere (
    idbrano character(7) NOT NULL,
    idalbum character(7) NOT NULL
);


ALTER TABLE public.raccogliere OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16630)
-- Name: rilascio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rilascio (
    idalbum character(5) NOT NULL,
    cfartista character(16) NOT NULL
);


ALTER TABLE public.rilascio OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16652)
-- Name: suona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suona (
    idbrano character(7) NOT NULL,
    cfartista character(16) NOT NULL
);


ALTER TABLE public.suona OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16711)
-- Name: utente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utente (
    id character varying(7) NOT NULL,
    nome character varying(40) NOT NULL,
    cognome character varying(40) NOT NULL,
    datanascita date NOT NULL,
    email character varying(50) NOT NULL,
    abbonamento character(6) NOT NULL
);


ALTER TABLE public.utente OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16770)
-- Name: vincita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vincita (
    idbrano character(7) NOT NULL,
    codpremio character(4) NOT NULL
);


ALTER TABLE public.vincita OWNER TO postgres;

--
-- TOC entry 3517 (class 2604 OID 16750)
-- Name: ascolto numascolto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ascolto ALTER COLUMN numascolto SET DEFAULT nextval('public.ascolto_numascolto_seq'::regclass);


--
-- TOC entry 3717 (class 0 OID 16706)
-- Dependencies: 222
-- Data for Name: abbonamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.abbonamento VALUES ('AAA333', true, 'VISA', false);
INSERT INTO public.abbonamento VALUES ('AAA222', true, 'MasterCard', true);
INSERT INTO public.abbonamento VALUES ('AAA555', true, 'Apple Pay', false);
INSERT INTO public.abbonamento VALUES ('BBB777', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('BBB888', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('CCC222', true, 'VISA', true);
INSERT INTO public.abbonamento VALUES ('CCC777', true, 'Apple Pay', true);
INSERT INTO public.abbonamento VALUES ('DDD111', true, 'VISA', false);
INSERT INTO public.abbonamento VALUES ('EEE999', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('CAB001', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('BGF101', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('RFT103', true, 'MasterCard', false);
INSERT INTO public.abbonamento VALUES ('RTD223', true, 'Apple Pay', true);
INSERT INTO public.abbonamento VALUES ('RFI043', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('OOO000', false, NULL, NULL);
INSERT INTO public.abbonamento VALUES ('BTS007', true, 'VISA', true);


--
-- TOC entry 3710 (class 0 OID 16593)
-- Dependencies: 215
-- Data for Name: album; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.album VALUES ('AAAAA', 'Non Zero Sumness Plus One', 2003, 20.30);
INSERT INTO public.album VALUES ('ABBBA', '21', 2011, 19.50);
INSERT INTO public.album VALUES ('CCCAA', 'Like a Virgin', 1984, 17.80);
INSERT INTO public.album VALUES ('DDEDS', 'I Am... Sasha Fierce', 2008, 15.80);
INSERT INTO public.album VALUES ('GHTRS', 'Fiesta', 1999, 21.00);
INSERT INTO public.album VALUES ('TYOPL', 'The Platinum Collection', 2004, 22.50);
INSERT INTO public.album VALUES ('VCDIE', 'Private Dancer', 1984, 19.90);
INSERT INTO public.album VALUES ('MNBAD', 'Like a Prayer', 1989, 16.70);
INSERT INTO public.album VALUES ('TRIXA', 'Noche Blanca', 2013, 18.20);
INSERT INTO public.album VALUES ('CEHRT', 'Heart of Stone', 1989, 17.60);
INSERT INTO public.album VALUES ('ACILL', 'Black Album', 1991, 21.40);
INSERT INTO public.album VALUES ('LIAOP', 'Immaculate Collection', 1990, 20.00);


--
-- TOC entry 3711 (class 0 OID 16600)
-- Dependencies: 216
-- Data for Name: artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.artista VALUES ('AVTI5567HSK5CXS6', 'Mina Anna Maria', 'Mazzini', 'IT', '1990-11-30', 'Mina', '38574027583');
INSERT INTO public.artista VALUES ('BBHN567VHSK554CF', 'Raffaella Maria Roberta', 'Pelloni', 'BE', '1902-09-13', 'Raffaella Carrà', '38838672093');
INSERT INTO public.artista VALUES ('NJ56567VHSK5ZS45', 'Robert William Gary', 'Moore', 'HR', '1986-08-18', NULL, '57692756432');
INSERT INTO public.artista VALUES ('CU78DS4VHSK5BVR5', 'Ji-Min', 'Park', 'FR', '1994-12-09', 'Jimin', '95768345967');
INSERT INTO public.artista VALUES ('VB78J34VHSK5XC65', 'Anna Mae', 'Bullock', 'US', '1956-01-10', 'Tina Turner', '17585674568');
INSERT INTO public.artista VALUES ('RTYB67VHSK5KH68F', 'Riccardo', 'Fabbriconi', 'NZ', '2000-02-11', 'Blanco', '17585674568');
INSERT INTO public.artista VALUES ('JH78DS4VHSK5G67M', 'Giselle', 'Knowles-Carter', 'US', '1989-12-21', 'Beyoncé', '38574027583');
INSERT INTO public.artista VALUES ('XZTBN67VHSK5CXS6', 'Justin', 'Timberlake', 'US', '1983-09-14', NULL, '38838672093');
INSERT INTO public.artista VALUES ('BVCX567VHSK554CF', 'Louise Veronica', 'Ciccone', 'US', '1968-03-30', 'Madonna', '38838672093');
INSERT INTO public.artista VALUES ('POIUY67VHSK5ZS45', 'Taylor Alison', 'Swift', 'US', '1994-11-22', 'Taylor Swift', '17585674568');
INSERT INTO public.artista VALUES ('LKJHG34VHSK5BVR5', 'Ariana', 'Grande-Butera', 'US', '1994-03-01', 'Ariana Grande', '45672957684');
INSERT INTO public.artista VALUES ('MNBVC34VHSK5XC65', 'Alicia Augello', 'Cook', 'US', '1981-01-25', 'Alicia Keys', '45672957684');
INSERT INTO public.artista VALUES ('POIUY67VHSKKH68F', 'Michael Joseph', 'Jackson', 'US', '1966-06-28', 'Michael Jackson', '38574027583');
INSERT INTO public.artista VALUES ('P67VHSOIUY45AZDD', 'James', 'Hetfiels', 'US', '1995-07-21', 'Metallica', '17585674568');
INSERT INTO public.artista VALUES ('LKJHG346GHSK5BV5', 'Dolly Rebecca', 'Parton', 'US', '1986-04-08', 'Dolly Parton', '45672957684');
INSERT INTO public.artista VALUES ('MNBVC367GHSDXC65', 'Marco', 'Baroni', 'IT', '1989-03-14', 'Planet Funk', '38574027583');
INSERT INTO public.artista VALUES ('POIUZ67VHSKKH68F', 'Cherilyn', 'Sarkisian', 'US', '1975-05-27', 'Cher', '38574027583');
INSERT INTO public.artista VALUES ('BFCX435VHGK554PF', 'Chester', 'Bennington', 'US', '1970-06-30', 'Linkin Park', '57692756432');
INSERT INTO public.artista VALUES ('GHTI567VHSK5G67M', 'Adele Laurie Blue', 'Adkins', 'AT', '1970-06-05', 'Adele', '45672957684');


--
-- TOC entry 3722 (class 0 OID 16747)
-- Dependencies: 227
-- Data for Name: ascolto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ascolto VALUES (33, '12323AC', 'ABVDRLS', '2019-12-08 10:41:39.876', '2019-12-08 10:42:30.876');
INSERT INTO public.ascolto VALUES (34, '12323AC', 'ABVDRLS', '2020-06-06 20:00:47.418', '2020-06-06 20:03:48.418');
INSERT INTO public.ascolto VALUES (35, '12323AC', 'NONONON', '2016-08-02 09:58:48.139', '2016-08-02 09:59:58.139');
INSERT INTO public.ascolto VALUES (36, '12323AC', 'PFPFPF ', '2022-12-18 13:09:45.591', '2022-12-18 13:09:47.591');
INSERT INTO public.ascolto VALUES (37, '12323MR', 'PPPPPP ', '2016-05-12 16:30:22.37', '2016-05-12 16:34:22.37');
INSERT INTO public.ascolto VALUES (38, '12323MR', 'ABVDRLS', '2017-07-29 05:27:24.751', '2017-07-29 05:30:28.751');
INSERT INTO public.ascolto VALUES (39, '12323MR', 'IUHTGRF', '2012-08-22 16:29:06.583', '2012-08-22 16:33:06.583');
INSERT INTO public.ascolto VALUES (40, '12323MR', 'PLOKIJG', '2011-11-17 18:14:28.985', '2011-11-17 18:18:28.985');
INSERT INTO public.ascolto VALUES (41, '14795PC', 'PFPFPF ', '2015-11-09 09:52:55.515', '2015-11-09 09:57:55.515');
INSERT INTO public.ascolto VALUES (42, '14795PC', 'PPPPPP ', '2014-01-28 21:28:15.701', '2014-01-28 21:32:15.701');
INSERT INTO public.ascolto VALUES (43, '14795PC', 'AAAAAAA', '2020-12-08 11:46:27.093', '2020-12-08 11:49:27.093');
INSERT INTO public.ascolto VALUES (44, '14795PC', 'ABVDRLS', '2015-05-15 18:59:13.045', '2015-05-15 19:01:17.045');
INSERT INTO public.ascolto VALUES (45, '23653LP', 'PPPPPP ', '2011-12-20 07:09:31.855', '2011-12-20 07:13:31.855');
INSERT INTO public.ascolto VALUES (46, '23653LP', 'ABVDRLS', '2018-02-24 18:32:01.331', '2018-02-24 18:35:20.331');
INSERT INTO public.ascolto VALUES (47, '23653LP', 'ABVDRLS', '2010-07-21 03:45:11.645', '2010-07-21 03:48:11.645');
INSERT INTO public.ascolto VALUES (48, '23653LP', 'IUHTGRF', '2012-03-12 01:04:20.725', '2012-03-12 01:08:20.725');
INSERT INTO public.ascolto VALUES (49, '34563MR', 'NONONON', '2021-10-09 08:58:55.567', '2021-10-09 09:02:55.567');
INSERT INTO public.ascolto VALUES (50, '34563MR', 'TGYTRFG', '2020-02-20 01:05:24.493', '2020-02-20 01:08:28.493');
INSERT INTO public.ascolto VALUES (51, '34563MR', 'ASDCFDS', '2012-09-16 06:03:27.156', '2012-09-16 06:08:27.156');
INSERT INTO public.ascolto VALUES (52, '34563MR', 'IIIIII ', '2018-04-14 12:36:31.497', '2018-04-14 12:37:33.497');
INSERT INTO public.ascolto VALUES (54, '43545PA', 'ABVDRLS', '2011-08-21 11:46:54.789', '2011-08-21 11:49:54.789');
INSERT INTO public.ascolto VALUES (55, '43545PA', 'PFPFPF ', '2018-10-01 12:50:16.594', '2018-10-01 12:52:19.594');
INSERT INTO public.ascolto VALUES (56, '43545PA', 'PPPPPP ', '2013-06-05 02:20:08.435', '2013-06-05 02:23:10.435');
INSERT INTO public.ascolto VALUES (57, '43545PA', 'PLOKIJG', '2018-05-24 07:32:33.932', '2018-05-24 07:32:58.932');
INSERT INTO public.ascolto VALUES (58, '43545PA', 'ASDCFDS', '2017-07-13 11:20:11.725', '2017-07-13 11:24:11.725');
INSERT INTO public.ascolto VALUES (59, '46534LL', 'ABVDRLS', '2010-12-22 00:29:55.029', '2010-12-22 00:32:58.029');
INSERT INTO public.ascolto VALUES (60, '46534LL', 'ABVDRLS', '2021-07-12 04:25:00.665', '2021-07-12 04:28:00.665');
INSERT INTO public.ascolto VALUES (61, '46534LL', 'ABVDRLS', '2021-07-09 07:36:58.654', '2021-07-09 07:38:58.654');
INSERT INTO public.ascolto VALUES (62, '46534LL', 'IUHTGRF', '2016-05-12 16:30:22.37', '2016-05-12 16:33:22.37');
INSERT INTO public.ascolto VALUES (63, '54674AB', 'PFPFPF ', '2020-02-20 01:05:26.493', '2020-02-20 01:09:26.493');
INSERT INTO public.ascolto VALUES (64, '54674AB', 'PPPPPP ', '2019-12-08 10:41:42.876', '2019-12-08 10:43:42.876');
INSERT INTO public.ascolto VALUES (65, '54674AB', 'AAAAAAA', '2018-10-01 12:50:17.594', '2018-10-01 12:53:17.594');
INSERT INTO public.ascolto VALUES (66, '54674AB', 'NONONON', '2012-08-22 16:29:10.583', '2012-08-22 16:33:00.583');
INSERT INTO public.ascolto VALUES (67, '87979TD', 'TGYTRFG', '2021-07-09 07:36:54.654', '2021-07-09 07:39:23.654');
INSERT INTO public.ascolto VALUES (68, '87979TD', 'ABVDRLS', '2021-07-12 04:25:05.665', '2021-07-12 04:28:05.665');
INSERT INTO public.ascolto VALUES (69, '87979TD', 'IUHTGRF', '2010-12-22 00:29:40.029', '2010-12-22 00:29:43.029');
INSERT INTO public.ascolto VALUES (70, '87979TD', 'PLOKIJG', '2017-07-13 11:20:13.725', '2017-07-13 11:23:56.725');
INSERT INTO public.ascolto VALUES (71, '87979TD', 'TGYTRFG', '2023-01-28 18:15:24.434', '2023-01-28 18:15:27.434');
INSERT INTO public.ascolto VALUES (72, '87979TD', 'PPPPPP ', '2018-04-14 12:36:36.497', '2018-04-14 12:39:39.497');
INSERT INTO public.ascolto VALUES (32, '12323AC', 'AAAAAAA', '2018-09-01 05:06:42.31', '2018-09-01 05:09:27.31');
INSERT INTO public.ascolto VALUES (53, '34563MR', 'AAAAAAA', '2023-01-28 18:15:31.434', '2023-01-28 18:18:16.434');


--
-- TOC entry 3714 (class 0 OID 16645)
-- Dependencies: 219
-- Data for Name: brano; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.brano VALUES ('AAAAAAA', 'Per un briciolo di allegria', 207, 0.05, '2023-04-23');
INSERT INTO public.brano VALUES ('ABVDRLS', 'Rumors has it', 223, 0.04, '2011-02-06');
INSERT INTO public.brano VALUES ('RTLSTDS', 'Grande grande grande', 300, 0.04, '2004-05-26');
INSERT INTO public.brano VALUES ('ADSRTGD', 'Like a prayer', 400, 0.2, '1989-04-23');
INSERT INTO public.brano VALUES ('ADERTGD', 'Halo', 400, 0.12, '2008-07-12');
INSERT INTO public.brano VALUES ('SWERTTF', 'Im a single lady', 400, 0.14, '2008-07-12');
INSERT INTO public.brano VALUES ('PFPFPF ', 'Chasing the sun', 320, 0.13, '2003-02-24');
INSERT INTO public.brano VALUES ('WSWSWS ', 'Who said', 290, 0.15, '2003-02-24');
INSERT INTO public.brano VALUES ('QWERTYU', 'Emotional fire', 320, 0.7, '1989-07-06');
INSERT INTO public.brano VALUES ('MNBVCCD', 'Heart of stone', 290, 0.5, '1989-07-06');
INSERT INTO public.brano VALUES ('UYTRFVU', 'Still claw', 345, 0.6, '1984-05-29');
INSERT INTO public.brano VALUES ('POIUYTR', 'I cant stand the rain', 280, 0.5, '1984-05-29');
INSERT INTO public.brano VALUES ('GFRTHGF', 'My friend of misery', 310, 0.43, '1991-08-12');
INSERT INTO public.brano VALUES ('RDFREYD', 'The God that failed', 235, 0.21, '1991-08-12');
INSERT INTO public.brano VALUES ('TGYTRFG', 'Like a vergin', 265, 0.65, '1990-11-30');
INSERT INTO public.brano VALUES ('PLOKIJG', 'Express your self', 290, 0.54, '1990-11-30');
INSERT INTO public.brano VALUES ('OKIJYGF', 'Open your heart', 290, 0.33, '1990-11-30');
INSERT INTO public.brano VALUES ('ASDCFDS', 'Bye bye bye', 300, 0.5, '2000-07-18');
INSERT INTO public.brano VALUES ('AGDTFSS', 'Thriller', 270, 0.43, '1982-05-14');
INSERT INTO public.brano VALUES ('AWSDRFS', 'Bad', 255, 0.32, '1987-08-31');
INSERT INTO public.brano VALUES ('IUHTGRF', 'My little love', 240, 0.30, '2021-11-24');
INSERT INTO public.brano VALUES ('NONONON', 'No one', 250, 0.40, '2007-03-12');
INSERT INTO public.brano VALUES ('TSTSTST', 'Bad blood', 260, 0.50, '2014-06-30');
INSERT INTO public.brano VALUES ('AGAGAGA', 'Rain on me', 260, 0.60, '2020-07-23');
INSERT INTO public.brano VALUES ('FMFMFM ', '4 minutes', 295, 0.34, '2008-08-08');
INSERT INTO public.brano VALUES ('FFFFFF ', 'Forte forte forte', 300, 0.30, '1999-09-29');
INSERT INTO public.brano VALUES ('GGGGGG ', 'Rumore', 310, 0.29, '1999-09-29');
INSERT INTO public.brano VALUES ('HHHHHH ', 'Fiesta', 280, 0.43, '1999-09-29');
INSERT INTO public.brano VALUES ('IIIIII ', 'Che dolor', 310, 0.21, '1999-09-29');
INSERT INTO public.brano VALUES ('PPPPPP ', 'Pedro', 340, 0.68, '1999-09-29');
INSERT INTO public.brano VALUES ('AMICAM ', 'Amicoamante', 250, 0.27, '1993-03-25');
INSERT INTO public.brano VALUES ('YOONGII', 'Bad Decisions', 280, 0.65, '2023-05-23');
INSERT INTO public.brano VALUES ('NEMNEMM', 'Nothing else matters', 205, 0.520000, '2023-06-11');


--
-- TOC entry 3720 (class 0 OID 16731)
-- Dependencies: 225
-- Data for Name: contiene; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contiene VALUES ('RTLSTDS', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('SWERTTF', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('GGGGGG ', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('PPPPPP ', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('AGAGAGA', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('ADERTGD', '1111BBB', '54644CH');
INSERT INTO public.contiene VALUES ('WSWSWS ', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('AGDTFSS', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('TGYTRFG', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('GFRTHGF', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('ADSRTGD', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('FFFFFF ', '9898DDD', '23653LP');
INSERT INTO public.contiene VALUES ('AAAAAAA', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('FFFFFF ', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('TGYTRFG', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('POIUYTR', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('QWERTYU', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('IIIIII ', '2345YUP', '43545PA');
INSERT INTO public.contiene VALUES ('PFPFPF ', '2345YUP', '14795PC');
INSERT INTO public.contiene VALUES ('WSWSWS ', '2345YUP', '14795PC');
INSERT INTO public.contiene VALUES ('TGYTRFG', '2345YUP', '14795PC');
INSERT INTO public.contiene VALUES ('GGGGGG ', '2345YUP', '14795PC');
INSERT INTO public.contiene VALUES ('ASDCFDS', '2345YUP', '14795PC');
INSERT INTO public.contiene VALUES ('ABVDRLS', '1212BCA', '87979TD');
INSERT INTO public.contiene VALUES ('UYTRFVU', '1212BCA', '87979TD');
INSERT INTO public.contiene VALUES ('FMFMFM ', '1212BCA', '87979TD');
INSERT INTO public.contiene VALUES ('PLOKIJG', '1212BCA', '87979TD');
INSERT INTO public.contiene VALUES ('TSTSTST', '1212BCA', '87979TD');
INSERT INTO public.contiene VALUES ('YOONGII', '4567BTS', '56789AD');


--
-- TOC entry 3709 (class 0 OID 16588)
-- Dependencies: 214
-- Data for Name: etichetta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.etichetta VALUES ('45672957684', 'Big Hit Music', 'Ankara');
INSERT INTO public.etichetta VALUES ('38574027583', 'Warner Music', 'New York');
INSERT INTO public.etichetta VALUES ('38838672093', 'Sony Music', 'Milano');
INSERT INTO public.etichetta VALUES ('57692756432', 'Interscope', 'Buenos Aires');
INSERT INTO public.etichetta VALUES ('95768345967', 'Virgin Records', 'Tokyo');
INSERT INTO public.etichetta VALUES ('17585674568', 'Universal Music', 'Reykjavik');
INSERT INTO public.etichetta VALUES ('56723456789', 'Purple Records', 'Seoul');


--
-- TOC entry 3712 (class 0 OID 16610)
-- Dependencies: 217
-- Data for Name: genere; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genere VALUES ('POP', 'GHTI567VHSK5G67M');
INSERT INTO public.genere VALUES ('POP', 'AVTI5567HSK5CXS6');
INSERT INTO public.genere VALUES ('CLASSICAL', 'AVTI5567HSK5CXS6');
INSERT INTO public.genere VALUES ('POP', 'BBHN567VHSK554CF');
INSERT INTO public.genere VALUES ('DANCE', 'BBHN567VHSK554CF');
INSERT INTO public.genere VALUES ('BLUES', 'NJ56567VHSK5ZS45');
INSERT INTO public.genere VALUES ('JAZZ', 'NJ56567VHSK5ZS45');
INSERT INTO public.genere VALUES ('K-POP', 'CU78DS4VHSK5BVR5');
INSERT INTO public.genere VALUES ('BLUES', 'VB78J34VHSK5XC65');
INSERT INTO public.genere VALUES ('POP', 'RTYB67VHSK5KH68F');
INSERT INTO public.genere VALUES ('POP', 'JH78DS4VHSK5G67M');
INSERT INTO public.genere VALUES ('R&B', 'JH78DS4VHSK5G67M');
INSERT INTO public.genere VALUES ('POP', 'XZTBN67VHSK5CXS6');
INSERT INTO public.genere VALUES ('POP', 'BVCX567VHSK554CF');
INSERT INTO public.genere VALUES ('DANCE', 'BVCX567VHSK554CF');
INSERT INTO public.genere VALUES ('POP', 'POIUY67VHSK5ZS45');
INSERT INTO public.genere VALUES ('POP', 'LKJHG34VHSK5BVR5');
INSERT INTO public.genere VALUES ('BLUES', 'MNBVC34VHSK5XC65');
INSERT INTO public.genere VALUES ('ROCK', 'POIUY67VHSKKH68F');
INSERT INTO public.genere VALUES ('ROCK', 'BFCX435VHGK554PF');
INSERT INTO public.genere VALUES ('ROCK', 'P67VHSOIUY45AZDD');
INSERT INTO public.genere VALUES ('BLUES', 'LKJHG346GHSK5BV5');
INSERT INTO public.genere VALUES ('ELETTRONICA', 'MNBVC367GHSDXC65');
INSERT INTO public.genere VALUES ('POP', 'POIUZ67VHSKKH68F');


--
-- TOC entry 3719 (class 0 OID 16721)
-- Dependencies: 224
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.playlist VALUES ('0000AAA', '14795PC', 'The best ever', true);
INSERT INTO public.playlist VALUES ('1111BBB', '54644CH', 'Favorites', true);
INSERT INTO public.playlist VALUES ('2222CCC', '23653LP', 'Love it', true);
INSERT INTO public.playlist VALUES ('1212BCA', '87979TD', 'Always on', true);
INSERT INTO public.playlist VALUES ('3333FFF', '14795PC', 'Play it again', false);
INSERT INTO public.playlist VALUES ('4545III', '14795PC', 'Remember this?', false);
INSERT INTO public.playlist VALUES ('9898DDD', '23653LP', 'Sentita questa?', false);
INSERT INTO public.playlist VALUES ('3434HHH', '12353TB', 'Simply the best', true);
INSERT INTO public.playlist VALUES ('5665GGI', '54674AB', 'Happy birthday', true);
INSERT INTO public.playlist VALUES ('6788OWA', '54674AB', 'Party', true);
INSERT INTO public.playlist VALUES ('1234POP', '64745PF', 'Sounds good', true);
INSERT INTO public.playlist VALUES ('2343WOW', '54674AB', 'Memories', false);
INSERT INTO public.playlist VALUES ('2345YUP', '14795PC', 'DJ metti questa!', false);
INSERT INTO public.playlist VALUES ('2345YUP', '43545PA', 'AGAIN!', false);
INSERT INTO public.playlist VALUES ('4567BTS', '56789AD', 'Purple Hearts', true);


--
-- TOC entry 3723 (class 0 OID 16765)
-- Dependencies: 228
-- Data for Name: premio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.premio VALUES ('DORO', 'Disco doro', 'FIMI', NULL, NULL, 20000, 30000, 10000);
INSERT INTO public.premio VALUES ('DARG', 'Disco dargento', 'FIMI', NULL, NULL, 15000, 25000, 8000);
INSERT INTO public.premio VALUES ('DPLA', 'Disco di platino', 'FIMI', NULL, NULL, 30000, 40000, 15000);
INSERT INTO public.premio VALUES ('DDIA', 'Disco di diamante', 'FIMI', NULL, NULL, 25000, 27000, 12000);
INSERT INTO public.premio VALUES ('H20 ', 'Vincitore Power Hits Estate 2020', 'RTL 102.5', '2020-08-30', 'RTL Power Hits Estate', NULL, NULL, NULL);
INSERT INTO public.premio VALUES ('R21 ', 'Leone doro 2021', 'RAI', '2021-02-25', 'Festival di Sanremo', NULL, NULL, NULL);
INSERT INTO public.premio VALUES ('B96 ', 'Premio Festivalbar 1996', 'Mediaset', '1996-08-14', 'Festivalbar', NULL, NULL, NULL);


--
-- TOC entry 3716 (class 0 OID 16671)
-- Dependencies: 221
-- Data for Name: raccogliere; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.raccogliere VALUES ('ABVDRLS', 'ABBBA  ');
INSERT INTO public.raccogliere VALUES ('RTLSTDS', 'TYOPL  ');
INSERT INTO public.raccogliere VALUES ('ADSRTGD', 'MNBAD  ');
INSERT INTO public.raccogliere VALUES ('ADERTGD', 'DDEDS  ');
INSERT INTO public.raccogliere VALUES ('SWERTTF', 'DDEDS  ');
INSERT INTO public.raccogliere VALUES ('QWERTYU', 'CEHRT  ');
INSERT INTO public.raccogliere VALUES ('MNBVCCD', 'CEHRT  ');
INSERT INTO public.raccogliere VALUES ('UYTRFVU', 'VCDIE  ');
INSERT INTO public.raccogliere VALUES ('POIUYTR', 'VCDIE  ');
INSERT INTO public.raccogliere VALUES ('GFRTHGF', 'ACILL  ');
INSERT INTO public.raccogliere VALUES ('RDFREYD', 'ACILL  ');
INSERT INTO public.raccogliere VALUES ('TGYTRFG', 'LIAOP  ');
INSERT INTO public.raccogliere VALUES ('PLOKIJG', 'LIAOP  ');
INSERT INTO public.raccogliere VALUES ('OKIJYGF', 'LIAOP  ');
INSERT INTO public.raccogliere VALUES ('PFPFPF ', 'AAAAA  ');
INSERT INTO public.raccogliere VALUES ('WSWSWS ', 'AAAAA  ');
INSERT INTO public.raccogliere VALUES ('FFFFFF ', 'GHTRS  ');
INSERT INTO public.raccogliere VALUES ('GGGGGG ', 'GHTRS  ');
INSERT INTO public.raccogliere VALUES ('HHHHHH ', 'GHTRS  ');
INSERT INTO public.raccogliere VALUES ('IIIIII ', 'GHTRS  ');
INSERT INTO public.raccogliere VALUES ('PPPPPP ', 'GHTRS  ');


--
-- TOC entry 3713 (class 0 OID 16630)
-- Dependencies: 218
-- Data for Name: rilascio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rilascio VALUES ('AAAAA', 'MNBVC367GHSDXC65');
INSERT INTO public.rilascio VALUES ('ABBBA', 'GHTI567VHSK5G67M');
INSERT INTO public.rilascio VALUES ('CCCAA', 'BVCX567VHSK554CF');
INSERT INTO public.rilascio VALUES ('DDEDS', 'JH78DS4VHSK5G67M');
INSERT INTO public.rilascio VALUES ('GHTRS', 'BBHN567VHSK554CF');
INSERT INTO public.rilascio VALUES ('TYOPL', 'AVTI5567HSK5CXS6');
INSERT INTO public.rilascio VALUES ('VCDIE', 'VB78J34VHSK5XC65');
INSERT INTO public.rilascio VALUES ('MNBAD', 'BVCX567VHSK554CF');
INSERT INTO public.rilascio VALUES ('TRIXA', 'RTYB67VHSK5KH68F');
INSERT INTO public.rilascio VALUES ('CEHRT', 'POIUZ67VHSKKH68F');
INSERT INTO public.rilascio VALUES ('ACILL', 'P67VHSOIUY45AZDD');
INSERT INTO public.rilascio VALUES ('LIAOP', 'BVCX567VHSK554CF');


--
-- TOC entry 3715 (class 0 OID 16652)
-- Dependencies: 220
-- Data for Name: suona; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.suona VALUES ('AAAAAAA', 'AVTI5567HSK5CXS6');
INSERT INTO public.suona VALUES ('AAAAAAA', 'RTYB67VHSK5KH68F');
INSERT INTO public.suona VALUES ('ABVDRLS', 'GHTI567VHSK5G67M');
INSERT INTO public.suona VALUES ('RTLSTDS', 'AVTI5567HSK5CXS6');
INSERT INTO public.suona VALUES ('ADSRTGD', 'BVCX567VHSK554CF');
INSERT INTO public.suona VALUES ('ADERTGD', 'JH78DS4VHSK5G67M');
INSERT INTO public.suona VALUES ('SWERTTF', 'JH78DS4VHSK5G67M');
INSERT INTO public.suona VALUES ('QWERTYU', 'POIUZ67VHSKKH68F');
INSERT INTO public.suona VALUES ('MNBVCCD', 'POIUZ67VHSKKH68F');
INSERT INTO public.suona VALUES ('UYTRFVU', 'VB78J34VHSK5XC65');
INSERT INTO public.suona VALUES ('POIUYTR', 'VB78J34VHSK5XC65');
INSERT INTO public.suona VALUES ('GFRTHGF', 'P67VHSOIUY45AZDD');
INSERT INTO public.suona VALUES ('RDFREYD', 'P67VHSOIUY45AZDD');
INSERT INTO public.suona VALUES ('TGYTRFG', 'BVCX567VHSK554CF');
INSERT INTO public.suona VALUES ('PLOKIJG', 'BVCX567VHSK554CF');
INSERT INTO public.suona VALUES ('OKIJYGF', 'BVCX567VHSK554CF');
INSERT INTO public.suona VALUES ('ASDCFDS', 'XZTBN67VHSK5CXS6');
INSERT INTO public.suona VALUES ('AGDTFSS', 'POIUY67VHSKKH68F');
INSERT INTO public.suona VALUES ('AWSDRFS', 'POIUY67VHSKKH68F');
INSERT INTO public.suona VALUES ('IUHTGRF', 'GHTI567VHSK5G67M');
INSERT INTO public.suona VALUES ('NONONON', 'MNBVC34VHSK5XC65');
INSERT INTO public.suona VALUES ('TSTSTST', 'POIUY67VHSK5ZS45');
INSERT INTO public.suona VALUES ('AGAGAGA', 'LKJHG34VHSK5BVR5');
INSERT INTO public.suona VALUES ('FMFMFM ', 'BVCX567VHSK554CF');
INSERT INTO public.suona VALUES ('FMFMFM ', 'XZTBN67VHSK5CXS6');
INSERT INTO public.suona VALUES ('PFPFPF ', 'MNBVC367GHSDXC65');
INSERT INTO public.suona VALUES ('WSWSWS ', 'MNBVC367GHSDXC65');
INSERT INTO public.suona VALUES ('FFFFFF ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('GGGGGG ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('HHHHHH ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('IIIIII ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('PPPPPP ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('AMICAM ', 'BBHN567VHSK554CF');
INSERT INTO public.suona VALUES ('YOONGII', 'CU78DS4VHSK5BVR5');
INSERT INTO public.suona VALUES ('NEMNEMM', 'P67VHSOIUY45AZDD');


--
-- TOC entry 3718 (class 0 OID 16711)
-- Dependencies: 223
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utente VALUES ('12323MR', 'Mario', 'Rossi', '2001-03-21', 'mariorossi@gmail.com', 'OOO000');
INSERT INTO public.utente VALUES ('23232GF', 'Giada', 'Forza', '2002-03-30', 'forzagiada@gmail.com', 'RFI043');
INSERT INTO public.utente VALUES ('2343SBV', 'Beatrice', 'Verdi', '1996-04-23', 'beaverdi@gmail.com', 'RTD223');
INSERT INTO public.utente VALUES ('12353TB', 'Talia', 'Berlinguer', '1998-06-24', 'taliaberlinguer@gmail.com', 'RFT103');
INSERT INTO public.utente VALUES ('87979TD', 'Tony', 'Dinozzo', '1984-05-27', 'dinozzot@gmail.com', 'BGF101');
INSERT INTO public.utente VALUES ('43545PA', 'Piero', 'Angela', '1970-11-27', 'angelapiero@gmail.com', 'CAB001');
INSERT INTO public.utente VALUES ('43564LD', 'Leonardo', 'DiCaprio', '1984-12-25', 'leodicaprio@gmail.com', 'EEE999');
INSERT INTO public.utente VALUES ('14795PC', 'Penelope', 'Cruz', '1991-10-20', 'cruzpenelope@gmail.com', 'DDD111');
INSERT INTO public.utente VALUES ('64745PF', 'Pierfrancesco', 'Favino', '2001-07-20', 'favinopierf@gmail.com', 'CCC777');
INSERT INTO public.utente VALUES ('12323AC', 'AJ', 'Cook', '2003-08-11', 'cookaj@gmail.com', 'CCC222');
INSERT INTO public.utente VALUES ('46534LL', 'Lucy', 'Liu', '2001-04-24', 'lucyliu@gmail.com', 'BBB888');
INSERT INTO public.utente VALUES ('23653LP', 'Lana', 'Parilla', '1999-09-19', 'lanaparilla@gmail.com', 'BBB777');
INSERT INTO public.utente VALUES ('54644CH', 'Chris', 'Evans', '1998-07-12', 'evanchris@gmail.com', 'AAA555');
INSERT INTO public.utente VALUES ('34563MR', 'Mark', 'Ruffalo', '1972-11-28', 'ruffalom@gmail.com', 'AAA222');
INSERT INTO public.utente VALUES ('54674AB', 'Angela', 'Bassett', '1988-03-29', 'angelabassett@gmail.com', 'AAA333');
INSERT INTO public.utente VALUES ('56789AD', 'Jungkook', 'Jeon', '1997-09-01', 'jeonjungkook@gmail.com', 'BTS007');


--
-- TOC entry 3724 (class 0 OID 16770)
-- Dependencies: 229
-- Data for Name: vincita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vincita VALUES ('ABVDRLS', 'DORO');
INSERT INTO public.vincita VALUES ('AGDTFSS', 'DARG');
INSERT INTO public.vincita VALUES ('FFFFFF ', 'DPLA');
INSERT INTO public.vincita VALUES ('ADSRTGD', 'DDIA');
INSERT INTO public.vincita VALUES ('NONONON', 'H20 ');
INSERT INTO public.vincita VALUES ('AAAAAAA', 'R21 ');
INSERT INTO public.vincita VALUES ('PFPFPF ', 'B96 ');
INSERT INTO public.vincita VALUES ('HHHHHH ', 'DORO');
INSERT INTO public.vincita VALUES ('SWERTTF', 'DARG');
INSERT INTO public.vincita VALUES ('PPPPPP ', 'DPLA');
INSERT INTO public.vincita VALUES ('ADERTGD', 'DDIA');


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 226
-- Name: ascolto_numascolto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ascolto_numascolto_seq', 72, true);


--
-- TOC entry 3537 (class 2606 OID 16710)
-- Name: abbonamento abbonamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abbonamento
    ADD CONSTRAINT abbonamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3522 (class 2606 OID 16599)
-- Name: album album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (id);


--
-- TOC entry 3524 (class 2606 OID 16604)
-- Name: artista artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_pkey PRIMARY KEY (cf);


--
-- TOC entry 3546 (class 2606 OID 16753)
-- Name: ascolto ascolto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_pkey PRIMARY KEY (numascolto);


--
-- TOC entry 3530 (class 2606 OID 16651)
-- Name: brano brano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brano
    ADD CONSTRAINT brano_pkey PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 16735)
-- Name: contiene contiene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_pkey PRIMARY KEY (idbrano, idplaylist, idutente);


--
-- TOC entry 3520 (class 2606 OID 16592)
-- Name: etichetta etichetta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etichetta
    ADD CONSTRAINT etichetta_pkey PRIMARY KEY (piva);


--
-- TOC entry 3526 (class 2606 OID 16614)
-- Name: genere genere_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genere
    ADD CONSTRAINT genere_pkey PRIMARY KEY (nome, cf);


--
-- TOC entry 3542 (class 2606 OID 16725)
-- Name: playlist playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id, idutente);


--
-- TOC entry 3548 (class 2606 OID 16769)
-- Name: premio premio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.premio
    ADD CONSTRAINT premio_pkey PRIMARY KEY (codice);


--
-- TOC entry 3535 (class 2606 OID 16675)
-- Name: raccogliere raccogliere_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raccogliere
    ADD CONSTRAINT raccogliere_pkey PRIMARY KEY (idbrano, idalbum);


--
-- TOC entry 3528 (class 2606 OID 16634)
-- Name: rilascio rilascio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rilascio
    ADD CONSTRAINT rilascio_pkey PRIMARY KEY (idalbum, cfartista);


--
-- TOC entry 3533 (class 2606 OID 16656)
-- Name: suona suona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suona
    ADD CONSTRAINT suona_pkey PRIMARY KEY (idbrano, cfartista);


--
-- TOC entry 3539 (class 2606 OID 16715)
-- Name: utente utente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (id);


--
-- TOC entry 3550 (class 2606 OID 16774)
-- Name: vincita vincita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vincita
    ADD CONSTRAINT vincita_pkey PRIMARY KEY (idbrano, codpremio);


--
-- TOC entry 3531 (class 1259 OID 16785)
-- Name: idx_brano_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_brano_id ON public.brano USING btree (id);


--
-- TOC entry 3540 (class 1259 OID 16786)
-- Name: idx_playlist_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_playlist_id ON public.playlist USING btree (id, idutente);


--
-- TOC entry 3551 (class 2606 OID 16605)
-- Name: artista artista_contratto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_contratto_fkey FOREIGN KEY (contratto) REFERENCES public.etichetta(piva);


--
-- TOC entry 3563 (class 2606 OID 16759)
-- Name: ascolto ascolto_idbrano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_idbrano_fkey FOREIGN KEY (idbrano) REFERENCES public.brano(id);


--
-- TOC entry 3564 (class 2606 OID 16754)
-- Name: ascolto ascolto_idutente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_idutente_fkey FOREIGN KEY (idutente) REFERENCES public.utente(id);


--
-- TOC entry 3561 (class 2606 OID 16736)
-- Name: contiene contiene_idbrano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_idbrano_fkey FOREIGN KEY (idbrano) REFERENCES public.brano(id);


--
-- TOC entry 3562 (class 2606 OID 16741)
-- Name: contiene contiene_idplaylist_idutente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contiene
    ADD CONSTRAINT contiene_idplaylist_idutente_fkey FOREIGN KEY (idplaylist, idutente) REFERENCES public.playlist(id, idutente);


--
-- TOC entry 3552 (class 2606 OID 16615)
-- Name: genere genere_cf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genere
    ADD CONSTRAINT genere_cf_fkey FOREIGN KEY (cf) REFERENCES public.artista(cf);


--
-- TOC entry 3560 (class 2606 OID 16726)
-- Name: playlist playlist_idutente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_idutente_fkey FOREIGN KEY (idutente) REFERENCES public.utente(id);


--
-- TOC entry 3557 (class 2606 OID 16681)
-- Name: raccogliere raccogliere_idalbum_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raccogliere
    ADD CONSTRAINT raccogliere_idalbum_fkey FOREIGN KEY (idalbum) REFERENCES public.album(id);


--
-- TOC entry 3558 (class 2606 OID 16676)
-- Name: raccogliere raccogliere_idbrano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raccogliere
    ADD CONSTRAINT raccogliere_idbrano_fkey FOREIGN KEY (idbrano) REFERENCES public.brano(id);


--
-- TOC entry 3553 (class 2606 OID 16640)
-- Name: rilascio rilascio_cfartista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rilascio
    ADD CONSTRAINT rilascio_cfartista_fkey FOREIGN KEY (cfartista) REFERENCES public.artista(cf);


--
-- TOC entry 3554 (class 2606 OID 16635)
-- Name: rilascio rilascio_idalbum_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rilascio
    ADD CONSTRAINT rilascio_idalbum_fkey FOREIGN KEY (idalbum) REFERENCES public.album(id);


--
-- TOC entry 3555 (class 2606 OID 16662)
-- Name: suona suona_cfartista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suona
    ADD CONSTRAINT suona_cfartista_fkey FOREIGN KEY (cfartista) REFERENCES public.artista(cf);


--
-- TOC entry 3556 (class 2606 OID 16657)
-- Name: suona suona_idbrano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suona
    ADD CONSTRAINT suona_idbrano_fkey FOREIGN KEY (idbrano) REFERENCES public.brano(id);


--
-- TOC entry 3559 (class 2606 OID 16716)
-- Name: utente utente_abbonamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_abbonamento_fkey FOREIGN KEY (abbonamento) REFERENCES public.abbonamento(id);


--
-- TOC entry 3565 (class 2606 OID 16780)
-- Name: vincita vincita_codpremio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vincita
    ADD CONSTRAINT vincita_codpremio_fkey FOREIGN KEY (codpremio) REFERENCES public.premio(codice);


--
-- TOC entry 3566 (class 2606 OID 16775)
-- Name: vincita vincita_idbrano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vincita
    ADD CONSTRAINT vincita_idbrano_fkey FOREIGN KEY (idbrano) REFERENCES public.brano(id);


-- Completed on 2023-06-15 16:28:51 CEST

--
-- PostgreSQL database dump complete
--


/*
                               
 _____ _____ _____ _____ __ __ 
|     |  |  |   __| __  |  |  |
|  |  |  |  |   __|    -|_   _|
|__  _|_____|_____|__|__| |_|  
   |__|                        
*/


-- QUERY 1
/*
SELECT DISTINCT ETICHETTA.nome AS etichetta, T.nome, cognome, nomedArte
FROM ETICHETTA
JOIN (
	SELECT contratto, nome, cognome, nomedArte
	FROM ARTISTA
	JOIN SUONA ON ARTISTA.cf = SUONA.cfArtista
	JOIN VINCITA ON VINCITA.idBrano = SUONA.idBrano
	WHERE codPremio = 'DORO' OR codPremio = 'DPLA'
) AS T ON T.contratto = ETICHETTA.pIVA
*/

-- QUERY 2
/*
SELECT idAlbum, numPremiAlbum
FROM(
SELECT RACCOGLIERE.idAlbum, SUM(numPremi) AS numPremiAlbum
FROM (
SELECT RILASCIO.idAlbum
FROM GENERE
JOIN RILASCIO ON  genere.cf = RILASCIO.cfArtista
WHERE GENERE.nome='POP') AS AlbumPOP
JOIN RACCOGLIERE ON RACCOGLIERE.idAlbum = AlbumPOP.idAlbum
JOIN (
SELECT COUNT(codPremio) AS numPremi, idBrano
FROM VINCITA
JOIN PREMIO ON VINCITA.codPremio = PREMIO.codice
WHERE numeroStream IS NOT NULL
GROUP BY idBrano) AS ConteggioPremi 
ON RACCOGLIERE.idBrano = ConteggioPremi.idBrano
GROUP BY RACCOGLIERE.idAlbum
) AS temp
ORDER BY  numPremiAlbum DESC
LIMIT 1
*/


-- QUERY 3
/*
SELECT ARTISTA.nome, ARTISTA.cognome, ARTISTA.nomedarte, COUNT(SUONA.idbrano) AS NumeroBrani
FROM ARTISTA 
JOIN SUONA ON ARTISTA.cf = SUONA.cfartista
WHERE ARTISTA.datanascita <= '2000-02-11' AND ARTISTA.nazionalita = 'US'
GROUP BY ARTISTA.cf
HAVING COUNT(SUONA.idbrano) > 1;

*/


-- QUERY 4
/*
SELECT DISTINCT UTENTE.nome,UTENTE.cognome, GENERE.nome AS Genere, COUNT(DISTINCT ARTISTA.cf) AS NumeroArtistiAscoltati
FROM UTENTE
JOIN ASCOLTO ON UTENTE.id =ASCOLTO.idUtente
JOIN BRANO ON ASCOLTO.idBrano =BRANO.id
JOIN SUONA ON BRANO.id= SUONA.idBrano
JOIN ARTISTA ON SUONA.cfartista= ARTISTA.cf
JOIN GENERE ON ARTISTA.cf= GENERE.cf
GROUP BY UTENTE.id, GENERE.nome
*/


-- QUERY 5
/*
SELECT UTENTE.nome AS nome_utente, SUONA.cfArtista AS artista_aggiunto, PLAYLIST.nome AS playlist, BRANO.titolo AS brano_aggiunto
FROM UTENTE
JOIN ABBONAMENTO ON UTENTE.abbonamento = ABBONAMENTO.id
JOIN PLAYLIST ON UTENTE.id = PLAYLIST.idutente
JOIN CONTIENE ON PLAYLIST.id = CONTIENE.idplaylist
JOIN BRANO ON CONTIENE.idbrano =BRANO.id
JOIN SUONA ON BRANO.id= SUONA.idbrano
WHERE ABBONAMENTO.premium = TRUE
AND PLAYLIST.privata = TRUE
AND SUONA.cfArtista = 'CU78DS4VHSK5BVR5';

*/


-- QUERY 6.1 - vincolo
/*
SELECT A1.idUtente, A1.idBrano AS brano1, A2.idBrano AS brano2
FROM ASCOLTO A1
JOIN ASCOLTO A2 ON A1.idUtente = A2.idUtente
WHERE A1.idBrano <> A2.idBrano
AND ((A1.oraInizio >= A2.oraInizio AND A1.oraInizio < A2.oraFine)
OR (A2.oraInizio >= A1.oraInizio AND A2.oraInizio < A1.oraFine))

*/

-- QUERY 6.2 - vincolo
/*
SELECT *
FROM ASCOLTO
JOIN BRANO ON ASCOLTO.idBrano = BRANO.id
WHERE ASCOLTO.oraFine > ASCOLTO.oraInizio + INTERVAL '1 second' * BRANO.durata

*/

-- QUERY 7 - inserimento
/*
BEGIN;
INSERT INTO BRANO(id, titolo, durata, guadagnoSecondo, dataRilascio) VALUES (‘ABC0012’, ‘rumore’ ‘320’, 0,003’, ’12/07/1970’);
INSERT INTO SUONA(idBrano, cfArtista) VALUES (‘ABC0012’, ‘BBHN567VHSK554CF’);
COMMIT;

*/