Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63508495ADA;
	Fri,  2 Oct 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942344; cv=pass; b=iQoO041JKB3MJc3nTvdoonp2SkYHUa1YGBVBeN4RMDtWdyT9ejJ73/eYZDWY5jrQmiK/5HSmPLrLRQWAPk7dLxL2rrlXoODdhI0nVNhGrh8rHVF7gRmtZIvw6N1+/nuD8CpPSnv6HXpBmtzSNkjpq6QTiNvY/SocL+rB/13F9+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942344; c=relaxed/simple;
	bh=g4bkliQzlUEDPLBcGS/0QBVY8NRhAVVUcK+ZgfSf130=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XISaZ1R97iNqarnWAMuEEGDHs0Pudtuz4UZWsl9ose8EQWgdkwE6MK5KZOnT5lIjbINi33p7ZIo3FxsCeLgw6XfH0roIO7wEcInUwKP5qWwyBIvfjoO2hlO8P/lspgK/krvLtNFok6U1Kai1GPd3MkUOvsA7q1ii1bQSLJ6Kgbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DYGUub1J; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DYGUub1J"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 436C420233C;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOJSGTTBHjY1JsEFpZjDfD7JOIGBIaKOZxBzKKynSno=;
	b=DYGUub1JVKbYZ0CE5QvclxdwOI4mqYvzSGjHIYM/kq3tBPnvQAucXs9t66d3pIuVqoMqIe
	zTU1lXHIdBdM+wk411/oX9be+7Z7aT4u7m8HwYppVTYM7gXmjAXykmI61pVybZNyTxGW8R
	BnFXoaaHtatZUSe/k+4b/OWgUurD/msgYqs2x8geNQmSjMeNIBq7BRhYKGotKcgqqBHFBo
	vF1Z9nQbR/28pDuz8CDEGKNi7RbsGNP4rLMfRXJmPBV/SiAwjWJVUirU72zwtydXD+/gba
	CjJ4H56P5l2J3Yo6PxvZklmdf0xO6BXsyickOQsQdCXt8VvUjqQ6c0i8m9p0RA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=ZE2HUEW1vduE+nwYxJZcpioUtu4BlkVt96STEtpw2eQch13KMx7xSoNFoWkYRx0DySvC7X
	qedWpkAyFFcuIdnKdLtoykaO4uE4OVZM8xa6yJv1F9NTHOSPQdrpKAaDghkV2dAV46OyOs
	EXzg948XfS7l2nZWihyufuE2+qF8pOYFygri+UdFMDTTlntyxEw2o7BNBjhJAR9o+l2GsJ
	AK5zJD7/Xi1X1bX2qNsOQ96dTCzJEqnPmux4zY3vZPuL7x2EJ5K746nNek/pYrvz5kQ0UP
	ybPzjsAo8bU5jzVRhzkDGSHXlcYwyVBljXYyLnpllGKaxxeiXtUgu8HaeLp2/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOJSGTTBHjY1JsEFpZjDfD7JOIGBIaKOZxBzKKynSno=;
	b=c4KJF92TCIkP2oWBXhbi/vIV5S3rIji6ikEwhfIQzjq0Zs2JcPGM+utT6doJc5KeB635lt
	e4HwnTaQLRmqY+PNy1mxJxIDpOQx0GXX331D2/PNi4+dKvn/jkDq75nDTPjH/loY4+39ZD
	Zns5gQ4uQUDVb4DNb1/PBiRlJSXn/oF6qfXQQ+XJO2NfjHI1LjZcKHDbpPbvIQjxLlz6g3
	Z8OVlWNafcbfr/tHJhCSMPfau0yuroabYbFo8A6w5maAFyw7FaEiQTG2V9rciD2Qhy04wi
	wirblxtRuAKHkeT/MXWYsvvLz5Kw74i+AyFWQLN1rOuQx3YE3a1F0sMPg3t/8g==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 31BA1380DD7; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
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
Subject: [PATCH net-next v1 6/8] net: dsa: realtek: rtl8365mb: add QoS baseline and DCB default priority
Date: Fri,  2 Oct 2026 13:58:48 +0200
Message-ID: <20261002115850.962676-7-o.rempel@pengutronix.de>
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

