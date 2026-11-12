Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472677;
	b=Fzo0Y1cVrc0Kch1BCFDxlqW8VPUGfHU8PEe9KfcN1Jq8eydyRJBu6E0iaOL4LVgplEhW
	 lt4vaxFYVqeOjcj++h3dFmkll2xtbJUjCNkVY9343Vqleyipkdg/+Dyj//PrB9LQfPAhq
	 Wakyr/2ZqqAGf3D9AXecDMYMeTaHlByFMdwwl5K6FnKFCvo3+hPIeEzqsLeXDr3HWmqpf
	 foSAbK7fBtkZtxdRzv4zDQn+LYq8AG7TnZJgtPQwUqquvCfg63hoOlJKx4MSorstn7MFD
	 q7qRjq9L8HBGmhBH4S+Kb62k5KZU+zC/dpaV+fICoFCwMnO10A+J91lWd2qKFzEUx1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+SHNkVP1QeJXX81DDUzaRvsnZJM4H9Pz1GBRNHq2FGk=;
	b=4i4JQ7Zo1chWV0IAx+8e9QId/nThBM5ktlORhUbQFEvu0YpTAYNdrshafbJS+HCU5nT+
	 DDYMdveogTCk7+CGsoQTaDi6d8cdPC7eAeK+6qug2qXTzbo8408yAAUgMxJa9aOWccHy2
	 g4MAYsk4Uj6LerdgD8kO6Zx9fnhs7jt+xiCxVdk2vaFNvIoRwY9PegkR6CXl4K6hkECWt
	 +rpXLCA68cqoP0iQf9Hc9KT7IaWT+EYEp9+SzE62nnG9EdbSHa5bQsqFm4l4cVX2pcCbF
	 XJ3wuPrXNLwFakHOpJBaFWpf9BVI/XN9I9Dzvn9YEYTirm76jNif7ZpHjdew530p40w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cRJIo+8N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF260707A5;
	Thu, 12 Nov 2026 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FFF260707A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cRJIo+8N
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8DA32205847;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SHNkVP1QeJXX81DDUzaRvsnZJM4H9Pz1GBRNHq2FGk=;
	b=cRJIo+8N//iNA7/5qOFGcVifSytAcJvTfWZcwEe/H0WP9lDjxo/vtmLeUJj5BqxnEZde97
	uO0v/60MsZE7fphD0s16H5uclZ5OO4ri3vJOI8u6MHVEpCnMtfKnMdMH6E+cPwBMlwu4kp
	ohMJvjkgeNFISraz10owMLyIz2ktreTqp5yV8/z5Ivg9KxqIX5D+8yhb7h42OPw/InW4hW
	LEP0Pm8kLCkSmQBq/PJ925U1ar6jsbm3FpZL2BAdJjRm3noSxL/BGjaU88yjhZsXXN+uZm
	YXG1GOeIcwqhD3R/6QbNCwBLJea6yC8mCb5suWbZp6UzazRYHmhW+lpJ/cufqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SHNkVP1QeJXX81DDUzaRvsnZJM4H9Pz1GBRNHq2FGk=;
	b=QH1sKvyFMm+XS9+1ScpSviPmc3wX9Fm8F/7H9ghI70EQjpv3QqsusAmfrkQZ1NSdUMxDXn
	iHv/HfjubjCTbjynIZKMWPWr8Z9VHYGQujvvAs0dpvOOHpfyzppktTcJCAufdOi8Zn7ipq
	m0E92dYmSGkgLz54CXm+fE2RS/t9ktBDESVEEuBZo2gKSKgZiCRMQCXfjo8yNljVeVmQv7
	sahURSPiv65ipqKwr+q9cSEYRhBKC+A2MdgUMzv5by8lslHkgtvoaeezvpSv6kiiez3zwR
	CKzEARtbJLPO0E9M1FR0fWbFpIGN80NbjAMxM8EoOhWPg5kCGozLTRMee+vSJQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=MSR9jsjoDf86X9BfgiW16Y0VcyvRTB6E2LA+0lTkf7ozVb15yPnNkiYojPdcNZ88zGSTrb
	FOAScEmi52XEu0UT86Iis+JIt7Hl5/G+buOnGGo01yt58jTi84Nli07bGU+ZLl5uKwxwCg
	hpq7qP2WToygQ4nd0T5zmk2XejxyhVtBMmT5vSiszGqE8S6RprAjPMocbgqoYPVqTgdZtX
	XfAKyys1HcLwgPi9Ue+dyteHWZWUcF/nmNLJKjC5Spm8cw74f7Uh/gdaFP7T6pClkoJLr+
	wl09MVd6ifxecfc9zj9Y5D0KxAmNYYDrkwKnD7G6wwnHPPQXSxqNfuqw/J0WNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 61FF9381E51; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:52 +0100
