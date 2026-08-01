Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3331E7C18
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588797; cv=none; b=jEXbLkfFYk67ek44VO8UcwmGdA1nAxWzaz0UgHBrpEfNAxam8R1g9+ZvRVdsCIV4JOHdngwBNam+Mi/CeE8VxWzspkZ0/v1wjO4aQMUMrHgdf1c2BWyc7ImCc4/JWLq6mTd2nnaoZpZsdWVJ+gXxDNm83PPRZlaSroRmuv4G4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588797; c=relaxed/simple;
	bh=BeirPNHRMo/Rsr/HjgqrDuIkDKEP8jXpTvxHQyM1Ibg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=rhZVrsnn6+kYdC4JOdSLHKgXjjeylXxvCq3a6ZDMhhWaEKJBVi1yVZ4FvLah8ns1PmNgguTJZVhGzoKABsHP6W/R7kv4Qjp/VsuSx4DxLFrhnC6Yl5eNpqnhHmfUNp9UwvwXN6p+GyXj9VPXiWWaxxCqii2kXcRRZffNJE2kU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uh1cYjLI; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uh1cYjLI"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1339561a12.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785588796; x=1786193596; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EyRw8ijN33FI042HEbdgaWvjcGfPLu7Src+L7Vxdbw=;
        b=Uh1cYjLIT2AvD8wtyHwaH+2q0kKy0+/AXI8Ro/hMASkoalZXH8Tme2DgiPgk6q32c8
         GAIOCiF8lDK4q/F0ROO10doL7sFk3rbOqpJAtS8GbMt3Dvso5rMTeGGRM/8paRTNvnkG
         nN8728Og/xmPOlR7mU4EemGV2YFjgtXbTnTfJhe18GAJjj/zh+FJ73KJDo3QAUk1kHA4
         YujePjqNp5hVDaNIJD/3wjDBbEmFu8ufzYwSIupJS21b91CqGZl5UYtItF5LLPWVmXk8
         bpW8hLlLWrGF6Dq7Ff2+s/cHFsqnvemHqSr3MBR796BenZOkxD3v6NweTOsqoG4OFuHI
         GocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785588796; x=1786193596;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EyRw8ijN33FI042HEbdgaWvjcGfPLu7Src+L7Vxdbw=;
        b=akDN7wal1DYB3CJsS2w5Hl0TA+PU1UyHo2y/APTDNtL9aT3sPRyT++F84OglNQHSDi
         crcobG9QnqJ91rJ6UGRHZ/ssbZEg1DOHCt30UrClgdhHuB7Pd7T9NfMwy8/rPlE7N2Vo
         VVlzacv1k3TuyaGHVyECv4drHnkWMhng1G9wqXrD97ApT4pubGVUqpJPK3eS6NzhAMiG
         fnP8D7yg9m/lZutH8RrTSW87AuMcZb/npujVPFr3TwzrEAs/5IdCNnZlVDpCVLHRl+yd
         ZkblF779ZsnhopWoXYewr/rlLLPJOrUGR2qMYxdzZT4RvNZ/81lcbw79PGekV23HO2Ms
         q1Vg==
X-Forwarded-Encrypted: i=1; AHgh+RqvyoIqbVZyPJ+56t4PELwZjkhMOFuB12qfEHdoCiPfqJsu6KPCqnfG9z9D9hHEm6oryLoYsf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY2d980FgnGzRdZ2ZWbRGUCMZT7tK5eP89Za65Dy9m0X7W3bn
	VcGdP/ulj26kNphGFoBi5f9Wn1r8KeHUQWXcjmUuM5EdBisgWfnZmd95Qnz5bF+oHLPdEO9e8gh
	6LQuCJlikcq6qkDLAz68CNrvzuA==
X-Received: from dycnm3.prod.google.com ([2002:a05:7300:d183:b0:311:afe8:cffd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a0c:b0:3c6:566d:edf2 with SMTP id adf61e73a8af0-3c92a88e660mr3229820637.51.1785588795438;
 Sat, 01 Aug 2026 05:53:15 -0700 (PDT)
Date: Sat,  1 Aug 2026 12:52:20 +0000
In-Reply-To: <20260801125308.1342897-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260801125308.1342897-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260801125308.1342897-2-almasrymina@google.com>
Subject: [PATCH net v1 2/3] net: devmem: return EMSGSIZE on type mismatch
From: Mina Almasry <almasrymina@google.com>
Cc: Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Will Deacon <will@kernel.org>, Antonio Quartulli <antonio@openvpn.net>, Ralf Lici <ralf@mandelbit.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

When a devmem payload mixes with a standard page payload, return
-EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
fall back to creating a new segment instead of failing the socket send.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
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
-- 
2.55.0.571.g244d577d93-goog

