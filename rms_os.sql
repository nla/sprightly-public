--------------------------------------------------------
--  File created - Monday-January-25-2010   
--------------------------------------------------------
  DROP TABLE "RMS_OS"."AGREEMENT" cascade constraints;
  DROP TABLE "RMS_OS"."CONDITION" cascade constraints;
  DROP TABLE "RMS_OS"."CONTACT" cascade constraints;
  DROP TABLE "RMS_OS"."CONTACTDETAIL" cascade constraints;
  DROP TABLE "RMS_OS"."CONTACTTYPE_LU" cascade constraints;
  DROP TABLE "RMS_OS"."COPYDETAILS" cascade constraints;
  DROP TABLE "RMS_OS"."COPYROLE_LU" cascade constraints;
  DROP TABLE "RMS_OS"."COPYSET" cascade constraints;
  DROP TABLE "RMS_OS"."COPYSTATUS" cascade constraints;
  DROP TABLE "RMS_OS"."NOTE" cascade constraints;
  DROP TABLE "RMS_OS"."PARTY" cascade constraints;
  DROP TABLE "RMS_OS"."PARTYAGREEMENT" cascade constraints;
  DROP TABLE "RMS_OS"."PERMISSION" cascade constraints;
  DROP TABLE "RMS_OS"."PERMISSIONPOLICY_LU" cascade constraints;
  DROP TABLE "RMS_OS"."PERMISSIONPURPOSE_LU" cascade constraints;
  DROP TABLE "RMS_OS"."PERMISSIONTYPE_LU" cascade constraints;
  DROP TABLE "RMS_OS"."PRIVACY_LU" cascade constraints;
  DROP TABLE "RMS_OS"."RELATED_ROLE" cascade constraints;
  DROP TABLE "RMS_OS"."RELATIONSHIP" cascade constraints;
  DROP TABLE "RMS_OS"."RELATIONSHIP_LU" cascade constraints;
  DROP TABLE "RMS_OS"."ROLE" cascade constraints;
  DROP TABLE "RMS_OS"."ROLE_LU" cascade constraints;
  DROP TABLE "RMS_OS"."STATUS_LU" cascade constraints;
  DROP TABLE "RMS_OS"."TRIMRECORD" cascade constraints;
  DROP SEQUENCE "RMS_OS"."SQ_AGREEMENT";
  DROP SEQUENCE "RMS_OS"."SQ_CONDITION";
  DROP SEQUENCE "RMS_OS"."SQ_CONTACT";
  DROP SEQUENCE "RMS_OS"."SQ_CONTACTDETAIL";
  DROP SEQUENCE "RMS_OS"."SQ_CONTACTTYPE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_COPYDETAILS";
  DROP SEQUENCE "RMS_OS"."SQ_COPYROLE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_COPYSET";
  DROP SEQUENCE "RMS_OS"."SQ_COPYSTATUS";
  DROP SEQUENCE "RMS_OS"."SQ_COPYSTATUS_LU";
  DROP SEQUENCE "RMS_OS"."SQ_NOTE";
  DROP SEQUENCE "RMS_OS"."SQ_PARTY";
  DROP SEQUENCE "RMS_OS"."SQ_PARTYAGREEMENT";
  DROP SEQUENCE "RMS_OS"."SQ_PERMISSION";
  DROP SEQUENCE "RMS_OS"."SQ_PERMISSIONPOLICY_LU";
  DROP SEQUENCE "RMS_OS"."SQ_PERMISSIONPURPOSE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_PERMISSIONTYPE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_POLICY";
  DROP SEQUENCE "RMS_OS"."SQ_POLICYSTATUS_LU";
  DROP SEQUENCE "RMS_OS"."SQ_POLICYTYPE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_POLICY_LU";
  DROP SEQUENCE "RMS_OS"."SQ_PRIVACYSTATUS_LU";
  DROP SEQUENCE "RMS_OS"."SQ_PRIVACY_LU";
  DROP SEQUENCE "RMS_OS"."SQ_RELATIONSHIP";
  DROP SEQUENCE "RMS_OS"."SQ_RELATIONSHIP_LU";
  DROP SEQUENCE "RMS_OS"."SQ_ROLE";
  DROP SEQUENCE "RMS_OS"."SQ_ROLE_LU";
  DROP SEQUENCE "RMS_OS"."SQ_STATUS_LU";
  DROP SEQUENCE "RMS_OS"."SQ_TRIMRECORD";
  DROP SEQUENCE "RMS_OS"."SQ_TRIMSTATUS_LU";
