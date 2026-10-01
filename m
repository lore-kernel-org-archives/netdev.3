Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AE439F77
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832991; cv=pass; b=bUwa7lY5p6eeyGq6Os/RJqi0AYcZz59om56C8PqhMoPc8Xm+avWKFukyrCUbIAHcjik3W+yd5CjgB1JPgQVXbEErzl3f0/AxNnYFv1JnxMJEcOSE1c0d01tyf5VCLKB7+vKFqJticZMLFwvfNveM/s8Qt9UEmUtsBwjLep7yxHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832991; c=relaxed/simple;
	bh=9LiEV+8DcFq1RTthoE/1hwsS1KF/RSgKiZupPkO0n6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjbxASSDVINTblAj1wlJo5eturG0Ckfi14HuXsuEwte05ZuBHQiAmtwuWdydbIsPs32BKRdV7lc/h742dM/2m4WL8Oz+X3SuHwwWREJnLYPprvytzKvnMlAQxRhuC0y0cDHCwp/QJORq2AZSm55zsWJMbdUjZlRLAQ/as8MrIEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PG/rTWEw; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PG/rTWEw"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148c3a4733fso2186667c88.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790832989; cv=none;
        d=google.com; s=arc-20260327;
        b=ThQZQJ3panpOPgeUVgWtDGMQBJ8biAPIfHTK5akz6H2I93seQSdra5nyS8sVjm/mWJ
         32uRWCwyMXnbf1nOZtNxdp3wgz+YcZLiYbNEkEjdRjMu6loKwA48oXqqWChXQEUsyysb
         ICoKjmhREl6DphanbRxsLbMc8Sk6iwj2kFyLi8qVgbm0Mv9EDF3+CDe/5IUWH04+Duf1
         wY5c3HFaQclx2Hl+gxGv4Y3Bdeo9+73ewFlH/0KrALdtpE6OAr4G6M6ejD51vWis2KoP
         i6udjgPznj8HE9Wg/RRMr3vtL7mhHt5Etnjxj282zMoUeUd67fuiREbakdqeZW8+pBg3
         NZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZ8/I0l3n9Xn6KlfGr5ohN9loKj5Pe6Re5WK9ivT2TQ=;
        fh=QZe4FY9nlWZyKwgUygTysFnolJ3WPOebr2cpvqjZ/kI=;
        b=PA9ClJYIn4+MYppnbULdVuIB7JkThDC0Y4WFxXIloNU0X4Nfwgp7PtZ8mMAUZdCTt3
         e5Sz7XZb7FtTVnYnFY/MekW7omHW5y5q6BZVI5n7eKiqVFq0WZY3lqpaSWNCt/PdwXtu
         h/F9fFzwpOSRxcJ3wlvstLv2HjIvaEzog0XYhfWaX5UgzCxfRJU2rv5UDU5cS4xz7EV0
         QKMrU2Cs617ustgG0a7rKK/b7w9weQHRoQ9YpmheCFdjrDq5ZG4FP2i/vd+A56HmkM5T
         eIcdfR5wR725nmj78TW0Zq2++H+F5umCT1aB50Ys7EPdE9YKgrbKMz65sH1QUfeg934Y
         eKuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790832989; x=1791437789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KZ8/I0l3n9Xn6KlfGr5ohN9loKj5Pe6Re5WK9ivT2TQ=;
        b=PG/rTWEw7tnKz51cZQb3pw6bbA0tOVfyOf7qEdHhw3umn0tsWy+uduHhboXLrQ2OHZ
         1XE+44p//SsR0528HPm9f6AxaGYLTbZuZ1bkKIE659fjq+3Ss5N74j1Y2Z5Y6RgzaSpO
         qME+MdkQscBuWr59543gLjjryrk+nY0MtbubnuIfAvmx+g0stmJKz4/WhY7WJ/pU2qLL
         JrZSLuav9cwOeAYDfupZlciXIAeyHYkRiz0Zob5bD/x8IKE7HoumpegRgm0DEgsADmVV
         gwbMVZnqgBxzenth7We0h55S/ttsCzovrsi5tzE7DMeqaC3UfN+uT2don5CqwsbI5Lpp
         nPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832989; x=1791437789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZ8/I0l3n9Xn6KlfGr5ohN9loKj5Pe6Re5WK9ivT2TQ=;
        b=Ysoi6PyhVTuamcxJheULz8BuEqYSJ5Xey59Knp6DK8I/I4878vAXqdS856ITED8aJi
         Aas/kkAlpZuT5wGRGJKi8XeKrYlb8Dktq562V9ZvzDPAWXu653h66WUc+KfPJEbby4Cn
         blSCanK/zCuIjRsPPGDbomBLP7OaADwgVCMgU/RHTrTmb03z8iDiFOR0DVdkzgrZDt83
         5M4I4zvPUsOLEwuVxcgcyZ4/u7WWIYMiKed+bGKhcqIq8SH2zEU1xol7FniEyGIhZv//
         +NwOobf71rzYQHS0MyENV0N88w4zQrNSwRnUeYLnGQsjHb5ZaJv5FvE99b91VnJQ66uU
         XVqg==
