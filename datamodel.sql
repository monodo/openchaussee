--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.0
-- Started on 2017-11-17 15:46:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 305423937)
-- Name: chaussee_dev; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA chaussee_dev;


--
-- TOC entry 7 (class 2615 OID 116238101)
-- Name: mistra; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA mistra;


SET search_path = chaussee_dev, pg_catalog;

--
-- TOC entry 1373 (class 1255 OID 315022459)
-- Name: timestamp_fct(); Type: FUNCTION; Schema: chaussee_dev; Owner: -
--

CREATE FUNCTION timestamp_fct() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
  NEW.cgm_updatedate = now();
  RETURN NEW;
END$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 296 (class 1259 OID 315105537)
-- Name: t_axissegments; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_axissegments (
    asg_iliid text NOT NULL,
    asg_axe_iliid text,
    asg_capturemethod_cat_iliid text,
    asg_capturedate date,
    asg_accuracyhorizontal real,
    asg_accuracyvertical real,
    asg_name character varying(64),
    asg_sequence smallint,
    asg_importdate date,
    asg_geom public.geometry,
    CONSTRAINT enforce_dims_asg_geom CHECK ((public.st_ndims(asg_geom) = 4)),
    CONSTRAINT enforce_geotype_asg_geom CHECK (((public.geometrytype(asg_geom) = 'MULTILINESTRING'::text) OR (asg_geom IS NULL))),
    CONSTRAINT enforce_srid_asg_geom CHECK ((public.st_srid(asg_geom) = 2056))
);


