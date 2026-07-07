class ram_monitor;
ram_trans t3;
mailbox #(ram_trans)m_sb;
virtual ram.mon vif;
covergroup mon_cg;
data_out:coverpoint t3.data_out{bins dout={[0:255]};}
endgroup
function new(virtual ram.mon vif,mailbox#(ram_trans)m_sb);
this.vif=vif;
this.m_sb=m_sb;
mon_cg=new;
endfunction
task start();
repeat(5)@(vif.mon_cb);
for(int i=0;i<=10;i++)
begin
t3=new;
repeat(1)@(vif.mon_cb);
t3.data_out=vif.mon_cb.data_out;
$display("monitor out data_out %d at %t\n",t3.data_out,$time);
m_sb.put(t3);
mon_cg.sample();
end
endtask
endclass
