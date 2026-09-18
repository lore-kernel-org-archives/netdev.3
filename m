Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221251DAFD
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756914; cv=pass; b=M/2t1xm/tvBVTJOCGbXA9UUobXMjzXiuyOOqC3kG18wyjVjeiRF4/wMAyYuxDLiyrkXiXKeagoRcvp8V2urwoZ2iZ4Q8z5wjo2q/z2SZiGucJg/HQNk8p3j7lOouzRfsBdS0XRzCFQt3zltWAOLin/06YT/QkZg3J7twV9XQP5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756914; c=relaxed/simple;
	bh=Q8kkoI9QqrR4BWwHpqPvOzkefuLSVO6IwXVa5vt71T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvPojtcp4PtgAJrCB/spWL7bnmMc8NuQypZig/MN71VNTNnfnMN3v3guZA49GYPgDzDMLmQ/68fgjupNdF7vPtRxxkeiDWz4aP/THyJC9J3PWkXLUxUV9UvxuNCLLKS3t1JU94he4L7z0tX1L3C4+svlM+32sIr2pi+0XVbFDdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGMIcxpd; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGMIcxpd"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso870882a12.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 11:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789756906; cv=none;
        d=google.com; s=arc-20260327;
        b=VptfMDtS4oO22ostKOKWY78K5bFpOE3GVJ/N3nSIhbJuKiq8R0QsDA2Ulp4l10cJvB
         zSkzxnKbpRxsRYD33pyLz5leAzx4d7JCZVm2FnBv4XwJvEZORqrobJRilTdmY+UJFkQ0
         4eJJqHG7sPZi7thGKIFoD8y7wQT7w96+iGNbwQa610rtFJYEQNJO+LxHv1opiVqceCod
         zHteOmZE0jsejTpxMJyeB568bXP9uywga0FSSJr0SHddjxd97x/sUCNy1cFNzdTk5vPV
         /qMTrch2ZerN42OHe7PvZdvcTGYBs666mK/PFC+KM8mVWgbA0R/br4dyHK4Amr4xpE7p
         y//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yigc03ybrtRAGj7IJjhu02MFv33g38bHvAEAEo9T+Ik=;
        fh=kDtIZ2BBHiXKEWgxTo7IqfYP25EfTJErBMT/looPp1M=;
        b=MT4tMELBAWV5tBQTPgGZ7BRrMhaQV+/ygRkbj1AgeITLJNlxuA4hH9StiqELwJ3I4r
         NGWZ+HK+3dfq5oUBVkJSC4T2lm8CaCXMClXVLLVbRr85QW8LjvZTT+8L2F3l5aKiFJrM
         c3mTabZJl3AaA/L/5bZC4t5rKTwHfUIVmcN5BijVvIUw8CMzGoLRyFT2QoyZTri23Zad
         Cke96++XyfL6mw97l/pVEVAwWZxJ1JybOAGd3fNjKw84vfmSkxpIts/yHKzgQjV3p1mf
         lV/R3vvbVD5TLbsEsyucDFMbNnDTXiJyPkl7eTzun9Usa4S7QvpRCyRi9zeW/chpCkai
         tciA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789756906; x=1790361706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yigc03ybrtRAGj7IJjhu02MFv33g38bHvAEAEo9T+Ik=;
        b=wGMIcxpdidJ4aKILxjbUVKsjPv5RKo3Gp57VVqbrpQi4KuOm6wJO9snh41BR6AzNv9
         LodJnPl0P0nVPvVk6a6SbrL2kAsOxKlNGdBhfve0q7wNL/NOO0l9N4gMFIXKhLmKxYHn
         Ge2So5XSBT1xDZ0ziNtFCCkgoMqSg/nrBmYBM6Z+wiE4/1zLwOFgQIIZN3XuCnnH86CV
         M7lpLtCwjM2xEOxlc69UcxvA4lTQrUQzQLiLNp/D26vOy582rvj/CR/fTC229hGvk0QS
         elSGRV/XXwa05P3eR9sfGXvpqYvIE11urInSdZBrBbaNJDWIsOW+WWKgXLWE2qd5yn0G
         8zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789756906; x=1790361706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yigc03ybrtRAGj7IJjhu02MFv33g38bHvAEAEo9T+Ik=;
        b=Kh2tyauKncftJn1ygivyEg+ruoaZmRfebPl5EbW7NwJz/B/y/I+5PLbFWhrlu9Q1PT
         fU2ldtoxuci+ki9s3iyAVs2BtrAsH9bnpJl9VMBz2dkEGQyayO7/uBZSdk2O33aZermj
         456CmhrJkWNnrcGybYJ33QzPlaIejjlEcxmdJY3YOO7DkKlMAh+6YFtcPj3nB77GAdCZ
         ONn07rqMw2amS2D/Qjk6Ol/UkaCHcgXn5D/NbtS66TJ+YLtlFaQQ6zVDG8mZ6c7wMRJs
         rof7FEbTSfMCeWRXtMTkleWBp9c6VuM2pOVJwdAyfUSKD9QBKNzC1OZqQBT6jwzZDy0R
         UCpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO0dBZXiZ/75u+O3pof+Dd4nF1UrnP8m7qUOs+26KO/5PHibLVARPtpoAaUkaZx5SKPK1gAqE=@vger.kernel.org
