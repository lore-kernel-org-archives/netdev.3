Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759803F6C3D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832491; cv=pass; b=dNgbCmS39XdNuF8Ii5TfR3fV0uLfGVe8Ogc43RMANBJkJevbVg5DpE8nqu+UPPXHZ9pqBDSMgfTelLgrrFrG030yv04JoA2c68hIC/gUpcvAmtkQmLAdO3dpSijNEc3P+lvRxyUXuxBdgT/8QBwHyEvHd6fsEvKCiA8gVfdje08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832491; c=relaxed/simple;
	bh=iKYphCbjE82uDmdtrcScGjDpuV23mQifdrEPrZrRZMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blI9dybMMja9mhWtkQtL09d7X42++Qg3UC9qXqhs6E76Yu3G+ViCWijyoJ5v+GZdSXEN3oVvONucG++MEhjJwKTR85+gmDe6PZbieJ3AZhXruWt9p+fZC9R1bYP7zOIYBVhLKT/UCJ7AteOn7waqrOETyNilLzA+GrsuIInsH8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nszgrSGJ; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nszgrSGJ"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so5697860c88.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790832488; cv=none;
        d=google.com; s=arc-20260327;
        b=PrxwZ8KlAA8zHnV7xjJ6eyfZFMK++jRutK/JaE8lIVnNxahcbP7ly5xPfjJ7dSeOH2
         wl0dtlg0lKGWwrnzZA2E6XqhZgEw3aX+vba51iRmUdr9vHeMRS0HFAm2HnUaVoR0r1UA
         LT+O16NQYpAJJht9XLkSDFFnm+ZT+qmcZT+YyVx2jjAPNGOI5Y9GiAEfBpdfpRz8zO6c
         5mkGOq/4mFqkmgJpr3ugPFn7NkoFGsPWfuZ70I2Va5Nyh2o+Rpdv5Vk23FWSTu0PP89C
         xPn8u5SoetN4RHq+nm3neZ6ZQ6HsZQvWgf5AC11c4gJzRoCiLQIV5cfDi2UGWJ3izgqj
         RlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p0pc8KPVapGRIrMA5ZVJiSi4kz9fPrnUycd9DfjW4n4=;
        fh=IRP1UiJmtUP59Ug0wZPbSbZswzFyN1uStMStoJHW2j8=;
        b=jRHw1+5sycaCo665nrAOfwqLbKwXsqDQllOJVbgpuGM1h718NrymLBB8bCbDKuN1YV
         AnMPjeU6shmyuXpGVorQHIOq5IbKmhuCS0SvvOIqCXT6qIIVUR5GDXdeY/tnFytkd9dj
         /I5pVK8O3i8+3KSVYmhnIEXckes+8tv0DcCEbtME5nsVP4tppvwCrlKt+AZ6hmPT1FJr
         zAZdXFrRI4KaGCB7+Xmc3hyVXx7b0NkQlEZdl+2gzD3YpUJ1A+T9N8XZutZQ6b1KY+V2
         pjwjHjXunRpDUMAXq/1nBXj04Soowz9uJLqmcuI5YMAhGFvlItaPh+wrp/mlFdo1+8dI
         7KlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790832488; x=1791437288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0pc8KPVapGRIrMA5ZVJiSi4kz9fPrnUycd9DfjW4n4=;
        b=nszgrSGJgRXHFiwcqEDRstflxxysyURAdoRETpH3/EP2NLrIidrHadMsBxo1fCmYtS
         4OITzZRqzZ+oQHoIZf/Z+wt7HtewVJBgr3ubBSaOWAfLjM1H2XT+QvIU2jT2qwiW4pDy
         clWIelCqmX4HPitfyllsJlXlEJnpjyIDizXFn6PJx6PlbfsIx8DHWxektv/T0nJTrUCd
         Cb7yeYkiNzunyCVdbv8GktnDvuMeEKIolb+WAuB7yi/xoFlV2akmKPd5b7p87k62bDLn
         EDzOnbdXoL5BRa4N8xQlTIZGGeKspz1MIsoBLqtLHChvXc5JBjCMHksdWJHo+XCIK2KU
         +k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790832488; x=1791437288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0pc8KPVapGRIrMA5ZVJiSi4kz9fPrnUycd9DfjW4n4=;
        b=ZsSOUUvRmOVlYGQsO6znq+UJ2geafXUYZwqENCua5VBRD6si9yu/rZ2VUkD12l6IM9
         EZyfA2eWcIkh9Ez8Sig+ii0ALSk8ztZzXnSQcZ7soNG0m9R2OJEmp68EnjoZ7w6NRWf2
         IyqNAW8QVmTW+7e9nomfyGIdLjfCfjcWSjMYOAplKtKWygQcosc76He3n8R9c/AiirTV
         zbZ4mvTg8BYQf2cclDjzFpwVdkMoB08hzB87fxjnacyjJ4VV2aFwbrWsFbCLhsRkyyA+
         jbggGkLXGRrY4X3nIl/kAKCZpiacPNFKQyrGwEkZXIyWNDN56L8GUyMZj8lNv001YkAo
         Rz7A==
