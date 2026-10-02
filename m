Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831D3E1686
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967315; cv=none; b=EwoN5VnA3vRJQethgrvZvAJu15LdwgZRwjfzks1eWJutASff1pafbACPMcT3V9k79BAcrPGsRIIQCFgyiy6xMFnxTxSMDQwqxyi0HTO/WTw1uTUObUUAUHCZxq3lNlB2xikrUHBX7EnIYonB5LE007p5d2mxf2PquTPVNBnKnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967315; c=relaxed/simple;
	bh=mPs5qxkCHg3wiz/pK9msxPHT0NqxNwXOAvTH/bRnWiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arWBnEDpvL6Q7cZgWkTE/lNQtg3F2PhpMaeCIvhpJC0Y6JkpDaduuz9b4t7joJEU5HSI9Fmw0TDTPj6fs0AzvqPAm+IauHG/5MGRkQ9MQwyXKZU1J5NLgnRI1W0aVtnFc3bsFpIPO2FH7DnAUTTT+VF75m6jkdbGVQkYKnZodAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3mtGJVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3mtGJVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278A41F000FF;
	Fri,  2 Oct 2026 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967313;
	bh=F4vxVglJlKjH+MXBSBhFsnNx99sDGCECEmQFJK1/XwY=;
	h=From:To:Cc:Subject:Date;
	b=l3mtGJVYgT6XvlVEemtx6GVj7U1OCZqpkmwxCYhhbVijABNxsA7q5e3Rd0C0nUeAQ
	 0M5tvLPQMAX84V8SQm1bDUQ+5H3rBZ2EEJKh1IE8GQujY9tS2EnXH9REz3Lecw7LEI
	 j8UOUFwCKjZ8dtZHOGYjskHeh/vh//kBBTHqLej88yr+23n1FD8Y1mtHlLPK+GjMsU
	 WKVr2ZtxHvn2rqKo6JUHKz4jddWjJ8SW52+h3i7sGKeMjDQDo4AJZPLdUOIaj1qbBz
	 HBs5DYfxjTAu+ewg9cAoOMkcU6Ge4l/MKpTr9iqwZs9z5ZXUPN/iioJSv9HTvneOA0
	 2VQ3X7SaboEOw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next] net: remove IPX raw 802.3 detection from eth_type_trans()
Date: Fri,  2 Oct 2026 20:55:09 +0200
Message-ID: <20261002185509.17226-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eth_type_trans() and vlan_set_encap_proto() still carry a "magic hack"
to spot Novell raw 802.3 frames (IPX directly over 802.3, without
an 802.2 LLC header) by looking for 0xFFFF in the first two bytes
of the payload, and report them as ETH_P_802_3.

IPX was removed in commit 7a2e838d28cf ("staging: ipx: delete it
from the tree") and there is no in-kernel packet handler for
ETH_P_802_3 on the Ethernet receive path anymore.

Simply classify all frames using a length field as ETH_P_802_2,
which is what the remaining LLC users (STP, GARP, SNAP) register for.

This removes a skb_header_pointer() call (and the skb->dev scratch
trick used to avoid a stack canary) from eth_type_trans(), and lets
skb_vlan_untag() only pull VLAN_HLEN bytes, as the extra two bytes
were only needed for this check since commit 55eff0eb7460
("net: Fix potential wrong skb->protocol in skb_vlan_untag()").

Note that such frames are now reported to AF_PACKET, tc, BPF and
nftables with skb->protocol == ETH_P_802_2 instead of ETH_P_802_3.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 2/5 up/down: 33/-187 (-154)
Function                                     old     new   delta
skb_shift                                   1736    1768     +32
eth_type_trans.cold                           45      46      +1
skb_vlan_untag                               690     678     -12
__skb_vlan_pop                               489     477     -12
nf_flow_encap_pop                            462     449     -13
eth_type_trans                               354     220    -134
Total: Before=31212910, After=31212756, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/if_vlan.h | 18 ++----------------
 net/core/skbuff.c       |  3 +--
 net/ethernet/eth.c      | 18 ++----------------
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4846032bf4ffc80e55a8aafd1814bbcc27233599..97589236713668179dee21da6b3572edffe51404 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -698,7 +698,6 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
 					struct vlan_hdr *vhdr)
 {
 	__be16 proto;
-	unsigned short *rawp;
 
 	/*
 	 * Was a VLAN packet, grab the encapsulated protocol, which the layer
@@ -711,21 +710,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
 		return;
 	}
 
-	rawp = (unsigned short *)(vhdr + 1);
-	if (*rawp == 0xFFFF)
-		/*
-		 * This is a magic hack to spot IPX packets. Older Novell
-		 * breaks the protocol design and runs IPX over 802.3 without
-		 * an 802.2 LLC layer. We look for FFFF which isn't a used
-		 * 802.2 SSAP/DSAP. This won't work for fault tolerant netware
-		 * but does for the rest.
-		 */
-		skb->protocol = htons(ETH_P_802_3);
-	else
-		/*
-		 * Real 802.2 LLC
-		 */
-		skb->protocol = htons(ETH_P_802_2);
+	/* No ethertype: this is an 802.2 LLC frame (length field). */
+	skb->protocol = htons(ETH_P_802_2);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c4024a03e10550d22dd926410c4fada35f69641..43ebe61c7fc481e91cf560f7e21b5a9dd02bbbc5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6355,8 +6355,7 @@ struct sk_buff *skb_vlan_untag(struct sk_buff *skb)
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		goto err_free;
-	/* We may access the two bytes after vlan_hdr in vlan_set_encap_proto(). */
-	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
+	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN)))
 		goto err_free;
 
 	vhdr = (struct vlan_hdr *)skb->data;
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index d9faadbe9b6c86a746cace6d7a7cfffdb84e4519..39aab0f8035ad9fc99a7dd81b397050a719ecc25 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -154,9 +154,7 @@ EXPORT_SYMBOL(eth_get_headlen);
  */
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
-	const unsigned short *sap;
 	const struct ethhdr *eth;
-	__be16 res;
 
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
@@ -176,20 +174,8 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	if (likely(eth_proto_is_802_3(eth->h_proto)))
 		return eth->h_proto;
 
-	/*
-	 *      This is a magic hack to spot IPX packets. Older Novell breaks
-	 *      the protocol design and runs IPX over 802.3 without an 802.2 LLC
-	 *      layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
-	 *      won't work for fault tolerant netware but does for the rest.
-	 *	We use skb->dev as temporary storage to not hit
-	 *	CONFIG_STACKPROTECTOR_STRONG=y costs on some platforms.
-	 */
-	sap = skb_header_pointer(skb, 0, sizeof(*sap), &skb->dev);
-	res = (sap && *sap == 0xFFFF) ? htons(ETH_P_802_3) : htons(ETH_P_802_2);
-
-	/* restore skb->dev in case it was mangled by skb_header_pointer(). */
-	skb->dev = dev;
-	return res;
+	/* No ethertype: this is an 802.2 LLC frame (length field). */
+	return htons(ETH_P_802_2);
 }
 EXPORT_SYMBOL(eth_type_trans);
 
-- 
2.53.0

