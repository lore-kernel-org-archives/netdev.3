Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FF3FBEAF;
	Mon, 27 Jul 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147670; cv=none; b=pQT9fathFemE7Ay4Y2x1e5/fBvQbrWlQFDaE3UcdnKp8SVqZJOggLWZSxQEEl9tVvPUU6uP6LEtbUYyv+oM3HrMGYXEFMYqzHTheLB90FeujBCwXjLRT6vYp2aPgGdQs9Y7hfeKAjQa5eQLL6CBlMrHqHx8GJ30k28RPtWMyP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147670; c=relaxed/simple;
	bh=u1wfUO8P2ZlixceoGoXXjhAZj/jPz1cTFc2a+aFelvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZH5RB9Gtb+/3K0mKvY+GJ7TeeVZzOFAm15rRLsbeBIyc3pnSilflan4hjDk8DITWUKWwR1V6379vtwUsrM0u2FChssvO6TYIinfIwBV1kELO752ZY94oz7Mg3xt1S/AkCS1XM8N5CDRYnNarfCvMk0YjhYhaQohiKYla1Vbz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n3gb9oU5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n3gb9oU5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CFCA31A128C;
	Mon, 27 Jul 2026 10:21:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B98B601BE;
	Mon, 27 Jul 2026 10:21:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3141311C131B5;
	Mon, 27 Jul 2026 12:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785147665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6LNXqBsn5PlT8qaz3Q1ne3dfPpge90upKA0ukcSSJwE=;
	b=n3gb9oU5VoMHntROhgrkFQxL2IwQQ35lGE3DSK6LpXhw6YBYTHoY9mkBamZRVRFIcEoxFN
	TS0SAAU4rvotEMpE5P+Vxg4fhmCfAg/Mvz0fNscw9n6XPGZStIu2CwRfovW3IX7vBo1IKd
	U7DZgLpHwPrJ4e7gp6m0R++O2e7Lotf9vb5nIW2FaCP2C6ZeGI8whiQwrptLRuz4VGZKVX
	FYi5+emyGm+MptKypapiOs7VnlDgcaVAmD2rLJwFCBq+NwqPcqB07gH11U8nQi068Wi2Bm
	FT79cxAVpaT3HBFMe1mqOIgZmEEP+cRTtR9sXbFNU4im8Kw4EfTB0JR/F7iTWQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 27 Jul 2026 12:20:48 +0200
Subject: [PATCH net-next v3 06/10] net: dsa: tag_ksz: move the KSZ8795 tag
 handling below ksz_xmit_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-ksz-new-ptp-v3-6-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
In-Reply-To: <20260727-ksz-new-ptp-v3-0-caba39e680e3@bootlin.com>
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
2.55.0

