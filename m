Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9E344DA8
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016773; cv=pass; b=CSqfGPMgOCEhBqHymepI83UoBbE/Zs2hXS1JoiINahlZ5XqR0+kPQUk2drxSRY1jb6Y0BQ7zy4U6lPr2bSWNtH6Ys3kKyDpcz2edtIXDVlCEDKgSOntRtk2W5vCBel6FU8hugQQ/ChRCkZAJNGmz7Cyr6t8lng1Ly8p1WrGV4Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016773; c=relaxed/simple;
	bh=U6mjhyiRpLaLB9KAl6dmzxU9rY5e4QrHQWmS+UYxkas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLrgtncPt/P6sTNi9jj1lVMf1TZvqOxOYYFUsnph32Jk5fqKxyYIAMcvb4c9qnOVjV//Okj8S8tM0C9EhJV6nib5f1t/i3q512L2AY+O5M/T1yjk/+Ixt/4xoKQLTSPEkL2d6leYdQqf/0nZl3Cd9T5E8Sg832h6kHbEthy8cS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=XJA9w0mJ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="XJA9w0mJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so23604845ad.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 14:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785016771; cv=none;
        d=google.com; s=arc-20260327;
        b=sk6U9peAnwHOA2C/FJ5f+Uth5WtlKv+p01IqKQr5pJiVgUR9HmXyCAW8v3Lo/d9Yc6
         TackbDBnFdzQpT5PhIifqeuYd7EWkPSchELBFpGs+WCneu8WWH79XKfQ1S5dUPRoT2F8
         CtPaZutQcLpAiZovhjbkz3DZShFsl5ZyNq0Om5DwHXtylELbU68kLjLlB4dw1P6I1VbA
         ZB5mUwO2lGbWZa4VaNVs7vFoUKKnHYy4/pH4EkmsvLfLouhp9dM/xazBKQTEBHOuUXkl
         JQaPhoEofBuoFs3gOjzEfSKF/MtBUEu6yySGtuE2Pq2fu6FuKsHYUF3briC1EMtiqspe
         6N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=604Ldio6O4k/Z0kUfQq96pKAmoGJa7Roa+RxaLoogKE=;
        fh=iBm1ZufDG0/TM5QUHAFeFEzYQT3npPzQPCYNSg4UaD8=;
        b=UmaFS4hjDSbqYLobfw6KT4PraWAxKdteReWIrIeVALHPzm3gUc5CL3TiMapLT9xVbj
         HbLMr+/MB1+FzC8qW220uv1q3dfw+c7/kkOhs7ApSsj00AsUOyP4GgP5BoSx6ZiC0gx7
         zrBvlkZF2WOKAe/lbNgA6bVZbkRjkQW6P6Sa+y8LgQrXmolsH6L0jTmdHiYs8ty0WL/0
         TxcN3E47kAmvjTfbtneSDEFFLL/++w4NaHhxI1/H3ELtFscU5sR12b/vpRrqbY/Dxapw
         kdeOenEwdNaQOkz8IUHKW+6P00AcxYxXvAVy9uWN0NRdbxIxvmFiPsra0ZcIBk2N0tkT
         0BhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785016771; x=1785621571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=604Ldio6O4k/Z0kUfQq96pKAmoGJa7Roa+RxaLoogKE=;
        b=XJA9w0mJDIduKhHmvKIEBwAV+1gEIKl58UyJcfEO8fl+08sceANZaaRxDqvhHSUbvW
         84LnCgWSkSBOMrA26ZZ7w3j/byzBgSiC/kgqDnAWZITGD2021XQH6zsOxrf7nVjbCunP
         Eu6MZQHUMnr/TCv0IExNoT/WG9pCfU4IkriBLXkq5Q3mcv9+HOK3dLOjCOsVWjCGDQZD
         ZLeJuuYWyO1EQlj/btZSHUIJ8qduIvz4syzaYIy4azpv7WmDPRb1hjRFnG4G4aArKyug
         fIgVZ7Xl0YgNa+QOqRLQGrlw3A/CqV9W7RUz1KyjeKiyhHbeHYMfuzcAN4hZ9lMiJxkw
         6FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785016771; x=1785621571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=604Ldio6O4k/Z0kUfQq96pKAmoGJa7Roa+RxaLoogKE=;
        b=kw70GBK2OpupNVhLYIF9Ahuc12PRjsMm+xiOM6GOYMWsbGXpEX1f14Hy3/tFu1AHnU
         QWv/tdXpPKNDfFnmvH8Wox6wzxmuu7ew7WIrnOlGNaQhoZSs730uCHHrAlMcVcYZtz63
         806eeopnq96LYuGuLJCX4Vv8OLtDNypnDGbzVO237qUJwLBrIJsB+wbHq5xT5qztErI8
         gZWYD0ltJmObFcqxwyWt8v09t8f/tJB4r2du2uPCTvBL6rXhskNe6vacjgvl0zEf8qjL
         VsrKecJ7kfpbL2bZT9GcCsUhAAOr8+FRYXQOSK7z2wY/BUI6GZSNKSIW8dvjI05tqLmb
         wspg==
X-Forwarded-Encrypted: i=1; AHgh+Rro3O2hC4a9eZdozSEJR7z7hwXRNZu1Mp/BSPD7OhA/IpN6yN2wg0At+nxFSB1AOlH5y00E774=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HkGwuvcEe1LsbT2fZlHGxYyF7Zrcg47U7rk2oSKi5U4bOchm
	ANOaW7204O0kQjNi0AlcKi8HpI7QjQ/8U3VGUpZIz9eFJLgG+lYbKPUv2w52mta7I4KEkkfEfxJ
	MyKDNGv8LqHMmrz7Fr9o6B/ehC0IOcBQ4fjCgHhZ9McytZzQb76Holl0e
