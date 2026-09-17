Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60D4E50AF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627175; cv=none; b=ge2g8Och8gz4+1X6JTcAtxGcm21FA3ncWtq0ubcsJ3HsGCzhQOufzSpDiUkT4EcnfioKFeKcb1ug/PGg4R3R6YZ+EUXRX8CqFiYuMSEC2hNMXqAkwFFZkrOMiwRI663ymwGYCom4PX5PPL8tuCYAo1CTkNRX8GlNJHeH/DJaoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627175; c=relaxed/simple;
	bh=MUFDxItIc6j5ydP3kZh6x7GgqwZbSf51KBf3aFwt2FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNwR9QeG/2ihd4tc8EwCtJ7OegdW8yQKztd/9NwSAoq4oLXDNGH8m4gCzXqN3rFj+r0XltCBRFfDnRhEnRex1NoXvIMLGBhZUzc8b61MXB567/h0jiVHrd37FU4JRU81KSezbPGClzpxbXP9AJT8mGxs53kd0zXKslCwDyL+Zqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Xwdy5HJI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Xwdy5HJI"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so411071b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789627173; x=1790231973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnBPv6F9lz/THf+mDaD9zwZNDllLBySsrpCA8QKPwWs=;
        b=Xwdy5HJICR/Ll3ptYChX6e11iL0clbysLQlNhLBGww/TpsR5mfZrrRP2CkXdjp9WCH
         3icT85aTo9kQbOdxMh2hYYHXfW+qsruxLFI5ul6I6uiBtF//WuvYZ29nBx+npmCVcIPD
         IVeBDz2JUovMGdx6g64t+NxKtFUFIp70I3Lzh8McSRkA5wMQGqOPM+A7zlG4CroSY4qQ
         bfu9Cv2yLCE7VMSH3sW6PorP7wi8U8hzBQed8snRg/S6mILxnVs6wxG3WWigyPS/+KlG
         Vcg5zj6ZkpJV+VtkrIFFXcT2jipVGJMIf5nLqBER6WEom80VIaNU7nd4fxmDeXO79xjK
         1Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627173; x=1790231973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jnBPv6F9lz/THf+mDaD9zwZNDllLBySsrpCA8QKPwWs=;
        b=rwt6QRU60G56AV8m1oL1Fqe47p4UbAYLsJX+aMPFNDI8QleFHz8j7pMgP5tnIFgXb3
         VIvSl//0Pe4Ydm6Zp303hi6oaHZFDwXGlcKbE/Fvv8GwQ/oImABuYJr9UuF4ZI8B8yx4
         W7iq5d5Zm7whHXSicvpO/vvo3cTsXhOm/UjJ9bYch48/A/lmQmiwG18OpQMRmXwAqFAG
         c9fjV9O+X7N0gxnomH7Yc3TQMslow7BZ9xbCcrPsOwRdRwiW4PlWb++FbwpTMmmMFRoa
         ltbMgvxJYXUgJKP3x6WYkJ8dv1pXxlZYlm3rlCDfR2NNCgzz5RBXBx8xEwVc/ycXmTJt
         nuXQ==
X-Gm-Message-State: AFuF++mGUsQ9juoXttQ9LEfXV0ecVH4UUv8sGwQ2QmgTIJCOnWwb3MPl
	p9OPLpQnZTQeEHgWciIa+PD8Z5w/SUqicHDgtckrfcWDoUJ2UEo8BLf7rbqCo7nW67Qn4lDDPqg
	d8xWvCYaznPFTdpM18aGfLzPC8vFics/EFlvjPR/Wyh9bkO+iAgHP9RPjevBQVJyWgcz7e5kWg7
	ofvQ==
X-Gm-Gg: AYBFou0+UBOXbjEQZdAiMWldtGpvIifLfiuJUJxIR6np6AoIs/NLk2F1o0oL3WRKD0P
	GDOG+5k4DpVfX4FBQtTd39900f84dIsNua7WZLigpYCdBiY3sJwk6N5DDKMr9hhICc/Rq+P+Gvz
	FBCxF7TBCdF8OmQzrw/ENkkG9K0UKD03LnHoZNOJ6Ze1jeIDn1VSowTO+PoKAqtOMah9JW8KSmG
	hotyGvmW+cx0F6zHe/WRJKeavdbPxU40KmnIpTzoH2cBj+uT+0yRQ3uEVOuXZ40F51CJUrTYu4q
	nM7b6YF8n8K+SogW+8sohA4p2GnERAxLX6t1I3pKUKUP3aXCGXTqfdXll3XLyzAyJwMKsvUN5sa
	RGhZw3jjScETQvC2HE9mdiA4NGysycVorDo11Dxe+Rc8QdD7ikj+XctQrLrV27LvyHK0FQ8DaMk
	IikoTBp6QmZHq+VomqZXbPk/8we3E8X/l+6/aj8OJNnjSt7G6ZyXX30Vhnt4R1KkoYc7xXb+Q24
	3DVUkLBVWIQ
X-Received: by 2002:a05:6a20:9147:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3dd5f57c1bamr13015782637.18.1789627172862;
        Wed, 16 Sep 2026 23:39:32 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d76834sm10904606c88.14.2026.09.16.23.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:39:32 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next 2/4] net: gso: support bounded TCP segmentation
Date: Thu, 17 Sep 2026 14:38:52 +0800
Message-ID: <20260917063854.2011613-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917063854.2011613-1-wang.zhan@smartx.com>
References: <20260917063854.2011613-1-wang.zhan@smartx.com>
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
 drivers/net/tap.c          |  2 +-
 include/net/gso.h          |  6 ++++--
 include/net/udp.h          |  2 +-
 net/core/gso.c             |  5 ++++-
 net/core/skbuff.c          | 14 ++++++++++++--
 net/ipv4/tcp_offload.c     |  3 ++-
 net/openvswitch/datapath.c |  2 +-
 7 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39e..57761aa1a983a 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -278,7 +278,7 @@ rx_handler_result_t tap_handle_frame(struct sk_buff **pskb)
 	if (q->flags & IFF_VNET_HDR)
 		features |= tap->tap_features;
 	if (netif_needs_gso(skb, features)) {
-		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
+		struct sk_buff *segs = __skb_gso_segment(skb, features, false, 0);
 		struct sk_buff *next;
 
 		if (IS_ERR(segs)) {
diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad51..cd4205090dd78 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,6 +19,7 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	__u16	max_segs;	/* Max MSS segments in one output GSO skb, 0 = no limit */
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
index 9648782fe8cba..da606fdbac3a4 100644
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

