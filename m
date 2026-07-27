Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250242253D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169883; cv=none; b=JYu1y0KIkFmaRnuTdkReb9T2lUj9M6CzMFnS1YLHKuAmX+Crbf9fse0N6ycJqGrCAZtVY6LGQv++8P7D3TfiEb72ZIaCVYmIkUgC/vrnmwxLq4YjxHkPS0PsCDPlmlPigIBzPreYX3rLlLK0jTAEm2wpb7v9dD1p20LNF+Bce3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169883; c=relaxed/simple;
	bh=MRH62yJJB/w81UQkfk3ix41pDrJvXV9I+5bYyi7lLkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqD9zGHpPs4WqrkupQ2OAGzRbWwcCFo/5LQ7MKPkHfaxS965RUia+hPwrp/DILDnqt05B8Famab3srxOchnaZfUSQk0YTaoSrk1aUj22PzMKYHP3ZR5TdpesS+UxqOobMTSWwJ2FTGoziKnYFsnjjy7Iby5Q9X5JXnSvKCHpndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdfDzYmg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdfDzYmg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf27856f9cso37977765ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169881; x=1785774681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoBA3FIDH8AULssFQ6ZZvKIUPXBaltR7llfhh0/h1O4=;
        b=EdfDzYmg+Kd0eBMYOWiSRTxMXegWReIRVNvTn7wWw7/v/cYi0FK1Z7jgVuL4efX6F9
         j/6tLIh84Wf4G+zDDzgdMuhjJJB3Oq8GxsGUHEVcUQPQKkH7NeyG3Yyq2ikhoYzcQ/aV
         UwxyRC7LaqIH28KdZmJ76Jcq8FVush10gpk5476D2/nvEFSvHE/thXIjIEzRYB5meSVM
         hRsGxGCX/CzggUSB4aI12r1tQD8CJIlnPz0qFqB/1k8nCBthz9Nrbmr7QAUai4s6usdx
         WJ3I2eehXoLMcEzCGh/gW5oDwUkfpeynfNJmUTKP7Jvdzd5OAXh1v4khSJ0MsYpYLcBR
         Avug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169881; x=1785774681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YoBA3FIDH8AULssFQ6ZZvKIUPXBaltR7llfhh0/h1O4=;
        b=Tw4jnicXCqBebAm7c9H2CyqVHNZuhTY/x1yLyGh2YAABVMqXhSnyxEEsnqq3gBbiiN
         eYND2O0CXXVgWnz5Z6MGW6wZ4TYiy8mdwA0kW74RISwRYk6lWFc0jgxQsZtSwFVPXGFO
         96qrwedN2TqFd2widBcgEIapB1LJpexVnqFISc3Zoq5izwaz5yl1CC2lAudl1lRnP/qM
         LbrXts0FbpEWj2GA+N3ns8tq6iuNAyE0Coqlj9HTJZj6G87qtICI1Pjr7IupayACyEz6
         0LRIw3RhidVzTiZCHNrs0BEs7D+B4a9747vCgT8PC9nQXd9THUS6PgxN1DCaue6C9dYO
         f4Bg==
X-Gm-Message-State: AOJu0YzmvLVpK+QlGI+CqpVzZAepTKwE7yIHw3LjdLeJJ+JT6QMTOOWQ
	rjX4whIN3j9CEtZ3la3XOROvrGD1AAGEEqrbDKkd2AMLPmJWpTDGNNAAZ8KBtl9lXlo=
X-Gm-Gg: AR+sD10s4L+NBpTKJWsx5xRWHDbKPZidGK0TeUV1idvM69FVCTzGjeATMXmJTv2If51
	g+MM8vV2RFWF3GSCyJ/9mpuzd8dOs7voqcRgIQS8vRz9sZYCGJD4N8TuCX1toySgFLPrG/8dAWm
	KXczdpXGQ2IAIH9KmPNYY8p9+ZpwCssB7fqOcvaqX6XEEtIOLDbeIzeVYkTwY/1Vcme09KDSINW
	UvmXFEsIjuxjotZ71o/jqWEk/U6JUZzGdpNH0TzAtqC0zStXoGqwIF1ntt4g5oolRSSq7p4TeGo
	BzvMREseM4oIfwyiPvtD0O9y5tHyvQollXdvBkXPTgTOmkGJd0BprSe7UeeulQBoRp/QV1w39JH
	BjWxIzgR/R7+9IsMQpnuWdTr9U3dT7UmvQrH8q+TTX/xYnZUHqVGVVOjhxBsip+ayDI52Qa1Jr2
	cEhXCnhCgdneVLN1K4kY6s
