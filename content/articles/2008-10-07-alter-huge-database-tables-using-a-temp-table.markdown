---
title: Alter huge database tables using a temp table
tags:
- sql
- oracle
---

In this case I had to delete some entries and alter the primary key of a huge 
table. I couldn't just fire up the DELETE and ALTER statements, because this 
would take to long. Causing in unnecessary DB load and a longer down-time.

The trick is to copy only the needed data to a temporary table, do the changes
and swap the new and old tables. Please note, that the original table was not
in productional use at this time, so no data was updated resp. lost!

* Create a new table `offer_pop_new` with the content of `offer_pop`. Instead
  of deleting the entries just filter them.

  {{sql
  create table offer_pop_new as
  select *
  from offer_pop
  where id_channel not in ('priceminister_product_fr', 'priceminister_query_fr')
  ;
  }}

* Alter the new table to your needs. For example adding a new primary key.

  {{sql
  alter table offer_pop_new
  add PRIMARY KEY ("ID_OFFER", "ID_CATEGORY", "ID_CHANNEL", "ID_CHANNELGROUP")
  }}

* Swap the two tables `current` to `old` and `new` to `current`

  {{sql
  alter table offer_pop rename to offer_pop_old;
  alter table offer_pop_new rename to offer_pop;
  }}

* Done!
