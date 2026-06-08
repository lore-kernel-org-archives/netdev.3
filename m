Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F63D4103
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927834; cv=none; b=sroA6YI2XMKwV/X+G9Twiyk8ksoZes2KQxvkJDA0wI9i8kyfxh88+EWKdz0b98UqZXljMby5eXEpp8AK2Vu5SblE5/iNmbYy8aVH0KD8h9KM0womoLM8gtpi6IRm47WumvI6V3/JrMFQjr6007BQ59v0nVrFVsEKAGHtl856AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927834; c=relaxed/simple;
	bh=8PLK6MH0PL+nlb1DPhHdLWujUIWkO1MLKgF4hGM6dgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsMRxsNb7zkfBTLuxXf4PJwCd19xQw2vz6HJ0XfnqV9nDH/oMbOt9hm4bPYgKIp8xxwYFb0yrBgYQ1BbPFE3+A/mhMUyyhX6gjrMFayOidwQijnPS0rSGNw0zevAETLac4WvtOzXvh89fJAFDPBDNjM5Ust+YLGs4Fcil0sRwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=keepMgWi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="keepMgWi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D66881A37CB;
	Mon,  8 Jun 2026 14:10:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A93A15FFB7;
	Mon,  8 Jun 2026 14:10:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5476B106A2963;
	Mon,  8 Jun 2026 16:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927830; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tnjgaeqlG41aOH/KRD2DPbdaTUdmphP7FD5A+bf7aq8=;
	b=keepMgWi48GNyoSyTg1+afgegylB7q+UKswGZiYwT+CoiuNiDtQSaN45xEj8IVA0CRGqbw
	iRYrsxXMZwOBdjl4h4WppPPGodIbjLdUf4Wxb3gFp3ITDZNlODOCGXlvp6p2IqAYCPXMZ+
	NvqRdoYEAtLMKVNVSCrC3PJXHtdpXDOkttsMAdn7MYmYxV82CFTW5aDq9Ck9c89pF7v/CH
	kaNnuTVLdShKvSFetV5NB3aCQpZSlC2rgzfy3hBHJVkfZUT4ZwOS9SkbNBpOMVPqZEtAB3
	znqgK7H1qKeSo/l1GUsSsbi8tiYYyh+TTMtE0vA8kEbXXQYW/55udjCz0ix3ow==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:11 +0200
Subject: [PATCH net-next v2 08/10] net: dsa: microchip: implement
 port_hsr_join for KSZ9477 only
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-8-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

All switches implement the optional .port_hsr_join operation while only
the KSZ9477 truly supports it.

Remove the common port_hsr_join implementation.
Replace it with a specific implementation for the KSZ9477 case.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  6 ---
 drivers/net/dsa/microchip/ksz9477.c      | 65 +++++++++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.h      |  2 -
 drivers/net/dsa/microchip/ksz_common.c   | 67 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  4 --
 drivers/net/dsa/microchip/lan937x_main.c |  2 -
 6 files changed, 61 insertions(+), 85 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 690e1b275992..76b0f2ac8594 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2448,8 +2448,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
@@ -2498,8 +2496,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
@@ -2554,8 +2550,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index e0b3724a7558..48813b0f4280 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/microchip-ksz.h>
 #include <linux/phy.h>
 #include <linux/if_bridge.h>
+#include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <net/dsa.h>
 #include <net/switchdev.h>
@@ -1707,12 +1708,52 @@ static int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
  */
 #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_FWD)
 
