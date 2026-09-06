Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F93DE43F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680855; cv=pass; b=SvBK54w4rNqbV76UX9/xAWa2ZqpHdC1ZVZTIuWsS/JVqlr9b3iZJlqJlYGZO5KASkL5Lbp/CZuTmRkAop4Vo4ddj1xQ/VbQXRyNfMcOWW2bBO9lYw99RzB1S8SOBF7ZoKYjS8v8jtHqNZ4hwFnDNDRIEJ5j0+mcSzAKR/lHIek4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680855; c=relaxed/simple;
	bh=QmosLt4Exr3yd3+DbuV4sKo0M0/L5NTz2CezfpDi4X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s15We+X0gPcncpLVwdPx8LbHrwZrkXROl76yTgig6gyljbG/QkcuiQjLPRJAzDE26tTpfVKFVzUm2Rla8V/UmNpwFxKwr906vSov8epjSl78L39A/YCInz8D6Zv1rZf5JZGOMA6vCdVRjxJWzfQN1UoQluesNnd8SuLl2D+9W+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7a8/nrW; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7a8/nrW"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c52d920b8so299102566b.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 00:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788680851; cv=none;
        d=google.com; s=arc-20260327;
        b=DAF9FpdIdYeQsZiZsVVgfpTxFVUT58ob+Q/GfHQnYu2WvPjWy8a3DaCke7rbHYwJrJ
         XCovkr1pXcPqvZe8teO4eOUUUeplM0i6f0eNzquDU1Y8zqXOFGZ6jFmJ7APjUCyQ8TNl
         TbpS1iGSVNOZur0a6QCHV6Y23xJOsRAnMoAt7ZcM9X3wnP/s6PnG/YLvZnR+4dYb1Z8b
         +sQBv5INDnJ+hf96W78gzEr8daSz4L2tkaM+KXf0e1YlRT9qeDLIjPXV3gixvzMriEud
         IuPU3ut2dsxEZpUe9Wp6zDkv12QhT+V39cA8T+uQNNcj30OAH8r8RRp60tkFlIy69+H3
         1FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JYM+LSAut5hPxwG+oopMKaaGaGA8Dp7pKYI7iVo/2Q=;
        fh=mmAbShqibDtyfmX+wmgVy0eZj1c6znY6IsfzQpGTAqM=;
        b=rKBAKYPhLjW/G792IBbu9f6afLp/8rkBJmv15uMJpYdXAYCWIJ1ZSCLaXZKDw5OVIa
         MfrZ0k4QVNuOBifJp/rsmfBEcm5jBfyD154TFVP6aq39R8Qnd+57LNokCtZmw37lGKO3
         Ddjr7hS6TM1zv+Foeu/8zAuXVZopbHvrZ+RJHrwucJbXzwkZJKg6S45t3vGNRpz8VN0T
         bIj8YxhSeK8UgEH/GSZS5zVnR3qFIHwam03UXyqDGdhBntztJAf0hQYqsxC8Yc9Rbf+T
         MH8bhm8/ezLI3XcFxa1ZNx1R+v5fCGr4BJo13jELQZfSfwGmsFW2UTewIKHblgmGX6TZ
         yn1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788680851; x=1789285651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6JYM+LSAut5hPxwG+oopMKaaGaGA8Dp7pKYI7iVo/2Q=;
        b=q7a8/nrW36aexVJmCqPdyS/bSc1UHO/soq5bIxxh+GY5BC+ZaJInexvOEnLY1FtMfn
         54wlteELOVhjGTkvuqxVhOz9306jHFQSxrhH09hIBLbUHKmxdJVGYxcTaZ1hFRX7cVz5
         +GCVb9YaZWO0O28nXCe9NA3NCXw0U6XGnmPpuz37LpmW5eshW6dfKBEq2BSLKRKUdiI+
         1iYBZ3NuCazcg2BmBlCAvbMX6c880EFWjsG9+fiqFZSIOppr2JtSTAhTuYnHuB0CVnB7
         zsQutyx0ED4MrSAee9JA3IoCDhyfpS3lHDawqQ8lcC3p0xDMeSbTYHMQbdq3aIIzbLyU
         9LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788680851; x=1789285651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JYM+LSAut5hPxwG+oopMKaaGaGA8Dp7pKYI7iVo/2Q=;
        b=q4a3HLb8D6VhrfqigMkg4VIHaxpH6Gp4GsKn2UIF6DbWUHZ44SksI0RSOjg9GNU2NM
         7zXv4L7KgKxLkF2OIx8Dw4nbRMxNxf8+UDFV/hswFWekxT/4baVvDy6AKwycVwfFDgcf
         EgnQuW21DG4blv2c52RyNvr1vor2ONDRBWESr1vziyyg5NQpi9/rx0gllItfxusphaFJ
         glrfkL3u7uCfRKWVI0Hw8xj1BGrvJbeS86f3arb0yz2oNv1Zpe/ciK4aUf8G6A08KuTP
         f8tyHlg+uFcKa2UZL0g8pyYI37IZm8vorDJnL0B/stBB+aQquGdXrNmlbnv405IMWkxy
         eRDw==
