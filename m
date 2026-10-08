Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A19A288
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424170; cv=none; b=WAXEmaGVru9Bs5PMQ0CqoOdZLAYCcXleZAZo+6YKrqfOApXEJNpfIF/kf+vBDsmhNX/il1OqmQ3CQFNQwyG0AgZ3hS4yUegr8jFVT05x1/ykFupKW2BbKaC0uXfouwdOUjSZCec4Wjw0V7OLOedhLBKbiafDl9Vxzgmb4Ix18XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424170; c=relaxed/simple;
	bh=Y2bgZt5MD5Lp/ECTRNG1YjhY6IZxQDBoeB1q2mOYy8w=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References; b=FwdDNp9PLIUeFqoajPz6OizRr3j/a173P2gvNBha062zYMZ7yrjw9NXkqGa259y9EDF8cfh0DLdmRAKZeJJf/a7ubRjJIYKrydZaVqlMVhU22ZHl5Czyd2PxlA6ZaU0w/esSoGlQiMyoa9+wydyfer5QF9DMB8ZlIEInEkbSJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YknF3CuC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YknF3CuC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-396affa9420so139384a91.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791424168; x=1792028968; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y2bgZt5MD5Lp/ECTRNG1YjhY6IZxQDBoeB1q2mOYy8w=;
        b=YknF3CuCTQYdv2hN8R95ee33506VfWwkVnyGghFttOSZgh//E3s0U3DtGlI8ygIDG1
         TAXErALGvubb5ZP/Hxtec+NOxOLIH2U1nLTN0VNgyGLFmj1lFxsfEMbMDT0psno3Ws7R
         vWVy8l1hCD9wVfv0kHEnQdGGuHHAUs1gSLCHo22VRn2+regKTpfi11Ub7zP7YrPglgDs
         MPtXqqkaEEnDLpeXSXssa++HiNEEUM2u0NOaYjRxyl4xi8jCwzzQobdBmnymDqhk4IO6
         NE+GjORzBd34Xjl5JCouhxABy0ivnWjxDjOKsa9aD5VoEsHN6IrAt4NaRrs9VsfI7fJn
         UBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791424168; x=1792028968;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2bgZt5MD5Lp/ECTRNG1YjhY6IZxQDBoeB1q2mOYy8w=;
        b=KR4Bss8ovAyRCfV/+JsIo91K4h8fNtSF+w55oGhQqUqh/FW2MyWXsazbF6VpbZSa1v
         jy4P/D5/zuSS+roB4OwKxS/p79MNISuyMo3xPGTMoBSyUfQXSIFkH70xO9qDvuw2xtxg
         ZGKgSt5G87vwrJVsvthNmi9bnqK//j6gdNRJhMKKYd8mpEFCvpxY20RM5vW4WizxHXJn
         jek8M94hT6OzmFAb/9KxrFVjLQl8a2nO+DSNX4FD6nxBlE49+xegW+J0wZ3hNbjN3Nzz
         jRTbvMjiWSluDkTkdM131KjryKKwMYIOBhTPXpW90Ib+EHz2Au5k72cnG67lDJOsYoLX
         5Xag==
X-Gm-Message-State: AFq9FYIXtWGOdwXqiJBBxIr3RWrHdnlRgmvAaylRqSKRHRVhrRDrf2xN
	S5nCb50xmVnyScdRquhjlJUFEQS9BnoYu7F9JrY1PiCBEFYPgnixZKVz
X-Gm-Gg: AYBFou2Vf6nht2QBf+HGnpJuQwCIQbk1SPC5TGHdCKXx7H7n7hIbFqxrhqUf3wGbc9X
	400X7TyZVt59aAmFmlYz18gfEH3OwLgFAc5l2dHKXfYze2t0BusVODKihUsNTiaGkqlPumvaQze
	F630QmE0uUUiM4i3gugjuopt5w0U0Ww57P1iLaaDO4FfElnNbZw8N+D0OuAgAJrWcxlil9OswQO
	7GPytGpR9apUDFFwerCX81O+NbbykpDELUgSmHMiWZdc0ep2sdNNC/9a0uJlIjbTq6lA9MqSNgd
	ILBgM63g/Dc7CsOiZLnXyB59AsgOwXEslaCyh/rDq4f9f4+nRwvBIRy/PmtjRm3Dx2/asvI2S2q
	TDnmCT6NdEVFAs25O6gaM/wcXKi7AC+SA1HvXJiz0IegDgXd5lhTTkLR7puknOFhkdEFvZuRe0b
	kt0or64R5zc6afHalH6Cwx84RWmqN030rWxt9WWNOfM1KcPY0nISKZRetxgj8vP6mTmLBJCmXMn
	AjcKPeBkckRqcqTE9mw+ro/6R3zJuGMUZvBUu5U
X-Received: by 2002:a17:90b:4b85:b0:3a0:8001:7d11 with SMTP id 98e67ed59e1d1-3aaab2e5f20mr1457182a91.6.1791424168414;
        Wed, 07 Oct 2026 18:49:28 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff5b3b06sm1854424a91.15.2026.10.07.18.49.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 18:49:27 -0700 (PDT)
Message-ID: <1791424156.460.8ed76b88c7@gmail.com>
Date: Thu, 08 Oct 2026 01:49:16 +0000
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
    Ido Schimmel <idosch@nvidia.com>,
    Steffen Klassert <steffen.klassert@secunet.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across async crypto resumption
In-Reply-To: <179110850671.434549.2584497019282941556@kernel.org>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com> <20260930090813.73901-2-q.h.hack.winter@gmail.com> <179110850671.434549.2584497019282941556@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

All real, and vti6 has the same problems.

The dev_hold()/dev_put() idea assumed the callback runs exactly once
per skb, which xfrm_input() doesn't guarantee. IPTFS frees the outer
skb on its own without any callback. The early drop when the SA is no
longer valid happens while family is still AF_UNSPEC, so xfrm_rcv_cb()
can't find the afinfo and never calls us. And on the success path I'd
drop the last reference before gro_cells_receive() is done with
skb->dev.

So I'll drop this. Two options I can see for the respin:

Re-lookup the tunnel in the callback like xfrmi does. The only key I
have there is the outer addresses of the state, which won't reproduce
the original lookup for wildcard-source SAs, and during teardown it
can pick up the fallback device instead. The RCU section also ends at
gro_cells_receive(): the skb queued to the gro cell is processed by
NAPI afterwards with skb->dev still pointing at the tunnel device and
nothing holding a reference.

Keep a reference from vti_input() but release it when the skb is freed
instead of in the callback, so the paths where the callback never runs
can't leak. That looks like it needs xfrm core support, so I'd rather
not pick it unilaterally.

Which way do you want this to go?

pw-bot: cr

