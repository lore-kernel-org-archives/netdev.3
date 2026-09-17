Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8065172D5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665661; cv=none; b=BHZlvhNcOQiBsQ8gaykqQcr/iHvmwhZKdwXZv0OVTjMFq8tZa2dHmEO49vktr3+0uU4OVhO2YX7o3nzJguUBuLPd3rDh915m7UfZBX4a9gWE7Jwv7RSNgaKrQ/8Jhy0bEUk1cPecdQe3jy6UzujdFPM1QFkkuajGtHUaJQeNVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665661; c=relaxed/simple;
	bh=nw/J8VcrReR5owald09pjVvypGmieOinjLIHRZM4tdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcvHyd/+q1B77+RlMPy2tKjaekaiJQzg9ToLx6tARnlDCX/sN58mzRdU4Ptzo50Qx9LGqK4tLtdgZNnXrJ20/Nfu+3E92vZeC/BTpId9oO2eceZfFkvwdN3RKhSlwgcF12nwHKyX6cjR+7E+qVA9LWSuMkPLgu0ftZo8tICwcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=kFMKOhT7; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="kFMKOhT7"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c2613d80fbso706248eaf.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1789665656; x=1790270456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R8vkCTDwduZBUtVdBbRq+qNyuVRxzowW3egmXOkgxJ4=;
        b=kFMKOhT7rXGu4MCDGVq45NIpzfI2jGF0kZGnQIKVoVr94XQ9ZXsXwHtVSHoTJhfHZK
         F7dSEP7vJWwI/bBajyC8R/hw8F/3DHlZqh7T/+1cIQ9y9lkZFZJmn0MaCJ3jQL3sGtyG
         w4bHEpKOdODtfqtCF469vdcSiO0kdBidq3/oF35M/317FEvAawxseebzU1AkmXCxbR90
         KPaL+8DPWF8XaVQV3o5VcFroTJQDgjrhGLO4pdKgjBhgq1qtriu1JajDSBG8UiumDStQ
         AQhwJhxpIlXwoCXLFJ6kb/UEo6IVXY8P25JwNiftadalfiN0T4vMJVikoxsHBU3zeotz
         ND5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665656; x=1790270456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8vkCTDwduZBUtVdBbRq+qNyuVRxzowW3egmXOkgxJ4=;
        b=eNfFKMKwlKDNjsYJsc675+UlpqR2ZCkWMlCWm6/KK6Rtrw/aORqj2KicGKlgDlaI/I
         8vzhLourbB+oIyP3sRvGgKBnr5C5X8zSpNTSO1QPXrM4pIWQYpUWKfN2+yvT8eB1IaJ2
         bhIHvoInZ5K78DjSKVhT2BhlbEH2xEEqnXTZyJQ0gGh+fM4u88xow/oSkz1yxODHpES5
         1lXmvmbYuZJ5W6dJeDxhphd0JOZgT1uEKuRBc9HtImRTvOo8gHKbjr37V25THwOU5x9A
         9j252xQz72TpN+wyRYb00CzWowkiXOX6ApQFNYaYJDiiTpYvDa8VJ0w6C/PcPf6Nv9/r
         k6xw==
X-Gm-Message-State: AFuF++m4K7G8ug9p0HlOtXLlZ96+TYz+eW8FFb4zfYCYTEZsJqYO/KXh
	q50WqzS+4sXaYyjhhpi/aLucEMkW4im2kJICoMcG+dCScxNuhuw3OvKeknoCCI08V4iqiCnm90t
	lElIA
X-Gm-Gg: AYBFou1/3VRbanxLxHtR2jhdajhJtRxnzuiMuGGjkn7Fj1i7kwdy7ObrvfatENxC7fZ
	5MEOOAVKP35dQ8YLLhaqlvStemiOIEkYBOSwD/FT3v7JdAPa7oSheZiyWjkvrw84GbjN2Eqd28U
	VjJ2okEV9je2/dY+uoSPPT5xmWW1I85JVRAv0aARdD4dh6WXvpOLIQ2Mhr9MBxLFtH1/WHGYKdV
	K5H3ddezdpQ6uwmMZrbT2Yw8W6Vai35PMq0MkNaeBugdT52U/vm98vGTVSe6YLs7ognXa+Q2mlo
	yPC7fs+elYReDkAe55wqO79+Q0FLwNI/MR7LuWO6Ghv0EEoArqYfDvHtqkJfB32xWQm4ntT9QhH
	qQC/8wIYT5YAyJxfaXcPOWqRfBVx2x1C3dlbHAjGqjQ0G+Xvw81knv5t1p0KeUAcoGf0KIYUfXS
	/BER08BMNq+2AfgOA8L2Pe0HPODW/FXEqHAGosz88OU3rpZgWGmVfKNXbhF1RikL0NwvufVJPRt
	HINvCEmhp1fmIK2jg==
