Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F044C664
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929649; cv=none; b=ZZVPJNVvbMsEvJH5xW93ielVcd/F16HYPSs0b0tHHj5z/JIhFXGQEgAUoZddDNlitIdicrfljeLZ+vHSoYTD94oBTrLubZRAF10OkiInYi0BDdfVURqJjvCBihW3vvZ41Tx4PScUUdCegbbrryqhRuWvHoryyKGgxuCq7LOHA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929649; c=relaxed/simple;
	bh=a1xk1jCAZJg39J3FGNdHcwlT0+iBsPOHSPEFK1O5dO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBCtSzFNArTOBaw7l0ggDuWfLgQ0bWxFflpSc/PZ1Gd7Vz5q1DmGiqCt5c+tnuwC4pWb4gcgbRGtsD3Rh1IYGw/yG2Xq/BhyjCC/urAonfrfiKgmgIUEpTQS+5XjB4GlkALUEn52sP0q5yLlOzxR+bJAwoxVHYyaON3kudszocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBdEpRDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBdEpRDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650D1F00893;
	Fri,  2 Oct 2026 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929638;
	bh=bSqrT5/SOFTtZ7VajUZrFIcKP4Ew/yRe9QpDQR+AoG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBdEpRDOW8oBEUPaFSg5IXBbx8XgeXHu2BFrF9oi/pRjgukoRTUYuuYTgvvEGRs45
	 nTFhmYSNQqobL7dJb1QTuPYW3kL/O8MISTzqXtxaWF4Vv0+4BKKUapKJd2cXUfDnya
	 ADDB4agXkqE2OTUnkyv93ha0RbuD0ynxgUPozVcLmj8h/WsqryQb1UqgL2OV1SPTHt
	 5Yx1dLI+oYCMkC0BzjZNSzy26E0l6n9B2It5iMdJtyz9r8xu/I2hcLoD3oengVmq3w
	 fZ040jGxY4AoW9ff1x6WVeZRD2R0hI41uHe0aorKRXrn4RL79hiK7vn7oUYxoabaOj
	 9RjMsx+r/K4Jw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v2 net 1/2] ieee802154: 6lowpan: look up the neighbour short address in lowpan_xmit()
Date: Fri,  2 Oct 2026 08:27:11 +0000
Message-ID: <20261002082712.3535213-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261002082712.3535213-1-edumazet@kernel.org>
References: <20261002082712.3535213-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lowpan_header_create() uses ipv6_hdr(skb)->daddr to find the
neighbour, and to use its 802.15.4 short address if it has one.

The IPv6 header is not there yet when lowpan_header_create() is
called for AF_PACKET SOCK_DGRAM sockets: packet_snd() copies the
payload after dev_hard_header(), and tpacket_fill_skb() attaches it
as page fragments after dev_hard_header(). The lookup then reads
uninitialized memory, possibly past the end of the linear data.

Move the lookup to lowpan_header(), called from lowpan_xmit().

lowpan_xmit() now makes sure the IPv6 header is in the linear part
of the skb.

Fixes: eab560e58208 ("6lowpan: add support for 802.15.4 short addr handling")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/tx.c | 62 +++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 4df76ff50699ede5c187c9cca6f0cc10b19d2123..ab28b6f912c000f5cf141982b6d1b25e7d2e48f6 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -36,9 +36,6 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 {
 	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
 	struct lowpan_addr_info *info = lowpan_skb_priv(skb);
-	struct lowpan_802154_neigh *llneigh = NULL;
-	const struct ipv6hdr *hdr = ipv6_hdr(skb);
-	struct neighbour *n;
 
 	if (!daddr)
 		return -EINVAL;
@@ -57,28 +54,12 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 		info->daddr.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 		info->daddr.mode = IEEE802154_ADDR_SHORT;
 	} else {
-		__le16 short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
-
-		n = neigh_lookup(&nd_tbl, &hdr->daddr, ldev);
-		if (n) {
-			llneigh = lowpan_802154_neigh(neighbour_priv(n));
-			read_lock_bh(&n->lock);
-			short_addr = llneigh->short_addr;
-			read_unlock_bh(&n->lock);
-		}
-
-		if (llneigh &&
-		    lowpan_802154_is_valid_src_short_addr(short_addr)) {
-			info->daddr.short_addr = short_addr;
-			info->daddr.mode = IEEE802154_ADDR_SHORT;
-		} else {
-			info->daddr.mode = IEEE802154_ADDR_LONG;
-			ieee802154_be64_to_le64(&info->daddr.extended_addr,
-						daddr);
-		}
-
-		if (n)
-			neigh_release(n);
+		/* The IPv6 header might not be there yet (AF_PACKET).
+		 * lowpan_header() will use the neighbour short address,
+		 * if there is one.
+		 */
+		info->daddr.mode = IEEE802154_ADDR_LONG;
+		ieee802154_be64_to_le64(&info->daddr.extended_addr, daddr);
 	}
 
 	if (!saddr) {
@@ -221,6 +202,31 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 	return rc;
 }
 
+/* Use the short address of the IPv6 destination, if the neighbour has one. */
+static void lowpan_neigh_short_addr(const struct sk_buff *skb,
+				    struct net_device *ldev,
+				    struct ieee802154_addr *daddr)
+{
+	struct lowpan_802154_neigh *llneigh;
+	struct neighbour *n;
+	__le16 short_addr;
+
+	n = neigh_lookup(&nd_tbl, &ipv6_hdr(skb)->daddr, ldev);
+	if (!n)
+		return;
+
+	llneigh = lowpan_802154_neigh(neighbour_priv(n));
+	read_lock_bh(&n->lock);
+	short_addr = llneigh->short_addr;
+	read_unlock_bh(&n->lock);
+	neigh_release(n);
+
+	if (lowpan_802154_is_valid_src_short_addr(short_addr)) {
+		daddr->short_addr = short_addr;
+		daddr->mode = IEEE802154_ADDR_SHORT;
+	}
+}
+
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 			 u16 *dgram_size, u16 *dgram_offset)
 {
@@ -230,6 +236,9 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 
 	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
 
+	if (info.daddr.mode == IEEE802154_ADDR_LONG)
+		lowpan_neigh_short_addr(skb, ldev, &info.daddr);
+
 	*dgram_size = skb->len;
 	lowpan_header_compress(skb, ldev, &info.daddr, &info.saddr);
 	/* dgram_offset = (saved bytes after compression) + lowpan header len */
@@ -255,7 +264,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 
 	pr_debug("package xmit\n");
 
-	if (skb->protocol != htons(ETH_P_IPV6)) {
+	if (skb->protocol != htons(ETH_P_IPV6) ||
+	    !pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

