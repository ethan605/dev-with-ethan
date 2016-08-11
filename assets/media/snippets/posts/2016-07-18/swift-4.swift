extension String {
  subscript(range: Range<Int>) -> String {
    if range.startIndex >= self.characters.count {
      return ""
    }
    
    let startIndex = self.startIndex.advancedBy(range.startIndex)
    let endIndex = self.startIndex.advancedBy(range.endIndex, limit: self.endIndex)
    return self.substringWithRange(startIndex..<endIndex)
  }
}

"Swift Extension"[0...4]            // "Swift"
"Swift Extension"[11...14]          // "sion"
"Swift Extension"[11...17]          // "sion"
"Swift Extension"[16...17]          // ""
