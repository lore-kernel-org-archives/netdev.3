Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628870;
	b=Kmc6Jno0IlvjRaa0pFm9D8rdjbkdx1ML2UNi4dqwe7/HX/S5qRfpZOB0GsDL/ZSy2YnI
	 4hXC9/1g2fmYxeu7oN8NrPzYDMnK1phCvZ2l+4lzwgAT7a7xipGaPtMbnzveRTVO13Vij
	 6xHV/ivxoaXserChTaklhKbYt0fbv4XUNL0gcRYx5tKDHHvPTPzXxZhZh8LAhD9AlypWO
	 22czw9KLyVXGwmkvqEaUZkTUVVA4KuC8Oyej70jFUG/235EjGy0GYzXNTTxCYMsLuHC0F
	 9am7KABEW+jVrwR50IY2bzQTlYkswhg/snp27S6uPJALh4SSEH6VGLN9KOlSZT1ZWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ICaWdcmZM/SOor8gQAvznooFYxuJag18RMXRZ2jewMI=;
	b=qInz4vaDHL3d8j5cQowkOxc7sCNK7wGfdQCFkuhDLL1qFNHpdz05pmiWxApi9AWVYbCt
	 z61i5MzdGy2dyfHxb0sLRYd+THi0IY6SGYygwOtSRUrckRv9umvV06VfKTfCjHwMuXngj
	 Z40nwRUyurXHUpR1HYRAVMo6ugUudFWCau5NNCpTh3F39jsEuoDeJDhq1YCSfMk8gde/z
	 SIUiKod0phqs7cDhWKNWOdES+P8OmS6YkpFMTAODQC5AAZ4emDI0WmtElfawACSpL9wxm
	 OfBekAJnAm+SAeAdoiaHpoYLWyco+8c2z4Zs5IF73FPDp7Sq8n9WcMOtDAXfh8RJThg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y7mwpcEp;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78D606A8A7
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA78D606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y7mwpcEp
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b07b06027eso2231943a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628869; x=1795233669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ICaWdcmZM/SOor8gQAvznooFYxuJag18RMXRZ2jewMI=;
        b=Y7mwpcEp/iIEkrOnZSlhnXcpha9eJ5eB1vRyoSZAJzgZq5KhpPtWOg8k8/7MeWi8MH
         jsyefSpkQePJtNhdMoAnE+SkIiyR12yBSJRwXIqfVo5x0NlH8KUuH8acewTArpHkCuhd
         O0eJ3tb3GwpZuq0f3aItf0BuA/Av8f2Yu3RJqNKmeJH1DvLJY9OjXVG5g1ZjiwhzomKa
         uizgs/nX2Zi9Ep8xXsyJo+T000cfjwjBaG12uhEDxnljNDt8RJbwnDneiSdTX3QkNnsu
         EKl2y2waLcjuQ+UdOAlxAsQvu5ey0qh3GRWSAYpKosuia9I/IunmbkXjROQXbDminixz
         +mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628869; x=1795233669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ICaWdcmZM/SOor8gQAvznooFYxuJag18RMXRZ2jewMI=;
        b=frt1A+Mpuki3yA0cavB+WHwbJaSIjuu9NwuqtFlwVIVQp/RnZgh8H8ldrf/ByZuxRV
         7yUGTrUR6S6is4LX4hFmX/F/BzZB1UEFLO5l4v28JX3NsL3FyQ0VzQuFrlhuLYJgHQnW
         MMo1E9kovic5gr8H0MFAZSF1mhQigLQmbaela7j69EHXx1wj35G0YTJyA3SjVq6myTQK
         +2f7ds+ZvGkRVpOrMyiT0tACyfEYC/UN8sskB6bNL1mrZCBU3DMBMHjGIFruL2gUbB+q
         E1e15zpjXF7mwXkS5DofguI3fcXWAEaBzBqESzbjILehD15RJoXwV1Led357tdwpBIsK
         JZag==
X-Forwarded-Encrypted: i=1; AL+hErG7wot78YZX3WAAvt+LeKuBoYzpmmnsOCVt87hy5Mtw6uYYCQGhOUb0Rm6Jr/XNmrctdIi3ehk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lAep6huKOHdAW6HurXMZhh1bBToXPxoINLkhN16OdyZlyB1DO
	gA+ormo9T9rhjuUDGG+Art/SfQj3uuMew+IMwbQve6LgKpO78qzm8dh6OKLZEVbOxxroKyij6tK
	WPY1xUg==
X-Received: from pgcgn26-n2.prod.google.com ([2002:a05:6a02:6a1a:20b0:cd8:baff:81d8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5548:b0:3a4:adea:50ad
 with SMTP id 98e67ed59e1d1-3b1b09fcbd0mr4327349a91.27.1794628868921; Fri, 13
 Nov 2026 20:01:08 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:50 +0000
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
Message-ID: <20261114040101.1043546-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 7/8] tcp: Batch memory accounting in tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once tcp_collapse_one() calls sock_rfree(), skb->truesize is
reclaimed to sk->sk_forward_alloc by sk_mem_uncharge().

However, sk_mem_uncharge() rounds down sk->sk_forward_alloc
immediately once it reaches 4K since commit 4890b686f408 ("net:
keep sk->sk_forward_alloc as small as possible").

This unnecessarily reclaims memory for newly allocated skbs,
and the following skb_set_owner_r() for them underflows
sk->sk_forward_alloc without sk_forced_mem_schedule().

Let's cache the delta during tcp_collapse() and batch accounting
at the end.

Then, we no longer need sk_forced_mem_schedule(), and instead
DEBUG_NET_WARN_ON_ONCE() is added to catch a future issue.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9f32577b0b53..598463f33987 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5822,6 +5822,24 @@ static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
 }
 
+static int tcp_collapse_uncharge(struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor != sock_rfree);
+
+	skb->sk = NULL;
+	skb->destructor = NULL;
+
+	return skb->truesize;
+}
+
+static int tcp_collapse_charge(struct sk_buff *skb, struct sock *sk)
+{
+	skb->sk = sk;
+	skb->destructor = sock_rfree;
+
+	return -skb->truesize;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5857,6 +5875,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	int remainder, nskbs;
 	struct sk_buff *nskb;
 	u8 scaling_ratio;
+	int released = 0;
 	u32 sub_end;
 
 	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
@@ -5874,6 +5893,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+			released += tcp_collapse_uncharge(skb);
 			skb = tcp_collapse_one(sk, skb, list, root);
 			goto restart;
 		}
@@ -5959,11 +5979,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
-		/* nskb is charged before the skbs it replaces are freed.
-		 * Make sure sk->sk_forward_alloc can not become negative.
-		 */
-		sk_forced_mem_schedule(sk, nskb->truesize);
-		skb_set_owner_r(nskb, sk);
+
+		released += tcp_collapse_charge(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
 		/* Copy data, releasing collapsed skbs. */
@@ -5987,6 +6004,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				start += size;
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+				released += tcp_collapse_uncharge(skb);
 				skb = tcp_collapse_one(sk, skb, list, root);
 			}
 		}
@@ -5998,6 +6016,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		tcp_rbtree_insert(root, skb);
 
 	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
+
+	if (released) {
+		DEBUG_NET_WARN_ON_ONCE(released < 0);
+		atomic_sub(released, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, released);
+	}
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.0.611.g1030f0b940-goog

