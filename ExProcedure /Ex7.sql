CREATE OR REPLACE FUNCTION RecordTotal ()
RETURNS integer AS $total$
DECLARE total integer;
BEGIN
  SELECT count(*) into total FROM COMPANY;
  RETURN total;
END;
$total$ 
LANGUAGE plpgsql;

select RecordTotal();
