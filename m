Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628868;
	b=beIUZ9gyk/bQK9PZgMPqgwEZ4VnlZs2dEfzD1ZEi+RU669KNeDbB9xd9sxDId5i8MLaD
	 HuPy60BUIGt3nIkjF+K9h7nrsyeAla/9to7dNFxLUuqqX42TdiBsiIdsd0EXU+b/c/pg4
	 H/WoxpfZwC9RVvmRo9anU4StAhaz69Lenh7go4HqMFo2Z7N6DgVlerJeKDH5w0z+6/1Yl
	 g8uJE5euFTrVL51gTofXKDJc724cEARx2ofE5HD/LaFM6P22s3sQCxW9MIFgBptvCoQfm
	 SsSd4VjJl/uoL+mjm6ctP0R22L8pQaIQCeQXGai/F+zgRzCwWxAeBwTuyFtY1zJCjfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uf5STt2ev1HSqyHHbVOT50Sjf5gybi6B30eSm+Jc/0g=;
	b=3SkFfXqWZIR/NdxJi5GWT+b1coIemZRw7Oa1li6590zuxYts0rdTLiOaBUMUuzq0a+dy
	 j8b9kMAaO6zhrFO/A0LyQktSsNXabgtv+E9HKvoa4m1Fa7q+iTGiEssCoxF4bw7QgCHvz
	 lx8JESMYtvnhygoeBGqZI+TqEHn2dMlgvRdFIJtVzxxPOskw6dR8CN9t18pG6HoqXe/qB
	 3Mqc1Yo0iapbzfb6UwkvrjMdbATuWDx8dpa9xrh3x+KqsmaIKNdS8sImnDzGL8xEKY+Nt
	 MtjHhknQUDt70etaSDa3s46NEWvUXqX1kUUcfkAm7ta2QlnVfkU7VSLqAvYR48eARow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NnjjBpcX;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27A606A89A
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E27A606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NnjjBpcX
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0a528ca65so1247772a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628867; x=1795233667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uf5STt2ev1HSqyHHbVOT50Sjf5gybi6B30eSm+Jc/0g=;
        b=NnjjBpcXIpPTnPP9HJT0f65m+mAx8d8jf1Zi9MZR1GNJLMMTs86yJ3R7zH+LlmzdLY
         3wyMdSibkUe3ZlIni58l35wIf8BZaSa7xcs7QuFObhPgg3HznnGYnbVSNicZLE2hD1xS
         65KoWGoK+bM2lRYYklMxYcMgWNG2h1nS6ei+bnHUqX66A0nMXx4MNx+jmPBkk+q/WeOc
         5lNaZBt6Cnyyqx60un0Sx+NvJjOI9q6so7LOfycU8bXJVPTQxBnGLI40wvMR8vHKVXkY
         XVkBjeojWCmQiCvshd5V68WnwD0+e6Oup0qiipahQUSK6N8c8KcTv/XA4giaL11EeZBP
         rznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628867; x=1795233667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uf5STt2ev1HSqyHHbVOT50Sjf5gybi6B30eSm+Jc/0g=;
        b=Q7VtqCOPF56XipjGwA1JiSGpRI++fny8c4injirZ7f78kLOYyNSv5tOBAWY2Htk/iL
         UGYPV60K1UIl9VeDbNEdl/gJBWBo60tt6xsI/iZlAKwoqRx2wH4TBXeRkNooNooqy4Ol
         dYpRHdAGfvcJ+QUF36MWj+YnAOs0IWWu9vBu998/BrgH9OBzk26Kvvp/qxQ3llW7RiFB
         vXysbdvMYruhqUHpZr7zNEPSV8F9rtDq9qJhM5tUUZuQpeyhRRF3uS69qlca2zYWsh4M
         WNshDtj2hmjYMRsAjXVdQSMzZkyXIC1HyN9q+qLV+owyK7M8TbLtztlKO7ZP5lKsfL9v
         VhAA==
X-Forwarded-Encrypted: i=1; AL+hErEnzNuLCjpOBwL2kw9pHOlXG5L//gXeE4PZBSS+2HSW8BqLPIuFv3Tk7sAYEirsAAHA7ah2rAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2iA7Eexlg1n7CRO5AzBKm1Y9sUfegzKyQtmRbp5mScawMvt7+
	Gi4nTv82GfN0DPqll/KkuZeW2zgohHOHGTJ32P/lLyGKSPPKU2CDWbS3PVi6LZZFDL1IuxEDugT
	eVZRRmg==
