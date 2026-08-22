Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DF1DF980
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386806; cv=none; b=Dv7BQQKgffPx8Xrr1/VoNCQHfexgImHb6kKDTkA8bjDv3zqRHQVS4jM9d4MYtvt2DEE+Xnb84ihVUP8Pfx40na8oWEW8tFQZcdyFhBhrRy33G4EqX/hDZoBAC8Hn1uufDLv3IBwkGGsjtA3XUh0xJ18ToNBYsppg7H5YlaGhHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386806; c=relaxed/simple;
	bh=Que7vWS0ff/mcugy7iYYDvqlqes2YX+MJRhezyALnn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxHmeCzzKFz9YmRFv23zO69d/eUA8d/hL+tdXN60yfZyRpqH986fmnFCKTEnxMpKd1OGAzyynqdArD5XlJx7+6jCJ64dq9dhxrX7xzZEkMbzcbxesTvmGOSYAuCoFPh8kErT49iB/PQEq3BN8ac34AsgjrWk8iBE94qFbOp6qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caea3f742bso29050005ad.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386804; x=1787991604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IXpU5gBxhimOqAaXfWedaBSQtTEfj3qqqpdSicXgXoU=;
        b=m4h8h8S8jNsHE8mD5FiDEBp/qOw7ab+OdstEKV8jLIa1n/48HSH6OLsT+QALmeaPLI
         Rw8hgOxnFn1iTyUIw1XUtO8o2IArTrjY25Y6Ls4Lx79aQttP3EmUOWxjDkHXQ3RP+a2z
         BjawY/vUHnUUEYVDX5hUTdPv6sSqbj5ynXhr4MOa07osVgpCdIlpOkwsuwfWm9+sVb7b
         zP65Ijju1S13mxabdt1Yjp+svtZ9k6dwHITJR31OKuXgpla8Spf3s0v+gkFUNQ39S0mz
         iR8CdNDDSkN3nzjVSnihiwIdOQt4BqBLELFuqxyIqtg2KJHgNbXtmmJr7QNKuwnI9dz7
         IWyA==
X-Forwarded-Encrypted: i=1; AHgh+RrXJA940/kdBXObGsuM0cwj2Yr3ObwfFk4WzC4528p8sKLjFSIIhA9U2TZHe2NX8TamEVTcSbE=@vger.kernel.org
X-Gm-Message-State: AFuF++kNSvkpPJlk0r6UwAmSBIXQmN7N9vWhMx2pmTdwibgegLxfXnWQ
	oaFTnMRK3PZWJqh+0EvZCL8qHMYhF+MboDjHPLkMFyj8Fc0W83luNV4Rb7omc9Lizgm5vhnJv+v
	OoPY7uGOt
X-Gm-Gg: AR+sD13IFUXz/6DSjVXEfRajbMqCAplVRC/sV/N5HptgvszGBfTb6KHsoInCrM9fsaE
	O0OpctQM2TlJNT52tJycK8EzyyumNSQSiKb9NX3WAbA4cqwbXHw/NaxFvJ4AwfIU+27WsWoZvtC
	vWfikftipX3XJSFx9x8WnO3gOa1W6F20GADHwVjg5inHDHv7ZFwTt93DbuUc0xZAP0zOFgjTHhk
	Vq9YsEgDOOZoXHZ1A5hOkaSc4L1WUKzNr7SOMT7VJycLe7z4Ng8GxDz1ci3V0QJQasmPiV+zyzK
	N1duxWGgvBaGqf5KdMDy6xXCB0F1H/7ERqKgEqroydOD2W0Vw/uJDFRO5O7odrCLSg0fgyYN4jV
	ve1NTtQ3gWwatpDa3GYalBv2hnjC4yePpjLh7R0xhdlYGWezTuhdaJ23nVMYIJLWAbfDpY/2cZo
	FJRU+/EmkrDenASfcHXv2aMdwK/4tefE2YfbG+S6WSP8bsQg==