X-Forwarded-Encrypted: i=1; AKwUvBzsmlFVej5zvGrrN2Ve3WKyngOGPnAblNcUl624iQR7lCL5S81t5cmqwbp3PbDlFsESr07d1YI=@vger.kernel.org
X-Gm-Message-State: AFuF++lOH6Hdgm8kkOsndtKFF2vof9fSVoBYopYO2bPMb+oiJDqFCCxp
	gzZyYLYaXhSK7DoUcc+0UAESmYlDKGHsYDEg5ATFnoLN8iZly0hltf/OdYHlZ/ERDfYHaHWZrjy
	0EEz8WKVj3cHvsGd6hgatFS06pJaRSik=
X-Gm-Gg: AYBFou0LPpaCeQtRa4Z9+b/28kQUh5r1C0UrYGgcllVM+LEVvv8IJl3xJWb6YP8YO/R
	kCaxXTXRPbidPCXlikwdyKJXtOYCTV36XZaATJT1nqu8gUiuduDRFgi7KjpWFL65xJ/GG2iDP+s
	YN/jBULRdd7Dpk+MOyxIhhlKgrwmcAWuyw6LM/AEHVM5VW4oEYb1qUqhJL7kfoQmq6Ex7LVfxD1
	QJDRTkD3ID08tv8s6CHv1trgwUEINCyFSsuDtYEl+KJ5A/g9HiJXXtXOYTEKCa76qYLPfASugK9
	O81jO8SX9imgEqmBN7fykxYSkbLbhjSce47Ac/dwclJo/HMMY4xLVNA/b7KHoOtAMsXf0O1gzUl
	mtw==
X-Received: by 2002:a17:907:3d44:b0:c27:420b:7c90 with SMTP id
 a640c23a62f3a-c27420ba0camr143467366b.48.1788680851220; Sun, 06 Sep 2026
 00:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906034939.3746540-1-bestswngs@gmail.com> <apzpbMAdqSa_SkEx@strlen.de>
In-Reply-To: <apzpbMAdqSa_SkEx@strlen.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 6 Sep 2026 15:46:54 +0800
X-Gm-Features: AcwNN1UgO9RFEYZ29bttWZXxvvnUa5xtH-e-azRguJk4JvDmub9GiasshRFPr7o
Message-ID: <CANgPUi13MqJ41Rt23zXARUp2UW6K20TJkSbmSEhj7dpmfCsGEA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ip6t_rpfilter: handle routes without inet6_dev
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+459f67f4d8af8ce6@bugs.sh, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw@strlen.de> =E4=BA=8E2026=E5=B9=B49=E6=9C=886=E6=97=A5=
=E5=91=A8=E6=97=A5 12:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Weiming Shi <bestswngs@gmail.com> wrote:
> > ip6_route_lookup() can return an error-free route whose rt6i_idev is
> > NULL.  For example, lowering an external nexthop device's MTU below
> > IPV6_MIN_MTU tears down its inet6_dev while fib6_ifdown() leaves routes
> > using nexthop objects in the FIB.
> >
> > rpfilter_lookup_reverse6() dereferences rt6i_idev before evaluating its
> > loose-mode condition.  This lets an unprivileged user with a private us=
er
> > and network namespace trigger a NULL pointer dereference:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdffffc0000000000
> >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> >   RIP: rpfilter_mt
> >   ip6t_do_table
> >   nf_hook_slow
> >   ipv6_rcv
> >   process_backlog
> >   net_rx_action
> >   handle_softirqs
> >
> > Evaluate loose mode first because route existence is sufficient there.
> > In strict mode, compare devices only when the route has an inet6_dev.
>
> I don't think we should treat rt->rt6i_idev =3D=3D NULL as an eligible
> result, even in loose mode. Maybe this instead?
>
> diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t=
_rpfilter.c
> --- a/net/ipv6/netfilter/ip6t_rpfilter.c
> +++ b/net/ipv6/netfilter/ip6t_rpfilter.c
> @@ -61,7 +61,7 @@ static bool rpfilter_lookup_reverse6(struct net *net, c=
onst struct sk_buff *skb,
>                 fl6.flowi6_oif =3D dev->ifindex;
>
>         rt =3D (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);
> -       if (rt->dst.error)
> +       if (rt->dst.error || !rt->rt6i_idev)
>                 goto out;
>
>         if (rt->rt6i_flags & (RTF_REJECT|RTF_ANYCAST))
>
>

 Thanks, agreed. v2 will be sent.
