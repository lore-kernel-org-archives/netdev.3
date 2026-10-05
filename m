Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF6D8834
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161389; cv=pass; b=B3uDR7XYhxWzlTemnnULZkXznM3PfdIKVpCfdM9OIKuz0d26i5wWPEgvsrtonp2exUB8IPzbI6w/KoB+8us6flnynrnnxEr/+KuqOzfgZCLKiCHHFhrVaBXSfQgxaktUTWAfO4YxIPXLbCHBCeNQcKhDRZq065rdpiB5lwUH8ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161389; c=relaxed/simple;
	bh=isvt2ytdnzyV6zDiR+IQl/JRc/u5VH11DNTu0koAnh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZVhTF1Z2Tp3JpwrlWMhYZ/Z4QfB78bWGIbGyWgKF6LWjpziGft0vCemw5PS/WAqZCzB15FB5hkiF5I6vzf87Lpbo/yHZS1z+CVR96ymiUv+I1dUeKknYifnrfcpaiQo1BRVluDI3iOFikPrbS45kEx3MDouaSesnJNu+htYPSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQt6EzFE; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQt6EzFE"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so1200307eec.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 17:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791161387; cv=none;
        d=google.com; s=arc-20260327;
        b=DyPBf9jycGl0e3p67BsQcskEDX4/3DPP3RuoFe95w4gexdujDE9C6njKBNLQ4+uC1P
         jiSN5BXfCN3wD2zDNZkUd2G1LngYtVbeEVnRCoAHJ85XNs/pW3BWdjoviISphzJyZEbr
         M9yQVa1PLicKEGeNSFBUF0k+dfj6j23gwkjDLh8oPuuiYfsdASctw/cjdgftgFXraw9z
         Jcrjv4zH6Mu9WARjEXKQ/Ps+fpVqGcMdY4Dqqe+yrBdoqK8UxNdEjlKGXhnOnMGhahVt
         ZwqGnb47J/JCVh8zpe3sgFGJaueHa4+V5VWO4ODqkl3gDVTKzPTrI+tmHNtJ90j27OKT
         9Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7B0gH55E6TihPzgBWeRttMqzXn4zs8KuJtKvrIc2nEE=;
        fh=pcvd1vyQQ6z94U5qwqpvvYt84kg5OmGn0Rw5GOnvOY4=;
        b=lzTFEqfXb1yNgmOrMxP+0L5SeqZNeShV6RZp6m61fIi2zVAy0hTkYqqZBtZmHjLZiN
         8oP/ma9MgY4E5nnP10H9DOEenlg9AIvNR95tMpO7CoJOE/EUKlBTwvQ6kEYKBmYEnKHO
         z2czix4U1URt1NAPCelvuiu4uMJao6ZjQSr0BbizYKu2MOFEGVDrIPFKeLbahb4KaJ5p
         Ye9un66n5muOqiKD2RyE98tlSiowr8YmMs6czxrmHRbCZR7b3Zfq7eJlZPbH88VNovS/
         J/T7d7aTv99G+f6KdJ2AWM3x4cXTWscQ4LySukqlhDD/7qiFKdJpQrcR5wkNVPacYbkc
         6Qhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791161387; x=1791766187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7B0gH55E6TihPzgBWeRttMqzXn4zs8KuJtKvrIc2nEE=;
        b=OQt6EzFE3xDsIWJtsrEvJW+oKqdTw+sVjP//3ds9Hf9d+zAmRQ45T/knaxZ2y7eBXn
         /6uEQUGfUDmsZaJ6HPyV32I/AX3RH28tMHPs+Il/2SsnzO9umb/RuKz7v285kuHjb9kj
         y21rJ0VYVAGo9AbV+7mN5QL63WE/g9IVQ+LO9Fn9rQwMUOsymApaTfcDQozABda8A5Ik
         h2YjlqGNmChpG7Z1s6cD/tuZtWb45npk/rLftxWPSL5bAMUrSXibYcFdmdqn698T+ZUL
         M38kgjLbzRHn6916aFR6aO4giVYhtXPLuD1p/gFxJtrY0D6TnsU+xupJvNFpH73McTNg
         Lnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791161387; x=1791766187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7B0gH55E6TihPzgBWeRttMqzXn4zs8KuJtKvrIc2nEE=;
        b=JhscNe8yIKFPN8SkeXRPNbNocWCcSGrBFAIqUJfhPocjtRQW3M4QVfTCKbJtPG/tg7
         FqYxlVr8ToQqsGPyhtkmERH/4+OVxI40LpMG6EqtUVH1G/kCrGEUF6XLNZIuPQquFPI8
         wAqxZ/Ry3Xetude8KBh/KnhvDPvwTXPWV2lnKhls20VqD1k5ZX7tkcHr/ptUAb0c0Mnu
         nbaTg3oeJeuDbW9czSuz9aYMX3dNEkQBs639iXdEjzde6aHEFKZhJ884pBwLjXW72RR4
         HSq653IyXNlVJ549ZZrAgmM8tJyMLa0Z/SfnP06JOsSN/IU3mJtCCJV5fBIu2sxfLlz7
         90qQ==