X-Gm-Gg: AR+sD10iQ0wT69+OO2aRDgeUfMFNOsKJTBXFZAtitqE9lY2wB/lRGwfGt8buitoFg3M
	T9UIcJ0PIgjEkjwWpUeE68vkwI+PEeZkby3+A8T/uwpeFEAq7hN+OrTMvCDI0iS1CweRVzgddjZ
	oTCU5JJNYL12afNTPVB1iYZ+Vfx5u6lpVa53t8ysxdVKGvJ/I/pPcNSteS1lkbogGElxX18lZIC
	lr8s1ZPDOQIrEHGlTKk4FkjD2dQfkVaDAUM2GFxfQ23el9+h4XGLH2kUgifot3KLiUB7mV1MoP4
	afC1eroO1+vB/qA+1w==
X-Received: by 2002:a17:903:2bcb:b0:2c8:1c05:16aa with SMTP id
 d9443c01a7336-2cfde7c66b1mr28574475ad.19.1785016771480; Sat, 25 Jul 2026
 14:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722223832.3524006-1-xmei5@asu.edu> <fd5dcd37-c4f8-94de-6fa2-01d30427f63e@blackhole.kfki.hu>
In-Reply-To: <fd5dcd37-c4f8-94de-6fa2-01d30427f63e@blackhole.kfki.hu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 25 Jul 2026 14:59:20 -0700
X-Gm-Features: AUfX_mxqEnB6EYWgu3OUWMFbSignSZXrEFWaUkiAUdm1kVaUAIsQfEtRBnFupLo
Message-ID: <CAPpSM+TZwQGHUX9QnwkOa9ufBueG2g1My=ZsnYxyt_zNL7TUMg@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ipset: fix refcount race between list:set
 GC and swap
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 12:33=E2=80=AFAM Jozsef Kadlecsik
<kadlec@blackhole.kfki.hu> wrote:
>
> On Wed, 22 Jul 2026, Xiang Mei (Microsoft) wrote:
>
> > __ip_set_put_byindex() resolved the index to a set pointer under RCU,
> > then took ip_set_ref_lock in __ip_set_put() to decrement set->ref.
> > ip_set_swap() holds that same lock while swapping both the ip_set_list
> > slots and the two sets' ref counters, so it can interleave between the
> > dereference and the lock acquisition, leaving the caller to decrement a
> > set whose reference already moved to the other index and hit
> > BUG_ON(set->ref =3D=3D 0). list_set_gc() reaches this from timer softir=
q,
> > which the nfnl mutex does not serialize against swap: an expiring
> > list:set member calls list_set_del() -> ip_set_put_byindex() while
> > IPSET_CMD_SWAP runs on the referenced sets.
> >
> > Resolve the index and decrement under ip_set_ref_lock, as ip_set_swap()
> > already does, keeping the refcount tied to the index rather than to a
> > stale set pointer.
> >
> >  kernel BUG at net/netfilter/ipset/ip_set_core.c:685!
> >  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >  RIP: 0010:ip_set_put_byindex (net/netfilter/ipset/ip_set_core.c:870)
> >  Call Trace:
> >   <IRQ>
> >   list_set_del (net/netfilter/ipset/ip_set_list_set.c:159)
> >   set_cleanup_entries (net/netfilter/ipset/ip_set_list_set.c:181)
> >   list_set_gc (net/netfilter/ipset/ip_set_list_set.c:578)
> >   call_timer_fn (kernel/time/timer.c:1748)
> >   __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2374)
> >   run_timer_softirq (kernel/time/timer.c:2405)
> >   </IRQ>
> >  Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 9076aea76538 ("netfilter: ipset: Increase the number of maximal =
sets automatically")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
> Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
>
> Best regards,
> Jozsef

Awesome, thank you for your review!

-Xiang
>
> > ---
> > net/netfilter/ipset/ip_set_core.c | 19 +++++++++++++------
> > 1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip=
_set_core.c
> > index 6cfad152d7d1..16d33c3e28cf 100644
> > --- a/net/netfilter/ipset/ip_set_core.c
> > +++ b/net/netfilter/ipset/ip_set_core.c
> > @@ -679,11 +679,18 @@ __ip_set_get(struct ip_set *set)
> > }
> >
> > static void
> > -__ip_set_put(struct ip_set *set)
> > +__ip_set_put_locked(struct ip_set *set)
> > {
> > -     write_lock_bh(&ip_set_ref_lock);
> > +     lockdep_assert_held(&ip_set_ref_lock);
> >       BUG_ON(set->ref =3D=3D 0);
> >       set->ref--;
> > +}
> > +
> > +static void
> > +__ip_set_put(struct ip_set *set)
> > +{
> > +     write_lock_bh(&ip_set_ref_lock);
> > +     __ip_set_put_locked(set);
> >       write_unlock_bh(&ip_set_ref_lock);
> > }
> >
> > @@ -854,11 +861,11 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_=
set_id_t index)
> > {
> >       struct ip_set *set;
> >
> > -     rcu_read_lock();
> > -     set =3D rcu_dereference(inst->ip_set_list)[index];
> > +     write_lock_bh(&ip_set_ref_lock);
> > +     set =3D ip_set(inst, index);
> >       if (set)
> > -             __ip_set_put(set);
> > -     rcu_read_unlock();
> > +             __ip_set_put_locked(set);
> > +     write_unlock_bh(&ip_set_ref_lock);
> > }
> >
> > void
> > --
> > 2.43.0
> >
> >
> >
