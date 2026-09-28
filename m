Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EF30CD95
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570499; cv=none; b=k+/8EpnfriaW9R/33f5zsSdb3cctXUebK5Lvdq6ZZ/06VS/PcJAq0TZ5vdqkDvbEmXE1x92o+m/I77+I9N9BJmWCz33wzbOK0pzeesMHT0l/lFS3wWf8spZuI02VAQcE6AbTlP2JmTmj6f4CSfLpkBk00sozZxKxFevTJDXLXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570499; c=relaxed/simple;
	bh=AAqPMTHkFPDULyuRgjk6B38kkYZeehlPZ0ZlA6DilEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcjXpAPA7XYk5XySfecgrX/9ANxM5gyi7rsD7oPkGnGHzryVPU96U1RVQnSxGCnJbucUSIPCswEQJWCQDKwJIFYfiTN0Ics8c2ZseJqwi8ycXUdBz3jKSdVaXoeZzDMuDR0jmvn4axbjTUWOhQ8ejDbh9mKzp7KswFsFGQRJK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=S6d3en1H; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="S6d3en1H"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3441c6893b2so137489eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570496; x=1791175296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oCeaJybTUFAGRPjLvKT8CYJX9A0Z3BGxF/rov4rRJLk=;
        b=S6d3en1HBujwUIInl7zJ0HBCtJksNWNAw8uiymKELEr4PtCq3Gk3uvX5EsnVPTSfLF
         e0UNq948q9yyQrk1DoC3a4DcrENJCfqmdsN6UHge965gsLgxqXpxdwm2P4JifYV0h589
         dcsXXm9wMJPY8CoFib23/+37wh9c/7NS7WtaIFyukeEENCz7Wvu2p1ph3aeTEsoeAU7O
         AjKt3KzzgpT25x4bB77f9QvoaBFm1jPHvva764eLQxWMWyRBVnOWuCyIhx9Vjp6nIXi+
         Glbu3pDSwhSWOulRLyQtHdy77hxEz2a+qHqPVwOwBjdNbxwsSPyrV6ezXtKLbcEHnTxh
         tnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570496; x=1791175296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oCeaJybTUFAGRPjLvKT8CYJX9A0Z3BGxF/rov4rRJLk=;
        b=ntU23HXyniMOSWFxC3XsPHlEYfbZpWLj0hZXj/EiGPUGqd5zmhAxyeuRbNpDEKMhfE
         vvemrXCVu5epoC29i+CKP/Rt6aJC7GB4KE76shA8qVbvoON7Wu2y3rnmlPFcbTLG9h4F
         EGTPy4cE44ZEP+m6BzxQoAZabcmsDS8ahAqp9DgMTjCey5T9Q7MT2iRidr0cKDPwmjQ5
         XXk28f0W5r4owgpmnyyx8Jceiu49LFeBCt+gTMSkb2vz9gE8Rv6H2NF5f+B40f1WZTHy
         hGDBScECfuR3TW2F5DldFItvJDCIDpCfDaFq2AO3WsXZwNU6vu5EeVV/o84fC3hfg0OV
         FkQA==
X-Gm-Message-State: AFq9FYKbd796EKKxrfyl//rXvs3CubHolYzRon7FLJVRTxc0B7cCO4sN
	KavpQ5jeN4ZQf1bX2IM/rNgzdQsdAVO0hROm7bFrRWkShw2BIMO4uxU+HDlJK+Zwkwz1BbZfR/8
	QYWpRQQ2u0GTJXBm/FdQgdT4ZSwGajPzkltQtLjrcrDtBIsiIxdXkeMM3nlIGrk1mX2toOSv/2n
	W3mA==