X-Received: by 2002:a17:903:4688:b0:2ce:9b49:d4a0 with SMTP id d9443c01a7336-2cfde866f8cmr85832535ad.35.1785169881086;
        Mon, 27 Jul 2026 09:31:21 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e3e0asm37733635ad.29.2026.07.27.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:31:20 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net v4 resend 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Tue, 28 Jul 2026 00:31:10 +0800
Message-ID: <891a220c362e3266efdf6b1aa9dc3e52f6825c00.1784735392.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784735392.git.zhilinz@nebusec.ai>
References: <cover.1784735392.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

tcp_synack_retries supplies the SYN-ACK retry limit used by request
socket timers. The same effective limit can also come from TCP_SYNCNT
through icsk_syn_retries, while TCP_DEFER_ACCEPT can keep an ACKed
request alive until rskq_defer_accept is reached.

The request socket timeout counter is incremented before it is used to
compute the next timeout. tcp_reqsk_timeout() and the Fast Open SYN-ACK
timer shift req->timeout by req->num_timeout. Excessive retry or
defer-accept limits can therefore drive these timer paths into invalid
shift counts before the request expires.

Clamp the effective retry and defer-accept limits in the regular
request socket timer path, clamp the Fast Open retry limit, and make
the request socket timeout helper saturate before shifting. This keeps
sysctl writes unchanged while bounding the timer calculations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
Changes in v4:
  - Drop the tcp_synack_retries sysctl maximum to preserve existing
    user-space behavior, and keep the runtime clamps at the timer usage
    sites.
  - v3 Link: https://lore.kernel.org/all/20260702095324.2995243-1-n05ec@lzu.edu.cn/

Changes in v3:
  - Order local variables in tcp_reqsk_timeout_sk() by reverse Christmas
    tree.
  - v2 Link: https://lore.kernel.org/all/20260630035009.55201-1-n05ec@lzu.edu.cn/

Changes in v2:
  - Keep the existing max_retries calculation in
    tcp_fastopen_synack_timer() and only add the clamp, avoiding code
    churn.
  - v1 Link: https://lore.kernel.org/all/02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com/

 include/net/tcp.h               | 19 +++++++++++++++----
 net/ipv4/inet_connection_sock.c |  6 +++++-
 net/ipv4/tcp_timer.c            |  3 ++-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..ee78436b8964 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -183,6 +183,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define MAX_TCP_KEEPINTVL	32767
 #define MAX_TCP_KEEPCNT		127
 #define MAX_TCP_SYNCNT		127
+#define MAX_TCP_SYNACK_RETRIES	63
 
 /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
  * to avoid overflows. This assumes a clock smaller than 1 Mhz.
@@ -882,12 +883,22 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
+						 struct request_sock *req)
 {
-	u64 timeout = (u64)req->timeout << req->num_timeout;
+	u32 rto_max = tcp_rto_max(sk);
+	u64 timeout = req->timeout;
+
+	if (req->num_timeout >= BITS_PER_TYPE(u64) ||
+	    timeout > U64_MAX >> req->num_timeout)
+		return rto_max;
+
+	return (unsigned long)min_t(u64, timeout << req->num_timeout, rto_max);
+}
 
-	return (unsigned long)min_t(u64, timeout,
-				    tcp_rto_max(req->rsk_listener));
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	return tcp_reqsk_timeout_sk(req->rsk_listener, req);
 }
 
 u32 tcp_delack_max(const struct sock *sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5483..b74212bae3dd 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1056,6 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	net = sock_net(sk_listener);
 	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
+	max_syn_ack_retries = min_t(int, max_syn_ack_retries,
+				    MAX_TCP_SYNACK_RETRIES);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
 	 * If synack was not acknowledged for 1 second, it means
@@ -1086,7 +1088,9 @@ static void reqsk_timer_handler(struct timer_list *t)
 		}
 	}
 
-	syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_defer_accept),
+	syn_ack_recalc(req, max_syn_ack_retries,
+		       min_t(u8, READ_ONCE(queue->rskq_defer_accept),
+			     MAX_TCP_SYNACK_RETRIES),
 		       &expire, &resend);
 	tcp_syn_ack_timeout(req);
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..bbedf2b9e1bc 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -467,6 +467,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 */
 	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -488,7 +489,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0
