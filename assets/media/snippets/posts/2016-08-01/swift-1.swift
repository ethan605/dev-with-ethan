func A() { print("Process A") }
func B() { var i = 1.0; for _ in 0..<10_000 { i *= 2 }; print("Process B") }
func C() { print("Process C") }
func D() { print("Process D") }
