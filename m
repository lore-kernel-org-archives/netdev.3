Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711143B52FA;
	Thu,  2 Jul 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983263; cv=none; b=rzENeFMnb593PwM1U630SD21kL3njMcPQKkbtfvG535jWmKB/Vol5Se2CUN2/puzjxThvgEybz7w+/iHI/wNkWfOYlzgE4VJJBaVO68l8zHaHtIomdJ0mTvgNMHzHydH6fB4ekxCDsacBKSyZmtAoITiO3OaiGGfLQXT2yQBAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983263; c=relaxed/simple;
	bh=SR7FxOtorKy9ofC0zr6bzAbWZmqkuVZn3buMDBB7Ej8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJWs3uRCBZeAxSLaWxFbufBsjS0v55LsUQIrjdby7l7KuXG+y+2Tk65um8xhmD6E/Pc4qOPPPfBjNopqWaizNQzWDtqpdyJKvx5cfllQ3U/xnyHYzXEUavscRCgngxRMIUSN0Yk5nPQJaLgQ+XsFJ3fuWhoW8uWmBaosMjSP1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCod7gk5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCod7gk5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 12FAD4E40C30;
	Thu,  2 Jul 2026 09:07:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DAF655FF03;
	Thu,  2 Jul 2026 09:07:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 503EA104C9616;
	Thu,  2 Jul 2026 11:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qyqe/LYZOKX36FinH9dq56chPDYti0C1CHTfZop4POM=;
	b=XCod7gk5KmARbLFxCqeH0YwaBaICP2JQ7ATfoOOp8EP8Ydo5BqWEjwI6b03y2aSuk1d+2G
	c715vRKJBz4u+PAvPpuRKbsTcBl3vmuxVaC5scVvkfHnOioguJ4TgJsxAI9CB829+mri/2
	+wF0nfnaAkpSumRuRahgM4lJ0GXiagVy/yVg/R6BgDRE4YrvAY7LhhNF/tJVHJPCFRMbU7
	z/lNk//9MNASoRwNsZT/idf+yEhvlUfqBJX+mN7YJpYApdYgxJduPo1DNLsXICFBP/PQ57
	OraTvrNDWax2SKS1yEP7DEcd2hz7sUFnKMS+2y+zaWeaH62ZP6vFstWxzB6B6A==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:24 +0200
Subject: [PATCH net-next 02/10] net: dsa: microchip: split port_max_mtu()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-2-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

From: Vladimir Oltean <vladimir.oltean@nxp.com>

ksz_max_mtu() is a bit cluttered. It would be good for developers and
reviewers if they didn't need to look at a common function for hardware
they likely don't have, and which is vastly different, when they are
interested in only a specific chip.

Benefit from the fact that all families listed here have their own
dsa_switch_ops, and provide separate implementations for the
port_max_mtu() method.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 16 ++++++++++++---
 drivers/net/dsa/microchip/ksz9477.c      |  7 ++++++-
 drivers/net/dsa/microchip/ksz9477.h      |  1 +
 drivers/net/dsa/microchip/ksz_common.c   | 34 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  2 --
 drivers/net/dsa/microchip/lan937x_main.c |  2 +-
 6 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c351179f6a60..2b4720c4c87e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -202,6 +202,16 @@ static int ksz87xx_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	return ksz_rmw8(dev, REG_SW_CTRL_2, SW_LEGAL_PACKET_DISABLE, ctrl2);
 }
 
+static int ksz87xx_max_mtu(struct dsa_switch *ds, int port)
+{
+	return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int ksz88xx_max_mtu(struct dsa_switch *ds, int port)
+{
+	return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
 static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
 	u8 mask_4q, mask_2q;
@@ -2541,7 +2551,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz88xx_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
+	.port_max_mtu		= ksz88xx_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
@@ -2591,7 +2601,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz87xx_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
+	.port_max_mtu		= ksz87xx_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
@@ -2642,7 +2652,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz88xx_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
+	.port_max_mtu		= ksz88xx_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f3f0c98dfb5a..0b08d2175f17 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -60,6 +60,11 @@ static int ksz9477_change_mtu(struct dsa_switch *ds, int port, int mtu)
 				  REG_SW_MTU_MASK, frame_size);
 }
 
+int ksz9477_max_mtu(struct dsa_switch *ds, int port)
+{
+	return KSZ9477_MAX_FRAME_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
 static int ksz9477_wait_vlan_ctrl_ready(struct ksz_device *dev)
 {
 	unsigned int val;
@@ -2098,7 +2103,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz9477_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
+	.port_max_mtu		= ksz9477_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 92a1d889224d..25b74d0af6c5 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -21,6 +21,7 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int port, bool freeze);
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port);
 int ksz9477_port_vlan_filtering(struct dsa_switch *ds, int port,
 				bool flag, struct netlink_ext_ack *extack);
+int ksz9477_max_mtu(struct dsa_switch *ds, int port);
 int ksz9477_port_vlan_add(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan,
 			  struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d1726778bb48..686bdbfe8b6a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2984,40 +2984,6 @@ int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-int ksz_max_mtu(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	switch (dev->chip_id) {
-	case KSZ8795_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8765_CHIP_ID:
-		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
-	case KSZ8463_CHIP_ID:
-	case KSZ88X3_CHIP_ID:
-	case KSZ8864_CHIP_ID:
-	case KSZ8895_CHIP_ID:
-		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
-	case KSZ8563_CHIP_ID:
-	case KSZ8567_CHIP_ID:
-	case KSZ9477_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9567_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-	case KSZ9896_CHIP_ID:
-	case KSZ9897_CHIP_ID:
-	case LAN9370_CHIP_ID:
-	case LAN9371_CHIP_ID:
-	case LAN9372_CHIP_ID:
-	case LAN9373_CHIP_ID:
-	case LAN9374_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		return KSZ9477_MAX_FRAME_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
-	}
-
-	return -EOPNOTSUPP;
-}
-
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b4a5673ba365..f276f2452684 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -443,8 +443,6 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 			       unsigned int mode,
 			       phy_interface_t interface);
 
-int ksz_max_mtu(struct dsa_switch *ds, int port);
-
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e);
 
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 8eb5337b0c10..f060fbc4c4f4 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -983,7 +983,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= lan937x_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
+	.port_max_mtu		= ksz9477_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,

-- 
2.54.0