X-Received: by 2002:a17:903:46cc:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d64b162098mr244571005ad.12.1787386804348;
        Sat, 22 Aug 2026 01:20:04 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0de2sm4367453eec.8.2026.08.22.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:20:03 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ncardwell@google.com,
	kuniyu@google.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v6 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Sat, 22 Aug 2026 16:19:46 +0800
Message-ID: <ba3cd75e76ef82b0ff5b393ff9e54056c00e90eb.1787382800.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787382800.git.zhilinz@nebusec.ai>
References: <cover.1787382800.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

request_sock::num_timeout is a 7-bit counter. Commit e6c022a4fa2d
("tcp: better retrans tracking for defer-accept") split this counter
out of an 8-bit field, but tcp_synack_retries still accepts an 8-bit
value and TCP_DEFER_ACCEPT can still derive a retry count up to 255.

If these settings exceed 127, the regular request timer cannot reach
its expiration threshold and num_timeout wraps to zero. After the wrap,
the request can keep timing out instead of expiring, and the next
zero-to-one transition repeats the young-queue accounting decrement.

Both request timer paths can also shift req->timeout by 64 or more while
calculating the next RTO. UBSAN reports that invalid shift, and systems
with panic_on_warn=1 panic before the later cap can take effect.

Keep the tcp_synack_retries sysctl range unchanged, but cap its effective
value in both SYN-ACK timer paths. Cap the TCP_DEFER_ACCEPT conversion at
the same range so its timer and bare-ACK consumers agree. Saturate the RTO
calculation before shifting, and cap the Fast Open extra retry as well.

Snapshot the request timeout and num_timeout once before the bounds check
and shift. num_timeout is a bitfield, so add a raw view of its existing
storage byte for a compile-safe READ_ONCE() snapshot. This keeps the check
and shift consistent when the timer concurrently increments num_timeout.

Fixes: e6c022a4fa2d ("tcp: better retrans tracking for defer-accept")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v6:
- Keep the tcp_synack_retries sysctl range unchanged and cap the effective
  retry count only in the regular and Fast Open timer paths.
- Snapshot num_timeout and timeout once before the bounds check and shift.
- Use a raw view of num_timeout's bitfield storage for the compile-safe
  READ_ONCE() snapshot.
- v5 Link: https://lore.kernel.org/all/9ec8921d81d6218946e07e8542b1ac41b6e2d205.1786540242.git.zhilinz@nebusec.ai/

changes in v5:
- Limit tcp_synack_retries and TCP_DEFER_ACCEPT at their configuration
  paths, so all users of each value see the same 7-bit range.
- Use 127, matching request_sock::num_timeout, instead of the previous
  runtime limit of 63, and document the sysctl limit.
- Spell out the 7-bit range mismatch, the repeated young-queue accounting,
  and the UBSAN panic_on_warn failure mode in the commit message.
- Keep the timeout calculation saturating before either SYN-ACK timer
  shifts it.
- Drop a no-op reqsk_timer_handler() formatting hunk.
- Correct the Fixes tag and update the reporter and sign-off trailers.
- v4 Link: https://lore.kernel.org/all/891a220c362e3266efdf6b1aa9dc3e52f6825c00.1784735392.git.zhilinz@nebusec.ai/

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

 Documentation/networking/ip-sysctl.rst |  2 +-
 include/net/request_sock.h             | 20 ++++++++++++++++++--
 include/net/tcp.h                      | 21 +++++++++++++++++----
 net/ipv4/inet_connection_sock.c        |  2 ++
 net/ipv4/tcp.c                         |  2 +-
 net/ipv4/tcp_timer.c                   |  6 ++++--
 6 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967ee59..fd5038b6cab9f 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -954,7 +954,7 @@ tcp_stdurg - BOOLEAN
 
 tcp_synack_retries - INTEGER
 	Number of times SYNACKs for a passive TCP connection attempt will
