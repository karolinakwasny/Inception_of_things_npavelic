# Check or generate SSH key for user 'iot'
if [ ! -f /home/iot/.ssh/id_rsa ]; then
  echo "🔐 SSH key not found for user 'kart', generating one now..."
  sudo -u iot ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f /home/iot/.ssh/id_rsa -N ""
  echo
  echo "⚠️  Please add the following SSH public key to your GitLab account (Settings > SSH Keys):"
  sudo cat /home/iot/.ssh/id_rsa.pub
  echo
  echo "Then re-run this script."
  exit 1
fi

if [ ! -f /root/.ssh/id_rsa ]; then
  echo "Copying SSH private key for root user..."
  sudo mkdir -p /root/.ssh
  sudo cp /home/iot/.ssh/id_rsa /root/.ssh/id_rsa
  sudo cp /home/iot/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
  sudo chmod 600 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub
fi
