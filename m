Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D44A3F36
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682047; cv=none; b=CUpKmeM0kbllQqlvCk6jNrTKAdH2ie+r9p7EZ6fErnSl8xN7chhdtHy0SW53XPIj/QJX0n10Q9sRbbATqBMei16Lz8iqfkliEAHFCIawS5vxsIhAZ+ovcZU5MWD99btErjAMVMOfZAoQ9zM8AtpwYz9lMDSmMmt9pcGoyWIr4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682047; c=relaxed/simple;
	bh=stgNm0O4ytBVO2Qf5KmpkH2AAV6qIzrLws8hJ0x7w+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7691tx4kZVmyToghqL3VQeMdBgJwiBSlX9Ue2vdWYD8EXuYyw3vM8wfNKobWw1fNdR/42VDu5qCBOhBSA23eypTiH2oSXwoVDc5KY8VEN2PfFnLLQodhMSxwaFV8TJkbWju+ZS/wAgVfhtiOXuCq8zc2Z52e4iNrEwZxUuw6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iDG/h88J; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iDG/h88J"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CEFFCC58469;
	Thu, 17 Sep 2026 21:54:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 489A05FF03;
	Thu, 17 Sep 2026 21:54:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 143A311C7B091;
	Thu, 17 Sep 2026 23:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789682039; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uIhy92caf8rb2pE2pQEh/B0RxW7n2vIPP1k1H/MMpmk=;
	b=iDG/h88JAV3wULAnjI9JiqDAeDdMx02cHP51jyts9M61+lxL/omSBedspqDrxEXrCIZg1u
	gehfCa9A7vAGkL+YP3uxtFEqfUQcCh/EE+ErjLrr5r2IfIWgqdGwv2venGwRp3xkiaehGg
	u/xrErN6DML9qAM8jwvfc0Wh/yNyACw4mRbMvH7KwJu5DhP2+ml5lM84x9j6NOTsMbL3Wd
	bOBHM0BUy7yYOxIZFS7JQDpnldU/EMF5neN+jQJdEz4rrp9wi0vtMvpuM08olKjoc19em7
	oA7WsuQ45cIBCgSKyp9xzWRd3uPlsByUOJXFJPltrkCX8qGK0hbMGokgv/C90w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net v4 1/7] net: stmmac: selftests: Support running selftests on DSA conduits
Date: Thu, 17 Sep 2026 23:53:32 +0200
Message-ID: <20260917215339.2022523-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Most stmmac selftests rely on dev_add_pack() to add custom handlers,
that validate the packets sent to ourselves through MAC loopback.

However, when the stmmac-driven interface is a DSA CPU conduit, all
frames that are received have ETH_P_XDSA as a protocol, even though they
don't actually contain any tag as they come from the loopback and not
the switch.

This will prevent any incoming packet to match our packet handlers.

Let's register a ETH_P_ALL packet handler when we detect that we're a
DSA conduit, and use a proxy packet handler to filter the h_proto.

As this allows external frames to be received through our .func(), the
packet handler is added after the dev->addr field is populated in our
selftest attributes.

Note that we may still receive incoming packets from the switch, but
these frames shouldn't interfere with the very specific frames used for
selftests, and stmmac selftests in general aren't safe against external
traffic interferences.

This was validated on a WPQ864 devkit for IPQ8064, that has the SoC
connected to a QCA8k switch.

The ARP offload's packet handler is left alone, this feature is just not
implemented in stmmac and due for removal.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 89 +++++++++++++++----
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6372ec7c3f31..614b5995dec5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/ip.h>
 #include <linux/udp.h>
+#include <net/dsa.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tcp.h>
@@ -237,6 +238,9 @@ struct stmmac_test_priv {
 	struct stmmac_packet_attrs *packet;
 	struct packet_type pt;
 	struct completion comp;
+	__be16 packet_type;
+	int (*func)(struct sk_buff *skb, struct net_device *ndev,
+		    struct packet_type *pt, struct net_device *orig_ndev);
 	int double_vlan;
 	int vlan_id;
 	int ok;
@@ -316,6 +320,50 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
 	return 0;
 }
 
