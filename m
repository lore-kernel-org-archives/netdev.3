Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731B3D330B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927831; cv=none; b=ZJtRqS8pbw0x3vwt+nbC+dozIiVQT/fOPzt9AecoT8yipRZ3cRXpWl6/AYVHrBy3zurD31ozd136BYpGeCOmYSPPgygTZR+JsWLfygBlhaLFQ+KOzSkTpnyH+73xLOcChVUAoAVQgDu++kbDfardH+36TQPHrnhUh6/QH975jXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927831; c=relaxed/simple;
	bh=0hUFGdUYmI9KO/PLb03TAtqcEyxvnl33H2o/iFpm7DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msOfSqIjbDstir5cQe4InLuwTFl0ak/5UTrmwLaOPr6bs5zyJ/eSCAKv5MznuWHpbK2zLSeKbDgvrgOqHPSUQovErLHKFZZhf2kq8urO60mcRKPviZAhftgYtHvhKzd9GyRKT7wVojE6maHC7l3Z7jdWtuYwPu+v3b3Oi0FQbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMaWqT0c; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AMaWqT0c"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7FB331A37CB;
	Mon,  8 Jun 2026 14:10:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B7505FFB7;
	Mon,  8 Jun 2026 14:10:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3ECC106A2958;
	Mon,  8 Jun 2026 16:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yyO6kiczAR32v5H26dk2bCuiftWpi3tl9gOA036Lk9o=;
	b=AMaWqT0cfSzH1b4jJYQsvt5Buad2u9jN7S1vvAMsrYJDSXl8kwOCTcnIw2n35DqFI3xxLz
	5I4TWxyx6Oro4DRr7Yj0hBwHG6U9IIUJzRfkzXd5yDWcf8R7rxGKh/xudQrbKUSL+LrDd0
	aJ4uIBhdkQij2PalWnArd7YwwJkHFoKKw0lBywZpl/McuP/R9TvAv+AZVU99Kts1yf8AZe
	luigJqIUJuiOF9mpYuP8tWQhgYXjXkMQBa1mydojy5FFMA1k+YCbOjXbojB2rUizp8X4FH
	cDuVEdqDFaIBd6/hkff7N7mqEVOaO8U5+dQtwqpuczl0SJRZTsJmZPYMxJEjtA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:09 +0200
Subject: [PATCH net-next v2 06/10] net: dsa: microchip: implement
 .support_eee() only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-6-6e61b7be23c4@bootlin.com>
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

The .support_eee() operation is optional. Yet, it is implemented by the
KSZ switches through a common functon that reports false for every chip
except for KSZ8563, KSZ9563 and KSZ9893 from the KSZ9477 family.

Remove the implementation from the switches that don't support EEE.
Also remove .set_mac_eee() for them as .set_mac_eee() is gated by the
`support_eee` presence in the core.

Implement instead a ksz9477-specific support_eee for these three supported
switches.