Subject: [PATCH net-next v2 09/10] net: dsa: realtek: rtl8365mb: offload
 DCB apptrust
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-9-f8e6fbdf8c99@pengutronix.de>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Wire up port_get_apptrust and port_set_apptrust. The admin can then
choose through dcbnl apptrust which ingress classification a port trusts
for its priority: 802.1p (PCP), DSCP or both. A port that trusts nothing
keeps the port default priority.

In the driver's model of the hardware, the trusted priority-decision
table is switch-wide, so all ports that trust something must trust the
same selectors. While another port trusts a set of selectors, a request
to trust a different set is refused with -EBUSY.

When both are trusted, DSCP must come first. When PCP is trusted, the
switch classifies an untagged frame by the PCP given to untagged
frames. A PCP source ranked above DSCP would then hide DSCP from
untagged IP frames. Refuse the order pcp dscp and any unknown selector
with -EOPNOTSUPP.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- move selector and precedence validation into rtl83xx-qos.c behind new
  qos_get/set_apptrust callbacks; weights and -EBUSY stay here (Linus)
- use one-hot decision weights; in the driver's model, the v1 linear
  weights could tie PCP with DSCP (Linus)
- define the apptrust slot order once (enum rtl83xx_apptrust_slot) for
  the shared selector table and the backend source table
- write the PCP and DSCP weights with one register update, so a failed
  write cannot leave the trusted table half programmed (sashiko)
- check that all apptrust sources share the one register that is updated
- rank DSCP above PCP and refuse pcp dscp with -EOPNOTSUPP, because
  with PCP first, untagged IP frames never reach DSCP
---
 drivers/net/dsa/realtek/realtek.h        |  16 +++
 drivers/net/dsa/realtek/rtl8365mb_main.c |   4 +
 drivers/net/dsa/realtek/rtl8365mb_qos.c  | 171 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_qos.h  |   4 +
 drivers/net/dsa/realtek/rtl83xx-qos.c    |  75 ++++++++++++++
 drivers/net/dsa/realtek/rtl83xx-qos.h    |   4 +
 6 files changed, 274 insertions(+)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index a9bdadbea3cbe19eeef0f33762318f022881e75f..0008ba9681cccb521d85d9bfc97425ad1b777aa6 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -100,6 +100,15 @@ struct realtek_priv {
 	void			*chip_data; /* Per-chip extra variant data */
 };
 
