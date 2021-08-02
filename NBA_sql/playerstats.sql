select * from players;
select * from advancestats;
-- used, gorup by, order by, inner join, temp tables's

-- delete all rows where the player has "TOT" for team
-- this mean they were traded in the middle of the season
delete from players
where Tm = 'TOT';

delete from advancestats
where Tm = 'TOT';

-- inner join on players and adv3pt_shooting_percentage3pt_shooting_percentageft_shooting_percentageance stats to get the columns we need
-- everything else after this query will use this table instead
drop table if exists season;
create table season
(
Rk numeric, Player nvarchar(255), Pos nvarchar(255), Tm nvarchar(255),
G numeric, MP numeric, FG numeric, FGA numeric, 3P numeric, 3PA numeric,
2P numeric, 2PA numeric, FT numeric, FTA numeric, TS float
);

insert into season (Rk, Player, Pos, Tm, G, MP, FG, FGA, 3P, 3PA, 2P, 2PA, FT, FTA, TS)
select p.Rk, p.Player, p.Pos, p.Tm, p.G, p.MP, p.FG, p.FGA, p.3P, 
p.3PA, p.2P, p.2PA, p.FT, p.FTA, a.TS
from players p
-- where MP > 300
join advancestats a on p.Rk = a.Rk
where p.MP > 500
order by Rk;

select * from season;

-- Creating Views --


--  view for displaying 3 point percentage
drop view if exists 3pt_shooting_percentage;
create view 3pt_shooting_percentage as
select Player, Tm, 3PA, 3P, 3P/3PA as threeptpercent
from season
where 3P > 60
-- group by Tm
order by 3P desc, threeptpercent desc;

select * from 3pt_shooting_percentage;



-- view for displaying 2 point percentages
drop view if exists 2pt_shooting_percentage;
create view 2pt_shooting_percentage as
select Player, Tm, 2PA, 2P, 2P/2PA as twoptpercent
from season
where 2P > 150
order by 2P desc, twoptpercent desc;

select * from 2pt_shooting_percentage;



-- view for displaying Freethrow percentages
drop view if exists FT_shooting_percentage;
create view FT_shooting_percentage as
select Player, Tm, FTA, FT, FT/FTA as freethowpercent
from season
where FT > 70
order by FT desc, freethowpercent desc;

select * from FT_shooting_percentage;

-- view for true shooting
drop view if exists Trueshoot;
create view Trueshoot as 
select Player, TS as Trueshooting
from season
where TS > 0.6 and 3*3P + 2*2p > 500
order by Trueshooting desc;

select * from Trueshoot


