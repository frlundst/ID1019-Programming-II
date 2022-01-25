defmodule Derivative do

  @type literal() ::  {:num, number()}  | {:var, atom()}
  @type expr() :: {:exp, literal(), {:num, number()}}
  | {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | {:sub, expr(), expr()}
  | {:div, expr(), expr()}
  | {:ln, expr()}
  | {:sqrt, expr()}
  | literal()
  
  @spec deriv(expr(), atom()) :: expr()

  def test() do
    #test = {:add, {:mul, {:num, 4}, {:exp, {:var, :x}, {:num, 2}}}, {:add, {:mul, {:num, 3}, {:var, :x}}, {:num, 42}}}
    # 4x^2 + 3x + 42
    #test = {:add, {:mul, {:num, 4}, {:exp, {:var, :x}, {:num, 2}}}, {:ln,{:var, :x}}}
    #4x^2 + ln(x)
    expression = {:ln,{:var, :x}}
    #ln(x)
    #test = {:sub, {:mul, {:num, 4}, {:exp, {:var, :x}, {:num, 2}}}, {:mul, {:num, 3}, {:var, :x}}}
    #4x^2 - 3x
    derived = deriv(test, :x)
    simplifyed = simplify(der)

    IO.write("expression: #{pprint(expression)}\n")
    IO.write("derivative: #{pprint(derived)}\n")
    IO.write("simplified: #{pprint(simplifyed)}\n")
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:add, e1, e2}, v) do {:add, deriv(e1, v), deriv(e2, v)} end
  def deriv({:mul, e1, e2}, v) do {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}} end
  def deriv({:exp, e1, {:num, c}}, v) do {:mul, {:mul, {:num, c}, {:exp, e1, {:num, c - 1}}}, deriv(e1, v)} end
  def deriv({:sub, e1, e2}, v) do {:sub, deriv(e1, v), deriv(e2, v)} end
  def deriv({:ln, v}, _) do {:div, {:num, 1}, v} end

  def simplify({:num, n}) do {:num, n} end
  def simplify({:var, v}) do {:var, v} end
  def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end
  def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end
  def simplify({:exp, e1, e2}) do simplify_exp(simplify(e1), simplify(e2)) end
  def simplify({:sub, e1, e2}) do simplify_sub(simplify(e1), simplify(e2)) end
  def simplify({:ln, v}) do {:ln, v} end
  def simplify({:div, e1, e2}) do simplify_div(simplify(e1), simplify(e2)) end

  def simplify_add({:num, 0}, e2) do e2 end  
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add({:var, v}, {:var, v}) do {:mul, {:num, 2}, {:var, v}} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_sub({:num, 0}, e2) do e2 end
  def simplify_sub({:num, n1}, {:num, n2}) do {:num, n1-n2} end
  def simplify_sub({:var, v}, {:var, v}) do {:num, 0} end
  def simplify_sub(e1, e2) do {:sub, e1, e2} end

  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end    
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end    
  def simplify_mul({:var, v}, {:var, v}) do {:exp, {:var, v}, {:num, 2}} end
  def simplify_mul({:var, v}, {:exp, {:var, v}, {:num, n}}) do {:exp, {:var, v}, {:num, n+1}} end  
  def simplify_mul({:exp, {:var, v}, {:num, n}}, {:var, v}) do {:exp, {:var, v}, {:num, n+1}} end
  
  def simplify_mul({:num, n1}, {:mul, {:num, n2}, e2}) do {:mul, {:num, n1*n2}, e2} end
  def simplify_mul({:num, n1}, {:mul, e2, {:num, n2}}) do {:mul, {:num, n1*n2}, e2} end
  def simplify_mul({:mul, {:num, n1}, e1}, {:num, n2}) do {:mul, {:num, n1*n2}, e1} end
  def simplify_mul({:mul, e1, {:num, n1}}, {:num, n2}) do {:mul, {:num, n1*n2}, e1} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end  

  def simplify_exp(_,{:num, 0}) do  1 end  
  def simplify_exp(e1,{:num, 1}) do  e1 end
  def simplify_exp(e1,e2) do {:exp, e1, e2} end

  def simplify_div(e1,e2) do {:div, e1, e2} end

  def print({:num, n}) do "#{n}" end
  def print({:var, v}) do "#{v}" end
  def print({:add, e1, e2}) do
    "#{pprint(e1)} + #{pprint(e2)}"
  end
  def print({:sub, e1, e2}) do
    "#{pprint(e1)} - #{pprint(e2)}"
  end
  def print({:mul, e1, e2}) do
    "( #{pprint(e1)} * #{pprint(e2)} )"
  end  
  def print({:exp, e1, e2}) do
    "#{pprint(e1)}^#{pprint(e2)}"
  end
  def print({:div, e1, e2}) do
    "#{pprint(e1)} / #{pprint(e2)}"
  end
  def print({:ln, e}) do
    "ln(#{pprint(e)})"
  end

end

Derivative.test()