--------------------------------------------------------
--  DDL for Sequence SQ_AGREEMENT
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_AGREEMENT"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 3761 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_CONDITION
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_CONDITION"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 281 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_CONTACT
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_CONTACT"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 2341 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_CONTACTDETAIL
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_CONTACTDETAIL"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 6121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_CONTACTTYPE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_CONTACTTYPE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_COPYDETAILS
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_COPYDETAILS"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 227101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_COPYROLE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_COPYROLE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_COPYSET
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_COPYSET"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 741 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_COPYSTATUS
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_COPYSTATUS"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 221 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_COPYSTATUS_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_COPYSTATUS_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_NOTE
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_NOTE"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 2181 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PARTY
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PARTY"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 5641 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PARTYAGREEMENT
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PARTYAGREEMENT"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 1441 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PERMISSION
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PERMISSION"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 312700 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PERMISSIONPOLICY_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PERMISSIONPOLICY_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PERMISSIONPURPOSE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PERMISSIONPURPOSE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PERMISSIONTYPE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PERMISSIONTYPE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_POLICY
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_POLICY"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 217401 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_POLICYSTATUS_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_POLICYSTATUS_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_POLICYTYPE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_POLICYTYPE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_POLICY_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_POLICY_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PRIVACYSTATUS_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PRIVACYSTATUS_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PRIVACY_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_PRIVACY_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_RELATIONSHIP
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_RELATIONSHIP"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 1021 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_RELATIONSHIP_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_RELATIONSHIP_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_ROLE
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_ROLE"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 661 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_ROLE_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_ROLE_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_STATUS_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_STATUS_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_TRIMRECORD
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_TRIMRECORD"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 5441 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_TRIMSTATUS_LU
--------------------------------------------------------

   CREATE SEQUENCE  "RMS_OS"."SQ_TRIMSTATUS_LU"  MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table AGREEMENT
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."AGREEMENT" 
   (	"AGREEMENTID" NUMBER, 
	"EXTENT" VARCHAR2(250), 
	"COLLECTION" VARCHAR2(50), 
	"AGREEMENTDATE" DATE, 
	"STATUS_LU_ID" NUMBER, 
	"NOTE" VARCHAR2(4000), 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50), 
	"FORMTYPE" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table CONDITION
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."CONDITION" 
   (	"CONDITIONID" NUMBER, 
	"TIMEOPERATOR" VARCHAR2(10), 
	"TIMEYEARS" NUMBER, 
	"EVENTOPERATOR" VARCHAR2(10), 
	"EVENT" VARCHAR2(50), 
	"POLICYID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table CONTACT
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."CONTACT" 
   (	"CONTACTID" NUMBER, 
	"PARTYID" NUMBER, 
	"CONTACTTYPE_LU_ID" NUMBER, 
	"PRIVACY_LU_ID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"PREFERRED" VARCHAR2(10), 
	"NOTE" VARCHAR2(4000), 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table CONTACTDETAIL
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."CONTACTDETAIL" 
   (	"CONTACTDETAILID" NUMBER, 
	"CONTACTID" NUMBER, 
	"KEY" VARCHAR2(250), 
	"VALUE" VARCHAR2(250)
   ) ;
--------------------------------------------------------
--  DDL for Table CONTACTTYPE_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."CONTACTTYPE_LU" 
   (	"CONTACTTYPE_LU_ID" NUMBER, 
	"CODE" VARCHAR2(50), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table COPYDETAILS
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."COPYDETAILS" 
   (	"COPYDETAILSID" NUMBER, 
	"COPYPID" VARCHAR2(38), 
	"COPYROLE_LU_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table COPYROLE_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."COPYROLE_LU" 
   (	"COPYROLE_LU_ID" NUMBER, 
	"COPYROLE" VARCHAR2(15), 
	"DISPLAY" VARCHAR2(15)
   ) ;
--------------------------------------------------------
--  DDL for Table COPYSET
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."COPYSET" 
   (	"COPYSETID" NUMBER, 
	"COPYDETAILSID" NUMBER, 
	"ROLEID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50), 
	"AGREEMENTID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table COPYSTATUS
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."COPYSTATUS" 
   (	"COPYSTATUSID" NUMBER, 
	"COPYDETAILSID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"NOTE" VARCHAR2(2000), 
	"DATEDETERMINED" DATE, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table NOTE
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."NOTE" 
   (	"NOTEID" NUMBER, 
	"PARTYID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"NOTE" VARCHAR2(4000), 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PARTY
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PARTY" 
   (	"PARTYID" NUMBER, 
	"PEPOID" VARCHAR2(50), 
	"STATUS_LU_ID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50), 
	"SURNAME" VARCHAR2(250), 
	"FORENAME" VARCHAR2(250), 
	"BIRTHDATE" VARCHAR2(250), 
	"DEATHDATE" VARCHAR2(250), 
	"FAMILYNAME" VARCHAR2(250), 
	"CORPORATENAME" VARCHAR2(250), 
	"AUTHORITYID" VARCHAR2(50), 
	"IMAGE" VARCHAR2(250)
   ) ;
--------------------------------------------------------
--  DDL for Table PARTYAGREEMENT
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PARTYAGREEMENT" 
   (	"PARTYAGREEMENTID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"PARTYID" NUMBER, 
	"AGREEMENTID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PERMISSION
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PERMISSION" 
   (	"PERMISSIONID" NUMBER, 
	"ORIGINALPERMISSIONID" NUMBER, 
	"PERMISSIONTYPE_LU_ID" NUMBER, 
	"PERMISSIONPOLICY_LU_ID" NUMBER, 
	"POLICY_LU_ID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"PERMISSIONHOLDER" VARCHAR2(50), 
	"DETAILS" VARCHAR2(4000), 
	"NOTE" VARCHAR2(4000), 
	"TRIGGERDATE" DATE, 
	"TIMEOPERATOR" VARCHAR2(10), 
	"TIMEYEARS" NUMBER, 
	"EVENTOPERATOR" VARCHAR2(10), 
	"EVENT" VARCHAR2(50), 
	"AGREEMENTID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50), 
	"PERMISSIONPURPOSE_LU_ID" NUMBER, 
	"RULE" VARCHAR2(250)
   ) ;
--------------------------------------------------------
--  DDL for Table PERMISSIONPOLICY_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PERMISSIONPOLICY_LU" 
   (	"PERMISSIONPOLICY_LU_ID" NUMBER, 
	"CODE" VARCHAR2(50), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PERMISSIONPURPOSE_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PERMISSIONPURPOSE_LU" 
   (	"PERMISSIONPURPOSE_LU_ID" NUMBER, 
	"CODE" VARCHAR2(50), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PERMISSIONTYPE_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PERMISSIONTYPE_LU" 
   (	"PERMISSIONTYPE_LU_ID" NUMBER, 
	"CODE" VARCHAR2(50), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table PRIVACY_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."PRIVACY_LU" 
   (	"PRIVACY_LU_ID" NUMBER, 
	"CODE" VARCHAR2(50), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table RELATED_ROLE
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."RELATED_ROLE" 
   (	"RELATED_ROLEID" NUMBER, 
	"ROLEID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table RELATIONSHIP
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."RELATIONSHIP" 
   (	"RELATIONSHIPID" NUMBER, 
	"RELATIONSHIP_LU_ID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"DELEGATOR" NUMBER, 
	"DELEGATEE" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table RELATIONSHIP_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."RELATIONSHIP_LU" 
   (	"RELATIONSHIP_LU_ID" NUMBER, 
	"CODE" VARCHAR2(20), 
	"LABEL" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table ROLE
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."ROLE" 
   (	"ROLEID" NUMBER, 
	"ROLE_LU_ID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"PARTYID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table ROLE_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."ROLE_LU" 
   (	"ROLE_LU_ID" NUMBER, 
	"CODE" VARCHAR2(20), 
	"LABEL" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for Table STATUS_LU
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."STATUS_LU" 
   (	"STATUS_LU_ID" NUMBER, 
	"CODE" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for Table TRIMRECORD
--------------------------------------------------------

  CREATE TABLE "RMS_OS"."TRIMRECORD" 
   (	"TRIMRECORDID" NUMBER, 
	"STATUS_LU_ID" NUMBER, 
	"TRIMREFNUMBER" VARCHAR2(256), 
	"DESCRIPTION" VARCHAR2(2000), 
	"TRIMDATE" DATE, 
	"POLICYID" NUMBER, 
	"ORIGINALPOLICYID" NUMBER, 
	"COPYDETAILSID" NUMBER, 
	"AUDITDATE" DATE, 
	"AUDITUSER" VARCHAR2(50), 
	"CREATEDATE" DATE, 
	"CREATEUSER" VARCHAR2(50), 
	"PARTYID" NUMBER, 
	"AGREEMENTID" NUMBER
   ) ;

---------------------------------------------------
--   DATA FOR TABLE AGREEMENT
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.AGREEMENT
Insert into RMS_OS.AGREEMENT (AGREEMENTID,EXTENT,COLLECTION,AGREEMENTDATE,STATUS_LU_ID,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,FORMTYPE) values (3742,'All material in the Pictures Collection','pictures',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),1,null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin','pictures');
Insert into RMS_OS.AGREEMENT (AGREEMENTID,EXTENT,COLLECTION,AGREEMENTDATE,STATUS_LU_ID,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,FORMTYPE) values (3741,'All material in the Music, Pictures Collections',null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),1,null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin','multi');

---------------------------------------------------
--   END DATA FOR TABLE AGREEMENT
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE CONDITION
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.CONDITION

---------------------------------------------------
--   END DATA FOR TABLE CONDITION
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE CONTACT
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.CONTACT
Insert into RMS_OS.CONTACT (CONTACTID,PARTYID,CONTACTTYPE_LU_ID,PRIVACY_LU_ID,STATUS_LU_ID,PREFERRED,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (2321,5623,1,23,1,'Y',null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.CONTACT (CONTACTID,PARTYID,CONTACTTYPE_LU_ID,PRIVACY_LU_ID,STATUS_LU_ID,PREFERRED,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (2322,5623,5,23,1,null,null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.CONTACT (CONTACTID,PARTYID,CONTACTTYPE_LU_ID,PRIVACY_LU_ID,STATUS_LU_ID,PREFERRED,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (2323,5623,2,21,1,null,null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.CONTACT (CONTACTID,PARTYID,CONTACTTYPE_LU_ID,PRIVACY_LU_ID,STATUS_LU_ID,PREFERRED,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (2324,5624,1,23,1,null,null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.CONTACT (CONTACTID,PARTYID,CONTACTTYPE_LU_ID,PRIVACY_LU_ID,STATUS_LU_ID,PREFERRED,NOTE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (2325,5624,2,23,1,'Y',null,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');

---------------------------------------------------
--   END DATA FOR TABLE CONTACT
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE CONTACTDETAIL
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.CONTACTDETAIL
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6101,2321,'line1','100 Main Street');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6102,2321,'line2',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6103,2321,'line3',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6104,2321,'postcode','2600');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6105,2321,'country',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6106,2321,'suburb','Canberra');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6107,2321,'addressee',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6108,2321,'state','ACT');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6109,2322,'mobile','040000001');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6110,2323,'email','mrcave@bogus.com');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6111,2324,'line1','100 Side Street');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6112,2324,'line2',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6113,2324,'line3',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6114,2324,'postcode','2600');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6115,2324,'country',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6116,2324,'suburb','Canberra');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6117,2324,'addressee',null);
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6118,2324,'state','ACT');
Insert into RMS_OS.CONTACTDETAIL (CONTACTDETAILID,CONTACTID,KEY,VALUE) values (6119,2325,'email','kyles@bogus.com');

---------------------------------------------------
--   END DATA FOR TABLE CONTACTDETAIL
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE CONTACTTYPE_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.CONTACTTYPE_LU
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (1,'postal','Postal');
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (2,'email','Email');
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (3,'ah_phone','Phone (After Hours)');
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (4,'bh_phone','Phone (Business Hours)');
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (5,'mobile','Mobile');
Insert into RMS_OS.CONTACTTYPE_LU (CONTACTTYPE_LU_ID,CODE,LABEL) values (6,'fax','Fax');

---------------------------------------------------
--   END DATA FOR TABLE CONTACTTYPE_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE COPYDETAILS
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.COPYDETAILS
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227082,'nla.cat-vn3789336',1);
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227083,'nla.cat-vn2638579',1);
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227084,'nla.cat-vn1797502',1);
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227086,'nla.cat-vn1971673',1);
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227081,'nla.cat-vn4609450',1);
Insert into RMS_OS.COPYDETAILS (COPYDETAILSID,COPYPID,COPYROLE_LU_ID) values (227085,'nla.cat-vn152021',1);

---------------------------------------------------
--   END DATA FOR TABLE COPYDETAILS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE COPYROLE_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.COPYROLE_LU
Insert into RMS_OS.COPYROLE_LU (COPYROLE_LU_ID,COPYROLE,DISPLAY) values (1,'o','Original');

---------------------------------------------------
--   END DATA FOR TABLE COPYROLE_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE COPYSET
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.COPYSET

---------------------------------------------------
--   END DATA FOR TABLE COPYSET
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE COPYSTATUS
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.COPYSTATUS

---------------------------------------------------
--   END DATA FOR TABLE COPYSTATUS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE NOTE
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.NOTE

---------------------------------------------------
--   END DATA FOR TABLE NOTE
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PARTY
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PARTY
Insert into RMS_OS.PARTY (PARTYID,PEPOID,STATUS_LU_ID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,SURNAME,FORENAME,BIRTHDATE,DEATHDATE,FAMILYNAME,CORPORATENAME,AUTHORITYID,IMAGE) values (5622,null,1,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',null,null,null,null,null,null,'858154',null);
Insert into RMS_OS.PARTY (PARTYID,PEPOID,STATUS_LU_ID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,SURNAME,FORENAME,BIRTHDATE,DEATHDATE,FAMILYNAME,CORPORATENAME,AUTHORITYID,IMAGE) values (5623,null,1,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',null,null,null,null,null,null,'67460',null);
Insert into RMS_OS.PARTY (PARTYID,PEPOID,STATUS_LU_ID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,SURNAME,FORENAME,BIRTHDATE,DEATHDATE,FAMILYNAME,CORPORATENAME,AUTHORITYID,IMAGE) values (5624,null,1,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'RMS',null,null,null,null,null,null,'19834',null);

---------------------------------------------------
--   END DATA FOR TABLE PARTY
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PARTYAGREEMENT
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PARTYAGREEMENT
Insert into RMS_OS.PARTYAGREEMENT (PARTYAGREEMENTID,STATUS_LU_ID,PARTYID,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (1421,1,5623,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.PARTYAGREEMENT (PARTYAGREEMENTID,STATUS_LU_ID,PARTYID,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (1423,1,5624,3742,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.PARTYAGREEMENT (PARTYAGREEMENTID,STATUS_LU_ID,PARTYID,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (1422,1,5624,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');

---------------------------------------------------
--   END DATA FOR TABLE PARTYAGREEMENT
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PERMISSION
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PERMISSION
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312680,312680,1,3,null,1,'Everyone','access allowed on the Library''s premises or while on loan in other libraries',null,null,null,null,null,null,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r4');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312681,312681,21,3,null,1,'Everyone','exhibition allowed at the Library and other institutions',null,null,null,null,null,null,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r10');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312682,312682,2,3,null,1,'Everyone','copying allowed for research, study or personal use',null,null,null,null,null,null,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r15');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312683,312683,3,3,null,1,'Everyone','Library may provide copies for publishing and public use by other people and organisations',null,null,null,null,null,null,3741,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r40');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312684,312684,1,3,null,1,'Everyone','access allowed on the Library''s premises or while on loan in other libraries',null,null,null,null,null,null,3742,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r4');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312685,312685,21,3,null,1,'Everyone','exhibition allowed at the Library and other institutions',null,null,null,null,null,null,3742,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r10');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312686,312686,2,3,null,1,'Everyone','copying allowed for research, study or personal use',null,null,null,null,null,null,3742,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r15');
Insert into RMS_OS.PERMISSION (PERMISSIONID,ORIGINALPERMISSIONID,PERMISSIONTYPE_LU_ID,PERMISSIONPOLICY_LU_ID,POLICY_LU_ID,STATUS_LU_ID,PERMISSIONHOLDER,DETAILS,NOTE,TRIGGERDATE,TIMEOPERATOR,TIMEYEARS,EVENTOPERATOR,EVENT,AGREEMENTID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER,PERMISSIONPURPOSE_LU_ID,RULE) values (312687,312687,3,3,null,1,'Everyone','Library may provide copies for publishing and public use by other people and organisations',null,null,null,null,null,null,3742,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',null,'r40');

---------------------------------------------------
--   END DATA FOR TABLE PERMISSION
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PERMISSIONPOLICY_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PERMISSIONPOLICY_LU
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (1,'permission_required','Permission required');
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (2,'closed','Closed');
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (3,'open','Open');
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (4,'part_open_part_permission_required','Part open/Part permission required');
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (5,'part_open_part_closed','Part open/Part closed');
Insert into RMS_OS.PERMISSIONPOLICY_LU (PERMISSIONPOLICY_LU_ID,CODE,LABEL) values (6,'part_permission_required_part_closed','Part permission required/part closed');

---------------------------------------------------
--   END DATA FOR TABLE PERMISSIONPOLICY_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PERMISSIONPURPOSE_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PERMISSIONPURPOSE_LU
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (1,'online','Online');
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (2,'publications_merchandise_publicity','Library publications, Merchandise, Publicity');
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (3,'merchandise','Merchandise');
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (22,'publicity','Publicity');
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (23,'publications','Publications');
Insert into RMS_OS.PERMISSIONPURPOSE_LU (PERMISSIONPURPOSE_LU_ID,CODE,LABEL) values (24,'specific_exhibition_publication','Specific Exhibition or Publication');

---------------------------------------------------
--   END DATA FOR TABLE PERMISSIONPURPOSE_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PERMISSIONTYPE_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PERMISSIONTYPE_LU
Insert into RMS_OS.PERMISSIONTYPE_LU (PERMISSIONTYPE_LU_ID,CODE,LABEL) values (1,'access','Access');
Insert into RMS_OS.PERMISSIONTYPE_LU (PERMISSIONTYPE_LU_ID,CODE,LABEL) values (2,'copying','Copying');
Insert into RMS_OS.PERMISSIONTYPE_LU (PERMISSIONTYPE_LU_ID,CODE,LABEL) values (3,'publishing','Publishing/Public use');
Insert into RMS_OS.PERMISSIONTYPE_LU (PERMISSIONTYPE_LU_ID,CODE,LABEL) values (21,'exhibition','Exhibition');

---------------------------------------------------
--   END DATA FOR TABLE PERMISSIONTYPE_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE PRIVACY_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.PRIVACY_LU
Insert into RMS_OS.PRIVACY_LU (PRIVACY_LU_ID,CODE,LABEL) values (21,'request','Public on request');
Insert into RMS_OS.PRIVACY_LU (PRIVACY_LU_ID,CODE,LABEL) values (22,'public','Public');
Insert into RMS_OS.PRIVACY_LU (PRIVACY_LU_ID,CODE,LABEL) values (23,'internal','Internal use only');

---------------------------------------------------
--   END DATA FOR TABLE PRIVACY_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE RELATED_ROLE
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.RELATED_ROLE

---------------------------------------------------
--   END DATA FOR TABLE RELATED_ROLE
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE RELATIONSHIP
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.RELATIONSHIP
Insert into RMS_OS.RELATIONSHIP (RELATIONSHIPID,RELATIONSHIP_LU_ID,STATUS_LU_ID,DELEGATOR,DELEGATEE,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (1001,1,1,5623,5624,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');

---------------------------------------------------
--   END DATA FOR TABLE RELATIONSHIP
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE RELATIONSHIP_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.RELATIONSHIP_LU
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (41,'nominee_after_death','Nominee after Death');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (42,'power_attorney','Power Attorney');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (43,'rep_Donating_Org','Rep Donating Org');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (44,'executor','Executor');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (1,'Heir','has a Heir');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (2,'Contact','has a Contact');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (3,'Agent','has an Agent');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (4,'Trustee','has a Trustee of Estate');
Insert into RMS_OS.RELATIONSHIP_LU (RELATIONSHIP_LU_ID,CODE,LABEL) values (5,'Guardian','has a Guardian');

---------------------------------------------------
--   END DATA FOR TABLE RELATIONSHIP_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE ROLE
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.ROLE
Insert into RMS_OS.ROLE (ROLEID,ROLE_LU_ID,STATUS_LU_ID,PARTYID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (641,53,1,5623,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.ROLE (ROLEID,ROLE_LU_ID,STATUS_LU_ID,PARTYID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (642,47,1,5623,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.ROLE (ROLEID,ROLE_LU_ID,STATUS_LU_ID,PARTYID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (643,48,1,5623,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');
Insert into RMS_OS.ROLE (ROLEID,ROLE_LU_ID,STATUS_LU_ID,PARTYID,AUDITDATE,AUDITUSER,CREATEDATE,CREATEUSER) values (644,50,1,5624,to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin',to_timestamp('24-JAN-10 01.00.00.000000000 PM','DD-MON-RR HH.MI.SS.FF AM'),'admin');

---------------------------------------------------
--   END DATA FOR TABLE ROLE
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE ROLE_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.ROLE_LU
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (41,'cartographer','Cartographer');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (42,'choreographer','Choreographer');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (43,'composer','Composer');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (44,'copyright_owner','Copyright Owner');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (45,'editor','Editor');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (46,'interviewee','Interviewee');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (47,'lyricist','Lyricist');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (48,'music_arranger','Music Arranger');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (49,'notator','Notator');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (50,'performer','Performer');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (51,'speaker','Speaker');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (52,'surveyor','Surveyor');
Insert into RMS_OS.ROLE_LU (ROLE_LU_ID,CODE,LABEL) values (53,'copyright_owner','Copyright Owner');

---------------------------------------------------
--   END DATA FOR TABLE ROLE_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE STATUS_LU
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.STATUS_LU
Insert into RMS_OS.STATUS_LU (STATUS_LU_ID,CODE) values (1,'Active');
Insert into RMS_OS.STATUS_LU (STATUS_LU_ID,CODE) values (2,'Deleted');
Insert into RMS_OS.STATUS_LU (STATUS_LU_ID,CODE) values (4,'Archived');
Insert into RMS_OS.STATUS_LU (STATUS_LU_ID,CODE) values (3,'Draft');

---------------------------------------------------
--   END DATA FOR TABLE STATUS_LU
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE TRIMRECORD
--   FILTER = none used
---------------------------------------------------
REM INSERTING into RMS_OS.TRIMRECORD

---------------------------------------------------
--   END DATA FOR TABLE TRIMRECORD
---------------------------------------------------
