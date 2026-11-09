Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245040;
	b=O82RLd9wZuksvqC8ScSLaJ7s/V26jVzLPA8Y4rDUkdyUV3LyGdzEUTdiiO42Y1X5FM8O
	 5FK4PK1fP2gQMy8aAQ9WOCaTgCoVf/TAEuzqjPTVb9GpQY6Dok4cowaVYXFhph4pCsZ9y
	 W7YHsoidQD2g2pBTBh5C0ZQHEb05E+2GBSFIkEm1ingNKWqQKq0g83d2Q18ZCvvYoorK/
	 UZmPfmOvWBdpIe8D0oZjLmGJ0vmdIbQJsvBlw+d6E8JXqNdbRofFoq65x30xNuMulFGKf
	 mz8GHSNCGpICAsRhRH61nR9jZfGO2WxPoN0LvdDkKtvND5m+gDItoJT4plJcQNMcNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SkI4TIX22rtuyPPaLwG1CdpRN3yueyM1ryT+FhQmelE=;
	b=YarabVbgIk2s1dPMsGLVbBlypOHC8bdYRd5cu56dlQMGqUMqLP2PgCwjF3sCGDuSiVXu
	 NJ//wjyfHRPMFWZLEEJDBBgzeZx0QObq4+pILVOIxvvbu+oj82Cz4S+NomaTlQ3olNuzq
	 KaAhwPJQ3K8JJxwWyisdpgWK0Uv2jNxvHOW7+5kTJQN5oYSAseQSa46O0tT80wiXJg126
	 RWoNdq8Q2r/y4TIMvsLs8sWbGaPmGpWqAlfNyZoZZBbQa1MctitGd/rrEHIbCIK4Ay3i5
	 5rfXCwH9cgUlcrcnY9IcnHcgKO2OAGFLdRTR5Yf+3NLDXAyuUj7klbPg4qUZebl0R4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6VmrDH+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE64606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6VmrDH+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C171F0089F;
	Mon,  9 Nov 2026 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245040;
	bh=SkI4TIX22rtuyPPaLwG1CdpRN3yueyM1ryT+FhQmelE=;
	h=From:To:Cc:Subject:Date;
	b=P6VmrDH+k0vJlsN7oWARydBIiKOfMGwtm5z/w69iy6JOmqDVeFeGPeGNEqkSjRqt2
	 CfcNbSSRaBCF89m/HLiNVIGIy5++fTz5fVrKWq7HW8nNnfZ7Mdo/9mDvBsnTEyprH3
	 Ff4bawYp8+eK2A6eAoBkExmq8dsXUZmgw4oAIQp5HvqIaX+PTtM3qKmOHmZ2f+VZXB
	 WuBoUCU75C+OIRQpe+4xDddxuqp8hRDI7tzCfI1iAfKtYszsmWi31buUzE2uSFBRAE
	 sRk8mQE5PpxEn4t8tm+NYd8Su+CUP3RhjyZpdAj1wLS28JJbJAj1vfvUGWCKYL04DC
	 aN+AiSTVNrBXg==
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
Subject: [PATCH v2 net] tcp: cubic: avoid looping in bictcp_update() TCP friendliness code
Date: Mon,  9 Nov 2026 18:23:56 +0100
Message-ID: <20261109172356.3113732-1-edumazet@kernel.org>
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

The TCP friendliness part of bictcp_update() does:

	delta = (cwnd * scale) >> 3;
	while (ca->ack_cnt > delta) {
		ca->ack_cnt -= delta;
		ca->tcp_cwnd++;
	}

A BPF congestion control can store any value in tp->snd_cwnd,
tp->snd_ssthresh and icsk_ca_priv, then call the cubictcp_cong_avoid()
kfunc or switch the socket to CUBIC. A zero delta (or a huge ack_cnt)
then hangs the CPU in ACK processing.

Make sure delta is at least 1, and replace the loop with a division,
done only when ack_cnt > delta (at most about once per RTT).

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/179363987528.3131.2987776489427079887@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2: fix the loop itself instead of sanitizing snd_cwnd at entry points.
v1: https://lore.kernel.org/netdev/20261106133748.2181133-1-edumazet@kernel.org/

Discovered by an AI code review agent (Sashiko), confirmed by
code inspection only, not triggered.

 net/ipv4/tcp_cubic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index a88e4bf86150f06eb3c0d3da99761e5d45c8f6a3..e74dabde34324d4d4764afda7022fafcdbcecbfe 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -298,10 +298,16 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
-		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
-			ca->ack_cnt -= delta;
-			ca->tcp_cwnd++;
+		/* BPF congestion controls can call us with any cwnd
+		 * and ack_cnt: cwnd * scale can wrap and give a zero delta,
+		 * and a loop could run up to 2^32 times.
+		 */
+		delta = max((cwnd * scale) >> 3, 1U);
+		if (ca->ack_cnt > delta) {		/* update tcp cwnd */
+			u32 n = (ca->ack_cnt - 1) / delta;
+
+			ca->ack_cnt -= n * delta;
+			ca->tcp_cwnd += n;
 		}
 
 		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-- 
2.53.0

