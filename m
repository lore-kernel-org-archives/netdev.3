Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DC3B14D8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878500; cv=pass; b=ipVAJY6FRMI9PQhW+Yhsw9Lo/aFn+TM4B8FveNKgm5sYoS/TC7lguMs8iPDfPMZU5ZfdI9YYxuT8rZmKmzQLflzl/QyN9tfK+Sznfa/2EAh3HvgmkhZDhJKwZaVQR3veS00GMUzpJBv8yb1tnojpDqYykwodu6PNpZgeJKELawM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878500; c=relaxed/simple;
	bh=KFFRxFxAH5AteS6INOuRURvfggPbMI9GON1e33BH2eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1PMmkAAjpOETRkij+YiJgmeE4wQkcKZCTL9YQc6WQvH9y3Au/XNS/dyJ3G+4Pa0TnagRhYe+vPYXkZUlqXmFOKd5HyCRdboYGO+AUmOMKwQuvM7xKO1NUVH025nPSCOTheB0ONdQsl4X1L5nKJ1RZkN8j8PASCqTnRC4TIe+ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHHvMEN/; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHHvMEN/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6aff2e5b322so389227a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791878497; cv=none;
        d=google.com; s=arc-20260327;
        b=S+xakHtQO/B8cGzyev55F9KoOV6bHKocy/lbpHOR2NOI2gI9NSoexs6pj8SUvNYd7o
         9Q0BNHb8GgvdYdFavzCF2svClhhSp4krBc6OYtU8LR+ChP6/EequWZBe5OueJbwcfuNy
         9NLZUo1kVUajGLhcNkUczyWCTccaczFP00KY7EcmTSsbmIKYBj+JHuZQKXx7TnhW8BNy
         mOk6h1vqaeAwD+9v54I4tWEOypOBIkvTtFCWOvyDYy3AsVtiAZpGp/KZ7MHQoYaq51kF
         jRJPo7ipFXZPGmRHyicr9dH4m+zkM6IuLy1gnBWtPBXvZ1U65kULtvjGG1mh+Dw/jsrN
         72xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        fh=NIXa0nrFgkrOptG6GRS8P2LQKOxAni0AqsaslFuDDx0=;
        b=M247JV79FlfMIGyTvQ1d09cr9zdal+Fo++HmUki3gTNzWmHAIS1pqMWYvBD7or4EjQ
         HEPOCvmGE0bA9nBlQKEpMnYTePxRRC22CI+9uSCoizb/YfUaV6RLLDqEFZQuK41YmPfe
         P/vY+sgfxIr6/2OQGjikq2gIhWjKCQzLHbGQUPPeDnQZkluUJbonBqG3pgz837ledNyD
         ARwEx+t98zzu6DRzmsQqnuJy1JduBoFVxB2HSY9XgGmWrBCC+OFm6i4fAdFspjugQQis
         0m1ZfE54YzuppXKYmfQTFp220O8WxfFQ7o9CHOk0nJn2uUz2omi4FernqUhjK9uYaOqw
         olRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791878497; x=1792483297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        b=nHHvMEN/eQUxeCOTd2vtYi0jMNxn1eR3uS/YULGmROzNc8d4DWEQZbZMH8PR8SeTri
         m/FmIp3PsJVqzV9k8pVxRidg3z9b5V+aFM5sWyBBn2v9lkNckVNLJj/+D4jDKh+bIquM
         ClSXSRWffboqAFL2MzpYX39Am8QxLuwfY7UC7uuwSY5gveJYGOgMcGOIgBw/i0JeKSaw
         Y6dVnutbJG7jdS7K2pJ1ZB0kRHx2lSFSROdxLbm/0tYP7WazMBnAGIOXqClT7413NtUj
         UIahC5feaPszUPeN6c77HuWNnNm8X7ZrYy+NnU7msVA+8gMajKrekVf699hxjmhxC83t
         t1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878497; x=1792483297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqPcad7Yc6oLW4/1CPglWS7qsNLhjHruOO8KWIE39Fw=;
        b=BrbU0r9dU6oaaVEHvKLQqOJT4tcLnsUbnlORiwBKYuk5Fd/lYJzkhxp9K43S9Werv5
         LuAav4VuTOXBZ1hxeujg24tZClsMVFlYBL0TT4gfnbnerg9bh+rL1SYl6HZxYSiJC/Jl
         qH1BU1+WFBEFT1Ubv6haeyv19KOb59XgzInlR6O3h72Hx5WK35Jcho4ZrqMETD2YWNe6
         E4u9b0EtwAs9wQo+W2LrkaauZ5M8Cv/phnWIoh1GdvFZMMFJzijnJNugIc5qTBXnvvpD
         dqZa0c0fdgHKTM3e+pfsiNrm/v9dREST1dMpyBla5CBcTP2nwGCzfHbur2e2QA38ue5D
         CGTw==
