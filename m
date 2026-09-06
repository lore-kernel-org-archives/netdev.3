Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BF625
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697954; cv=none; b=KjJEMku23nquhfUOMtQgQ96RTjk1mxRmSWhRIqkPOromLn43Wd4D2NR+K762Aq6ZQaDIYAQ+ULoac2UTmxVeSaVEQ/ShzVEiYNUL/GSc3yCv0nhWt7eEzoRa49q6SSfo9TKtLFlDst7gdVnnJNozsdmk44wvfluLXN9Pihj1aBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697954; c=relaxed/simple;
	bh=257ha5482dGDut3K/eEsR7K8P9zIwElkWPJi5hXYxbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6ZOnJLh+9Dq0KCeCC8fOUA/BfhRxZ70mMVU9TOKa5/QaQRZiIH6enirIvirV23xPi2ekCP9E0aBBKSrxzsZtfs03oniNPQKMAMlepqHKX5YTG+gFDnKCH56V7IjqsWA54YxDymUzpLyU+qEQX7YbK2wbeafGigyJhQhR9vOTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=azDatZic; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="azDatZic"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843178b1c8so174145f8f.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788697948; x=1789302748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2re4j2iFe8xgappvNLpp0Es9o+RXslUNOkb93dc7fFQ=;
        b=azDatZicdgBmetHzMTm+e6f98k0srQY4FCkxJQGGJxymD/ysfko+373GPWyA1tenOY
         x98UZBQvWL0uc8T1lv0moLvwvNlb892XG9KZsOxfwSO0kEtVeLqsrasxlPFq2sFRbtn7
         zUFxgs8s5/Uqud54d0Wmp0fDguF8XgK3ftwq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697948; x=1789302748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2re4j2iFe8xgappvNLpp0Es9o+RXslUNOkb93dc7fFQ=;
        b=HrlbXDG/jotDRLOzWfDE3V257nG/8TPHYtv24/MXjL91Jm2z+igwe22Afewe8Sf3xz
         E2vyKZXKnj5RAFdh2213i3kq0S6ZPsXymQHpE8r4kNEttR2G+oVmzjrDyNxZN3yVSdER
         9YlqOfmWFe3hX8qWEYUV2EsoXPd9UFmoXdCAy/3DOywH0ZSgECoNUPoh8BVNQ4YCJJAi
         11OhifgpkZ2u3jyjzvORzH17jZpUV2sTA9/VdbiMfLyjBpY5Ae9+5TfI638IBUnLfxG3
         K7ALUQsi7Bm86rK/zpsx+Lwf5zUEMUmXsZQ3QB9mm+sR/WIK4+I2nunrmgOSjnH+oQ1o
         cv8w==
X-Forwarded-Encrypted: i=1; AKwUvBzMmdma+Uk+6uz+ObKsgRJdmcV6r0ePctmA8jWqEEo56OZH9tJNCq2ll/cv59fFZ9OJp7n5ebA=@vger.kernel.org
X-Gm-Message-State: AFuF++n4IyL2yw1uVzUqtsWgvk7cmdW3XJ3d2lmYmNlceeKtgD6N2xib
	5v0nR7mR1z5mD16juM0Ubal1FbvKf34/nCqVn1t/BMAxxXjVoa7E3KAShz9ROo4arA==
X-Gm-Gg: AYBFou2hZj9WLwhnDOtjRys5YP76rh5Wh56fZgEpxPuhGPpuXoVa4QMRXP8x4lC6Mki
	Lrpcsy/ft86mkDeoSTwkZJyUlx/lo5yi/vhLyd3S0IAuFFGLlrS+eeWTgikxFMa24d7nr9FXNKu
	13BBHAsrHJZEQ0Oo9Zg+ycEiAstT3QoAnw98STvRsZRnx4tS93dhIJtIL8jYDVHERjuSNBw++JE
	x/LU3b5W10U9VrXQiP6dHpHyd2+Xkx1LOzCjWg+2OlZeSyLQ/bIM8iNT9VdV+mXutVDFvZHPtcX
	Bw1dfWh2kRNb9QgWo3f+vyhyg44XSqJpA2wEtdaKVpNbbcyGDJqpFQjiOe8wtAiEDUe+7XgG5r0
	BwWLi4QHK8GaQesDkf4FjhFZJxkb2Gs30OwAMlowpRmPN60a2lVOnflRaORnG2N800S6hZrG69T
	2bC/ewISkaeNuZjBZIs4vrlJrZh+YqGZTj4LMhhKe8Pt4Z7hy5In5btHPrWYIdNCvSZIxU/Befw
	ABiIMwf503WOiooUtbqS+9YsA==
X-Received: by 2002:a05:600c:c494:b0:499:d95a:41f with SMTP id 5b1f17b1804b1-49d010c3969mr86187115e9.0.1788697948407;
        Sun, 06 Sep 2026 05:32:28 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm200184035e9.11.2026.09.06.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:32:28 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>,
	Amit Klein <amit.klein@mail.huji.ac.il>,
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Subject: [PATCH] tcp: validate old ACKs before fast path data processing
Date: Sun,  6 Sep 2026 15:31:51 +0300
Message-ID: <20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For incoming TCP segments processed in the fast path,
Linux does not enforce the RFC5961 requirement:

   The ACK value is considered acceptable only if
   it is in the range of ((SND.UNA - MAX.SND.WND) <= SEG.ACK <=
   SND.NXT).  All incoming segments whose ACK value doesn't satisfy the
   above condition MUST be discarded and an ACK sent back.

