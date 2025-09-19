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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: insert_01_address_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_address_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_address_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_address(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_address_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_address_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_address(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_cartitem_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_cartitem_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_cartItem_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_cartItem(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_cartitem_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_cartitem_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_cartItem(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_category_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_category_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_category_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_category(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_category_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_category_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_category(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_image_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_image_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_image_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_image(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_image_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_image_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_image(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_order_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_order_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_order_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_order(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_order_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_order_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_order(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_orderitem_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_orderitem_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_orderItem_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_orderItem(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_orderitem_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_orderitem_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_orderItem(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_producttype_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_producttype_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_productType_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_productType(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_producttype_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_producttype_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productType(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_producttypetype_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_producttypetype_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_productTypeType_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_productTypeType(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_producttypetype_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_producttypetype_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productTypeType(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_productvariant_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_productvariant_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_productVariant_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_productVariant(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_productvariant_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_productvariant_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productVariant(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_01_user_aggregate_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_user_aggregate_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_01_user_event_and_return_id(event_in, aggregate_id);

INSERT INTO aggregate_events_01_user(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_01_user_event_and_return_id(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_01_user_event_and_return_id(event_in text, aggregate_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_user(event, aggregate_id, timestamp)
VALUES(event_in::text, aggregate_id,  now()) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_address_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_address_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_address_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_address(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_address_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_address_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_address(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_cartitem_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_cartitem_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_cartItem_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_cartItem(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_cartitem_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_cartitem_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_cartItem(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_category_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_category_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_category_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_category(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_category_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_category_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_category(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_image_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_image_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_image_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_image(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_image_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_image_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_image(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_order_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_order_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_order_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_order(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_order_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_order_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_order(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_orderitem_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_orderitem_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_orderItem_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_orderItem(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_orderitem_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_orderitem_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_orderItem(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_producttype_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_producttype_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_productType_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_productType(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_producttype_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_producttype_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productType(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_producttypetype_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_producttypetype_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_productTypeType_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_productTypeType(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_producttypetype_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_producttypetype_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productTypeType(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_productvariant_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_productvariant_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_productVariant_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_productVariant(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_productvariant_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_productvariant_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_productVariant(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: insert_md_01_user_aggregate_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_user_aggregate_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
    event_id integer;
BEGIN
    event_id := insert_md_01_user_event_and_return_id(event_in, aggregate_id, md);

INSERT INTO aggregate_events_01_user(aggregate_id, event_id)
VALUES(aggregate_id, event_id) RETURNING id INTO inserted_id;
return event_id;
END;
$$;


--
-- Name: insert_md_01_user_event_and_return_id(text, uuid, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_md_01_user_event_and_return_id(event_in text, aggregate_id uuid, md text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
inserted_id integer;
BEGIN
INSERT INTO events_01_user(event, aggregate_id, timestamp, md)
VALUES(event_in::text, aggregate_id, now(), md) RETURNING id INTO inserted_id;
return inserted_id;
END;
$$;


--
-- Name: aggregate_events_01_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aggregate_events_01_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_address (
    id integer DEFAULT nextval('public.aggregate_events_01_address_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_cartitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_cartitem (
    id integer DEFAULT nextval('public.aggregate_events_01_cartitem_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_category (
    id integer DEFAULT nextval('public.aggregate_events_01_category_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_image (
    id integer DEFAULT nextval('public.aggregate_events_01_image_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_order (
    id integer DEFAULT nextval('public.aggregate_events_01_order_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_orderitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_orderitem (
    id integer DEFAULT nextval('public.aggregate_events_01_orderitem_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_producttype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_producttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_producttype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_producttype (
    id integer DEFAULT nextval('public.aggregate_events_01_producttype_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_producttypetype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_producttypetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_producttypetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_producttypetype (
    id integer DEFAULT nextval('public.aggregate_events_01_producttypetype_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_productvariant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_productvariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_productvariant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_productvariant (
    id integer DEFAULT nextval('public.aggregate_events_01_productvariant_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: aggregate_events_01_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.aggregate_events_01_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aggregate_events_01_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aggregate_events_01_user (
    id integer DEFAULT nextval('public.aggregate_events_01_user_id_seq'::regclass) NOT NULL,
    aggregate_id uuid NOT NULL,
    event_id integer
);


--
-- Name: events_01_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_address (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_address ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_cartitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_cartitem (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_cartitem ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_category (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_image (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_image ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_order (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_order ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_orderitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_orderitem (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_orderitem ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_producttype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_producttype (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_producttype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_producttype ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_producttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_producttypetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_producttypetype (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_producttypetype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_producttypetype ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_producttypetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_productvariant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_productvariant (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_productvariant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_productvariant ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_productvariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: events_01_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events_01_user (
    id integer NOT NULL,
    aggregate_id uuid NOT NULL,
    event text NOT NULL,
    published boolean DEFAULT false NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    md text
);


--
-- Name: events_01_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.events_01_user ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_01_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(128) NOT NULL
);


--
-- Name: snapshots_01_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_address (
    id integer DEFAULT nextval('public.snapshots_01_address_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_cartitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_cartitem (
    id integer DEFAULT nextval('public.snapshots_01_cartitem_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_category (
    id integer DEFAULT nextval('public.snapshots_01_category_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_image (
    id integer DEFAULT nextval('public.snapshots_01_image_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_order (
    id integer DEFAULT nextval('public.snapshots_01_order_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_orderitem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_orderitem (
    id integer DEFAULT nextval('public.snapshots_01_orderitem_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_producttype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_producttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_producttype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_producttype (
    id integer DEFAULT nextval('public.snapshots_01_producttype_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_producttypetype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_producttypetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_producttypetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_producttypetype (
    id integer DEFAULT nextval('public.snapshots_01_producttypetype_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_productvariant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_productvariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_productvariant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_productvariant (
    id integer DEFAULT nextval('public.snapshots_01_productvariant_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: snapshots_01_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.snapshots_01_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snapshots_01_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.snapshots_01_user (
    id integer DEFAULT nextval('public.snapshots_01_user_id_seq'::regclass) NOT NULL,
    snapshot text NOT NULL,
    event_id integer,
    aggregate_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: aggregate_events_01_address aggregate_events_01_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_address
    ADD CONSTRAINT aggregate_events_01_address_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_cartitem aggregate_events_01_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_cartitem
    ADD CONSTRAINT aggregate_events_01_cartitem_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_category aggregate_events_01_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_category
    ADD CONSTRAINT aggregate_events_01_category_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_image aggregate_events_01_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_image
    ADD CONSTRAINT aggregate_events_01_image_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_order aggregate_events_01_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_order
    ADD CONSTRAINT aggregate_events_01_order_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_orderitem aggregate_events_01_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_orderitem
    ADD CONSTRAINT aggregate_events_01_orderitem_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_producttype aggregate_events_01_producttype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_producttype
    ADD CONSTRAINT aggregate_events_01_producttype_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_producttypetype aggregate_events_01_producttypetype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_producttypetype
    ADD CONSTRAINT aggregate_events_01_producttypetype_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_productvariant aggregate_events_01_productvariant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_productvariant
    ADD CONSTRAINT aggregate_events_01_productvariant_pkey PRIMARY KEY (id);


--
-- Name: aggregate_events_01_user aggregate_events_01_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_user
    ADD CONSTRAINT aggregate_events_01_user_pkey PRIMARY KEY (id);


--
-- Name: events_01_address events_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_address
    ADD CONSTRAINT events_address_pkey PRIMARY KEY (id);


--
-- Name: events_01_cartitem events_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_cartitem
    ADD CONSTRAINT events_cartitem_pkey PRIMARY KEY (id);


--
-- Name: events_01_category events_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_category
    ADD CONSTRAINT events_category_pkey PRIMARY KEY (id);


--
-- Name: events_01_image events_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_image
    ADD CONSTRAINT events_image_pkey PRIMARY KEY (id);


--
-- Name: events_01_order events_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_order
    ADD CONSTRAINT events_order_pkey PRIMARY KEY (id);


--
-- Name: events_01_orderitem events_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_orderitem
    ADD CONSTRAINT events_orderitem_pkey PRIMARY KEY (id);


--
-- Name: events_01_producttype events_producttype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_producttype
    ADD CONSTRAINT events_producttype_pkey PRIMARY KEY (id);


--
-- Name: events_01_producttypetype events_producttypetype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_producttypetype
    ADD CONSTRAINT events_producttypetype_pkey PRIMARY KEY (id);


--
-- Name: events_01_productvariant events_productvariant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_productvariant
    ADD CONSTRAINT events_productvariant_pkey PRIMARY KEY (id);


--
-- Name: events_01_user events_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events_01_user
    ADD CONSTRAINT events_user_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: snapshots_01_address snapshots_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_address
    ADD CONSTRAINT snapshots_address_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_cartitem snapshots_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_cartitem
    ADD CONSTRAINT snapshots_cartitem_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_category snapshots_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_category
    ADD CONSTRAINT snapshots_category_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_image snapshots_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_image
    ADD CONSTRAINT snapshots_image_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_order snapshots_order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_order
    ADD CONSTRAINT snapshots_order_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_orderitem snapshots_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_orderitem
    ADD CONSTRAINT snapshots_orderitem_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_producttype snapshots_producttype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_producttype
    ADD CONSTRAINT snapshots_producttype_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_producttypetype snapshots_producttypetype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_producttypetype
    ADD CONSTRAINT snapshots_producttypetype_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_productvariant snapshots_productvariant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_productvariant
    ADD CONSTRAINT snapshots_productvariant_pkey PRIMARY KEY (id);


--
-- Name: snapshots_01_user snapshots_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_user
    ADD CONSTRAINT snapshots_user_pkey PRIMARY KEY (id);


--
-- Name: ix_01_aggregate_events_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_address_id ON public.aggregate_events_01_address USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_cartitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_cartitem_id ON public.aggregate_events_01_cartitem USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_category_id ON public.aggregate_events_01_category USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_image_id ON public.aggregate_events_01_image USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_order_id ON public.aggregate_events_01_order USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_orderitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_orderitem_id ON public.aggregate_events_01_orderitem USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_producttype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_producttype_id ON public.aggregate_events_01_producttype USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_producttypetype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_producttypetype_id ON public.aggregate_events_01_producttypetype USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_productvariant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_productvariant_id ON public.aggregate_events_01_productvariant USING btree (aggregate_id);


--
-- Name: ix_01_aggregate_events_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_aggregate_events_user_id ON public.aggregate_events_01_user USING btree (aggregate_id);


--
-- Name: ix_01_events_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_address_id ON public.events_01_address USING btree (aggregate_id);


--
-- Name: ix_01_events_cartitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_cartitem_id ON public.events_01_cartitem USING btree (aggregate_id);


--
-- Name: ix_01_events_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_category_id ON public.events_01_category USING btree (aggregate_id);


--
-- Name: ix_01_events_category_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_category_timestamp ON public.events_01_category USING btree ("timestamp");


--
-- Name: ix_01_events_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_image_id ON public.events_01_image USING btree (aggregate_id);


--
-- Name: ix_01_events_image_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_image_timestamp ON public.events_01_image USING btree ("timestamp");


--
-- Name: ix_01_events_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_order_id ON public.events_01_order USING btree (aggregate_id);


--
-- Name: ix_01_events_order_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_order_timestamp ON public.events_01_order USING btree ("timestamp");


--
-- Name: ix_01_events_orderitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_orderitem_id ON public.events_01_orderitem USING btree (aggregate_id);


--
-- Name: ix_01_events_orderitem_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_orderitem_timestamp ON public.events_01_orderitem USING btree ("timestamp");


--
-- Name: ix_01_events_product_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_product_timestamp ON public.events_01_producttype USING btree ("timestamp");


--
-- Name: ix_01_events_producttype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_producttype_id ON public.events_01_producttype USING btree (aggregate_id);


--
-- Name: ix_01_events_producttype_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_producttype_timestamp ON public.events_01_producttypetype USING btree ("timestamp");


--
-- Name: ix_01_events_producttypetype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_producttypetype_id ON public.events_01_producttypetype USING btree (aggregate_id);


--
-- Name: ix_01_events_productvariant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_productvariant_id ON public.events_01_productvariant USING btree (aggregate_id);


--
-- Name: ix_01_events_productvariant_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_productvariant_timestamp ON public.events_01_productvariant USING btree ("timestamp");


--
-- Name: ix_01_events_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_user_id ON public.events_01_user USING btree (aggregate_id);


--
-- Name: ix_01_events_user_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_events_user_timestamp ON public.events_01_user USING btree ("timestamp");


--
-- Name: ix_01_snapshot_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_address_id ON public.snapshots_01_address USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_cartitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_cartitem_id ON public.snapshots_01_cartitem USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_category_id ON public.snapshots_01_category USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_image_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_image_id ON public.snapshots_01_image USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_order_id ON public.snapshots_01_order USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_orderitem_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_orderitem_id ON public.snapshots_01_orderitem USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_producttype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_producttype_id ON public.snapshots_01_producttype USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_producttypetype_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_producttypetype_id ON public.snapshots_01_producttypetype USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_productvariant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_productvariant_id ON public.snapshots_01_productvariant USING btree (aggregate_id);


--
-- Name: ix_01_snapshot_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshot_user_id ON public.snapshots_01_user USING btree (aggregate_id);


--
-- Name: ix_01_snapshots_category_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_category_timestamp ON public.snapshots_01_category USING btree ("timestamp");


--
-- Name: ix_01_snapshots_image_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_image_timestamp ON public.snapshots_01_image USING btree ("timestamp");


--
-- Name: ix_01_snapshots_order_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_order_timestamp ON public.snapshots_01_order USING btree ("timestamp");


--
-- Name: ix_01_snapshots_orderitem_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_orderitem_timestamp ON public.snapshots_01_orderitem USING btree ("timestamp");


--
-- Name: ix_01_snapshots_product_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_product_timestamp ON public.snapshots_01_producttype USING btree ("timestamp");


--
-- Name: ix_01_snapshots_producttype_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_producttype_timestamp ON public.snapshots_01_producttypetype USING btree ("timestamp");


--
-- Name: ix_01_snapshots_productvariant_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_productvariant_timestamp ON public.snapshots_01_productvariant USING btree ("timestamp");


--
-- Name: ix_01_snapshots_user_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_01_snapshots_user_timestamp ON public.snapshots_01_user USING btree ("timestamp");


--
-- Name: aggregate_events_01_address aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_address
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_address(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_cartitem aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_cartitem
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_cartitem(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_category aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_category
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_category(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_image aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_image
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_image(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_order aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_order
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_order(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_orderitem aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_orderitem
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_orderitem(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_producttype aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_producttype
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_producttype(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_producttypetype aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_producttypetype
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_producttypetype(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_productvariant aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_productvariant
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_productvariant(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: aggregate_events_01_user aggregate_events_01_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aggregate_events_01_user
    ADD CONSTRAINT aggregate_events_01_fk FOREIGN KEY (event_id) REFERENCES public.events_01_user(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_address event_01_address_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_address
    ADD CONSTRAINT event_01_address_fk FOREIGN KEY (event_id) REFERENCES public.events_01_address(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_cartitem event_01_cartitem_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_cartitem
    ADD CONSTRAINT event_01_cartitem_fk FOREIGN KEY (event_id) REFERENCES public.events_01_cartitem(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_category event_01_category_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_category
    ADD CONSTRAINT event_01_category_fk FOREIGN KEY (event_id) REFERENCES public.events_01_category(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_image event_01_image_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_image
    ADD CONSTRAINT event_01_image_fk FOREIGN KEY (event_id) REFERENCES public.events_01_image(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_order event_01_order_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_order
    ADD CONSTRAINT event_01_order_fk FOREIGN KEY (event_id) REFERENCES public.events_01_order(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_orderitem event_01_orderitem_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_orderitem
    ADD CONSTRAINT event_01_orderitem_fk FOREIGN KEY (event_id) REFERENCES public.events_01_orderitem(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_producttype event_01_producttype_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_producttype
    ADD CONSTRAINT event_01_producttype_fk FOREIGN KEY (event_id) REFERENCES public.events_01_producttype(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_producttypetype event_01_producttypetype_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_producttypetype
    ADD CONSTRAINT event_01_producttypetype_fk FOREIGN KEY (event_id) REFERENCES public.events_01_producttypetype(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_productvariant event_01_productvariant_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_productvariant
    ADD CONSTRAINT event_01_productvariant_fk FOREIGN KEY (event_id) REFERENCES public.events_01_productvariant(id) MATCH FULL ON DELETE CASCADE;


--
-- Name: snapshots_01_user event_01_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.snapshots_01_user
    ADD CONSTRAINT event_01_user_fk FOREIGN KEY (event_id) REFERENCES public.events_01_user(id) MATCH FULL ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20250913094124'),
    ('20250913094134'),
    ('20250913094143'),
    ('20250913094150'),
    ('20250913094156'),
    ('20250913094202'),
    ('20250913094208'),
    ('20250913094214'),
    ('20250913094236'),
    ('20250913094241');
