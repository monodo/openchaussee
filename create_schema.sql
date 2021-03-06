--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.0
-- Started on 2017-09-20 14:23:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 305423937)
-- Name: chaussee_dev; Type: SCHEMA; Schema: -; Owner: spch_admin
--

CREATE SCHEMA chaussee_dev;


ALTER SCHEMA chaussee_dev OWNER TO spch_admin;

SET search_path = chaussee_dev, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 300 (class 1259 OID 305458061)
-- Name: t_current_geometries; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_current_geometries OWNER TO spch_admin;

--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE t_current_geometries; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_current_geometries IS 'G�om�trie de la chauss�e';


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_iliid IS 'Identifiant interne';


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_geom; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_geom IS 'Polygones "libres", pas multipolygone, pas de trou.';


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_asg_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_asg_iliid IS 'Segment d''axe concern�';


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_calcul_length IS 'Longueur SRB de la couche (Calcul�)';


--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_calcul_area IS 'Surface SRB de la couche (Calcul�)';


--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_updateuser IS 'Auteur de la mise � jour (syst�me)';


--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN t_current_geometries.cgm_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_geometries.cgm_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 302 (class 1259 OID 306243170)
-- Name: t_current_views; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_current_views OWNER TO spch_admin;

--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE t_current_views; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_current_views IS 'D�coupage des couches de structure pour la vue actuelle';


--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_iliid IS 'Identifiant interne';


--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_geom; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_geom IS 'polygone avec trou';


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_pvl_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_pvl_iliid IS 'Couche d''origine';


--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_calcul_length IS 'Longueur SRB de la couche (Calcul�)';


--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_calcul_area IS 'Surface SRB de la couche (Calcul�)';


--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_updateuser IS 'Auteur de la mise � jour  (syst�me)';


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN t_current_views.cuv_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_current_views.cuv_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 288 (class 1259 OID 305423953)
-- Name: t_layers; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_layers OWNER TO spch_admin;

--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE t_layers; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_layers IS 'Catalogue des types de couche';


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_iliid IS 'Identifiant interne';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_shortname IS 'Abr�viation. (AB6,''AC11L, HMTxxx,...) ';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_name; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_name IS 'Libell� selon cat MISTRA (ex : AC 8S, avec polym�res, C. de roulement)';


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_layer; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_layer IS 'Couche (ex : RO  Couche de roulement)';


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_material; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_material IS 'Sorte de mat�riau (ex:  B�ton bitumineux AC)';


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_remark; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_remark IS 'Remarques';


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_updateuser IS 'Auteur de la mise � jour (syst�me)';


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN t_layers.lay_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_layers.lay_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 289 (class 1259 OID 305423960)
-- Name: t_methods; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_methods OWNER TO spch_admin;

--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE t_methods; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_methods IS 'Catalogue des types de m�thode de relev�';


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_iliid IS 'Identifiant interne';


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_shortname IS 'Abbr�viation';


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_name; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_name IS 'Nom';


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_characteristic; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_characteristic IS 'Caract�ristique de la chauss�e (I1, I2, etc..)';


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_remark; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_remark IS 'Remarque';


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_updateuser IS 'Auteur de la mise � jour';


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN t_methods.mtd_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_methods.mtd_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 290 (class 1259 OID 305423967)
-- Name: t_pavement_layers; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_pavement_layers OWNER TO spch_admin;

--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE t_pavement_layers; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_pavement_layers IS 'Couches de structure';


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_iliid IS 'Identifiant interne';


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_geom; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_geom IS 'Polygones libres, pas multipolygone, pas de trou';


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_start_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_start_sec_iliid IS 'PR d�but';


--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_start_u; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_start_u IS 'Distance U au PR d�but [m]';


--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_end_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_end_sec_iliid IS 'PR fin';


--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_end_u; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_end_u IS 'Distance U au PR fin [m]';


--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_lay_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_lay_iliid IS 'Type de couche. Pour le prototype, une liste de valeurs qui se trouivent dans la table Type Couches';


--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_posedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_posedate IS 'Date de pose';


--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_thickness; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_thickness IS 'Epaisseur [cm]';


--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_depth; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_depth IS 'Profondeur de fraisage [cm]';


