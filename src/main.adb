with Ada.Text_IO; use Ada.Text_IO;

procedure main is
   num_counters : Integer := 8;
   add : Long_Long_Integer := 3;
   time : Duration := 5.0;
   stop : Boolean := False;
   pragma Volatile (stop);

   task type breaker;
   task type counter is entry start(id: in Integer);
   end counter;

   task body breaker is
   begin
      delay (time);
      stop := true;
   end breaker;

   task body counter is
      sum : Long_Long_Integer := 0;
      count : Long_Long_Integer := 0;
      id: Integer;
   begin
      accept start (id : in integer) do counter.id := id;
      end start;
      loop
         sum := sum + add;
         count := count + 1;
         exit when stop;
      end loop;
      delay 0.1;
      Put_Line(id'Img & " -" & sum'Img & " -" & count'Img);
   end counter;

   break : breaker;
   thread : array(1..num_counters) of counter;

   begin
   for i in thread'Range loop
      thread(i).start(i);
   end loop;
end main;