Note that comment /* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
is completely removed because it concerns the KSZ87xx family that doesn't
support at all EEE.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  6 ----
 drivers/net/dsa/microchip/ksz9477.c      | 50 +++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 57 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  1 -
 drivers/net/dsa/microchip/lan937x_main.c |  2 --
 5 files changed, 49 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 98cf7239057d..7b4b46db1ef6 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2477,8 +2477,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
@@ -2534,8 +2532,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
@@ -2592,8 +2588,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index a39541d29ad5..e0b3724a7558 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1909,6 +1909,54 @@ void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 	ksz9477_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
 }
 
+/**
+ * ksz9477_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
+ *                       port
+ * @ds: Pointer to the DSA switch structure
+ * @port: Port number to check
+ *
+ * This function also documents devices where EEE was initially advertised but
+ * later withdrawn due to reliability issues, as described in official errata
+ * documents. These devices are explicitly listed to record known limitations,
+ * even if there is no technical necessity for runtime checks.
+ *
+ * Returns: true if the internal PHY on the given port supports fully
+ * operational EEE, false otherwise.
+ */
+static bool ksz9477_support_eee(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (!dev->info->internal_phy[port])
+		return false;
+
+	switch (dev->chip_id) {
+	case KSZ8563_CHIP_ID:
+	case KSZ9563_CHIP_ID:
+	case KSZ9893_CHIP_ID:
+		return true;
+	default:
+		/* KSZ8567R Errata DS80000752C Module 4 */
+		/* KSZ9477S Errata DS80000754A Module 4 */
+		/* KSZ9567S Errata DS80000756A Module 4 */
+		/* KSZ9896C Errata DS80000757A Module 3 */
+		/* KSZ9897R Errata DS80000758C Module 4 */
+		/* Energy Efficient Ethernet (EEE) feature select must be
+		 * manually disabled
+		 *   The EEE feature is enabled by default, but it is not fully
+		 *   operational. It must be manually disabled through register
+		 *   controls. If not disabled, the PHY ports can auto-negotiate
+		 *   to enable EEE, and this feature can cause link drops when
+		 *   linked to another device supporting EEE.
+		 *
+		 * The same item appears in the errata for all switches above.
+		 */
+		break;
+	}
+
+	return false;
+}
+
 static struct phylink_pcs *
 ksz9477_phylink_mac_select_pcs(struct phylink_config *config,
 			       phy_interface_t interface)
@@ -1998,7 +2046,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.cls_flower_add		= ksz9477_cls_flower_add,
 	.cls_flower_del		= ksz9477_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
+	.support_eee		= ksz9477_support_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 33a20c2e0a8a..bebf697ec60a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3052,63 +3052,6 @@ int ksz_max_mtu(struct dsa_switch *ds, int port)
 	return -EOPNOTSUPP;
 }
 
-/**
- * ksz_support_eee - Determine Energy Efficient Ethernet (EEE) support for a
- *                   port
- * @ds: Pointer to the DSA switch structure
- * @port: Port number to check
- *
- * This function also documents devices where EEE was initially advertised but
- * later withdrawn due to reliability issues, as described in official errata
- * documents. These devices are explicitly listed to record known limitations,
- * even if there is no technical necessity for runtime checks.
- *
- * Returns: true if the internal PHY on the given port supports fully
- * operational EEE, false otherwise.
- */
-bool ksz_support_eee(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->info->internal_phy[port])
-		return false;
-
-	switch (dev->chip_id) {
-	case KSZ8563_CHIP_ID:
-	case KSZ9563_CHIP_ID:
-	case KSZ9893_CHIP_ID:
-		return true;
-	case KSZ8567_CHIP_ID:
-		/* KSZ8567R Errata DS80000752C Module 4 */
-	case KSZ8765_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8795_CHIP_ID:
-		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
-	case KSZ9477_CHIP_ID:
-		/* KSZ9477S Errata DS80000754A Module 4 */
-	case KSZ9567_CHIP_ID:
-		/* KSZ9567S Errata DS80000756A Module 4 */
-	case KSZ9896_CHIP_ID:
-		/* KSZ9896C Errata DS80000757A Module 3 */
-	case KSZ9897_CHIP_ID:
-	case LAN9646_CHIP_ID:
-		/* KSZ9897R Errata DS80000758C Module 4 */
-		/* Energy Efficient Ethernet (EEE) feature select must be
-		 * manually disabled
-		 *   The EEE feature is enabled by default, but it is not fully
-		 *   operational. It must be manually disabled through register
-		 *   controls. If not disabled, the PHY ports can auto-negotiate
-		 *   to enable EEE, and this feature can cause link drops when
-		 *   linked to another device supporting EEE.
-		 *
-		 * The same item appears in the errata for all switches above.
-		 */
-		break;
-	}
-
-	return false;
-}
-
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index ef8eb10fde50..17b7ba77aaa9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -478,7 +478,6 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 
 int ksz_max_mtu(struct dsa_switch *ds, int port);
 
-bool ksz_support_eee(struct dsa_switch *ds, int port);
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e);
 
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 69df378a40bf..e1aba93d1438 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -903,8 +903,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,

-- 
2.54.0

