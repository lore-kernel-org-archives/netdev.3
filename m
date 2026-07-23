Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1B194AE6;
	Thu, 23 Jul 2026 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779288; cv=none; b=MVFbZYj5ElYNpJjzRgrcr4ApF6WUOifo5SeN+E28XRP5ZGORVguy/akyy9dBKamF2bs4aU/TExfZEgrGXOVE+LjwPeG2nZ2LD5A2KP7KuAVasTHZ6rGyglDTP6dIK3zs3s+M8Gq9QPn6DOCBKB590DaQlV/FMCyq8TSswdXol9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779288; c=relaxed/simple;
	bh=IY5Bl2E+gqY+gZBK2w8f9YLdXXHt6SgsOd9uDdkPPp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CACtDn9tcqXuDzsWD7c0dKRrUfkWeg96QVHM5dzVm/8dZi/dLypzTe+4pXZVs1binOlQaLTkbmUduCt32633ys5kHSaLs3P5bTUE04rHxr5ROx/fvhs1cs08fy54XXfj6VDKQLWbDgJl6PMkP8QlpYmSTtdlFXnQpOGJstvzz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M7MrqE5u; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M7MrqE5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wc
	+3PhU21YMfGv3MQtCbC7m5kfnjx6hNUZyjZXCWg5E=; b=M7MrqE5uv2ic15ocRe
	ECDCkqPPPjabgxM2SPUjQW1uBqmpUKDEzqDc1DRTdmiLBQJkhVutAr9zZqSDSu91
	O6W34NSCZWxNU+xdqsyvskwK5Zlmm/T6QTOzjKNXU0AuNw6kjWkxskIsfGVDpzNR
	0Uw4z7pbqyHwK2a8XaG1GGRws=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXApbikWFqJi3iKg--.64205S2;
	Thu, 23 Jul 2026 12:00:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
Date: Thu, 23 Jul 2026 12:00:32 +0800
Message-Id: <20260723040032.2094322-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXApbikWFqJi3iKg--.64205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4rJryktF13uw4rKryfZwb_yoW8trWfpF
	Z8ua4S9r95WF1xGw1xWFWIqFy5Zr1rZa4fWryUJw1I9345ZFyrCrWYqFy0y3WjkF18JFyS
	vF45ZFyrua45WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREeHhUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wSQymphkeT4iAAA3-

Enslaving a CAN device (e.g. vxcan) to a team master triggers a
NULL pointer dereference in can_rx_unregister() inside
net/can/af_can.c.

During team_port_add(), the code only checks IFF_LOOPBACK but
does not reject ARPHRD_CAN devices.  After passing this gate,
team_dev_type_check_change() calls team_setup_by_port() which
sets dev->type = port_dev->type, adopting the CAN type for the
team device.  However, CAN devices operate on a fundamentally
different Layer 2 architecture, relying on the CAN mid-layer
private data structure (can_ml_priv) instead of standard
Ethernet structures.  Since the team driver never initializes
can_ml_priv, subsequent CAN subsystem operations -- such as
closing an ISOTP socket bound to the team interface via
isotp_release() -- reach can_rx_unregister() which dereferences
the NULL can_ml_priv, causing a kernel crash.

The bonding driver already rejects CAN devices since commit
8ba68464e478 ("bonding: refuse to enslave CAN devices").
Team, as a sibling aggregation path, needs the same protection.

Fix this by adding an explicit ARPHRD_CAN check in
team_port_add(), directly after the IFF_LOOPBACK guard,
consistent with the approach taken in bond_enslave().

Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/team/team_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..38f88a836010 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1224,6 +1224,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EINVAL;
 	}
 
+	if (port_dev->type == ARPHRD_CAN) {
+		NL_SET_ERR_MSG(extack, "CAN device can't be added as a team port");
+		netdev_err(dev, "Device %s is CAN device. CAN devices can't be added as a team port\n",
+			   portname);
+		return -EINVAL;
+	}
+
 	if (netif_is_team_port(port_dev)) {
 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
 		netdev_err(dev, "Device %s is already a port "
-- 
2.34.1

