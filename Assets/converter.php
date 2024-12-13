<?php

ini_set("memory_limit", "6000M");

$PAGES = new RecursiveDirectoryIterator("./");
$ITERATOR = new RecursiveIteratorIterator($PAGES);
// $REGEX = new RegexIterator($ITERATOR, "/^.+\.png|\.jpg|\.jpeg$/i", RecursiveRegexIterator::GET_MATCH);
$REGEX = new RegexIterator($ITERATOR, "/^.+\.jpg$/i", RecursiveRegexIterator::GET_MATCH);

foreach ($REGEX as $file => $value) {
  if (str_contains($file, "import")) continue;

  $name = $file;
  $new_name = str_replace(".jpg", ".jpg", $name);

  $new_size = 512;
  // if (str_contains($name, "_full")) $new_size = 1280;

  // Create and save
  $img = imagecreatefromjpeg($name);
  if (!$img) continue;
  // $size = min(imagesx($img), imagesy($img));
  // $height = imagesy($img);
  // $width = imagesx($img);
  // $im2 = imagecrop($img, ['x' => $width * .1, 'y' => $height * .1, 'width' => $width * .9, 'height' => $height * .9]);
  $img = imagescale($img, $new_size, -1, IMG_NEAREST_NEIGHBOUR);
  imagepalettetotruecolor($img);
  imagealphablending($img, true);
  imagesavealpha($img, true);
  imagejpeg($img, $new_name, 100);
  imagedestroy($img);
}
