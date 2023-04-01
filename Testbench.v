module tb();

reg clk, write, read;
reg [7:0] data_in_tb;
reg [15:0] address_tb;
wire [8:0] data_out_tb;
reg [8:0] data_temp;


typedef struct{
	reg [7:0] data_in_tb; // data to write 
	reg [15:0] address_tb; //address to read/write
	reg [8:0] data_expected; //expected data read 
	reg [8:0] data_read; // Actual Data to read 
} transactions;


my_mem dl (.clk(clk),
				.write(write),
				.read(read),
				.data_in(data_in_tb),
				.address(address_tb),
				.data_out(data_out_tb)
				);

transactions transaction_array [6];
transactions transaction;
transactions queue[$];

//logic [8:0] expected_array [int], index =1;

always #5 clk = ~clk;

int i,Error_count;

initial begin
//transaction_array = new[6];
	clk = 0;
	read=0;
	write =0;
	$vcdpluson;
	$dumpfile("dump.vcd");
	$dumpvars;


//write 
write = 1;
int i = 0;
do begin
    address_tb = queue[i].address_tb;
    data_in_tb = queue[i].data_in_tb;

    @(posedge clk);
    $display("Write Address: %h \t Data to write: %h\n", address_tb, data_in_tb);

    i++;
end while (i < 6);

end
endmodule