with Ada.Text_IO; use Ada.Text_IO;

procedure main is
   time : Duration := 10.0;
   stop : Boolean := False;

   task type breaker;
   task type counter(How_Many: Positive);

   task body breaker is
   begin
      delay (time);
      stop := true;
   end breaker;

   task body counter is
      sum : Long_Long_Integer := 0;
      add : Long_Long_Integer := 3;
      count : Long_Long_Integer := 0;
   begin
      for id in 1..How_Many loop
         loop
            sum := sum + add;
            count := count + 1;
            exit when stop;
         end loop;
         delay 0.1;
         Put_Line(id'Img & " -" & sum'Img & " -" & count'Img);
      end loop;
   end counter;

   break : breaker;
   threads : counter(How_Many => 5);

begin
   null;
end main;
