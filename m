Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC8495AD8;
	Fri,  2 Oct 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942342; cv=pass; b=LiOssS6RfBeSd3ZHESqvSbF/Bb4Esr6Emq7PazdTJymtgwrYYAvsg8/uTMEKuuExF35G3z3bdfe5m1wP5qxa/2lf5+5U4KXfSxQCIYVhngQqIcub8N/fSH7aj3Y5vyfqOGAkhak/S1TVjziwk7QmFIj8syyB20am8+gs1PGiojc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942342; c=relaxed/simple;
	bh=LIrne//FW+ohWlxaSeDDhQQaLgHHlQquHfKqze55+/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgIhc+gvEJnil/QAU/CeV7u3Km62HM0A6AAxIkpi6hOGi/2Nlu4Td5Qi5lcnrbVm3BmXph1RtnHtKYzb14eRzBDYc0gOk87cx8rQOAc2/fqPILk0fi0hRKnS+t7jLZH5aMGpDOmxSOAyYP7Myfnr9ifHC4Ia6NX7G9Da9aJbHXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=AB+FtCtF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="AB+FtCtF"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5BE35202342;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylHg+6av2qYflcLUx7D/kueUtXLPeG16VXlykA4eGMk=;
	b=AB+FtCtFWjhTU+/DixLOsqnC0bAZi26OEzTXseF5mdjVapI9XJZTLgeaVrRVPzVYh7tuwz
	FazwwihANbm6EH9eyH6g1reb3+x4WCtObrZufHjCWCtp7ZQOYUkBfIeIbLa3FvM+MPLVhW
	MWPQC1jn8sWwK3aife2Av7YkvN9+zysY11XntoiZCGXLbi/r++oXetberMfy+gnEJr1y4I
	amm2/joqG/exsHmknVlvAjBDen+Omhv2qVUantxULAMJzbkJuAOlLwUyk+5+MuZP49wDxp
	y3RPZ1DM/Wee2uGFfGsGrxMnkoAxSi3Fq1n9c/Cvt1b7A1Seud4WohRwGfF7kw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=dISitSQJ5WwZdUzmgxzCwLKRz4xvRDvvqYzjEagL0YAoCIMqb0hJyOP1ZshdgkRBvMigDD
	iHPfA3QrB6hP2yz4bWA99H+Ihgku+SGUWlG8b6Vsrskq8vaN4eVn7Q5Fahf0SVI06gDepQ
	OqVOePCnP9kbKWAlXslo9V6VOcrstRLGBz6pODIwBFqY9+HRYjYN9MH9PEj7uRE/hFh1vA
	/fQ0R3DcLdzhrBRR4OFmOGTKKuzU01d9cOab5LH9n1kiuQPlDSE7yaJjW/Xnf81aDL9FlI
	etsD/ZeiuekrdiKRrBsG2Gxr+Z6fk3S1zw0KQmMYqukCxs06iXz+2Z2jz+wwPw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylHg+6av2qYflcLUx7D/kueUtXLPeG16VXlykA4eGMk=;
	b=bDolpKs4CvKhIvjtzyE6jkqB0X7mmQx71qHoUPTZ7w3gq36jXURGxAs2/evxLa9pjmH31d
	rKqVBBzjZle2HSbweu0hsSavHa9+G7AsZ6SwepifeZiPyT1ktoKXpI3HwG4ARar+TSZMC6
	Lr659iEW4OwNVNMG0ZCZCo66hW64rAGmBGyfAwG+TUgKQWcbR9/gLm5bM3twRwr/muGWKA
	vUFglrC7NgjfCyImIBna903XxCd/e1InNW25PaaK00gL2IYAGHb9l00yyVL2SCl1wqe/zr
	6buGkA6jR5SgE+amhEIckKNICYRZQ3dxw8EwbTiavkHA8F5qTC9bWXYcCccR3Q==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 49682380BA7; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
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
Subject: [PATCH net-next v1 8/8] net: dsa: realtek: rtl8365mb: offload DCB DSCP-to-priority
Date: Fri,  2 Oct 2026 13:58:50 +0200
Message-ID: <20261002115850.962676-9-o.rempel@pengutronix.de>
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

