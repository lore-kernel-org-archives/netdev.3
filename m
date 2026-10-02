Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D703BBA0A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929650; cv=none; b=cegfROkTGGEKBZcgoG7pS5NicZnpl13UD9xU/2F4lXYSJQgU9/Gc+DcWMM/5BwIpODOCcidHx7OJGRbAJMhdD6lynnx4GMcVniDm5zkbjzAg2ZdOgrgXDIWYGjRQtRTVMSPQCaKtVnJOjx3oKF84v/AwL8jZXsv4k0h5ON5HHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929650; c=relaxed/simple;
	bh=WCPRnpc2zYBk6Fp0eZOcRxIBizkbOxjuUkko9qpk2+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEOzNZvv8IeqWSzcNX/+KiIL+Cb3+TCG/NLD8eYJlJ1VGsNJghXr7fnG7USj7XClN5w9uYreSt2F0LZ1zyOBnCfjO1Dokaei9PWBl3C4yC/HhH+BdaDXJQghLPm0+Lma47REBIFtP7GBQhecjSliw7Q9qcIaFr9QYU1jADyuxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaASS5i2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaASS5i2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784361F00898;
	Fri,  2 Oct 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929640;
	bh=K1Y/IyBREHaPGmDCissW4K/sbvjZwt7h1SD73iBGerw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QaASS5i2T/DbogsJx9D5LvbyfrqRw63gStadcDhY+iR9R9ZoPw3IviwmkPTF50fZP
	 eie32XeVx7Y29WOOXiAkdlAmIRCf30RnG8qmbmwN/uUsPB82w8ukXoE+ZLGt3KFYgN
	 wBUCnXKmPW8uLdNOvvXnrAaVhAyfAByGIMBCLRkS3OWPHJWpI336TF5n7hKGNzgZes
	 GRiRXcRnzXly2A2XAhaVAjLqla2FTvVvSXtJh3xaT+h+r2f0oseftQ/5taapuw3L+g
	 X1zG6EFWuwYYlNy4YX3fSdymN5qmSE8Ub7j+gUarNv0Ey5mCz35f7sg7lEGa8CgOJ6
	 Gd1dP9BZa2/yA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>,
	Farhad Alemi <falemi@asu.edu>
Subject: [PATCH v2 net 2/2] 6lowpan: fix warning in lowpan_compress_addr_64()
Date: Fri,  2 Oct 2026 08:27:12 +0000
Message-ID: <20261002082712.3535213-3-edumazet@kernel.org>
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

SEFCOM lab reported a warning in lowpan_compress_addr_64():

WARNING: net/6lowpan/iphc.c:937 at lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline]
WARNING: net/6lowpan/iphc.c:937 at lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
Call Trace:
 lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
 lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
 lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
 lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
 dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
 __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114

lowpan_header_create() stores the 802.15.4 addresses in the skb
headroom, without changing skb->data, and lowpan_xmit() reads them
from there. But lowpan_xmit() cannot know if this was done:

- AF_PACKET SOCK_RAW sockets do not call dev_hard_header().
- GSO segments get a new headroom: skb_segment() only copies
  data starting at the mac header.

lowpan_xmit() then uses uninitialized memory, and can call
lowpan_header_compress() with invalid address modes.

Fix this by pushing the destination address as a pseudo header,
like IPoIB in ipoib_hard_header(). The pseudo header is the 8 byte
EUI-64 given to dev_hard_header(), as in sockaddr_ll.sll_addr,
so its layout does not depend on the architecture.

lowpan_xmit() pulls it, then lowpan_header() computes the 802.15.4
addresses like lowpan_header_create() did. Like IPoIB, the saddr
argument is ignored: the IPv6 stack and AF_PACKET pass NULL, and
the wpan device address is used.

Set hard_header_len to the pseudo header size, so that AF_PACKET
SOCK_RAW sockets set the network header after it, and probe the
transport header from there. lowpan_xmit() now checks the minimum
length itself, and resets the network header after pulling the
pseudo header: lowpan_header_compress() expects the IPv6 header
at skb->data.

