Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868203876A4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508700; cv=none; b=n2S3ffQb3SOpPMDPAP2ndDtqyYccHrwBw6yj50n5bfIqtGi9y+cCSPX6cFLAZv4iRRs24j5B4SFudSb6wKsQ1kwGqkL9oKPPYzX5YsPdE9inI1AK52YQWGMwCoOf2bxp9BzZP0jD8yBSz+uJMpnJ+V0ZPIjODPtXCVYII4WGOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508700; c=relaxed/simple;
	bh=gl7z553izH5VoAz2WaKJ3FfcdDy/ZjbaYueup3zguMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+4s6O7a02WlvszMUcMiV/x2z1mvPlsDIhmbcddtfzgJ1ewjorJRZhGoOhsiSxoib5HZKgAm6jiaFa8evQ9Sddlk0+LAJd9iYfqkOfc1jflq6qlFERm8XGEnrbYgnEe02JXoVcn4abk+Va7LGB/LXQuh0MfopWdEy5oo2HK0c6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=JtC0JdJI; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="JtC0JdJI"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso150340a34.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1789508697; x=1790113497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dDLidrfZT1Vnx6uN4AwWKPzSr1RL8d69I4daalwq6Y=;
        b=JtC0JdJIgkKej8bx9YsIEc8zNmFhQ19WYBFyIH7f2+vUlhduZpWe8rrzBtUI2k/ph7
         yHVplRJzrAo9CkgXJXMq9W2QZ0MjHkfIAx+OAgMtVZx1kRM7UrvMOgqsr8Hvxtrvxq+x
         HmuEwXOtkY3e/VJaDEwRMd3BTft2QuBhTtWVp5kcQrba5ni5YC0gQSRpEOYFCc3HWOpo
         sImCTnk0qFMDJZqZMpGNcrTzXDq0c4dIXJpX5Qls+lPPPqnSUSjeNTE4etjaqBxC+Te2
         0yI4Ski7F0WuMngZ/LWX8bR8MmTOwxmBVpPfN4hh0FcQGMgAVf9vjy/HK0CqOgiDPO8k
         Tj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508697; x=1790113497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dDLidrfZT1Vnx6uN4AwWKPzSr1RL8d69I4daalwq6Y=;
        b=tLU+wIw57x8cnmSdK/Ib3w6WZQyuPiJFbd6GcPpGWE86bbGwr8JAEc2sMWsdWbUGNL
         N8MU16YxgTipzwEzpzryRsDpablhi2uPxl0PqYTS+UWYvf6yHQ58F7jHSzS7UP+s1EtL
         CPJZOkZ+1d5MBC3J2a9PTZiDveTKeIGJtG0W/FeLdVVBm3pX3Jpy7sBMJdqSvwoX2e/q
         OftJfOxnuOQfadEuvmqtSHog81wsgsjsqP4dbD4gQSqDCfysZMGIUryYTbGhnRqUcG6B
         Z6qgif01E2sfUS2JZO4rpWuutw5i/+5o0KiMi8e/fuXWDwXk/rAqD7giSWdJltccgQL1
         mW/A==
X-Gm-Message-State: AFuF++m6xOHgpPlo3zbX1Wjk1Ha3xZ4yJaVi4GqGfES8j7NBT2Lo9G1w
	r/5TJKlSyrDbCZOmd9CP8VLgBaygh7TrFHAT4G2d/8dreYxS28ZyDeGAsWWHd6U3LUw0sH8W92h
	C2KlN
