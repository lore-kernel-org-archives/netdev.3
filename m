Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46935A3B2
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124132; cv=none; b=HuI+1XNyI/Bqt9y5E0qk9ilA265h7Mz8ijNTKk5zlYycZQDud0fnTZvIp/I7z7QFQAsuRHL9kXaUBcRwomWgoiT0XP8DxEyGeY0cvtmLny5Ii1+Qus6fkfmAaS8pfUp7cXgBgh6sbhU7fttR3IHOkvrsYCJ2UZd3unRNI6eBNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124132; c=relaxed/simple;
	bh=dEchD225Qzgvi9oN9QQCvJY1h2OUeaXj835WhDSNg4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxs7EHOrBM4L5kEiPyRg7c1L77OibUKYyDtBtItCMxmDsjA5yUrflZYuwODCOaI8S2pJ6ACSx+JDrcjEUU7yM5mUkYCnMuElBW5R8Arys8uSRQJVPlMYS9Tp0gGrgJ8FWGpVKJ+Q63yD3+L2BXwCezPToc7bpc6c210PVgj91mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aY4Dt9I3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aY4Dt9I3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C4E1A1A1609;
	Thu, 26 Feb 2026 16:42:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 999965FDE9;
	Thu, 26 Feb 2026 16:42:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B57DB103693FE;
	Thu, 26 Feb 2026 17:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772124128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LIWPK5v4kauktcENJzQ+X9YyyIohLYTZEqoF2EsTY+c=;
	b=aY4Dt9I3d2tiKk9YzF+v/1igs16R8tkgeeepV6b4NhXlnzL3nACoVYsve3x2V0P+T+ZPBt
	ge9Ay9oDjgmYUIPmWJpYHSzufd1PHBbH4/IHy7Urm8nCnC/ndK74pbwInyN4EhZ8xOBVW2
	V5WM8laj6SaubJJgVYEAE6KeK1IfBx0jsrDKD59O4pJ3zMXL12amOM0lL5dNvBY+CjJWkF
	giRZj0v49ErsoWSKkEnDCscATRQWThDEmpbSdmdFTT/IaDLtqLGcUkxWQYtC9xzuqchgh1
	CDr/5JMjs4A1jNWfFPuY11+NXvAzQy+7WUQ0zhFO+qmwxeTXdooiQ4bWlwUvRg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 26 Feb 2026 17:41:53 +0100
Subject: [PATCH net-next v5 6/9] net: dsa: microchip: Add KSZ8463 tail tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ksz8463-ptp-v5-6-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
In-Reply-To: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
use the tail tag to convey timestamps to the host as KSZ9893 does. It
uses the reserved fields in the PTP header instead.

Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
There is no information in the tail tag to distinguish PTP packets from
others so use the ptp_classify_raw() helper to find the PTP packets and
extract the timestamp from their PTP headers.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c |  5 ++-
 include/net/dsa.h                      |  2 ++
 net/dsa/tag_ksz.c                      | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7deeb0b86793bab4818a7e70bc468346ec8f22e3..4b36a3b88f49363273e72d19f9625e542bff1b06 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3580,8 +3580,10 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
+	if (dev->chip_id == KSZ8463_CHIP_ID)
+		proto = DSA_TAG_PROTO_KSZ8463;
+
 	if (dev->chip_id == KSZ88X3_CHIP_ID ||
-	    dev->chip_id == KSZ8463_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3609,6 +3611,7 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 	switch (proto) {
 	case DSA_TAG_PROTO_KSZ8795:
 		return 0;
+	case DSA_TAG_PROTO_KSZ8463:
 	case DSA_TAG_PROTO_KSZ9893:
 	case DSA_TAG_PROTO_KSZ9477:
 	case DSA_TAG_PROTO_LAN937X:
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc29682e07a70362bae8d8fa6233b0..e854cde8b400c2f47e5c474460e914e1abbf8984 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_KSZ8463_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 6ec9bcb324a953d988ef665a177566159e27027f..310390ce08c207a1d872de8ffc4ce1f301f0f1c7 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -12,6 +12,7 @@
 
 #include "tag.h"
 
+#define KSZ8463_NAME "ksz8463"
 #define KSZ8795_NAME "ksz8795"
 #define KSZ9477_NAME "ksz9477"
 #define KSZ9893_NAME "ksz9893"
@@ -382,6 +383,66 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
 DSA_TAG_DRIVER(ksz9893_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
 
+#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
+#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
+
+static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
+
+	return ksz_common_xmit(skb, dev, false,
+			       FIELD_PREP(KSZ8463_TAIL_TAG_PRIO, prio),
+			       0);
+}
+
+static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	struct ptp_header *ptp_hdr;
+	unsigned int ptp_class;
+	unsigned int port;
+	ktime_t tstamp;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
+
+	__skb_push(skb, ETH_HLEN);
+	ptp_class = ptp_classify_raw(skb);
+	__skb_pull(skb, ETH_HLEN);
+	if (ptp_class == PTP_CLASS_NONE)
+		goto common_rcv;
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (ptp_hdr) {
+		tstamp = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
+		KSZ_SKB_CB(skb)->tstamp = tstamp;
+		ptp_hdr->reserved2 = 0;
+	}
+
+common_rcv:
+	return ksz_common_rcv(skb, dev, port, len);
+}
+
+static const struct dsa_device_ops ksz8463_netdev_ops = {
+	.name	= KSZ8463_NAME,
+	.proto	= DSA_TAG_PROTO_KSZ8463,
+	.xmit	= ksz8463_xmit,
+	.rcv	= ksz8463_rcv,
+	.connect = ksz_connect,
+	.disconnect = ksz_disconnect,
+	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(ksz8463_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8463, KSZ8463_NAME);
+
 /* For xmit, 2/6 bytes are added before FCS.
  * ---------------------------------------------------------------------------
  * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|ts(4bytes)|tag0(1byte)|tag1(1byte)|
@@ -452,6 +513,7 @@ DSA_TAG_DRIVER(lan937x_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN937X, LAN937X_NAME);
 
 static struct dsa_tag_driver *dsa_tag_driver_array[] = {
+	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz8795_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),

-- 
2.53.0

