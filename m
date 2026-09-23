Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB3494835;
	Wed, 23 Sep 2026 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160002; cv=none; b=MsVQtg9+/+GzayUCoO5Ddw2Q89FoZK+0uDOEw5QLRQoeDkgXfzgYm3CAimAK+ifsLNDKwJHlsVoaVlhM/iSsxGhCqTDopZzD3A+Bx/OjjLiku0TnACePNseZFSi6NMf6SLLYSKniyYZgVD+OxFzQWmCV7v3frnKRJ8PF1UPlsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160002; c=relaxed/simple;
	bh=TxwSK6Y0b5TgpjR7a/u719a4G3NxmNq7t9yj8Gg3aZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/cXCoAunMLdx+A6U6fgE5cLaGMBrFgQrBopQEw5Tw/Kyvt8+Sih81ZHx2JSJ+7dk1OlLcBslCLkciz2mIfbhylqfI86zCNs4Y4OQuhN+U7+Gzi4rEAQ3aZEmm12RBpxb632HlRZ2u/LqQC4XOKhsIPaegI6YzN0VgiIoo9gF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPeKSvT4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mD/fNZMi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPeKSvT4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD/fNZMi"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxHIQMNUG0po+e6KZ3ydpoDSMlER+beOviOrigSCjqU=;
	b=zPeKSvT4YbA0kFlveoNHgxX7WhWkCkA8d68zIz1POP7Dppu4IBTKHCvJI40cNw/ttxqlwc
	S8ybQSgKMfFiaSNVRsw8wWzqgO4EHixU1x+e8mw+O/2DpEm3AZ1JTicKLvpEcumPw+CnCm
	fIQ4Ys0P7qPzHrORuMOc8RdzBzXmsYzL6Y6Bv2XwhoZzBbI9YXXHhBXTLisSS1EN8MtCC5
	8O/qAP9alvAwP5iYmHc57uwCFI6JOQD0wJQLFUfQDNk9d4x1b66A0BSwxU3qpSOLyAgXJr
	cft1nnJDDVDCufnvXk4EKTxtn8H2waSmGknf3PZ1E5TNxEHiTJnm4U/FQOs4rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxHIQMNUG0po+e6KZ3ydpoDSMlER+beOviOrigSCjqU=;
	b=mD/fNZMiRImlX+VoTci6FpT/tZXUBAF9/GYhFKYaxlTk/dKHnk9/ygCfIJMuTEe9r5pgZ0
	wm1a1X5FV3Nf9GAg==
Date: Wed, 23 Sep 2026 12:39:34 +0200
Subject: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add VLAN filtering and membership offload for switch configurations that
implement the Port VLAN synthesis option. Without this feature active,
the switch removes VLAN information on CPU ingress without including the
removed information in the DSA tag. To avoid silent drops and
misbehaviour in this case, reject VLAN operations with a netlink
extended acknowledgment.

If the feature is available, configure ports in Hybrid and C-Port modes
and manage their PVID, ingress filtering and acceptance mode, and custom
egress untagging. Program the per-VID member and untagged port masks
through the hardware selector interface.

The port and VID selectors are shared by all VLAN operations, so
serialize selector and data register sequences with a dedicated mutex.
Track member and untagged masks in software and restore the shadow state
if programming fails.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/dsa/soce/soce_dsa.h      |  11 +
 drivers/net/dsa/soce/soce_dsa_core.c | 388 ++++++++++++++++++++++++++++++++++-
 2 files changed, 392 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
index 2acd4dbaf958..41533a89d680 100644
--- a/drivers/net/dsa/soce/soce_dsa.h
+++ b/drivers/net/dsa/soce/soce_dsa.h
@@ -9,6 +9,7 @@
 #define __SOCE_DSA_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 #include <net/dsa.h>
 
@@ -18,8 +19,18 @@ struct soce_dsa_local {
 	void __iomem *base_addr;
 };
 
