Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304A4C77BD
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766961; cv=none; b=RcOrdujVHA1DYOOZLzGSdEoPRFhEB707YvyYGMY8Rze7qJqo7pEsPm0ctRtt10VplwYuHS8faOMJz+Ks6+b8zPXs7HAxoV2uwnGgu63wkgWm1cKbsHgzT8xtOYe+za4Gb5HHB5qf1hzhCHv2TTFOHmW1B18B+HPu7rHaNNSV9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766961; c=relaxed/simple;
	bh=bq7y6nz00uXO6OCf1DOKb9qpPEUyiGK32+WbURvJVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROb9WInepsERs/INUh+D39qqGVP39N7hrZSf0y8+PiSlMw/iJrAPnKgoEphfEyrC4AO3Pthyu7FJb9GKrqx8fybkifYDS6u8cK5pknyaAI1IDUER/ku/vfYyJxlXo2oeOaMPvDxGgpUzm4+kLitQD2CQxc2KzTATQE5DtUsh9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=c8baYmZP; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="c8baYmZP"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso5867106eec.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766957; x=1791371757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E28tUJO0PXqK3V5X4pYHs/7vLIQYo4YEAQc4viPeYEE=;
        b=c8baYmZPnecIe9U7fco8LpfxRQ+DsKAmsd6vALHdEj+5AzzOiY47kXl3jDTZwL/Nhx
         /JZCpOSIzujfffOEwb3kinYzotIoY/KUDFo7mgaSX1RFJrmbROwiBZ5mYr9rWD5RVsAM
         GzpTvwGzRssbpHGqno9VeS3i+69dV/ALn9G9BcGu/t/wWzwBmDwBNHEkODHtz/yBoDQD
         /m0LtOG75YhzHIl5Sx02P6hYSDHyNkK2pfUHQVFTMl+KYJQ75uSWXhuITiE7AOxgXFXt
         tF/sDimwq3/24vripyO0WGjCE3I1M6Z/TictxO9ytmsxK7lbAnXZsL0nPrANyR5bZW5W
         pfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766957; x=1791371757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E28tUJO0PXqK3V5X4pYHs/7vLIQYo4YEAQc4viPeYEE=;
        b=sg66iZOKnPcY25fe2duN9wcv3ouE9s0s/a59gttjJp8GTfDiaaBTvZX5fe6lYWpqkt
         jSftKHSmYlc4O3QkhA7YpAgPdGN9VHPnh9NxXSQiP91P67osPICtNxwNxp3/Mtp3Vmhn
         e6/scXP1CdNVJgsT12blSMoSHzCSMBBa0EfXgjDgdIpKw9G5bmivHbyXSuZsZ1SPBsPy
         N9aFPX6mt+RMJKfqBHD0FNswHYix2KPRKX9Coa2KirhdwyNWIizp7dHd6J8owhntVijC
         7AlaARwsVBDjPLTbXFqWR5irQwO0QJ6m9zf0FLF8P5jH2DIECSTJKWzxU0AkcExNdyBH
         y7BA==
X-Gm-Message-State: AFuF++ktl+AMCLkyN6wxJm6cYo9p/rhComZPVyaY98hcjhHZsr3cZkH3
	23/hElxEdzKJ8Y9Rsu+adVeqrIlDUixlInGN/F8iqpaUmkws7FDTjDNi/yh/j5Gxw14OuUCVMqS
	cEGEvlBlUu7hvZ0482EqhU5cxYy7tFsLEDJf1Dk88fHT/UDIYNHeA4pOUn9BDupw24GVAoE8D
X-Gm-Gg: AYBFou2rvG74wYSDLAttslQd4F7WEkSLo0BFCTJAHsJWKJLjBA/qZFd6CpZgOiQJ6BS
	cbK2oRt4BW/JNpcL1cn9rLEtqs17MaCik/gvV/zieI67Q+Oodz3G4sP/hoZ/Ii8AJ+mjMp04b6H
	msAIeJ+vQkvglAVYcJtnUCWQETVW7dR8q1KY54stzfOj3xsAkqjJvq0ftqDUjHl0QKvpmKRJb0c
	7ZwpDO/+V2jN5OlnudDYxkxWnUvJ/6cf7wkPhHT67N2K1dwX0a8UzMgEvo5ff4Ji3lGK11JE3Yw
	aUBubTbUXj5dF/U30ycgoLVlTICE/4c6FbZgrlz+Z1SeEBcwg85T3XaxS1LvFQy8cCnPYeAXERT
	ia6/OuIAL9H58Dk1LyO6/Gj9PoSxs7eUrLEwzFqP9eZoPC+86NXcL/S/vqdzecYO/aiba8Gb5Zo
	c9nmjEZhyo5US+aPlvZSInGFpXchq8NPy9zQ5mLv4meUSfHuE+m3+0B49hmbUjsZad+UW0ccEnS
	ATsc5krxsEw5cmFvdIl/g==
X-Received: by 2002:a05:7301:1927:b0:34c:8c69:529d with SMTP id 5a478bee46e88-34cdc0d20fcmr1435447eec.26.1790766956414;
        Wed, 30 Sep 2026 04:15:56 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:15:55 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] net: gso: support re-segmentation of TCP GSO skbs
Date: Wed, 30 Sep 2026 19:15:24 +0800
Message-ID: <20260930111526.2183107-4-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930111526.2183107-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The re-segmentation added by the next patch splits an oversized TCP GSO skb
into several GSO skbs which fit the device limits.  That needs the GSO
engine to group several MSS segments into one output skb, so let callers
set the number of MSS segments each output skb may carry and pass it
through the existing __skb_gso_segment() entry point.  Ordinary callers
pass zero for no limit.

Without max_segs, skb_segment() groups several MSS into one output skb only
for a device which advertises NETIF_F_GSO_PARTIAL or for a skb with a
frag_list which can be split into uniform pieces, and falls back to one
segment per skb otherwise.  A caller which sets max_segs asks for the
grouping regardless, so the block which makes that decision is skipped.
Callers which pass zero keep it, and the re-segmentation path only runs for
an unencapsulated TCP skb without a frag_list.

The output stays a GSO skb: gso_size is the original MSS and gso_segs is
the number of MSS it holds, so a downstream device can still perform
ordinary TSO.  Store max_segs in the existing skb_gso_cb scratch context,
alongside the call-local data_offset and mac_offset fields, so that the
segmentation methods keep their signature.  A zero max_segs value means
that no limit is active; it is not a persistent skb flag.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4:
- drop the comment at the frag_list gate
- call the feature re-segmentation rather than bound
- say in the kernel-doc which skbs may set max_segs
v3: https://lore.kernel.org/20260928044102.1004310-4-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-3-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/
---
 drivers/net/tap.c          | 3 ++-
 include/net/gso.h          | 6 ++++--
 include/net/udp.h          | 2 +-
 net/core/gso.c             | 6 +++++-
 net/core/skbuff.c          | 8 ++++++--
 net/openvswitch/datapath.c | 2 +-
 6 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39ec..bc111495ebbce5 100644
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
index 29975440cad51e..fccb37889965f5 100644
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
index bcd156372f4df0..21a259ca392f43 100644
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
 
@@ -117,6 +120,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->max_segs = min(max_segs, GSO_MAX_SEGS);
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8912a66cd90972..fd10a7cdc1883a 100644
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