Wire up port_get_dscp_prio/port_add_dscp_prio/port_del_dscp_prio so
dcbnl can program the DSCP-to-internal-priority mapping. The mapping
only takes effect on ports that trust DSCP via apptrust, so it stays
inert on the default (untrusted) configuration.

The DSCP table is a single switch-wide resource, so set
ds->dscp_prio_mapping_is_global and let the DSA core keep the app table
consistent across ports; no per-port bookkeeping is needed. add and
del write the global table; del reverts the entry to the standard
IETF default for that DSCP (ietf_dscp_to_ieee8021q_tt()) and only when
the table still holds the priority being removed, matching dcbnl's
replace sequence.

rtl8365mb_dcb_init() seeds the whole table with the same IETF mapping
so the switch behaves predictably as soon as DSCP is trusted, rather
than relying on the chip reset value.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/rtl8365mb_dcb.c  | 113 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_dcb.h  |   5 +
 drivers/net/dsa/realtek/rtl8365mb_main.c |   4 +
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.c b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
index 4afcae6e85a1..091dc8189e73 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_dcb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
@@ -54,10 +54,16 @@ static_assert(RTL8365MB_NUM_IPMS == IEEE8021Q_TT_MAX);
 #define RTL8365MB_QOS_PORT_PRI_OFFSET(_p)		(((_p) & 0x3) << 2)
 
 /* Default internal priority for unmarked traffic. Best Effort, to match what
- * an untagged (PCP 0) frame resolves to via ieee8021q_pcp_to_tt().
+ * an untagged (PCP 0) frame and a default-marked (DSCP CS0) frame resolve to
+ * via ieee8021q_pcp_to_tt() and ietf_dscp_to_ieee8021q_tt().
  */
 #define RTL8365MB_QOS_DEFAULT_PRIO			IEEE8021Q_TT_BE
 
