Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A64CEE66
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577053; cv=none; b=imVozaXpiSN6/O0fAEdiNPABvJccJ94gHM0EkEpHXSXcdsHyhDOguHcH0wueKwVl18zoIEmPogLAUcSpnovcolsI+6zOd2xDmRDaLeJValF7yVjzb+7AFaEfWFhHBGaOewTC2vUz304DCE1B+M8HC/stkVTccE6m8JjKQZxORss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577053; c=relaxed/simple;
	bh=VewGv01dzeArNwz6G4oTQ7PUYU/ujavLp1cXDQYa58Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o76xyQDfMSXo6ZdE+/zJUD5RWYrax3K4hcJsdTvpSFz9lYinfWf1Xdbz0g43mYa+gH6uwWBpG0eMLnVvZv/pPSJR+yWZXZK5TutvKzhBju7FOS2Md9ks9B2rG7iH54jxDQOgOn2MDJqKtaS2B0S2tan9zQ2uzc0/lXLmR0oI4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlaS27U5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlaS27U5"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso899741a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577034; x=1790181834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqHY/HHhqcI64MdlILGee2ugK76bq9SvJgTA/Q/klAg=;
        b=RlaS27U5GAiMDv9FFMaSA464jvCzw5uejDMxWWR+C/7UD+1TJaFZ2WdIj9iRCNYbOk
         aSu6yS/E0zXSW04qCSE+62paAhhIeAaToS2jrCnzZ9LVEvSTCWaGQSGlM88UWB8lvMlt
         ZgrZpSo9BaJ6BgIWbo+kXpTDnZrhsdy6+wBt+uoBuSjTol1HWGbiWWfPinvUIG2hOCRY
         5xgmGjRRW9gmqZAQ1m7UTGWs03Cgj+0rT7jUCkSYETlC2yQ9jU5xtm5OyS9qwURSkt8V
         renyvz0uB9a09EgGyvsYvYsUqqh1esUxupJkooVQ52QzFSS+SvBh+VCqqoN3n1bV+dor
         DMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577034; x=1790181834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqHY/HHhqcI64MdlILGee2ugK76bq9SvJgTA/Q/klAg=;
        b=h9jCKtXSOMRtWQ0bsu3Efw5WzTT49QpDbOZcesbPe0FL8YoYT6izhMTzuI8Ov9EcyE
         +CxnYk9MRkSVPNGDSB/y2baQrWfy/pkd+guwPgA6zRQ0BzwE1ScPQGTQ0sCZLU8RbYJr
         YGEMjVjPVgGc/QRhxMX+VUTKEbG756vNQufY2VohaU3QrU0hN+iemNoxDZFP0mcsxufm
         6uThHLWnAksKfSlWcVIkQ3GjAEhapmdya2Bp1Ip7ccDTHMwzql7Y2EZzUfv5ksmvqv3B
         2SGfvHiFbdUnzUxsMmLIYoce6eGIHgv+uwWHdw0gvBSghQ6c51Tc4JxAHnPgNj1gHw54
         9dVg==
X-Gm-Message-State: AFuF++mOLyJWxLem3RMABCir2RJJZS1icN5qAqvUnuRgX9/YJM99pyE6
	iUaPN5dPai1mf3xiyuhZmF0DRh9sLerdfShk+QbSEYqc4tFERhggQ9le8uDNiq/nZ10=
X-Gm-Gg: AYBFou0QwPtO4vIgJcb9yeVgpEs2yAv7JM1C5rx6n9hFzRjyKpIcD43wny3gz+PFNUu
	TowtyhM4AOR7KnUurb6kM9MT6x6XfCa3IxOcGKaDrmFZun3f1AfAFl8Fex3xJ+PWeLkxzd4P1c/
	fm8v4I8xsWndfvbnbA8syzyTswIdRfWmEMqjrIk9KxLL16syTtvvO1YIDPwzO7ucUF4IZnPk5Mv
	NsZTiuVTn5cEFIkVt+AH92Aamz1RwllTdAgqsB+Lgv6JXGM6sBC3gExrLna5DJIGlLkUMoO+4Lx
	HiPjR8xzBOM7+hJNjBo/wbWFsNu4z87oxjYrkm/2zYYyirkZ/K6aP+0YjdBnEYQDR0Pxl5NtE33
	UKSb8Y8oAG07l680KQlEEYaNURSd9vJShzc0iPObrpmqqJSKCtHpr888D0dGrGWOh1pT6tlx+qW
	PMJdM3k7+GIGcea0wEy2o4mz2fVRjwYYmBrZFmywPqrrrg7NVg7L5KAdii0B1NotLoPLhBLHz1Q
	Pl2ZORdzAUSgED/VIa5cnlLjw==