X-Forwarded-Encrypted: i=1; AKwUvBxvGdyMYmEHOiPqYKtCflkA+UoJlO9IME0S8bx3o9JEXBlILy9ASBrYYEFjPaeYoqGALvJZAVs=@vger.kernel.org
X-Gm-Message-State: AFuF++mBRkYw91I+k9oCnkSERFxBEc2hH9KLx1Qo5njaZadKHVBiSNp5
	p6GXh1qfpNwsGtHbhyV/OBp1MvTTeuyogYmIA4fkAa3BHF7S215jeq63PGUUKYFW6j3hMVNoyoa
	fJ9Vy4iw4X6Ie5i+XWDsEPWAahkwEoj6gGUtIBad6
X-Gm-Gg: AYBFou0KId8/3EidBQf2d/Tvu2xPV6jV6Vufjsaw6nIMs1ajlJ/0KS9Jt27ZPjGQwZt
	tZhbmr3ftyFLQ8KLkH3E9z03Hrw0p6PpwitxoTGy4L+bo3Ubj0NsWD45/QLVnypZe6EVNWRZ25k
	41A3mr0nSy2mW5QqIMv15YUVuNYQ9GqQuv/keFi5Zwxmwwt0G0IxP2ezJ5Z1puXlrD0LR5rD2e3
	kP/Sjrv9Lf1e/DF/zwLfBBKuR/m8WqrkmPezM8dmozQyHnrOQnril/fd13nrXBBqXTZkI8adWaV
	15ToiHs9yLe3eq7VCt3hXl+KdG4SHxUwNvX4767+lJL6QlYUWgsfNeJBy8Of+/K2M/yhSeLXrGU
	3iUOgrFGl3ircYiRCMXpFX5kpUaxyFWF3lYgESzFLzeuLUEulFjlHhFxu5/em7oUIc9w=
X-Received: by 2002:a05:701b:2096:10b0:143:3617:c595 with SMTP id
 a92af1059eb24-14d2f7e628cmr3394600c88.1.1790832487459; Wed, 30 Sep 2026
 22:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929201546.1533268-2-kuniyu@google.com> <179082090950.434549.10665389618210861393@kernel.org>
