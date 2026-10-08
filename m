Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F34921B1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454046; cv=none; b=txF3O2xYy8SEkKNEZGWe6Vb9afU/k9UJtv17rksgt7HvXV76cCRy4kao9eNowd1ihTcnUHwsp+lYZg3KcqynjAirzoXp8VQ638ysGdpfdRhK416okKu4ulQLbiRlLCBYKv39JBsmhiIcEkiopsEK7y71VYxkoAV37u4WEn530wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454046; c=relaxed/simple;
	bh=K3o63W9SQ15djAbR7ccDO7MrwGCak9savL5/2U2S7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6lrIZ77/nhyZc+/oa3ubl0Wvw+6d8+zoEgAUIs3CuOnPsT59wD8nGlOTQ1ZfqYiYHCnD0nC9+x3o8zZjZ8JSvBX0bxM0qlpeiyRkROl661O+Tc6HL7+zPlTQSsERCnkWmpOctxgKBDjgz8KkiCiEKInUVSm20PLzomXpzUduWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Z5WZomOG; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Z5WZomOG"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15354aa70e8so1091441c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454042; x=1792058842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MInaTZGAyeNc3N10L4xlEYiw8NweQkY2iT7aRbcZMl0=;
        b=Z5WZomOGEwcs8VmGX9tJFU5JFeqgSKrbKNQYJxLv7MM5hwQzdETKU1SiqQ84MW/XY/
         CaKlT6lYYvPF1Enm3Z8vPdXVLoiSylYRG0calsfgeHQg9qv9zAt5ir+VSPHT8orP6Mi5
         MXPq8Hn8+t8VAPxRosI8nexS0Ufc9xXs6XwtUgUgf8edRWwbypIuZFKeMx+VUh9VL5hl
         WymsElArXynnK1WHv1cIKTCLmOuCdbG8MXacGxMMZrtgSGSABdkMWqwdDCD35EESMxGf
         bEb5TcI0D/fjK5L5xjPlBoUEHHkAGQD3Tt4NMaXMaLzDs06OtsWPoyl+8PH4Iwb/VfHL
         XBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454042; x=1792058842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MInaTZGAyeNc3N10L4xlEYiw8NweQkY2iT7aRbcZMl0=;
        b=HeVZNEDtMlmT8M9WFjZTOatYPqYY0z3lJU/rjIcL+vn1YmDNqU+yVFyxvElUHBWaPu
         XWBM5CAkA4RWvgFSpZ7DtrsiWmEiFEhfQ4vpa2+QkzCLp8Or76jvyXtaKjZaCZlnqpfk
         R9pjG5rU21UE4FcDB7w0dQzLrRkxTW4wNB2aUUQDOFuAShFizM3kWtr+qICZJkEG8gS0
         29P8QIIWFphzEckSPEiG39BNF4zHkMzjoPK32+dSFLwK60gcafav5N/0PTMeqh9iEUde
         iq93V2I/62IBl/KEGJqkir8HW45qK/ZeXoyKJFsDJrXyR+ideyrvPAl9N6zwQ90zEPB+
         w5ag==
X-Gm-Message-State: AFuF++ny+V0C9s+kgDQRBlgz/p9ikzA7Hs5qAIKwNX4r46EglCtlzLBC
	KLboOeT5mRC4jhLBIZeMBpaiX0CeyJP3c347scs+8p/H2SbGHAm7dGOEXIC8AggmqhBlCdmgwUJ
	8uE/Rlj9J2ww3JP+5JlHwUhTmwrm+F4jzv/b0c0hRnS16gySPOkqsZjvZnkQh4PSeJhBI6FIk
X-Gm-Gg: AYBFou195nP2e5H6M5PXEkjzKAMvqUAWhki3XM0jZokSUdlGpdFjTVCewnfKPezreZc
	iWpuAjYdTAlvZ705+WL/ma5ATaNzYsaqzkzCZrjzl1pna16UF3XJM9nPJh+0pggHX8NMgGCRlGE
	vjAcHlHyNzuDkMBJeCieT+aNn4Khva5ENlCUPCAK30+foER+7Z043OSld36u+Tr5aLN+SE2ccPI
	sQUH2bR9pbgbLcOLUIcMnpzlb2J+4dTz7476b05he2egR9zk5nwMZIn9qXqX08PNqAvgv6tfxAV
	sqzFugcPbPmc3SmLiNfhGP7LEB6JD8d6OBt9fw/1gWVT7/63qdMklQEXK81jmK/VUJgAB2IwkaR
	ilrn9qT+9SLv/kIKiXj6d/Iu6RPNX24DZAHUzEAqsaZGrBwpSSvm2x8KVLNUGqbrqzSDkFfSPcA
	lHJAszFQ/l1lw43ND9PPyP3JOjcaPPsfEKghPPmWhJVqB1iGZQk51aQB6eAqNT/qn+MvDa1Si7w
	kJ4xS1zuQU=
