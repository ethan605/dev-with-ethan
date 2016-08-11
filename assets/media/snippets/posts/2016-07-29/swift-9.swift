var array: [AnyObject?] = [1, 2, "3", 4.0, nil, 5]
print(array.unwrapped())            // nil

array = [1, 2, "3", 4.0, 5]
print(array.unwrapped())            // Optional[1, 2, 3, 4, 5]
