Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811030;
	b=iGXFJ0LmU8zsxS0xaHxC4T3jjCSJCQ1zbAkhnPrQuaJErlVCsnhRtjiZBIIUF5BhSx9e
	 qeV7DRzbkpPA6NO6E1OvtENhCN8qjEl5VoazMjWYYhon0ChKpaGwMzQIfMA95LiOk/98w
	 X5ukhQdkyYJMlqm9Eb6nPKbL9TKa1ezUZn/sxpPnlp7OgiQcnkL4zSXxy5ZOeRQf6On8X
	 HDbPpikMg0F7npPawtfUio2UhNcCwixNyzUDps17li7ld5NGJZQjjwU8b5o/3QakYnkou
	 S12+J9HWoTbrrfeMO77yDD3tb60W+mH//KUFQZRJMngl0qdQavNE+93rgQYmuO1hW9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5nrtqEKLU1ea8xT2s46uDv61cS9QhnQFGlb9NdyBg9U=;
	b=Ein/orNDjXGKSEuqVsPbNU6LSHcSGbwzNppy7+/0+gatFzfFmsCJl2x0hqAmoZYzFSoT
	 /M0fQfbZ+8SpOHq0FKPhbaqvG3v/r5AGT7ZbUxzjE471fu0F+CzGi8ZwgmJYjlv4ZZUJc
	 D/BjtzMyE4Mo+UALHDAqWchHl+yeHCNpGyJKOQXPs/7go09cYW93SaDQn1Fewlpptf3w1
	 YpjGr0mm5aHDpXpFHMlxZbzrMAO14Mz723r/KdbnSYQICq27u39CsCF90k7W9ssIhgiMN
	 msjQey5zDK79RANaqcca4qhTpo7xszyhjt4Yg02G6DzPhPbZa4KAXFrhFFeoDlXgxqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Aiulxnqa;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAD606EEAB
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FAAD606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Aiulxnqa
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08364cdc7so928596a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793811030; x=1794415830; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nrtqEKLU1ea8xT2s46uDv61cS9QhnQFGlb9NdyBg9U=;
        b=AiulxnqaJVMxsgE2s4/kJfM+Pcf6nnEnSVP28X097Xb6ejOMT8K9imU/ck0WkfW427
         1rNYdqc68RbFBaDMiGbIog7OP559MM/d7W7CrPloBTnadNHa22VN6Dz7YfyICol5GlHL
         BxJ2N8fC0M3XqnNhBxTORv+Wcx3xjOWz8G7/T26k1XVg5xdY+KHlA5pnk0Qoz2qLto3t
         dPYS3qrS/iD2uK4v1ouR3gbk8DCrTXmkxjwoBZ7ey4J9Jz9hLMhe9+8lelkRpqadJDfW
         q2vAyyWW+ey6HQz48BCpcZeWrwz/UNiWuCuX3TPA/RDnfi+OqUOxhbHZf77oK0rhl84C
         03aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811030; x=1794415830;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nrtqEKLU1ea8xT2s46uDv61cS9QhnQFGlb9NdyBg9U=;
        b=Z34hgciVCbqsLw/xTaJg6M345wXB0WUG05IMJNDhlMXDYHIwNU3VAwdQks1BOcXy3K
         TGx5x2HbjJhUTP2T1apX7A7N1uJFVS2Wl7Mm+aA4PIS3uQQVh8eF9nbjVpYYeIzacOMw
         6/5h1ecMoXCLkX2EJEhISgs+RRnmDTuv5FjsU1fbzdTPoi/LzRhEPipmVUqRVWRCbuRw
         +yRwqGI7eqVVAYWyFRf11DwqAEKDolRb0EXYesRl6FmmWSB8IsFP6nXhoCTEMGFNDfxL
         nd0aG+OBS7Z9d6xNEW0IwMXWJlOSp/bfUnklwzrhqiEP0EcwXY2TPjWwjYRtOxgImjXE
         Upvg==
X-Forwarded-Encrypted: i=1; AKwUvBxtFMdPM7DDCVfpPUHXS60chiveX4T7B0FdJ5gkfH6hnFfEXruLEz+I7hTTlbIGKCHIzj30tM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OfP1kp+byheIB/gfWDXNDQJFEA0h4DgyBW12Ef6zoKLTwNvRn
	u+cGZTe5+wNi3qs1Rh3WT0XvbGGGxYKLE9TJ4vNEsXZgOrSlgbZHhbduWIuS1ABIq2lBZ2vFOyF
	E3iA24w==
X-Received: from pjnx22.prod.google.com ([2002:a17:90a:8a96:b0:3a8:28d0:2510])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2d0:b0:3ae:533e:7e3c
 with SMTP id 98e67ed59e1d1-3ae8981bf57mr12982939a91.35.1793811029477; Wed, 04
 Nov 2026 08:50:29 -0800 (PST)
Date: Wed,  4 Nov 2026 16:49:57 +0000
In-Reply-To: <20261104165025.1026357-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104165025.1026357-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104165025.1026357-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] mptcp: Don't call tcp_update_recv_tstamps()
 if not needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As with TCP, __mptcp_recvmsg_mskq() also always triggers
tcp_recv_timestamp() if skb has hwtstamp.

Accessing sk->sk_tsflags incurs unnecessary costs for sockets
that do not need RX tstamp.

Let's check SOCK_RCVTSTAMP and SOCK_TIMESTAMPING_ANY under
lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..e632c7de779f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2189,7 +2189,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			}
 		}
 
-		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
+		if (MPTCP_SKB_CB(skb)->has_rxtstamp &&
+		    sk_want_rx_tstamps(sk)) {
 			tcp_update_recv_tstamps(skb, tss);
 			*cmsg_flags |= MPTCP_CMSG_TS;
 		}
-- 
2.56.0.385.gac671c819a-goog

