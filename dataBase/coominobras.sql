/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     7/6/2017 9:34:35 PM                          */
/*==============================================================*/


drop table if exists "CONDITION";

drop table if exists CREDIT;

drop table if exists CREDIT_CONDITION;

/*==============================================================*/
/* Table: "CONDITION"                                           */
/*==============================================================*/
create table "CONDITION"
(
   CONDID               int not null,
   CONDTERM             text,
   CONDRATE             text,
   primary key (CONDID)
);

/*==============================================================*/
/* Table: CREDIT                                                */
/*==============================================================*/
create table CREDIT
(
   CREDBENEFITS         text,
   CREDDESTINATION      text,
   CREDID               int not null,
   CREDNAME             text,
   CREDCONDITION        text,
   primary key (CREDID)
);

/*==============================================================*/
/* Table: CREDIT_CONDITION                                      */
/*==============================================================*/
create table CREDIT_CONDITION
(
   CREDID               int not null,
   CONDID               int not null,
   primary key (CREDID, CONDID)
);

alter table CREDIT_CONDITION add constraint FK_CREDIT_CONDITION foreign key (CREDID)
      references CREDIT (CREDID) on delete restrict on update restrict;

alter table CREDIT_CONDITION add constraint FK_CREDIT_CONDITION2 foreign key (CONDID)
      references "CONDITION" (CONDID) on delete restrict on update restrict;