X-Gm-Gg: AYBFou0r9afd1HyqG40cZkdgX09v2jC3kP7oIrThaBAAXjCSflhScISBciT8pGgJNvV
	/kNPBSoWnx/vrWgQwxMBFSLOZPDm/4eaU5bwsloAA+6z3UGO/+MUDJVJ7RlP6tj4IBjRmcw3hUx
	RH9dYmEBZoyG1o09lGooiu6t8f+m0QOaSsxAPWeCNMZ++fhgaoF+suFUFZ9Ii4wNOxtSg341kiW
	e3R6cf9ejIyndBWIHrJUglWiZXAn21IuXZ9Y9xqdp7fIT4MvktNK8IQQI/3AFejMyLKLHQBVKQ0
	JUpbxBYO2pissUFogvdlOmqaFR435WFCDo5vB/x1SDfmpV1jI6hD2RHptcnzb97uKT5+ZTnKbU1
	OKfqL0KGNRWPZrQ01+qvrmDkiBvQVRL19YCB3i35lM480PRkjR2C+NZLzPrBlg+fFGjD+AITVXU
	BxeRV698NcGSVPRIIMgX6RNx8WM2MWV23VEW43b0hT70KSOpPVWefVXwfPrSDwX2NUO51hNilqC
	Ad8lm7KXWQ3JguFmQ==
X-Received: by 2002:a05:6830:4389:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-80b29faf1b4mr660476a34.0.1789508697338;
        Tue, 15 Sep 2026 14:44:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:25::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b0668755esm565577a34.9.2026.09.15.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:44:56 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net] tcp: initialize skb tx timestamp key before cloning
Date: Tue, 15 Sep 2026 14:44:50 -0700
Message-ID: <20260915214450.2882680-1-dw@davidwei.uk>
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

Initialize skb tskey just before cloning while its shinfo is still
private. In tcp_tx_timestamp(), if it selects a cloned skb from the rtx
queue from the current tcp_sendmsg_locked() call (i.e. tx_flags and
txstamp_ack are 0) and the pre-init skb tskey matches, then tx_flags can
be set safely.

If the skb is not shared, coming from the write queue, then both tskey
and tx_flags are set, as before.

Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx queue")
Assisted-by: LLM
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/ipv4/tcp.c        | 21 ++++++++++++++++-----
 net/ipv4/tcp_output.c | 20 +++++++++++++-------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 562752352afe..0d6bbb41d5f8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -481,20 +481,31 @@ void tcp_init_sock(struct sock *sk)
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
+	struct skb_shared_info *shinfo;
 	u32 tsflags = sockc->tsflags;
+	struct tcp_skb_cb *tcb;
+	u32 tskey;
 
 	if (unlikely(!skb))
 		skb = skb_rb_last(&sk->tcp_rtx_queue);
+	if (unlikely(!skb))
+		return;
 
-	if (tsflags && skb) {
-		struct skb_shared_info *shinfo = skb_shinfo(skb);
-		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+	shinfo = skb_shinfo(skb);
+	tcb = TCP_SKB_CB(skb);
+	tskey = tcb->seq + skb->len - 1;
+	if (skb_cloned(skb) &&
+	    !shinfo->tx_flags && !tcb->txstamp_ack) {
+		if (shinfo->tskey != tskey)
+			return;
+	} else if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
+		shinfo->tskey = tskey;
+	}
 
+	if (tsflags) {
 		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack |= TSTAMP_ACK_SK;
-		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
-			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 
 	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 00417a429222..ee3efcbbdf3a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1522,6 +1522,12 @@ static void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
 }
 #endif
 
+static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
+{
+	return TCP_SKB_CB(skb)->txstamp_ack ||
+		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
+}
+
 /* This routine actually transmits TCP packets queued in by
  * tcp_do_sendmsg().  This is used by both the initial
  * transmission and possible later retransmissions.
@@ -1559,8 +1565,14 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		tcp_skb_tsorted_save(oskb) {
 			if (unlikely(skb_cloned(oskb)))
 				skb = pskb_copy(oskb, gfp_mask);
-			else
+			else {
+				if (oskb->len &&
+				    !(TCP_SKB_CB(oskb)->tcp_flags & TCPHDR_SYN) &&
+				    !tcp_has_tx_tstamp(oskb))
+					skb_shinfo(oskb)->tskey =
+						TCP_SKB_CB(oskb)->seq + oskb->len - 1;
 				skb = skb_clone(oskb, gfp_mask);
+			}
 		} tcp_skb_tsorted_restore(oskb);
 
 		if (unlikely(!skb))
@@ -1795,12 +1807,6 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
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
-- 
2.53.0-Meta

