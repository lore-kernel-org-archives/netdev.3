Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DF4A49B5
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005843; cv=pass; b=NzOgt/kgrF6E/CDdAnjVdszscIg4yf7M5DZWXwCq3HevNFin1ksljmZTfsxJya/pcweM/cstYeNuYlZTF2JxJUBfOqkawgOccpfQxLEUxu6hahLIeZPQrrrX0s6VPSp/Q2LUtN7LsZFOf+4En26Q9t3BP5g1/S0CfdSQR+IO7EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005843; c=relaxed/simple;
	bh=Q2N8kLm6wRwCpOk3CgQu50Shbi0J31/wktfMba/FXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AntpbfALyX6Dm4L8GXd5F1qLqiqL4+BSTma7xUitUxna1GVxuuynuFbHIMXIdYoZcWe5NNqkqAQ8KAcjKUSs5RyOSpBU2XW28j9LhehZCb0ikKFFNNNRqeDXHQpnydXf+w0LIf6sJBcWDw2Uy+cPHf/5f+5iF4E1KEx+BfnzmpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ghu7xnjM; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ghu7xnjM"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1649842a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790005837; cv=none;
        d=google.com; s=arc-20260327;
        b=kDfIreV0Xt/FWH4h4l0Qhr2IGlV6ZpOhM8Z9jVONpt8giiXAgzLU+OPbPmIOZGcgyd
         JgAAdkZ1TLdCWkhqmpDwIyg4tEgcdWZgS0Yyhkw8azvVYqMaA87U1IknEQKHYx9ceDx0
         Zv68UngLtueQudaWJZ1KezlwUP1r9TJqoNSmOoiuHt2YXPwzwuSrHBARBXZ18KDEr7i2
         /CdJssOD27NGoMzUNTf2P2h5Sy9ZgaZUuUVfHLKaBovKJyQGHdtk6TUuoaPRekiaFzwG
         +7Hia52JEjKpEV3dZ0gu478IYc0T9vfbiLSMWVpXuvSkf1H1o5W3QCNOI4A9yznvz9sc
         NIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUpIUbD0Y38dahxUTc3kTHdAeYdpZ1UlGgHQuvP+VJ4=;
        fh=3d6TzFUAWeQGrIf3BKsQx/PVu4Dxew+V7CLo6sZQ+8w=;
        b=kBgA+XFvRe5GqM9b3XCe+Btta0aj6PYHh//8YeunVJpZzexCsjiDZ2n7JTwDwYJFoA
         4REImEYkVXmKqjFa3WCcpGQvb0ZjyeCT6KOnuiIPJUvzzl1r1J1TDB1BRudYvy9Ys7kU
         wGtYztrDMV5zCm+T/3upNrOFF5/+MX/hbfZNJ5hBWmcxvHRUIMfiTvN4ecOXyipIJP5K
         r2t7+98Kjfp7p/gbCMfR9P0mnlljRPKKc7S80SgJM+bvnApu2mLZY2+7U3u7ctVbLrqV
         a03s8GhjXIOZmKof2VK0zrPu2CwOoVJVOLhO0csFmyor/FX2PAJ68dY2TUvMohfvJ65a
         u13A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790005837; x=1790610637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUpIUbD0Y38dahxUTc3kTHdAeYdpZ1UlGgHQuvP+VJ4=;
        b=Ghu7xnjMdmdeuI9nc+luoud9PYzoLfn8k9SfMVY8dBYRcWSoBPJj6yloig72/hTfhq
         IR+Vi6uudOtkpE7awJNH1/6hYYirYL/E+Bhh4ugWkPIoZkCdymcWpbMKoPjpjw9Ao/0r
         4EnaqqeqyNlSzcpySjkKuXFneHhj5UBuecLPtyHgZKKpNYZ7m/RBnR4vBbweUXDlkMsE
         Dy3ruJBzJO4wwxFFDKhgI9pIInQYZcTI8UvX/DHzYVhgF9nVJIJ7DYtCogP6H2kYbXKI
         +EdQ3hpfm5woMR3swYDJN+89Mdeh7Q35QLAE2M/llYoP1Yx3FBRJOEtj9/TYrHxY3CKR
         RV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005837; x=1790610637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUpIUbD0Y38dahxUTc3kTHdAeYdpZ1UlGgHQuvP+VJ4=;
        b=JGhIZc+dskI8IB+fdEWXIRuEZxAZfHWK0CIB1JL4vhFaOvdqNgXIN0swBvMR1waP7O
         Q835eD+Am/4X/pqabI94KSAxNiubQizet25Hh5cIw5efYSZAiqZc8tRkNLEIr9Bajm53
         sHmJ3uwWtAhAaAwqxy0ydGviruWVL3eWtR5fBVHAUmau6jcBfGn51FDvwlzZ/4KmfnXv
         O3All+ygD6AXtskOjjGKiugEbRzDXds9tlz0MNa0+ZXABCydTpSwHOrQg2+DWLL/PaZ5
         N2Am/ZjZKfqoR2cO26W/koceJgKnr6tHfPNQwztGJzWjTBppVxxgIcT1pavax8YVLl0S
         IoFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtea4My+q8i8tJ1+Dv84P8QRGZwqLGYSPDy+02mJm7ihwD0YXS6WZ1PI/YIXt+oGVtFk0Ywz0=@vger.kernel.org