Also return -EINVAL from lowpan_header_create() for non IPv6
packets, like net/bluetooth/6lowpan.c, instead of returning 0
without a pseudo header. lowpan_xmit() drops them anyway.

IPv6 stack and AF_PACKET SOCK_DGRAM users are not affected.
AF_PACKET SOCK_RAW senders now have to put the destination address
in front of the IPv6 header, and SOCK_RAW packet taps see it
on transmit. Received packets are unchanged: their framing for
SOCK_RAW taps already depends on the 6LoWPAN dispatch type.
tcpdump is not affected, libpcap uses cooked mode for ARPHRD_6LOWPAN.

Fixes: eab560e58208 ("6lowpan: add support for 802.15.4 short addr handling")
Reported-by: Farhad Alemi <falemi@asu.edu>
Closes: https://lore.kernel.org/netdev/CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h |  5 ++
 net/ieee802154/6lowpan/core.c      |  4 +-
 net/ieee802154/6lowpan/tx.c        | 82 +++++++++++++-----------------
 3 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 44a7e16bf3b5e14c03b99a806145203fc2a4af01..ccc49d10983318b1370a659ff61649bf339fb8c7 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -30,6 +30,11 @@ struct lowpan_frag_queue {
 	struct inet_frag_queue	q;
 };
 
