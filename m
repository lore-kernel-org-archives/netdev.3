Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7637CD5A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392748; cv=none; b=IVaR+ekSbRzvCQFWKmf9zIT2Ua4moEITTmJGos/U7SKxImNUY1wlPwabUc5BrmC7QZhiiDl69aAWwyJqaIjb+lwvjEtnyelqR510cH9ojDNje1QkxsOBEda+als5KUATeoLTO52GmXBdi0WaHVbHCcAmDFItnKcPT6kuCUStw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392748; c=relaxed/simple;
	bh=j15p9kqnLsoZnkKuv4K6BS9p5IaOdB8PIeHyQYw3k4I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qHuLgf5OJGNpT+mWwByM4DsfbMX/W6x88YcY/SBS48O/HX7zmfFYwwjzKIusajd8MYDdbRPEuNhE9VhGqGrKL+6wZR+yC1Y/GVNWcxB0MZ7Vd4J3rhIbOeS/IgkSGdSDVrdcsmyapXA9gY3j9ZIn7hbO4GbKQCITcBIe02FXXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qxt20KpL; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qxt20KpL"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so2846181a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786392746; x=1786997546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EI/HoHClRGKxnybzwHOOhYmWsnX7Q/D3wFeZtFxK35I=;
        b=Qxt20KpLvRSV8RBeTQVCTJohDUQ1zTXGpCa0RrAgHg0Yv7zORu+uh0sUCO5K7nPxO9
         rHu+Cx+EcIXFWbTFwy8bGmjIIZNR/hCXIbpv14pECUKPlBlpYF3EJ6bu/BAtIGWS0qAT
         AexeDYBRK0FToOw0V9gE5yPnMwbcD8fF+NVy1432Hzzff75SyzABER8xaEbjCExHpmWA
         u3uw3pdJDMxXsR53qYBsbWEc9cO4YLvd3Po3zM5ZgZnUGWGCIyNV6GR0gpvr1jeesnbp
         tOJvDiFAVipuBYHJ41m24fUNERuOmMMGWiLZEOIcUWk0Wc9xAzZD07Ha+niKYV8TF5B7
         9aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786392746; x=1786997546;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI/HoHClRGKxnybzwHOOhYmWsnX7Q/D3wFeZtFxK35I=;
        b=GG5F7zcisOUdMgfGV20A6GOQxal3OhDh5RsAP0aKJxHf0cbZI6P3gfwMyz3gs/pHgK
         X71Um7M1k83AUYf0VISVl3RyAm0/oH1sXw7375WouFJgQOQM9hMIL8gxwo8QMepcDC2c
         q/lQnR7VQSZz3HUr7+HMiV3xrbheEO/XnA90B63GBQMJLGn2XSCzon3R2r8jFyfWFN6B
         Cnz+AfrG6NQ5dgij9OX1YDTvzmUyt5MWMjXNyJf+53fnixdukL/VjcLj9GheO9YRrIab
         Rm/zI2MY63XIVUFu/PjlpBTkj7bvKAFNJYkuUvFjcNAH6UmD5vsjlB+kHszetq3nE4i6
         gj3w==
X-Gm-Message-State: AOJu0YzZNoISxMVzZKUMoSBUUIfPmxnVzLaV2uiX2WN5op51r6FdCrWW
	p7u6msoW2B9o83l9PGJVMf+bp1E9ZSpam1md1L5Q0UKFlUDACml9bGVxAPGPiz0IrRpg8ssfuBS
	RkYOu/y1iZE3+OfhOaObZfxGvF4MTXVCN9FCOPrmMaSVAtNhGqHyX3MNz0jrj5cnKdCIRdZ7WYd
	OcGTwRiSWkrRdHAbOdiE7w7S0TRQKVj7n8E+Izcs/6b43NGdXrKlJzF9vSM5Q4Wbk=
X-Received: from dled12-n2.prod.google.com ([2002:a05:701b:42cc:20b0:13b:9ad0:582f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d8c:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3cbce94fef7mr25905237637.30.1786392745845;
 Mon, 10 Aug 2026 13:12:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:11:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810201213.2708375-1-almasrymina@google.com>
Subject: [PATCH net-next v2] net: devmem: return EMSGSIZE on type mismatch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Ralf Lici <ralf@mandelbit.com>, 
	Will Deacon <will@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When a devmem payload mixes with a standard page payload, return
-EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
fall back to creating a new segment instead of failing the socket send.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
v2: Sent to net-next instead of net (Jakub). Otherwise no changes.
v1: https://lore.kernel.org/r/20260801125308.1342897-2-almasrymina@google.com
---
 net/core/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 173b5d97bd409..6f8ffd61bcab4 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -638,7 +638,7 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	int frag = skb_shinfo(skb)->nr_frags;
 
 	if (!skb_frags_readable(skb))
-		return -EFAULT;
+		return -EMSGSIZE;
 
 	while (length && iov_iter_count(from)) {
 		struct page *head, *last_head = NULL;
@@ -713,7 +713,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	struct net_iov *niov;
 
 	if (i && skb_frags_readable(skb))
-		return -EFAULT;
+		return -EMSGSIZE;
 
 	/* Devmem filling works by taking an IOVEC from the user where the
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to

base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe
-- 
2.55.0.679.g6767b8d81c-goog

