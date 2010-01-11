<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=<?= c->encoding =~ /utf/ ? 'UTF-8': 'Shift_JIS' ?>" />
    <title><? block title => 'Amon' ?></title>
    <meta http-equiv="Content-Style-Type" content="text/css" />  
    <meta http-equiv="Content-Script-Type" content="text/javascript" />  
    <link href="<?= uri_for('/static/css/main.css') ?>" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
    <div id="Container">
        <div id="Header">
            <a href="<?= uri_for('/') ?>">Amon Startup Page</a>
        </div>
        <div id="Content">
? if (login_user()) {
            Hello, <?= login_user()->nick() ?>
? }
            <? block content => 'body here' ?>
        </div>
        <div id="FooterContainer"><div id="Footer">
            Powered by Amon
        </div></div>
    </div>
</body>
</html>