X-Received: by 2002:a05:6820:c2c1:10b0:6c8:fb02:527e with SMTP id 006d021491bc7-6c8fb025440mr3198729eaf.39.1789665656434;
        Thu, 17 Sep 2026 10:20:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:19::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-486abe0e884sm442239fac.15.2026.09.17.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:20:55 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH net v2] tcp: prevent stale tx timestamp keys on rtx fallback
Date: Thu, 17 Sep 2026 10:20:50 -0700
Message-ID: <20260917172050.2191062-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_tx_timestamp() can select skbs from the rtx queue when all the
copied data has been sent in tcp_sendmsg_locked(). These skbs may be
already cloned, sharing the same shinfo, and handed off into the lower
tx layers.

tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing with
any reader of both. It is possible to observe a valid tx_flag, but an
uninitialized tskey, which produces a large underflow after subtracting
the socket tskey.

Reorder the writes in tcp_tx_timestamp() and
bpf_sock_ops_enable_tx_tstamp() to write the tskey first, followed by
publishing tx_flags via store-release.

Readers perform a symmetric load-acquire on the tx_flags, followed by a
relaxed read of tskey.

Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
Assisted-by: LLM
Signed-off-by: David Wei <dw@davidwei.uk>
---
v2:
 - switch from pre-setting tskey to reordering tskey/tx_flag

 include/linux/skbuff.h |  3 ++-
 include/net/tcp.h      |  6 ++++++
 net/core/dev.c         |  2 +-
 net/core/filter.c      |  8 ++++++--
 net/core/skbuff.c      | 27 ++++++++++++++++-----------
 net/ipv4/tcp.c         | 11 +++++++----
 net/ipv4/tcp_offload.c | 16 ++++++++++++----
 net/ipv4/tcp_output.c  |  6 ------
 net/socket.c           |  4 ++--
 9 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..489eeb4eb390 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4776,7 +4776,8 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 static inline void skb_tx_timestamp(struct sk_buff *skb)
 {
 	skb_clone_tx_timestamp(skb);
-	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
+	if (READ_ONCE(skb_shinfo(skb)->tx_flags) &
+	    (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		skb_tstamp_tx(skb, NULL);
 }
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b89a3..cc7f78b5cca3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1159,6 +1159,12 @@ struct tcp_skb_cb {
 
 #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
 
+static inline bool tcp_has_tx_tstamp(const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->txstamp_ack ||
+		(READ_ONCE(skb_shinfo(skb)->tx_flags) & SKBTX_ANY_TSTAMP);
+}
+
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a..172ebab5d38f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4828,7 +4828,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags &
+	if (unlikely(READ_ONCE(skb_shinfo(skb)->tx_flags) &
 		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..ed6396704e11 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12602,7 +12602,9 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
+	struct skb_shared_info *shinfo;
 	struct sk_buff *skb;
+	u8 tx_flags;
 
 	if (skops->op != BPF_SOCK_OPS_TSTAMP_SENDMSG_CB)
 		return -EOPNOTSUPP;
@@ -12611,9 +12613,11 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 		return -EINVAL;
 
 	skb = skops->skb;
-	skb_shinfo(skb)->tx_flags |= SKBTX_BPF;
+	shinfo = skb_shinfo(skb);
+	WRITE_ONCE(shinfo->tskey, TCP_SKB_CB(skb)->seq + skb->len - 1);
 	TCP_SKB_CB(skb)->txstamp_ack |= TSTAMP_ACK_BPF;
-	skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	tx_flags = READ_ONCE(shinfo->tx_flags);
+	smp_store_release(&shinfo->tx_flags, tx_flags | SKBTX_BPF);
 
 	return 0;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9648782fe8cb..25ca82eb6cdb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5601,7 +5601,7 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 	serr->opt_stats = opt_stats;
 	serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
 	if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
-		serr->ee.ee_data = skb_shinfo(skb)->tskey;
+		serr->ee.ee_data = READ_ONCE(skb_shinfo(skb)->tskey);
 		if (sk_is_tcp(sk))
 			serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
 	}
@@ -5652,6 +5652,8 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 	 */
 	if (likely(refcount_inc_not_zero(&sk->sk_refcnt))) {
 		*skb_hwtstamps(skb) = *hwtstamps;
+		/* Order the tskey read after observing timestamp flags. */
+		(void)smp_load_acquire(&skb_shinfo(skb)->tx_flags);
 		__skb_complete_tx_timestamp(skb, sk, SCM_TSTAMP_SND, false);
 		sock_put(sk);
 		return;
@@ -5663,19 +5665,20 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
 static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
+						 u8 tx_flags,
 						 struct skb_shared_hwtstamps *hwtstamps,
 						 int tstype)
 {
 	switch (tstype) {
 	case SCM_TSTAMP_SCHED:
-		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
+		return tx_flags & SKBTX_SCHED_TSTAMP;
 	case SCM_TSTAMP_SND:
-		return skb_shinfo(skb)->tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP_NOBPF :
-						    SKBTX_SW_TSTAMP);
+		return tx_flags & (hwtstamps ? SKBTX_HW_TSTAMP_NOBPF :
+						      SKBTX_SW_TSTAMP);
 	case SCM_TSTAMP_ACK:
 		return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
 	case SCM_TSTAMP_COMPLETION:
-		return skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP;
+		return tx_flags & SKBTX_COMPLETION_TSTAMP;
 	}
 
 	return false;
@@ -5718,20 +5721,23 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
 	u32 tsflags;
+	u8 tx_flags;
 
 	if (!sk)
 		return;
 
-	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+	tx_flags = smp_load_acquire(&skb_shinfo(orig_skb)->tx_flags);
+	if (tx_flags & SKBTX_BPF)
 		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
 						      sk, tstype);
 
-	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
+	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tx_flags,
+						  hwtstamps, tstype))
 		return;
 
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
-	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
+	    tx_flags & SKBTX_IN_PROGRESS)
 		return;
 
 	tsonly = tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
