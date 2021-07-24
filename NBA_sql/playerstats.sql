select * from players;

-- delete all rows where the player has "TOT" for team
-- this mean they were traded in the middle of the season
delete from players
where Tm = 'TOT';

-- get the players with the highest minutes played
select Player, MP as minutes_played from players
order by MP desc;

-- minutes per game average Tm
select Player, Tm, MP as minutes_played, MP/G as average_minutes
from players
order by average_minutes desc;

-- Who drew the most fouls by using free throws to count
select Player, FT
from players 
order by FT desc;

-- rename all coloumns that have a % to have per instead
alter table players
rename column FG% to FGPer;
-- figure out how to renmae the column
-- how to deal with %

-- get player with the highest FT percentage for those who have shot more than 15
select Player, FT, FTA, FT/FTA as FTPER
from players
where FTA >=15
order by FTPER desc;

-- get players with the highest 3pt percentage per team and 2pt percentage
select Player, Tm, max(3P/3PA) as threeptpercent 
from players
where 3PA >=30
group by Tm;






