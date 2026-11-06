Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972273;
	b=PqIcY0+xE+cSuNH+6CwALJVsxFnNF8NUPPZ1VhxaoHU4Ppjx/STEkoGTVURawdbgLwQN
	 yOrgzYNmvsphGwzyVTpfQA4S6V/Sn7++Mk2/LKt1NftqE2KebH4EVOH2BWQcTlOrMADCR
	 ax9rd/mvogLmSSrZixNRfxQXPHduPx6AtNXQVYUmrbMLe/wK+z64FitVNF4fdhqUuh0GW
	 qrde4xFm98ItKQ7T8kOyc23E/yGHrTmt8qnVl6cWU2fYAs4GdhtmcblIt2XawVNGdHKaz
	 prdhjgi5kOmsIykt8L7Q4V576u0/ifvd3ZAGMT8S/F7j2bO9FchupZoS+MGRxDQyLrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RulP2pumuJDdQ6qGczFOD8MSveffDIBuVeKLG1nOIoE=;
	b=SEpD8LQd0YyryClxAenTGfw8xhq10lhSsOe70c1KOhg6aRcLr7SC2naEDbK1c5vjKnfO
	 TndL1FhoDN0c/dC+q63A4a/9T8w41NxbjrCJ7+df6IOoYEAau/fXshYpxp3u5erM2VRFA
	 p0KUOweWWj7orvuDWAo7IyEKL0oE16Mw26kE4Uv0l7BTb9raIwG9mDle049QPwDSo1sMx
	 Ao77bI710M59SHVdapKARD1Vm3syItRYVRULk0BnqiH+ZVtIuNhXLI23mOfQ165FdtA0x
	 CFUDpHG8vsPKYubqugBmTLrK++5R8rDXuldNfEtefhiUs3Hf/fN+4tFu7EK4eIIUU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dhl1/tjj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E91606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dhl1/tjj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB71B1F0089F;
	Fri,  6 Nov 2026 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972272;
	bh=RulP2pumuJDdQ6qGczFOD8MSveffDIBuVeKLG1nOIoE=;
	h=From:To:Cc:Subject:Date;
	b=Dhl1/tjj19WpPD/mLjqi7JdfUPUtq7vdrL8kbEyR7jOOKt9feVGHOZ3JQNJ+UQ4iU
	 dS/4kltchi1a7NxRNlzlJ0nAVbTH94JiIb4F2Uav/aWPd/NC5Fhs2wTcOmA7yR2FVp
	 JWL49qzUZd3nQ1pXi/lHDttvUp4bfbuM+PsEIu3RZ5PsapSYZgw2r9aL0K+uy02J2Q
	 MENK6pSYB4hP1vuhSLlzftEJIPSCyOP/RU2VTGgRSvp64b0Bor6KD6EYFvw82res3b
	 e8EXUCQGmXya8HF+VFcIOoyaOLuYp6WRNAEJImwiQM+ckjvgPishE+EB3s72NmUgK9
	 Xb9JTU5OVul+w==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] tcp: cubic: do not trust snd_cwnd set by BPF congestion controls
Date: Fri,  6 Nov 2026 14:37:48 +0100
Message-ID: <20261106133748.2181133-1-edumazet@kernel.org>
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

Follow up of 475ff14ba558 ("tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND")

The TCP friendliness part of bictcp_update() does:

	delta = (cwnd * scale) >> 3;
	while (ca->ack_cnt > delta) {
		ca->ack_cnt -= delta;
		ca->tcp_cwnd++;
	}

beta_scale is at least 8, so delta is 0 only if cwnd is 0,
or if the u32 product cwnd * scale wraps. Native paths keep
cwnd in [1, TCP_MAX_SND_CWND], where this can not happen,
even with the largest valid beta (beta_scale = 5458).

A BPF congestion control (struct_ops) can store any u32 value
in tp->snd_cwnd and tp->snd_ssthresh, then:

- call the cubictcp_cong_avoid() kfunc.

- switch the socket to CUBIC with TCP_CONGESTION,
  as tcp_reinit_congestion_control() keeps snd_cwnd.

With snd_cwnd = 0 (or 0x88888889 with the default beta_scale of 15)
and snd_ssthresh low enough to leave slow start, delta is 0 and
the loop never ends, hanging the CPU in ACK processing.

Adding a check in bictcp_update() would cost native CUBIC a
conditional branch in its fast path.

Instead, fix the two entry points:

- The cubictcp_cong_avoid() kfunc becomes a wrapper ignoring
  calls with a cwnd outside [1, TCP_MAX_SND_CWND].
  Native CUBIC uses __cubictcp_cong_avoid(), marked noinline
  so that its generated code does not change.

- tcp_reinit_congestion_control() bounds snd_cwnd to
  [1, snd_cwnd_clamp]. This also protects other native
  congestion controls, whose ->ssthresh() handlers do u32
  multiplications on cwnd.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/179363987528.3131.2987776489427079887@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_cong.c  |  7 +++++++
 net/ipv4/tcp_cubic.c | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e3f462f161dd6c3f4e9eeae99b45a93391c87079..2c20524489168da0062bf7ff1b8bfc69e2c8b6de 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -251,8 +251,15 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 					  const struct tcp_congestion_ops *ca)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
 	tcp_cleanup_congestion_control(sk);
+
+	/* A BPF congestion control could have stored any value
+	 * in tp->snd_cwnd. Native ones expect a sane value.
+	 */
+	tcp_snd_cwnd_set(tp, clamp(tcp_snd_cwnd(tp), 1U, tp->snd_cwnd_clamp));
+
 	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index a88e4bf86150f06eb3c0d3da99761e5d45c8f6a3..9595bdc9589c255b673744ce501f50c418d82e2b 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -318,7 +318,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	ca->cnt = max(ca->cnt, 2U);
 }
 
-__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+static noinline void __cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct bictcp *ca = inet_csk_ca(sk);
@@ -335,6 +335,20 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
+/* BPF congestion controls can store any value in tp->snd_cwnd.
+ * bictcp_update() would loop forever with cwnd == 0, or with a cwnd
+ * large enough for cwnd * beta_scale to wrap.
+ * Native callers do not need this check.
+ */
+__bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+{
+	u32 cwnd = tcp_snd_cwnd(tcp_sk(sk));
+
+	if (unlikely(!cwnd || cwnd > TCP_MAX_SND_CWND))
+		return;
+	__cubictcp_cong_avoid(sk, ack, acked);
+}
+
 __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
@@ -475,7 +489,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
 static struct tcp_congestion_ops cubictcp __read_mostly = {
 	.init		= cubictcp_init,
 	.ssthresh	= cubictcp_recalc_ssthresh,
-	.cong_avoid	= cubictcp_cong_avoid,
+	.cong_avoid	= __cubictcp_cong_avoid,
 	.set_state	= cubictcp_state,
 	.undo_cwnd	= tcp_reno_undo_cwnd,
 	.cwnd_event_tx_start = cubictcp_cwnd_event_tx_start,
-- 
2.53.0