In-Reply-To: <179082090950.434549.10665389618210861393@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 22:27:55 -0700
X-Gm-Features: AclHuK_xlyqaXc92H4h85yhIC9CqsnZZWgkmNr_MPHHjLCjqGibOWv9YXU9a7EQ
Message-ID: <CAAVpQUBjMQVgr7ozNfqEJAcfCaf8YwJb+Vi1wqkBWaWQXFdsnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] ipv4: Batch rt_flush_dev() in netdev_run_todo().
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 7:15=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 3 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Retrying the NETDEV_UNREGISTER broadcast no longer flushes IPv4
>   uncached routes.
> - [High] Moving the IPv4 uncached-route device swap from the
>   NETDEV_UNREGISTER notifier into `netdev_run_todo()` removes the RCU=E2=
=80=A6
> - [High] ipv4: NULL pointer dereference in rt_flush_dev() with
>   uninitialized list
>
> --
>
> ipv4: Batch rt_flush_dev() in netdev_run_todo().
>
> This commit takes the IPv4 uncached route flush out of the per-device
> NETDEV_UNREGISTER path. It now calls rt_flush_dev(NULL) once per batched
> unregistration in netdev_run_todo(), without holding RTNL. rt_flush_dev()
> returns early for dismantling devices. When passed NULL, it moves every
> route whose device is NETREG_UNREGISTERED over to blackhole_netdev.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a8eb382f40caf..9cedc17b5bdc2 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -11838,6 +11838,9 @@ void netdev_run_todo(void)
> >               linkwatch_sync_dev(dev);
> >       }
> >
> > +     if (!list_empty(&list))
> > +             rt_flush_dev(NULL);
> > +
> >       cnt =3D 0;
> >       while (!list_empty(&list)) {
> >               dev =3D netdev_wait_allrefs_any(&list);
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index d7da2f1acbb59..1b641901f10dc 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1587,6 +1587,9 @@ void rt_flush_dev(struct net_device *dev)
> >       struct rtable *rt, *safe;
> >       int cpu;
> >
> > +     if (dev && dev->dismantle)
> > +             return;
> > +
>
> [Severity: High]
> Can this call reach rt_flush_dev() before ip_rt_init() has set up
> rt_uncached_list?

This is false positive, and IPv6 checks !&ul->head.next
just because the IPv6 init level is wrong.

Sashiko pointed out a similar one for neighbour changes, and
considering IPv4 modulise effort, I guess I should add a new init
level for IPv6.


>
> The per-cpu rt_uncached_list entries are only initialised in
> ip_rt_init(), which does INIT_LIST_HEAD() and spin_lock_init() for
> each possible CPU. That runs from inet_init(), an fs_initcall. Until
> then ul->head.next is still NULL.
>
> Before this patch, rt_flush_dev() was only reached through
> fib_netdev_event(). That notifier is registered from ip_fib_init(),
> which ip_rt_init() calls after it initialises the lists, so the
> ordering was implicitly safe.
>
> netdev_run_todo() has no such dependency. It runs from rtnl_unlock()
> whenever net_todo_list is non-empty. Any netdev unregistration before
> fs_initcall time would now call rt_flush_dev(NULL) on zeroed lists.
> One example is an earlier initcall that registers a device and then
> unregisters it on a later failure.
>
> In that case list_empty(&ul->head) returns false, because head->next
> is NULL rather than &ul->head. The loop then takes the uninitialised
> ul->lock and enters list_for_each_entry_safe(). That derives pos from
> the NULL head->next and immediately loads pos->dst.rt_uncached.next,
> which is address 0. The result is a NULL pointer dereference during
> boot.
>
> The IPv6 patch later in the series seems to handle the same case in
> rt6_uncached_list_flush_dev() by skipping a list whose head.next is
> still NULL. Should rt_flush_dev() get a similar guard? Or should
> netdev_run_todo() skip the call until IPv4 routing is initialised?
>
> [Severity: High]
> With this early return, does the NETDEV_UNREGISTER that
> netdev_wait_allrefs_any() resends still flush any IPv4 uncached routes?
>
> netdev_wait_allrefs_any() resends NETDEV_UNREGISTER about once a second s=
o
> protocols can drop late references. That reaches
> fib_netdev_event()->rt_flush_dev(dev). dev->dismantle is already set, so
> the first notifier call and every retry now return straight away.
>
> The only flush left for a dying device is the single rt_flush_dev(NULL) i=
n
> netdev_run_todo(). It runs once, before the wait loop, and no grace perio=
d
> follows it.
>
> Can an uncached route with the dying device be added after that pass? One
> possible path goes through xfrm_bundle_create():
>
> xfrm_bundle_create()
>     rcu_read_lock();
>     dev =3D dst_dev_rcu(dst);
>     ...
>     xfrm_fill_dst(xdst_prev, dev, fl)
>         xfrm4_fill_dst()

It seems this happens only for IPv4 since xfrm6_fill_dst() uses
in6_dev_get(), which returns after the last in6_dev_put().

I'll add dev_isalive() check after dst_dev_rcu() in xfrm_bundle_create()
and xfrm_create_dummy_bundle(), then they must finish before
synchronize_rcu() or fail to add a new entry.



>             netdev_hold(dev, &xdst->u.dst.dev_tracker, GFP_ATOMIC);
>             ...
>             rt_add_uncached_list(&xdst->u.rt);
>
> Say the sweep moves dst_orig to blackhole_netdev after dev is read but
> before the new xdst is linked. The xdst then goes onto rt_uncached_list
> after the sweep has already passed that CPU's list, and it still holds a
> reference on the dying device.
>
> Before this patch, synchronize_net() in unregister_netdevice_many_notify(=
)
> ran after the notifier flush, and each retry ran rt_flush_dev(dev) again.
> Nothing now seems to come back to such an entry.
>
> Could unregister_netdevice then loop on "waiting for %s to become free" f=
or
> as long as the xdst lives? For a bundle cached on an idle connected socke=
t,
> that could be forever.
>
> >       for_each_possible_cpu(cpu) {
> >               struct uncached_list *ul =3D &per_cpu(rt_uncached_list, c=
pu);
> >
> > @@ -1595,10 +1598,14 @@ void rt_flush_dev(struct net_device *dev)
> >
> >               spin_lock_bh(&ul->lock);
> >               list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_unca=
ched) {
> > -                     if (rt->dst.dev !=3D dev)
> > +                     struct net_device *rt_dev =3D rt->dst.dev;
> > +
> > +                     if (dev ? rt_dev !=3D dev :
> > +                         READ_ONCE(rt_dev->reg_state) !=3D NETREG_UNRE=
GISTERED)
> >                               continue;
> > +
> >                       rcu_assign_pointer(rt->dst.dev_rcu, blackhole_net=
dev);
> > -                     netdev_ref_replace(dev, blackhole_netdev,
> > +                     netdev_ref_replace(rt_dev, blackhole_netdev,
> >                                          &rt->dst.dev_tracker, GFP_ATOM=
IC);
>
> [Severity: High]
> Does moving the swap here remove the RCU grace period between publishing
> blackhole_netdev and freeing the old net_device?

This is false positive, also free_nh_exceptions() already does the
same thing.

---
pw-bot: cr
