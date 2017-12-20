require 'ruby2d'
require 'json'

class Vizualizer
  def initialize(*args)
    @window = Ruby2D::Window.new();
    @width = args[0];
    @height = args[1];
    @window.set(width: @width, height: @height, title: args[2]);
    @blocks = args[3];
    @states = args[4];
    @tick = 0
    @counter = 0;
    self.run();
  end

  def run()
    @window.update() do
      if @tick % 1 == 0
        @window.set(background: Ruby2D::Color.new([0.0,0.0,0.0,1.0]));
        if(@counter < @states.length)
          state = JSON.parse(@states[@counter]);
          # p(state);
          @window.clear();
          self.drawRects(state);
          @counter += 1;
        end
      end
      @tick += 1
    end

    @window.show();
  end

  def drawRects(state)
    p(state);
    width = (@width.to_f/@blocks.to_f);
    height = (@height.to_f-10)/@blocks.to_f;
    # puts("width: #{width}\theight: #{height}\n");
    state.each_with_index do |x,i|
      h = (height * x.to_i) + 5;
      # puts("x: #{i*width}\ty: #{@height}\tw: #{width}\th: #{-1*h}\n")
      @window.add(Ruby2D::Rectangle.new(x: (i*width),y: @height,width: width,height: -1*h));
    end
    return;
  end
end