X-Forwarded-Encrypted: i=1; AKwUvBzHKqRVY69go7sXc5SAmFVvA3sJq90KGoXzdnCAhGM1oDCN+4xgSJ7Fu7ZFzwVzhltASWYjetU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoJ91ALeFIQi5v/fJl2H9gZCRp5m2k8skcH9RmyXLH+YiXsdEl
	BLgLhsQZO3EO3eS69g9NGhWtxWEIinhiugarvw2EMVtfUrKx6SaHYiEpX6/rRt/58uctSl+Pcb9
	mFiGIm2jPf8DwCWhGOr7wBl6qBU/GgNkBbtJ+TE0+
X-Gm-Gg: AYBFou1cXUerBFxBPItVOtkV8PAH6Gg78YxhV84wZndWsSbzS7j1FZalJa3XVp56wHf
	3Ct6XuIRMWEkG3dBbbmORCl0wDpHzBi5AQgNBdKkV0fj0XPSAYIFJhPsSSAZPluP7L2T+6K8UBJ
	KxUZuNaRdP6k9+usUTXHWv7IPx1hWjL/iPiohGC/3JGqtRxj0t9/m6dtAxKzSSFjnDXTyJdm+P8
	m08CNcqy4bqO9+75zfkHhUvGlta5wywGP9ZXAlvjdK+ztAA0gMP8PaOul181jQg/+KO6lo4q7jq
	DAyP7VA5vYuD1b+PlgspiONRFIXzhOsU8k+Os3Cw+sIF3QOLfwZRbmRgJ5RVduZ/FZR1lJ9TpDp
	yMkET9VFL44kmVvF3+XZOA4DipFIfyyDyuOuk018GzcNomPJxeUvT/eJQk6HG2AFXPg4=
X-Received: by 2002:a05:701b:4194:20b0:143:2973:c08b with SMTP id
 a92af1059eb24-14d32bde0d2mr3563263c88.28.1790832987913; Wed, 30 Sep 2026
 22:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929201546.1533268-3-kuniyu@google.com> <179082091084.434549.1540561487678718082@kernel.org>
