defmodule Emulator do

  def run(prgm) do
	{code, data} = Program.load(prgm)
	out = Out.new()
    reg = Register.new()
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, data, out) do
    next = Program.read_instruction(code, pc)
    case next do

    {:halt} ->
	    Out.close(out)

    {:out, rs} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
		out = Out.put(out, s)
	    run(pc, code, reg, data, out)
	
    {:add, rd, rs, rt} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s + t)
	    run(pc, code, reg, data, out)

    {:sub, rd, rs, rt} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s - t)
	    run(pc, code, data, reg, out)

    {:addi, rd, rs, imm} ->
	  	pc = pc + 4
		IO.write("#{pc} : addi, #{rd}, #{rs}, #{imm}")
	    s = Register.read(reg, rs)
	    reg = Register.write(reg, rd, s + imm)
	    run(pc, code, data, reg, out)

	{:lable, :loop} ->
		run(pc, code, data, reg, out)

    {:beq, rs, rt, imm} ->
		pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s == t do 
				pc+imm 
			else 
				pc 
			end
	    run(pc, code, data, reg, out)

    {:bne, rs, rt, imm} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s != t do 
				pc+imm 
			else 
				pc 
			end
	    run(pc, code, data, reg, out)

    {:lw, rd, rs, imm} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)	
	    addr = s + imm
	    val = Program.read_data(data, addr) # read data from address
	    reg = Register.write(reg, rd, val)
	    run(pc, code, data, reg, out)
      
    {:sw, rs, rt, imm} ->
	  	pc = pc + 4
	    vs = Register.read(reg, rs)
	    vt = Register.read(reg, rt)	
	    addr = vt + imm
	    data = Program.write_data(data, addr, vs) # write and read from address
	    run(pc, code, data, reg, out)
    end
  end

end