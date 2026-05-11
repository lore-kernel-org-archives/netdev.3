Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CE23BD63D;
	Mon, 11 May 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489585; cv=none; b=dnSKPH50Z58NGbKcEagBjmRoMwB+tNt9YDBZGWtQusYTlbU3JoChIntecKxy1mg6SMLMwUxva2d9ugl+c/X4kl0i//LgvzWG6vi5DEotowe0HG5eVFi+c/GCBbP/ekh11ZPXo5/8KV6r5u+NSd5k+gFZyYbiiUYD3jiJZiw/8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489585; c=relaxed/simple;
	bh=ZVwEfbWxL/kjFIOQzU+C2EPYG5AfUI1qggMxCbUnbtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARtngG1QjDe+i3ADURtMwq/W/pt4wHkab0sdM52jroopE/pqc26U2Usxhb1nQ9bR+PSdgHZh0xEpdu+eiUpX7zyGRoA/Ky+LQaFLw+PUGKLVvOig/k8n52W1umAqj7nO6s9JuVkiMXuqG/32OqN2wAr/Hmy/h/6OFkwlo7Qi1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Qy5sxOumRaqsfdIMwbMEVg==
X-CSE-MsgGUID: KZRVB/AbQvKlRcm+2j3E6g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2026 17:53:03 +0900
Received: from [127.0.1.1] (unknown [10.226.78.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9F6C34009A31;
	Mon, 11 May 2026 17:53:00 +0900 (JST)
From: Michael Dege <michael.dege@renesas.com>
Date: Mon, 11 May 2026 10:52:13 +0200
Subject: [PATCH net-next v4 10/13] net: renesas: rswitch: clean up is_rdev
 rswitch_device checking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rswitch_add_vlans-v4-10-a5a225f8faae@renesas.com>
References: <20260511-rswitch_add_vlans-v4-0-a5a225f8faae@renesas.com>
In-Reply-To: <20260511-rswitch_add_vlans-v4-0-a5a225f8faae@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778489544; l=2714;
 i=michael.dege@renesas.com; s=20251023; h=from:subject:message-id;
 bh=ZVwEfbWxL/kjFIOQzU+C2EPYG5AfUI1qggMxCbUnbtw=;
 b=IWY6tGnfQogjhe+WHBXrqEMkFExEvnqPK9nohaMr6bPVqpFHyvrQS9LTlIvNFv8G5aD4knPbS
 uhsu0FAggm/C98qjV/kNb7M8fARTWfds3M7CTf7uHKovAzt0icT3DKY
X-Developer-Key: i=michael.dege@renesas.com; a=ed25519;
 pk=gu1rwIcCrAxNMv2I8fIfiQvt51xzZwnQy4Ua/DscQt8=

Add null pointer checking for ndev and remove unnecessay
rswitch_port_check() wrapper function.

Signed-off-by: Michael Dege <michael.dege@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch_l2.c   | 15 +++++----------
 drivers/net/ethernet/renesas/rswitch_main.c |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_l2.c b/drivers/net/ethernet/renesas/rswitch_l2.c
index 3cc0ce8762f3..dd8aecbcb2a8 100644
--- a/drivers/net/ethernet/renesas/rswitch_l2.c
+++ b/drivers/net/ethernet/renesas/rswitch_l2.c
@@ -158,11 +158,6 @@ static void rswitch_update_offload_brdev(struct rswitch_private *priv)
 	rswitch_update_l2_offload(priv);
 }
 
-static bool rswitch_port_check(const struct net_device *ndev)
-{
-	return is_rdev(ndev);
-}
-
 static void rswitch_port_update_brdev(struct net_device *ndev,
 				      struct net_device *brdev)
 {
@@ -199,7 +194,7 @@ static int rswitch_netdevice_event(struct notifier_block *nb,
 	struct netdev_notifier_changeupper_info *info;
 	struct net_device *brdev;
 
-	if (!rswitch_port_check(ndev))
+	if (!is_rdev(ndev))
 		return NOTIFY_DONE;
 	if (event != NETDEV_CHANGEUPPER)
 		return NOTIFY_DONE;
@@ -254,12 +249,12 @@ static int rswitch_switchdev_event(struct notifier_block *nb,
 
 	if (event == SWITCHDEV_PORT_ATTR_SET) {
 		ret = switchdev_handle_port_attr_set(ndev, ptr,
-						     rswitch_port_check,
+						     is_rdev,
 						     rswitch_port_attr_set);
 		return notifier_from_errno(ret);
 	}
 
-	if (!rswitch_port_check(ndev))
+	if (!is_rdev(ndev))
 		return NOTIFY_DONE;
 
 	return notifier_from_errno(-EOPNOTSUPP);
@@ -278,11 +273,11 @@ static int rswitch_switchdev_blocking_event(struct notifier_block *nb,
 		return -EOPNOTSUPP;
 	case SWITCHDEV_PORT_ATTR_SET:
 		ret = switchdev_handle_port_attr_set(ndev, ptr,
-						     rswitch_port_check,
+						     is_rdev,
 						     rswitch_port_attr_set);
 		break;
 	default:
-		if (!rswitch_port_check(ndev))
+		if (!is_rdev(ndev))
 			return NOTIFY_DONE;
 		ret = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index d00af333fcce..bb9ead193cd6 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1979,7 +1979,7 @@ static const struct net_device_ops rswitch_netdev_ops = {
 
 bool is_rdev(const struct net_device *ndev)
 {
-	return (ndev->netdev_ops == &rswitch_netdev_ops);
+	return ndev && (ndev->netdev_ops == &rswitch_netdev_ops);
 }
 
 static int rswitch_get_ts_info(struct net_device *ndev, struct kernel_ethtool_ts_info *info)

-- 
2.43.0