X-Forwarded-Encrypted: i=1; AKwUvBwPcQRST0ikX4RNrOtGncon7WBdVwM2CpARvJXEqqW4jKfwYyEo+FdHnIPA4JIbEp6XGwJWk9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx/OByO7jNhJkMA6YWESxx1ttoooi+0UfRup1aWm0f34lQzwb6
	RwOK/iKszWQzog5lB/ZYbokjJfR1ezb98fXkINypIQ5snqDzX/T+MHQbur1cn3apgZqwvQwvtQ7
	OND8lD7P9ItSx+VsExib+VbBEx66qyUg=
X-Gm-Gg: AYBFou0Zy6hbTGVuP/b2dxm6oGVADSEZkhH8thwVrBX+HsCZ2IqXY5EybE8z01M9jEd
	Ck0KAKgZQfktSpJTnOG6q27qFMq7+FH6wCz8ypcrn56yR6oylzpxrR/jbqAL8hVzojovEUr7JTD
	lv2lMmt3KPA+0Q7ciJ9+OcelP8pXNB862H8hbtNKNHnw5tEUkw3eZL78Evqx1F5hGDqjR/JSpro
	+MQjAYyC/LG+Rv7TFMKosRm8WoGIqojfRH+Q8WtFMalcuJC7rr/1BLGjHQTf4lZ92L29j/xRduF
	W8Ito1Uvr12Hw5n/92i28uDb7KBznRYfl73nOO6oqGgoHu8Uuz/ezTzAiMOf0xNE2K2p5us5tNw
	If8KPYQaGsVWPLXodLrM=
X-Received: by 2002:a17:906:2092:b0:c34:d75b:ddd6 with SMTP id
 a640c23a62f3a-c34d75bea07mr278330066b.3.1791878492661; Tue, 13 Oct 2026
 01:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com> <20261012200752.3771786-1-kuniyu@google.com>
In-Reply-To: <20261012200752.3771786-1-kuniyu@google.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 13 Oct 2026 16:01:20 +0800
X-Gm-Features: AclHuK9knlLJpyn2NKb20q7UFVWoMrjulr9UbG2ELaElJRyP4Qnhyg0dvU7dqcE
Message-ID: <CAAo+4rXMefUoP3BwwK20remeQ=qrS5fj-9y0w99LDu0mY0eJxg@mail.gmail.com>
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket allocation
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki

On Tue, Oct 13, 2026 at 4:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Chengfeng Ye <nicoyip.dev@gmail.com>
> Date: Sat,  3 Oct 2026 01:38:44 +0800
> > inet_create() and inet6_create() look up the protocol under RCU, then d=
rop
> > RCU before using the resulting proto. A concurrent module unload can
> > unregister the protosw, wait for the RCU readers, and destroy the proto=
's
> > slab before sk_alloc() uses it. sk_alloc() may sleep, so the RCU read-s=
ide
> > critical section cannot simply be extended across the allocation.
> >
> > The reported failure occurred during concurrent L2TP socket creation an=
d
> > module unload:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >         0xffff1108974182a0
> >   KASAN: maybe wild-memory-access in range
> >          [0xfff8a844ba0c1500-0xfff8a844ba0c1507]
> >   RIP: kmem_cache_alloc_noprof+0x63/0x370
> >   Call Trace:
> >    sk_prot_alloc+0x74/0x2c0
> >    sk_alloc+0x2b/0x6c0
> >    inet_create+0x2cd/0xd40
> >    __sock_create+0x1c3/0x430
> >    __sys_socket+0x116/0x1d0
> >
> > Cache the proto and its owner under RCU and acquire a temporary module
> > reference before dropping RCU. This prevents normal module unload while
> > the proto is in use. sk_prot_alloc() takes the socket's own reference;
> > drop the temporary reference on every exit after allocation. Use the
> > cached proto for the IPv6 backlog callback as well.
> >
> > Use try_module_get() with its existing initialization semantics. SCTP
> > creates its kernel control socket during module initialization, so
> > rejecting MODULE_STATE_COMING would prevent modular SCTP from loading.
> > Failed module initialization can still unwind published protocols despi=
te
> > module references; that separate publication/unwind lifetime issue is n=
ot
> > fixed here.
> >
> > Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable p=
rotocol modules")
> > Cc: stable@vger.kernel.org
> > Assisted-by: GPT-6-Astra
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v4:
> > - Remove the MODULE_STATE_COMING rejection. SCTP creates its kernel con=
trol
> >   socket from module init and must be allowed to use the published prot=
osw.
>
> You can filter the case by @kern.
>
> sockets created from __init_net functions always have
> @kern=3Dtrue otherwise we cannot tear down netns.
>

Thanks for the review and suggestion, v5 adds that @kern checking and
adds back the STATE_COMING rejection in v3

https://lore.kernel.org/netdev/20261013075604.868273-1-nicoyip.dev@gmail.co=
m/T/#u

Best regards,
Chengfeng
