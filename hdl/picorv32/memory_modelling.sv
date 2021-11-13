module memory_modelling (input logic clk, 
	                input logic [3:0] mem_la_wstrb, 
			input logic [31:0] mem_la_wdata, 
			input logic [31:0] mem_la_addr, 
			input logic mem_la_read,
			input logic mem_la_write,
			input logic mem_instr,
			input logic mem_valid,
			output logic mem_ready, 
			output logic [31:0] mem_rdata);
	
  logic [31:0] foobar [logic [31:0]];

  always @(posedge clk) begin
    // On every clock cycle checking for reading
    mem_ready <= 1;
    if (mem_la_read) begin
      mem_rdata = mem_read (mem_la_addr);
    end
    // On evry clock cycle checking for writing
    if(mem_la_write == 1) begin
      mem_write (mem_la_addr, mem_la_wstrb, mem_la_wdata);
    end

  end

  // Read function
  function logic [31:0] mem_read(input logic [31:0] m_addr);
    logic [31:0] mem_rdata;
        mem_rdata = foobar[m_addr >> 2];
    return mem_rdata;
  endfunction

  // Write task
  task mem_write(input logic [31:0] mem_addr, input logic [3:0] write_strobe, input logic [31:0] wdata);
     logic [31:0] m_addr;

       m_addr = mem_addr >> 2;
       if (write_strobe[0]) foobar[m_addr][ 7: 0] = wdata[ 7: 0];
       if (write_strobe[1]) foobar[m_addr][15: 8] = wdata[15: 8];
       if (write_strobe[2]) foobar[m_addr][23:16] = wdata[23:16];
       if (write_strobe[3]) foobar[m_addr][31:24] = wdata[31:24];
  endtask

endmodule