+static int stmmac_sft_filter(struct sk_buff *skb, struct net_device *ndev,
+			     struct packet_type *pt,
+			     struct net_device *orig_ndev)
+{
+	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+	struct ethhdr *hdr = eth_hdr(skb);
+	int ret = 0;
+
+	if (hdr->h_proto == tpriv->packet_type) {
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (nskb)
+			ret = tpriv->func(nskb, ndev, pt, orig_ndev);
+	}
+
+	kfree_skb(skb);
+	return ret;
+}
+
+static void stmmac_sft_add_pack(struct packet_type *pt)
+{
+	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+
+	if (netdev_uses_dsa(tpriv->pt.dev)) {
+		tpriv->packet_type = tpriv->pt.type;
+		tpriv->func = tpriv->pt.func;
+
+		/* DSA conduit will report ETH_P_XDSA, so our packet handler
+		 * won't match. Let's register a ETH_P_ALL match and filter
+		 * manually in stmmac_sft_filter.
+		 */
+		tpriv->pt.type = htons(ETH_P_ALL);
+		tpriv->pt.func = stmmac_sft_filter;
+		tpriv->pt.ignore_outgoing = true;
+	}
+
+	dev_add_pack(pt);
+}
+
+static void stmmac_sft_remove_pack(struct packet_type *pt)
+{
+	dev_remove_pack(pt);
+}
+
 static int __stmmac_test_loopback(struct stmmac_priv *priv,
 				  struct stmmac_packet_attrs *attr)
 {
@@ -337,7 +385,7 @@ static int __stmmac_test_loopback(struct stmmac_priv *priv,
 	tpriv->packet = attr;
 
 	if (!attr->dont_wait)
-		dev_add_pack(&tpriv->pt);
+		stmmac_sft_add_pack(&tpriv->pt);
 
 	skb = stmmac_test_get_udp_skb(priv, attr);
 	if (!skb) {
@@ -360,7 +408,7 @@ static int __stmmac_test_loopback(struct stmmac_priv *priv,
 
 cleanup:
 	if (!attr->dont_wait)
-		dev_remove_pack(&tpriv->pt);
+		stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -767,7 +815,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 	tpriv->pt.func = stmmac_test_flowctrl_validate;
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
-	dev_add_pack(&tpriv->pt);
+	stmmac_sft_add_pack(&tpriv->pt);
 
 	/* Compute minimum number of packets to make FIFO full */
 	pkt_count = rx_fifo_size;
@@ -823,7 +871,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 cleanup:
 	dev_mc_del(priv->dev, paddr);
 	dev_set_promiscuity(priv->dev, -1);
-	dev_remove_pack(&tpriv->pt);
+	stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -928,18 +976,20 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 	if (ret)
 		goto cleanup;
 
+	attr.vlan = 1;
+	attr.dst = priv->dev->dev_addr;
+	attr.sport = 9;
+	attr.dport = 9;
+
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	for (i = 0; i < 4; i++) {
-		attr.vlan = 1;
 		attr.vlan_id_out = tpriv->vlan_id + i;
-		attr.dst = priv->dev->dev_addr;
-		attr.sport = 9;
-		attr.dport = 9;
 
 		skb = stmmac_test_get_udp_skb(priv, &attr);
 		if (!skb) {
@@ -966,9 +1016,9 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	}
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1022,18 +1072,20 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 	if (ret)
 		goto cleanup;
 
+	attr.vlan = 2;
+	attr.dst = priv->dev->dev_addr;
+	attr.sport = 9;
+	attr.dport = 9;
+
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	for (i = 0; i < 4; i++) {
-		attr.vlan = 2;
 		attr.vlan_id_out = tpriv->vlan_id + i;
-		attr.dst = priv->dev->dev_addr;
-		attr.sport = 9;
-		attr.dport = 9;
 
 		skb = stmmac_test_get_udp_skb(priv, &attr);
 		if (!skb) {
@@ -1060,9 +1112,9 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	}
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1293,7 +1345,6 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
 	if (ret)
@@ -1301,6 +1352,8 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 
 	attr.dst = priv->dev->dev_addr;
 
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	skb = stmmac_test_get_udp_skb(priv, &attr);
 	if (!skb) {
 		ret = -ENOMEM;
@@ -1318,9 +1371,9 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	ret = tpriv->ok ? 0 : -ETIMEDOUT;
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(proto), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
-- 
2.55.0

