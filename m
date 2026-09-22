Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96881CAAC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039191; cv=none; b=nHkV42wYlwSjTh1z2k4kJSCOZyu64AHVsRy44rnMoAxAMqMOeVE1HMXyaoGhw0BXcEVtk1FNj3dkF7qBQCvhIC9PNHW52pyI9I420kouGmt41YQwUmO8lHpd/AfwNsei8H3wddRJ07daEy5WGs6G6WxDNami3CAoEBBCCzXFRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039191; c=relaxed/simple;
	bh=jyqPo0gZ0xPXlmDFBUx7Sd6EF70qWVj/OCUCOfROvCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ijhQ/g9KRDLfiCqStexJVlLZrfPiBsl6/5w5wR+86L0x8mkJ94TgPPFCSAH7ToErIo3vU6Nvsk8Quqo0XcRZWJoD9hAo3u/PiGyf86BrCArnPQB2ozAXC2LxKOGQszCjE5onScy1GUE9r9tJtVuQDQOUPJcV7i6jcABa5aXwYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5bWPZZN; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5bWPZZN"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93be1861d2dso543352785a.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790039189; x=1790643989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjyBQJhCTsWXzul4npx2tpKLd2K/2yev6oQ1KsDBvx4=;
        b=u5bWPZZNCUDLyti9jHa5I0YC7ocPrYF+3QM5J+NYB14FluYzJtRXVoPGdqGMKC12cO
         g6nFYDFSZsj0ERiMBXyxqu4KS0T+A13jI8q8bVP0va+ziBTYpAe9G3lwNlfjNoaaHZ2X
         xCFCJWmxRzQKKAzvHC1IMOlBwt6l73tajjHj4+lTsZc6cYGufNjJdbdKO8xZ57k7PTaf
         mehubS6jbNQ3Vn8/gxB/b8Qn59aZ9HUZ7GiHUZda7lF2NCOXUzHySuV2zhQik/RxshOs
         WZtCfCUOOxNDQuzBNZC94MCxzp9zw4Gko5zwutBmJZhj8nz2cSZ04ruZhoDac4tiB1W4
         8yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039189; x=1790643989;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjyBQJhCTsWXzul4npx2tpKLd2K/2yev6oQ1KsDBvx4=;
        b=i0yoL1uB7d7MPsoLGP40sIDg/2qKqNrM4H01pwSHbXpAEqm6TlhQsBLKuOowrl8PvU
         cBLCqokhVjhznjYS2gfh06lQlWzNaH+qDTci249kH+MxmDs5qKAcdEaFXM8srVqYst1S
         SranEavWU7lZPAcjdfPQ4KFN8cd+cfsResZ7sYI6lLmGvseuj/X20r+Ogj81ZUbf0xIp
         gSbtWmMfs4UApfMEmuWAqPbb6jYfx3wwX3KHA/kI59n+ScmMf+K4w6VBjkAZjWjKFvBJ
         nPyYJyrOsFvvNn7Q3KkjxI4dhOVM9cyIvFu60FdhQg2V5cNuoYK2KuCP03kF6H6w5NSx
         +KpA==
X-Forwarded-Encrypted: i=1; AKwUvBythtGU2dN9aUAT/GAic4EjP5hdeGjCYAzXNGmmn+astQMmaxzGPcB5RQ4rU2HDPb+70LiUck4=@vger.kernel.org
X-Gm-Message-State: AFuF++kmT4gB3/bK3XLl81QkCLiLqtEe/OHbqZyNohuJ9od7sZg/BLVD
	7cnzOykPu0HxEOBKOLW74wJjYvFBg9a6hoeSCbAgczDx0g5eNBYvDeHJjX5Ep3b0uqPeA4UxOga
	U6gftq6QYunIS5w==
X-Received: from qknvk2.prod.google.com ([2002:a05:620a:70c2:b0:93a:b4a:6af7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4622:b0:93a:34e2:b7b4 with SMTP id af79cd13be357-93c15d567e2mr347156385a.15.1790039188656;
 Mon, 21 Sep 2026 18:06:28 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:06:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922010627.2291980-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: remove dead code in tcp_rcv_state_process()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit 3d501dd326fb ("tcp: do not accept ACK of bytes we never
sent"), tcp_ack() bounds the acceptable old ACK window by
min(tp->max_window, tp->bytes_acked).

When sk->sk_state == TCP_SYN_RECV, tp->bytes_acked is always 0, so
any segment with before(ack, prior_snd_una) immediately returns
-SKB_DROP_REASON_TCP_TOO_OLD_ACK and never reaches the old_ack label
(which returns 0).

Therefore, tcp_ack() can only return 0 in closing states (where old
ACKs are accepted), and can never return 0 in TCP_SYN_RECV.

Simplify the tcp_ack() return value check in tcp_rcv_state_process()
to only check for negative return values and remove the unreachable
!reason branch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33d81e9ce90d9de2e5d989ba71c8a3..892ff256e235272a8483a11949cc98b319dd7cc9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7233,19 +7233,14 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_UPDATE_TS_RECENT |
 				  FLAG_NO_CHALLENGE_ACK);
 
-	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV) {
+	/* accept old ack (reason == 0) during closing */
+	if ((int)reason < 0) {
+		reason = -reason;
+		if (sk->sk_state == TCP_SYN_RECV)
 			/* send one RST */
-			if (!reason)
-				return SKB_DROP_REASON_TCP_OLD_ACK;
-			return -reason;
-		}
-		/* accept old ack during closing */
-		if ((int)reason < 0) {
-			tcp_send_challenge_ack(sk, false);
-			reason = -reason;
-			goto discard;
-		}
+			return reason;
+		tcp_send_challenge_ack(sk, false);
+		goto discard;
 	}
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
-- 
2.55.0.1082.g2b9226bbc0-goog

