# symfonyのプロジェクトをdockerで動かすデモアプリ

### Cloud9環境でSymfonyデモプロジェクトを作成

php7.3インストールして切り替え
```
sudo yum -y install php73 php73-mbstring php73-pdo
sudo unlink /usr/bin/php
sudo ln -s /usr/bin/php-7.3 /usr/bin/php
```

composerインストール
https://getcomposer.org/download/を参照
```
sudo mv composer.phar /usr/local/bin/composer
```


symfonyクライアントをインストール
```
wget https://get.symfony.com/cli/installer -O - | bash
export PATH="$HOME/.symfony/bin:$PATH"
```

デモプロジェクト作成
```
composer create-project symfony/website-skeleton my-project
composer require doctrine/annotations
```

LuckyControllerを作成
```
<?php
// src/Controller/LuckyController.php
namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LuckyController
{
    /**
     * @Route("/lucky/number")
     */
    public function number()
    {
        $number = random_int(0, 100);

        return new Response(
            '<html><body>Lucky number: '.$number.'</body></html>'
        );
    }
}
```

symfonyを起動して http://PUBLIC_IP:8000/lucky/number　で動作確認。
Cloud9が動くEC2のIPに対してアクセスすればよい。SecurityGroupはMyIPでPort80を許可すること
```
docker build -t symfony-demo .
docker images

docker run -p 80:80 -d symfony-demo
docker ps
docker stop <CONTAINER_ID>
```


### Docker関連

Dockerfileの中でmy-projectをdocker imageにセットしている
Apacheの設定ファイルや環境変数をセットすることでSymfonyの実行が可能になる

