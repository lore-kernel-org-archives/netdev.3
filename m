Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380A2E2665
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253368; cv=none; b=tV7Ea038gs/1fqydBVlFcmwOLFuJ6S7M/VQwrNPd1ijv+7mSfINZlR8dIwzw+UapZQCUpXIdCT3BmuMHDaAIVPKblh5A9hfHihZpXuFZlnIsVdvy6DRolueooq1p/xcCVV8dtmG+djSVRmn/x5M1H7XDCB8UeLUjq9NN63udFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253368; c=relaxed/simple;
	bh=y03j6aXQZPA7dY/OKuTA0zhQGxVOn+bxn2OOzV3f2AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otenctdK5Q2xM0pw+WKjEAI4vV/o+uxDKhn9QvLb0Fq0KOQPFrmL7pZsfxTikovjiOS97eOOee9J+kP70IVoIYDw/byFWTNuqAhF2USK4ANPlzuZVv78eO92xFrg72pNl5WajMh9zMNfZ/2WXavEWgyw5kA1+tyAzqfat0SBnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpHyhCvR; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpHyhCvR"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93bfb2da664so484553285a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790253366; x=1790858166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBkw2okeVKwX1DprLwIPOJXWya579AOUlYzG0HklLz8=;
        b=YpHyhCvRg0QTijybrDb8x92mZ42FtTdJ8ekv+WKGmSewJUDWooKOE6fed+ZnGDeX0H
         s5/kH3JEqdPocpoXCjEYzIkwDeHZZ/C66a7J5XrsGCS1pYByYSUa6xm22srSlBp7BggX
         MohyyI/g+3QVExGeFqdCFB3t6M28xDGbwTJqs9J7BbUzKDnr3yzjqRXexZo7Z/i1wPia
         Tfq7LockU0ANb1Q1q9/CRb+8y7QE3xn3Ez1nAc84jnuBWUb9KdUr244f6oZMjwKvm+/I
         rMiX25iPnicLOK2PYxVKfkXFM6gDpFL5oPmL5w1m1W7Lc6G3ZkHvkam8lwFXtezdMYx3
         7dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253366; x=1790858166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBkw2okeVKwX1DprLwIPOJXWya579AOUlYzG0HklLz8=;
        b=xsPb13o0L9Ys7cRbwGe79jduokhPsfFYjx0aKicpOLpCFGz7IFFoTVRnMSuvO1wNkT
         /XuAKW3diynX4WYz8tyEY+O+TflPNfK3cwtoTUdMbHTo/jLtcAzi1iehgojbunuO0NHj
         cvUTyYlr/CyT4u3Mi6z03T0gUOy0Wc4oIYN6LaUyW/hND5CHfRvAiuAqXRezw19Bc++t
         +MkwWUMWSwBv2CF3GHjHKAmmwVtphbQJqpoumVeTuuzEvGqUFvvLu/cRoirqb4CFhE+3
         xVvUPSz6LFUv8bvJdsHfitpVRfiTV6ThA1KtVPtBgX67Jlul+IAqrRXDXqw7o2sztnNY
         Iy4g==
X-Forwarded-Encrypted: i=1; AKwUvBzBkPE/m3Y/pJquH85ZcyMA2GH34zM2UAay57KhkaUQGkXPtLzO38RbtEiyW+bysBhjqI6nVYg=@vger.kernel.org
X-Gm-Message-State: AFuF++mUetbS082OghkyfKFEUAVfIevHE5bviKSOHDl+G1I8VtCDKXWl
	4SBy/MqPxYYGhpeS1lm40EIWXr7PC26ywnknNF4ucjVVW6ccuTRXxXboyO66qYWwr+zfJMuZ7it
	uCa7f6EuDQUlEQg==
X-Received: from qkiq10.prod.google.com ([2002:a05:620a:c8a:b0:93a:1d1e:a932])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4555:b0:939:5cd3:75ce with SMTP id af79cd13be357-93c3625eb93mr252104585a.8.1790253365390;
 Thu, 24 Sep 2026 05:36:05 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:36:01 +0000
In-Reply-To: <20260924123602.1979090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924123602.1979090-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924123602.1979090-2-edumazet@google.com>
Subject: [PATCH net 1/2] net: restrict SO_RESERVE_MEM to TCP sockets and cap
 max value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM") and
commit d00c8ee31729 ("net: fix possible NULL deref in sock_reserve_memory")
only checked sk_has_account(sk), which is true for both TCP and UDP
sockets.

However, SO_RESERVE_MEM and sk_unused_reserved_mem() are currently only
supported by TCP:
- On UDP sockets, sk->sk_forward_alloc is protected by
  sk->sk_receive_queue.lock, whereas sock_reserve_memory() and
  sock_release_reserved_memory() only acquire lock_sock(sk). Concurrent
  UDP packet reception/release and setsockopt(SO_RESERVE_MEM) corrupt
  sk_forward_alloc and memcg accounting.
- udp_rmem_release() reclaims excess sk_forward_alloc without
  accounting for sk_unused_reserved_mem(sk).

Restrict sock_reserve_memory() to TCP sockets (sk_is_tcp(sk)) for now.
Supporting SO_RESERVE_MEM for UDP (acquiring sk_receive_queue.lock and
honoring sk_unused_reserved_mem() in udp_rmem_release()) can be done in
a future net-next series if needed.

In addition, reject val > INT_MAX >> 1 with -EINVAL in
sk_setsockopt(SO_RESERVE_MEM). Without an upper bound, values near
INT_MAX cause sk_mem_pages(delta) and (pages << PAGE_SHIFT) to overflow
32-bit signed int, corrupting sk->sk_forward_alloc and
sk->sk_reserved_mem.

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Reported-by: Cai Xinchen <caixinchen1@huawei.com>
Closes: https://lore.kernel.org/netdev/5a88421d-10ef-4fca-9acb-85a27a3c1173@huawei.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d23333bb4f3fafa19f58095522ef10d918d92496..cfc6700a62e6fb904f4c8320509d7360c6223b1f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1034,7 +1034,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	bool charged;
 	int pages;
 
-	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
+	if (!mem_cgroup_sk_enabled(sk) || !sk_is_tcp(sk))
 		return -EOPNOTSUPP;
 
 	if (!bytes)
@@ -1661,7 +1661,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	{
 		int delta;
 
-		if (val < 0) {
+		if (val < 0 || val > INT_MAX >> 1) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.56.0.rc1.310.g51773c2048-goog

