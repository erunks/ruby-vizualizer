class SortAlgorthim
  attr_reader :size, :array, :states;

  def initialize(*args)
    @rand = Random.new(Time.now.nsec);
    @rand.seed();
    @size = args[0];
    @array = (Array.new(@size){|index| index+1}).shuffle;
    @states = [];
  end

  def swap(i,j,array)
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;

    return array;
  end

  def bubbleSort(n, m, array)
    @states.push(array.to_s());
    if(n == 0)
      return array;
    end

    (1..n-1).each do |i|
      if(array[i-1] > array[i])
        array = self.swap(i-1, i, array);
        m = i;
      end
    end
    n = m;

    self.bubbleSort(n, 0, array);
  end

  def quickSort(first, last, array)
    @states.push(array.to_s());
    if (first < last)
      pIndex = self.quickPartition(first, last, array);
      self.quickSort(first, pIndex-1, array);
      self.quickSort(pIndex+1, last, array);
    end

    return array;
  end

  def quickPartition(first, last, array)
    pivot = array[last];

    i = first-1;
    (first...last).each do |j|
      if(array[j] <= pivot)
        i += 1;
        array = self.swap(i, j, array);
      end
    end

    if(array[last] < array[i+1])
      array = self.swap(i+1, last, array);
    end
    return i + 1;
  end

  def insertionSort(array)
    @states.push(array.to_s());
    (1...array.length).each do |n|
      j = n;
      while ((j > 0) && (array[j-1] > array[j]))
        array = self.swap(j,j-1,array);
        j -= 1;
      end
      @states.push(array.to_s());
    end

    return array;
  end

  def selectionSort(array)
    (0...array.length).each do |j|
      @states.push(array.to_s());
      min = j;
      ((j+1)...array.length).each do |i|
        if(array[i] < array[min])
          min = i;
        end
      end

      if(min != j)
        array = self.swap(j,min,array);
      end
    end

    return array;
  end

  def mergeSortBottomUp(array)
    width = 1;
    @states.push(array.to_s());
    while(width < array.length)
      temp = Array.new(array.length);
      low = 0;
      while(low < array.length)
        mid = [low+width,array.length].min();
        high = [low+(2*width),array.length].min();
        temp = self.bottomUpMerge(low, mid, high, array, temp);
        low += 2*width;
      end
      array = temp.inject([]){|a,e| a << e.dup};
      width *= 2;
      @states.push(array.to_s());
    end

    return array;
  end

  def bottomUpMerge(low, mid, high, array, temp)
    i = low;
    j = mid;

    (low...high).each do |k|
      if((i < mid) && ((j >= high) || (array[i] <= array[j])))
        temp[k] = array[i];
        i += 1;
      else
        temp[k] = array[j];
        j += 1;
      end
    end

    return temp;
  end

  def mergeSortTopDown(array)
    temp = Array.new(array.length);
    temp = array.inject([]){|a,e| a << e.dup};
    @states.push(temp.to_s());
    return self.topDownSplitMerge(0, array.length, array, temp);
  end

  def topDownSplitMerge(b, e, array, temp)
    if(e - b < 2)
      return array;
    end
    mid = (e + b) / 2;
    temp = self.topDownSplitMerge(b, mid, temp, array);
    temp = self.topDownSplitMerge(mid, e, temp, array);
    temp = self.topDownMerge(b, mid, e, temp, array);

    @states.push(temp.to_s());
    return temp;
  end

  def topDownMerge(low, mid, high, array, temp)
    return self.bottomUpMerge(low, mid, high, array, temp);
  end

  def combSort(array)
    @states.push(array.to_s());
    gap = array.length;
    shrink = 1.3;
    sorted = false;

    while(!sorted) do
      gap = (gap/shrink).floor();
      if(gap > 1)
        sorted = false;
      else
        gap = 1;
        sorted = true;
      end

      i = 0;
      while(i + gap < array.length) do
        if(array[i] > array[i+gap])
          array = self.swap(i,i+gap,array);
          sorted = false;
          @states.push(array.to_s());
        end
        i += 1;
      end
    end

    return array;
  end

  def cocktailSort(array)
    @states.push(array.to_s());
    loop do
      swapped = false;
      (0..array.length-2).each do |i|
        if(array[i] > array[i+1])
          array = self.swap(i,i+1,array);
          swapped = true;
          @states.push(array.to_s());
        end
      end
      if (!swapped) then break end;

      (array.length-2..0).each do |i|
        if(array[i] > array[i+1])
          array = self.swap(i,i+1,array);
          swapped = true;
          @states.push(array.to_s());
        end
      end
      if (!swapped) then break end;
    end

    return array;
  end


  def radixSort(array, base=10)
    def listToBuckets(array, base, iteration)
      buckets = [];
      (0..base).each do |i|
        buckets.push([]);
      end

      array.each_with_index do |n,i|
        digit = (n/(base ** iteration)).floor() % base;
        # puts("#{iteration},\tNumber: #{n},\tDigit: #{digit},\ti: #{i}");
        buckets[digit].push(n);
      end

      # puts("#{iteration},\tbuckets: #{buckets}\n\n");

      return buckets;
    end

    def bucketsToList(buckets)
      numbers = [];
      buckets.each do |bucket|
        bucket.each do |n|
          numbers.push(n);
        end
      end

      # puts("Numbers: #{numbers}\n\n");

      return numbers;
    end

    maxVal = array.max();
    i = 0;

    @states.push(array.to_s());
    while((base ** i) <= maxVal) do
      # puts("#{base ** i} <= #{maxVal}\n\n");
      array = bucketsToList(listToBuckets(array, base, i));
      i += 1;
      @states.push(array.to_s());
    end

    return array;
  end

end
