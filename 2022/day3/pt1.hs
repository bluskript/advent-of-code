import Data.Char (isUpper, ord)

index :: Char -> Integer
index c = toInteger $ fromEnum c - (if isUpper c then 39 else 97)

eachRucksack :: String -> String -> Integer
eachRucksack [] _ = 0
eachRucksack (x : xs) y = max (eachRucksack xs y) (if x `elem` y then index x + 1 else 0)

getRucksackPriority :: String -> Integer
getRucksackPriority x =
  let (first, second) = splitAt (length x `div` 2) x
   in eachRucksack first second

getAnswer = sum . map getRucksackPriority . lines

main :: IO ()
main = do
  text <- readFile "./input"
  print $ getAnswer text
