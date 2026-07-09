Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A03DD86A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579383; cv=none; b=Tcg9OFdTneSczUzUuPl64o39ThqR5zR9SUOXINgQfvLstLJVyCoucVVhC8C1ZSgKWze/7kOSMi3BW6cYaJ5elSlCDa1gs7tiby/CUnhKiE7KgzohX3Q4lcxEkYwO4mE5o+edxqqC9An0oG8iGtoxPEE6bTRS4naZzKu2goqePQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579383; c=relaxed/simple;
	bh=xQHKW1F2NG38KYANKnYmQ5plJV2+SH99XIMZP7geEjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fL6/Ck9SM6HiBz/X09vCzrY+23wBx1IjTcYCjHt9jj+6O/lzab2PafAhY+eE6GhJd2tO97MFgujj3YT4U1SXNKDVkWIBFOFWM7SY3WW6wbo3Ws4CkNgzKz1MoNMekl64XWUYwXMsyKQyjpVmmgGKoR31UDYOUOMN06TDqfKxsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCrBhuHC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCrBhuHC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56CA51A0EFF;
	Thu,  9 Jul 2026 06:42:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A5825FF03;
	Thu,  9 Jul 2026 06:42:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3517F11BC2147;
	Thu,  9 Jul 2026 08:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gAOwbOJ3Onfl15ts9OOIsYnSMYiHF9ztFhgg9MrccOc=;
	b=XCrBhuHCPz9tXUX9G652dCHW5djMYvTXjFEQDcFNZkevKrQGcKXrgsQueerNYxJyecn0L2
	VapXIIfgGexVpniygB8R7Q4O2TmLuC8ihx6I6faEOPJ8aLONQ8xo4wXeqqNAiie3bFMgmW
	Myy/3s3+o4qCNdxKRwSI9qQ8Q8ihoCegf/C7S+Qxd09fmBQuqVpVs4BndhXwKNHlOlm2Mu
	yLmbmUHV04yMSRbFv5lx6jclDI7v1r583PUKL19TF8cnTA8Uqevlz2S5zYHNMZb5Zxg7vs
	yS86mUAJDr5NuMs5t8zcYjgKfm/4jnSe7igzZBfO39ophmy1M08d1+1ItQHSbw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:34 +0200
Subject: [PATCH net-next 08/10] net: dsa: microchip: add KSZ8463 tail tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-8-344f02fe739e@bootlin.com>
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

KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
use the tail tag to convey timestamps to the host as KSZ9893 does. It
uses the reserved fields in the PTP header instead.

Add a KSZ8463-specific DSA_TAG driver to handle KSZ8463 timestamps.
There is no information in the tail tag to distinguish PTP packets from
others so use the ptp_classify_raw() helper to find the PTP packets and
extract the timestamp from their PTP headers.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c |  4 +--
 include/net/dsa.h                |  2 ++
 net/dsa/tag_ksz.c                | 62 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 5e5bfc5cae2d..ac9e8ef5774a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2966,7 +2966,7 @@ static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_KSZ9893;
+	return DSA_TAG_PROTO_KSZ8463;
 }
 
 static int ksz8463_connect_tag_protocol(struct dsa_switch *ds,
@@ -2974,7 +2974,7 @@ static int ksz8463_connect_tag_protocol(struct dsa_switch *ds,
 {
 	struct ksz_tagger_data *tagger_data;
 
-	if (proto != DSA_TAG_PROTO_KSZ9893)
+	if (proto != DSA_TAG_PROTO_KSZ8463)
 		return -EPROTONOSUPPORT;
 
 	tagger_data = ksz_tagger_data(ds);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc10..6f7f5c17b532 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -59,6 +59,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
+#define DSA_TAG_PROTO_KSZ8463_VALUE		34
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -95,6 +96,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
+	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index f8b40437c5fa..633511679cad 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -12,6 +12,7 @@
 
 #include "tag.h"
 
+#define KSZ8463_NAME "ksz8463"
 #define KSZ8795_NAME "ksz8795"
 #define KSZ9477_NAME "ksz9477"
 #define KSZ9893_NAME "ksz9893"
@@ -396,6 +397,66 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
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
+	ktime_t ts;
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
+		ts = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
+		KSZ_SKB_CB(skb)->tstamp = ts;
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
@@ -468,6 +529,7 @@ DSA_TAG_DRIVER(lan937x_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN937X, LAN937X_NAME);
 
 static struct dsa_tag_driver *dsa_tag_driver_array[] = {
+	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz8795_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),

-- 
2.54.0

