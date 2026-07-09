Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CA3DEAD1
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579375; cv=none; b=X67nrD56TWE8Vb7IsZe/EgE/yC/1+R3YJBxL2HRxYhZ3UbtARzFhpjhmBscD6NJM53EJqzz02bHNSuP5lIuyHg/c8jaXKHRvtB+Z5FocR/wQvx9p3uJdLenHSS1EaeZMBQPijDFSZEOI3RoCQGKYzHKW6/fpB4h8j2I+XTczBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579375; c=relaxed/simple;
	bh=w/SxAb4Naw1RupB4FjbSArAI84yzXTJXB+MRwVhcX9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCmqtufaCau835LuSdqKojI12xCyq56K/nocl1xuStOH6+30f2NbJArZsQPNbzN9QC5xaao/l9+XNd4roJL9vlAiKXTYgECuxqOjKv64WL7iMa1VT5iRzv9cL9OX4buRbGKo+4jP/URL2z/1tjOZqjU5/aj3EwhKkTxt7CPvqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mtERZrA/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mtERZrA/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15367C2F4C0;
	Thu,  9 Jul 2026 06:43:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CA7765FF03;
	Thu,  9 Jul 2026 06:42:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2D8511BC2144;
	Thu,  9 Jul 2026 08:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yoOtR2HWNljx7819Q66dKQeYgock7C9Bppqch7osah4=;
	b=mtERZrA/CDkryxpw5K3yd3QMwn8PJhfyAE3E0ZK4qmWCb2xjGzFzOKi17NrROxjUlpsGCc
	thbNhzuh/66mgEeKTDvwnrlx5pQt72vSrpNpNEUc20B0ml0BxqqwZEhCbeq9y7+cRWRsyf
	WITRzeDjIgfY6NPVT7og4lW7tDh18wQcNYsUdS0tGg+p6iles+0t5P/CAygLveEOIaB28t
	dLV6i7yMrBTz1/gwg1PJAlYayJFQNuuuY3z7ITHepB5pFX3krigx0eN5ZRsui99Ac9TltP
	MaBUubcNO+WwW0n/DAIYIqoV8SBXuPNPkQswyPEjNi+QsfENRBgDa/sC9jsmmg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:32 +0200
Subject: [PATCH net-next 06/10] net: dsa: tag_ksz: move the KSZ8795 tag
 handling below ksz_xmit_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-6-344f02fe739e@bootlin.com>
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
In-Reply-To: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Upcoming patch reduces code duplication between KSZ8795 and KSZ9893 by
introducing a common xmit() function. This rework needs the KSZ8795
handlers to be implemented below ksz_defer_xmit().

Do the move now to reduce the noise in next patch.
No functionnal change is intended in this patch.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 net/dsa/tag_ksz.c | 132 +++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 67fa89f102e0..f58ce0f0e9e4 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -103,72 +103,6 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 	return skb;
 }
 
-/*
- * For Ingress (Host -> KSZ8795), 1 byte is added before FCS.
- * ---------------------------------------------------------------------------
- * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag(1byte)|FCS(4bytes)
- * ---------------------------------------------------------------------------
- * tag : each bit represents port (eg, 0x01=port1, 0x02=port2, 0x10=port5)
- *
- * For Egress (KSZ8795 -> Host), 1 byte is added before FCS.
- * ---------------------------------------------------------------------------
- * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
- * ---------------------------------------------------------------------------
- * tag0 : zero-based value represents port
- *	  (eg, 0x0=port1, 0x2=port3, 0x3=port4)
- */
-
-#define KSZ8795_TAIL_TAG_EG_PORT_M	GENMASK(1, 0)
-#define KSZ8795_TAIL_TAG_OVERRIDE	BIT(6)
-#define KSZ8795_TAIL_TAG_LOOKUP		BIT(7)
-
-static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct ethhdr *hdr;
-	u8 *tag;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	/* Tag encoding */
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
-
-	*tag = dsa_xmit_port_mask(skb, dev);
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
-
-	return skb;
-}
-
-static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
-{
-	u8 *tag;
-
-	if (skb_linearize(skb)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-
-	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
-			      KSZ_EGRESS_TAG_LEN);
-}
-
-static const struct dsa_device_ops ksz8795_netdev_ops = {
-	.name	= KSZ8795_NAME,
-	.proto	= DSA_TAG_PROTO_KSZ8795,
-	.xmit	= ksz8795_xmit,
-	.rcv	= ksz8795_rcv,
-	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
-};
-
-DSA_TAG_DRIVER(ksz8795_netdev_ops);
-MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
-
 /*
  * For Ingress (Host -> KSZ9477), 2/6 bytes are added before FCS.
  * ---------------------------------------------------------------------------
@@ -353,6 +287,72 @@ static const struct dsa_device_ops ksz9477_netdev_ops = {
 DSA_TAG_DRIVER(ksz9477_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9477, KSZ9477_NAME);
 
+/*
+ * For Ingress (Host -> KSZ8795), 1 byte is added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag : each bit represents port (eg, 0x01=port1, 0x02=port2, 0x10=port5)
+ *
+ * For Egress (KSZ8795 -> Host), 1 byte is added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag0 : zero-based value represents port
+ *	  (eg, 0x0=port1, 0x2=port3, 0x3=port4)
+ */
+
+#define KSZ8795_TAIL_TAG_EG_PORT_M	GENMASK(1, 0)
+#define KSZ8795_TAIL_TAG_OVERRIDE	BIT(6)
+#define KSZ8795_TAIL_TAG_LOOKUP		BIT(7)
+
+static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ethhdr *hdr;
+	u8 *tag;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Tag encoding */
+	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
+	hdr = skb_eth_hdr(skb);
+
+	*tag = dsa_xmit_port_mask(skb, dev);
+	if (is_link_local_ether_addr(hdr->h_dest))
+		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
+
+	return skb;
+}
+
+static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *tag;
+
+	if (skb_linearize(skb)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+
+	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
+			      KSZ_EGRESS_TAG_LEN);
+}
+
+static const struct dsa_device_ops ksz8795_netdev_ops = {
+	.name	= KSZ8795_NAME,
+	.proto	= DSA_TAG_PROTO_KSZ8795,
+	.xmit	= ksz8795_xmit,
+	.rcv	= ksz8795_rcv,
+	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(ksz8795_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
+
 #define KSZ9893_TAIL_TAG_PRIO		GENMASK(4, 3)
 #define KSZ9893_TAIL_TAG_OVERRIDE	BIT(5)
 #define KSZ9893_TAIL_TAG_LOOKUP		BIT(6)

-- 
2.54.0