--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_pro_iliid IS 'Projet';


--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_remark; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_remark IS 'Remarques';


--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_calcul_length; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_calcul_length IS 'Longueur SRB de la couche (Calcul�)';


--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_calcul_area; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_calcul_area IS 'Surface SRB de la couche (Calcul�)';


--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_updateuser IS 'Auteur de la mise � jour (syst�me)';


--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN t_pavement_layers.pvl_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_pavement_layers.pvl_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 313 (class 1259 OID 312557700)
-- Name: t_point_loc; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE TABLE t_point_loc (
    ptl_iliid integer NOT NULL,
    ptl_geom public.geometry(Point,2056)
);


ALTER TABLE t_point_loc OWNER TO spch_admin;

--
-- TOC entry 312 (class 1259 OID 312557698)
-- Name: t_point_loc_ptl_iliid_seq; Type: SEQUENCE; Schema: chaussee_dev; Owner: spch_admin
--

CREATE SEQUENCE t_point_loc_ptl_iliid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_point_loc_ptl_iliid_seq OWNER TO spch_admin;

--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 312
-- Name: t_point_loc_ptl_iliid_seq; Type: SEQUENCE OWNED BY; Schema: chaussee_dev; Owner: spch_admin
--

ALTER SEQUENCE t_point_loc_ptl_iliid_seq OWNED BY t_point_loc.ptl_iliid;


--
-- TOC entry 291 (class 1259 OID 305423974)
-- Name: t_projects; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_projects OWNER TO spch_admin;

--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE t_projects; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_projects IS 'Catalogue des projets';


--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_iliid IS 'Identifiant interne';


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_year; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_year IS 'Ann�e';


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_shortname; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_shortname IS 'Abbr�viation';


--
-- TOC entry 3804 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_name; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_name IS 'Nom';


--
-- TOC entry 3805 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_typname; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_typname IS 'Type de projet';


--
-- TOC entry 3806 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_remark; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_remark IS 'Remarques';


--
-- TOC entry 3807 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3808 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_updateuser IS 'Auteur de la mise � jour (syst�me)';


--
-- TOC entry 3809 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN t_projects.pro_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_projects.pro_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 292 (class 1259 OID 305423981)
-- Name: t_road_controls; Type: TABLE; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
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


ALTER TABLE t_road_controls OWNER TO spch_admin;

--
-- TOC entry 3811 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE t_road_controls; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON TABLE t_road_controls IS 'Etats de la chauss�e relev�';


--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_iliid IS 'Identifiant interne';


--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_geom; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_geom IS 'Ligne superpos�e � la g�om�trie du segment d''axe';


--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_start_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_start_sec_iliid IS 'PR d�but';


--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_start_u; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_start_u IS 'Distance U au PR d�but [m]';


--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_end_sec_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_end_sec_iliid IS 'PR fin';


--
-- TOC entry 3817 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_end_u; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_end_u IS 'Distance U au PR fin [m]';


--
-- TOC entry 3818 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_traffic_lane; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_traffic_lane IS 'Num�ro de voie. Idem MISTRA.  -2; -1; 0; 1; 2';


--
-- TOC entry 3819 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_mtd_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_mtd_iliid IS 'Type de m�thode';


--
-- TOC entry 3820 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_statementdate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_statementdate IS 'Date du relev�';


--
-- TOC entry 3821 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_value_1; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_value_1 IS 'Premi�re valeur';


--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_value_2; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_value_2 IS 'Deuxi�me valeur';


--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_value_3; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_value_3 IS 'Troisi�me valeur';


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_pro_iliid; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_pro_iliid IS 'Projet';


--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_note; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_note IS 'Note (fonction r�gle)';


--
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_remark; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_remark IS 'Remarques';


--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_updatedate; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_updatedate IS 'Date de la mise � jour, la cr�ation est une mise � jour (syst�me)';


--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_updateuser; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_updateuser IS 'Auteur de la mise � jour (syst�me)';


--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN t_road_controls.rco_statut; Type: COMMENT; Schema: chaussee_dev; Owner: spch_admin
--

COMMENT ON COLUMN t_road_controls.rco_statut IS 'Enregistrement actif/ inactif';


