#!/bin/bash
# 살림연구소 비서실 현황판 → https://woriappa.github.io/ 재배포
# 사용법: bash work/ghpages_sallim/deploy.sh ["2026-11-28 09:00"]
#   인자를 주면 work/sallim_office/_src/rebuild.py 로 배지 시각만 바꿔 재조립한 뒤 배포합니다.
set -e
cd "$(dirname "$0")/../.."          # /workspace
if [ -n "$1" ]; then
  python3 work/sallim_office/_src/rebuild.py "$1"
fi
cp work/sallim_office/sallim_office.html work/ghpages_sallim/index.html
cd work/ghpages_sallim
git add index.html
git commit -q -m "현황판 갱신 $(date '+%Y-%m-%d %H:%M')" || echo "(변경 없음)"
git push -q origin main
echo "푸시 완료. 1~2분 뒤 https://woriappa.github.io/ 확인"
curl -s -o /dev/null -w "HTTP %{http_code}\n" https://woriappa.github.io/
