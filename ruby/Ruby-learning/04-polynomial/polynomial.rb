=begin rdoc
  For RPCFN: Ruby**Fun (#4)
  The Original Problem can be found here:
  http://rubylearning.com/blog/2009/11/26/rpcfn-rubyfun-4/

  Here is an excerpt:

  Write a class that pretty-prints polynomials, following some simple rules:

  * if a coefficient is 1, it doesn't get printed
  * if a coefficient is negative, you have to display something like "- 2x^3",
  not "+ -2x^3"
  * if a coefficient is 0, nothing gets added to the output
  * for x^1 the ^1 part gets omitted
  * x^0 == 1, so we don't need to display it

  Here's a couple of usage examples:

  puts Polynomial.new([-3,-4,1,0,6]) # => -3x^4-4x^3+x^2+6
  puts Polynomial.new([1,0,2]) # => x^2+2

  Don't concern yourself too much with error handling, but if somebody tries to
  create a polynomial with less than 2 elements, your program has to raise an
  ArgumentError with the message "Need at least 2 coefficients."

  =================================================
  Author:: Aurelien Bottazzini
=end
class Polynomial
  @coefficients

  def initialize(coefficients)
    
    if coefficients.count < 2
      raise ArgumentError, "Need at least 2 coefficients."
    end

    @coefficients = coefficients
  end

  # Pretty print
  def to_s
    string = String.new
    all_zero = true

    polynomial_degree = @coefficients.size
    @coefficients.each_with_index do | coef, index |
      if coef != 0
       
        # displaying coefficient sign
        string << sign(coef) unless all_zero == true && coef > 0
        # displaying coefficient when needed
        string << "#{coef.abs unless coef == 1 || coef == -1}"
        # computing degree for current coefficient
        string << "#{x(polynomial_degree - (index + 1))}"
        
        all_zero = false
      end
    end

    all_zero ? "0" : string
  end

  private

  def x(degree)
    case
    when degree == 1
      "x"
    when degree > 1
      "x^#{degree}"
    else
      String.new
    end
  end

  def sign(coef)
    coef > 0 ? "+" : "-"
  end

end
