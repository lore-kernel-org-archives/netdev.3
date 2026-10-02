Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD7493D58;
	Fri,  2 Oct 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942346; cv=pass; b=cnaHPOIXgoxYoGBi/okKMnhoPHXrlWMsEysuib69yEYhEmjaR8PfZ/W/L/6ZJ74KoQIM3fQIJlDyCqAVitaJ2M+XyApTcYYoN681mC0u6lxZ+5SNu2vDRkOAwUC8VJQgU1dXxlb28Mr2z2TmhJsgWopXFbdXE3p/DHF9rgBQgW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942346; c=relaxed/simple;
	bh=bbhljfAlmdpfiIzjaczkcl0K1WcvfqkPE6JqIHjuiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwzRnG9l6zMc34gZ+7/H/lsneQ2TkUZg7SwZ/5VAEUcXwHeRz54VbJfJycmF6tS0M6uUCGXFR5zi10oCT9SyrLGKTMORMU1Yd1vcOC5NlH2RY+A8KjuP8QuwjlM0D2FTc2keyWPLafGxUWU/GBPoX8Gd3o76fZ5rZYfAiN0IyPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Mqsk9CV2; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Mqsk9CV2"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4EF8E20233F;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2tl+gat2DSIchu9hVfVngcOgbwOJalxG/YtHQpRSjY=;
	b=Mqsk9CV26nzr51IBEPCa+GCBsKTYArOorPdOF0eKk+W5A8O/S4Xrtu1xlVOZzX9VBFbbci
	++hNkid34Z2wDkX7nKNLbEdPY/WAL19KrJHhKrXdyVPBiACUZQVEMOYyIYTBDj4aU6X8lO
	47gKBEknWYXekNZV4jeaeBzaQz/wxRm6++fQhkKKYPGl6XAIWVq+v8rg1FHmmVw2HOTmgc
	aX7dtIoH2cv7gPN6badJvx0h8jpRkQHvyLIFrUoy34jqIZSQxZrCOtmZDtWvUxcodD8eW/
	gHrXd7MViJI1mEbOe7KdiUwmKvy+XCznwR/Y8yTNip/APGXhngy/J0nRMTRcIQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=VqKftqSueBzYrd2QW30u3iY73oy/7RiMgx8CMgArQq+fD8GKcZ1e6YEcF7Nv2g1+rOfcSg
	OvNGIejezCCpQ4Bq9rSkTDuDX/f/q6BEDGkSX99oJqYCJUFBdVS40t9ZiLFC2UlfuNpv5Z
	GMMER9nUse9J5aPEqXg5XidV/1Sf1sWhYTBt/0TBM2svGJk4vQQ07z4UCyO1XNh4QolQk0
	zpJHClawVK+uNoV9/JNItT+CiOdoxkJtX0k6fVgr4cqQ7qYx0MRPwL0jkKBhy0GwsVTHEB
	1hFvoZ4Ye7IW215u7bIdavamdCXqstlbyUpqWIemtUVIxPa8/cPN0Zb5oSgccw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2tl+gat2DSIchu9hVfVngcOgbwOJalxG/YtHQpRSjY=;
	b=U4/uEGJ0jhnj6mkfjOstYeioFPLTnsmPHyHNtzIrZl9F+jQjV1G1s9v7DBVcZmgLabtS9s
	moZODLTsDhQPTBRRAwbDoNScv6bfPR8vfEUDYvAzkrGou8ZCjoMVIIwGiu+2pRdO06M1cy
	IBR2aWOl8FpNPq4qWUwkI3JvhWiQYNVH8t7MHDGtc7HZaTYAFu/zyA06A9ZoU6mW4OAZ+q
	n6bFnhqqm68YEUiPMjFmqM8n9/1fC6L9McYCy+Cliz6rAnxQeEJ3fp4STEIiRmcWU1tTWI
	ieaSYGOpCAF70/y78R8tVLgw/TqFHrL9IZMdRLRYMP8O15AsAT4L+myu5xbd7Q==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 3E8EF380FA9; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 7/8] net: dsa: realtek: rtl8365mb: offload DCB apptrust
Date: Fri,  2 Oct 2026 13:58:49 +0200
Message-ID: <20261002115850.962676-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002115850.962676-1-o.rempel@pengutronix.de>
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up port_get_apptrust/port_set_apptrust so the admin can choose,
through dcbnl, which ingress classification sources a port trusts for
its priority: 802.1p (PCP) and/or DSCP. Nothing but the port default is
trusted until this opts in.

The hardware exposes two priority-decision weight tables and a per-port
bit selecting between them. rtl8365mb_dcb_init() leaves both tables
trusting only the port priority; apptrust programs the second
("trusted") table with the requested PCP/DSCP weights and steers the
port to it, or back to the untrusted table when the selector list is
empty. This driver fixes the precedence to PCP > DSCP via the decision
weights, so the selector list is validated to be in that order.

