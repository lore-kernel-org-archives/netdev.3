Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792469833;
	b=SuR+U/SzLpjffvKRVSvjUGpx3k6kN3pY1YMU82QIaJe5oS2zv2DIENkVbK8A30vFEHIX
	 UBbTWTp7TdbopLxWQZ8Dvn/1GKopU8VpbJUsgJT4CSWc/fYHCNDX+IffWLyyg1IZQ1ET4
	 KB+mmlVdkJ5ulf9PYIswDqoLVL4cflYs5lmmE0oWjW/CPdj2jccuDOpbeIoAA1gbX7bF9
	 pVp3MnmY/gc3qYV6GjyxSjrakNqwFwfUKCKlUjI6uhf6/Y1L4AAdiLD6GDBv8YVksWlhR
	 dUo0ATpVwAlP8/ixDjQwaUDcrxZ2/Y7dDb5J94DFbkntDBrDl1WUenHWxxE/ownZntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792469833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=y3El/zgkrIeOwSVM/xohA1VqXQV6ttAXBbNdMdXf5L8=;
	b=w6OmzNCsM2AtuSPLlAM9ggrlkk7GYghWk7ngrno3QhwQavCxKD+zyAvfAQXTbVcKCpi5
	 twPh++KQ6hEZuOy+8u5L6ubNxLOi6x0K1Gj31qewLSHAhwcwsbA/PSgsf1PjclU4yk6Ot
	 pho7/9357aIfcSiwcMpQQjgRO9v3+ru401k8Cqw7E0/lUEDRKHaF7ACfcANvOSGIPRCmZ
	 +4fwOgevZZgyodi+sXXdbEL9z5W9Zof6CFtf/bgH55bY0TQqVpSGw9tc22S0L6mBI+zWC
	 CpPXK87foUA5v2zj8uSegEB1cAwOsLU2egJdxeQ8BNy8nMlPzNEmsFmStYTdZSTRSDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vru2u8Jq;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522C606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9522C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Vru2u8Jq
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e61a48d5b7so2464795ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792469832; x=1793074632; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3El/zgkrIeOwSVM/xohA1VqXQV6ttAXBbNdMdXf5L8=;
        b=Vru2u8Jq82+miZuKIMq+iNrrySMlbLwYlqtQrdYaraqYni21KD8DxLXUPTGa4QAwLf
         f7qBlLr4I1FbdSRQzAcfsQfOT0ZrlUTn73WWjW5MQJW4AW9rEJZoiAWDBnvSBN3ADDO/
         4TSMaILDuaVNgWpB6Iz1aFKsc7v/dB37P/CqjiqqXq4aGVX1O/42mZLdNoBGPcUbF+pn
         7wWrteItlH/2NGR31vXppE9xfDYKOfVEL8xFIPUB+8p91KAZfPQIUB1UzvkQguCwYW32
         EWZ5h3nKIIrHS3aC1OfC59CccWRenvr8xuRaWjm/eQhYguOogTxq1ctfdSifY+y1GpYr
         xIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792469832; x=1793074632;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3El/zgkrIeOwSVM/xohA1VqXQV6ttAXBbNdMdXf5L8=;
        b=TbRfFoPrUHLW9rYmTSHNCEqsllmeBcDZ8Gk3lQjwqIL3F2M2fDfoPEiGXoq+QM5Z3w
         DhnynvMGWKZhqWF5z3grKEgh8nHISpqpTPEDOeAmXoBN7H19tWdjY/sBXo6DCJStHtyl
         JwVQtvDIIjlIFCG1dTNBHCyx1PfrrYGyBL9WarrHN4jIJHvigx+RRTTSATkK6FIZqq/4
         DPDEK+hRX3oremDIfW2tuKiBQ88UP5895QRDClGrU+9igf1G27pU8PGkV8bjNKJo6/1J
         xnp0BMFqCc+rSCZbjq4xTtvGj2l5n07fuKrL70VKzVkkD9WGPh8ckihDBn6HbpyGZmRJ
         3sWg==
X-Forwarded-Encrypted: i=1; AKwUvBz4hnCU598ZlnGnKdd1gNex6ssevB08cVXU04m2rpsJPvBYqXpKYdToCC42DyLzlnZJCG4EkQw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC9+1LM6lQSB4pWTTQ7zbYB3YHvduoNllzA15CS01q6T71/B71
	FQ0bEC4F+mcWFWCmkQcRcPkTGtOnf/WK32ohyawok33/o682yy7yuo/sujk/Iz3spcLkeHdRr7Z
	orZ1Dhg==
X-Received: from plsr10.prod.google.com ([2002:a17:902:be0a:b0:2df:a429:6698])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c4:b0:2df:b510:cebb
 with SMTP id d9443c01a7336-2ea1d5d079bmr7431245ad.6.1792469831159; Mon, 19
 Oct 2026 21:17:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:17:10 +0000
In-Reply-To: <20261019-bug-net-netns-move-rcu-barrier-v2-2-b6eb7780c492@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
 <20261019-bug-net-netns-move-rcu-barrier-v2-2-b6eb7780c492@gmail.com>
Message-ID: <atbrOCfiVAJrmUgH@google.com>
Subject: Re: [PATCH net-next v2 2/3] ipv6: take fib6_sernum from a sequence
 shared by all netns
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 19 Oct 2026 11:31:16 +0800, Qiliang Yuan wrote:
> A per-cpu IPv6 route of a nexthop object records fib6_sernum of the
> netns it was created in, and rt6_is_valid() compares it with fib6_sernum
> of the netns its device belongs to when the route is checked. Every netns
> starts its fib6_sernum at 1 and increments it on each tree change, so
> different netns often hold the same value.
> 
> When a device moves to another netns, such a route remains usable until
> nexthop_free_rcu() releases it, and fib6_info_destroy_rcu() queues that
> callback from inside an RCU callback, after the device has moved. If the
> fib6_sernum of the new netns matches the cached one in that window,
> ip6_dst_check() accepts the route and a socket in the old netns keeps
> sending through a device that now belongs to another netns.
> 
> Take every fib6_sernum bump from one sequence shared by all netns, which
> only hands out values from 2 up: every netns still starts at 1, and 0
> means there is no sernum to check. Every netns bumps its fib6_sernum
> when a route is inserted, so before a route through it can be cached,
> and the new netns does so before the moved device can transmit, when
> NETDEV_UP adds a route through it. A cached route therefore never
> matches the fib6_sernum of the netns its device moves to.
> fib6_new_sernum() callers only hold their own table's tb6_lock, so two
> tables of one netns can store their values in either order, and
> fib6_sernum is no longer monotonic per netns. It is only compared for
> equality, so this costs at most an extra invalidation.
> 
> A connected UDP socket in netns A caches a route through an IPv6 nexthop
> object on a veth. The veth is moved to netns B and brought up with one
> RTM_NEWLINK, then the socket sends 200000 datagrams. A route is added to
> and removed from B 0 to 20 times before the move, 63 trials:
> 
>                                 before     after
>   trials sending after move          1         0
>   datagrams sent after move        251         0
> 
> Fixes: 8f34e53b60b3 ("ipv6: Use global sernum for dst validation with nexthop objects")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
