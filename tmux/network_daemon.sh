#!/bin/bash
# Фоновый демон для обновления IP/DNS в tmux status bar.
# Использует tmux user options (@tmux_ip / @tmux_dns) вместо файлов —
# это мгновенно и не вызывает "communication error".

LOCK="/tmp/tmux_network_daemon.lock"

# Убиваем старого демона по lock-файлу
if [[ -f "$LOCK" ]]; then
  old_pid=$(cat "$LOCK" 2>/dev/null)
  [[ -n "$old_pid" ]] && kill "$old_pid" 2>/dev/null
  sleep 0.2
fi

echo $$ > "$LOCK"
trap 'rm -f "$LOCK"; exit 0' TERM EXIT

old_ip=""
old_dns=""

# Функция обновления tmux-переменных
_tmux_set() {
  tmux set -g "$1" "$2" 2>/dev/null
}

while true; do
  # 1. Получаем IPv4: curl -4 форсирует IPv4, fallback dig
  ip=""
  ip=$(curl -4 --max-time 3 -s https://api.ipify.org 2>/dev/null)
  if [[ -z "$ip" ]]; then
    ip=$(curl -4 --max-time 3 -s https://ipv4.icanhazip.com 2>/dev/null)
  fi
  if [[ -z "$ip" ]]; then
    ip=$(dig +tries=1 +timeout=2 +short -4 A myip.opendns.com @resolver1.opendns.com 2>/dev/null)
  fi

  # 2. Получаем DNS
  dns=$(awk '/^nameserver/{print $2; exit}' /etc/resolv.conf 2>/dev/null)

  # 3. Обновляем tmux-переменные только при изменении (чтобы не гонять tmux set)
  if [[ "$ip" != "$old_ip" ]]; then
    old_ip="$ip"
    _tmux_set "@tmux_ip" "$ip"
  fi

  if [[ "$dns" != "$old_dns" ]]; then
    old_dns="$dns"
    _tmux_set "@tmux_dns" "$dns"
  fi

  # 4. Форсируем refresh tmux и ждём 10 секунд до следующего опроса
  tmux refresh-client -S 2>/dev/null
  sleep 10
done