-	be retransmitted. Should not be higher than 255. Default value
+	be retransmitted. Should not be higher than 127. Default value
 	is 5, which corresponds to 31seconds till the last retransmission
 	with the current initial RTO of 1second. With this the final timeout
 	for a passive TCP connection will happen after 63seconds.
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 5a9c826a7092d..a9781fab774aa 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -58,12 +58,17 @@ struct request_sock {
 	struct request_sock		*dl_next;
 	u16				mss;
 	u8				num_retrans; /* number of retransmits */
-	u8				syncookie:1; /* True if
+	union {
+		struct {
+			u8		syncookie:1; /* True if
 						      * 1) tcpopts needs to be encoded in
 						      *    TS of SYN+ACK
 						      * 2) ACK is validated by BPF kfunc.
 						      */
-	u8				num_timeout:7; /* number of timeouts */
+			u8		num_timeout:7; /* number of timeouts */
+		};
+		u8		num_timeout_syncookie;
+	};
 	u32				ts_recent;
 	struct timer_list		rsk_timer;
 	const struct request_sock_ops	*rsk_ops;
@@ -74,6 +79,17 @@ struct request_sock {
 	u32				timeout;
 };
 
+static inline u8 reqsk_num_timeout(const struct request_sock *req)
+{
+	u8 num_timeout = READ_ONCE(req->num_timeout_syncookie);
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	return num_timeout >> 1;
+#else
+	return num_timeout & 0x7f;
+#endif
+}
+
 static inline struct request_sock *inet_reqsk(const struct sock *sk)
 {
 	return (struct request_sock *)sk;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b55..b4054aa53b7c7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -183,6 +183,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define MAX_TCP_KEEPINTVL	32767
 #define MAX_TCP_KEEPCNT		127
 #define MAX_TCP_SYNCNT		127
+/* request_sock::num_timeout is a 7-bit field. */
+#define MAX_TCP_SYNACK_RETRIES	127
 
 /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
  * to avoid overflows. This assumes a clock smaller than 1 Mhz.
@@ -882,12 +884,23 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
+						 struct request_sock *req)
 {
-	u64 timeout = (u64)req->timeout << req->num_timeout;
+	u64 timeout = READ_ONCE(req->timeout);
+	u32 rto_max = tcp_rto_max(sk);
+	u8 num_timeout = reqsk_num_timeout(req);
+
+	if (num_timeout >= BITS_PER_TYPE(timeout) ||
+	    timeout > U64_MAX >> num_timeout)
+		return rto_max;
+
+	return (unsigned long)min_t(u64, timeout << num_timeout, rto_max);
+}
 
-	return (unsigned long)min_t(u64, timeout,
-				    tcp_rto_max(req->rsk_listener));
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	return tcp_reqsk_timeout_sk(req->rsk_listener, req);
 }
 
 u32 tcp_delack_max(const struct sock *sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba54838..a5f6ad0f0ea1f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1085,6 +1085,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 			young <<= 1;
 		}
 	}
+	max_syn_ack_retries = min_t(int, max_syn_ack_retries,
+				    MAX_TCP_SYNACK_RETRIES);
 
 	syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_defer_accept),
 		       &expire, &resend);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b6949..24896fa08a5d8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -357,7 +357,7 @@ static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
 		int period = timeout;
 
 		res = 1;
-		while (seconds > period && res < 255) {
+		while (seconds > period && res < MAX_TCP_SYNACK_RETRIES) {
 			res++;
 			timeout <<= 1;
 			if (timeout > rto_max)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb30..daa4eac072dd9 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -462,11 +462,13 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 
 	tcp_syn_ack_timeout(req);
 
-	/* Add one more retry for fastopen.
+	/* Add one more retry for fastopen when the timeout counter can
+	 * represent it.
 	 * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
 	 */
 	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -488,7 +490,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0
