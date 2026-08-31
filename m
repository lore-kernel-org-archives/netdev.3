Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F4404BE8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170396; cv=none; b=FnNqVNrAUy+mee0aLiqvlmK+WEohqmaKa5LzrXPtMiFcXv/JkSt21sUdCvJ5fxDRNGVhFv6KtMCe8b7DVKG8qmE+j6IadXA9OfMucoPxyb4Miu00doNi/yERQKmdgWu11aL4XRLohDKIByaK/i3sKSeotr+z3riCF2VV3ujHgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170396; c=relaxed/simple;
	bh=B15RlXup8VNrbDY928345EvNUEtNMh/B6AZDUiwOnQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nlZQx4RjZogeWNbOoH67M6A7A6Y8yrHABbZxKSpNU+ISBEGcygEMeN0cgiSl45WH6ttYk/lq4M9AGUV/qHl61vNMFAeaHMt5Y2zqPTyaXUeMK+uwy/kOz0mYB0iW1zMFtP0kULDxhXADqHeclcTHklObhzuRFaa0YvNczfnl2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aedL06qC; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aedL06qC"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93771aa0379so892936385a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788170394; x=1788775194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q6dY7yOVEqXJeUCiqCQC5RwlEiYvk4fl4crGEBWJBdw=;
        b=aedL06qCjct+z5+ypoINGYP3Mg2IGImRk5vmk99CuaQQZg1TJ9mswPljcNJxXh4yG1
         rQrCLBT21/0VuUy83VTfcIFPb41bpFy/nt0x1XIxqyIaQsfduwNo3OKpLQn0Mhidrwmf
         KpypPkhxp9HZ/M6nQ43nZnhQoRa18ErOkOXCCnN+e9yyVP/JiJKNZbhlobsQ+Jv+X9Zi
         G63es0ZDrADi9DhqFKju6BU8Vp0hUYhY8cdLQHfPqIi4BpMxaymSx+IkYzB44KQmeoLm
         RAkbDSW4rPdbIos+DvTHRgui6rRH5vXjFFp65KgckXwiGpvb3T8d+fW7+jxcQg/9MjXS
         IlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170394; x=1788775194;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6dY7yOVEqXJeUCiqCQC5RwlEiYvk4fl4crGEBWJBdw=;
        b=KbNoQkzUsR/l5U3s8G/W+Icye8+QKudv8SVQ6VIkyMDrWvMdTJJJJW9c8LrgPIN3vJ
         BGGaCk6nMWQHhRBd15B1qKVy1OdDzqAQJH4QRxjK4eYjH+hL8erqrNMbRopgso4C8jcY
         R4+1JE1SYNr+Deui8Dmo+r5UJsCUfAs7FMe0Nb/UnSQt4jA2YLSRjCZ0haucOkAiGeB9
         aNm/Lw0zwZmpJG2J6G8WYS/wDUZz0bgiOBfwaVYCaNPFb/EO28oyooGewvf9Qeim5+Ec
         wL52hf1ZJty8lx/ej6DmjC21l3neVRzNB+fx2BDs0p5X2mxiNN30ynRRedhE3xRQiFf7
         rOXg==
X-Forwarded-Encrypted: i=1; AHgh+Rpoh3GpQNjHGAHuqhnnXr5PO2NnkMoUr5KHE5CI3ftn9jm2zzWlL3xAojQ9L3y/sVeABil7X2I=@vger.kernel.org
X-Gm-Message-State: AFuF++mKXfHn24W60uGsDjrP+5L0C0i+vndn04KXgZwVWOgTQdF6x1lh
	UfWsssnk9iPFuvFyvz6aqUGslGMalm2TbY8fyjfzi2H3NxU0L51qINMycb9O3jiv+1V3nFClq/Q
	M8NTWY/KKhelq1g==
