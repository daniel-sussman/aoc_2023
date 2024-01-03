 "O....#....
  O.OO#....#
  .....##...
  OO.#O....O
  .O.....O#.
  O.#..O.#.#
  ..O..#O..O
  .......O..
  #....###..
  #OO..#...."



# grab positions of square blocks
col0 = [8, 9]
col1 = []
col2 = [5]
col3 = [3]
col4 = [1]
col5 = [0, 2, 6, 8, 9]
col6 = [2, 8]
col7 = [5, 8]
col8 = [4]
col9 = [1, 5]
# based on the loc of rocks in each column, the north position is ascertainable.
[4, 3, [1, 2], [1, 0], [0, 1], [0, 1, 0], [0, 1, 0], [1, 1, 0], [0, 0], [0, 1, 1]]
# there are a total of 5 rocks in the first elements of each column. Since there's a rock at 0 position only in col5, we divide this into 4 rocks in columns before col5 and 1 rock in columns after col5
#figuring west position, going by row:
[[4, 1], ...]
# next row: total rocks in this row: 1, 1, 0 (since 1 < 2), 0, 0, 0, 0 (1 < 2), 0, 0. two rocks in row1, col4 and col9. So:
[[4, 1], [2, 0]]
# next row: total rocks in this row: 1, 1, 0 (the boulder's in 5 and 1 < 3), 0 (boulder's in 3 and 1 < 3), 1 (boulder's in 1, so we get the 1 roller from second group), #, #, 0 (boulder's in 5 and 1 < 3), 0, 1 (boulder's in 1, so second group)
[[4, 1], [2, 0], [3, 1]]

800 - 96141
801 - 96124
802 - 96105
803 - 96094
804 - 96097
805 - 96095
806 - 96093
807 - 96096
808 - 96112
809 - 96132
810 - 96141
811 - 96141
812 - 96124
813 - 96105
814 - 96094

817 - 96093

822 - 96141 #?
