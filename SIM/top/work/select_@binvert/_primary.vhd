library verilog;
use verilog.vl_types.all;
entity select_Binvert is
    generic(
        alu_add         : integer := 0
    );
    port(
        ALUCode         : in     vl_logic_vector(4 downto 0);
        Binvert         : out    vl_logic
    );
end select_Binvert;