X-Gm-Gg: AYBFou0BL3rqyWNpX5AXUanT8kyCoJFnwu9M5H+JpSuMfKgIsK+rf1Y/pJgvfDHzPhg
	Q1mdMZ17VzkLM9TDkhfDo/69MJ7P43pJkznXOirWQl2w7CGdJjWtmudplikV1Oo0d+N1GJY5Lu/
	qMo9MGaYtKmo/hdxxgcRB3+JhCMAZx7J7jagGL5sMBkh2hB64jFKcLT0xZOx6R+5fkDGd5GztrX
	9Nid0VGQxBge8vh8DpnxENgT1JDXTbe841Tdmfql7dDZ24jm2l0+04ldEsUGZi1vOVnKcLUZKFx
	cZp8XR9Pzphe44qbLZFp9a2ra/xvTNdsbbpFrkyyeziZZgYbHxuzMV6wpo4bB3a3lCHw04t6mDj
	AgS0bvUZOGjHd7UxcrpVlD7xk7pTJW0DG4ikIB7Q0qV9wagq4ouyjda2xhKfW5acrMO6QkG44Tk
	hXTH6p4/FlKo9iyeGEUCjMI9FcLG9erefE/Xz7Twy6gqcwPPlbtY2qULBCvncyiRrp/VFe2yCBp
	zUhbN03xmg=
X-Received: by 2002:a05:7301:2224:b0:341:2466:2d68 with SMTP id 5a478bee46e88-3427304d4e6mr7841683eec.38.1790570495704;
        Sun, 27 Sep 2026 21:41:35 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:35 -0700 (PDT)
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
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v3 3/5] net: gso: support bounded TCP segmentation
Date: Mon, 28 Sep 2026 12:41:00 +0800
Message-ID: <20260928044102.1004310-4-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounded resegmentation added by the next patch splits an oversized TCP
GSO skb into several GSO skbs which fit the device limits.  That needs the
GSO engine to group several MSS segments into one output skb, so let
callers bound the number of MSS segments each output skb carries and pass
the bound through the existing __skb_gso_segment() entry point.  Ordinary
callers use zero for no limit.

Without a bound, skb_segment() groups several MSS into one output skb only
for a device which advertises NETIF_F_GSO_PARTIAL or for a skb with a
frag_list which can be split into uniform pieces, and falls back to one
segment per skb otherwise.  A caller which passes a bound asks for the
grouping regardless, so the block which makes that decision is skipped
when max_segs is set.  Callers which pass no bound keep it, and the bounded
path only runs for skbs which carry no frag_list.

The output stays a GSO skb: gso_size is the original MSS and gso_segs is
the number of MSS it holds, so a downstream device can still perform
ordinary TSO.  Store the bound in the existing skb_gso_cb scratch context,
alongside the call-local data_offset and mac_offset fields, so that the
segmentation methods keep their signature.  A zero max_segs value means
that no bound is active; it is not a persistent skb flag.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v3:
- drop the tcp_gso_segment() exception: the caller keeps the features
- cap the bound with GSO_MAX_SEGS instead of U16_MAX
- drop the reset of the field in the output skbs: every caller initializes it
- note in the kernel-doc that a bound is for TCP GSO skbs only
- note at the frag_list gate that a bound must not go with a frag_list skb
v2: https://lore.kernel.org/20260918084651.3022878-3-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/
---
 drivers/net/tap.c          |  3 ++-
 include/net/gso.h          |  6 ++++--
 include/net/udp.h          |  2 +-
 net/core/gso.c             |  6 +++++-
 net/core/skbuff.c          | 14 ++++++++++++--
 net/openvswitch/datapath.c |  2 +-
 6 files changed, 25 insertions(+), 8 deletions(-)

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
index bcd156372f4df..42fbce17b508c 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -77,6 +77,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
  *	@skb: buffer to segment
  *	@features: features for the output path (see dev->features)
  *	@tx_path: whether it is called in TX path
+ *	@max_segs: maximum MSS segments per output GSO skb, 0 means no limit;
+ *		   must only be set for TCP GSO skbs
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
 
@@ -117,6 +120,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->max_segs = min(max_segs, GSO_MAX_SEGS);
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8912a66cd9097..b16a6843f3192 100644
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
@@ -4839,7 +4840,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	csum = !!can_checksum_protocol(features, proto);
 
 	if (sg && csum && !gso_by_frags)  {
-		if (!(features & NETIF_F_GSO_PARTIAL)) {
+		/*
+		 * A call with max_segs set groups the MSS segments below,
+		 * and the frag_list split in this block does not carry the
+		 * bound, so a bound must not be passed for a skb with a
+		 * frag_list.
+		 */
+		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
 
@@ -4874,7 +4881,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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

