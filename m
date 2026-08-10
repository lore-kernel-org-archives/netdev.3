Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862F3C0613
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385400; cv=none; b=h1OBUNlUQrgDs6FvOLCsIN8orAwXB1e7RgEP7/42qkOctzkWZtC9rvcze1CbCZeiX2JawuICIPdTaWVYbDQqYc1S/zrHtv5w9YcBQqd4X2mAECVFHPTqMzXUG8n3HCkwai42BLw1rRV8X4HS01DkTX3yyqFf4mk+Y7W4jZn+2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385400; c=relaxed/simple;
	bh=Tng8g144ubL7cdWL7PLGD3awMbDgm0zKMUbyJxPrw44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WL9C6nojOM8yjuk17dTMGag1sogdz+txlx4pmn0XHFX4slXK9xPQ7b+EXAGEeA8eshN1b+GRkenihexwd/HSdXd0QUdJFF2QdmKdVteJ9WaH1T+ELtZYzXh2ilTY3QsPk+IYxp8SB7vVZoEaNXFfUHEfeHhQgWjVZ7hSypc9Q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6IOQknI; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6IOQknI"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so3367663a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786385398; x=1786990198; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SvfrgljYlAUv+7lnNBQs3scDd9aa1SmFKhsRXetGHN4=;
        b=P6IOQknI0Bk+Af5kPIcsRUPTch8YK+XIr9VBVxQk26mPtt3/2RctvUlVKwpw4xaMXt
         pPuKmsk8O0sRPWOiWHPy/mGvXU2kH/bjStzn++ZvuBkyhnPITgOwxgEF9VWhzzjPfwZh
         QBUpS1VXXfks4p3xD1HwzU/d4zgTOG3fKDOI6ik17C98BXFCvawtudzPQ4gt/vS6ZVc8
         30UuoOnuNvKcZVBfJWvoDhjoEmGHm88TT8PuG9V/nSBNMCGU3LdWaD7oM0prZNS7bN6d
         VekmkFK74WmGxyQ/t9uVLjsaERYpJYzHAomX4ElwgEUwxIe4ZcixsmigbDjlTujAVXIG
         21+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385398; x=1786990198;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SvfrgljYlAUv+7lnNBQs3scDd9aa1SmFKhsRXetGHN4=;
        b=GthoCvCuNwsQv+z9BNey/crSk6CVAcgd1nhIPNf7l1xastpAAzkgRal0Nm8HN2hcSk
         rRiIbBz31rknV563E35cj3qknAg8iIWD/F7DTlYLETVJkXKfxZ0ke5LvPhHBFcpXzqyv
         xfkeSVz2mGNT6PmZe/IRzoXWOT0/hYUFfeXVkDTcwtu4j7BqTJvzQ/O5F2Bi5bOQ7k8o
         kCXXHBrcUh0qQgdeCYI1b2lcyphq1yMu7R18pyfagtVGaS3P95BV3LVZjc/pmJxJ5SCd
         5hSfBgYrM+C/BC9iClmMLqCkHYL2iVuJjhexrmtpwT5yTornkUObvvohjgKiD+KEdU1H
         EvXQ==
X-Gm-Message-State: AOJu0Yx7PaMwRX8kdR1DJ45r7rUMAP/sPZDytGCo+rPzzKyEfmwUT2xt
	RMnURInnVvgUucZ9O7GzIuEM+uF21qEzxyqQDxFKbHTvYnG1gc51DwioDElyqwBNUFmDeYSN9ko
	aQulDDP4IQaZVzf6Pgzq/wxQV9AP4SQ0CYcoR5PkvvjzdtcvOqaux5QGiu+bMtpVYkig9eZWlHr
	wSc8xCLIPmYWkpNVJBqVfVCHX8J8oN2Lb2AkalZgrp+TLs0sJBpjn0Izz6T/oOxS4=
X-Received: from dyka37.prod.google.com ([2002:a05:7300:83a5:b0:314:fa60:e9ff])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a4f:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-392cca5bb14mr3886435a91.13.1786385398088;
 Mon, 10 Aug 2026 11:09:58 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:09:44 +0000
In-Reply-To: <20260810180956.2348280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810180956.2348280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810180956.2348280-2-almasrymina@google.com>
Subject: [PATCH net v2 2/2] net: tcp: block standard payload injection into
 devmem skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
page fragments to unreadable devmem skbs. Create a new segment instead.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---
v2: No changes.
v1: https://lore.kernel.org/r/20260801125308.1342897-3-almasrymina@google.com
---
 net/ipv4/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b6949..186a36c698798 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
+		if (zc != MSG_ZEROCOPY && unlikely(!skb_frags_readable(skb))) {
+			tcp_mark_push(tp, skb);
+			goto new_segment;
+		}
+
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.55.0.679.g6767b8d81c-goog