+/* apptrust selector slots: the index into the trust[] array of the
+ * qos_get/set_apptrust callbacks, in precedence order (highest first)
+ */
+enum rtl83xx_apptrust_slot {
+	RTL83XX_APPTRUST_DSCP,
+	RTL83XX_APPTRUST_PCP,
+	RTL83XX_APPTRUST_COUNT,
+};
+
 /*
  * struct realtek_ops - vtable for the per-SMI-chiptype operations
  * @detect: detects the chiptype
@@ -174,6 +183,13 @@ struct realtek_ops {
 	int	(*qos_set_pcp_prio)(struct realtek_priv *priv, u8 pcp, u8 iprio);
 	int	(*qos_set_dscp_prio)(struct realtek_priv *priv, u8 dscp,
 				     u8 iprio);
+	/* @trust is indexed by enum rtl83xx_apptrust_slot and has @n entries.
+	 * The trust scope (per port or switch-wide) differs between chips.
+	 */
+	int	(*qos_set_apptrust)(struct realtek_priv *priv, int port,
+				    const bool *trust, unsigned int n);
+	int	(*qos_get_apptrust)(struct realtek_priv *priv, int port,
+				    bool *trust, unsigned int n);
 };
 
 struct realtek_variant {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 512463be9212bb072380bc26c44b1bef23428917..d16e7c99217bdc01d1bdf7dbbcb8e7ed1441e6a8 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3481,6 +3481,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_get_default_prio = rtl83xx_port_get_default_prio,
 	.port_set_default_prio = rtl83xx_port_set_default_prio,
+	.port_get_apptrust = rtl83xx_port_get_apptrust,
+	.port_set_apptrust = rtl83xx_port_set_apptrust,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -3527,6 +3529,8 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.qos_set_port_prio = rtl8365mb_qos_set_port_prio,
 	.qos_set_pcp_prio = rtl8365mb_qos_set_pcp_prio,
 	.qos_set_dscp_prio = rtl8365mb_qos_set_dscp_prio,
+	.qos_set_apptrust = rtl8365mb_qos_set_apptrust,
+	.qos_get_apptrust = rtl8365mb_qos_get_apptrust,
 };
 
 static const char *const rtl8365mb_supplies[] = {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.c b/drivers/net/dsa/realtek/rtl8365mb_qos.c
index 2a849d0e4898a712d8f4babd5cdd03fe8e207814..c465d639ee5e527a604498fb064d6757aac1fda4 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.c
@@ -12,6 +12,7 @@
 #include <linux/build_bug.h>
 #include <linux/dcbnl.h>
 #include <linux/regmap.h>
+#include <linux/string.h>
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
@@ -114,6 +115,8 @@ static_assert(RTL8365MB_QOS_WEIGHT_BITS * RTL8365MB_QOS_WEIGHTS_PER_REG <=
 #define RTL8365MB_QOS_PRIDEC_TABLE_UNTRUSTED		0
 #define RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED		1
 
+static_assert(RTL8365MB_QOS_MAX_PORTS <= RTL8365MB_QOS_REG_BITS);
+
 /* Priority-decision sources, in the hardware's numbering */
 enum rtl8365mb_qos_pridec_src {
 	RTL8365MB_QOS_PRIDEC_PORT = 0,
@@ -141,6 +144,36 @@ static_assert(RTL8365MB_QOS_PRIDEC_REG(RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
 #define RTL8365MB_QOS_WEIGHT_DISABLED			0
 #define RTL8365MB_QOS_WEIGHT_PORT			BIT(0)
 
+/* Priority-decision source of each apptrust slot */
+static const u8 rtl8365mb_qos_apptrust_src[] = {
+	[RTL83XX_APPTRUST_DSCP]	= RTL8365MB_QOS_PRIDEC_DSCP,
+	[RTL83XX_APPTRUST_PCP]	= RTL8365MB_QOS_PRIDEC_1Q,
+};
+
+/* The 1Q source also classifies untagged frames, by the PCP given to untagged
+ * frames. Ranked above DSCP, it would hide DSCP from untagged IP frames.
+ */
+static_assert(RTL83XX_APPTRUST_DSCP < RTL83XX_APPTRUST_PCP);
+
+static_assert(ARRAY_SIZE(rtl8365mb_qos_apptrust_src) ==
+	      RTL83XX_APPTRUST_COUNT);
+
+/* Register of source @_s in the trusted decision table */
+#define RTL8365MB_QOS_APPTRUST_REG(_s) \
+	RTL8365MB_QOS_PRIDEC_REG(RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED, _s)
+
+/* The top trusted rank must fit in the weight field */
+static_assert((RTL8365MB_QOS_WEIGHT_PORT <<
+	       ARRAY_SIZE(rtl8365mb_qos_apptrust_src)) <
+	      BIT(RTL8365MB_QOS_WEIGHT_BITS));
+
+/* Each trusted slot outranks the port default and every later slot */
+static u8 rtl8365mb_qos_apptrust_weight(unsigned int slot)
+{
+	return RTL8365MB_QOS_WEIGHT_PORT <<
+	       (ARRAY_SIZE(rtl8365mb_qos_apptrust_src) - slot);
+}
+
 static u32 rtl8365mb_qos_sel_mask(unsigned int idx)
 {
 	unsigned int off = RTL8365MB_QOS_SEL_OFFSET(idx);
@@ -304,6 +337,14 @@ static int rtl8365mb_qos_set_pridec(struct realtek_priv *priv, int table,
 						 weight);
 }
 
+static int rtl8365mb_qos_get_pridec(struct realtek_priv *priv, int table,
+				    int src)
+{
+	return rtl8365mb_qos_regmap_read_field(priv,
+					       RTL8365MB_QOS_PRIDEC_REG(table, src),
+					       rtl8365mb_qos_weight_mask(src));
+}
+
 /* Program every source in both tables rather than relying on the reset state */
 int rtl8365mb_qos_pridec_init(struct realtek_priv *priv)
 {
@@ -327,3 +368,133 @@ int rtl8365mb_qos_pridec_init(struct realtek_priv *priv)
 	/* In the driver's model, a clear bit selects the untrusted table */
 	return regmap_write(priv->map, RTL8365MB_QOS_PRIDEC_TBL_SEL_REG, 0);
 }
+
+/* Read the trust state of each apptrust slot from the trusted table */
+static int rtl8365mb_qos_apptrust_read(struct realtek_priv *priv, bool *trust)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rtl8365mb_qos_apptrust_src); i++) {
+		int weight;
+
+		weight = rtl8365mb_qos_get_pridec(priv,
+						  RTL8365MB_QOS_PRIDEC_TABLE_TRUSTED,
+						  rtl8365mb_qos_apptrust_src[i]);
+		if (weight < 0)
+			return weight;
+
+		trust[i] = weight != RTL8365MB_QOS_WEIGHT_DISABLED;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_qos_get_apptrust(struct realtek_priv *priv, int port, bool *trust,
+			       unsigned int n)
+{
+	u32 trusted_ports;
+	int ret;
+
+	if (n != ARRAY_SIZE(rtl8365mb_qos_apptrust_src))
+		return -EINVAL;
+
+	ret = regmap_read(priv->map, RTL8365MB_QOS_PRIDEC_TBL_SEL_REG,
+			  &trusted_ports);
+	if (ret)
+		return ret;
+
+	/* On the untrusted table nothing but the port default is trusted. */
+	if (!(trusted_ports & BIT(port))) {
+		memset(trust, 0, n * sizeof(*trust));
+		return 0;
+	}
+
+	return rtl8365mb_qos_apptrust_read(priv, trust);
+}
+
+/* The trusted table is shared by all ports. A port may switch to it only if it
+ * trusts the same sources as the other ports already on it.
+ */
+static int rtl8365mb_qos_apptrust_check_shared(struct realtek_priv *priv,
+					       int port, const bool *trust)
+{
+	bool other[ARRAY_SIZE(rtl8365mb_qos_apptrust_src)];
+	u32 trusted_ports;
+	int ret;
+
+	ret = regmap_read(priv->map, RTL8365MB_QOS_PRIDEC_TBL_SEL_REG,
+			  &trusted_ports);
+	if (ret)
+		return ret;
+
+	if (!(trusted_ports & ~BIT(port)))
+		return 0;
+
+	ret = rtl8365mb_qos_apptrust_read(priv, other);
+	if (ret)
+		return ret;
+
+	if (memcmp(trust, other, sizeof(other))) {
+		dev_err(priv->dev,
+			"trust profile is switch-wide; another port already trusts different sources\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_qos_set_apptrust(struct realtek_priv *priv, int port,
+			       const bool *trust, unsigned int n)
+{
+	u32 reg = RTL8365MB_QOS_APPTRUST_REG(rtl8365mb_qos_apptrust_src[0]);
+	u32 mask = 0, val = 0;
+	bool any = false;
+	int ret, i;
+
+	if (n != ARRAY_SIZE(rtl8365mb_qos_apptrust_src))
+		return -EINVAL;
+
+	ret = rtl8365mb_qos_check_port(priv, port);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < n; i++)
+		any |= trust[i];
+
+	if (!any)
+		return regmap_clear_bits(priv->map,
+					 RTL8365MB_QOS_PRIDEC_TBL_SEL_REG,
+					 BIT(port));
+
+	ret = rtl8365mb_qos_apptrust_check_shared(priv, port, trust);
+	if (ret)
+		return ret;
+
+	/* Collect all slot weights into one mask and value and write them once,
+	 * so a failed write cannot leave the trusted table half programmed.
+	 */
+	for (i = 0; i < n; i++) {
+		u8 weight = trust[i] ? rtl8365mb_qos_apptrust_weight(i) :
+				       RTL8365MB_QOS_WEIGHT_DISABLED;
+		u8 src = rtl8365mb_qos_apptrust_src[i];
+		u32 src_mask = rtl8365mb_qos_weight_mask(src);
+
+		/* A slot missing from rtl8365mb_qos_apptrust_src[] is 0, which
+		 * is the port source. Reject it. Also reject a source whose
+		 * weight is in a different register than reg.
+		 */
+		if (WARN_ON_ONCE(src == RTL8365MB_QOS_PRIDEC_PORT ||
+				 RTL8365MB_QOS_APPTRUST_REG(src) != reg))
+			return -EINVAL;
+
+		mask |= src_mask;
+		val |= field_prep(src_mask, weight);
+	}
+
+	ret = regmap_update_bits(priv->map, reg, mask, val);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(priv->map, RTL8365MB_QOS_PRIDEC_TBL_SEL_REG,
+			       BIT(port));
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_qos.h b/drivers/net/dsa/realtek/rtl8365mb_qos.h
index 71949ece4af8fae5c49cf105ddaa3db9bc622cf2..eed5ea5fa7f345ce6989e3e890d7cd755da9d0fc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_qos.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_qos.h
@@ -24,5 +24,9 @@ int rtl8365mb_qos_set_port_prio(struct realtek_priv *priv, int port, u8 iprio,
 				u8 untag_pcp);
 int rtl8365mb_qos_set_pcp_prio(struct realtek_priv *priv, u8 pcp, u8 iprio);
 int rtl8365mb_qos_set_dscp_prio(struct realtek_priv *priv, u8 dscp, u8 iprio);
+int rtl8365mb_qos_set_apptrust(struct realtek_priv *priv, int port,
+			       const bool *trust, unsigned int n);
+int rtl8365mb_qos_get_apptrust(struct realtek_priv *priv, int port, bool *trust,
+			       unsigned int n);
 
 #endif /* _REALTEK_RTL8365MB_QOS_H */
diff --git a/drivers/net/dsa/realtek/rtl83xx-qos.c b/drivers/net/dsa/realtek/rtl83xx-qos.c
index 08091586901291e45ad1a2c64730cdcc30298b7a..b25a9dfb9138b5c2c176dbe68974cdd65e1643bb 100644
--- a/drivers/net/dsa/realtek/rtl83xx-qos.c
+++ b/drivers/net/dsa/realtek/rtl83xx-qos.c
@@ -10,6 +10,7 @@
  * The backend maps internal priorities to its egress queues itself.
  */
 
+#include <linux/build_bug.h>
 #include <linux/dcbnl.h>
 #include <linux/errno.h>
 #include <net/dscp.h>
@@ -19,6 +20,25 @@
 #include "realtek.h"
 #include "rtl83xx-qos.h"
 
+/* dcbnl selector of each apptrust slot */
+static const u8 rtl83xx_apptrust_sel[] = {
+	[RTL83XX_APPTRUST_DSCP]	= IEEE_8021QAZ_APP_SEL_DSCP,
+	[RTL83XX_APPTRUST_PCP]	= DCB_APP_SEL_PCP,
+};
+
+static_assert(ARRAY_SIZE(rtl83xx_apptrust_sel) == RTL83XX_APPTRUST_COUNT);
+
+static int rtl83xx_apptrust_sel_to_slot(u8 sel)
+{
+	int slot;
+
+	for (slot = 0; slot < ARRAY_SIZE(rtl83xx_apptrust_sel); slot++)
+		if (rtl83xx_apptrust_sel[slot] == sel)
+			return slot;
+
+	return -EINVAL;
+}
+
 /* Seed the PCP and DSCP tables, although neither source is trusted yet */
 int rtl83xx_qos_init(struct dsa_switch *ds)
 {
@@ -113,3 +133,58 @@ int rtl83xx_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 	return priv->ops->qos_set_port_prio(priv, port, tt, prio);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_port_set_default_prio, "REALTEK_DSA");
+
+int rtl83xx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+			      int *nsel)
+{
+	bool trust[ARRAY_SIZE(rtl83xx_apptrust_sel)];
+	struct realtek_priv *priv = ds->priv;
+	int i, ret;
+
+	if (!priv->ops->qos_get_apptrust)
+		return -EOPNOTSUPP;
+
+	ret = priv->ops->qos_get_apptrust(priv, port, trust,
+					  ARRAY_SIZE(trust));
+	if (ret)
+		return ret;
+
+	*nsel = 0;
+
+	for (i = 0; i < ARRAY_SIZE(rtl83xx_apptrust_sel); i++)
+		if (trust[i])
+			sel[(*nsel)++] = rtl83xx_apptrust_sel[i];
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_get_apptrust, "REALTEK_DSA");
+
+int rtl83xx_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+			      int nsel)
+{
+	bool trust[ARRAY_SIZE(rtl83xx_apptrust_sel)] = { };
+	struct realtek_priv *priv = ds->priv;
+	int i, prev = -1;
+
+	if (!priv->ops->qos_set_apptrust)
+		return -EOPNOTSUPP;
+
+	/* The backends use a fixed precedence, so the selector list
+	 * must follow the slot order.
+	 */
+	for (i = 0; i < nsel; i++) {
+		int slot = rtl83xx_apptrust_sel_to_slot(sel[i]);
+
+		if (slot < 0 || slot <= prev) {
+			dev_err(priv->dev,
+				"unsupported apptrust order; supported: dscp, pcp, dscp pcp\n");
+			return -EOPNOTSUPP;
+		}
+
+		prev = slot;
+		trust[slot] = true;
+	}
+
+	return priv->ops->qos_set_apptrust(priv, port, trust, ARRAY_SIZE(trust));
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_set_apptrust, "REALTEK_DSA");
diff --git a/drivers/net/dsa/realtek/rtl83xx-qos.h b/drivers/net/dsa/realtek/rtl83xx-qos.h
index 82ad9338d78db9062d8ceed06378b31e467ee04d..fbddc7b7d9dd37918423afc5373b684596637a05 100644
--- a/drivers/net/dsa/realtek/rtl83xx-qos.h
+++ b/drivers/net/dsa/realtek/rtl83xx-qos.h
@@ -11,5 +11,9 @@ int rtl83xx_qos_init(struct dsa_switch *ds);
 int rtl83xx_qos_init_port(struct dsa_switch *ds, int port);
 int rtl83xx_port_get_default_prio(struct dsa_switch *ds, int port);
 int rtl83xx_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
+int rtl83xx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+			      int *nsel);
+int rtl83xx_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+			      int nsel);
 
 #endif /* _RTL83XX_QOS_H */

-- 
2.47.3