--
-- TOC entry 280 (class 1259 OID 305458061)
-- Name: t_current_geometries; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_current_geometries (
    cgm_iliid text NOT NULL,
    cgm_geom public.geometry(Polygon,2056),
    cgm_asg_iliid text,
    cgm_calcul_length numeric(10,2),
    cgm_calcul_area numeric(10,2),
    cgm_updatedate timestamp without time zone NOT NULL,
    cgm_updateuser character varying(36) NOT NULL,
    cgm_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3889 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE t_current_geometries; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_current_geometries IS 'Géométrie de la chaussée';


--
-- TOC entry 3890 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_iliid IS 'Identifiant interne';


--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_geom; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_geom IS 'Polygones "libres", pas multipolygone, pas de trou.';


--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_asg_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_asg_iliid IS 'Segment d''axe concerné';


--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_calcul_length IS 'Longueur SRB de la couche (Calculé)';


--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_calcul_area IS 'Surface SRB de la couche (Calculé)';


--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN t_current_geometries.cgm_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries.cgm_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 298 (class 1259 OID 315223579)
-- Name: t_current_geometries_v1; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_current_geometries_v1 (
    cgm_iliid text NOT NULL,
    cgm_asg_iliid text,
    cgm_calcul_length numeric(10,2),
    cgm_calcul_area numeric(10,2),
    cgm_start_date date,
    cgm_end_date date,
    cgm_createdate timestamp without time zone DEFAULT now(),
    cgm_updatedate timestamp without time zone DEFAULT now() NOT NULL,
    cgm_updateuser character varying(36) NOT NULL,
    cgm_statut boolean DEFAULT true NOT NULL,
    cgm_geom public.geometry(Polygon,2056),
    cgm_line_geom public.geometry(LineString,2056)
);


--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE t_current_geometries_v1; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_current_geometries_v1 IS 'Géométrie de la chaussée';


--
-- TOC entry 3899 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_iliid IS 'Identifiant interne';


--
-- TOC entry 3900 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_asg_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_asg_iliid IS 'Référence point linéaire fin de la géométrie actuelle';


--
-- TOC entry 3901 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_calcul_length IS 'Longueur SRB de la couche (Calculé)';


--
-- TOC entry 3902 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_calcul_area IS 'Surface SRB de la couche (Calculé)';


--
-- TOC entry 3903 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_start_date; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_start_date IS 'Date de début de validité de la géométrie actuelle';


--
-- TOC entry 3904 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_end_date; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_end_date IS 'Date de fin de validité de la géométrie actuelle';


--
-- TOC entry 3905 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_createdate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_createdate IS 'Date de création de la géométrie actuelle (système)';


--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_updatedate IS 'Date de la mise à jour (système)';


--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 3909 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN t_current_geometries_v1.cgm_geom; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_geometries_v1.cgm_geom IS 'Polygones "libres", pas multipolygone, pas de trou.';


--
-- TOC entry 282 (class 1259 OID 306243170)
-- Name: t_current_views; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_current_views (
    cuv_iliid text NOT NULL,
    cuv_geom public.geometry(MultiPolygon,2056),
    cuv_start_sec_iliid text,
    cuv_start_u double precision,
    cuv_end_sec_iliid text,
    cuv_end_u double precision,
    cuv_lay_iliid text,
    cuv_posedate date,
    cuv_thickness real,
    cuv_depth real,
    cuv_pro_iliid text,
    cuv_pvl_iliid text,
    cuv_calcul_length numeric(10,2),
    cuv_calcul_area numeric(10,2),
    cuv_updatedate timestamp without time zone NOT NULL,
    cuv_updateuser character varying(36) NOT NULL,
    cuv_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3910 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE t_current_views; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_current_views IS 'Découpage des couches de structure pour la vue actuelle';


--
-- TOC entry 3911 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_iliid IS 'Identifiant interne';


--
-- TOC entry 3912 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_geom; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_geom IS 'polygone avec trou';


--
-- TOC entry 3913 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_pvl_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_pvl_iliid IS 'Couche d''origine';


--
-- TOC entry 3914 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_calcul_length IS 'Longueur SRB de la couche (Calculé)';


--
-- TOC entry 3915 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_calcul_area IS 'Surface SRB de la couche (Calculé)';


--
-- TOC entry 3916 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3917 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_updateuser IS 'Auteur de la mise à jour  (système)';


--
-- TOC entry 3918 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN t_current_views.cuv_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_current_views.cuv_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 268 (class 1259 OID 305423953)
-- Name: t_layers; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_layers (
    lay_iliid text NOT NULL,
    lay_shortname character varying(36),
    lay_name character varying(72),
    lay_layer character varying(128),
    lay_material character varying(128),
    lay_remark character varying(255),
    lay_updatedate timestamp without time zone NOT NULL,
    lay_updateuser character varying(36) NOT NULL,
    lay_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3919 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE t_layers; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_layers IS 'Catalogue des types de couche';


--
-- TOC entry 3920 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_iliid IS 'Identifiant interne';


--
-- TOC entry 3921 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_shortname IS 'Abréviation. (AB6,''AC11L, HMTxxx,...) ';


--
-- TOC entry 3922 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_name; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_name IS 'Libellé selon cat MISTRA (ex : AC 8S, avec polymères, C. de roulement)';


--
-- TOC entry 3923 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_layer; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_layer IS 'Couche (ex : RO  Couche de roulement)';


--
-- TOC entry 3924 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_material; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_material IS 'Sorte de matériau (ex:  Béton bitumineux AC)';


--
-- TOC entry 3925 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_remark; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_remark IS 'Remarques';


--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3927 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3928 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN t_layers.lay_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_layers.lay_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 269 (class 1259 OID 305423960)
-- Name: t_methods; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_methods (
    mtd_iliid text NOT NULL,
    mtd_shortname character varying(36),
    mtd_name character varying(100),
    mtd_characteristic character varying(128),
    mtd_remark character varying(256),
    mtd_updatedate timestamp without time zone NOT NULL,
    mtd_updateuser character varying(36) NOT NULL,
    mtd_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3929 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE t_methods; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_methods IS 'Catalogue des types de méthode de relevé';


--
-- TOC entry 3930 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_iliid IS 'Identifiant interne';


--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_shortname IS 'Abbréviation';


--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_name; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_name IS 'Nom';


--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_characteristic; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_characteristic IS 'Caractéristique de la chaussée (I1, I2, etc..)';


--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_remark; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_remark IS 'Remarque';


--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_updateuser IS 'Auteur de la mise à jour';


--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN t_methods.mtd_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_methods.mtd_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 270 (class 1259 OID 305423967)
-- Name: t_pavement_layers; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_pavement_layers (
    pvl_iliid text NOT NULL,
    pvl_geom public.geometry(Polygon,2056),
    pvl_start_sec_iliid text,
    pvl_start_u double precision,
    pvl_end_sec_iliid text,
    pvl_end_u double precision,
    pvl_lay_iliid text,
    pvl_posedate date,
    pvl_thickness real,
    pvl_depth real,
    pvl_pro_iliid text,
    pvl_remark character varying(256),
    pvl_calcul_length numeric(10,2),
    pvl_calcul_area numeric(10,2),
    pvl_updatedate timestamp without time zone NOT NULL,
    pvl_updateuser character varying(36) NOT NULL,
    pvl_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE t_pavement_layers; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_pavement_layers IS 'Couches de structure';


--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_iliid IS 'Identifiant interne';


--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_geom; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_geom IS 'Polygones libres, pas multipolygone, pas de trou';


--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_start_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_start_sec_iliid IS 'PR début';


--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_start_u; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_start_u IS 'Distance U au PR début [m]';


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_end_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_end_sec_iliid IS 'PR fin';


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_end_u; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_end_u IS 'Distance U au PR fin [m]';


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_lay_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_lay_iliid IS 'Type de couche. Pour le prototype, une liste de valeurs qui se trouivent dans la table Type Couches';


--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_posedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_posedate IS 'Date de pose';


--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_thickness; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_thickness IS 'Epaisseur [cm]';


--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_depth; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_depth IS 'Profondeur de fraisage [cm]';


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_pro_iliid IS 'Projet';


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_remark; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_remark IS 'Remarques';


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_calcul_length IS 'Longueur SRB de la couche (Calculé)';


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_calcul_area IS 'Surface SRB de la couche (Calculé)';


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN t_pavement_layers.pvl_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_pavement_layers.pvl_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 295 (class 1259 OID 314632185)
-- Name: t_point_location; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_point_location (
    ptl_iliid text NOT NULL,
    ptl_geom public.geometry(Point,2056),
    ptl_sec_iliid text,
    ptl_u double precision,
    ptl_m double precision,
    ptl_createdate timestamp without time zone DEFAULT now(),
    ptl_updatedate timestamp without time zone NOT NULL,
    ptl_updateuser character varying(36) NOT NULL,
    ptl_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE t_point_location; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_point_location IS 'Point de référencement linéaire SRB des objets pvl, rco et cgm';


--
-- TOC entry 271 (class 1259 OID 305423974)
-- Name: t_projects; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_projects (
    pro_iliid text NOT NULL,
    pro_year integer,
    pro_shortname character varying(36),
    pro_name character varying(72),
    pro_typname character varying(128),
    pro_remark character varying(256),
    pro_updatedate timestamp without time zone NOT NULL,
    pro_updateuser character varying(36) NOT NULL,
    pro_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE t_projects; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_projects IS 'Catalogue des projets';


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_iliid IS 'Identifiant interne';


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_year; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_year IS 'Année';


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_shortname IS 'Abbréviation';


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_name; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_name IS 'Nom';


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_typname; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_typname IS 'Type de projet';


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_remark; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_remark IS 'Remarques';


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3965 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3966 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN t_projects.pro_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_projects.pro_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 272 (class 1259 OID 305423981)
-- Name: t_road_controls; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_road_controls (
    rco_iliid text NOT NULL,
    rco_geom public.geometry(LineString,2056),
    rco_start_sec_iliid text,
    rco_start_u double precision,
    rco_end_sec_iliid text,
    rco_end_u double precision,
    rco_traffic_lane integer,
    rco_mtd_iliid text,
    rco_statementdate date,
    rco_value_1 real,
    rco_value_2 real,
    rco_value_3 real,
    rco_pro_iliid text,
    rco_note real,
    rco_remark character varying(256),
    rco_updatedate timestamp without time zone NOT NULL,
    rco_updateuser character varying(36) NOT NULL,
    rco_statut boolean DEFAULT true NOT NULL
);


--
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE t_road_controls; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON TABLE t_road_controls IS 'Etats de la chaussée relevé';


--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_iliid IS 'Identifiant interne';


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_geom; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_geom IS 'Ligne superposée à la géométrie du segment d''axe';


--
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_start_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_start_sec_iliid IS 'PR début';


--
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_start_u; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_start_u IS 'Distance U au PR début [m]';


--
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_end_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_end_sec_iliid IS 'PR fin';


--
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_end_u; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_end_u IS 'Distance U au PR fin [m]';


--
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_traffic_lane; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_traffic_lane IS 'Numéro de voie. Idem MISTRA.  -2; -1; 0; 1; 2';


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_mtd_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_mtd_iliid IS 'Type de méthode';


--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_statementdate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_statementdate IS 'Date du relevé';


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_value_1; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_value_1 IS 'Première valeur';


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_value_2; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_value_2 IS 'Deuxième valeur';


--
-- TOC entry 3979 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_value_3; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_value_3 IS 'Troisième valeur';


--
-- TOC entry 3980 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_pro_iliid IS 'Projet';


--
-- TOC entry 3981 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_note; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_note IS 'Note (fonction règle)';


--
-- TOC entry 3982 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_remark; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_remark IS 'Remarques';


--
-- TOC entry 3983 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_updatedate IS 'Date de la mise à jour, la création est une mise à jour (système)';


--
-- TOC entry 3984 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_updateuser IS 'Auteur de la mise à jour (système)';


--
-- TOC entry 3985 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN t_road_controls.rco_statut; Type: COMMENT; Schema: chaussee_dev; Owner: -
--

COMMENT ON COLUMN t_road_controls.rco_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 297 (class 1259 OID 315161891)
-- Name: t_sectors; Type: TABLE; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE TABLE t_sectors (
    sec_iliid text NOT NULL,
    sec_sequence double precision,
    sec_name character varying(64),
    sec_length double precision,
    sec_km double precision,
    sec_marker_cat_iliid text,
    sec_markeraccuracyhorizontal real,
    sec_markeraccuracyvertical real,
    sec_markerdescription character varying(256),
    sec_mat_cat_iliid text,
    sec_mataccuracyvertical real,
    sec_mataccuracyhorizontal real,
    sec_mat_v real,
    sec_matdescription character varying(256),
    sec_platetyp_cat_iliid text,
    sec_platelabel_cat_iliid text,
    sec_platefixation_cat_iliid text,
    sec_platelocation_cat_iliid text,
    sec_platelocationaccess character varying(1),
    sec_platetext character varying(256),
    sec_plate_u double precision,
    sec_plate_v real,
    sec_asg_iliid text,
    sec_importdate date,
    sec_refpoint_geom public.geometry,
    sec_line_geom public.geometry,
    CONSTRAINT enforce_dims_sec_refpoint_geom CHECK ((public.st_ndims(sec_refpoint_geom) = 3)),
    CONSTRAINT enforce_geotype_sec_refpoint_geom CHECK (((public.geometrytype(sec_refpoint_geom) = 'POINT'::text) OR (sec_refpoint_geom IS NULL))),
    CONSTRAINT enforce_srid_sec_refpoint_geom CHECK ((public.st_srid(sec_refpoint_geom) = 2056))
);


SET search_path = mistra, pg_catalog;

--
-- TOC entry 209 (class 1259 OID 116239504)
-- Name: NE_OATE; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE "NE_OATE" (
    comments character varying(256),
    xtf_id text
);


--
-- TOC entry 210 (class 1259 OID 116239510)
-- Name: cahiers_srb; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE cahiers_srb (
    pdf character(12),
    axe character(13) NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 116239513)
-- Name: t_axis; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_axis (
    axe_iliid text NOT NULL,
    axe_typ_cat_iliid text,
    axe_status_cat_iliid text,
    axe_owner character varying(12),
    axe_dba_iliid text,
    axe_name character varying(64),
    axe_namelong character varying(256),
    axe_positioncode character varying(1),
    axe_versionvalidfrom date,
    axe_versionvalidto date,
    axe_objectvalidfrom date,
    axe_objectvalidto date,
    axe_importdate date
);


--
-- TOC entry 212 (class 1259 OID 116239519)
-- Name: t_axissegments; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_axissegments (
    asg_iliid text NOT NULL,
    asg_axe_iliid text,
    asg_capturemethod_cat_iliid text,
    asg_capturedate date,
    asg_accuracyhorizontal real,
    asg_accuracyvertical real,
    asg_name character varying(64),
    asg_sequence smallint,
    asg_importdate date,
    asg_geom public.geometry,
    CONSTRAINT enforce_dims_asg_geom CHECK ((public.st_ndims(asg_geom) = 4)),
    CONSTRAINT enforce_geotype_asg_geom CHECK (((public.geometrytype(asg_geom) = 'MULTILINESTRING'::text) OR (asg_geom IS NULL))),
    CONSTRAINT enforce_srid_asg_geom CHECK ((public.st_srid(asg_geom) = 2056))
);


--
-- TOC entry 213 (class 1259 OID 116239528)
-- Name: t_sectors; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_sectors (
    sec_iliid text NOT NULL,
    sec_sequence double precision,
    sec_name character varying(64),
    sec_length double precision,
    sec_km double precision,
    sec_marker_cat_iliid text,
    sec_markeraccuracyhorizontal real,
    sec_markeraccuracyvertical real,
    sec_markerdescription character varying(256),
    sec_mat_cat_iliid text,
    sec_mataccuracyvertical real,
    sec_mataccuracyhorizontal real,
    sec_mat_v real,
    sec_matdescription character varying(256),
    sec_platetyp_cat_iliid text,
    sec_platelabel_cat_iliid text,
    sec_platefixation_cat_iliid text,
    sec_platelocation_cat_iliid text,
    sec_platelocationaccess character varying(1),
    sec_platetext character varying(256),
    sec_plate_u double precision,
    sec_plate_v real,
    sec_asg_iliid text,
    sec_importdate date,
    sec_geom public.geometry,
    CONSTRAINT enforce_dims_sec_geom CHECK ((public.st_ndims(sec_geom) = 3)),
    CONSTRAINT enforce_geotype_sec_geom CHECK (((public.geometrytype(sec_geom) = 'POINT'::text) OR (sec_geom IS NULL))),
    CONSTRAINT enforce_srid_sec_geom CHECK ((public.st_srid(sec_geom) = 2056))
);


--
-- TOC entry 214 (class 1259 OID 116239537)
-- Name: rt10_axes_nationaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt10_axes_nationaux AS
 SELECT sub1.asg_geom,
    sub1.asg_sign,
    sub1.asg_iliid,
    sub1.axe_owner,
    sub1.axe_name,
    sub1.axe_positioncode,
    sub1.asg_name,
    sub1.axe_namelong,
    sub2.sec_asg_iliid,
    sub2.total_sec_length
   FROM ( SELECT t_axissegments.asg_geom,
                CASE
                    WHEN ((t_axis.axe_positioncode)::bpchar = '='::bpchar) THEN 'pas de sens ='::text
                    WHEN ((t_axis.axe_positioncode)::bpchar = '-'::bpchar) THEN 'sens négatif -'::text
                    WHEN ((t_axis.axe_positioncode)::bpchar = '+'::bpchar) THEN 'sens positif +'::text
                    ELSE NULL::text
                END AS asg_sign,
            t_axissegments.asg_iliid,
            t_axis.axe_owner,
            t_axis.axe_name,
            t_axis.axe_positioncode,
            t_axissegments.asg_name,
            t_axis.axe_namelong
           FROM t_axissegments,
            t_axis
          WHERE (t_axissegments.asg_axe_iliid = t_axis.axe_iliid)) sub1,
    ( SELECT t_sectors.sec_asg_iliid,
            sum(t_sectors.sec_length) AS total_sec_length
           FROM t_sectors
          GROUP BY t_sectors.sec_asg_iliid) sub2
  WHERE ((sub1.asg_iliid = sub2.sec_asg_iliid) AND ((sub1.axe_owner)::bpchar = 'CH'::bpchar));


--
-- TOC entry 215 (class 1259 OID 116239542)
-- Name: rt11_axes_cantonaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt11_axes_cantonaux AS
 SELECT t_axissegments.asg_axe_iliid,
    t_axissegments.asg_capturemethod_cat_iliid,
    t_axissegments.asg_capturedate,
    t_axissegments.asg_accuracyhorizontal,
    t_axissegments.asg_accuracyvertical,
    t_axissegments.asg_sequence,
    t_axissegments.asg_importdate,
    sub3.asg_geom,
    sub3.asg_sign,
    sub3.asg_iliid,
    sub3.axe_owner,
    sub3.axe_name,
    sub3.axe_positioncode,
    sub3.asg_name,
    sub3.axe_namelong,
    sub3.sec_asg_iliid,
    sub3.total_sec_length,
    cahiers_srb.pdf AS cahier_srb,
    (((('<a href="https://sitnintra.ne.ch/projects/spch/cahiers_srb/'::text || (cahiers_srb.pdf)::text) || '" target="_blank">'::text) || (cahiers_srb.pdf)::text) || '</a>'::text) AS pdflink
   FROM ( SELECT sub1.asg_geom,
            sub1.asg_sign,
            sub1.asg_iliid,
            sub1.axe_owner,
            sub1.axe_name,
            sub1.axe_positioncode,
            sub1.asg_name,
            sub1.axe_namelong,
            sub2.sec_asg_iliid,
            sub2.total_sec_length
           FROM ( SELECT t_axissegments_1.asg_geom,
                        CASE
                            WHEN ((t_axis.axe_positioncode)::bpchar = '='::bpchar) THEN 'pas de sens ='::text
                            WHEN ((t_axis.axe_positioncode)::bpchar = '-'::bpchar) THEN 'sens négatif -'::text
                            WHEN ((t_axis.axe_positioncode)::bpchar = '+'::bpchar) THEN 'sens positif +'::text
                            ELSE NULL::text
                        END AS asg_sign,
                    t_axissegments_1.asg_iliid,
                    t_axis.axe_owner,
                    t_axis.axe_name,
                    t_axis.axe_positioncode,
                    t_axissegments_1.asg_name,
                    t_axis.axe_namelong
                   FROM t_axissegments t_axissegments_1,
                    t_axis
                  WHERE (t_axissegments_1.asg_axe_iliid = t_axis.axe_iliid)) sub1,
            ( SELECT t_sectors.sec_asg_iliid,
                    sum(t_sectors.sec_length) AS total_sec_length
                   FROM t_sectors
                  GROUP BY t_sectors.sec_asg_iliid) sub2
          WHERE ((sub1.asg_iliid = sub2.sec_asg_iliid) AND ((sub1.axe_owner)::bpchar = 'NE'::bpchar))) sub3,
    (t_axissegments
     LEFT JOIN cahiers_srb ON ((cahiers_srb.axe = (t_axissegments.asg_name)::bpchar)))
  WHERE (t_axissegments.asg_iliid = sub3.asg_iliid);


--
-- TOC entry 216 (class 1259 OID 116239547)
-- Name: rt12_axes_communaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt12_axes_communaux AS
 SELECT sub1.asg_geom,
    sub1.asg_sign,
    sub1.asg_iliid,
    sub1.axe_owner,
    sub1.axe_name,
    sub1.axe_positioncode,
    sub1.asg_name,
    sub1.axe_namelong,
    sub2.sec_asg_iliid,
    sub2.total_sec_length
   FROM ( SELECT t_axissegments.asg_geom,
                CASE
                    WHEN ((t_axis.axe_positioncode)::bpchar = '='::bpchar) THEN 'pas de sens ='::text
                    WHEN ((t_axis.axe_positioncode)::bpchar = '-'::bpchar) THEN 'sens négatif -'::text
                    WHEN ((t_axis.axe_positioncode)::bpchar = '+'::bpchar) THEN 'sens positif +'::text
                    ELSE NULL::text
                END AS asg_sign,
            t_axissegments.asg_iliid,
            t_axis.axe_owner,
            t_axis.axe_name,
            t_axis.axe_positioncode,
            t_axissegments.asg_name,
            t_axis.axe_namelong
           FROM t_axissegments,
            t_axis
          WHERE (t_axissegments.asg_axe_iliid = t_axis.axe_iliid)) sub1,
    ( SELECT t_sectors.sec_asg_iliid,
            sum(t_sectors.sec_length) AS total_sec_length
           FROM t_sectors
          GROUP BY t_sectors.sec_asg_iliid) sub2
  WHERE (((sub1.asg_iliid = sub2.sec_asg_iliid) AND ((sub1.axe_owner)::bpchar <> 'CH'::bpchar)) AND ((sub1.axe_owner)::bpchar <> 'NE'::bpchar));


--
-- TOC entry 217 (class 1259 OID 116239552)
-- Name: rt13_secteurs_nationaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt13_secteurs_nationaux AS
 SELECT t_sectors.sec_geom,
    t_sectors.sec_sequence,
    t_sectors.sec_km,
    t_sectors.sec_iliid,
    t_sectors.sec_name,
    t_sectors.sec_length,
    t_sectors.sec_asg_iliid,
    t_axis.axe_name,
    t_axis.axe_owner,
    t_axissegments.asg_name,
    t_axissegments.asg_iliid,
        CASE
            WHEN ((t_sectors.sec_length <> (0)::double precision) AND (t_sectors.sec_sequence <> (0)::double precision)) THEN 0
            WHEN ((t_sectors.sec_length = (0)::double precision) OR (t_sectors.sec_sequence = (0)::double precision)) THEN 1
            ELSE NULL::integer
        END AS classification
   FROM t_sectors,
    t_axissegments,
    t_axis
  WHERE (((t_sectors.sec_asg_iliid = t_axissegments.asg_iliid) AND (t_axissegments.asg_axe_iliid = t_axis.axe_iliid)) AND ((t_axis.axe_owner)::bpchar = 'CH'::bpchar));


--
-- TOC entry 218 (class 1259 OID 116239557)
-- Name: rt14_secteurs_cantonaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt14_secteurs_cantonaux AS
 SELECT t_sectors.sec_geom,
    t_sectors.sec_sequence,
    t_sectors.sec_km,
    t_sectors.sec_iliid,
    t_sectors.sec_name,
    t_sectors.sec_length,
    t_sectors.sec_asg_iliid,
    t_axis.axe_name,
    t_axis.axe_owner,
    t_axissegments.asg_name,
        CASE
            WHEN ((t_sectors.sec_length <> (0)::double precision) AND (t_sectors.sec_sequence <> (0)::double precision)) THEN 0
            WHEN ((t_sectors.sec_length = (0)::double precision) OR (t_sectors.sec_sequence = (0)::double precision)) THEN 1
            ELSE NULL::integer
        END AS classification,
    t_axissegments.asg_iliid
   FROM t_sectors,
    t_axissegments,
    t_axis
  WHERE (((t_sectors.sec_asg_iliid = t_axissegments.asg_iliid) AND (t_axissegments.asg_axe_iliid = t_axis.axe_iliid)) AND ((t_axis.axe_owner)::bpchar = 'NE'::bpchar));


--
-- TOC entry 219 (class 1259 OID 116239562)
-- Name: rt15_secteurs_communaux; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW rt15_secteurs_communaux AS
 SELECT t_sectors.sec_geom,
    t_sectors.sec_sequence,
    t_sectors.sec_km,
    t_sectors.sec_iliid,
    t_sectors.sec_name,
    t_sectors.sec_length,
    t_sectors.sec_asg_iliid,
    t_axis.axe_name,
    t_axis.axe_owner,
    t_axissegments.asg_name,
        CASE
            WHEN ((t_sectors.sec_length <> (0)::double precision) AND (t_sectors.sec_sequence <> (0)::double precision)) THEN 0
            WHEN ((t_sectors.sec_length = (0)::double precision) OR (t_sectors.sec_sequence = (0)::double precision)) THEN 1
            ELSE NULL::integer
        END AS classification
   FROM t_sectors,
    t_axissegments,
    t_axis
  WHERE ((((t_sectors.sec_asg_iliid = t_axissegments.asg_iliid) AND (t_axissegments.asg_axe_iliid = t_axis.axe_iliid)) AND ((t_axis.axe_owner)::bpchar <> 'CH'::bpchar)) AND ((t_axis.axe_owner)::bpchar <> 'NE'::bpchar));


--
-- TOC entry 220 (class 1259 OID 116239567)
-- Name: t_calpoints; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_calpoints (
    cal_iliid text NOT NULL,
    cal_u double precision,
    cal_sec_iliid text,
    cal_importdate date,
    cal_geom public.geometry,
    CONSTRAINT enforce_dims_cal_geom CHECK ((public.st_ndims(cal_geom) = 3)),
    CONSTRAINT enforce_geotype_cal_geom CHECK (((public.geometrytype(cal_geom) = 'POINT'::text) OR (cal_geom IS NULL))),
    CONSTRAINT enforce_srid_cal_geom CHECK ((public.st_srid(cal_geom) = 2056))
);


--
-- TOC entry 221 (class 1259 OID 116239576)
-- Name: t_catalogs; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_catalogs (
    cat_iliid text NOT NULL,
    cat_owner character varying(12),
    cat_name character varying(36),
    cat_parent_cat_ilid text,
    cat_sort_nr integer,
    cat_createdate date,
    cat_modificationdate date,
    cat_deletedate date,
    cat_createuser character varying(36),
    cat_modificationuser character varying(36),
    cat_deleteuser character varying(36),
    cat_validfrom date,
    cat_validto date,
    cat_importdate date
);


--
-- TOC entry 222 (class 1259 OID 116239582)
-- Name: t_cattexts; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_cattexts (
    ctt_iliid text NOT NULL,
    ctt_cat_iliid text,
    ctt_language_id text,
    ctt_name character varying(128),
    ctt_shortname character varying(12),
    ctt_createdate date,
    ctt_modificationdate date,
    ctt_deletedate date,
    ctt_createuser character varying(36),
    ctt_modificationuser character varying(36),
    ctt_deleteuser character varying(36),
    ctt_importdate date
);


--
-- TOC entry 223 (class 1259 OID 116239588)
-- Name: t_civilengineerinstructures; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_civilengineerinstructures (
    ces_id text NOT NULL,
    ces_number character varying(12),
    ces_name character varying(128),
    ces_u double precision,
    ces_v real,
    ces_sec_ilid text,
    ces_year smallint,
    ces_total_length double precision,
    ces_total_width double precision,
    ces_length double precision,
    ces_height double precision,
    ces_width double precision,
    ces_template_height double precision,
    ces_template_width double precision,
    ces_maximum_load double precision,
    ces_importdate date,
    geom public.geometry,
    CONSTRAINT enforce_dims_geom CHECK ((public.st_ndims(geom) = 2)),
    CONSTRAINT enforce_geotype_geom CHECK (((public.geometrytype(geom) = 'POINT'::text) OR (geom IS NULL))),
    CONSTRAINT enforce_srid_geom CHECK ((public.st_srid(geom) = 2056))
);


--
-- TOC entry 224 (class 1259 OID 116239597)
-- Name: t_databases; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_databases (
    dba_iliid text NOT NULL,
    dba_name character varying(36) NOT NULL,
    dba_importdate date
);


--
-- TOC entry 225 (class 1259 OID 116239603)
-- Name: t_junctions; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_junctions (
    jnc_iliid text NOT NULL,
    jnc_owner character varying(12),
    jnc_dba_iliid text,
    jnc_name character varying(36),
    jnc_commonname character varying(32),
    jnc_versionid text,
    jnc_versionvalidfrom date,
    jnc_versionvalidto date,
    jnc_createdate date,
    jnc_modificationdate date,
    jnc_importdate date
);


--
-- TOC entry 226 (class 1259 OID 116239609)
-- Name: t_links; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_links (
    lnk_iliid text NOT NULL,
    lnk_dba_iliid text NOT NULL,
    lnk_net_iliid text NOT NULL,
    lnk_owner character varying(12) NOT NULL,
    lnk_versionid text NOT NULL,
    lnk_versionvalidfrom date NOT NULL,
    lnk_versionvalidto date,
    lnk_createdate date NOT NULL,
    lnk_modificationdate date,
    lnk_start_nlo_iliid text NOT NULL,
    lnk_end_nlo_iliid text NOT NULL,
    lnk_importdate date NOT NULL,
    lnk_geom public.geometry,
    CONSTRAINT enforce_dims_lnk_geom CHECK ((public.st_ndims(lnk_geom) = 2)),
    CONSTRAINT enforce_geotype_lnk_geom CHECK (((public.geometrytype(lnk_geom) = 'LINESTRING'::text) OR (lnk_geom IS NULL))),
    CONSTRAINT enforce_srid_lnk_geom CHECK ((public.st_srid(lnk_geom) = 2056))
);


--
-- TOC entry 227 (class 1259 OID 116239618)
-- Name: t_networks; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_networks (
    net_iliid text NOT NULL,
    net_typ_cat_iliid text NOT NULL,
    net_dba_iliid text NOT NULL,
    net_owner character varying(12) NOT NULL,
    net_name character varying(64) NOT NULL,
    net_versionvalidfrom date NOT NULL,
    net_versionvalidto date,
    net_objectvalidfrom date,
    net_objectvalidto date,
    net_importdate date NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 116239624)
-- Name: t_nodelocations; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_nodelocations (
    nlo_iliid text NOT NULL,
    nlo_dba_iliid text,
    nlo_versionid text,
    nlo_versionvalidfrom date,
    nlo_versionvalidto date,
    nlo_createdate date,
    nlo_modificationdate date,
    nlo_u double precision,
    nlo_v real,
    nlo_sec_iliid text,
    nlo_nod_iliid text,
    nlo_importdate date
);


--
-- TOC entry 229 (class 1259 OID 116239630)
-- Name: t_nodes; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_nodes (
    nod_iliid text NOT NULL,
    nod_typ_cat_iliid text,
    nod_jnc_iliid text,
    nod_dba_iliid text,
    nod_owner character varying(12),
    nod_name character varying(36),
    nod_commonname character varying(32),
    nod_level smallint,
    nod_parent_nod_ilid text,
    nod_versionid text,
    nod_versionvalidfrom date,
    nod_versionvalidto date,
    nod_createdate date,
    nod_modificationdate date,
    nod_importdate date,
    nod_geom public.geometry,
    CONSTRAINT enforce_dims_nod_geom CHECK ((public.st_ndims(nod_geom) = 2)),
    CONSTRAINT enforce_geotype_nod_geom CHECK (((public.geometrytype(nod_geom) = 'POINT'::text) OR (nod_geom IS NULL))),
    CONSTRAINT enforce_srid_nod_geom CHECK ((public.st_srid(nod_geom) = 2056))
);


--
-- TOC entry 230 (class 1259 OID 116239639)
-- Name: t_sections; Type: TABLE; Schema: mistra; Owner: -; Tablespace: 
--

CREATE TABLE t_sections (
    sct_iliid text NOT NULL,
    sct_dba_iliid text NOT NULL,
    sct_net_iliid text NOT NULL,
    sct_owner character varying(12) NOT NULL,
    sct_versionid text NOT NULL,
    sct_versionvalidfrom date NOT NULL,
    sct_versionvalidto date,
    sct_createdate date NOT NULL,
    sct_modificationdate date,
    sct_start_sec_iliid text NOT NULL,
    sct_start_u double precision NOT NULL,
    sct_start_v real,
    sct_end_sec_iliid text NOT NULL,
    sct_end_u double precision NOT NULL,
    sct_end_v real,
    sct_importdate date NOT NULL,
    sct_geom public.geometry,
    CONSTRAINT enforce_dims_sct_geom CHECK ((public.st_ndims(sct_geom) = 2)),
    CONSTRAINT enforce_geotype_sct_geom CHECK (((public.geometrytype(sct_geom) = 'LINESTRING'::text) OR (sct_geom IS NULL))),
    CONSTRAINT enforce_srid_sct_geom CHECK ((public.st_srid(sct_geom) = 2056))
);


--
-- TOC entry 231 (class 1259 OID 116239648)
-- Name: v_links_oate; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW v_links_oate AS
 SELECT t_links.lnk_iliid,
    t_links.lnk_dba_iliid,
    t_links.lnk_net_iliid,
    t_links.lnk_owner,
    t_links.lnk_versionid,
    t_links.lnk_versionvalidfrom,
    t_links.lnk_versionvalidto,
    t_links.lnk_createdate,
    t_links.lnk_modificationdate,
    t_links.lnk_start_nlo_iliid,
    t_links.lnk_end_nlo_iliid,
    t_links.lnk_importdate,
    t_links.lnk_geom,
    "NE_OATE".comments,
    "NE_OATE".xtf_id
   FROM t_links,
    "NE_OATE"
  WHERE ("NE_OATE".xtf_id = t_links.lnk_iliid);


--
-- TOC entry 232 (class 1259 OID 116239652)
-- Name: v_nodes_oate; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW v_nodes_oate AS
 SELECT t_nodes.nod_iliid,
    t_nodes.nod_typ_cat_iliid,
    t_nodes.nod_jnc_iliid,
    t_nodes.nod_dba_iliid,
    t_nodes.nod_owner,
    t_nodes.nod_name,
    t_nodes.nod_commonname,
    t_nodes.nod_level,
    t_nodes.nod_parent_nod_ilid,
    t_nodes.nod_versionid,
    t_nodes.nod_versionvalidfrom,
    t_nodes.nod_versionvalidto,
    t_nodes.nod_createdate,
    t_nodes.nod_modificationdate,
    t_nodes.nod_importdate,
    t_nodes.nod_geom
   FROM t_nodes
  WHERE (t_nodes.nod_iliid IN ( SELECT t_nodelocations.nlo_nod_iliid
           FROM t_links,
            t_nodelocations,
            "NE_OATE"
          WHERE (("NE_OATE".xtf_id = t_links.lnk_iliid) AND (t_links.lnk_start_nlo_iliid = t_nodelocations.nlo_iliid))
        UNION
         SELECT t_nodelocations.nlo_nod_iliid
           FROM t_links,
            t_nodelocations,
            "NE_OATE"
          WHERE (("NE_OATE".xtf_id = t_links.lnk_iliid) AND (t_links.lnk_end_nlo_iliid = t_nodelocations.nlo_iliid))));


--
-- TOC entry 233 (class 1259 OID 116239657)
-- Name: v_segments_oate; Type: VIEW; Schema: mistra; Owner: -
--

CREATE VIEW v_segments_oate AS
 SELECT t_axissegments.asg_axe_iliid,
    t_axissegments.asg_capturemethod_cat_iliid,
    t_axissegments.asg_capturedate,
    t_axissegments.asg_accuracyhorizontal,
    t_axissegments.asg_accuracyvertical,
    t_axissegments.asg_sequence,
    t_axissegments.asg_importdate,
    sub3.asg_geom,
    sub3.asg_sign,
    sub3.asg_iliid,
    sub3.axe_owner,
    sub3.axe_name,
    sub3.axe_positioncode,
    sub3.asg_name,
    sub3.axe_namelong,
    sub3.sec_asg_iliid,
    sub3.total_sec_length
   FROM ( SELECT sub1.asg_geom,
            sub1.asg_sign,
            sub1.asg_iliid,
            sub1.axe_owner,
            sub1.axe_name,
            sub1.axe_positioncode,
            sub1.asg_name,
            sub1.axe_namelong,
            sub2.sec_asg_iliid,
            sub2.total_sec_length
           FROM ( SELECT t_axissegments_1.asg_geom,
                        CASE
                            WHEN ((t_axis.axe_positioncode)::bpchar = '='::bpchar) THEN 'pas de sens ='::text
                            WHEN ((t_axis.axe_positioncode)::bpchar = '-'::bpchar) THEN 'sens négatif -'::text
                            WHEN ((t_axis.axe_positioncode)::bpchar = '+'::bpchar) THEN 'sens positif +'::text
                            ELSE NULL::text
                        END AS asg_sign,
                    t_axissegments_1.asg_iliid,
                    t_axis.axe_owner,
                    t_axis.axe_name,
                    t_axis.axe_positioncode,
                    t_axissegments_1.asg_name,
                    t_axis.axe_namelong
                   FROM t_axissegments t_axissegments_1,
                    t_axis
                  WHERE (t_axissegments_1.asg_axe_iliid = t_axis.axe_iliid)) sub1,
            ( SELECT t_sectors.sec_asg_iliid,
                    sum(t_sectors.sec_length) AS total_sec_length
                   FROM t_sectors
                  GROUP BY t_sectors.sec_asg_iliid) sub2
          WHERE ((sub1.asg_iliid = sub2.sec_asg_iliid) AND ((((((((((((((((((((((((((((sub1.axe_owner)::bpchar = 'NE'::bpchar) OR (((sub1.axe_name)::text = '101'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = '1084'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = '1292'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = '237'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = '417'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = '517'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = 'NEUVE'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = 'POD'::text) AND ((sub1.axe_owner)::text = '6421'::text))) OR (((sub1.axe_name)::text = 'DJEANRI'::text) AND ((sub1.axe_owner)::text = '6436'::text))) OR (((sub1.axe_name)::text = 'HVILLE'::text) AND ((sub1.axe_owner)::text = '6436'::text))) OR (((sub1.axe_name)::text = 'MANNECA'::text) AND ((sub1.axe_owner)::text = '6436'::text))) OR (((sub1.axe_name)::text = 'TEMPLE'::text) AND ((sub1.axe_owner)::text = '6436'::text))) OR (((sub1.axe_name)::text = '21'::text) AND ((sub1.axe_owner)::text = '6458'::text))) OR (((sub1.axe_name)::text = '570'::text) AND ((sub1.axe_owner)::text = '6458'::text))) OR (((sub1.axe_name)::text = '69'::text) AND ((sub1.axe_owner)::text = '6458'::text))) OR (((sub1.axe_name)::text = '837'::text) AND ((sub1.axe_owner)::text = '6458'::text))) OR (((sub1.axe_name)::text = '5724'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5726'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5745'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5748'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5754'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5755'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5758'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5759'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5762'::text) AND ((sub1.axe_owner)::text = '6461'::text))) OR (((sub1.axe_name)::text = '5768'::text) AND ((sub1.axe_owner)::text = '6461'::text))))) sub3,
    t_axissegments
  WHERE (t_axissegments.asg_iliid = sub3.asg_iliid);


SET search_path = chaussee_dev, pg_catalog;

--
-- TOC entry 3695 (class 2606 OID 315105547)
-- Name: axissegments_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT axissegments_pk PRIMARY KEY (asg_iliid);


--
-- TOC entry 3674 (class 2606 OID 305424015)
-- Name: controls_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT controls_pk PRIMARY KEY (rco_iliid);


--
-- TOC entry 3683 (class 2606 OID 305458069)
-- Name: current_geoms_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_current_geometries
    ADD CONSTRAINT current_geoms_pk PRIMARY KEY (cgm_iliid);


--
-- TOC entry 3703 (class 2606 OID 315223589)
-- Name: current_geoms_v1_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_current_geometries_v1
    ADD CONSTRAINT current_geoms_v1_pk PRIMARY KEY (cgm_iliid);


--
-- TOC entry 3685 (class 2606 OID 306243178)
-- Name: current_views_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT current_views_pk PRIMARY KEY (cuv_iliid);


--
-- TOC entry 3656 (class 2606 OID 305423997)
-- Name: layers_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_layers
    ADD CONSTRAINT layers_pk PRIMARY KEY (lay_iliid);


--
-- TOC entry 3659 (class 2606 OID 305424000)
-- Name: methods_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_methods
    ADD CONSTRAINT methods_pk PRIMARY KEY (mtd_iliid);


--
-- TOC entry 3661 (class 2606 OID 305424002)
-- Name: methods_shortname_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_methods
    ADD CONSTRAINT methods_shortname_uk UNIQUE (mtd_shortname);


--
-- TOC entry 3663 (class 2606 OID 305424004)
-- Name: pavement_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pavement_pk PRIMARY KEY (pvl_iliid);


--
-- TOC entry 3693 (class 2606 OID 314632193)
-- Name: point_location_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_point_location
    ADD CONSTRAINT point_location_pk PRIMARY KEY (ptl_iliid);


--
-- TOC entry 3670 (class 2606 OID 305424011)
-- Name: projects_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_projects
    ADD CONSTRAINT projects_pk PRIMARY KEY (pro_iliid);


--
-- TOC entry 3672 (class 2606 OID 305424013)
-- Name: projects_shortname_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_projects
    ADD CONSTRAINT projects_shortname_uk UNIQUE (pro_shortname);


--
-- TOC entry 3697 (class 2606 OID 315161903)
-- Name: sectors_name_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_name_uk UNIQUE (sec_name, sec_asg_iliid);


--
-- TOC entry 3699 (class 2606 OID 315161901)
-- Name: sectors_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_pk PRIMARY KEY (sec_iliid);


--
-- TOC entry 3701 (class 2606 OID 315161905)
-- Name: sectors_sequence_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_sequence_uk UNIQUE (sec_sequence, sec_asg_iliid);


SET search_path = mistra, pg_catalog;

--
-- TOC entry 3572 (class 2606 OID 116239776)
-- Name: axis_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axis
    ADD CONSTRAINT axis_pk PRIMARY KEY (axe_iliid);


--
-- TOC entry 3574 (class 2606 OID 116239778)
-- Name: axis_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axis
    ADD CONSTRAINT axis_uk UNIQUE (axe_owner, axe_name, axe_positioncode);


--
-- TOC entry 3579 (class 2606 OID 116239780)
-- Name: axissegments_name_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT axissegments_name_uk UNIQUE (asg_name, asg_axe_iliid);


--
-- TOC entry 3581 (class 2606 OID 116239782)
-- Name: axissegments_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT axissegments_pk PRIMARY KEY (asg_iliid);


--
-- TOC entry 3583 (class 2606 OID 116239784)
-- Name: axissegments_sequence_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT axissegments_sequence_uk UNIQUE (asg_sequence, asg_axe_iliid);


--
-- TOC entry 3601 (class 2606 OID 116239786)
-- Name: calpoints_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_calpoints
    ADD CONSTRAINT calpoints_pk PRIMARY KEY (cal_iliid);


--
-- TOC entry 3604 (class 2606 OID 116239788)
-- Name: catalogs_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_catalogs
    ADD CONSTRAINT catalogs_pk PRIMARY KEY (cat_iliid);


--
-- TOC entry 3606 (class 2606 OID 116239790)
-- Name: cattexts_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_cattexts
    ADD CONSTRAINT cattexts_pk PRIMARY KEY (ctt_iliid);


--
-- TOC entry 3613 (class 2606 OID 116239792)
-- Name: databases_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_databases
    ADD CONSTRAINT databases_pk PRIMARY KEY (dba_iliid);


--
-- TOC entry 3615 (class 2606 OID 116239794)
-- Name: databases_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_databases
    ADD CONSTRAINT databases_uk UNIQUE (dba_name);


--
-- TOC entry 3618 (class 2606 OID 116239796)
-- Name: junctions_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_junctions
    ADD CONSTRAINT junctions_pk PRIMARY KEY (jnc_iliid);


--
-- TOC entry 3620 (class 2606 OID 116239798)
-- Name: junctions_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_junctions
    ADD CONSTRAINT junctions_uk UNIQUE (jnc_owner, jnc_name);


--
-- TOC entry 3626 (class 2606 OID 116239800)
-- Name: lnk_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_links
    ADD CONSTRAINT lnk_pk PRIMARY KEY (lnk_iliid);


--
-- TOC entry 3630 (class 2606 OID 116239802)
-- Name: net_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_networks
    ADD CONSTRAINT net_pk PRIMARY KEY (net_iliid);


--
-- TOC entry 3633 (class 2606 OID 116239804)
-- Name: net_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_networks
    ADD CONSTRAINT net_uk UNIQUE (net_owner, net_name);


--
-- TOC entry 3638 (class 2606 OID 116239806)
-- Name: nodelocations_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_nodelocations
    ADD CONSTRAINT nodelocations_pk PRIMARY KEY (nlo_iliid);


--
-- TOC entry 3645 (class 2606 OID 116239808)
-- Name: nodes_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nodes_pk PRIMARY KEY (nod_iliid);


--
-- TOC entry 3647 (class 2606 OID 116239810)
-- Name: nodes_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nodes_uk UNIQUE (nod_owner, nod_name);


--
-- TOC entry 3567 (class 2606 OID 294264942)
-- Name: pkey_cahier_srb; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cahiers_srb
    ADD CONSTRAINT pkey_cahier_srb PRIMARY KEY (axe);


--
-- TOC entry 3653 (class 2606 OID 116239812)
-- Name: sct_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sections
    ADD CONSTRAINT sct_pk PRIMARY KEY (sct_iliid);


--
-- TOC entry 3593 (class 2606 OID 116239814)
-- Name: sectors_name_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_name_uk UNIQUE (sec_name, sec_asg_iliid);


--
-- TOC entry 3595 (class 2606 OID 116239816)
-- Name: sectors_pk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_pk PRIMARY KEY (sec_iliid);


--
-- TOC entry 3597 (class 2606 OID 116239818)
-- Name: sectors_sequence_uk; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sectors_sequence_uk UNIQUE (sec_sequence, sec_asg_iliid);


--
-- TOC entry 3611 (class 2606 OID 116239820)
-- Name: t_civilengineerinstructures_pkey; Type: CONSTRAINT; Schema: mistra; Owner: -; Tablespace: 
--

ALTER TABLE ONLY t_civilengineerinstructures
    ADD CONSTRAINT t_civilengineerinstructures_pkey PRIMARY KEY (ces_id);


SET search_path = chaussee_dev, pg_catalog;

--
-- TOC entry 3680 (class 1259 OID 305458070)
-- Name: cgm_asg_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cgm_asg_fki ON t_current_geometries USING btree (cgm_asg_iliid);


--
-- TOC entry 3681 (class 1259 OID 305458071)
-- Name: cgm_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cgm_geom_idx ON t_current_geometries USING gist (cgm_geom);


--
-- TOC entry 3686 (class 1259 OID 306243213)
-- Name: cuv_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_end_sec_fki ON t_current_views USING btree (cuv_end_sec_iliid);


--
-- TOC entry 3687 (class 1259 OID 306389655)
-- Name: cuv_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_geom_idx ON t_current_views USING gist (cuv_geom);


--
-- TOC entry 3688 (class 1259 OID 306243214)
-- Name: cuv_lay_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_lay_fki ON t_current_views USING btree (cuv_lay_iliid);


--
-- TOC entry 3689 (class 1259 OID 306243215)
-- Name: cuv_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_pro_fki ON t_current_views USING btree (cuv_pro_iliid);


--
-- TOC entry 3690 (class 1259 OID 306243205)
-- Name: cuv_pvl_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_pvl_fki ON t_current_views USING btree (cuv_pvl_iliid);


--
-- TOC entry 3691 (class 1259 OID 306243212)
-- Name: cuv_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX cuv_start_sec_fki ON t_current_views USING btree (cuv_start_sec_iliid);


--
-- TOC entry 3657 (class 1259 OID 305423998)
-- Name: layers_shortname_uk; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX layers_shortname_uk ON t_layers USING btree (lay_shortname);


--
-- TOC entry 3664 (class 1259 OID 305424007)
-- Name: pvl_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX pvl_end_sec_fki ON t_pavement_layers USING btree (pvl_end_sec_iliid);


--
-- TOC entry 3665 (class 1259 OID 305881081)
-- Name: pvl_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX pvl_geom_idx ON t_pavement_layers USING gist (pvl_geom);


--
-- TOC entry 3666 (class 1259 OID 305424005)
-- Name: pvl_lay_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX pvl_lay_fki ON t_pavement_layers USING btree (pvl_lay_iliid);


--
-- TOC entry 3667 (class 1259 OID 305424006)
-- Name: pvl_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX pvl_pro_fki ON t_pavement_layers USING btree (pvl_pro_iliid);


--
-- TOC entry 3668 (class 1259 OID 305424008)
-- Name: pvl_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX pvl_start_sec_fki ON t_pavement_layers USING btree (pvl_start_sec_iliid);


--
-- TOC entry 3675 (class 1259 OID 305424020)
-- Name: rco_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX rco_end_sec_fki ON t_road_controls USING btree (rco_end_sec_iliid);


--
-- TOC entry 3676 (class 1259 OID 306234689)
-- Name: rco_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX rco_geom_idx ON t_road_controls USING btree (rco_geom);


--
-- TOC entry 3677 (class 1259 OID 305424016)
-- Name: rco_mtd_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX rco_mtd_fki ON t_road_controls USING btree (rco_mtd_iliid);


--
-- TOC entry 3678 (class 1259 OID 305424017)
-- Name: rco_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX rco_pro_fki ON t_road_controls USING btree (rco_pro_iliid);


--
-- TOC entry 3679 (class 1259 OID 305424018)
-- Name: rco_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: -; Tablespace: 
--

CREATE INDEX rco_start_sec_fki ON t_road_controls USING btree (rco_start_sec_iliid);


SET search_path = mistra, pg_catalog;

--
-- TOC entry 3575 (class 1259 OID 116239849)
-- Name: asg_axe_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX asg_axe_fki ON t_axissegments USING btree (asg_axe_iliid);


--
-- TOC entry 3576 (class 1259 OID 116239850)
-- Name: asg_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX asg_cat_fki ON t_axissegments USING btree (asg_capturemethod_cat_iliid);


--
-- TOC entry 3577 (class 1259 OID 116239851)
-- Name: asg_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX asg_geom_idx ON t_axissegments USING gist (asg_geom);


--
-- TOC entry 3568 (class 1259 OID 116239852)
-- Name: axe_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX axe_dba_fki ON t_axis USING btree (axe_dba_iliid);


--
-- TOC entry 3569 (class 1259 OID 116239853)
-- Name: axe_status_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX axe_status_cat_fki ON t_axis USING btree (axe_status_cat_iliid);


--
-- TOC entry 3570 (class 1259 OID 116239854)
-- Name: axe_typ_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX axe_typ_cat_fki ON t_axis USING btree (axe_typ_cat_iliid);


--
-- TOC entry 3598 (class 1259 OID 116239855)
-- Name: cal_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX cal_geom_idx ON t_calpoints USING gist (cal_geom);


--
-- TOC entry 3599 (class 1259 OID 116239856)
-- Name: cal_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX cal_sec_fki ON t_calpoints USING btree (cal_sec_iliid);


--
-- TOC entry 3602 (class 1259 OID 116239857)
-- Name: cat_parent_cat_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX cat_parent_cat_idx ON t_catalogs USING btree (cat_parent_cat_ilid);


--
-- TOC entry 3607 (class 1259 OID 116239858)
-- Name: ctt_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX ctt_cat_fki ON t_cattexts USING btree (ctt_cat_iliid);


--
-- TOC entry 3616 (class 1259 OID 116239859)
-- Name: jnc_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX jnc_dba_fki ON t_junctions USING btree (jnc_dba_iliid);


--
-- TOC entry 3621 (class 1259 OID 116239860)
-- Name: lnk_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX lnk_dba_fki ON t_links USING btree (lnk_dba_iliid);


--
-- TOC entry 3622 (class 1259 OID 116239861)
-- Name: lnk_end_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX lnk_end_sec_fki ON t_links USING btree (lnk_end_nlo_iliid);


--
-- TOC entry 3623 (class 1259 OID 116239862)
-- Name: lnk_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX lnk_geom_idx ON t_links USING gist (lnk_geom);


--
-- TOC entry 3624 (class 1259 OID 116239863)
-- Name: lnk_net_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX lnk_net_fki ON t_links USING btree (lnk_net_iliid);


--
-- TOC entry 3627 (class 1259 OID 116239864)
-- Name: lnk_start_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX lnk_start_sec_fki ON t_links USING btree (lnk_start_nlo_iliid);


--
-- TOC entry 3628 (class 1259 OID 116239865)
-- Name: net_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX net_dba_fki ON t_networks USING btree (net_dba_iliid);


--
-- TOC entry 3631 (class 1259 OID 116239866)
-- Name: net_typ_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX net_typ_cat_fki ON t_networks USING btree (net_typ_cat_iliid);


--
-- TOC entry 3634 (class 1259 OID 116239867)
-- Name: nlo_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nlo_dba_fki ON t_nodelocations USING btree (nlo_dba_iliid);


--
-- TOC entry 3635 (class 1259 OID 116239868)
-- Name: nlo_nod_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nlo_nod_fki ON t_nodelocations USING btree (nlo_nod_iliid);


--
-- TOC entry 3636 (class 1259 OID 116239869)
-- Name: nlo_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nlo_sec_fki ON t_nodelocations USING btree (nlo_sec_iliid);


--
-- TOC entry 3639 (class 1259 OID 116239870)
-- Name: nod_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nod_dba_fki ON t_nodes USING btree (nod_dba_iliid);


--
-- TOC entry 3640 (class 1259 OID 116239871)
-- Name: nod_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nod_geom_idx ON t_nodes USING gist (nod_geom);


--
-- TOC entry 3641 (class 1259 OID 116239872)
-- Name: nod_jnc_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nod_jnc_fki ON t_nodes USING btree (nod_jnc_iliid);


--
-- TOC entry 3642 (class 1259 OID 116239873)
-- Name: nod_nod_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nod_nod_fki ON t_nodes USING btree (nod_parent_nod_ilid);


--
-- TOC entry 3643 (class 1259 OID 116239874)
-- Name: nod_typ_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX nod_typ_cat_fki ON t_nodes USING btree (nod_typ_cat_iliid);


--
-- TOC entry 3648 (class 1259 OID 116239875)
-- Name: sct_dba_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sct_dba_fki ON t_sections USING btree (sct_dba_iliid);


--
-- TOC entry 3649 (class 1259 OID 116239876)
-- Name: sct_end_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sct_end_sec_fki ON t_sections USING btree (sct_end_sec_iliid);


--
-- TOC entry 3650 (class 1259 OID 116239877)
-- Name: sct_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sct_geom_idx ON t_sections USING gist (sct_geom);


--
-- TOC entry 3651 (class 1259 OID 116239878)
-- Name: sct_net_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sct_net_fki ON t_sections USING btree (sct_net_iliid);


--
-- TOC entry 3654 (class 1259 OID 116239879)
-- Name: sct_start_sec_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sct_start_sec_fki ON t_sections USING btree (sct_start_sec_iliid);


--
-- TOC entry 3584 (class 1259 OID 116239880)
-- Name: sec_asg_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_asg_fki ON t_sectors USING btree (sec_asg_iliid);


--
-- TOC entry 3585 (class 1259 OID 116239881)
-- Name: sec_geom_idx; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_geom_idx ON t_sectors USING gist (sec_geom);


--
-- TOC entry 3586 (class 1259 OID 116239882)
-- Name: sec_marker_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_marker_cat_fki ON t_sectors USING btree (sec_marker_cat_iliid);


--
-- TOC entry 3587 (class 1259 OID 116239883)
-- Name: sec_mat_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_mat_cat_fki ON t_sectors USING btree (sec_mat_cat_iliid);


--
-- TOC entry 3588 (class 1259 OID 116239884)
-- Name: sec_platefixation_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_platefixation_cat_fki ON t_sectors USING btree (sec_platefixation_cat_iliid);


--
-- TOC entry 3589 (class 1259 OID 116239885)
-- Name: sec_platelabel_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_platelabel_cat_fki ON t_sectors USING btree (sec_platelabel_cat_iliid);


--
-- TOC entry 3590 (class 1259 OID 116239886)
-- Name: sec_platelocation_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_platelocation_cat_fki ON t_sectors USING btree (sec_platelocation_cat_iliid);


--
-- TOC entry 3591 (class 1259 OID 116239887)
-- Name: sec_platetyp_cat_fki; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX sec_platetyp_cat_fki ON t_sectors USING btree (sec_platetyp_cat_iliid);


--
-- TOC entry 3608 (class 1259 OID 116239888)
-- Name: t_civilengineerinstructures_ces_sec_ilid_143322903266; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX t_civilengineerinstructures_ces_sec_ilid_143322903266 ON t_civilengineerinstructures USING btree (ces_sec_ilid);


--
-- TOC entry 3609 (class 1259 OID 116239889)
-- Name: t_civilengineerinstructures_geom_143322903296; Type: INDEX; Schema: mistra; Owner: -; Tablespace: 
--

CREATE INDEX t_civilengineerinstructures_geom_143322903296 ON t_civilengineerinstructures USING gist (geom);


SET search_path = chaussee_dev, pg_catalog;

--
-- TOC entry 3748 (class 2620 OID 315223590)
-- Name: timestamp_trg; Type: TRIGGER; Schema: chaussee_dev; Owner: -
--

CREATE TRIGGER timestamp_trg BEFORE INSERT OR UPDATE ON t_current_geometries_v1 FOR EACH ROW EXECUTE PROCEDURE timestamp_fct();


--
-- TOC entry 3747 (class 2606 OID 306243189)
-- Name: cuv_end_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_end_sec_fk FOREIGN KEY (cuv_end_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3745 (class 2606 OID 306243199)
-- Name: cuv_lay_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_lay_fk FOREIGN KEY (cuv_lay_iliid) REFERENCES t_layers(lay_iliid);


--
-- TOC entry 3746 (class 2606 OID 306243194)
-- Name: cuv_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_pro_fk FOREIGN KEY (cuv_pro_iliid) REFERENCES t_projects(pro_iliid);


--
-- TOC entry 3743 (class 2606 OID 306388783)
-- Name: cuv_pvl_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_pvl_fk FOREIGN KEY (cuv_pvl_iliid) REFERENCES t_pavement_layers(pvl_iliid) ON DELETE CASCADE;


--
-- TOC entry 3744 (class 2606 OID 306243207)
-- Name: cuv_start_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_start_sec_fk FOREIGN KEY (cuv_start_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3737 (class 2606 OID 306242614)
-- Name: pvl_end_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_end_sec_fk FOREIGN KEY (pvl_end_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3740 (class 2606 OID 305424026)
-- Name: pvl_lay_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_lay_fk FOREIGN KEY (pvl_lay_iliid) REFERENCES t_layers(lay_iliid);


--
-- TOC entry 3739 (class 2606 OID 305424031)
-- Name: pvl_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_pro_fk FOREIGN KEY (pvl_pro_iliid) REFERENCES t_projects(pro_iliid);


--
-- TOC entry 3738 (class 2606 OID 306242609)
-- Name: pvl_start_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_start_sec_fk FOREIGN KEY (pvl_start_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3742 (class 2606 OID 305424036)
-- Name: rco_mtd_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT rco_mtd_fk FOREIGN KEY (rco_mtd_iliid) REFERENCES t_methods(mtd_iliid);


--
-- TOC entry 3741 (class 2606 OID 305424041)
-- Name: rco_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: -
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT rco_pro_fk FOREIGN KEY (rco_pro_iliid) REFERENCES t_projects(pro_iliid);


SET search_path = mistra, pg_catalog;

--
-- TOC entry 3708 (class 2606 OID 116239900)
-- Name: asg_axe_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT asg_axe_fk FOREIGN KEY (asg_axe_iliid) REFERENCES t_axis(axe_iliid);


--
-- TOC entry 3707 (class 2606 OID 116239905)
-- Name: asg_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_axissegments
    ADD CONSTRAINT asg_cat_fk FOREIGN KEY (asg_capturemethod_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3706 (class 2606 OID 116239910)
-- Name: axe_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_axis
    ADD CONSTRAINT axe_dba_fk FOREIGN KEY (axe_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3705 (class 2606 OID 116239915)
-- Name: axe_status_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_axis
    ADD CONSTRAINT axe_status_cat_fk FOREIGN KEY (axe_status_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3704 (class 2606 OID 116239920)
-- Name: axe_typ_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_axis
    ADD CONSTRAINT axe_typ_cat_fk FOREIGN KEY (axe_typ_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3716 (class 2606 OID 116239925)
-- Name: cal_sec_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_calpoints
    ADD CONSTRAINT cal_sec_fk FOREIGN KEY (cal_sec_iliid) REFERENCES t_sectors(sec_iliid);


--
-- TOC entry 3717 (class 2606 OID 116239930)
-- Name: cat_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_catalogs
    ADD CONSTRAINT cat_cat_fk FOREIGN KEY (cat_parent_cat_ilid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3718 (class 2606 OID 116239935)
-- Name: ctt_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_cattexts
    ADD CONSTRAINT ctt_cat_fk FOREIGN KEY (ctt_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3719 (class 2606 OID 116239940)
-- Name: jnc_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_junctions
    ADD CONSTRAINT jnc_dba_fk FOREIGN KEY (jnc_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3723 (class 2606 OID 116239945)
-- Name: lnk_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_links
    ADD CONSTRAINT lnk_dba_fk FOREIGN KEY (lnk_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3722 (class 2606 OID 116239950)
-- Name: lnk_end_nlo_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_links
    ADD CONSTRAINT lnk_end_nlo_fk FOREIGN KEY (lnk_end_nlo_iliid) REFERENCES t_nodelocations(nlo_iliid);


--
-- TOC entry 3721 (class 2606 OID 116239955)
-- Name: lnk_net_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_links
    ADD CONSTRAINT lnk_net_fk FOREIGN KEY (lnk_net_iliid) REFERENCES t_networks(net_iliid);


--
-- TOC entry 3720 (class 2606 OID 116239960)
-- Name: lnk_start_nlo_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_links
    ADD CONSTRAINT lnk_start_nlo_fk FOREIGN KEY (lnk_start_nlo_iliid) REFERENCES t_nodelocations(nlo_iliid);


--
-- TOC entry 3725 (class 2606 OID 116239965)
-- Name: net_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_networks
    ADD CONSTRAINT net_dba_fk FOREIGN KEY (net_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3724 (class 2606 OID 116239970)
-- Name: net_typ_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_networks
    ADD CONSTRAINT net_typ_cat_fk FOREIGN KEY (net_typ_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3728 (class 2606 OID 116239975)
-- Name: nlo_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodelocations
    ADD CONSTRAINT nlo_dba_fk FOREIGN KEY (nlo_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3727 (class 2606 OID 116239980)
-- Name: nlo_nod_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodelocations
    ADD CONSTRAINT nlo_nod_fk FOREIGN KEY (nlo_nod_iliid) REFERENCES t_nodes(nod_iliid);


--
-- TOC entry 3726 (class 2606 OID 116239985)
-- Name: nlo_sec_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodelocations
    ADD CONSTRAINT nlo_sec_fk FOREIGN KEY (nlo_sec_iliid) REFERENCES t_sectors(sec_iliid);


--
-- TOC entry 3732 (class 2606 OID 116239990)
-- Name: nod_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nod_dba_fk FOREIGN KEY (nod_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3731 (class 2606 OID 116239995)
-- Name: nod_jnc_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nod_jnc_fk FOREIGN KEY (nod_jnc_iliid) REFERENCES t_junctions(jnc_iliid);


--
-- TOC entry 3730 (class 2606 OID 116240000)
-- Name: nod_nod_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nod_nod_fk FOREIGN KEY (nod_parent_nod_ilid) REFERENCES t_nodes(nod_iliid);


--
-- TOC entry 3729 (class 2606 OID 116240005)
-- Name: nod_typ_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_nodes
    ADD CONSTRAINT nod_typ_cat_fk FOREIGN KEY (nod_typ_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3736 (class 2606 OID 116240010)
-- Name: sct_dba_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sections
    ADD CONSTRAINT sct_dba_fk FOREIGN KEY (sct_dba_iliid) REFERENCES t_databases(dba_iliid);


--
-- TOC entry 3735 (class 2606 OID 116240015)
-- Name: sct_end_sec_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sections
    ADD CONSTRAINT sct_end_sec_fk FOREIGN KEY (sct_end_sec_iliid) REFERENCES t_sectors(sec_iliid);


--
-- TOC entry 3734 (class 2606 OID 116240020)
-- Name: sct_net_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sections
    ADD CONSTRAINT sct_net_fk FOREIGN KEY (sct_net_iliid) REFERENCES t_networks(net_iliid);


--
-- TOC entry 3733 (class 2606 OID 116240025)
-- Name: sct_start_sec_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sections
    ADD CONSTRAINT sct_start_sec_fk FOREIGN KEY (sct_start_sec_iliid) REFERENCES t_sectors(sec_iliid);


--
-- TOC entry 3709 (class 2606 OID 116240030)
-- Name: sec_asg_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_asg_fk FOREIGN KEY (sec_asg_iliid) REFERENCES t_axissegments(asg_iliid);


--
-- TOC entry 3710 (class 2606 OID 116240035)
-- Name: sec_marker_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_marker_cat_fk FOREIGN KEY (sec_marker_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3711 (class 2606 OID 116240040)
-- Name: sec_mat_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_mat_cat_fk FOREIGN KEY (sec_mat_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3712 (class 2606 OID 116240045)
-- Name: sec_platefixation_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_platefixation_cat_fk FOREIGN KEY (sec_platefixation_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3713 (class 2606 OID 116240050)
-- Name: sec_platelabel_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_platelabel_cat_fk FOREIGN KEY (sec_platelabel_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3714 (class 2606 OID 116240055)
-- Name: sec_platelocation_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_platelocation_cat_fk FOREIGN KEY (sec_platelocation_cat_iliid) REFERENCES t_catalogs(cat_iliid);


--
-- TOC entry 3715 (class 2606 OID 116240060)
-- Name: sec_platetyp_cat_fk; Type: FK CONSTRAINT; Schema: mistra; Owner: -
--

ALTER TABLE ONLY t_sectors
    ADD CONSTRAINT sec_platetyp_cat_fk FOREIGN KEY (sec_platetyp_cat_iliid) REFERENCES t_catalogs(cat_iliid);


-- Completed on 2017-11-17 15:46:47

--
-- PostgreSQL database dump complete
--

