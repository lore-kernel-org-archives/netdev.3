Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909778;
	b=A9MXa0aTQRZEanqU72OwXMWlDgAxICIB1Vx/TR72DfXWp93aUMC5beyhuPON+EE2Wp+S
	 fbnckksMqPNoMFPoPBnAb+zIIRxEltAPL+W7mPTvxOvbRmoFsUtI6AWlrP9bE8+20n+Rw
	 3b9w7Wug3FmBpXiXpfomuWIw8H6ET7SKY5xFc8TE71z6CinLGj6QfxFLEAwirXFMc8Z+S
	 tHgXb0EdVgbewfiI8wGf8VwIR0oZwx5bXXHlnGggu1+d61DPukvfmLgnpkmd/8Jf6Unc9
	 jqubmEry4nIZ3iBa6jdN2yFkvD28/30W/HvtGG3AfR7EjNINPOf6NrLnn3Zv7nMpvwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
	b=aVgUXlat8ybaRDiCmQ4e+eBIlVLvRDMfgdFuTc5vXC8Fbz44MJTHj4lZiyb4kZv9qaQF
	 o4d6xtenU4UkjmAGqdSk2LgbytyGReQCTkG7BuzHprQifJl02EqZhCQghf+2fP7j1QBhp
	 PE7wsc7Zyda3HdGFQQQyh8mvSU0t1RDHsuilnygMthpA0MhRUNyJaBhLv0kaaaai37yAO
	 u5AGOKkmMHDAML6P7nXT/lZTcUgx96kRhrCg76OVmHoBQ26bFD6zW4iB3EwsM6ZDhSd9b
	 LHhukJEu5jxWUK3Dwpg1b/KfAQ9s5Xpf2FWsV6ubbHHscMQKCQMGyJPWT1lAAFHGSeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="c9gkSRk/";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DD606A336
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36DD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c9gkSRk/
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so3247139a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793909777; x=1794514577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
        b=c9gkSRk/G5cQaDx3BSrZGBoDMCozv4szM8QvS2Th579Qnisyokp/JdrpkjOZDHP45X
         iTpj6U5QGGnf4wNaEELIgCTz9BACb3zfyo046QWk1uLstSQyRlZKaqFhuH/2RLWqejnQ
         QAtnKIqy6prKraHvJKKR3ady4Fyn6sBSgjvQhgIlofqXP123yfJzkT8scbG1ZMQtH6FT
         vBBQSCt7Zdepm2bJggcyD1e6cpvu/9N6zrgr2tvZ0AleLOTZcymiNZ2vLmP6A1WTb8pa
         sZNviGhek4kHBVs5Q6xsEJSokuDU9xH5nF3FecmRtc5dzrow7+/801IJt181nXWU/7wW
         Afpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909777; x=1794514577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIQy1/TAGoU8eKcCEo0zLnQFQImrjv7x5uGLH/nZ0FA=;
        b=q04WTKxSsjGPUrSwYrd8LS0xW8fvmWcilN6vIQgTd9lxvw7QntkjPh7bO+X/J17x3X
         mpXY2C2IBrYX+bhEcYZsnSYMRqzJbcW4qpDe6jCthuyvEvw6zmOIIZn6KNjKEfHJcPkX
         dstsCTEAij1qduJzqnd5hQ3f4wtZx65NZ/nI1bCs7f2xs4w36y0DRTKhGLsSajDSYt45
         QCSj7CHYse9iak+GS5q7fC7Rn1pD029HoACmes8gfejcAf4mHDIMZreynP0ZA/GN5NNA
         jwWRmvAKuJjAbQ54Xo2QEvCkNFmTIYxMHAGjFtjRripdxrtWpTy9RnjEbSOzqgdg1Rgk
         g8yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwe0HFdov/2w8vHji65cTUyAeJNwNgaWaryvKHlbMOJFzYsPcsNu8uXWsUSrkfTNfdoknx1jIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AR4IMQ/WlFCaZSm2ZE1gJvlDuBPFVdoCOYNa3oqn1xXnbYrnp
	zhcNuBprtvyNBLahw8KOKFo2jrikgpvixJ6uA00t+JMBZLpKrnYe8DSCIRLoa7GlLllCSoEr1IP
	ZsRrQ8w==
X-Received: from plby6.prod.google.com ([2002:a17:902:ed46:b0:2e9:6f2c:71c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288e:b0:3ac:9669:846b
 with SMTP id 98e67ed59e1d1-3b0db5f7106mr137314a91.9.1793909776747; Thu, 05
 Nov 2026 12:16:16 -0800 (PST)
Date: Thu, 5 Nov 2026 20:16:16 +0000
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org>
Message-ID: <auzkBSLZp4br_6OX@google.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 16:03:18 +0100, Eric Dumazet wrote:
> calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> with ipv6_renew_options(), which charges the listener sk_omem_alloc
> through sock_kmalloc().
> 
> tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> so each request socket leaks its options size from the listener
> budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> all subsequent SYN packets. __sk_destruct() also reports an optmem
> leakage when the listener is destroyed.
> 
> Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
> migration, req->rsk_listener is no longer the socket that was charged.
> 
> These options belong to the request socket, there is no reason to
> charge them to the listener. Change ipv6_renew_options() to use
> kmalloc() when its sk argument is NULL, and use this from
> calipso_req_setattr() and calipso_req_delattr(),
> like cipso_v4_req_setattr() which uses kzalloc().
> 
> Note:
> 
> After this patch, calipso_req_setattr() and calipso_req_delattr()
> no longer need the listener. Commit 10876da918fa ("calipso: Fix
> null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
> in net-next (also removing the then unused sk variables), so that
> CALIPSO works with SYN cookies.
> 
> Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by the lsm.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179378292255.488856.6917577451813010963@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