X-Received: from qknvu23.prod.google.com ([2002:a05:620a:5617:b0:92e:512f:829a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:390b:b0:936:57db:e761 with SMTP id af79cd13be357-939427fc52dmr171258085a.7.1788170393781;
 Mon, 31 Aug 2026 02:59:53 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:59:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831095952.3385596-1-edumazet@google.com>
Subject: [PATCH net] net: fix use-after-free in pskb_expand_head()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com, 
	syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

pskb_expand_head() and pskb_carve_inside_header() decide whether to drop
the old head gracefully via skb_release_data() or directly free it via
skb_free_head().

Blamed commit replaced the check against dataref == delta with skb_cloned(skb).

However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHIFT)
of dataref using SKB_DATAREF_MASK. For an skb with nohdr == 1 or a clone
referencing a shared buffer where only one regular reference exists,
skb_cloned(skb) evaluates to false even when dataref is shared with other
skbs.

When pskb_expand_head() is called on such a buffer (e.g. during bridge
flooding, generic XDP, or VLAN tag insertion), it falsely assumes the head
is unshared and calls skb_free_head(skb) directly. This drops the underlying
head/frag reference immediately, while other clones or references still
point to it, causing a use-after-free in subsequent packet processing.

Introduce skb_dataref_bias() and skb_data_is_shared() to accurately test
if dataref is shared by checking atomic_read(&skb_shinfo(skb)->dataref) != bias.

Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() in
pskb_expand_head() and pskb_carve_inside_header().

Fixes: 3e24591a19bb ("skb: Drop "fastpath" variable for skb_cloned check in pskb_expand_head")
Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a954e27.4d659fcc.734b4.0046.GAE@google.com/
Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=128e9f5a0f85a51215b1
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 13 ++++++++++++-
 net/core/skbuff.c      |  4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc454511ea6c7b83d5227481840a7c4bcc0..efeef148e1ba50cbb0d480975dc6c3c59acb98c7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1295,6 +1295,11 @@ static inline bool skb_unref(struct sk_buff *skb)
 	return true;
 }
 
+static inline int skb_dataref_bias(const struct sk_buff *skb)
+{
+	return skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
+}
+
 static inline bool skb_data_unref(const struct sk_buff *skb,
 				  struct skb_shared_info *shinfo)
 {
@@ -1303,7 +1308,7 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	if (!skb->cloned)
 		return true;
 
-	bias = skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
+	bias = skb_dataref_bias(skb);
 
 	if (atomic_read(&shinfo->dataref) == bias)
 		smp_rmb();
@@ -2019,6 +2024,12 @@ static inline struct sk_buff *skb_get(struct sk_buff *skb)
  * If users == 1, we are the only owner and can avoid redundant atomic changes.
  */
 
+static inline bool skb_data_is_shared(const struct sk_buff *skb)
+{
+	return skb->cloned &&
+	       atomic_read(&skb_shinfo(skb)->dataref) != skb_dataref_bias(skb);
+}
+
 /**
  *	skb_cloned - is the buffer a clone
  *	@skb: buffer to check
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94d0a9f0387cec70b5297eccfcf19f..f4c0645f98d3f2f0c8765403e0184769e928d7b0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2331,7 +2331,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	 * is not we can just drop the old head and let the existing refcount
 	 * be since all we did is relocate the values
 	 */
-	if (skb_cloned(skb)) {
+	if (skb_data_is_shared(skb)) {
 		if (skb_orphan_frags(skb, gfp_mask))
 			goto nofrags;
 		if (skb_zcopy(skb))
@@ -6855,7 +6855,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info,
 			frags[skb_shinfo(skb)->nr_frags]));
-	if (skb_cloned(skb)) {
+	if (skb_data_is_shared(skb)) {
 		/* drop the old head gracefully */
 		if (skb_orphan_frags(skb, gfp_mask)) {
 			skb_kfree_head(data);
-- 
2.55.0.897.gb25b4bd76c-goog