+struct soce_features {
+	u32 num_ports;
+	bool port_vlan;
+};
+
 struct soce_priv {
 	struct soce_dsa_local local;
+	struct soce_features features;
+	struct mutex vlan_lock; /* Serializes selector-based VLAN accesses */
+	u32 *vlan_members;
+	u32 *vlan_untagged;
+	u16 port_pvid[SOCE_MAX_NUM_PORTS];
 	struct dsa_switch ds;
 };
 
diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
index d391b11b94ad..f93ce9da8400 100644
--- a/drivers/net/dsa/soce/soce_dsa_core.c
+++ b/drivers/net/dsa/soce/soce_dsa_core.c
@@ -5,7 +5,10 @@
  * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
  */
 
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
@@ -48,6 +51,39 @@
 #define SOCE_PORTS_CTRL_INGR_EN			BIT(0)
 #define SOCE_PORTS_CTRL_EGR_EN			BIT(1)
 
+#define SOCE_VLAN_REGS_BASE			0x0d00
+#define SOCE_VLAN_CTRL_OFFSET			SOCE_VLAN_REGS_BASE
+#define SOCE_VLAN_CTRL_ENABLE			BIT(0)
+#define SOCE_VLAN_RESET_OFFSET			(SOCE_VLAN_REGS_BASE + 0x0004)
+#define SOCE_VLAN_RESET_CMD			BIT(0)
+#define SOCE_VLAN_PORT_SEL_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0010)
+#define SOCE_VLAN_PORT_SEL_PORT_MASK		GENMASK(7, 0)
+#define SOCE_VLAN_PORT_MODE_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0014)
+#define SOCE_VLAN_PORT_MODE_HYBRID		0x2
+#define SOCE_VLAN_PORT_TYPE_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0018)
+#define SOCE_VLAN_PORT_TYPE_UNAWARE		0x0
+#define SOCE_VLAN_PORT_TYPE_C_PORT		0x1
+#define SOCE_VLAN_PORT_VLAN_OFFSET		(SOCE_VLAN_REGS_BASE + 0x001c)
+#define SOCE_VLAN_PORT_VLAN_PVID_MASK		GENMASK(11, 0)
+#define SOCE_VLAN_PORT_INGR_FILTER_OFFSET	(SOCE_VLAN_REGS_BASE + 0x0020)
+#define SOCE_VLAN_PORT_INGR_FILTER_EN		BIT(0)
+#define SOCE_VLAN_PORT_INGR_ACCEPT_OFFSET	(SOCE_VLAN_REGS_BASE + 0x0024)
+#define SOCE_VLAN_PORT_INGR_ACCEPT_ALL		0x0
+#define SOCE_VLAN_PORT_INGR_ACCEPT_TAGGED_ONLY	0x1
+#define SOCE_VLAN_PORT_EGR_TAG_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0028)
+#define SOCE_VLAN_PORT_EGR_TAG_MASK		GENMASK(1, 0)
+#define SOCE_VLAN_PORT_EGR_TAG_UNTAG_PORT	0x0
+#define SOCE_VLAN_PORT_EGR_TAG_CUSTOM_UNTAG	0x3
+#define SOCE_VLAN_VID_SEL_OFFSET		(SOCE_VLAN_REGS_BASE + 0x002c)
+#define SOCE_VLAN_VID_SEL_VID_MASK		GENMASK(11, 0)
+#define SOCE_VLAN_MEMBER_CTRL_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0030)
+#define SOCE_VLAN_MEMBER_CTRL_WRITE		BIT(0)
+#define SOCE_VLAN_MEMBER_PORTS_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0034)
+#define SOCE_VLAN_UNTAG_CTRL_OFFSET		(SOCE_VLAN_REGS_BASE + 0x003c)
+#define SOCE_VLAN_UNTAG_CTRL_WRITE		BIT(0)
+#define SOCE_VLAN_UNTAG_PORTS_OFFSET		(SOCE_VLAN_REGS_BASE + 0x0040)
+#define SOCE_VLAN_CMD_TIMEOUT_US		1000
+
 static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -107,7 +143,7 @@ static void soce_sw_read_core_version(struct soce_dsa_local *local,
 }
 
 static int soce_sw_detect_features(struct soce_dsa_local *local,
-				   u32 *numports)
+				   struct soce_features *features)
 {
 	void __iomem *base = local->base_addr;
 	u32 implemented_numports;
@@ -123,13 +159,15 @@ static int soce_sw_detect_features(struct soce_dsa_local *local,
 	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
 		return -ENODEV;
 
+	features->port_vlan = regval & SOCE_IMPL_FEATURES0_PORT_VLAN;
+
 	implemented_numports =
 		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
 	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
 	    implemented_numports > licensed_numports)
 		return -EINVAL;
 
-	*numports = implemented_numports;
+	features->num_ports = implemented_numports;
 
 	return 0;
 }