--
-- TOC entry 3547 (class 2604 OID 312557703)
-- Name: ptl_iliid; Type: DEFAULT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_point_loc ALTER COLUMN ptl_iliid SET DEFAULT nextval('t_point_loc_ptl_iliid_seq'::regclass);


--
-- TOC entry 3567 (class 2606 OID 305424015)
-- Name: controls_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT controls_pk PRIMARY KEY (rco_iliid);


--
-- TOC entry 3576 (class 2606 OID 305458069)
-- Name: current_geoms_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_current_geometries
    ADD CONSTRAINT current_geoms_pk PRIMARY KEY (cgm_iliid);


--
-- TOC entry 3578 (class 2606 OID 306243178)
-- Name: current_views_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT current_views_pk PRIMARY KEY (cuv_iliid);


--
-- TOC entry 3549 (class 2606 OID 305423997)
-- Name: layers_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_layers
    ADD CONSTRAINT layers_pk PRIMARY KEY (lay_iliid);


--
-- TOC entry 3552 (class 2606 OID 305424000)
-- Name: methods_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_methods
    ADD CONSTRAINT methods_pk PRIMARY KEY (mtd_iliid);


--
-- TOC entry 3554 (class 2606 OID 305424002)
-- Name: methods_shortname_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_methods
    ADD CONSTRAINT methods_shortname_uk UNIQUE (mtd_shortname);


--
-- TOC entry 3556 (class 2606 OID 305424004)
-- Name: pavement_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pavement_pk PRIMARY KEY (pvl_iliid);


--
-- TOC entry 3563 (class 2606 OID 305424011)
-- Name: projects_pk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_projects
    ADD CONSTRAINT projects_pk PRIMARY KEY (pro_iliid);


--
-- TOC entry 3565 (class 2606 OID 305424013)
-- Name: projects_shortname_uk; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_projects
    ADD CONSTRAINT projects_shortname_uk UNIQUE (pro_shortname);


--
-- TOC entry 3587 (class 2606 OID 312557705)
-- Name: t_point_loc_pkey; Type: CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

ALTER TABLE ONLY t_point_loc
    ADD CONSTRAINT t_point_loc_pkey PRIMARY KEY (ptl_iliid);


--
-- TOC entry 3573 (class 1259 OID 305458070)
-- Name: cgm_asg_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cgm_asg_fki ON t_current_geometries USING btree (cgm_asg_iliid);


--
-- TOC entry 3574 (class 1259 OID 305458071)
-- Name: cgm_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cgm_geom_idx ON t_current_geometries USING gist (cgm_geom);


--
-- TOC entry 3579 (class 1259 OID 306243213)
-- Name: cuv_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_end_sec_fki ON t_current_views USING btree (cuv_end_sec_iliid);


--
-- TOC entry 3580 (class 1259 OID 306389655)
-- Name: cuv_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_geom_idx ON t_current_views USING gist (cuv_geom);


--
-- TOC entry 3581 (class 1259 OID 306243214)
-- Name: cuv_lay_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_lay_fki ON t_current_views USING btree (cuv_lay_iliid);


--
-- TOC entry 3582 (class 1259 OID 306243215)
-- Name: cuv_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_pro_fki ON t_current_views USING btree (cuv_pro_iliid);


--
-- TOC entry 3583 (class 1259 OID 306243205)
-- Name: cuv_pvl_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_pvl_fki ON t_current_views USING btree (cuv_pvl_iliid);


--
-- TOC entry 3584 (class 1259 OID 306243212)
-- Name: cuv_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX cuv_start_sec_fki ON t_current_views USING btree (cuv_start_sec_iliid);


--
-- TOC entry 3550 (class 1259 OID 305423998)
-- Name: layers_shortname_uk; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX layers_shortname_uk ON t_layers USING btree (lay_shortname);


--
-- TOC entry 3557 (class 1259 OID 305424007)
-- Name: pvl_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX pvl_end_sec_fki ON t_pavement_layers USING btree (pvl_end_sec_iliid);


--
-- TOC entry 3558 (class 1259 OID 305881081)
-- Name: pvl_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX pvl_geom_idx ON t_pavement_layers USING gist (pvl_geom);


