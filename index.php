<?php
require_once('data.php');
require_once('helpers.php');

$main_content = include_template('main.php', [
    'cats' => $cats,
    'cards' => $cards
]);

$layout_content = include_template('layout.php', [
    'main_content' => $main_content,
    'cats' => $cats,
    'is_auth' => $is_auth,
    'user_name' => $user_name,
    'title' => $title
]);

echo $layout_content;