Unlike switches with independent per-port trust bits, the trusted table
is a single switch-wide resource: all ports that trust something must
trust the same selectors. A request that conflicts with the selectors
another port is already using is refused with -EBUSY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/rtl8365mb_dcb.c  | 193 +++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_dcb.h  |   4 +
 drivers/net/dsa/realtek/rtl8365mb_main.c |   2 +
 3 files changed, 199 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.c b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
index f48e95ef3947..4afcae6e85a1 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_dcb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
@@ -13,7 +13,9 @@
 
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
+#include <linux/dcbnl.h>
 #include <linux/regmap.h>
+#include <linux/string.h>
 #include <net/dsa.h>
 #include <net/ieee8021q.h>
 
@@ -66,6 +68,8 @@ static_assert(RTL8365MB_NUM_IPMS == IEEE8021Q_TT_MAX);
 
 /* Each port selects one of the two decision tables; one bit per port. */
 #define RTL8365MB_QOS_PRIDEC_IDX_REG			0x0889
+#define RTL8365MB_QOS_PRIDEC_TABLE_UNTRUSTED		0
+#define RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED		1
 
 /* Priority-decision sources. The hardware numbers eight sources; this driver
  * programs the three it uses by name and explicitly disables the rest. The
@@ -84,6 +88,24 @@ static_assert(RTL8365MB_NUM_IPMS == IEEE8021Q_TT_MAX);
 #define RTL8365MB_QOS_WEIGHT_UNTRUSTED			0
 #define RTL8365MB_QOS_WEIGHT_PORT			1
 
+/* apptrust selectors this driver supports, in descending precedence. Each
+ * entry binds a dcbnl selector to the priority-decision source it enables, so
+ * this ordered table is the one place the fixed precedence lives.
+ */
+static const struct rtl8365mb_apptrust_map {
+	u8 sel;		/* dcbnl apptrust selector */
+	u8 src;		/* priority-decision source it enables */
+} rtl8365mb_apptrust_map[] = {
+	{ DCB_APP_SEL_PCP,	     RTL8365MB_QOS_PRIDEC_1Q },
+	{ IEEE_8021QAZ_APP_SEL_DSCP, RTL8365MB_QOS_PRIDEC_DSCP },
+};
+
+/* rtl8365mb_apptrust_weight() gives the first entry the top weight,
+ * RTL8365MB_QOS_WEIGHT_PORT + ARRAY_SIZE(rtl8365mb_apptrust_map); fail the
+ * build if adding a selector would raise it past the decision weight range.
+ */
+static_assert(RTL8365MB_QOS_WEIGHT_PORT + ARRAY_SIZE(rtl8365mb_apptrust_map) <= 7);
+
 /* The QoS priority and queue selectors are 3-bit register fields; derive a
  * field's mask from its bit offset.
  */
@@ -135,6 +157,22 @@ static int rtl8365mb_qos_set_pridec(struct realtek_priv *priv, int table,
 				   rtl8365mb_qos_weight_field_mask(off), weight);
 }
 
+static int rtl8365mb_qos_get_pridec(struct realtek_priv *priv, int table,
+				    int src, u8 *weight)
+{
+	int off = RTL8365MB_QOS_PRIDEC_OFFSET(src);
+	u32 val;
+	int ret;
+
+	ret = rtl8365mb_get_field(priv, rtl8365mb_qos_pridec_reg(table, src),
+				  rtl8365mb_qos_weight_field_mask(off), &val);
+	if (ret)
+		return ret;
+
+	*weight = val;
+	return 0;
+}
+
 static int rtl8365mb_qos_setup_queues(struct realtek_priv *priv,
 				      unsigned int nq)
 {
@@ -285,3 +323,158 @@ int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 	return rtl8365mb_set_field(priv, RTL8365MB_QOS_PORT_PRI_REG(port),
 				   rtl8365mb_qos_sel_field_mask(off), tt);
 }
