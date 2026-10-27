Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106382;
	b=0ms582Hv+amlVz9+oWy92xzhZvS0NXiolruM6bTLmuaTNxwzz87fTbmKmh+je7LHy3If
	 0PkOsuR/8gOiOflQF2G1yUYAVmwJIEpVEZqn0zpYT0jP8y9Qri1ZR6PQkKKmYMldFotLJ
	 +Hfl06+CB32/VS++5dIyf/hpJe/7ecIV5l0Ne3EBE+E6aIpazzRIXbiEhf5Z6TdJKgevh
	 t1NDIV8qwbk0R7i5Q/JsSZ/Vu/6TejkN2g71W3OwFm2QwpGvORAKC3LBXLCnDhzV2/Uv7
	 i7rsDYl6IuLfHYbv/0O77ogMZ88deHKVjCw6IRk2NHcAl2dZu6jn4q+LDFGmriTAdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7uGiIIsGwotu1dNVo2fGPdi4w1b/0QD6iVQaceH2QM0=;
	b=oVCrMHzAAP11pYgNNwKY4xxYIKV8pcXCQxFtaOLT58++U2Ly93cAR9SKkv4N+pdjrqSr
	 QqZidDxw5UxBCzDkXYeOxJvFxRdvS7rBhJ1bB6RyDdRpTojnppiVTqrce1/Wt8vQBr8h1
	 YhaaIh7CNq2QPF0c++e+3qs9EO/g8Vlc16NhEWxg9S1PoI7MiSMjLIcjyA+406DeoFV+i
	 XAq8r7mUFatXTPEPfaAl5n+AfUc8aGWqSK+/OygJGvXBBUp33YciynWDUXBwMM3zusuqC
	 A2aOHv3WJoHPh1p+3pr0Qn1ezEgzDkj5/4yliClf48vEqMQvPxqmJLU5gYe+OjFjs2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jbm2Qmrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5F606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jbm2Qmrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442291F01829;
	Tue, 27 Oct 2026 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106382;
	bh=7uGiIIsGwotu1dNVo2fGPdi4w1b/0QD6iVQaceH2QM0=;
	h=From:To:Cc:Subject:Date;
	b=Jbm2QmrrCy2awObRjp/fjZ25opWWkzo+70hj+nxrqoJAqwevfK/gYQjdvE1Ljb0rd
	 oIHSw77vh8Hk717TN28xQCOqki5c9UKtMTOzKcQ4SDhKyjR/lUtkP7uyRJgfCos/9d
	 ++Q9iNHAnyuTGy8Fu3LxePNmu+XOuLJC4GKJLNuEufRkw3AaqFPIbUnfaXs/pViONn
	 QHpizXO8npe3FqXiXEA3WnBNCdl8uZWwW0ILdCJ2iMo+eqCCSzh7e6CqxLA45xez4K
	 jqn+tmJ5MdHzRyK7rUP7uXGx8PWmuy6DOtzUt/RNswXrVGLnJp5CKQPipXiNIigYdy
	 xQLv/1PCAYXlw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Chris Mason <mason@kernel.org>
Subject: [PATCH net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
Date: Tue, 27 Oct 2026 14:06:17 +0100
Message-ID: <20261027130617.1550253-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_cwnd has no practical upper bound: snd_cwnd_clamp defaults to ~0,
and RTAX_INITCWND, a locked RTAX_CWND metric, TCP_BPF_IW and
TCP_BPF_SNDCWND_CLAMP accept any positive value.

Congestion control modules do u32 arithmetic on cwnd that assumes
much smaller values, and can misbehave if cwnd gets too big.

The paths that can grow cwnd by large amounts (tcp_slow_start(),
tcp_cong_avoid_ai(), bbr_set_cwnd() and tcp_init_cwnd()) already
bound it by snd_cwnd_clamp, so give snd_cwnd_clamp a finite default
of 2^24 packets, and cap the metric and BPF paths that set it or set
cwnd directly.

2^24 packets is more than 24GB in flight with a 1448 byte MSS, well
above what any sk_sndbuf allows.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/tcp.h      | 6 ++++++
 net/core/filter.c      | 3 ++-
 net/ipv4/tcp.c         | 2 +-
 net/ipv4/tcp_metrics.c | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0265c27a5fd77df8a86991e364ec7caff3a7ea0d..be1609cd78840cfb1da75517273be0d64f4c3981 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1553,6 +1553,12 @@ static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
 
 #define TCP_INFINITE_SSTHRESH	0x7fffffff
 
+/* Default and maximum snd_cwnd_clamp, in packets.
+ * Far above any usable BDP, but low enough that congestion control
+ * arithmetic such as 100 * cwnd in CUBIC cannot overflow a u32.
+ */
+#define TCP_MAX_SND_CWND	(1U << 24)
+
 static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 {
 	return tp->snd_cwnd;
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2e9fccd9cf54808e002ff0f82da62..63bb314e8697db81ecef3a0b3dcf4fed85ac79fa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5562,11 +5562,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	case TCP_BPF_IW:
 		if (val <= 0 || tp->data_segs_out > tp->syn_data)
 			return -EINVAL;
-		tcp_snd_cwnd_set(tp, val);
+		tcp_snd_cwnd_set(tp, min_t(u32, val, tp->snd_cwnd_clamp));
 		break;
 	case TCP_BPF_SNDCWND_CLAMP:
 		if (val <= 0)
 			return -EINVAL;
+		val = min_t(u32, val, TCP_MAX_SND_CWND);
 		tp->snd_cwnd_clamp = val;
 		WRITE_ONCE(tp->snd_ssthresh, val);
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 76df69aa01154cddd4c7940f3c3749d04487ae7b..a11c1b06ed5e5591c47f585a3f9e4fba4de30153 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -456,7 +456,7 @@ void tcp_init_sock(struct sock *sk)
 	 * initialization of these values.
 	 */
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
-	tp->snd_cwnd_clamp = ~0;
+	tp->snd_cwnd_clamp = TCP_MAX_SND_CWND;
 	tp->mss_cache = TCP_MSS_DEFAULT;
 
 	tp->reordering = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reordering);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index d58f99c67d4dc0877d0e853c9e9faddd80343c22..ae551546422fe7c38b2ac3224f9ea9adbd3679d0 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -495,7 +495,8 @@ void tcp_init_metrics(struct sock *sk)
 	}
 
 	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
-		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
+		tp->snd_cwnd_clamp = min(tcp_metric_get(tm, TCP_METRIC_CWND),
+					 TCP_MAX_SND_CWND);
 
 	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
 	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
-- 
2.53.0

