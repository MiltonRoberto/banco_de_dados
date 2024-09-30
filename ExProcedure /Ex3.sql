CREATE OR REPLACE FUNCTION totalProcessos (integer)
RETURNS integer AS $total$
DECLARE total integer;
BEGIN
  SELECT count(*) into total FROM processo where id <= $1;
  RETURN total;
END;
$total$
LANGUAGE plpgsql;