In-Reply-To: <179082091084.434549.1540561487678718082@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 22:36:16 -0700
X-Gm-Features: AclHuK-6xP9C-b53cEwK_OOxxbu_JVv5bflDSJZkSV7-FsSF7BWI3PNBKh37weo
Message-ID: <CAAVpQUDt2KX-3hsL1=ppgccGH5ZXNEMpFxVLTbQmwizKBg=1ng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] ipv6: Batch rt6_uncached_list_flush_dev()
 in netdev_run_todo().
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 7:15=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Moving the IPv6 uncached-route flush into netdev_run_todo()
>   removes the RCU grace period that used to follow the device-pointer=E2=
=80=A6
> - [Medium] Build failure with CONFIG_IPV6=3Dn.
> - [Medium] The batched flush reads dev->reg_state twice per route with no
>   consistent snapshot, and another unregister batch can change reg_state=
=E2=80=A6
> - [Low] The new initialization guard `if (unlikely(!ul->head.next))
>   return;` in rt6_uncached_list_flush_dev() (net/ipv6/route.c:172) is a=
=E2=80=A6
>
> --
>
> ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
>
> This patch moves the IPv6 uncached route flush out of the per-device
> NETDEV_UNREGISTER path. It now runs once per batched unregistration from
> netdev_run_todo(), without RTNL. With dev =3D=3D NULL, a route's device i=
s
> matched by reg_state =3D=3D NETREG_UNREGISTERED.
>
> Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v=
3-0-30493a37b6eb@cloudflare.com/
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 9cedc17b5bdc2..0b3213ff56e70 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -11838,8 +11838,10 @@ void netdev_run_todo(void)
> >               linkwatch_sync_dev(dev);
> >       }
> >
> > -     if (!list_empty(&list))
> > +     if (!list_empty(&list)) {
> >               rt_flush_dev(NULL);
> > +             rt6_uncached_list_flush_dev(NULL);
>
> [Severity: Medium]
> With CONFIG_IPV6=3Dn, is the new stub for rt6_uncached_list_flush_dev()
> visible here?
>
> net/core/dev.c doesn't include <net/ip6_route.h> directly. The only path
> seems to be net/udp_tunnel.h -> net/ip_tunnels.h, and that include is
> compiled out when IPv6 is off:
>
> include/net/ip_tunnels.h:
> #if IS_ENABLED(CONFIG_IPV6)
> #include <net/ipv6.h>
> #include <net/ip6_fib.h>
> #include <net/ip6_route.h>
> #endif
>
> So when IPv6 is disabled, dev.c would see neither the prototype nor the
> static inline stub added to include/net/ip6_route.h. Would this call then
> fail with -Werror=3Dimplicit-function-declaration? It would also fail to
> link, since net/ipv6/route.c isn't built.
>
> rt_flush_dev() doesn't hit this, because net/route.h always reaches
> dev.c through net/ip.h.
>
> Should dev.c include <net/ip6_route.h> directly, or should the
> declaration and stub go in a header that dev.c always includes?
>
> > +     }
> >
> >       cnt =3D 0;
> >       while (!list_empty(&list)) {
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index a76869ff87cd6..38261775e7137 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -158,14 +158,20 @@ void rt6_uncached_list_del(struct rt6_info *rt)
> >       }
> >  }
> >
> > -static void rt6_uncached_list_flush_dev(struct net_device *dev)
> > +void rt6_uncached_list_flush_dev(struct net_device *dev)
> >  {
> >       int cpu;
> >
> > +     if (dev && dev->dismantle)
> > +             return;
> > +
> >       for_each_possible_cpu(cpu) {
> >               struct uncached_list *ul =3D per_cpu_ptr(&rt6_uncached_li=
st, cpu);
> >               struct rt6_info *rt, *safe;
> >
> > +             if (unlikely(!ul->head.next))
> > +                     return;
>
> [Severity: Low]
> This isn't a functional bug, but ul->head.next is read here without
> ul->lock. Other CPUs can update it concurrently under the lock:
> list_add_tail() in rt6_uncached_list_add() when the list is empty, and
> list_del_init() in rt6_uncached_list_del().
>
> The list_empty() check just below already uses READ_ONCE(). Should this
> be READ_ONCE(ul->head.next) so that KCSAN doesn't report it?
>
> > +
> >               if (list_empty(&ul->head))
> >                       continue;
> >
> > @@ -175,19 +181,23 @@ static void rt6_uncached_list_flush_dev(struct ne=
t_device *dev)
> >                       struct net_device *rt_dev =3D rt->dst.dev;
> >                       bool handled =3D false;
> >
> > -                     if (rt_idev && rt_idev->dev =3D=3D dev) {
> > +                     if (rt_idev &&
> > +                         (dev ? rt_idev->dev =3D=3D dev :
> > +                          READ_ONCE(rt_idev->dev->reg_state) =3D=3D NE=
TREG_UNREGISTERED)) {
> >                               rt->rt6i_idev =3D in6_dev_get(blackhole_n=
etdev);
> >                               in6_dev_put(rt_idev);
> >                               handled =3D true;
> >                       }
> >
> > -                     if (rt_dev =3D=3D dev) {
> > -                             rt->dst.dev =3D blackhole_netdev;
> > +                     if (dev ? rt_dev =3D=3D dev :
> > +                         READ_ONCE(rt_dev->reg_state) =3D=3D NETREG_UN=
REGISTERED) {
>
> [Severity: Medium]
> If two netdev_run_todo() instances overlap, can these two reg_state reads
> see different values for the same device?
>
> netdev_run_todo() calls __rtnl_unlock() before it sets each device to
> NETREG_UNREGISTERED, and that write is done under netdev_lock(), not
> ul->lock. So batch A can be scanning while batch B updates a device D
> that is on B's todo list. Take a route whose rt6i_idev->dev and dst.dev
> are both D:
>
> CPU1 (batch A, flush(NULL))          CPU2 (batch B, owns D)
> READ_ONCE(rt_idev->dev->reg_state)
>   sees NETREG_UNREGISTERING,
>   rt6i_idev is not swapped
>                                      WRITE_ONCE(D->reg_state,
>                                                 NETREG_UNREGISTERED)
> READ_ONCE(rt_dev->reg_state)
>   sees NETREG_UNREGISTERED,
>   dst.dev swapped, handled =3D true
> list_del_init(&rt->dst.rt_uncached)

Good catch, I'll unlink it only when both devices point to
blackhole_netdev.

And I noticed a similar bug in the current code; if we move one
of dev/idev to another netns, the route is unlinked, and removing
the netns will get stuck until socket releases the uncached route.



>
> By the time batch B's own flush runs, the route is off the list. Its
> rt6i_idev still points at D's inet6_dev, which holds a reference on D.
>
> The NETDEV_UNREGISTER rebroadcasts can't fix this either.
> rt6_disable_ip()->rt6_uncached_list_flush_dev(dev) now returns early on
> dev->dismantle, and the route is no longer listed.
>
> Could batch B then sit in netdev_wait_allrefs_any() printing "waiting for
> D to become free" for as long as something holds the uncached route? The
> window is narrow, but the old code compared pointers under RTNL, so it
> could not race this way.
>
> > +                             rcu_assign_pointer(rt->dst.dev_rcu, black=
hole_netdev);
> >                               netdev_ref_replace(rt_dev, blackhole_netd=
ev,
> >                                                  &rt->dst.dev_tracker,
> >                                                  GFP_ATOMIC);
>
> [Severity: High]
> Is there still an RCU grace period between this pointer swap and the
> old device being freed?
>
> Before this patch, the flush ran from the NETDEV_UNREGISTER notifier in
> unregister_netdevice_many_notify(). That is followed by synchronize_net()=
,
> and later by the rcu_barrier() at the top of netdev_run_todo().
>
> Now the flush runs after that rcu_barrier():
>
> netdev_run_todo()
>     __rtnl_unlock();
>     rcu_barrier();
>     ...
>     rt_flush_dev(NULL);
>     rt6_uncached_list_flush_dev(NULL);
>         rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
>         netdev_ref_replace(rt_dev, ...);  /* drops ref on old dev */
>     netdev_wait_allrefs_any(&list);       /* returns if refcnt =3D=3D 1 *=
/
>     ...
>     free_netdev() / kobject_put()
>         -> netdev_release()
>             kvfree(dev);
>
> netdev_release() frees the device without waiting for readers:
>
>         /* no need to wait for rcu grace period:
>          * device is dead and about to be freed.
>          */
>
> ip6_output() is one reader of this pointer:
>
>         rcu_read_lock();
>         dev =3D dst_dev_rcu(dst);
>
> It then passes dev on to NF_HOOK_COND(), ip6_finish_output() and
> dev_queue_xmit(). Suppose a reader loads the old pointer after the
> rcu_barrier() but before this swap. Can it still be using dev, and its
> tx queues, after they are freed?
>
> The in6_dev_put(rt_idev) branch above has the same problem.
> in6_dev_finish_destroy() drops the netdev reference before its call_rcu()=
.
>
> The previous patch in this series, "ipv4: Batch rt_flush_dev() in
> netdev_run_todo().", uses the same ordering for IPv4.
>
> >                               handled =3D true;
> >                       }
> > +
> >                       if (handled)
> >                               list_del_init(&rt->dst.rt_uncached);
> >               }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929201546.1533268-1-kuniyu%40google.com
