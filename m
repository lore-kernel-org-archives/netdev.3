Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E1348463
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721257; cv=none; b=I4X72ARMejbEyF115IhxZ49lqk8ex0UhkUCMlca1sqJtSC5aN0ZkUo/53HTLk8+5M4cPJl1JZTKSLiG2dSd56QBDf5sfgCN1huCldkhfR8pXH0QkyPYkwlyiixfdvSmLpoSpVj4o7cfBgTvljW+CSCTooiZLryiNg2X0BRyGEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721257; c=relaxed/simple;
	bh=RZ9/hCq2hvhcxYmmp0+h+mwD+YY0x8AExBns0iKh2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1ITbCZ+rQevvtyv47L3zAkFxp8QokMgIJGRQo/jwQqSv5Y07A+XGVT9YPe5gdC432tLRG47sjMzyrcV7J7Zj+nxPKSswol9rjrJoAIzi8B2vkFtMrZFGjrwoOEP+MY9qSVgTzFmXEB9s1qP/hLyPehEg8otzxnRYJEtzOvc/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=wiwIFsQQ; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="wiwIFsQQ"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd8923e7abso6495345ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789721255; x=1790326055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EE0dVfdrOmZpweF4eCzLlqGEzja//ATgtFdJ3qaOUKY=;
        b=wiwIFsQQHYeimApO6C7kelk3dnoc3YXNG5t9eRvQU8SkgFgf7cZF8woUwuoWP6bXSr
         RT/f+vzVLXCnMc7WCluGNJe/CImmounDucFAgM9m8KXjrRstUs/scgbyHaXGdFTDWdcD
         qPQ3EsrY9HZmPDCpFPUeWXYHME0HoIA10jdnicVkzlZHQnWSV5e781zkCfs7lt3Pn47Z
         6A+5cdZ7A9vDQs3NP9EtLzODGBGxzWk0kZFcCapFyJjey1YCfspC3W1JbGsRqBOAJU0/
         IK+N5ibXUTNzUG/MR/kl05cuLywIk5raI8i5xusapVYrAjSsMYchWLWJLYxOne2DAdfb
         uYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721255; x=1790326055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EE0dVfdrOmZpweF4eCzLlqGEzja//ATgtFdJ3qaOUKY=;
        b=WaWmPP/CK206P6jlNgHX7gEldENCqo93npgu/1u5E7SbIZkDimy/8ENksrOJyTw9lx
         McqjRJotwx02FnX6YgASEKD4myEBzOUp58sg2j/DXoJYiP84Ba3BXsSgxDEVtap9m+3f
         uEZBOBx7Sy4dIWG3+imV2Xn66cfpjnDyILlExhWaK2skHHJfGVBkBgM9YQsYyA7VPvRM
         FlLQWLVbabpZu987NNwBB7a26WjeqFnzYNzq2ah8ASZxFRIzkx6XpMMaCpVK6kT7/adI
         qwOw68wv1r6+W3c3hDsXtvDc4eKJvfJ4BQ7GXdM9Fzyn1Lg3QxJ7HoF8lluhSHwOWkXR
         eJ1w==
X-Gm-Message-State: AFuF++l5d0PSY8+NN6r0nED4H9jKnnYQKKu647otKj1gq/yNwQ68+3md
	n7U37PFgEeQXZ7+hHmB8lwlZy/SH9Yh4GnQplBsrRfXjY8nqCnKmtqBz5ius7ef0ypX1upRUouI
	cHP0nCLLlbXoW2S60GKrF+hr1EhfHaKUXujMvuX51/Nv2uZMMScr3/6ON+xA6A+dB1F+N/bwg5d
	w3ht5n
X-Gm-Gg: AYBFou2bJb+ONg6bcQ9zGBN0+9spgfiXdBgguBqowPDRrhVYjlpGacChuj3tbWFsgWG
	KhlrbFpUhgIlfBUjMNgqFvUd16tm002mUtHqe7ZQHR+LpsO5Daj2hyVBg8yC1igyeoD+4fOA8p2
	U/JzVhuU1VljsjORnKN0Q73V4LXtOHoTJPEF5bG7v42lWCahdRZAmoCBtRmcSgIHXJx4c/zq9KI
	8VXxjAMWL1LSLB7kGmCrGJlk6mSJ+YJBm9nHnibeI76QmuCcfI6pT2ZYSONu/bkW1khFFx4IVxw
	QWWXa2XZ9hmdJhNXr5mLMCykVLIlkfeZD1SpyC1TcF7Ll5UP+hzZvcvgjb2dAx4ZgohBo+BHzM5
	4BsiLdgKEsYu6LnbUBCBfmx4QI6xJnDd8cHBOHvdr0/EEzem44GH+3/uMfZWzpmiYVlw4RbDbH3
	dASzlDxfQDf3v1SGP4CPLJ9dRLDs9g2W8Hdpte15oH27snc8slZXdOrFDaTpBlxR7b75FF0KedJ
	2gdvlJqvKU=
X-Received: by 2002:a17:902:f652:b0:2dd:8800:f69d with SMTP id d9443c01a7336-2ddb1b0b1b3mr46022785ad.12.1789721254618;
        Fri, 18 Sep 2026 01:47:34 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm2578095eec.22.2026.09.18.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:47:34 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
Date: Fri, 18 Sep 2026 16:46:49 +0800
Message-ID: <20260918084651.3022878-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918084651.3022878-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounded resegmentation added by the next patch splits an oversized TCP
GSO skb into several GSO skbs which fit the device limits. That needs the
GSO engine to group several MSS segments into one output skb, so let
callers bound the number of MSS segments each output skb carries and pass
the bound through the existing __skb_gso_segment() entry point. Ordinary
callers use zero for no limit.