Add rtl8365mb_dcb.c to establish a defined QoS baseline and offload the
DCB default priority.

The switch's internal priority is an opaque 3-bit value; give it the
meaning of an IEEE 802.1Q traffic type. The switch classifies from
several domains, each numbered on its own scale: the port default, PCP
and DSCP. A single traffic-type meaning lets each domain map onto the
internal priority with consistent ordering, so Best Effort outranks
Background rather than following the raw PCP number.

Program the baseline explicitly rather than trusting the chip reset
state: set the priority-to-queue map for the chip's queue count, remap
PCP to the internal priority, and give every one of the eight
priority-decision sources a defined weight. Only the port default is
trusted; PCP and DSCP stay untrusted until the admin opts in (apptrust,
added later), and every port defaults to Best Effort, so all traffic
lands on a single egress queue and the baseline has no user-visible
effect on its own.

Select DCB and the 802.1Q helpers following the microchip ksz driver, so
the DCB code needs no CONFIG_DCB guards.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/Kconfig          |   2 +
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/rtl8365mb_dcb.c  | 287 +++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_dcb.h  |  20 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  15 ++
 5 files changed, 325 insertions(+)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_dcb.c
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_dcb.h

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index d6eb6713e5f6..934833adde58 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -33,6 +33,8 @@ config NET_DSA_REALTEK_RTL8365MB
 	tristate "Realtek RTL8365MB switch driver"
 	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL8_4
+	select NET_IEEE8021Q_HELPERS
+	select DCB
 	help
 	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
 
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 72bb42e80c95..052a924519e8 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -20,4 +20,5 @@ rtl8365mb-objs := rtl8365mb_main.o \
 		  rtl8365mb_table.o \
 		  rtl8365mb_vlan.o \
 		  rtl8365mb_l2.o \
+		  rtl8365mb_dcb.o \
 # end of rtl8365mb-objs
diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.c b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
new file mode 100644
index 000000000000..f48e95ef3947
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/* QoS and DCB configuration for the rtl8365mb switch family
+ *
+ * The internal priority is the common rail: every classifier writes onto it,
+ * and it is the 802.1Q traffic type.
+ *
+ * A queue is a traffic class. Priority is not the same as traffic class: the
+ * mapping is policy (Table 8-5 for non-CBS) and collapses 8 priorities onto nq
+ * queues when nq < 8; they only line up here because this is a non-CBS switch
+ * at 8 queues. The code therefore always maps through ieee8021q_tt_to_tc(), never
+ * assuming priority == queue.
+ */
+
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+#include <net/ieee8021q.h>
+
+#include "realtek.h"
+#include "rtl8365mb_dcb.h"
+
+/* The chip's eight internal priorities carry 802.1Q traffic types, so the
+ * two axes must have the same cardinality.
+ */
+static_assert(RTL8365MB_NUM_IPMS == IEEE8021Q_TT_MAX);
+
+/* Per-port output-queue mapping index (selects the queue count). Four ports
+ * per register, 3-bit field. An N-queue configuration selects index N, except
+ * the full eight-queue configuration, which is encoded as index 0 (the field
+ * wraps modulo eight).
+ */
+#define RTL8365MB_QOS_PORT_QUEUE_NUMBER_REG(_p)		(0x0900 + ((_p) >> 2))
+#define RTL8365MB_QOS_PORT_QUEUE_NUMBER_OFFSET(_p)	(((_p) & 0x3) << 2)
+#define RTL8365MB_QOS_QMAP_IDX(_nq)			((_nq) & 0x7)
+
+/* Internal priority -> queue-id map. Eight tables (one per queue count),
+ * indexed [table][prio]; four priorities per register, 3-bit qid. An N-queue
+ * configuration uses table N-1 (1Q is table 0 at 0x0904, 8Q is table 7).
+ */
+#define RTL8365MB_QOS_PRI_TO_QID_TABLE(_nq)		((_nq) - 1)
+#define RTL8365MB_QOS_PRI_TO_QID_REG(_t, _pri) \
+	(0x0904 + ((_t) << 1) + ((_pri) >> 2))
+#define RTL8365MB_QOS_PRI_TO_QID_OFFSET(_pri)		(((_pri) & 0x3) << 2)
+
+/* 802.1p (PCP) -> internal priority remap. Four priorities per register. */
+#define RTL8365MB_QOS_1Q_REMAP_REG(_pri)		(0x0865 + ((_pri) >> 2))
+#define RTL8365MB_QOS_1Q_REMAP_OFFSET(_pri)		(((_pri) & 0x3) << 2)
+
+/* Port-based (default) priority. Four ports per register, 3-bit. */
+#define RTL8365MB_QOS_PORT_PRI_REG(_p)			(0x0877 + ((_p) >> 2))
+#define RTL8365MB_QOS_PORT_PRI_OFFSET(_p)		(((_p) & 0x3) << 2)
+
+/* Default internal priority for unmarked traffic. Best Effort, to match what
+ * an untagged (PCP 0) frame resolves to via ieee8021q_pcp_to_tt().
+ */
+#define RTL8365MB_QOS_DEFAULT_PRIO			IEEE8021Q_TT_BE
+
+/* Priority-decision weight tables. Two tables (each port selects one), eight
+ * sources, one 8-bit weight each, two sources per register. Higher weight
+ * wins; a weight of zero disables the source.
+ */
+#define RTL8365MB_QOS_PRIDEC_TBL0_REG(_s)		(0x087B + ((_s) >> 1))
+#define RTL8365MB_QOS_PRIDEC_TBL1_REG(_s)		(0x0885 + ((_s) >> 1))
+#define RTL8365MB_QOS_PRIDEC_OFFSET(_s)			(((_s) & 0x1) << 3)
+
+/* Each port selects one of the two decision tables; one bit per port. */
+#define RTL8365MB_QOS_PRIDEC_IDX_REG			0x0889
+
+/* Priority-decision sources. The hardware numbers eight sources; this driver
+ * programs the three it uses by name and explicitly disables the rest. The
+ * hardware assigns these source ordinals: PORT=0, ACL=1 (unused), DSCP=2,
+ * 1Q=3, SVLAN=4 (unused), CVLAN=5 (unused), DA=6 (unused), SA=7 (unused).
+ */
+#define RTL8365MB_QOS_PRIDEC_PORT			0
+#define RTL8365MB_QOS_PRIDEC_DSCP			2
+#define RTL8365MB_QOS_PRIDEC_1Q				3
+#define RTL8365MB_QOS_PRIDEC_NUM_SRC			8
+
+/* Priority-decision weights. The baseline trusts only the port-based
+ * priority; every other source is disabled (weight 0). apptrust raises a
+ * trusted source's weight above the port default so that it wins.
+ */
+#define RTL8365MB_QOS_WEIGHT_UNTRUSTED			0
+#define RTL8365MB_QOS_WEIGHT_PORT			1
+
+/* The QoS priority and queue selectors are 3-bit register fields; derive a
+ * field's mask from its bit offset.
+ */
+static inline u32 rtl8365mb_qos_sel_field_mask(unsigned int off)
+{
+	return GENMASK(off + 2, off);
+}
+
+/* The priority-decision weight is an 8-bit register field; derive its mask
+ * from the field's bit offset, mirroring rtl8365mb_qos_sel_field_mask().
+ */
+static inline u32 rtl8365mb_qos_weight_field_mask(unsigned int off)
+{
+	return GENMASK(off + 7, off);
+}
+
+static int rtl8365mb_set_field(struct realtek_priv *priv, u32 reg, u32 mask,
+			       u32 val)
+{
+	return regmap_update_bits(priv->map, reg, mask,
+				  (val << __ffs(mask)) & mask);
+}
+
+static int rtl8365mb_get_field(struct realtek_priv *priv, u32 reg, u32 mask,
+			       u32 *val)
+{
+	int ret;
+
+	ret = regmap_read(priv->map, reg, val);
+	if (ret)
+		return ret;
+
+	*val = (*val & mask) >> __ffs(mask);
+	return 0;
+}
+
+static u32 rtl8365mb_qos_pridec_reg(int table, int src)
+{
+	return table ? RTL8365MB_QOS_PRIDEC_TBL1_REG(src) :
+		       RTL8365MB_QOS_PRIDEC_TBL0_REG(src);
+}
+
+static int rtl8365mb_qos_set_pridec(struct realtek_priv *priv, int table,
+				    int src, u8 weight)
+{
+	int off = RTL8365MB_QOS_PRIDEC_OFFSET(src);
+
+	return rtl8365mb_set_field(priv, rtl8365mb_qos_pridec_reg(table, src),
+				   rtl8365mb_qos_weight_field_mask(off), weight);
+}
+
+static int rtl8365mb_qos_setup_queues(struct realtek_priv *priv,
+				      unsigned int nq)
+{
+	int table = RTL8365MB_QOS_PRI_TO_QID_TABLE(nq);
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	int tt, ret;
+
+	dsa_switch_for_each_port(dp, ds) {
+		u32 reg = RTL8365MB_QOS_PORT_QUEUE_NUMBER_REG(dp->index);
+		int off = RTL8365MB_QOS_PORT_QUEUE_NUMBER_OFFSET(dp->index);
+
+		ret = rtl8365mb_set_field(priv, reg,
+					  rtl8365mb_qos_sel_field_mask(off),
+					  RTL8365MB_QOS_QMAP_IDX(nq));
+		if (ret)
+			return ret;
+	}
+
+	for (tt = 0; tt < IEEE8021Q_TT_MAX; tt++) {
+		u32 reg = RTL8365MB_QOS_PRI_TO_QID_REG(table, tt);
+		int off = RTL8365MB_QOS_PRI_TO_QID_OFFSET(tt);
+		int tc = ieee8021q_tt_to_tc(tt, nq);
+
+		if (tc < 0)
+			return tc;
+
+		/* QID field holds the traffic class */
+		ret = rtl8365mb_set_field(priv, reg,
+					  rtl8365mb_qos_sel_field_mask(off), tc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Map ingress PCP to the internal priority via its 802.1Q traffic type, so
+ * Best Effort (PCP 0) correctly outranks Background (PCP 1).
+ */
+static int rtl8365mb_qos_setup_pcp(struct realtek_priv *priv)
+{
+	int pcp, ret;
+
+	for (pcp = 0; pcp < IEEE_8021Q_MAX_PRIORITIES; pcp++) {
+		u32 reg = RTL8365MB_QOS_1Q_REMAP_REG(pcp);
+		int off = RTL8365MB_QOS_1Q_REMAP_OFFSET(pcp);
+		int tt = ieee8021q_pcp_to_tt(pcp);
+
+		if (tt < 0)
+			return tt;
+
+		ret = rtl8365mb_set_field(priv, reg,
+					  rtl8365mb_qos_sel_field_mask(off), tt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int rtl8365mb_dcb_init(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv = ds->priv;
+	int table, ret;
+
+	/* The priority->queue table is a single switch-wide resource, shared by
+	 * all ports (not per-port).
+	 */
+	ret = rtl8365mb_qos_setup_queues(priv, ds->num_tx_queues);
+	if (ret)
+		return ret;
+
+	ret = rtl8365mb_qos_setup_pcp(priv);
+	if (ret)
+		return ret;
+
+	/* Program every decision source in both tables rather than relying on
+	 * the reset state: only the port default carries weight, the other
+	 * seven sources are disabled. apptrust later raises the weights in the
+	 * trusted table and steers ports to it on demand.
+	 */
+	for (table = 0; table <= 1; table++) {
+		int src;
+
+		for (src = 0; src < RTL8365MB_QOS_PRIDEC_NUM_SRC; src++) {
+			u8 weight = src == RTL8365MB_QOS_PRIDEC_PORT ?
+				    RTL8365MB_QOS_WEIGHT_PORT :
+				    RTL8365MB_QOS_WEIGHT_UNTRUSTED;
+
+			ret = rtl8365mb_qos_set_pridec(priv, table, src, weight);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return regmap_write(priv->map, RTL8365MB_QOS_PRIDEC_IDX_REG, 0);
+}
+
+int rtl8365mb_dcb_init_port(struct dsa_switch *ds, int port)
+{
+	int off = RTL8365MB_QOS_PORT_PRI_OFFSET(port);
+	struct realtek_priv *priv = ds->priv;
+
+	/* All ports default to Best Effort: with no source trusted, every port
+	 * treats its traffic as unmarked, matching the default PCP result
+	 * so classification stays consistent once the admin opts a source in.
+	 */
+	return rtl8365mb_set_field(priv, RTL8365MB_QOS_PORT_PRI_REG(port),
+				   rtl8365mb_qos_sel_field_mask(off),
+				   RTL8365MB_QOS_DEFAULT_PRIO);
+}
+
+int rtl8365mb_port_get_default_prio(struct dsa_switch *ds, int port)
+{
+	int off = RTL8365MB_QOS_PORT_PRI_OFFSET(port);
+	struct realtek_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	ret = rtl8365mb_get_field(priv, RTL8365MB_QOS_PORT_PRI_REG(port),
+				  rtl8365mb_qos_sel_field_mask(off), &val);
+	if (ret)
+		return ret;
+
+	/* The register holds the internal priority (an 802.1Q traffic type);
+	 * dcbnl expects an 802.1p priority.
+	 */
+	return ieee8021q_tt_to_pcp(val);
+}
+
+int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
+{
+	int off = RTL8365MB_QOS_PORT_PRI_OFFSET(port);
+	struct realtek_priv *priv = ds->priv;
+	int tt;
+
+	if (prio >= IEEE_8021Q_MAX_PRIORITIES)
+		return -ERANGE;
+
+	/* dcbnl passes an 802.1p priority; the register holds the internal
+	 * priority (an 802.1Q traffic type).
+	 */
+	tt = ieee8021q_pcp_to_tt(prio);
+	if (tt < 0)
+		return tt;
+
+	return rtl8365mb_set_field(priv, RTL8365MB_QOS_PORT_PRI_REG(port),
+				   rtl8365mb_qos_sel_field_mask(off), tt);
+}
diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.h b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
new file mode 100644
index 000000000000..4f8068dd3522
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* QoS and DCB configuration for the rtl8365mb switch family */
+
+#ifndef _REALTEK_RTL8365MB_DCB_H
+#define _REALTEK_RTL8365MB_DCB_H
+
+#include <linux/types.h>
+#include <net/dsa.h>
+
+/* The switch has eight internal priorities (0..7). The egress queue count is
+ * a per-chip property; see struct rtl8365mb_chip_info::num_tx_queues.
+ */
+#define RTL8365MB_NUM_IPMS		8
+
+int rtl8365mb_dcb_init(struct dsa_switch *ds);
+int rtl8365mb_dcb_init_port(struct dsa_switch *ds, int port);
+int rtl8365mb_port_get_default_prio(struct dsa_switch *ds, int port);
+int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
+
+#endif /* _REALTEK_RTL8365MB_DCB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 0924d31790e0..5a3f4328354e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -108,6 +108,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
+#include "rtl8365mb_dcb.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
 
@@ -3187,6 +3188,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
+		/* Default the port QoS (default priority = Best Effort) */
+		ret = rtl8365mb_dcb_init_port(ds, dp->index);
+		if (ret)
+			goto out_teardown_irq;
+
 		/* Set up per-port private data */
 		p->priv = priv;
 		p->index = dp->index;
@@ -3274,6 +3280,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	 */
 	ds->num_tx_queues = mb->chip_info->num_tx_queues;
 
+	/* Establish a defined QoS baseline: program the priority-to-queue map
+	 * for the chip's queue count and trust only the port default priority.
+	 */
+	ret = rtl8365mb_dcb_init(ds);
+	if (ret)
+		goto out_teardown_irq;
+
 	/* Start statistics counter polling */
 	ret = rtl8365mb_stats_setup(priv);
 	if (ret) {
@@ -3435,6 +3448,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_pre_bridge_flags = rtl8365mb_port_pre_bridge_flags,
 	.port_bridge_flags = rtl83xx_port_bridge_flags,
+	.port_get_default_prio = rtl8365mb_port_get_default_prio,
+	.port_set_default_prio = rtl8365mb_port_set_default_prio,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
-- 
2.47.3