+/* lowpan_header_create() pushes the destination address (an EUI-64, as in
+ * sockaddr_ll.sll_addr) in front of the IPv6 header, lowpan_xmit() pulls it.
+ */
+#define LOWPAN_PSEUDO_HDR_LEN	EUI64_ADDR_LEN
+
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
 void lowpan_net_frag_exit(void);
 int lowpan_net_frag_init(void);
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 6a8d6852cb93057305a1a6c5398a3c072bde9f0f..c70b5e414fdf2a68013ded7b0d1d51ba3e3f55de 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -109,8 +109,8 @@ static const struct net_device_ops lowpan_netdev_ops = {
 static void lowpan_setup(struct net_device *ldev)
 {
 	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
-	/* We need an ipv6hdr as minimum len when calling xmit */
-	ldev->hard_header_len	= sizeof(struct ipv6hdr);
+	/* lowpan_header_create() pushes the destination address */
+	ldev->hard_header_len	= LOWPAN_PSEUDO_HDR_LEN;
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
 	ldev->priv_flags	|= IFF_NO_QUEUE;
 
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index ab28b6f912c000f5cf141982b6d1b25e7d2e48f6..10ce2928fcca1a9fd535e8e35f2cac3f792e82f6 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -15,17 +15,13 @@ struct lowpan_addr_info {
 	struct ieee802154_addr saddr;
 };
 
-static inline struct
-lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
-{
-	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
-	return (struct lowpan_addr_info *)(skb->data -
-			sizeof(struct lowpan_addr_info));
-}
-
 /* This callback will be called from AF_PACKET and IPv6 stack, the AF_PACKET
  * sockets gives an 8 byte array for addresses only!
  *
+ * Like IPoIB, the destination address is pushed as a pseudo header, which
+ * AF_PACKET SOCK_RAW senders have to provide. lowpan_xmit() pulls it, and
+ * always uses the wpan device address as source address.
+ *
  * TODO I think AF_PACKET DGRAM (sending/receiving) RAW (sending) makes no
  * sense here. We should disable it, the right use-case would be AF_INET6
  * RAW/DGRAM sockets.
@@ -34,9 +30,6 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 			 unsigned short type, const void *daddr,
 			 const void *saddr, unsigned int len)
 {
-	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
-	struct lowpan_addr_info *info = lowpan_skb_priv(skb);
-
 	if (!daddr)
 		return -EINVAL;
 
@@ -44,38 +37,11 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 	 * if this package isn't ipv6 one, where should it be routed?
 	 */
 	if (type != ETH_P_IPV6)
-		return 0;
-
-	/* intra-pan communication */
-	info->saddr.pan_id = wpan_dev->pan_id;
-	info->daddr.pan_id = info->saddr.pan_id;
-
-	if (!memcmp(daddr, ldev->broadcast, EUI64_ADDR_LEN)) {
-		info->daddr.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-		info->daddr.mode = IEEE802154_ADDR_SHORT;
-	} else {
-		/* The IPv6 header might not be there yet (AF_PACKET).
-		 * lowpan_header() will use the neighbour short address,
-		 * if there is one.
-		 */
-		info->daddr.mode = IEEE802154_ADDR_LONG;
-		ieee802154_be64_to_le64(&info->daddr.extended_addr, daddr);
-	}
-
-	if (!saddr) {
-		if (lowpan_802154_is_valid_src_short_addr(wpan_dev->short_addr)) {
-			info->saddr.mode = IEEE802154_ADDR_SHORT;
-			info->saddr.short_addr = wpan_dev->short_addr;
-		} else {
-			info->saddr.mode = IEEE802154_ADDR_LONG;
-			info->saddr.extended_addr = wpan_dev->extended_addr;
-		}
-	} else {
-		info->saddr.mode = IEEE802154_ADDR_LONG;
-		ieee802154_be64_to_le64(&info->saddr.extended_addr, saddr);
-	}
+		return -EINVAL;
 
-	return 0;
+	memcpy(skb_push(skb, LOWPAN_PSEUDO_HDR_LEN), daddr,
+	       LOWPAN_PSEUDO_HDR_LEN);
+	return LOWPAN_PSEUDO_HDR_LEN;
 }
 
 static struct sk_buff*
@@ -228,16 +194,32 @@ static void lowpan_neigh_short_addr(const struct sk_buff *skb,
 }
 
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
-			 u16 *dgram_size, u16 *dgram_offset)
+			 const u8 *daddr, u16 *dgram_size, u16 *dgram_offset)
 {
 	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
 	struct lowpan_addr_info info;
 
-	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
+	/* intra-pan communication */
+	info.saddr.pan_id = wpan_dev->pan_id;
+	info.daddr.pan_id = info.saddr.pan_id;
 
-	if (info.daddr.mode == IEEE802154_ADDR_LONG)
+	if (!memcmp(daddr, ldev->broadcast, EUI64_ADDR_LEN)) {
+		info.daddr.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+		info.daddr.mode = IEEE802154_ADDR_SHORT;
+	} else {
+		info.daddr.mode = IEEE802154_ADDR_LONG;
+		ieee802154_be64_to_le64(&info.daddr.extended_addr, daddr);
 		lowpan_neigh_short_addr(skb, ldev, &info.daddr);
+	}
+
+	if (lowpan_802154_is_valid_src_short_addr(wpan_dev->short_addr)) {
+		info.saddr.mode = IEEE802154_ADDR_SHORT;
+		info.saddr.short_addr = wpan_dev->short_addr;
+	} else {
+		info.saddr.mode = IEEE802154_ADDR_LONG;
+		info.saddr.extended_addr = wpan_dev->extended_addr;
+	}
 
 	*dgram_size = skb->len;
 	lowpan_header_compress(skb, ldev, &info.daddr, &info.saddr);
@@ -258,6 +240,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
+	u8 daddr[LOWPAN_PSEUDO_HDR_LEN];
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
 	u16 dgram_size, dgram_offset;
@@ -265,11 +248,16 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	pr_debug("package xmit\n");
 
 	if (skb->protocol != htons(ETH_P_IPV6) ||
-	    !pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+	    !pskb_may_pull(skb, sizeof(daddr) + sizeof(struct ipv6hdr))) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
 
+	/* Destination address pushed by lowpan_header_create() */
+	memcpy(daddr, skb->data, sizeof(daddr));
+	__skb_pull(skb, sizeof(daddr));
+	skb_reset_network_header(skb);
+
 	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
 
 	/* We must take a copy of the skb before we modify/replace the ipv6
@@ -294,7 +282,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 			return NET_XMIT_DROP;
 	}
 
-	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
+	ret = lowpan_header(skb, ldev, daddr, &dgram_size, &dgram_offset);
 	if (ret < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