X-Forwarded-Encrypted: i=1; AKwUvBz040oDfuxOkajnP3w4XyDUiYTpcdriCD24haHQAvzkqXgQiXKmShG2MNeaUZYL1eKbjJOepyg=@vger.kernel.org
X-Gm-Message-State: AFuF++lXLYc0AOVX83xHwcfXgB0AbKlTg+yD79e77VXfDS+mQQPNk+T0
	PyEX2EBAVThGjtMDgPlifTJcRDtE7nlehMgjB5NYy1Kto/LsH7SCQ44SEm77qsUdrLBlUBXNG0E
	aKgZut/xgQsOWja6rfyAYc9yBGVl/w23YoTXXRsrt
X-Gm-Gg: AYBFou1wjEyiI62pHEqsZVkjJA5O8uJ6aSXfVKjX8Uk2yx1HhM9lzpg7Gm3Cdwh1zkS
	gljO8jQv56Fzj+G4MlQAAh5FTVAf68z/2qTwTOt2NSIe8gQmEMcz25SVmumxtxDGhl8QoVMM0Uf
	QPr8e1tDpIZEBnyU4thke/r56tfdWVQzPzS5ImLbgSELzkxhbwJq9+QnjHH0zlDxIwff372WzUb
	fFyG8aVPpKsOQ/SV6HFBcAJF5cBEY3v+eqXhbi/bGgPJyEiAgpkpLHJCHJ0AWPlluD29djV342t
	BDPdPmNPJoDoMMQnKT/I5rjbuSXRlQSh/hJZjDWpk32e+1pwhuzsUGLZISWFQK0hRHfEsVenPxh
	zNdyxOu/yWqNfNO+3ASv/IlPW5VZV7xE1hupdJJoNwTbhU764neUqIHFpP69N2Te573BcPqPRZK
	l3a8lt2bMbsZ7NYf6xGKVpe2HM2oLsIVnLVDQ=
X-Received: by 2002:a05:7022:7f14:b0:148:8aa2:91e2 with SMTP id
 a92af1059eb24-14f5c7e1245mr12751123c88.38.1791161386034; Sun, 04 Oct 2026
 17:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001204752.2572265-7-kuniyu@google.com> <179115494386.434549.7335879058511719741@kernel.org>
