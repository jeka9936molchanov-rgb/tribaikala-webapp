# Скрипт для развертывания веб-приложения на GitHub Pages (PowerShell версия)

# Полный путь к Git
$gitPath = "git"

# Проверяем, есть ли изменения в папке webapp-deploy
$gitStatus = & $gitPath status --porcelain . 2>$null
if ([string]::IsNullOrEmpty($gitStatus)) {
  Write-Host "Нет изменений в папке webapp-deploy"
  exit 0
}

# Инициализируем git репозиторий
& $gitPath init
& $gitPath config user.name "GitHub Actions"
& $gitPath config user.email "actions@github.com"

# Добавляем все файлы
& $gitPath add .

# Создаем коммит
& $gitPath commit -m "Deploy to GitHub Pages"

# Добавляем удаленный репозиторий
& $gitPath remote add origin "https://$env:GITHUB_ACTOR:$env:GITHUB_TOKEN@github.com/$env:GITHUB_REPOSITORY.git"

# Принудительно отправляем изменения в ветку gh-pages
& $gitPath push --force origin main:gh-pages

Write-Host "Развертывание на GitHub Pages завершено"