X-Received: from pjvm4.prod.google.com ([2002:a17:90a:de04:b0:3b0:b598:8b1d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e8f:b0:3ac:7749:2f0
 with SMTP id 98e67ed59e1d1-3b1b0b52e04mr4366398a91.44.1794628867302; Fri, 13
 Nov 2026 20:01:07 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:48 +0000
In-Reply-To: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/8] tcp: Skip collapsing if collapsed skb is less-dense.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once tcp_collapse() finds a collapsible skb, it collapses
consecutive bloated skbs.

However, the end result could be the same or larger than
as is in some cases:

  1. skb is already minimum

     If SKB_HEAD_ALIGN(len) <= SKB_SMALL_HEAD_CACHE_SIZE,
     skb is allocated from skbuff_small_head, and skb->truesize
     never changes.

  2. SKB_HEAD_ALIGN() and kmalloc_size_roundup() in alloc_skb()

     Assume two bloated skbs with len = 1448 B (truesize =
     2304 B, scaling_ratio = 160) and len = 300 B (truesize =
     896 B, scaling_ratio = 85), whose total truesize is
     3200 B.

     Collapsing them calls alloc_skb(1748), which rounds up
     SKB_HEAD_ALIGN(1748) = 2112 B to 4096 B and allocates a
     new skb with truesize = 4352 B (+1152 B!).

Even worse, in case 1, such a skb is reallocated repeatedly
by every tcp_collapse() in vain.

Let's calculate the final collapsed truesize before collapsing
skbs and skip the range if it does not shrink.

We could allocate skbs first and calculate the new truesize,
but given tcp_collapse() is called under memory pressure,
we want to avoid unnecessary allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/skbuff.h |  7 +++++++
 net/ipv4/tcp_input.c   | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d36fbb88b3f6..618e629df15a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -292,6 +292,13 @@
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+/* return estimated truesize allocated by alloc_skb(X) via kmalloc_reserve() */
+#define SKB_ALLOCSIZE(X)					\
+	((SKB_HEAD_ALIGN(X) <= SKB_SMALL_HEAD_CACHE_SIZE ?	\
+	  SKB_SMALL_HEAD_CACHE_SIZE :				\
+	  kmalloc_size_roundup(SKB_HEAD_ALIGN(X))) +		\
+	 SKB_DATA_ALIGN(sizeof(struct sk_buff)))
+
 struct net_device;
 struct scatterlist;
 struct pipe_inode_info;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bd42a74c6f5..fe71305f6e67 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5850,8 +5850,10 @@ static void
 tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	     struct sk_buff *head, struct sk_buff *tail, u32 start)
 {
+	int old_truesize, new_truesize;
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
+	int remainder, nskbs;
 	u8 scaling_ratio;
 	u32 sub_end;
 
@@ -5891,6 +5893,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 	/* Second, find consecutive collapsible skb. */
 	sub_end = TCP_SKB_CB(skb)->end_seq;
+	old_truesize = skb->truesize;
 
 	for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
 		if (!skb_frags_readable(n) ||
@@ -5898,8 +5901,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		    !tcp_skb_can_collapse_rx(skb, n))
 			break;
 
-		if (!after(TCP_SKB_CB(n)->end_seq, sub_end))
+		if (!after(TCP_SKB_CB(n)->end_seq, sub_end)) {
+			old_truesize += n->truesize;
 			continue;
+		}
 
 		/* seq and end_seq must increase monotonically for rbtree. */
 		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
@@ -5908,6 +5913,23 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 
 		sub_end = TCP_SKB_CB(n)->end_seq;
+		old_truesize += n->truesize;
+	}
+
+	/* Third, check if the new skbs have high density. */
+	nskbs = (sub_end - start) / TCP_COLLAPSE_MAX_SIZE;
+	new_truesize = nskbs * SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE);
+
+	remainder = (sub_end - start) % TCP_COLLAPSE_MAX_SIZE;
+	if (remainder) {
+		nskbs++;
+		new_truesize += SKB_ALLOCSIZE(remainder);
+	}
+
+	if (old_truesize <= new_truesize) {
+		start = sub_end;
+		skb = n;
+		goto restart;
 	}
 
 	while (before(start, sub_end)) {
-- 
2.56.0.611.g1030f0b940-goog