+/* DSCP -> internal priority. Global table, four DSCP per register, 3-bit. */
+#define RTL8365MB_QOS_DSCP_PRI_REG(_d)			(0x0867 + ((_d) >> 2))
+#define RTL8365MB_QOS_DSCP_PRI_OFFSET(_d)		(((_d) & 0x3) << 2)
+#define RTL8365MB_DSCP_MAX				64
+
 /* Priority-decision weight tables. Two tables (each port selects one), eight
  * sources, one 8-bit weight each, two sources per register. Higher weight
  * wins; a weight of zero disables the source.
@@ -142,6 +148,15 @@ static int rtl8365mb_get_field(struct realtek_priv *priv, u32 reg, u32 mask,
 	return 0;
 }
 
+static int rtl8365mb_qos_set_dscp_prio(struct realtek_priv *priv, u8 dscp,
+				       u8 prio)
+{
+	int off = RTL8365MB_QOS_DSCP_PRI_OFFSET(dscp);
+
+	return rtl8365mb_set_field(priv, RTL8365MB_QOS_DSCP_PRI_REG(dscp),
+				   rtl8365mb_qos_sel_field_mask(off), prio);
+}
+
 static u32 rtl8365mb_qos_pridec_reg(int table, int src)
 {
 	return table ? RTL8365MB_QOS_PRIDEC_TBL1_REG(src) :
@@ -234,6 +249,27 @@ static int rtl8365mb_qos_setup_pcp(struct realtek_priv *priv)
 	return 0;
 }
 
+/* Seed the DSCP -> priority table with the standard IETF mapping, so it is
+ * meaningful once a port opts in to trusting DSCP via apptrust.
+ */
+static int rtl8365mb_qos_setup_dscp(struct realtek_priv *priv)
+{
+	int dscp, ret;
+
+	for (dscp = 0; dscp < RTL8365MB_DSCP_MAX; dscp++) {
+		int tt = ietf_dscp_to_ieee8021q_tt(dscp);
+
+		if (tt < 0)
+			return tt;
+
+		ret = rtl8365mb_qos_set_dscp_prio(priv, dscp, tt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int rtl8365mb_dcb_init(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -250,6 +286,10 @@ int rtl8365mb_dcb_init(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	ret = rtl8365mb_qos_setup_dscp(priv);
+	if (ret)
+		return ret;
+
 	/* Program every decision source in both tables rather than relying on
 	 * the reset state: only the port default carries weight, the other
 	 * seven sources are disabled. apptrust later raises the weights in the
@@ -278,7 +318,7 @@ int rtl8365mb_dcb_init_port(struct dsa_switch *ds, int port)
 	struct realtek_priv *priv = ds->priv;
 
 	/* All ports default to Best Effort: with no source trusted, every port
-	 * treats its traffic as unmarked, matching the default PCP result
+	 * treats its traffic as unmarked, matching the default PCP/DSCP result
 	 * so classification stays consistent once the admin opts a source in.
 	 */
 	return rtl8365mb_set_field(priv, RTL8365MB_QOS_PORT_PRI_REG(port),
@@ -324,6 +364,75 @@ int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 				   rtl8365mb_qos_sel_field_mask(off), tt);
 }
 
+int rtl8365mb_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	int off = RTL8365MB_QOS_DSCP_PRI_OFFSET(dscp);
+	struct realtek_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	if (dscp >= RTL8365MB_DSCP_MAX)
+		return -EINVAL;
+
+	ret = rtl8365mb_get_field(priv, RTL8365MB_QOS_DSCP_PRI_REG(dscp),
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
+int rtl8365mb_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio)
+{
+	struct realtek_priv *priv = ds->priv;
+	int tt;
+
+	if (dscp >= RTL8365MB_DSCP_MAX)
+		return -EINVAL;
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
+	return rtl8365mb_qos_set_dscp_prio(priv, dscp, tt);
+}
+
+int rtl8365mb_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio)
+{
+	struct realtek_priv *priv = ds->priv;
+	int tt, ret;
+
+	if (dscp >= RTL8365MB_DSCP_MAX)
+		return -EINVAL;
+
+	/* dcbnl replaces an entry by adding the new one before deleting the
+	 * old, so only revert if the table still holds the removed priority.
+	 */
+	ret = rtl8365mb_port_get_dscp_prio(ds, port, dscp);
+	if (ret < 0)
+		return ret;
+	if (ret != prio)
+		return 0;
+
+	/* Revert to the standard IETF default mapping for this DSCP. */
+	tt = ietf_dscp_to_ieee8021q_tt(dscp);
+	if (tt < 0)
+		return tt;
+
+	return rtl8365mb_qos_set_dscp_prio(priv, dscp, tt);
+}
+
 /* Read which sources a decision table trusts (weight != 0), indexed like
  * rtl8365mb_apptrust_map[].
  */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.h b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
index 156fa6e1c4fd..ebe6f1628734 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_dcb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.h
@@ -20,5 +20,10 @@ int rtl8365mb_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
 				int *nsel);
 int rtl8365mb_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
 				int nsel);
+int rtl8365mb_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
+int rtl8365mb_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio);
+int rtl8365mb_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio);
 
 #endif /* _REALTEK_RTL8365MB_DCB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 77f971abf783..9fe87c295795 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3283,6 +3283,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	/* Establish a defined QoS baseline: program the priority-to-queue map
 	 * for the chip's queue count and trust only the port default priority.
 	 */
+	ds->dscp_prio_mapping_is_global = true;
 	ret = rtl8365mb_dcb_init(ds);
 	if (ret)
 		goto out_teardown_irq;
@@ -3452,6 +3453,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_set_default_prio = rtl8365mb_port_set_default_prio,
 	.port_get_apptrust = rtl8365mb_port_get_apptrust,
 	.port_set_apptrust = rtl8365mb_port_set_apptrust,
+	.port_get_dscp_prio = rtl8365mb_port_get_dscp_prio,
+	.port_add_dscp_prio = rtl8365mb_port_add_dscp_prio,
+	.port_del_dscp_prio = rtl8365mb_port_del_dscp_prio,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
-- 
2.47.3