In-Reply-To: <179115494386.434549.7335879058511719741@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 4 Oct 2026 17:49:33 -0700
X-Gm-Features: AclHuK8HjvUssgzpNuVQpi8YqnANrT6s6p2zRQ121Hw73Vl_wLHJOV7mw4Bft9M
Message-ID: <CAAVpQUDySDaobjo_yCzzPOqC3WMYbubbct8aC6joeyz6QgJLTg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 6/6] ipv6: Batch rt6_uncached_list_flush_dev()
 in netdev_run_todo().
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 4:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] Use-after-free of the net_device because no RCU grace period
>   separates the uncached-route swap from the device free.
> - [Medium] Uninitialised per-CPU list access in
>   rt6_uncached_list_flush_dev() when IPv6 init failed at boot.
>
> --
>
> ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
>
> This commit stops flushing IPv6 uncached routes from the per-device
> NETDEV_UNREGISTER path. It now does the flush once per batched
> unregistration from netdev_run_todo(), without RTNL. Routes are matched b=
y
> NETREG_UNREGISTERED and are unlinked only after both dst.dev and
> rt6i_idev->dev point at blackhole_netdev. An ipv6_mod_enabled() check is
> added because netdev_run_todo() also runs when IPv6 is disabled.
>
> Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v=
3-0-30493a37b6eb@cloudflare.com/
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 4658e4e16d9dd..4ce128864b8c8 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > @@ -11872,8 +11873,10 @@ void netdev_run_todo(void)
> >               linkwatch_sync_dev(dev);
> >       }
> >
> > -     if (!list_empty(&list))
> > +     if (!list_empty(&list)) {
> >               rt_flush_dev(NULL);
> > +             rt6_uncached_list_flush_dev(NULL);
> > +     }
> >
> >       cnt =3D 0;
> >       while (!list_empty(&list)) {
>
> [Severity: Critical]
> Does this flush need an RCU grace period before the device is freed?

No.

ip6_finish_output2() mentioned below should not happen at this
point, and also nexthop does not wait RCU grace period
after dst_dev_put():

After calling fib6_info_release() at NETDEV_UNREGISTER,
synchronize_net() in unregister_netdevice_many_notify()
makes fib6_info_destroy_rcu() schedulable, and dst_dev_put()
is called there, and rcu_barrier() in netdev_run_todo() waits the
callback to finish, but there is not more synchornize_rcu() for
dst_dev_put() before free_netdev().

fib6_info_destroy_rcu() -> nexthop_free_rcu() -> fib6_nh_release()
-> fib6_nh_release_dsts() -> dst_dev_put()


>
> Before this patch, rt6_disable_ip() called rt6_uncached_list_flush_dev(de=
v)
> during NETDEV_UNREGISTER processing. The synchronize_net() in
> unregister_netdevice_many_notify() ran after that call. So any RCU reader
> that had loaded the old dst.dev was done before the device could be freed=
.
>
> Now the swap happens after the only rcu_barrier() in netdev_run_todo(), a=
nd
> the old device reference is dropped right away:
>
> rt6_uncached_list_flush_dev(NULL)
>     rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
>     netdev_ref_replace(rt_dev, blackhole_netdev, ...)
>         __dev_put(rt_dev)
>
> The in6_dev_put(rt_idev) call can also reach in6_dev_finish_destroy(),
> which drops a device reference synchronously.
>
> netdev_wait_allrefs_any() then checks the refcount before any
> rcu_barrier() or msleep():
>
>         list_for_each_entry(dev, list, todo_list)
>                 if (netdev_refcnt_read(dev) =3D=3D 1)
>                         return dev;
>
> After that, netdev_run_todo() runs netdev_do_free_pcpu_stats(),
> priv_destructor and free_netdev(). The final put reaches netdev_release()=
,
> which calls kvfree(dev) under the comment "no need to wait for rcu grace
> period".
>
> Readers such as ip6_finish_output2() use the device under RCU without
> taking a reference:
>
>         struct net_device *dev =3D dst_dev_rcu(dst);
>         struct inet6_dev *idev =3D ip6_dst_idev(dst);
>         unsigned int hh_len =3D LL_RESERVED_SPACE(dev);
>
> Take a sender holding an uncached rt6 on device X. It could come from an
> IPV6_HDRINCL raw socket, an xfrm6 bundle, or icmp6_dst_alloc():
>
> CPU1                           CPU0
> ip6_finish_output2()
>   dev =3D dst_dev_rcu(dst) /* X */
>                                netdev_run_todo()
>                                  rt6_uncached_list_flush_dev(NULL)
>                                    swap to blackhole, put X
>                                  netdev_wait_allrefs_any()
>                                    refcnt =3D=3D 1, return X
>                                  ...
>                                  kvfree(X)
>   LL_RESERVED_SPACE(dev),
>   dev_queue_xmit()
>
> Can CPU1 then dereference the freed net_device and its tx queues? This
> could happen while CPU1 is preempted inside its RCU section under
> PREEMPT_RCU.
>
> The previous patch in this series, "ipv4: Batch rt_flush_dev() in
> netdev_run_todo().", seems to do the same for IPv4 uncached routes. Would
> a synchronize_net() after the rt_flush_dev(NULL) and
> rt6_uncached_list_flush_dev(NULL) calls, before netdev_wait_allrefs_any()=
,
> close this window?
>
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index a76869ff87cd6..b1dcb5e5da88c 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -158,10 +158,16 @@ void rt6_uncached_list_del(struct rt6_info *rt)
> >       }
> >  }
> >
> > -static void rt6_uncached_list_flush_dev(struct net_device *dev)
> > +void rt6_uncached_list_flush_dev(struct net_device *dev)
> >  {
> >       int cpu;
> >
> > +     if (!ipv6_mod_enabled())
> > +             return;
> > +
>
> [Severity: Medium]
> Is ipv6_mod_enabled() enough to show that rt6_uncached_list was
> initialised?

Yes.

Now inet6_init() runs at fs_initcall_sync() during early boot, where
small GFP_KERNEL allocations do not fail.

The error handling is a leftover from when =3Dm was possible.

Also, other ipv6_mod_enabled() users assume the same, if it
returns true, inet6_init() finished successfully.


>
> ipv6_mod_enabled() only reflects disable_ipv6_mod. The per-cpu list heads
> and locks are set up at the very end of ip6_route_init(), after every ste=
p
> that can fail:
>
> net/ipv6/route.c:ip6_route_init() {
>     ...
>         ret =3D register_netdevice_notifier(&ip6_route_dev_notifier);
>         if (ret)
>                 goto out_register_late_subsys;
>     ...
>         for_each_possible_cpu(cpu) {
>                 struct uncached_list *ul =3D per_cpu_ptr(&rt6_uncached_li=
st, cpu);
>
>                 INIT_LIST_HEAD(&ul->head);
>                 spin_lock_init(&ul->lock);
>         }
>     ...
> }
>
> ip6_route_init() can fail, or inet6_init() can fail before it calls
> ip6_route_init(). In either case the inet6_init() error paths leave
> disable_ipv6_mod unset. Because CONFIG_IPV6 is bool, boot carries on.
>
> The next device unregistration would then run:
>
> rtnl_unlock()
>   netdev_run_todo()
>     rt6_uncached_list_flush_dev(NULL)
>       list_empty(&ul->head)       /* head->next =3D=3D NULL, seen as non-=
empty */
>       spin_lock_bh(&ul->lock)     /* lock never initialised */
>       list_for_each_entry_safe()  /* loads through NULL head->next */
>
> Could this oops with BH disabled and the per-cpu lock held?
>
> The commit message says:
>
>     Note also that netdev_run_todo() cannot be called before
>     rt6_uncached_list is initialised because:
>
> That covers ordering, but not the case where initialisation never
> finishes. Before this patch, the function was only reachable from
> rt6_disable_ip() through the ip6_route/addrconf notifiers. Those are
> registered only after ip6_route_init() has succeeded.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261001204752.2572265-1-kuniyu%40google.com
