# TriBaikala WebApp

Веб-приложение для отображения карты квестов TriBaikala - работает на мобильных телефонах и компьютерах.

## 🚀 Быстрый старт

### Вариант 1: GitHub Pages (Рекомендуется - работает на телефонах!)

1. **Создать репозиторий на GitHub:**
   - Откройте https://github.com/new
   - Назовите его `tribaikala-webapp`
   - Выберите "Public" (чтобы работало на GitHub Pages)
   - Нажмите "Create repository"

2. **Скопировать файлы:**
   ```bash
   # Клонируйте новый репозиторий
   git clone https://github.com/ВАШ-ЛОГИН/tribaikala-webapp.git
   cd tribaikala-webapp
   
   # Скопируйте все файлы из папки webapp-deploy (кроме .git)
   # Скопируйте: map.html, index.html, nginx.conf, README.md, .github папку
   ```

3. **Закоммитить и запушить:**
   ```bash
   git add .
   git commit -m "Initial commit: TriBaikala WebApp"
   git push -u origin main
   ```

4. **Активировать GitHub Pages:**
   - Перейдите в Settings репозитория → Pages
   - Source: "Deploy from a branch"
   - Branch: "main" / "/ (root)"
   - Нажмите Save
   - Дождитесь завершения деплоя (зелёная галочка)

5. **Получить URL приложения:**
   - URL: `https://ВАШ-ЛОГИН.github.io/tribaikala-webapp/`

6. **Настроить API сервер:**
   - Отредактируйте map.html
   - Найдите переменную `TRIBAIKALA_API_URL`
   - Установите реальный адрес вашего API сервера (например: `https://tribaikala-api.com`)

### Вариант 2: Локальная разработка

```bash
# Просто откройте map.html в браузере
# Или используйте локальный сервер:
python -m http.server 8080
# Откройте http://localhost:8080
```

## 📱 Использование в Telegram

Бот автоматически формирует ссылку на WebApp:
```
https://tribaikala.github.io/tribaikala-webapp/map.html?user_id=123456789&api_url=https://ваш-api.com
```

Параметры:
- `user_id` - ID пользователя Telegram
- `api_url` - адрес API сервера (опционально)

## ⚙️ Конфигурация API

Приложение поддерживает несколько способов указания API URL:

### 1. Через параметр URL (приоритет 1)
```
map.html?user_id=123&api_url=https://api.tribaikala.com
```

### 2. Через localStorage (приоритет 2)
```javascript
localStorage.setItem('tribaikala_api_url', 'https://api.tribaikala.com');
```

### 3. Через глобальную переменную (приоритет 3)
```javascript
window.TRIBAIKALA_API_URL = 'https://api.tribaikala.com';
```

### 4. По умолчанию (приоритет 4)
- GitHub Pages: `https://api.tribaikala.com`
- Локально: `http://localhost:8001`

## 🔒 HTTPS обязателен для Telegram!

Telegram WebApp требует HTTPS. Для GitHub Pages это работает автоматически.

Если ваш API находится на локальной машине:
- ✅ Используйте LocalTunnel: `npm install -g localtunnel && lt --port 8001`
- ✅ Используйте ngrok: `ngrok http 8001`
- ✅ Развертайте API на сервере с HTTPS

## 📊 Структура API

Приложение взаимодействует со следующими endpoints:

### Получение квестов
```
GET /api/quests?user_id=123&limit=50
```

Ответ:
```json
[
  {
    "id": 1,
    "title": "Название квеста",
    "description": "Описание",
    "category_id": 1,
    "category_name": "Природа",
    "category_emoji": "🌲",
    "lat": 53.1925,
    "lng": 107.3333,
    "reward_amount": 25,
    "status": "active"
  }
]
```

### Проверка статуса администратора
```
GET /api/admin/check?user_id=123
```

### Создание квеста (только админ)
```
POST /api/admin/create_quest

{
  "user_id": 123,
  "title": "Новый квест",
  "description": "Описание",
  "category_id": 1,
  "reward_amount": 25,
  "lat": 53.1925,
  "lng": 107.3333
}
```

### Удаление квеста (только админ)
```
POST /api/quests/delete

{
  "user_id": 123,
  "quest_id": 1
}
```

## 🛠️ Поддерживаемые браузеры

- ✅ Chrome (Android)
- ✅ Safari (iOS)
- ✅ Firefox
- ✅ Samsung Internet
- ✅ Edge

## 🐛 Отладка

Откройте консоль браузера (F12) и посмотрите логи:

```javascript
// Проверить текущий API URL
console.log('API URL:', apiUrl);

// Проверить ID пользователя
console.log('User ID:', userId);

// Проверить статус Telegram WebApp
console.log('Telegram WebApp:', tg);
```

## 📝 Обновление приложения

1. Отредактируйте файлы (map.html, index.html и т.д.)
2. Закоммитьте и запушьте:
   ```bash
   git add .
   git commit -m "Update: описание изменений"
   git push
   ```
3. GitHub Pages обновится автоматически через GitHub Actions

## 🚨 Проблемы и решения

### Приложение не загружается
- Проверьте консоль браузера (F12)
- Убедитесь, что API сервер запущен и доступен
- Проверьте CORS настройки на сервере

### Квесты не появляются
- Проверьте API URL в консоли
- Убедитесь, что endpoint `/api/quests` возвращает корректные данные
- Проверьте network вкладку в DevTools

### Администратор не может создавать квесты
- Проверьте, что пользователь добавлен в ADMIN_ID или ALLOWED_ADMIN_IDS
- Убедитесь, что API возвращает `is_admin: true`

## 📞 Поддержка

Для проблем с:
- **WebApp**: смотрите консоль браузера (F12)
- **API**: проверьте логи сервера
- **Deployment**: смотрите Actions tab на GitHub

## 📄 Лицензия

MIT