X-Received: by 2002:a05:6a21:3294:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3dd5f79ce3dmr7651251637.23.1789577034165;
        Wed, 16 Sep 2026 09:43:54 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:53 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 8/8] net: dsa: motorcomm: Add SerDes PCS
Date: Thu, 17 Sep 2026 00:43:08 +0800
Message-ID: <20260916164310.3168269-9-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support in-band negotiation of the SerDes ports.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/Makefile   |   1 +
 drivers/net/dsa/motorcomm/chip.c     |  61 ++++++-
 drivers/net/dsa/motorcomm/chip.h     |   6 +
 drivers/net/dsa/motorcomm/mdio_bus.c |  31 +++-
 drivers/net/dsa/motorcomm/mdio_bus.h |  15 ++
 drivers/net/dsa/motorcomm/pcs-921x.c | 235 +++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |  13 ++
 7 files changed, 355 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index f7cce7eabbb8..1d2c1b3064c4 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
 yt921x-objs += mdio_bus.o
+yt921x-objs += pcs-921x.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index c7a8004ce34a..530bea77ac70 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -28,6 +28,7 @@
 #include "chip.h"
 #include "leds.h"
 #include "mdio_bus.h"
+#include "pcs.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -3511,6 +3512,10 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 	if (ps == YT921X_SPEED_NUM)
 		return -EINVAL;
 
+	mask = YT921X_PORT_SPEED_M | YT921X_PORT_TX_MAC_EN |
+	       YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_PAUSE |
+	       YT921X_PORT_RX_PAUSE | YT921X_PORT_DUPLEX_FULL |
+	       YT921X_PORT_CTRL_LINK_AN;
 	ctrl = YT921X_PORT_SPEED(ps);
 	if (duplex == DUPLEX_FULL)
 		ctrl |= YT921X_PORT_DUPLEX_FULL;
@@ -3519,7 +3524,9 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 	if (rx_pause)
 		ctrl |= YT921X_PORT_RX_PAUSE;
 	ctrl |= YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
-	res = yt921x_reg_write(priv, YT921X_PORTn_CTRL(port), ctrl);
+	if (pp->serdes && pp->inband)
+		ctrl |= YT921X_PORT_CTRL_LINK_AN;
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_CTRL(port), mask, ctrl);
 	if (res)
 		return res;
 
@@ -3539,7 +3546,8 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 		if (rx_pause)
 			ctrl |= YT921X_SERDES_RX_PAUSE;
 		mask |= YT921X_SERDES_LINK;
-		ctrl |= YT921X_SERDES_LINK;
+		if (!pp->inband)
+			ctrl |= YT921X_SERDES_LINK;
 		res = yt921x_reg_update_bits(priv, YT921X_SERDESn(port),
 					     mask, ctrl);
 		if (res)
@@ -3570,7 +3578,6 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
 	u32 mask;
-	u32 ctrl;
 	int res;
 
 	if (BIT(port) & info->internal_mask) {
@@ -3615,6 +3622,29 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 	return -EINVAL;
 }
 
+static struct phylink_pcs *
+yt921x_phylink_mac_select_pcs(struct phylink_config *config,
+			      phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	const struct yt921x_info *info = priv->info;
+	int port = dp->index;
+
+	if (!(BIT(port) & info->serdes_mask))
+		return NULL;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return &priv->ports[port].pcs;
+	default:
+		return NULL;
+	}
+}
+
 static void
 yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 			     phy_interface_t interface)
@@ -4202,6 +4232,11 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_reg_clear_bits(priv, YT921X_SERDES_CTRL,
+				    YT921X_SERDES_CTRL_TEST);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -4211,6 +4246,8 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	struct device *dev = to_device(priv);
 	struct device_node *np = dev->of_node;
 	struct device_node *child;
