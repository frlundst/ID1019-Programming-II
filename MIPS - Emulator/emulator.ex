defmodule Emulator do

  def run(prgm) do
	{code, data} = Program.load(prgm)
	out = Out.new()
    reg = Register.new()
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, mem, out) do
    next = Program.read_instruction(code, pc)
    case next do

    {:halt} ->
	    Out.close(out)

    {:out, rs} ->
	  	pc = pc + 4
	    a = Register.read(reg, rs)
	    run(pc, code, reg, mem, out)
	
    {:add, rd, rs, rt} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s + t)
	    run(pc, code, reg, mem, out)

    {:sub, rd, rs, rt} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s - t)
	    run(pc, code, mem, reg, out)

    {:addi, rd, rs, imm} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    reg = Register.write(reg, rd, s + imm)
	    run(pc, code, mem, reg, out)

    {:beq, rs, rt, imm} ->
		pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s == t do 
				pc+imm 
			else 
				pc 
			end
	    run(pc, code, mem, reg, out)

    {:bne, rs, rt, imm} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s != t do 
				pc+imm 
			else 
				pc 
			end
	    run(pc, code, mem, reg, out)

    {:lw, rd, rs, imm} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)	
	    addr = s + imm
	    val = Memory.read(mem, addr)
	    reg = Register.write(reg, rd, val)
	    run(pc, code, mem, reg, out)
      
    {:sw, rs, rt, imm} ->
	  	pc = pc + 4
	    vs = Register.read(reg, rs)
	    vt = Register.read(reg, rt)	
	    addr = vt + imm
	    mem = Memory.write(mem, addr, vs)
	    run(pc, code, mem, reg, out)
    end
  end

end