@@ -5760,9 +5766,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (tsonly) {
-		skb_shinfo(skb)->tx_flags |= skb_shinfo(orig_skb)->tx_flags &
-					     SKBTX_ANY_TSTAMP;
-		skb_shinfo(skb)->tskey = skb_shinfo(orig_skb)->tskey;
+		skb_shinfo(skb)->tx_flags |= tx_flags & SKBTX_ANY_TSTAMP;
+		skb_shinfo(skb)->tskey = READ_ONCE(skb_shinfo(orig_skb)->tskey);
 	}
 
 	if (hwtstamps)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 562752352afe..ec4ee5e5d2de 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -483,18 +483,21 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
 
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
 		skb = skb_rb_last(&sk->tcp_rtx_queue);
+		if (skb && tcp_has_tx_tstamp(skb))
+			return;
+	}
 
 	if (tsflags && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
+		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
+			WRITE_ONCE(shinfo->tskey, tcb->seq + skb->len - 1);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack |= TSTAMP_ACK_SK;
-		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
-			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 	}
 
 	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e74d99ca9fac..73344cdf8e16 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -16,13 +16,20 @@
 static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
-	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
-	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+	struct skb_shared_info *shinfo = skb_shinfo(gso_skb);
+	u32 ts_seq;
+	u8 flags;
 
+	/* Pair with timestamp request publication before copying tskey. */
+	flags = smp_load_acquire(&shinfo->tx_flags) & SKBTX_ANY_TSTAMP;
+	if (!flags)
+		return;
+
+	ts_seq = READ_ONCE(shinfo->tskey);
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
+			skb_shinfo(skb)->tx_flags |= flags;
 			return;
 		}
 
@@ -198,7 +205,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+	if (unlikely(READ_ONCE(skb_shinfo(gso_skb)->tx_flags) &
+		     SKBTX_ANY_TSTAMP))
 		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 00417a429222..7bab67f5d327 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1795,12 +1795,6 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
 	tcp_verify_left_out(tp);
 }
 
-static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
-{
-	return TCP_SKB_CB(skb)->txstamp_ack ||
-		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
-}
-
 static void tcp_fragment_tstamp(struct sk_buff *skb, struct sk_buff *skb2)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
diff --git a/net/socket.c b/net/socket.c
index c05d86e63abf..d16e1f491f15 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -766,7 +766,7 @@ EXPORT_SYMBOL(sock_release);
 
 void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 {
-	u8 flags = *tx_flags;
+	u8 flags = READ_ONCE(*tx_flags);
 
 	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
 		flags |= SKBTX_HW_TSTAMP_NOBPF;
@@ -780,7 +780,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 	if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
 		flags |= SKBTX_COMPLETION_TSTAMP;
 
-	*tx_flags = flags;
+	smp_store_release(tx_flags, flags);
 }
 EXPORT_SYMBOL(__sock_tx_timestamp);
 
-- 
2.53.0-Meta

