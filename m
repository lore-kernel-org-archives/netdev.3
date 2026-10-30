Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358933;
	b=cXCevO470A6bR1NL71/5BEdl55TlgI0fjSng8ZsyZegyMgcHF2wTPRr3rZgFqm+bLhMK
	 Ee2WudXNSYCN3VZYQ2Ro8zxFd5qjlk1W/CzR+kU4NayGFnbB+oDWCGfBGUloyNyRXGD0C
	 z25b3/fN9uYzSXeddodg7IWMMSB3qcbNbf6L+rlIncB26JWxsWUA1k0cRxn7q/yJ+jhEL
	 WNtHmw22e2qx5Z4wn95nzqwiizR5FQAfLHck0xiOxkRH1RDuG7HNTjOfbHBW80EqO8F9h
	 3WUDj1Ar7hKffPv2b/qtHDXgRNlYNsBbM5IYHce1n2CtcLMOit/+qxRWZwR9iM8wkew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NgFw98abvJpGmoFM42LssdatIt/oCiwXS2s4Oiwx1Hw=;
	b=Sd5oNJUOIwd0UDX4yJNTRhvSMnZ7WDRSrh9tHoeUNtv+aBrR0PNgwL7ckhQb5pcjLYD6
	 9ogGD93fTMcTrYF4VPzY48dz8s27WkkDx29SblA9d7s150lMXMGYXsGzW8m486abfI+0G
	 8Ocou4JEsVMeky/YV0oX+LkEklVuj3zwIpWynxPa2sjAsUslkpma6L1tYUukRQ7v0LAPH
	 9wwhfBiIkNpQ+pRyWZuU+wMJYiytNjAPYYGGGilV1blKi88BeAzNCmFL90ym/BFamOmBp
	 MAIVBelVXbBw266Tw6vUmS78f7D5MOSKXXgOUucLRoOdsiw800YN0yIiMph+Iv4zVdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrTedrC2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8199606A32A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrTedrC2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340131F00A1B;
	Fri, 30 Oct 2026 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358932;
	bh=NgFw98abvJpGmoFM42LssdatIt/oCiwXS2s4Oiwx1Hw=;
	h=From:To:Cc:Subject:Date;
	b=FrTedrC2uWyL/PbBqEeLSHS3lIWNsYWgno9kI5pZNHQaexgO0RXghtE6xL079tf4W
	 Gw1DiLVBQU8pdMWL5cMsVDjlFPwJzNL6I5Z51WEqYCNP+LYuXNPx967Ni9ko5OEzfh
	 YdFdsBsKWLhKI9VAfRc1jCE5SxOanoxpYiI9iJ3KGG0Ut209s2g6whbvuqGntJtPNw
	 MgxI9taD53Y+QRb/3ypbFoQJzbTd4qKaL1wpJfjtPdIaoRSoZ0WNba2Btk/o8vQW/D
	 XacvIL9KaoQFgkI125TynTG0wRHMZXMu3KExSQJChcQHfIRH6Ka/bIK83ytK/R+z3Y
	 +PNwn0q8SxYTA==
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
Subject: [PATCH v2 net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
Date: Fri, 30 Oct 2026 12:15:28 +0100
Message-ID: <20261030111528.2850082-1-edumazet@kernel.org>
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
much smaller values. For instance, ssthresh() handlers compute:

  CUBIC, BIC, ROCCET:  cwnd * (BICTCP_BETA_SCALE + beta), up to 2047
  DCTCP:               cwnd * dctcp_alpha, up to 1024
  CDG, NV, CUBIC, ...: cwnd * beta, below 1024

With a large initcwnd route or TCP_BPF_IW, cwnd is set directly to
such values, and the next RTO or recovery calls ->ssthresh() with it.
The product then wraps: DCTCP with cwnd = 2^24 and alpha = 1024 gets
ssthresh == cwnd, and CUBIC computes a wrong ssthresh and Wmax.
CUBIC bictcp_update() also expects cwnd below about one million packets.

The paths that can grow cwnd by large amounts (tcp_slow_start(),
tcp_cong_avoid_ai(), bbr_set_cwnd() and tcp_init_cwnd()) already
bound it by snd_cwnd_clamp, so give snd_cwnd_clamp a finite default
of 2^20 packets, and cap the metric and BPF paths that set it or set
cwnd directly.

2^20 packets do not limit real flows: with the maximum window scale
of 14, a peer can not advertise more than 65535 << 14 bytes (~1GB),
which is less than 2^20 packets for any MSS of 1024 bytes or more.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2: lower TCP_MAX_SND_CWND to 2^20 to cover CC ssthresh() products (Sashiko)
v1: https://lore.kernel.org/netdev/20261027130617.1550253-1-edumazet@kernel.org/

Chris found the bug thanks to an LLM. A repro can confirm it.
---
 include/net/tcp.h      | 9 +++++++++
 net/core/filter.c      | 3 ++-
 net/ipv4/tcp.c         | 2 +-
 net/ipv4/tcp_metrics.c | 3 ++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821544d260bcf07cdd8a4d280c0ff36..5c9203aae83417d75bfe520cfdbecff36a15a057 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1554,6 +1554,15 @@ static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
 
 #define TCP_INFINITE_SSTHRESH	0x7fffffff
 
+/* Default and maximum snd_cwnd_clamp, in packets.
+ * A peer can not advertise more than 65535 << 14 bytes, so a larger
+ * cwnd is useless with any MSS of 1024 bytes or more.
+ * Congestion control modules multiply cwnd by u32 factors up to 2047
+ * (cwnd * (BICTCP_BETA_SCALE + beta) in CUBIC), and CUBIC's
+ * bictcp_update() expects cwnd to stay below about one million packets.
+ */
+#define TCP_MAX_SND_CWND	(1U << 20)
+
 static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 {
 	return tp->snd_cwnd;
diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82abe8fc188c8f68059691cdcb52fb4..96f9ba67095a286b8973cbc198adf8da18af1b16 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5590,11 +5590,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
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
index b9de7c302ba83acfcb9cc6a2a2f67362277386b6..876f3e5f34c07f3af592d49e79d48eed3fc5d61c 100644
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

