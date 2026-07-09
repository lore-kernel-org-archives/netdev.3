Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC73E074E
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579383; cv=none; b=DEIdcEZb/LD/0cyjx4vC7dsreG8MAuik+whdocu4HAKF8YA9hTuj0Y7W5kwyQVqIEwuewtDc9r5Sxy76n/SNa+/tsSiyi/xVBIfh0oesTwUZCnhjFLEqHGjmP16/htXzsOWH7Mi6dd7oTXvd2j6jKjxbr2qDtFfT7i4HE+ILFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579383; c=relaxed/simple;
	bh=KcRnAacbUb1U1qpPj32Xg0y3dcBts07hc7eNi6V5GcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVXBbCuBMwNjpWBZ7jhPcFCc+J/GibzSq1vpnF6Q8JEzOC+r17G+ztpVFnB5Js/UlKYiiURBSrC+4iZuZXmcvcRRcNWFvUIEXKTkMUltluY0tfD8SSLQpHyG+oD4WIXlgxh3ykgnnXE/xg30fEdWtJPsTGKPzKdsu5xlc8450fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vQKwea77; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vQKwea77"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4819A1A0F03;
	Thu,  9 Jul 2026 06:42:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C9E55FF03;
	Thu,  9 Jul 2026 06:42:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0622F11BC207F;
	Thu,  9 Jul 2026 08:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579368; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DB/AuADM3cKTTPWyDwbhPOvmCpqeymWC83FnlPAt0eM=;
	b=vQKwea77njXb/b9vUxguCPyHXWdLmugyb94Lj6AwlNDmGpk8iTuLWYB1+WZsNzwj4/NXjG
	xO8AS1hWTFcK/illIbpm6Ks2DbNwS3H0uHiKbHl5+BJ6xbwKw4F7+oP9U24/BGf1BOE9mc
	1gU3ncy71ZggPnSQrgy6TeKlLfyzKJUW6IhSdTlmGLESUoO3fJvgGIyQF1QR4SdAk+4lrM
	TryATep4jTgTJHocfJo1z58tY0YTkbgBum5G+LZ/vvAmXEjmEtlI6B/bV/diCDgX0szeTr
	UiLx2GYdiGsOcSrbUOQmAhUrj5LRFuE3OSHweM1QjBVbNNBzNg8VK15Hw94LPA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:33 +0200
Subject: [PATCH net-next 07/10] net: dsa: tag_ksz: share code for KSZ8795
 and KSZ9893 xmit operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-7-344f02fe739e@bootlin.com>
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

KSZ8795 and KSZ9893 have very similar tag handling in the xmit path,
leading to code duplication.

There are only two differences between the two ksz*_xmit():
- the KSZ8795 doesn't handle priorities between frames
- ksz8795_xmit() directly returns the SKB instead of calling
ksz_defer_xmit(). Yet, ksz_defer_xmit() also returns directly the SKB
if no clone is present inside the SKB. Clones are only created by the KSZ
driver when the PTP feature is enabled. Since KSZ8795 doesn't support
PTP, returning the SKB directly or ksz_defer_xmit() is the same.

The upcoming support for the KSZ8463 also requires a similar xmit().

Gather the common code from ksz8795_xmit() and ksz9893_xmit() into a new
ksz_common_xmit() function that takes three input arguments:
- do_tstamp to tell whether ksz_xmit_timestamp() should be called
- prio to give the priority tag (if any)
- override_mask to give the location of the override bit (if any)

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 net/dsa/tag_ksz.c | 73 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index f58ce0f0e9e4..f8b40437c5fa 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -218,6 +218,37 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
 	return NULL;
 }
 
+static struct sk_buff *ksz_common_xmit(struct sk_buff *skb,
+				       struct net_device *dev,
+				       bool do_tstamp,
+				       u8 prio,
+				       u8 override_mask)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct ethhdr *hdr;
+	u8 *tag;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Tag encoding */
+	if (do_tstamp)
+		ksz_xmit_timestamp(dp, skb);
+
+	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
+	hdr = skb_eth_hdr(skb);
+
+	*tag = dsa_xmit_port_mask(skb, dev);
+	*tag |= prio;
+
+	if (is_link_local_ether_addr(hdr->h_dest))
+		*tag |= override_mask;
+
+	return ksz_defer_xmit(dp, skb);
+}
+
 static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -308,23 +339,7 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9477, KSZ9477_NAME);
 
 static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 {
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
+	return ksz_common_xmit(skb, dev, false, 0, KSZ8795_TAIL_TAG_OVERRIDE);
 }
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
@@ -362,28 +377,10 @@ static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
 {
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_user_to_port(dev);
-	struct ethhdr *hdr;
-	u8 *tag;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	/* Tag encoding */
-	ksz_xmit_timestamp(dp, skb);
-
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
-
-	*tag = dsa_xmit_port_mask(skb, dev);
-	*tag |= FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio);
 
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ9893_TAIL_TAG_OVERRIDE;
-
-	return ksz_defer_xmit(dp, skb);
+	return ksz_common_xmit(skb, dev, true,
+			       FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio),
+			       KSZ9893_TAIL_TAG_OVERRIDE);
 }
 
 static const struct dsa_device_ops ksz9893_netdev_ops = {

-- 
2.54.0

