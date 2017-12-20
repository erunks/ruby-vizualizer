require './Vizualizer'
require './SortAlgorithm'

size = (ARGV.length > 0) ? ARGV[0].to_i() : 10;
sa = SortAlgorthim.new(size);
p(sa.array);
# sa.bubbleSort(sa.size, 0, sa.array);
# sa.quickSort(0, sa.size-1, sa.array);
# sa.insertionSort(sa.array);
# sa.selectionSort(sa.array);
# sa.mergeSortBottomUp(sa.array);
# sa.mergeSortTopDown(sa.array);
# sa.combSort(sa.array);
sa.cocktailSort(sa.array);
# sa.radixSort(sa.array);
puts("\n");
puts(sa.states);
p(ARGV)

viz = Vizualizer.new(1200,800,"Sorting Algorithm Vizualizer",size,sa.states);