--
-- TOC entry 3559 (class 1259 OID 305424005)
-- Name: pvl_lay_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX pvl_lay_fki ON t_pavement_layers USING btree (pvl_lay_iliid);


--
-- TOC entry 3560 (class 1259 OID 305424006)
-- Name: pvl_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX pvl_pro_fki ON t_pavement_layers USING btree (pvl_pro_iliid);


--
-- TOC entry 3561 (class 1259 OID 305424008)
-- Name: pvl_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX pvl_start_sec_fki ON t_pavement_layers USING btree (pvl_start_sec_iliid);


--
-- TOC entry 3568 (class 1259 OID 305424020)
-- Name: rco_end_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX rco_end_sec_fki ON t_road_controls USING btree (rco_end_sec_iliid);


--
-- TOC entry 3569 (class 1259 OID 306234689)
-- Name: rco_geom_idx; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX rco_geom_idx ON t_road_controls USING btree (rco_geom);


--
-- TOC entry 3570 (class 1259 OID 305424016)
-- Name: rco_mtd_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX rco_mtd_fki ON t_road_controls USING btree (rco_mtd_iliid);


--
-- TOC entry 3571 (class 1259 OID 305424017)
-- Name: rco_pro_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX rco_pro_fki ON t_road_controls USING btree (rco_pro_iliid);


--
-- TOC entry 3572 (class 1259 OID 305424018)
-- Name: rco_start_sec_fki; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX rco_start_sec_fki ON t_road_controls USING btree (rco_start_sec_iliid);


--
-- TOC entry 3585 (class 1259 OID 312557709)
-- Name: sidx_t_point_loc_ptl_geom; Type: INDEX; Schema: chaussee_dev; Owner: spch_admin; Tablespace: 
--

CREATE INDEX sidx_t_point_loc_ptl_geom ON t_point_loc USING gist (ptl_geom);


