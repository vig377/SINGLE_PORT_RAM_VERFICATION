class ram_scoreborad;
ram_trans t4,t5;
mailbox #(ram_trans)m_sb;
mailbox #(ram_trans)mbx_dr_sb;
logic [7:0]mem[32];
int match=0;
int mismatch=0;
function new(mailbox #(ram_trans)m_sb,mailbox#(ram_trans)mbx_dr_sb);
this.m_sb=m_sb;
this.mbx_dr_sb=mbx_dr_sb;
foreach(mem[i])
mem[i]=8'bz;
endfunction
task start();
for(int i=0;i<=10;i++)
begin
mbx_dr_sb.get(t4);
m_sb.get(t5);
if(t4.reset==0)
begin
foreach(mem[i])
mem[i]=8'bz;
if(t5.data_out===8'bz)
        $display("RESET DATA_OUT PASS");
    else
        $display("RESET DATA_OUT FAIL");

    continue;

end

 if(t4.write_enb&&!t4.read_enb)
begin
mem[t4.address]=t4.data_in;
$display(" scoreborad : write addr %d data %d at %t\n",t4.address,t4.data_in,$time);
end
else if(t4.read_enb&&!t4.write_enb)
begin
if(mem[t4.address]===t5.data_out)
begin
match++;
$display("scoreborad :pass addr %d exp %d actual %d at %t \n",t4.address,mem[t4.address],t5.data_out,$time);
end
else
begin
mismatch++;
$display("scoreborad: fail addr %d exp %d actual %d at %t\n",t4.address,mem[t4.address],t5.data_out,$time);
end
end
else if(t4.read_enb&&t4.write_enb)
begin
if(t5.data_out===8'bz)
begin
match++;
$display("scoreborad :pass no chnage in concurent addr %d dut %d local  %d at %t\n",t4.address,t5.data_out,mem[t4.address],$time);
end
else
begin
mismatch++;
$display("scoreboard :fail   chnage in concurent addr %d dut %d local  %d at %t\n",t4.address,t5.data_out,mem[t4.address],$time);
end
end
end
$display("total tansact %d match =%d mismatch =%d\n",match+mismatch,match,mismatch);
endtask
endclass

