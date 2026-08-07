Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A419F40B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101706; cv=pass; b=KjmwOqEWd4T9T8RanTtAPQlc3l3DfFLtoMNkq4IzISluOMtlBmaAIhlgRAKH6mFuYmjnO1CFUKWIEOSq4o2KQ6Iz5dt0+TMOlIyEFk59MtO4Os9GQa1kl/qwTQnJtBAub0w7YsbzuU+ThetfZwR+rFn8dtuIcApv0Nm9h30LteU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101706; c=relaxed/simple;
	bh=b7BM3Lp9tBbanKUXXOullk/LF8dMXL9Sd5xXHhKmN5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhodcUeE8X6fbbAF21pE2eC4IhFP5r7qYMBiKE0CqtZIKq1htKQ6Cz5jgr2jun/y9iJtVntIQ1/viiKqCHmqcaXrLR+J40ZkI3DPdqPdDJ/TuL6Fg8XROlyoRtjKjJh6mSnXp7SkEAQnB90Uv8icOxOR11HYq9VO2wb49qBXPIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeBBR/jO; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeBBR/jO"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4960a66d36dso819492b6e.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 04:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786101704; cv=none;
        d=google.com; s=arc-20260327;
        b=CohMkih8hs8VXPLRWXqCFHuecal7tAuFV6AmH4zJOrqKeN5npN/5C2piec2uC5lDei
         FjWibvDu+Ki5kbdNextr8jlHYDHa6CRPtbrqSZUHNW/J85o6lL4AwneXgPGBqJNKQhhC
         IoMbRJwYnsZZHzELWfympouxco9O189vp/sRPlBakpSLMnJSS++fnnzGUJZQ9VwiKghG
         WvGPcJbb16gXPFLXu0P0++tK0t7L85ilErh82oQodjuWBymziQYf36RyQ19jgBKB7aiN
         UgaDZF3DZbDvywja+dHk5HUP1EC4x83scWV6m8jXkZnW7XfXQiZRex9U9qd036CaGd6n
         qgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mINjklpxtkICORyfJxN/cHIuCc/TZS+0MLm3vqn2bsU=;
        fh=ou7HoF2iNTXmr88aOUofn6fi2GivoYPUxM/3PPPyfsY=;
        b=boPBkZVZFjYPFdqgNSnZAnP7J3qQn5v08lOeWRbUznv2CLYkSH/Ycbzvc713TZA1Ph
         0pt68A5Ebsr33sb8G9RzfiNfUa04ecF+0igOa3bZ1WOE/uh4n0YRhY+bg9Np+E9OdwFc
         XoJ90Sk2F5IdFirI0J2L5aLOjVqmtYehY9TbumI8TXO4ix3WxsjAboDvKrPKFrQo7nVn
         IwiPvc3/xjYY/vlvZXI8nUsbxDmjItdv/vqdo/fXkNl/8LvKIAx5Fq6k33h4LTsY7YcF
         GagfphoVecN18dW787Q0YDRNFeJpkq1PHACeyuQlRo8yr3KWGrKjfY2sUhDEyGGAfrab
         w3rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786101704; x=1786706504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mINjklpxtkICORyfJxN/cHIuCc/TZS+0MLm3vqn2bsU=;
        b=AeBBR/jOY5icRr0mi3SOSYWV2Bm8ohjo5i6vzUHTwtOlby/s3F8hQvh6LAbSjcUDQ6
         zvEGHpWBCtoUySBzBl07Pqz+ttzLpb95pGxxApdrTl67Cr+pjKm2U7dP88WH4QTg8h0h
         cHb9mkM4552qp1DKx+OCG5TxgUIxud8yI5wjWIuszvvc8iNj2tXgMC4GR+pXVt4d11Zm
         YEVowFgfezFGiYdo46ZSF7VZde2lnpFHs/C/EDBfllVW8CBlvb95r4Qqyec9YZ2dKU7E
         2dKOVn8kLRW6dgHMaGZRiOKY9dXF+m4x2aNDyOU7P8R7aijE1hnobeammteNmsa+23VJ
         Hc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786101704; x=1786706504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mINjklpxtkICORyfJxN/cHIuCc/TZS+0MLm3vqn2bsU=;
        b=qji5Bo0PlYl/s1nN92Ng3tUTqENso0n7er/IZa61v9ezqzxZZJd7SNNTXbQTjbdGQa
         Ytue0UfQEagpAStICbu7fqp6YZDfqRi61K8kt2Qwc+KDL6c8a9qT3RSs7lSh794/rLAT
         e5MGMJ0wlQca7GlFYkjhXzFtXVsYNsK7AN40/0I55eHTHEzghaszMmyts0p/CNk05q+O
         V5PAZBtyKpCOYY1Zu9v/OcmOHKkrzzVSqc2JS6MhDX8cp/aVH/L03CM5ZkZNEfDIWovc
         vGmGcEZYySh41b9oVm9YoP6o1ZXHO70gR7SFc3ostoGE7IKmmocssU0hgkT95cdwgWmq
         FkOA==