X-Gm-Message-State: AFuF++nej06roz7RxDewGRvlYYRDV5JkayuQ8G5O2Crdy25NbBMtmn/T
	o0lOMYFp61l89bC2gRHkr6eUWbicg3WpOe6pEEEgAnLwy0PhCoQ+yFLS/iF1I8mu9aBpJ5juJ9t
	DtMP/FxsQNRhV7dny/TLeNKLz99DOKpDkrashhFu2
X-Gm-Gg: AYBFou2EUW0jLydVAlyA0gMe7GgRL0exnlfgimTjfQJajxqlxYaGc/wT1991B5/8spv
	J80cCWhl9MYTJWHqovbk74R0AcRoGgqjZz7ixm1xHDLxaJ7vg/DW258/ybi9IMu8W3/2V6VNTUP
	TWGrJoVuOeflERbymorrE3R0LnTSYFe7sGmY+hVbo2oKqgyds6Bl8GZGety4LTJB2aqUtGNv85J
	y9VlDxYz/jy3now/sK0lP4tlPciObI+e1L0ZWKQ0o6sqarkzxKfr1qRUiDYQOM1gKIBMGgNiJ4d
	8V6DwpZNwOp+9Lh3S9nOAbAbZEUrzkQGJjl99s2oaT/7J1py93Uk5sXBduRCoLl4pjuxXk4TGd9
	ctzbeEHKmyVR8H699R6qIxpqWRRsgnZAoZnWqBiy0YJ8xcQBDMdM87qEpPosXe2EyJKam/J3KrM
	pMhQFIGm7IMaA4P+mZpTPIQZd2oHkVjIs5
X-Received: by 2002:a17:90b:17cc:b0:39e:135e:130e with SMTP id
 98e67ed59e1d1-39e54af6a0emr16893374a91.3.1790005836132; Mon, 21 Sep 2026
 08:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918082209.2853582-1-kuniyu@google.com> <178997904775.2160803.15157410527748919821@kernel.org>
 <20260921100956.GA2108776@shredder>