@@ -162,6 +200,178 @@ static void soce_sw_disable_tagging(struct soce_dsa_local *local)
 	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
 }
 
+static void soce_vlan_set_enabled(struct soce_dsa_local *local, bool enabled)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	regval = readl(base + SOCE_VLAN_CTRL_OFFSET);
+	if (enabled)
+		regval |= SOCE_VLAN_CTRL_ENABLE;
+	else
+		regval &= ~SOCE_VLAN_CTRL_ENABLE;
+	writel(regval, base + SOCE_VLAN_CTRL_OFFSET);
+}
+
+static int soce_vlan_reset(struct soce_dsa_local *local)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	writel(SOCE_VLAN_RESET_CMD, base + SOCE_VLAN_RESET_OFFSET);
+
+	return readl_poll_timeout(base + SOCE_VLAN_RESET_OFFSET,
+				  regval, !(regval & SOCE_VLAN_RESET_CMD), 10,
+				  SOCE_VLAN_CMD_TIMEOUT_US);
+}
+
+static int soce_vlan_wait_for_write(struct soce_dsa_local *local, u32 offset,
+				    u32 mask)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	return readl_poll_timeout(base + offset, regval,
+				  !(regval & mask), 10,
+				  SOCE_VLAN_CMD_TIMEOUT_US);
+}
+
+static void soce_vlan_select_port(struct soce_dsa_local *local, int port)
+{
+	writel(FIELD_PREP(SOCE_VLAN_PORT_SEL_PORT_MASK, port),
+	       local->base_addr + SOCE_VLAN_PORT_SEL_OFFSET);
+}
+
+static void soce_vlan_select_vid(struct soce_dsa_local *local, u16 vid)
+{
+	writel(FIELD_PREP(SOCE_VLAN_VID_SEL_VID_MASK, vid),
+	       local->base_addr + SOCE_VLAN_VID_SEL_OFFSET);
+}
+
+static void soce_vlan_config_port(struct soce_priv *priv, int port,
+				  bool vlan_filtering)
+{
+	struct soce_dsa_local *local = &priv->local;
+	void __iomem *base = local->base_addr;
+	u32 egress_tagging;
+	u32 port_type;
+	u32 regval;
+	u32 accept;
+
+	port_type = vlan_filtering ? SOCE_VLAN_PORT_TYPE_C_PORT :
+				     SOCE_VLAN_PORT_TYPE_UNAWARE;
+	egress_tagging = vlan_filtering ? SOCE_VLAN_PORT_EGR_TAG_CUSTOM_UNTAG :
+					   SOCE_VLAN_PORT_EGR_TAG_UNTAG_PORT;
+
+	soce_vlan_select_port(local, port);
+	writel(SOCE_VLAN_PORT_MODE_HYBRID, base + SOCE_VLAN_PORT_MODE_OFFSET);
+	writel(port_type, base + SOCE_VLAN_PORT_TYPE_OFFSET);
+	writel(FIELD_PREP(SOCE_VLAN_PORT_VLAN_PVID_MASK,
+			  priv->port_pvid[port]),
+	       base + SOCE_VLAN_PORT_VLAN_OFFSET);
+	writel(vlan_filtering ? SOCE_VLAN_PORT_INGR_FILTER_EN : 0,
+	       base + SOCE_VLAN_PORT_INGR_FILTER_OFFSET);
+
+	/* Without a PVID, untagged frames have no VLAN to be classified
+	 * into, so only accept tagged frames while filtering.
+	 */
+	accept = vlan_filtering && !priv->port_pvid[port] ?
+			 SOCE_VLAN_PORT_INGR_ACCEPT_TAGGED_ONLY :
+			 SOCE_VLAN_PORT_INGR_ACCEPT_ALL;
+	writel(accept, base + SOCE_VLAN_PORT_INGR_ACCEPT_OFFSET);
+
+	regval = readl(base + SOCE_VLAN_PORT_EGR_TAG_OFFSET);
+	regval &= ~SOCE_VLAN_PORT_EGR_TAG_MASK;
+	regval |= FIELD_PREP(SOCE_VLAN_PORT_EGR_TAG_MASK, egress_tagging);
+	writel(regval, base + SOCE_VLAN_PORT_EGR_TAG_OFFSET);
+}
+
+static int soce_vlan_write_entry(struct soce_priv *priv, u16 vid)
+{
+	struct soce_dsa_local *local = &priv->local;
+	void __iomem *base = local->base_addr;
+	u32 cpu_ports;
+	u32 untagged;
+	u32 members;
+	int ret;
+
+	/* The CPU port must be a tagged member of every active VLAN so
+	 * tagged frames can reach the conduit.
+	 */
+	cpu_ports = dsa_cpu_ports(&priv->ds);
+	members = priv->vlan_members[vid];
+	if (members)
+		members |= cpu_ports;
+	untagged = priv->vlan_untagged[vid] & ~cpu_ports;
+
+	soce_vlan_select_vid(local, vid);
+	writel(members, base + SOCE_VLAN_MEMBER_PORTS_OFFSET);
+	writel(SOCE_VLAN_MEMBER_CTRL_WRITE,
+	       base + SOCE_VLAN_MEMBER_CTRL_OFFSET);
+	ret = soce_vlan_wait_for_write(local, SOCE_VLAN_MEMBER_CTRL_OFFSET,
+				       SOCE_VLAN_MEMBER_CTRL_WRITE);
+	if (ret)
+		return ret;
+
+	writel(untagged, base + SOCE_VLAN_UNTAG_PORTS_OFFSET);
+	writel(SOCE_VLAN_UNTAG_CTRL_WRITE,
+	       base + SOCE_VLAN_UNTAG_CTRL_OFFSET);
+
+	return soce_vlan_wait_for_write(local, SOCE_VLAN_UNTAG_CTRL_OFFSET,
+					SOCE_VLAN_UNTAG_CTRL_WRITE);
+}
+
+static int soce_vlan_setup(struct dsa_switch *ds)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	struct dsa_port *dp;
+	int ret;
+
+	local = &priv->local;
+
+	if (!priv->features.port_vlan)
+		return 0;
+
+	ret = soce_vlan_reset(local);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset VLAN configuration: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* Default every port to PVID 1, unfiltered, so standalone
+	 * forwarding keeps working before any bridge VLAN is configured.
+	 */
+	scoped_guard(mutex, &priv->vlan_lock) {
+		dsa_switch_for_each_available_port(dp, ds) {
+			priv->port_pvid[dp->index] = 1;
+			soce_vlan_config_port(priv, dp->index, false);
+		}
+		soce_vlan_set_enabled(local, true);
+	}
+
+	return 0;
+}
+
+static void soce_vlan_teardown(struct soce_priv *priv)
+{
+	struct soce_dsa_local *local = &priv->local;
+	int ret;
+
+	if (!priv->features.port_vlan)
+		return;
+
+	scoped_guard(mutex, &priv->vlan_lock) {
+		ret = soce_vlan_reset(local);
+		if (ret)
+			dev_warn(priv->ds.dev,
+				 "failed to reset VLAN configuration during teardown: %d\n",
+				 ret);
+		soce_vlan_set_enabled(local, false);
+	}
+}
+
 static void soce_port_select(struct soce_dsa_local *local, int port)
 {
 	writel(FIELD_PREP(SOCE_PORTS_SELECTOR_PORT_MASK, port),
@@ -204,6 +414,11 @@ static void soce_port_disable(struct dsa_switch *ds, int port)
 static int soce_setup(struct dsa_switch *ds)
 {
 	struct soce_priv *priv = ds->priv;
+	int ret;
+
+	ret = soce_vlan_setup(ds);
+	if (ret)
+		return ret;
 
 	soce_sw_enable_tagging(&priv->local);
 
@@ -213,8 +428,12 @@ static int soce_setup(struct dsa_switch *ds)
 static void soce_teardown(struct dsa_switch *ds)
 {
 	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+
+	local = &priv->local;
 
-	soce_sw_disable_tagging(&priv->local);
+	soce_sw_disable_tagging(local);
+	soce_vlan_teardown(priv);
 }
 
 static enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds,
@@ -224,6 +443,130 @@ static enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_SDSA;
 }
 
+static int soce_port_vlan_add(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct soce_priv *priv = ds->priv;
+	u32 port_mask = BIT(port);
+	u32 *untagged_ports;
+	u32 old_untagged;
+	u32 old_members;
+	bool untagged;
+	u32 *members;
+	int ret;
+
+	untagged_ports = priv->vlan_untagged;
+	members = priv->vlan_members;
+
+	if (!priv->features.port_vlan) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Port VLAN support is not implemented in the switch core");
+		return -EOPNOTSUPP;
+	}
+
+	if (!vlan->vid)
+		return 0;
+
+	untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+
+	scoped_guard(mutex, &priv->vlan_lock) {
+		old_members = members[vlan->vid];
+		old_untagged = untagged_ports[vlan->vid];
+
+		members[vlan->vid] |= port_mask;
+		if (untagged)
+			untagged_ports[vlan->vid] |= port_mask;
+		else
+			untagged_ports[vlan->vid] &= ~port_mask;
+
+		ret = soce_vlan_write_entry(priv, vlan->vid);
+		if (ret) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "failed to update VLAN hardware tables");
+			dev_err(ds->dev,
+				"failed to add VLAN %u on port %d: %d\n",
+				vlan->vid, port, ret);
+			members[vlan->vid] = old_members;
+			untagged_ports[vlan->vid] = old_untagged;
+			return ret;
+		}
+
+		if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+			priv->port_pvid[port] = vlan->vid;
+			soce_vlan_config_port(priv, port,
+					      dsa_port_is_vlan_filtering(dp));
+		}
+	}
+
+	return ret;
+}
+
+static int soce_port_vlan_del(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct soce_priv *priv = ds->priv;
+	u32 port_mask = BIT(port);
+	u32 *untagged_ports;
+	u32 old_untagged;
+	u32 old_members;
+	u32 *members;
+	int ret;
+
+	untagged_ports = priv->vlan_untagged;
+	members = priv->vlan_members;
+
+	if (!priv->features.port_vlan)
+		return -EOPNOTSUPP;
+
+	if (!vlan->vid)
+		return 0;
+
+	scoped_guard(mutex, &priv->vlan_lock) {
+		old_members = members[vlan->vid];
+		old_untagged = untagged_ports[vlan->vid];
+		members[vlan->vid] &= ~port_mask;
+		untagged_ports[vlan->vid] &= ~port_mask;
+		ret = soce_vlan_write_entry(priv, vlan->vid);
+		if (ret) {
+			dev_err(ds->dev,
+				"failed to delete VLAN %u from port %d: %d\n",
+				vlan->vid, port, ret);
+			members[vlan->vid] = old_members;
+			untagged_ports[vlan->vid] = old_untagged;
+			return ret;
+		}
+
+		if (priv->port_pvid[port] == vlan->vid) {
+			priv->port_pvid[port] = 0;
+			soce_vlan_config_port(priv, port,
+					      dsa_port_is_vlan_filtering(dp));
+		}
+	}
+
+	return ret;
+}
+
+static int soce_port_vlan_filtering(struct dsa_switch *ds, int port,
+				    bool vlan_filtering,
+				    struct netlink_ext_ack *extack)
+{
+	struct soce_priv *priv = ds->priv;
+
+	if (!priv->features.port_vlan) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Port VLAN support is not implemented in the switch core");
+		return -EOPNOTSUPP;
+	}
+
+	scoped_guard(mutex, &priv->vlan_lock)
+		soce_vlan_config_port(priv, port, vlan_filtering);
+
+	return 0;
+}
+
 static const struct dsa_switch_ops soce_switch_ops = {
 	.get_tag_protocol	= soce_get_tag_protocol,
 	.setup			= soce_setup,
@@ -231,6 +574,9 @@ static const struct dsa_switch_ops soce_switch_ops = {
 	.phylink_get_caps	= soce_phylink_get_caps,
 	.port_enable		= soce_port_enable,
 	.port_disable		= soce_port_disable,
+	.port_vlan_filtering	= soce_port_vlan_filtering,
+	.port_vlan_add		= soce_port_vlan_add,
+	.port_vlan_del		= soce_port_vlan_del,
 };
 
 static int soce_sw_probe(struct platform_device *pdev)
@@ -241,7 +587,6 @@ static int soce_sw_probe(struct platform_device *pdev)
 	struct dsa_switch *ds;
 	u8 hw_subversion;
 	u16 hw_revision;
-	u32 hw_numports;
 	u8 hw_version;
 	int ret;
 
@@ -261,7 +606,7 @@ static int soce_sw_probe(struct platform_device *pdev)
 	soce_sw_read_core_version(local, &hw_version, &hw_subversion,
 				  &hw_revision);
 
-	ret = soce_sw_detect_features(local, &hw_numports);
+	ret = soce_sw_detect_features(local, &priv->features);
 	if (ret) {
 		if (ret == -ENODEV)
 			dev_err(dev, "switch core does not implement DSA\n");
@@ -278,8 +623,35 @@ static int soce_sw_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (priv->features.port_vlan) {
+		ret = devm_mutex_init(dev, &priv->vlan_lock);
+		if (ret)
+			return ret;
+
+		priv->vlan_members =
+			devm_kcalloc(dev, VLAN_N_VID,
+				     sizeof(*priv->vlan_members), GFP_KERNEL);
+		if (!priv->vlan_members)
+			return -ENOMEM;
+
+		priv->vlan_untagged =
+			devm_kcalloc(dev, VLAN_N_VID,
+				     sizeof(*priv->vlan_untagged), GFP_KERNEL);
+		if (!priv->vlan_untagged)
+			return -ENOMEM;
+	} else {
+		dev_warn(dev,
+			 "VLAN-tagged frames received on the CPU port are unsupported\n");
+	}
+
 	ds->ops = &soce_switch_ops;
-	ds->num_ports = hw_numports;
+	ds->num_ports = priv->features.num_ports;
+
+	/* Force VLAN uppers always through the callbacks, so cores without
+	 * Port VLAN feature can reject them instead of silently dropping
+	 * VLAN frames.
+	 */
+	ds->needs_standalone_vlan_filtering = true;
 	ret = devm_of_platform_populate(dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -294,7 +666,9 @@ static int soce_sw_probe(struct platform_device *pdev)
 
 	dev_info(dev,
 		 "probed soce switch core version %02x.%02x.%04x with %u ports\n",
-		 hw_version, hw_subversion, hw_revision, hw_numports);
+		 hw_version, hw_subversion, hw_revision,
+		 priv->features.num_ports);
+
 	return 0;
 }
 

-- 
2.39.5