--
-- TOC entry 3598 (class 2606 OID 306243189)
-- Name: cuv_end_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_end_sec_fk FOREIGN KEY (cuv_end_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3596 (class 2606 OID 306243199)
-- Name: cuv_lay_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_lay_fk FOREIGN KEY (cuv_lay_iliid) REFERENCES t_layers(lay_iliid);


--
-- TOC entry 3597 (class 2606 OID 306243194)
-- Name: cuv_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_pro_fk FOREIGN KEY (cuv_pro_iliid) REFERENCES t_projects(pro_iliid);


--
-- TOC entry 3594 (class 2606 OID 306388783)
-- Name: cuv_pvl_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_pvl_fk FOREIGN KEY (cuv_pvl_iliid) REFERENCES t_pavement_layers(pvl_iliid) ON DELETE CASCADE;


--
-- TOC entry 3595 (class 2606 OID 306243207)
-- Name: cuv_start_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_current_views
    ADD CONSTRAINT cuv_start_sec_fk FOREIGN KEY (cuv_start_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3588 (class 2606 OID 306242614)
-- Name: pvl_end_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_end_sec_fk FOREIGN KEY (pvl_end_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3591 (class 2606 OID 305424026)
-- Name: pvl_lay_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_lay_fk FOREIGN KEY (pvl_lay_iliid) REFERENCES t_layers(lay_iliid);


--
-- TOC entry 3590 (class 2606 OID 305424031)
-- Name: pvl_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_pro_fk FOREIGN KEY (pvl_pro_iliid) REFERENCES t_projects(pro_iliid);


--
-- TOC entry 3589 (class 2606 OID 306242609)
-- Name: pvl_start_sec_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_pavement_layers
    ADD CONSTRAINT pvl_start_sec_fk FOREIGN KEY (pvl_start_sec_iliid) REFERENCES mistra.t_sectors(sec_iliid);


--
-- TOC entry 3593 (class 2606 OID 305424036)
-- Name: rco_mtd_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT rco_mtd_fk FOREIGN KEY (rco_mtd_iliid) REFERENCES t_methods(mtd_iliid);


--
-- TOC entry 3592 (class 2606 OID 305424041)
-- Name: rco_pro_fk; Type: FK CONSTRAINT; Schema: chaussee_dev; Owner: spch_admin
--

ALTER TABLE ONLY t_road_controls
    ADD CONSTRAINT rco_pro_fk FOREIGN KEY (rco_pro_iliid) REFERENCES t_projects(pro_iliid);


--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 300
-- Name: t_current_geometries; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_current_geometries FROM PUBLIC;
REVOKE ALL ON TABLE t_current_geometries FROM spch_admin;
GRANT ALL ON TABLE t_current_geometries TO spch_admin;
GRANT ALL ON TABLE t_current_geometries TO PUBLIC;
GRANT SELECT ON TABLE t_current_geometries TO spch_reader;
GRANT ALL ON TABLE t_current_geometries TO spch_update;
GRANT ALL ON TABLE t_current_geometries TO spch_editor;


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 302
-- Name: t_current_views; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_current_views FROM PUBLIC;
REVOKE ALL ON TABLE t_current_views FROM spch_admin;
GRANT ALL ON TABLE t_current_views TO spch_admin;
GRANT ALL ON TABLE t_current_views TO PUBLIC;
GRANT SELECT ON TABLE t_current_views TO spch_reader;
GRANT ALL ON TABLE t_current_views TO spch_update;
GRANT ALL ON TABLE t_current_views TO spch_editor;


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 288
-- Name: t_layers; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_layers FROM PUBLIC;
REVOKE ALL ON TABLE t_layers FROM spch_admin;
GRANT ALL ON TABLE t_layers TO spch_admin;
GRANT ALL ON TABLE t_layers TO spch_update;
GRANT SELECT ON TABLE t_layers TO spch_reader;
GRANT ALL ON TABLE t_layers TO spch_editor;


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 289
-- Name: t_methods; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_methods FROM PUBLIC;
REVOKE ALL ON TABLE t_methods FROM spch_admin;
GRANT ALL ON TABLE t_methods TO spch_admin;
GRANT ALL ON TABLE t_methods TO spch_update;
GRANT SELECT ON TABLE t_methods TO spch_reader;
GRANT ALL ON TABLE t_methods TO spch_editor;


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 290
-- Name: t_pavement_layers; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_pavement_layers FROM PUBLIC;
REVOKE ALL ON TABLE t_pavement_layers FROM spch_admin;
GRANT ALL ON TABLE t_pavement_layers TO spch_admin;
GRANT ALL ON TABLE t_pavement_layers TO spch_update;
GRANT SELECT ON TABLE t_pavement_layers TO spch_reader;
GRANT ALL ON TABLE t_pavement_layers TO spch_editor;


--
-- TOC entry 3810 (class 0 OID 0)
-- Dependencies: 291
-- Name: t_projects; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_projects FROM PUBLIC;
REVOKE ALL ON TABLE t_projects FROM spch_admin;
GRANT ALL ON TABLE t_projects TO spch_admin;
GRANT ALL ON TABLE t_projects TO spch_update;
GRANT SELECT ON TABLE t_projects TO spch_reader;
GRANT ALL ON TABLE t_projects TO spch_editor;


--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 292
-- Name: t_road_controls; Type: ACL; Schema: chaussee_dev; Owner: spch_admin
--

REVOKE ALL ON TABLE t_road_controls FROM PUBLIC;
REVOKE ALL ON TABLE t_road_controls FROM spch_admin;
GRANT ALL ON TABLE t_road_controls TO spch_admin;
GRANT ALL ON TABLE t_road_controls TO spch_update;
GRANT SELECT ON TABLE t_road_controls TO spch_reader;
GRANT ALL ON TABLE t_road_controls TO spch_editor;


--
-- TOC entry 3178 (class 826 OID 305424156)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: chaussee_dev; Owner: mapfish
--

ALTER DEFAULT PRIVILEGES FOR ROLE mapfish IN SCHEMA chaussee_dev REVOKE ALL ON TABLES  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE mapfish IN SCHEMA chaussee_dev REVOKE ALL ON TABLES  FROM mapfish;
ALTER DEFAULT PRIVILEGES FOR ROLE mapfish IN SCHEMA chaussee_dev GRANT ALL ON TABLES  TO PUBLIC;


-- Completed on 2017-09-20 14:23:11

--
-- PostgreSQL database dump complete
--

