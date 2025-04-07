# Laravel

## テスト

### 基礎・概要・用語

- スイート
    一式という意味

Unit    : 単体
Feature : 機能

## 問題

providersで
`'driver' => 'eloquent'`を指定すると、パスワードが常に期待される。

```php auth.php
    'providers' => [
        'users' => [
            'driver' => 'eloquent',
            'model' => App\Models\User::class,
```

Auth::attempt()が常にパスワードを参照している状態。

### 解決方法

password参照している部分をオーバーライドした、新しいProviderを作る.

```php
<?php

namespace App\Providers;

use Illuminate\Auth\EloquentUserProvider;
use Illuminate\Contracts\Auth\Authenticatable;

class GuestUserProvider extends EloquentUserProvider
{
    /**
     * Retrieve a user by the given credentials.
     *
     * @param array $credentials
     * @return Authenticatable|null
     */
    public function retrieveByCredentials(array $credentials)
    {
        // If the credentials array is empty, return null
        if (empty($credentials)) {
            return null;
        }

        // Get the phone number and reservation number from the credentials array
        $s_representative_phone = $credentials['s_representative_phone'];
        $s_reserve_code = $credentials['s_reserve_code'];

        // Query the user by the phone number and reservation number
        return $this->createModel()
            ->newQuery()
            ->where('s_representative_phone', $s_representative_phone)
            ->where('s_reserve_code', $s_reserve_code)
            ->first();
    }

    /**
     * Validate a user against the given credentials.
     *
     * @param Authenticatable $user
     * @param array $credentials
     * @return bool
     */
    public function validateCredentials(Authenticatable $user, array $credentials)
    {
        if (
            $user->s_reserve_code === $credentials['s_reserve_code'] &&
            $user->s_representative_phone === $credentials['s_representative_phone']
        ) {
            return true;
        }

        return false;
    }
}
```