X-Forwarded-Encrypted: i=1; AHgh+RqEUBtGTn2eSSj9nlxHlLTHvm1DqgQBlmDKalp2Z8vgGpk6MpI1GAQ4SI1PMn42MbprUgnFje4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAYvJFXkWlNBAaTOeRJZwT/aFlSDFK7dWKmATqh73Fw563eaL
	2Ti8hV0EEmaWhOVbDSr1DQC/hhkzwfsnYQUNMcB1doGW1VO768eNjiaKZYG0xl0SiJCbHNhMs8a
	wvMYESyFlFjWz147YFzYwxGWFind2kxM=
X-Gm-Gg: AR+sD13uWSeWMCh7WaZEHRglSS8F4NiindD+Q+UNKhpJMuzq1qVp568fLUKjMaWgJ9p
	tku46245qcLtgWo0ahg0nnRIPtwFhc3Ea0IwyFDmf/a17EceIhOWQ0cvxDg/KiNA3GRSJXitQ/2
	AYJbAAUqz8xuDJA3qR2CltNgXGSBnamZPxXnL5HhWjXro2l3UB2DdA7sEJD5q9vJ3ykuoOmC7Em
	MOj29WRGFpImH1bQVpRaHeWGtidvjgMk5kHWIs+fvR8Z+MkkyMIA5DyYV6RemP77c73XvUlnFPy
	yBBiir5EUXMpxv0BtMwDFcvhJ11fzPde5RaJGpl04CJbh0IA2iifW9xMQwO8/SN65/4/DLLOCHm
	o6Y0=
X-Received: by 2002:a05:6808:13c2:b0:495:d9fc:238a with SMTP id
 5614622812f47-4afae30e48cmr7524084b6e.3.1786101704218; Fri, 07 Aug 2026
 04:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-1-170a35b92da1@gmail.com> <anSsOVuekqtrHDbA@gmail.com>
In-Reply-To: <anSsOVuekqtrHDbA@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Aug 2026 12:21:32 +0100
X-Gm-Features: AUfX_mxWlUoYJlld1vFqIGzoqxO5uJw26ROdntN0BlL1ZbKwf0s5zr-_2OK406M
Message-ID: <CAGSyskWqbUd9c9uFsdr4=L-O56cq6qctHVsXiVbS=xzVWBHHHA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netconsole: add an address family to struct inet_addr
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:49=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Wed, Aug 05, 2026 at 10:33:01PM +0100, Gustavo Luiz Duarte wrote:
> > @@ -731,7 +733,7 @@ static void netconsole_print_banner(struct netconso=
le_target *nt)
> >  /* Parse the string and populate the `inet_addr` union. Return 0 if IP=
v4 is
>                                                     ^-> there is no more =
union.
>
> I think there are other references for union that needs to be updated as
> well.

I fixed this in the next patch, but let me do it here for consistency.
I didn't find any other reference to union.

>
> > +static int netpoll_parse_ip_addr(const char *str, struct inet_addr *ad=
dr)
> ...
> >       return -1;
>
> Should the failure path set addr->family =3D AF_UNSPEC?

The failure path leaves addr untouched, so if the user writes an invalid va=
lue
to local_ip or remote_ip the write fails and the original value is maintain=
ed.

>
> > +++ b/include/linux/netpoll.h
> > +struct inet_addr {
> > +     /* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6=
 */
> > +     u8                      family;
> > +     union {
> > +             __be32          ip;
> > +             struct in6_addr in6;
> > +     };
> >  };
>
> Since a1116396476f6 ("netconsole: move local_ip/remote_ip/ipv6 to
> netconsole_target") struct netpoll has no address member, and netconsole
> is the only user left in the tree:
>
>     drivers/net/netconsole.c:   union inet_addr         local_ip, remote_=
ip;
>     drivers/net/netconsole.c:static int netpoll_parse_ip_addr(const char =
*str, union inet_addr *addr)
>
> Since you touched it, can you move it to netconsole headers, please?

Sure, will do it in v2.
