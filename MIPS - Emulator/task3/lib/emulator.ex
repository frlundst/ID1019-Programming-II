defmodule Emulator do

  def run(prgm) do
	{code, data} = Program.load(prgm)
	data = Tree.tree_insert(:arg, 12, data)
	out = Out.new()
    reg = Register.new()
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, data, out) do
    next = Program.read_instruction(code, pc)
    case next do

    {:halt} ->
	    Out.close(out)
		#{reg, data}
    {:out, rs} ->
	  	pc = pc + 4
	    s = Register.read(reg, rs)
		out = Out.put(out, s)
	    run(pc, code, reg, data, out)
	
    {:add, rd, rs, rt} ->
	  	pc = pc + 4
		IO.write("#{pc} : add, #{rd}, #{rs}, #{rt}\n")
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s + t)
	    run(pc, code, reg, data, out)

    {:sub, rd, rs, rt} ->
	  	pc = pc + 4
		IO.write("#{pc} : sub, #{rd}, #{rs}, #{rt}\n")
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    reg = Register.write(reg, rd, s - t)
	    run(pc, code, reg, data, out)

    {:addi, rd, rs, imm} ->
	  	pc = pc + 4
		IO.write("#{pc} : addi, #{rd}, #{rs}, #{imm}\n")
	    s = Register.read(reg, rs)
	    reg = Register.write(reg, rd, s + imm)
	    run(pc, code, reg, data, out)

	{:label, name} ->
		pc = pc + 4
		data = Tree.tree_insert(name, pc, data)
		run(pc, code, reg, data, out)

    {:beq, rs, rt, imm} ->
		pc = pc + 4
		IO.write("#{pc} : beq, #{rs}, #{rt}, #{imm}\n")
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s == t do 
				Program.read_address(data, imm)
			else 
				pc 
			end
	    run(pc, code, reg, data, out)

    {:bne, rs, rt, imm} ->
	  	pc = pc + 4
		IO.write("#{pc} : bne, #{rs}, #{rt}, #{imm}\n")
		
	    s = Register.read(reg, rs)
	    t = Register.read(reg, rt)
	    pc = if s != t do 
				Program.read_address(data, imm)
			else 
				pc 
			end
	    run(pc, code, reg, data, out)

    {:lw, rd, rs, imm} ->
	  	pc = pc + 4
		IO.write("#{pc} : lw, #{rd}, #{rs}, #{imm}\n")
	    s = Register.read(reg, rs)
	    addr = Program.read_address(data, imm) + s
	    reg = Register.write(reg, rd, addr)
	    run(pc, code, reg, data, out)
      
    {:sw, rs, rt, imm} ->
	  	pc = pc + 4
	    vs = Register.read(reg, rs)
	    vt = Register.read(reg, rt)
	    addr = vt + imm
	    data = Program.write_data(data, addr, vs)
	    run(pc, code, reg, data, out)
    end
  end
end