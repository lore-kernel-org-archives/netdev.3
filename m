Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A351369D6D;
	Mon, 13 Jul 2026 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926707; cv=none; b=jWa0Y3Ptz8rW0UgbofWm7SD6QvvShpcVSiY9cIyPuxpj4IgzkL1KlZBvnItjudcUB37bYY5A8dh+yzisdFtYGTHeaY1fu5e2RNtjuyUolECgSmJDKQcZJ525N4OzMr6mio55viXrgqPjgfn7bdIqLS5IDHbCWWN0ZqBBzyYWUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926707; c=relaxed/simple;
	bh=w/SxAb4Naw1RupB4FjbSArAI84yzXTJXB+MRwVhcX9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqGEsx+XLVv8WApWILZvaZt5s8ta7TOER8eV7lmxsGf8sqNUFOTq6PEeLqxkD5nAAbv2fAg9i3CqLblgUfm+jf0FaUF7YTo/fCjBmn+wC6YMqr4HSFFjWr2M0g5OH1CIVaWiYBxgwHWEO1fLT82dC2fNxXGit8VFE9WyS+WPXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N4sfphw3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N4sfphw3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C8A0C2BB0F;
	Mon, 13 Jul 2026 07:11:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15CFB60341;
	Mon, 13 Jul 2026 07:11:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57F6711BD3A3A;
	Mon, 13 Jul 2026 09:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yoOtR2HWNljx7819Q66dKQeYgock7C9Bppqch7osah4=;
	b=N4sfphw3M7b6iy0ASKKklEML/iW8W0XYaPLC33+DJMRTtMmdCbZ0kORHaZNT6RA9j8McVH
	FO58VlDLXIr7MOIkTYu1h7kBraipK9PQ1xxqn1xZjONrAohTbH0utBnXiTTmrd2bnEJUMS
	MTG1TPGRqOUDPlumAeqKnBL225DY2BawMQTE6ww/nGVRajLbZzyhn3M7nvrQ2J7dTKT9g6
	jauC1QVuZCtyBNDUb9D2clcgIICyEkZmkoFLXYpTIXtM4A7MOghT9By4rnTki9uOAfKWmv
	4MGhkWbrocqtf6oDPd2A9bXGMUFOpEyqbF4fkXpJRj1LcOq9dx/XkqI/EcI8Mw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:25 +0200
Subject: [PATCH net-next v2 06/10] net: dsa: tag_ksz: move the KSZ8795 tag
 handling below ksz_xmit_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-6-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
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

