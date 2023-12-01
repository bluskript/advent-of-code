import Data.Char (isUpper, ord)

group :: Int -> [a] -> [[a]]
group _ [] = []
group n l
  | n > 0 = take n l : group n (drop n l)
  | otherwise = error "Negative or zero n"

index :: Char -> Integer
index c = toInteger $ fromEnum c - (if isUpper c then 39 else 97)

eachRucksack :: String -> String -> Char
eachRucksack [] _ = 0
eachRucksack (x : xs) y = max (eachRucksack xs y) (if x `elem` y then index x + 1 else 0)

getAnswer = sum .  . group 3 . lines

main :: IO ()
main = do
  text <- readFile "./input"
  print $ getAnswer text