In-Reply-To: <20260921100956.GA2108776@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Sep 2026 08:50:24 -0700
X-Gm-Features: AcwNN1Uu3h5HDn00WRS8F1wFoShbL-iSTQCHXYUECPf4zWDmgw6VT-BVEXTKhR8
Message-ID: <CAAVpQUAEdk=T+_prizx4yRXb=VdSYt_WFHzmCeH0CuT1wSedCQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying fib6_info.
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev-bot+sashiko@kernel.org, dsahern@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	marcharvey@google.com, kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 3:10=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Sep 21, 2026 at 08:24:07AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The new guard in rt6_insert_exception()
> >   (net/ipv6/route.c:1732) trusts f6i->fib6_destroying, but that bit is=
=E2=80=A6
> >
> > --
> >
> > ipv6: Prevent rt6_insert_exception() for dying fib6_info.
> >
> > This reorders fib6_purge_rt() so that fib6_drop_pcpu_from() runs before
> > rt6_flush_exceptions(), and adds a f6i->fib6_destroying check in
> > rt6_insert_exception() so a dying fib6_info can no longer gain a new
> > exception route.  The goal is to stop the fib6_info<->exception referen=
ce
> > cycle that stalls netdev unregistration.
> >
> > > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > > index 9ea75703b38d..9ff761962b45 100644
> > > --- a/net/ipv6/ip6_fib.c
> > > +++ b/net/ipv6/ip6_fib.c
> > > @@ -1043,8 +1043,8 @@ static void fib6_purge_rt(struct fib6_info *rt,=
 struct fib6_node *fn,
> > >     struct fib6_table *table =3D rt->fib6_table;
> > >
> > >     /* Flush all cached dst in exception table */
> > > -   rt6_flush_exceptions(rt);
> > >     fib6_drop_pcpu_from(rt);
> > > +   rt6_flush_exceptions(rt);
> > >
> > >     if (rt->nh) {
> > >             spin_lock(&rt->nh->lock);
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index 08bd68f1b5bb..884d9ab0d50d 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -1729,6 +1729,11 @@ static int rt6_insert_exception(struct rt6_inf=
o *nrt,
> > >
> > >     spin_lock_bh(&rt6_exception_lock);
> > >
> > > +   if (f6i->fib6_destroying) {
> > > +           err =3D -ENOENT;
> > > +           goto out;
> > > +   }
> > > +
> >
> > [Severity: Medium]
> > Can this check observe fib6_destroying =3D=3D 0 after fib6_purge_rt() h=
as
> > already set it?
> >
> > fib6_destroying shares one u8 storage unit with three other bits in
> > struct fib6_info:
> >
> > include/net/ip6_fib.h:
> >       u8                              should_flush:1,
> >                                       dst_nocount:1,
> >                                       dst_nopolicy:1,
> >                                       fib6_destroying:1,
> >                                       unused:4;
> >
> > Adjacent bitfields are a single memory location, so every assignment to
> > any of them is a non-atomic read-modify-write of the whole byte.
> >
> > The setter in fib6_drop_pcpu_from() runs with only the table's tb6_lock
> > held:
> >
> > net/ipv6/ip6_fib.c:fib6_drop_pcpu_from() {
> >       f6i->fib6_destroying =3D 1;
> >       mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
> >       ...
> > }
> >
> > One peer writer of the same byte is addrconf_disable_policy_idev(), whi=
ch
> > holds only rtnl_net_lock plus idev->lock and ifa->lock:
> >
> > net/ipv6/addrconf.c:addrconf_disable_policy_idev() {
> >       ...
> >                       rcu_read_lock();
> >                       ifa->rt->dst_nopolicy =3D val ? true : false;
> >       ...
> > }
> >
> > Is there any lock common to both paths?  inet6_rtm_delroute() is
> > registered with RTNL_FLAG_DOIT_UNLOCKED, and
> > ip6_route_del()->__ip6_del_rt()->fib6_del()->fib6_purge_rt() takes only
> > rcu_read_lock() and tb6_lock, so a write to
> > net.ipv6.conf.<dev>.disable_policy on a host route (ifa->rt) does not
> > appear to be serialized against the deletion path.
> >
> > If the disable_policy writer loaded the byte before fib6_destroying was
> > set and stores its copy back afterwards, the bit is cleared again.  A
> > third thread in ip6_rt_update_pmtu() or rt6_do_redirect() that still
> > holds the pre-removal fib6_info would then read fib6_destroying =3D=3D =
0 here
> > and insert an exception after the final rt6_flush_exceptions(), which
> > recreates the fib6_info<->exception cycle and the
> >
> >       unregister_netdevice: waiting for gre6 to become free
> >
> > stall described in the commit message.  The same lost update also lets
> > rt6_make_pcpu_route() re-add per-CPU routes after
> > __fib6_drop_pcpu_from() has run.
>
> It's a pre-existing issue and not a problem introduced by this patch.
> The likelihood of this happening is close to zero.

Agreed.

>
> The current patch needs to be backported up to v5.3 and the issue being
> flagged here is only visible since v6.16 (bd11ff421d36), so either
> handle the issue in a follow-up or in patch 2/2 of v2.

I'd follow up on it.  I might not have enough time to check all bit field
users and locking this week (due to oncall).


>
> >
> > Note the load here is a plain bitfield read with no READ_ONCE(), and th=
e
> > store side is a plain RMW, so this is also visible to KCSAN as a data
> > race.  rt6_multipath_flush() writes should_flush under tb6_lock, so
> > dst_nopolicy looks like the one unsynchronized peer.
> >
> > Would it make sense to give this flag its own storage accessed with
> > WRITE_ONCE()/READ_ONCE() (or to serialize all writers of the containing
> > byte), and to document which lock protects it?
> >
> > The comment above the store in fib6_drop_pcpu_from() still mentions onl=
y
> > rt6_make_pcpu_route() and the cmpxchg() as the counterpart; could it al=
so
> > mention the new rt6_exception_lock reader added here?
>
> I already mentioned this and it's minor.

Yes, I'll follow up on this in net-next.

Thanks !
