Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F83D9043
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940088; cv=none; b=LFMMkgdmlkbGY+1OO80sBk0qsMVo9dEpxK7hVGpCl4KC7Q7bk2hsfQ+fMTova7dMHeyl4GfseRget7NxaMMTDsLKhOdyZlNuC44jRSbQUHg63lre44ZkQycpeK7JKcICgYeHXYGOOJMV113/ouMfAmKPX3Jqfaj1O+SvTvocn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940088; c=relaxed/simple;
	bh=57YANBJl5PwefqB99euvaUE2FJXJt+Ws4eoGLiojHC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUSFQsTeYgIMrdwTl3sauchkEII9jDqwSMGSWlmj9gJmb/bNzxjd2Bxetod/zei0CpORmIBHgFv2BNXfr6oC2uj3DPy/kubXe0w+tzQnFDN0EUWyM6K2Oc2UkJgk9EswfqI43Amj/Th/k36I7hhMtFj9b7dRT/xN5X1JpzPdAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjvO3Xg5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjvO3Xg5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E12584E415AE;
	Wed,  9 Sep 2026 07:47:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B132060448;
	Wed,  9 Sep 2026 07:47:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C68B11C7AF4A;
	Wed,  9 Sep 2026 09:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940077; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=acg21s52zn73yG1o10b+uWJAS2RrIOADAmWZx0hmucI=;
	b=OjvO3Xg5ibz1EYKxHLLZezidmZ4YcXzrrdPLvtiAY799izbAH0i2D/nc3TtLiK3CmALkve
	+9hfcYt6acfWMmrtP9gINgdq8MF7/NpA1S8wPPtS+iQSCE+lNyBVswmkm4Yr23gYjV7GZP
	WEHdwLIBT89pgrdH7pUKOVHx5T0B8af0hAnUpaDgffMtbk3yQy0MglCOSI//SwqUX74sin
	qaNCz5TpAc1bJ3G//MgSdZVQu+npVS6fZkoJINuPAwq0YwpeBXGqzCGZu1/yAnoAM/fPDu
	Xk3k0r6RLTGx5PYgKy+Ai1Ms+8Zo713Yl71+yzkG4bI1N2SyfyLnPlSS+inBnQ==
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
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net 1/6] net: stmmac: selftests: Support running selftests on DSA conduits
Date: Wed,  9 Sep 2026 09:47:34 +0200
Message-ID: <20260909074740.1247762-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
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

Note that we may still receive incoming packets from the switch, but
these frames shouldn't interfere with the very specific frames used for
selftests, and stmmac selftests in general aren't safe against external
traffic interferences.

This was validated on a WPQ864 devkit for IPQ8064, that has the SoC
connected to a QCA8k switch.

The ARP offload's packet handler is left alone, this feature is just not
implemented in stmmac and due for removal.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 68 ++++++++++++++++---
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6372ec7c3f31..6503678b646e 100644
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
@@ -928,7 +976,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
+	stmmac_sft_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 	if (ret)
@@ -968,7 +1016,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 vlan_del:
 	vlan_vid_del(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
+	stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1022,7 +1070,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
+	stmmac_sft_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 	if (ret)
@@ -1062,7 +1110,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 vlan_del:
 	vlan_vid_del(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
+	stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1293,7 +1341,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
+	stmmac_sft_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
 	if (ret)
@@ -1320,7 +1368,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 vlan_del:
 	vlan_vid_del(priv->dev, htons(proto), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
+	stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
-- 
2.55.0

