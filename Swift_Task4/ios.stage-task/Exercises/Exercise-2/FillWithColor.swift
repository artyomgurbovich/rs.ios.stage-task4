import Foundation

final class FillWithColor {
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        guard image.count > 0 && image[0].count > 0 && row < image.count && column < image[0].count else { return image }
        var result = image
        let targetColor = result[row][column]
        fillWithColorMove(&result, newColor, targetColor, row, column)
        return result
    }
        
    func fillWithColorMove(_ result: inout [[Int]], _ newColor: Int, _ targetColor: Int , _ row: Int, _ column: Int) {
        guard result[row][column] == targetColor && result[row][column] != newColor else { return }
        result[row][column] = newColor
        if row > 0 {
            fillWithColorMove(&result, newColor, targetColor, row - 1, column)
        }
        if row + 1 < result.count {
            fillWithColorMove(&result, newColor, targetColor, row + 1, column)
        }
        if column > 0 {
            fillWithColorMove(&result, newColor, targetColor, row, column - 1)
        }
        if column + 1 < result[0].count {
            fillWithColorMove(&result, newColor, targetColor, row, column + 1)
        }
    }
}