+
+/* Read which sources a decision table trusts (weight != 0), indexed like
+ * rtl8365mb_apptrust_map[].
+ */
+static int rtl8365mb_apptrust_read(struct realtek_priv *priv, int table,
+				   bool *trust)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++) {
+		u8 weight;
+
+		ret = rtl8365mb_qos_get_pridec(priv, table,
+					       rtl8365mb_apptrust_map[i].src,
+					       &weight);
+		if (ret)
+			return ret;
+
+		trust[i] = weight != RTL8365MB_QOS_WEIGHT_UNTRUSTED;
+	}
+
+	return 0;
+}
+
+/* Validate the selector list and mark which table entries it trusts. This
+ * driver fixes the precedence via the decision weights, so the list must be in
+ * rtl8365mb_apptrust_map[] order.
+ */
+static int rtl8365mb_apptrust_parse(struct realtek_priv *priv, const u8 *sel,
+				    int nsel, bool *trust)
+{
+	int i, prev = -1;
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++)
+		trust[i] = false;
+
+	for (i = 0; i < nsel; i++) {
+		int idx;
+
+		for (idx = 0; idx < ARRAY_SIZE(rtl8365mb_apptrust_map); idx++)
+			if (sel[i] == rtl8365mb_apptrust_map[idx].sel)
+				break;
+
+		if (idx == ARRAY_SIZE(rtl8365mb_apptrust_map) || idx <= prev) {
+			dev_err(priv->dev,
+				"unsupported apptrust selector, or not in the driver's fixed precedence order\n");
+			return -EINVAL;
+		}
+		prev = idx;
+		trust[idx] = true;
+	}
+
+	return 0;
+}
+
+/* Trusted sources outrank the port default, and earlier entries in
+ * rtl8365mb_apptrust_map[] outrank later ones. Deriving the weight from the
+ * entry's position makes the table order the sole expression of precedence,
+ * so the order and the hardware weights cannot drift apart.
+ */
+static u8 rtl8365mb_apptrust_weight(unsigned int entry)
+{
+	return RTL8365MB_QOS_WEIGHT_PORT +
+	       ARRAY_SIZE(rtl8365mb_apptrust_map) - entry;
+}
+
+int rtl8365mb_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+				int *nsel)
+{
+	bool trust[ARRAY_SIZE(rtl8365mb_apptrust_map)];
+	struct realtek_priv *priv = ds->priv;
+	int ret, i;
+	u32 idx;
+
+	*nsel = 0;
+
+	ret = regmap_read(priv->map, RTL8365MB_QOS_PRIDEC_IDX_REG, &idx);
+	if (ret)
+		return ret;
+
+	/* On the untrusted table nothing but the port default is trusted. */
+	if (!(idx & BIT(port)))
+		return 0;
+
+	ret = rtl8365mb_apptrust_read(priv, RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
+				      trust);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++)
+		if (trust[i])
+			sel[(*nsel)++] = rtl8365mb_apptrust_map[i].sel;
+
+	return 0;
+}
+
+int rtl8365mb_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+				int nsel)
+{
+	bool trust[ARRAY_SIZE(rtl8365mb_apptrust_map)];
+	struct realtek_priv *priv = ds->priv;
+	bool any = false;
+	int ret, i;
+	u32 idx;
+
+	ret = rtl8365mb_apptrust_parse(priv, sel, nsel, trust);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++)
+		any |= trust[i];
+
+	ret = regmap_read(priv->map, RTL8365MB_QOS_PRIDEC_IDX_REG, &idx);
+	if (ret)
+		return ret;
+
+	/* Nothing trusted: point the port at the untrusted table. */
+	if (!any)
+		return rtl8365mb_set_field(priv, RTL8365MB_QOS_PRIDEC_IDX_REG,
+					   BIT(port), 0);
+
+	/* The trusted table is a single switch-wide resource. If another port
+	 * already uses it, this request must trust the same selectors.
+	 */
+	if (idx & ~BIT(port)) {
+		bool other[ARRAY_SIZE(rtl8365mb_apptrust_map)];
+
+		ret = rtl8365mb_apptrust_read(priv,
+					      RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
+					      other);
+		if (ret)
+			return ret;
+
+		if (memcmp(trust, other, sizeof(trust))) {
+			dev_err(priv->dev,
+				"trust profile is switch-wide; another port already trusts different sources\n");
+			return -EBUSY;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_apptrust_map); i++) {
+		u8 weight = trust[i] ? rtl8365mb_apptrust_weight(i) :
+				       RTL8365MB_QOS_WEIGHT_UNTRUSTED;
+
+		ret = rtl8365mb_qos_set_pridec(priv,
+					       RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
+					       rtl8365mb_apptrust_map[i].src,
+					       weight);
+		if (ret)
+			return ret;
+	}
+
+	return rtl8365mb_set_field(priv, RTL8365MB_QOS_PRIDEC_IDX_REG,
+				   BIT(port), 1);
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.h b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
index 4f8068dd3522..156fa6e1c4fd 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_dcb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
@@ -16,5 +16,9 @@ int rtl8365mb_dcb_init(struct dsa_switch *ds);
 int rtl8365mb_dcb_init_port(struct dsa_switch *ds, int port);
 int rtl8365mb_port_get_default_prio(struct dsa_switch *ds, int port);
 int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
+int rtl8365mb_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+				int *nsel);
+int rtl8365mb_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+				int nsel);
 
 #endif /* _REALTEK_RTL8365MB_DCB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5a3f4328354e..77f971abf783 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3450,6 +3450,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_get_default_prio = rtl8365mb_port_get_default_prio,
 	.port_set_default_prio = rtl8365mb_port_set_default_prio,
+	.port_get_apptrust = rtl8365mb_port_get_apptrust,
+	.port_set_apptrust = rtl8365mb_port_set_apptrust,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
-- 
2.47.3