X-Gm-Message-State: AFuF++nCE+P14WUdfd/oC/UzE8KKSfCI1FBfGNMOnv0DINN0/3eglXfa
	d9SxdmwJB84NXDEUxfMQJ6d+41Gv1mfnlsElL1nZAx+qrtm4Xu9zvnHL73v4BL4yBoKFwbqKwOh
	3xFKNiAbiVCPIxjl8vzTuJmSN4JubaB+auDGXHH/D
X-Gm-Gg: AYBFou0BfbnJ+jnu/UO0vMnzRoQfldGAo1jbmEMM18HhP6Ly6aTMa7tllHPA0T1ru64
	IeXeu2xOlWMQPE81+/JJhWGOmAqDg/tSapscyYYlvkrd0bMisd+Ta/y1ViF0atAxO6+sRO0k3m7
	ZglTV84mdM2EbB5RbwL+m43mg4qFoY4DRX28jqDVqyqSzZRnf1/oCkZX1lLS0cgNiR130kpMTj0
	+2l0iX09SSR8iSJ7OG4osaB81vWfna6BIYrB359MfJNSexYBnDeF49hxAsY4S7F9G2LRhf/MN3P
	z+0Fn4zj2ZNIZ3B4QtkIbiHRmN7NRg2PnldT1w74GAY1Iag7JyhrLRewiEqOzUX78DFKICWFsiL
	LguvL29i0V3WNFoX5Ne+UnAPxNnBE7Y2IofgMLgwgnRNvVL5lTzA4XGIewMdU+6q1htvGZZ8ajO
	Ivy7FgDDutBrJ+A7VPyMnDmoUvC7aBlvD2
X-Received: by 2002:a17:90b:1647:b0:39e:4498:4863 with SMTP id
 98e67ed59e1d1-39e54f4187emr10996270a91.10.1789756905720; Fri, 18 Sep 2026
 11:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqyIEE5bRoxRyrFZ@20HS2G4> <20260918042110.2581679-1-kuniyu@google.com>
 <aq2B8PSfjn-xau4V@20HS2G4>