+	unsigned long mask;
+	int port;
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -4244,6 +4281,23 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	mask = priv->info->serdes_mask;
+	for_each_set_bit(port, &mask, YT921X_PORT_NUM) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		pp->pcs.ops = &yt921x_phylink_pcs_ops;
+		pp->pcs.poll = true;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_100BASEX,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pp->pcs.supported_interfaces);
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_setup(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -4261,6 +4315,7 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 }
 
 static const struct phylink_mac_ops yt921x_phylink_mac_ops = {
+	.mac_select_pcs	= yt921x_phylink_mac_select_pcs,
 	.mac_link_down	= yt921x_phylink_mac_link_down,
 	.mac_link_up	= yt921x_phylink_mac_link_up,
 	.mac_config	= yt921x_phylink_mac_config,
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index c1b5f29eb0fa..0cbb54834fff 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -910,6 +910,8 @@ struct yt921x_port {
 
 	/* SerDes in use */
 	bool serdes:1;
+	/* Link from in-band status (PHYLINK_PCS_NEG_INBAND) */
+	bool inband:1;
 	/* BR_HAIRPIN_MODE */
 	bool hairpin:1;
 	/* BR_ISOLATED */
@@ -929,8 +931,12 @@ struct yt921x_port {
 
 	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
 #endif
+
+	struct phylink_pcs pcs;
 };
 
+#define pcs_to_yt921x_port(_pcs) container_of((_pcs), struct yt921x_port, pcs)
+
 struct yt921x_reg_ops {
 	int (*read)(void *context, u32 reg, u32 *valp);
 	int (*write)(void *context, u32 reg, u32 val);
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index ba70343f3f33..1a3f3cc68275 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -19,8 +19,7 @@ static int yt921x_intif_wait(struct yt921x_priv *priv)
 			       &val);
 }
 
-static int
-yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+int yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
 {
 	struct device *dev = to_device(priv);
 	u32 mask;
@@ -58,8 +57,7 @@ yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
 	return 0;
 }
 
-static int
-yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+int yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
 {
 	u32 mask;
 	u32 ctrl;
@@ -86,6 +84,31 @@ yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
 	return yt921x_intif_wait(priv);
 }
 
+int
+yt921x_intif_modify_changed(struct yt921x_priv *priv, int port, int reg,
+			    u16 mask, u16 val)
+{
+	int res;
+	u16 v;
+	u16 u;
+
+	res = yt921x_intif_read(priv, port, reg, &v);
+	if (res)
+		return res;
+
+	u = v;
+	u &= ~mask;
+	u |= val;
+	if (u == v)
+		return 0;
+
+	res = yt921x_intif_write(priv, port, reg, u);
+	if (res)
+		return res;
+
+	return 1;
+}
+
 static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 {
 	struct yt921x_priv *priv = mbus->priv;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motorcomm/mdio_bus.h
index ae5792b8da24..e79b725d435b 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.h
+++ b/drivers/net/dsa/motorcomm/mdio_bus.h
@@ -33,6 +33,21 @@
 
 struct yt921x_priv;
 
+int yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp);
+int yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val);
+int yt921x_intif_modify_changed(struct yt921x_priv *priv, int port, int reg,
+				u16 mask, u16 val);
+
+static inline int
+yt921x_intif_modify(struct yt921x_priv *priv, int port, int reg, u16 mask,
+		    u16 val)
+{
+	int res;
+
+	res = yt921x_intif_modify_changed(priv, port, reg, mask, val);
+	return res >= 0 ? 0 : res;
+}
+
 int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp);
 int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp);
 