Meaning the ack of incoming segments is no earlier than a window back
from the first unacknowledged sent byte.

Later work showed that the condition (SND.UNA - MAX.SND.WND) <= SEG.ACK
can be further tightened, eliminating some demonstrated TCP data
injection attacks, resulting in CVE-2023-52881 assigned by Linux and
the 2023 patch:
Commit 3d501dd326fb1c7 ("tcp: do not accept ACK of bytes we never sent")
that rejects ACKs for bytes so far back that were never sent.

Link: https://www.cve.org/CVERecord?id=CVE-2023-52881

Both RFC5961 and the later patch were only applied to the slow path,
leaving the fast path vulnerable and noncompliant with RFC5961.

Enforce a validation test for the SEG.ACK in the fast path, before the data
is processed. Failure to pass the validation will result in a challenge ACK
and the packet will be discarded in compliance with RFC5961.

Some details:
RFC5961 (and the 2023 patch) is enforced in tcp_ack()
(./net/ipv4/tcp_input.c).
Incoming segments to a socket in ESTABLISHED state are processed in
tcp_rcv_established() (./net/ipv4/tcp_input.c).
Consider a packet that violates RFC5961 (meaning the SEG.ACK is too early).
In the slow path (starting at the label "slow_path"), tcp_ack() is invoked,
well before processing the segment data.
A challenge ACK is sent there, tcp_ack() returns
-SKB_DROP_REASON_TCP_TOO_OLD_ACK,
and slow path discards the segment as expected.
In the fast path, tcp_ack() is also called,
but only after the data from the segment is processed.
Furthermore, the return value from tcp_ack() is not checked.
De-facto, the data from the segment is accepted
(and an ACK is generated), even though the segment violates RFC5961.

The following packetdrill script shows the issue at hand.
Linux (as a server) accepts data segment processed in the fast path with
an ack that is far too low.

// BASED ON PACKETDRILL SCRIPT FROM:
// Commit 3d501dd326fb1c7 ("tcp: do not accept ACK of bytes we never sent")
0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1024) = 0

// ---------------- Handshake ------------------- //
+0 < S 0:0(0) win 65535
+0 > S. 0:0(0) ack 1 <...>
+0 < . 1:1(0) ack 1 win 65535
+0 accept(3, ..., ...) = 4

// Data must be first sent/received on the socket
// so that memory is allocated (sk_forward_alloc should be > 0)
// and later data will be proccessed in the fast path
+0 < P. 1:501(500) ack 1 win 65535 //valid packet forcing memory allocation
+0 > . 1:1(0) ack 501

// incoming segment, ack way in the past... (101 + 2^32 - 1500000000)
// Oops, unpatched kernels happily accept this packet
+0 < P. 501:1501(1000) ack 2794967397 win 65535

// On unpatched kernels, this ACK will match,
// showing that the segment is accepted
+0 > . 1:1(0) ack 1501

Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Reported-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
---
 net/ipv4/tcp_input.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51342..2474871e80ec 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4272,6 +4272,17 @@ static void tcp_rack_update_reo_wnd(struct sock *sk, struct rate_sample *rs)
 	}
 }
 
+/* Validates that the ACK is older than the acceptable historical ACK window*/
+static inline bool tcp_ack_too_old(const struct tcp_sock *tp, u32 ack,
+				   u32 snd_una)
+{
+	u32 max_window;
+
+	max_window = min_t(u64, tp->max_window, tp->bytes_acked);
+
+	return before(ack, snd_una - max_window);
+}
+
 /* This routine deals with incoming acks, but not outgoing ones. */
 static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 {
@@ -4303,12 +4314,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * then we can probably ignore it.
 	 */
 	if (before(ack, prior_snd_una)) {
-		u32 max_window;
-
-		/* do not accept ACK for bytes we never sent. */
-		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
-		if (before(ack, prior_snd_una - max_window)) {
+		if (tcp_ack_too_old(tp, ack, prior_snd_una)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
 				tcp_send_challenge_ack(sk, false);
 			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
@@ -6614,6 +6621,15 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if ((int)skb->truesize > sk->sk_forward_alloc)
 				goto step5;
 
+			if (unlikely(before(TCP_SKB_CB(skb)->ack_seq, tp->snd_una))) {
+				if (tcp_ack_too_old(tp, TCP_SKB_CB(skb)->ack_seq,
+						    tp->snd_una)) {
+					tcp_send_challenge_ack(sk, false);
+					reason = SKB_DROP_REASON_TCP_TOO_OLD_ACK;
+					goto discard;
+				}
+			}
+
 			/* Predicted packet is in window by definition.
 			 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
 			 * Hence, check seq<=rcv_wup reduces to:
-- 
2.43.0