-void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+static int ksz9477_hsr_join(struct dsa_switch *ds, int port,
+			    struct net_device *hsr,
+			    struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 	struct net_device *user;
 	struct dsa_port *hsr_dp;
 	u8 data, hsr_ports = 0;
+	enum hsr_version ver;
+	int ret;
+
+	ret = hsr_get_version(hsr, &ver);
+	if (ret)
+		return ret;
+
+	if (dev->chip_id != KSZ9477_CHIP_ID) {
+		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 can support HW offloading of only 1 HSR device */
+	if (dev->hsr_dev && hsr != dev->hsr_dev) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Offload supported for a single HSR");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 only supports HSR v0 and v1 */
+	if (!(ver == HSR_V0 || ver == HSR_V1)) {
+		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 can only perform HSR offloading for up to two ports */
+	if (hweight8(dev->hsr_ports) >= 2) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload more than two ports - using software HSR");
+		return -EOPNOTSUPP;
+	}
+
+	/* Self MAC address filtering, to avoid frames traversing
+	 * the HSR ring more than once.
+	 */
+	ret = ksz_switch_macaddr_get(ds, port, extack);
+	if (ret)
+		return ret;
 
 	/* Program which port(s) shall support HSR */
 	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
@@ -1744,12 +1785,20 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 	/* Setup HW supported features for lan HSR ports */
 	user = dsa_to_port(ds, port)->user;
 	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+
+	dev->hsr_dev = hsr;
+	dev->hsr_ports |= BIT(port);
+
+	return 0;
 }
 
-void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
+static int ksz9477_hsr_leave(struct dsa_switch *ds, int port,
+			     struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
 
+	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
+
 	/* Clear port HSR support */
 	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), 0);
 
@@ -1758,6 +1807,14 @@ void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
 
 	/* Disable per port self-address filtering */
 	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
+
+	dev->hsr_ports &= ~BIT(port);
+	if (!dev->hsr_ports)
+		dev->hsr_dev = NULL;
+
+	ksz_switch_macaddr_put(ds);
+
+	return 0;
 }
 
 static int ksz9477_switch_init(struct ksz_device *dev)
@@ -2012,8 +2069,8 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
+	.port_hsr_join		= ksz9477_hsr_join,
+	.port_hsr_leave		= ksz9477_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 599db0a6ba2e..92a1d889224d 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -45,8 +45,6 @@ int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
-void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
-void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 809a0bc3c01e..7dc8e4ffacdd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -16,7 +16,6 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
-#include <linux/if_hsr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
@@ -4055,72 +4054,6 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds)
 	kfree(switch_macaddr);
 }
 
-int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
-		 struct netlink_ext_ack *extack)
-{
-	struct ksz_device *dev = ds->priv;
-	enum hsr_version ver;
-	int ret;
-
-	ret = hsr_get_version(hsr, &ver);
-	if (ret)
-		return ret;
-
-	if (dev->chip_id != KSZ9477_CHIP_ID) {
-		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 can support HW offloading of only 1 HSR device */
-	if (dev->hsr_dev && hsr != dev->hsr_dev) {
-		NL_SET_ERR_MSG_MOD(extack, "Offload supported for a single HSR");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 only supports HSR v0 and v1 */
-	if (!(ver == HSR_V0 || ver == HSR_V1)) {
-		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 can only perform HSR offloading for up to two ports */
-	if (hweight8(dev->hsr_ports) >= 2) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Cannot offload more than two ports - using software HSR");
-		return -EOPNOTSUPP;
-	}
-
-	/* Self MAC address filtering, to avoid frames traversing
-	 * the HSR ring more than once.
-	 */
-	ret = ksz_switch_macaddr_get(ds, port, extack);
-	if (ret)
-		return ret;
-
-	ksz9477_hsr_join(ds, port, hsr);
-	dev->hsr_dev = hsr;
-	dev->hsr_ports |= BIT(port);
-
-	return 0;
-}
-
-int ksz_hsr_leave(struct dsa_switch *ds, int port,
-		  struct net_device *hsr)
-{
-	struct ksz_device *dev = ds->priv;
-
-	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
-
-	ksz9477_hsr_leave(ds, port, hsr);
-	dev->hsr_ports &= ~BIT(port);
-	if (!dev->hsr_ports)
-		dev->hsr_dev = NULL;
-
-	ksz_switch_macaddr_put(ds);
-
-	return 0;
-}
-
 int ksz_suspend(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 17b7ba77aaa9..2c118eaddd75 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -490,10 +490,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
 		struct ethtool_wolinfo *wol);
 int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 			     const unsigned char *addr);
-int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
-		 struct netlink_ext_ack *extack);
-int ksz_hsr_leave(struct dsa_switch *ds, int port,
-		  struct net_device *hsr);
 
 int ksz_suspend(struct dsa_switch *ds);
 int ksz_resume(struct dsa_switch *ds);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 6b1306e81558..d45798de4ce9 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -871,8 +871,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,

-- 
2.54.0

