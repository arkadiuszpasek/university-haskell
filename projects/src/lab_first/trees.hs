module Trees where 

    data BTree t = Empty | Node (BTree t) t (BTree t) deriving Show

    generate :: t -> BTree t
    generate x = Node Empty x Empty

    empty :: BTree t -> Bool
    empty Empty = True
    empty _ = False

    isBinary :: (Ord t) => BTree t -> Bool
    isBinary Empty = False
    isBinary (Node Empty value Empty) = True
    isBinary (Node (Node tLeft value1 tRight) value Empty) = 
        (value1 < value) &&
        (isBinary tRight) &&
        (isBinary tLeft)
    isBinary (Node Empty value (Node tLeft value1 tRight)) = 
        (value1 > value) &&
        (isBinary tRight) &&
        (isBinary tLeft)
    isBinary (Node (Node tLeft1 value1 tRight1) value (Node tLeft2 value2 tRight2)) = 
        (value1 < value) &&
        (value2 > value) &&
        (isBinary tRight1) &&
        (isBinary tLeft1) &&
        (isBinary tRight2) &&
        (isBinary tLeft2)

    isBalanced :: BTree t -> Bool
    isBalanced Empty = False
    isBalanced (Node tLeft value tRight) = (abs ((height tLeft) - (height tRight))) <= 1

    height :: BTree t -> Integer
    height Empty = 0
    height (Node tLeft value tRight) = 
        1 + (max (height tLeft) (height tRight))

    search _ Empty = False
    search x (Node tLeft value tRight)
        | x == value = True
        | x < value = search x tLeft
        | x > value = search x tRight

    toString :: (Show t) => BTree t -> [Char]
    toString Empty = ""
    toString (Node tLeft value tRight) = (show value) ++ "(" ++ toString(tLeft) ++ "," ++ toString(tRight) ++ ")"

    insert x Empty = Node Empty x Empty
    insert x (Node tLeft value tRight)
        | value == x = Node tLeft value tRight
        | value < x = Node tLeft value (insert x tRight)
        | value > x = Node (insert x tLeft) value tRight

    traverseVLR Empty = [] 
    traverseVLR (Node tLeft value tRight) = [value] ++ (traverseVLR tLeft) ++ (traverseVLR tRight)
    traverseLVR Empty = [] 
    traverseLVR (Node tLeft value tRight) = (traverseVLR tLeft) ++ [value] ++ (traverseVLR tRight)
    traverseLRV Empty = [] 
    traverseLRV (Node tLeft value tRight) = (traverseVLR tLeft) ++ (traverseVLR tRight) ++ [value]
    traverseVRL Empty = [] 
    traverseVRL (Node tLeft value tRight) = [value] ++ (traverseVLR tRight) ++ (traverseVLR tLeft)
    traverseRVL Empty = [] 
    traverseRVL (Node tLeft value tRight) = (traverseVLR tRight) ++ [value] ++ (traverseVLR tLeft)
    traverseRLV Empty = [] 
    traverseRLV (Node tLeft value tRight) = (traverseVLR tRight) ++ (traverseVLR tLeft) ++ [value]

    leaves :: BTree t -> [t] 
    leaves Empty = []
    leaves (Node tLeft value tRight)
        | empty tLeft && empty tRight = [value]
        | otherwise = (leaves tLeft) ++ (leaves tRight)

    nnodes :: BTree t -> Integer
    nnodes Empty = 0
    nnodes (Node tLeft value tRight) = 1 + (nnodes tLeft) + (nnodes tRight)

    nsum Empty = 0 
    nsum (Node tLeft value tRight) = value + (nsum tLeft) + (nsum tRight)

    tmap f Empty = Empty
    tmap f (Node tLeft value tRight) = (Node (tmap f tLeft) (f value) (tmap f tRight))

    remove :: (Ord a) => a -> BTree a -> BTree a
    remove _ Empty = Empty
    remove x (Node Empty value Empty)
        | x == value = Empty
        | otherwise = (Node Empty value Empty)
    remove x (Node Empty value tRight)
        | x == value = tRight
        | otherwise = (Node Empty value (remove x tRight))
    remove x (Node tLeft value Empty)
        | x == value = tLeft
        | otherwise = (Node (remove x tLeft) value Empty)
    remove x (Node tLeft value tRight)
            | value == x = (Node (remove s tLeft) s (remove s tRight))
            | value < x = (Node tLeft value (remove x tRight))
            | value > x = (Node (remove x tLeft) value tRight)
            where s = (successor (Node tLeft value tRight))

    successor (Node Empty _ tRight) = lElement tRight
    successor (Node tLeft _ Empty) = rElement tLeft
    successor (Node tLeft _ tRight) = rElement tLeft

    lElement (Node Empty value _) = value
    lElement (Node tLeft _ _) = lElement tLeft

    rElement (Node _ value Empty) = value
    rElement (Node _ _ tRight) = rElement tRight

    merge t1 (Node Empty value Empty) = insert value t1
    merge (Node Empty value Empty) t1 = insert value t1
    merge t1 (Node tLeft value tRight) = (merge (merge (insert value t1) tRight) tLeft)
    merge (Node tLeft value tRight) t1 = (merge (merge (insert value t1) tRight) tLeft)