In-Reply-To: <aq2B8PSfjn-xau4V@20HS2G4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 18 Sep 2026 11:41:34 -0700
X-Gm-Features: AcwNN1U_wRZ_cMbwfEJmIW3q1Qd9L-P9A846ypz2R_CtNGbxLJdF1kkNVVEz-bY
Message-ID: <CAAVpQUD9NJGR-odxR6om0EWTC++BybAA3uyA8ezip4SJBf-Qpw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: hash uncached route lists by device
To: Chris Arges <carges@cloudflare.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kernel-team@cloudflare.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:24=E2=80=AFAM Chris Arges <carges@cloudflare.com=
> wrote:
>
> On 2026-09-18 04:19:34, Kuniyuki Iwashima wrote:
> > From: Chris Arges <carges@cloudflare.com>
> > Date: Thu, 17 Sep 2026 19:38:40 -0500
> > > On 2026-09-17 22:10:22, Kuniyuki Iwashima wrote:
> > > > From: Chris J Arges <carges@cloudflare.com>
> > > > Date: Thu, 17 Sep 2026 14:38:21 -0500
> > > > > We have observed hung tasks blocked on rtnl_mutex while network n=
amespaces
> > > > > were being removed. The namespaces contained many network devices=
, and the
> > > > > host had accumulated a large population of entries on the global =
per-CPU
> > > > > uncached route lists. A perf profile collected during one inciden=
t
> > > > > attributed most of the cleanup worker's samples to rt_flush_dev()=
:
> > > > >
> > > > > ```
> > > > > 99.92% kworker/u384:3-  worker_thread
> > > > >   `-88.71% process_one_work
> > > > >       `-81.02% cleanup_net
> > > > >           `-81.00% unregister_netdevice_many_notify
> > > > >               `-79.42% notifier_call_chain
> > > > >                   `-78.05% fib_netdev_event
> > > > >                       `-77.92% rt_flush_dev
> > > > > ```
> > > > >
> > > > > For each device, rt_flush_dev() visits every possible CPU and sca=
ns the
> > > > > global uncached route population while its caller holds rtnl_mute=
x. If N is
> > > > > the number of devices, C the number of possible CPUs, and R the n=
umber of
> > > > > uncached routes, the cost is O(N * (C + R)).
> > > > >
> > > > > During namespace cleanup, other processes that issue RTNETLINK op=
erations
> > > > > requiring the RTNL lock can stall until cleanup releases the lock=
.
> > > > >
> > > > > A minimal reproducer is available here:
> > > > > https://github.com/arges/linux-reproducers/tree/main/rtnl-flush-s=
torm
> > > > >
> > > > > This series replaces each per-CPU uncached route list with a hash=
 table
> > > > > using the network device as its key. Each table uses 64 buckets.
> > > >
> > > > This sounds a bit overkill.  Also, this series still leaves
> > > > O(N * C) loops.
> > > >
> > > > Given unregistering a single device is less common than
> > > > destroying netns, I think the right approach should be to
> > > > make the route flush once in cleanup_net() + outside RTNL.
> > > >
> > > > Could you try this change ? (only compile-tested)
> > > >
> > > Excellent, I'll test this and report back.
> >
> > I found a pre-existing issue, which affects the previous
> > diff, so on top of it, please apply this patch
> >
> >   https://lore.kernel.org/netdev/20260918041439.2575935-1-kuniyu@google=
.com/T/#u
> >
> > and this diff :
> >
> > ---8<---
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index d35b66b33bbc..c12e20e07749 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1567,12 +1567,13 @@ void rt_add_uncached_list(struct rtable *rt)
> >  {
> >       struct uncached_list *ul =3D raw_cpu_ptr(&rt_uncached_list);
> >
> > +     rt->dst.rt_uncached_list =3D ul;
> > +
> >       spin_lock_bh(&ul->lock);
> >
> >       if (!check_net(dst_dev_net_rcu(&rt->dst))) {
> >               rt_replace_uncached_list(rt);
> >       } else {
> > -             rt->dst.rt_uncached_list =3D ul;
> >               list_add_tail(&rt->dst.rt_uncached, &ul->head);
> >       }
> >
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 6cffe8440b44..f22793abbbb8 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -155,12 +155,13 @@ void rt6_uncached_list_add(struct rt6_info *rt)
> >  {
> >       struct uncached_list *ul =3D raw_cpu_ptr(&rt6_uncached_list);
> >
> > +     rt->dst.rt_uncached_list =3D ul;
> > +
> >       spin_lock_bh(&ul->lock);
> >
> >       if (!check_net(dst_dev_net_rcu(&rt->dst))) {
> >               rt6_uncached_list_replace(rt);
> >       } else {
> > -             rt->dst.rt_uncached_list =3D ul;
> >               list_add_tail(&rt->dst.rt_uncached, &ul->head);
> >       }
> >
> > ---8<---
>
> Kuniyuki,
>
> I was able to test this diff, the previous diff you sent plus the fixup
> mentioned above. I was able to confirm even greater reduction in contenti=
on
> as measured by how much latency an unrelated process takes when waiting f=
or
> cleanup_net to complete. This makes sense since we don't even need to hol=
d the
> lock when processing those routing entries with your patch.
>
> Some rough average latency numbers with 36 devices, 160k routes, 8 vCPUs:
> - main: 137ms
> - my hashing proposal: 13ms
> - your patchset: 1.8ms
>
> I'd be happy to retest any proposed patches.

Great, thank you for testing !

I will post patches officially once my fix lands in net-next
(so should be after next Thursday)

Thanks !