diff --git a/drivers/net/dsa/motorcomm/pcs-921x.c b/drivers/net/dsa/motorcomm/pcs-921x.c
new file mode 100644
index 000000000000..dcf7397cd241
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/pcs-921x.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "mdio_bus.h"
+#include "pcs.h"
+#include "smi.h"
+
+#define to_device(priv) ((priv)->ds.dev)
+
+static int
+yt921x_serdes_config(struct yt921x_priv *priv, int port, unsigned int neg_mode,
+		     phy_interface_t interface,
+		     const unsigned long *advertising, bool permit_pause_to_mac)
+{
+	bool inband = neg_mode & PHYLINK_PCS_NEG_INBAND;
+	struct yt921x_port *pp = &priv->ports[port];
+	bool changed = false;
+	u16 bmcr;
+	u32 mask;
+	u32 ctrl;
+	u16 val;
+	int adv;
+	int res;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		ctrl = YT921X_SERDES_MODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_100BASEX:
+		ctrl = YT921X_SERDES_MODE_100BASEX;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		ctrl = YT921X_SERDES_MODE_1000BASEX;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ctrl = YT921X_SERDES_MODE_2500BASEX;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	res = yt921x_reg_update_bits(priv, YT921X_SERDESn(port),
+				     YT921X_SERDES_MODE_M, ctrl);
+	if (res)
+		return res;
+
+	mask = YT921X_PORT_CTRL_LINK_AN | YT921X_PORT_CTRL_PAUSE_AN;
+	ctrl = 0;
+	if (inband)
+		ctrl |= YT921X_PORT_CTRL_LINK_AN;
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED && permit_pause_to_mac)
+		ctrl |= YT921X_PORT_CTRL_PAUSE_AN;
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_CTRL(port), mask, ctrl);
+	if (res)
+		return res;
+
+	if (inband) {
+		res = yt921x_reg_clear_bits(priv, YT921X_SERDESn(port),
+					    YT921X_SERDES_LINK);
+		if (res)
+			return res;
+	}
+
+	adv = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (adv >= 0) {
+		res = yt921x_intif_modify_changed(priv, port, MII_ADVERTISE,
+						  U16_MAX, adv);
+		if (res < 0)
+			return res;
+
+		changed = !!res;
+	}
+
+	res = yt921x_intif_read(priv, port, MII_BMCR, &val);
+	if (res)
+		return res;
+
+	bmcr = val;
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		bmcr |= BMCR_ANENABLE;
+	else
+		bmcr &= ~BMCR_ANENABLE;
+
+	/* If the ANENABLE bit was changed, the PHY will restart negotiation,
+	 * so we don't need to flag a change to trigger its own restart.
+	 */
+	if (bmcr != val)
+		changed = false;
+
+	bmcr &= ~BMCR_ISOLATE;
+	res = yt921x_intif_write(priv, port, MII_BMCR, bmcr);
+	if (res)
+		return res;
+
+	pp->inband = inband;
+	return changed;
+}
+
+static unsigned int
+yt921x_phylink_pcs_inband_caps(struct phylink_pcs *pcs,
+			       phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+}
+
+static void
+yt921x_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     struct phylink_link_state *state)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = to_device(priv);
+	int port = pp->index;
+	u16 bmsr;
+	u16 lpa;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_intif_read(priv, port, MII_BMSR, &bmsr);
+	if (res)
+		goto out;
+
+	res = yt921x_intif_read(priv, port, MII_LPA, &lpa);
+
+out:
+	mutex_unlock(&priv->reg_lock);
+
+	if (res) {
+		dev_err(dev, "Failed to %s PCS port %d: %i\n", "get state of",
+			port, res);
+		state->link = false;
+		return;
+	}
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+}
+
+static void yt921x_phylink_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = to_device(priv);
+	int port = pp->index;
+	u16 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_intif_read(priv, port, MII_BMCR, &val);
+	if (res)
+		goto end;
+
+	val |= BMCR_ANRESTART;
+	res = yt921x_intif_write(priv, port, MII_BMCR, val);
+
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s PCS port %d: %i\n", "restart",
+			port, res);
+}
+
+static void yt921x_phylink_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = to_device(priv);
+	int port = pp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_intif_modify(priv, port, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s PCS port %d: %i\n", "power down",
+			port, res);
+}
+
+static int yt921x_phylink_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int port = pp->index;
+	u16 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_intif_read(priv, port, MII_BMCR, &val);
+	if (res)
+		goto end;
+
+	val &= ~BMCR_PDOWN;
+	val |= BMCR_ANRESTART;
+	res = yt921x_intif_write(priv, port, MII_BMCR, val);
+
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			  phy_interface_t interface,
+			  const unsigned long *advertising,
+			  bool permit_pause_to_mac)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int port = pp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_serdes_config(priv, port, neg_mode, interface,
+				   advertising, permit_pause_to_mac);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+const struct phylink_pcs_ops yt921x_phylink_pcs_ops = {
+	.pcs_inband_caps	= yt921x_phylink_pcs_inband_caps,
+	.pcs_get_state		= yt921x_phylink_pcs_get_state,
+	.pcs_an_restart		= yt921x_phylink_pcs_an_restart,
+	.pcs_disable		= yt921x_phylink_pcs_disable,
+	.pcs_enable		= yt921x_phylink_pcs_enable,
+	.pcs_config		= yt921x_phylink_pcs_config,
+};
diff --git a/drivers/net/dsa/motorcomm/pcs.h b/drivers/net/dsa/motorcomm/pcs.h
new file mode 100644
index 000000000000..42426558086a
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/pcs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_PCS_H
+#define _YT_PCS_H
+
+#include <linux/phylink.h>
+
+extern const struct phylink_pcs_ops yt921x_phylink_pcs_ops;
+
+#endif
-- 
2.53.0