X-Received: by 2002:a05:7022:ed0a:b0:150:1cea:31b0 with SMTP id a92af1059eb24-16205cc1e56mr6382332c88.13.1791454041368;
        Thu, 08 Oct 2026 03:07:21 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:20 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 3/6] net: gso: support re-segmentation of TCP GSO skbs
Date: Thu,  8 Oct 2026 18:06:48 +0800
Message-ID: <20261008100651.2534957-4-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A caller which re-segments an oversized TCP GSO skb needs the engine to
group several MSS into one output skb, so let it pass how many MSS segments
each output skb may carry through __skb_gso_segment().  max_segs is a
per-call u8 in the skb_gso_cb scratch context, and only an unencapsulated
TCP skb without a frag_list sets it; every other caller passes zero.

Without max_segs, skb_segment() groups several MSS into one output skb only
for a device which advertises NETIF_F_GSO_PARTIAL, or for a frag_list which
splits into uniform pieces.  max_segs skips that test.

The output stays a GSO skb: gso_size keeps the original MSS and gso_segs the
number of MSS it holds, so a downstream device can still perform TSO.  The
caller keeps the output within the 64 KiB its L3 length field can express.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v5:
- make max_segs a u8, skb_gso_cb has one byte left
- only warn about the input segment count without max_segs
v4: https://lore.kernel.org/20260930111526.2183107-4-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-4-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-3-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/
---
 drivers/net/tap.c          |  3 ++-
 include/net/gso.h          |  7 +++++--
 include/net/udp.h          |  2 +-
 net/core/gso.c             |  6 +++++-
 net/core/skbuff.c          | 10 +++++++---
 net/openvswitch/datapath.c |  2 +-
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 832439b8a8988d..2f19fb07bb2d42 100644
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
index 0749230d414ecb..fe3260b381d4ed 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -21,6 +21,8 @@ struct skb_gso_cb {
 	__u16	csum_start;
 	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
 	u8	recursion_counter;
+	/* Max MSS segs per output skb, 0 = no limit */
+	u8	max_segs;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
@@ -83,12 +85,13 @@ static inline __sum16 gso_make_checksum(struct sk_buff *skb, __wsum res)
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
index 1fee17274745f0..5bc25dcf25fbaa 100644
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
index e96ef635006487..b5bd269e56e4ec 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -77,6 +77,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
  *	@skb: buffer to segment
  *	@features: features for the output path (see dev->features)
  *	@tx_path: whether it is called in TX path
+ *	@max_segs: maximum MSS segments per output GSO skb, 0 means no limit;
+ *		   set only for an unencapsulated TCP skb without a frag_list
  *
  *	This function segments the given skb and returns a list of segments.
  *
@@ -86,7 +88,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
  *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
  */
 struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
-				  netdev_features_t features, bool tx_path)
+				  netdev_features_t features, bool tx_path,
+				  unsigned int max_segs)
 {
 	struct sk_buff *segs;
 
@@ -118,6 +121,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
 	SKB_GSO_CB(skb)->recursion_counter = 0;
+	SKB_GSO_CB(skb)->max_segs = min(max_segs, U8_MAX);
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc481..1feb038d9ff680 100644
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
 
@@ -4873,8 +4874,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
 		 */
-		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
-		partial_segs = min(len / mss, GSO_MAX_SEGS);
+		DEBUG_NET_WARN_ON_ONCE(!max_segs && len / mss > GSO_MAX_SEGS);
+		if (max_segs)
+			partial_segs = min(len / mss, max_segs);
+		else
+			partial_segs = min(len / mss, GSO_MAX_SEGS);
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 21870341432552..e793aead68372d 100644
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