skb_segment() only groups several MSS into one output skb when the device
advertises NETIF_F_GSO_PARTIAL, or when the skb has a frag_list which can
be split into uniform pieces, and falls back to one segment per skb
otherwise. A caller which passes a bound asks for that grouping
regardless, so the frag_list check is skipped when max_segs is set. Every
other caller keeps it, and the bounded path is only used for skbs which do
not carry a frag_list.

The output stays a GSO skb: gso_size is the original MSS and gso_segs is
the number of MSS it holds, so a downstream device can still perform
ordinary TSO. Store the bound in the existing skb_gso_cb scratch context,
alongside the call-local data_offset and mac_offset fields, so that the
segmentation methods keep their signature. A zero max_segs value means
that no bound is active; it is not a persistent skb flag. Clear the value
when each output skb copies the input header so the temporary limit is not
propagated to the next GSO call.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v2:
- wrap the tap.c declaration and skb_gso_cb comment to 80 columns
v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/
---
 drivers/net/tap.c          |  3 ++-
 include/net/gso.h          |  6 ++++--
 include/net/udp.h          |  2 +-
 net/core/gso.c             |  5 ++++-
 net/core/skbuff.c          | 14 ++++++++++++--
 net/ipv4/tcp_offload.c     |  3 ++-
 net/openvswitch/datapath.c |  2 +-
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39e..bc111495ebbce 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -278,9 +278,10 @@ rx_handler_result_t tap_handle_frame(struct sk_buff **pskb)
 	if (q->flags & IFF_VNET_HDR)
 		features |= tap->tap_features;
 	if (netif_needs_gso(skb, features)) {
-		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
+		struct sk_buff *segs;
 		struct sk_buff *next;
 
+		segs = __skb_gso_segment(skb, features, false, 0);
 		if (IS_ERR(segs)) {
 			drop_reason = SKB_DROP_REASON_SKB_GSO_SEG;
 			goto drop;
diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad51..fccb37889965f 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,6 +19,7 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	__u16	max_segs;	/* Max MSS segs per output skb, 0 = no limit */
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
@@ -75,12 +76,13 @@ static inline __sum16 gso_make_checksum(struct sk_buff *skb, __wsum res)
 }
 
 struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
-				  netdev_features_t features, bool tx_path);
+				  netdev_features_t features, bool tx_path,
+				  unsigned int max_segs);
 
 static inline struct sk_buff *skb_gso_segment(struct sk_buff *skb,
 					      netdev_features_t features)
 {
-	return __skb_gso_segment(skb, features, true);
+	return __skb_gso_segment(skb, features, true, 0);
 }
 
 struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
diff --git a/include/net/udp.h b/include/net/udp.h
index 1fee17274745f..5bc25dcf25fba 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -613,7 +613,7 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	/* the GSO CB lays after the UDP one, no need to save and restore any
 	 * CB fragment
 	 */
-	segs = __skb_gso_segment(skb, features, false);
+	segs = __skb_gso_segment(skb, features, false, 0);
 	if (IS_ERR_OR_NULL(segs)) {
 		drop_count = skb_shinfo(skb)->gso_segs;
 		goto drop;
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4df..157f2bfdca128 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -77,6 +77,7 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
  *	@skb: buffer to segment
  *	@features: features for the output path (see dev->features)
  *	@tx_path: whether it is called in TX path
+ *	@max_segs: maximum MSS segments per output GSO skb, 0 means no limit
  *
  *	This function segments the given skb and returns a list of segments.
  *
@@ -86,7 +87,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
  *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
  */
 struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
-				  netdev_features_t features, bool tx_path)
+				  netdev_features_t features, bool tx_path,
+				  unsigned int max_segs)
 {
 	struct sk_buff *segs;
 
@@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index dbbe10277d51d..9c0d140236bc6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4793,6 +4793,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *segs = NULL;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
+	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
 	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
@@ -4839,7 +4840,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	csum = !!can_checksum_protocol(features, proto);
 
 	if (sg && csum && !gso_by_frags)  {
-		if (!(features & NETIF_F_GSO_PARTIAL)) {
+		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
 
@@ -4874,7 +4875,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		 * now.
 		 */
 		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
-		partial_segs = min(len / mss, GSO_MAX_SEGS);
+		if (max_segs)
+			partial_segs = min(len / mss, max_segs);
+		else
+			partial_segs = min(len / mss, GSO_MAX_SEGS);
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4975,6 +4979,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		__copy_skb_header(nskb, head_skb);
 
+		/*
+		 * max_segs is a per-call limit, so output skbs must not
+		 * inherit it from the input skb.
+		 */
+		SKB_GSO_CB(nskb)->max_segs = 0;
+
 		skb_headers_offset_update(nskb, skb_headroom(nskb) - headroom);
 		skb_reset_mac_len(nskb);
 
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e74d99ca9face..a4076318c5352 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -164,7 +164,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (unlikely(skb->len <= mss))
 		goto out;
 
-	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
+	if (!SKB_GSO_CB(skb)->max_segs &&
+	    skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
 		/* Packet is from an untrusted source, reset gso_segs. */
 
 		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 2187034143255..e793aead68372 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -375,7 +375,7 @@ static int queue_gso_packets(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	BUILD_BUG_ON(sizeof(*OVS_CB(skb)) > SKB_GSO_CB_OFFSET);
-	segs = __skb_gso_segment(skb, NETIF_F_SG, false);
+	segs = __skb_gso_segment(skb, NETIF_F_SG, false, 0);
 	if (IS_ERR(segs))
 		return PTR_ERR(segs);
 	if (segs == NULL)
-- 
2.47.3
