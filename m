Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0D377A93
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406511; cv=pass; b=Aqx9KHzct1C9aKPpbM5xFbESz2xXI2y2clMPlp0EyIHCGUQvPh81s3Rx2jXvo4JazHOiWVdBzdzBPfEmyKvYdh+i9CAKGFGREFYoMucnu+5K/PPYUNxCjySeO0E7UOc93AqnRGFDXDfIvmObSHUecNFVKmGP8Y3BN/xgdBTdOas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406511; c=relaxed/simple;
	bh=GpSHOSmsDafpeJZtKd3L3b2sMuY6b7m/ynRMGXakG6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbxD9mGNTQVxkui2HqPXoJumxBUJfiEZcHkWEq1eHoR0CBzCSgpLsLffdQDdIkplYYNkx5LD7LjO6juTUuIdm2BtTrwC+Zmciy25EAtxkk8Au02v08AKeHVCxXVF8cVZrc8nhWfwdDpMm4cqviVT6fjs/MtcQN6aAvZU3begE7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zt1ckg/A; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zt1ckg/A"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso25745961cf.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790406508; cv=none;
        d=google.com; s=arc-20260327;
        b=chpue4EhIvr9rRxmq5wUR5ALactUSZg1brAdcOkAa5StIIXjfN61Xd3mfL2vBfXl6+
         JpcHWqr+uyNy7H31BHEA0hpx9TSd17TpTqRD8Hb+Cmc/HKI/hcPETG4zrNINNtXQuUSk
         KVlb42iELN+ue0MRyP0U0TTHHXSTjHw/Upyl3NkVs789F4geQamIOq6rS2dSxOCtltSu
         HGCegy8gTHBRElfOELEn9unXbViqvdRTnDYM0OzKPp88Z9g76HzZNRMMCc46GxsmMTlK
         8uoxtF7CBI6ary//9AbleG+gSLjGIrwQ6qoFUBpXAwv9FhkUH2agplEa1bmTL+BatIF3
         NFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTzz9936CoC18hxqQeDgJkYQ/bNcnEH2d501NccNANc=;
        fh=0/Lxdk/BpLTXzzkAoDa+g06NdXonVM88LkHuBAMDWbo=;
        b=K248xYkTnOHlOTR6VaLX8kv+Vyit24p9XxIIsV5kRwxUmO8uebYV0FKB67CGXOl4Tq
         mY0bcGx6392QvxsfRoDIeuuyHP3E4LHczPdWc0HnvI6EAe/YxGs3vIiC/cVSMRJMmNWG
         O4rDrh9jHB1P8e8o4ivhMW+F2dy1+vBtu+PlD8xUrTC44VDl+dz1FbAvex4I5vydKUYF
         D9EfVEqT8WBti80rydFTcSbo3ZgcqmB6WN194W7Cn5Tgq4PN9fTyU89LGbh+6CSGLrZi
         7Y3Fp9sy7LhI+6CSiOQbUP6GCWmZItf7M8tXEKChVc7dXR+CSUaE+x7M/QmQV2N2HVnC
         xSpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790406508; x=1791011308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTzz9936CoC18hxqQeDgJkYQ/bNcnEH2d501NccNANc=;
        b=Zt1ckg/AAsWnkqHrNOxZZ0w7bmY7dXYM8eDIx0lXm+xFRGW1q9S4uZbb6tHph1SBPe
         rT/MU2uI/bvG6LvK99obvOXQxbARXufHdLQhL7oFORn6Wveobc4dPobIfOc4Kvjy22mt
         TyC+QfrF5Ea6DQBxCJDzE9GVEkwx+gH+XyAnk0GCinQDRGms1Z2gTdiCrzTNkYO7a9hM
         v0lmMk2z75wf8OzT67lvmgEM2N6I5nPMaV1OxvhXE+Tjn5Py1R3+xD47+o9fe8i4Lw0x
         Wt3gFZUTyYRZpA4niRP0ZONPdRQ0diFtzvNK2whLxGQzceQUdW7YUln1Qa2orLQHnvHy
         VyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406508; x=1791011308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTzz9936CoC18hxqQeDgJkYQ/bNcnEH2d501NccNANc=;
        b=I00IrHifXIx8S7HSTmBDM/srfjIX+vLYZjCKmYi8nF2I0fvO0a0HsvtMJDHgPiP/tn
         A9/Ujpiz9C7o1iUeBNlguPzvA9UNnpsMV4csX4xXePFrSEpxmXOh9EMVeA14oVSMzf68
         PbmgoXpOd3yKrcW3ERLIWA1OFuNEtdChq/n4+5QUEz7Y20ZLbzIvw3O+ZKQNpPQYrB8S
         QGOCThG4cBiKBACQobi3hkYnFw9qv3ek3SvSD+Fz7x6821JCfcn/l3vEZc1kdP50psVT
         vAEz4j1eA+kHG9K7V9k2WzjiBM/QLc/FAuZhSoWVs4DMomqfa7kbfhuidsLUgfYx8zK3
         3qkA==
X-Forwarded-Encrypted: i=1; AKwUvByV9AIRVRK3/QmdwuBwq7dDFngXa3ONDfcg73MDHJFQnASvwbJ9CZxra2MSd2BhJ+3E1SWIjtA=@vger.kernel.org
X-Gm-Message-State: AFuF++laAW71Bkp36q5MeIwdNum7DW5gdmddgekpDC4JqjerGbf11I2+
	Y+dKi0Tre+af5EAV+kjo6n8OzuMA37S0kig3AN7mNHSZEyHCH24l0KCVoG2tWLq60o+suxcrXut
	2i8e0KCUDNe3QgoEQ6umGKpZSUvweZx4zxIJcUv6T
X-Gm-Gg: AYBFou22ARJecT/mkWov8+L5LvaATZAGbcVeMENGLQvY9sCKzucVVAVIgeaBv8JLBZW
	n/xSucAYY1suDgNj7wEXjJ2K6UUrt9sCHslR/q/0C7MNyov1Y8xXq3lTf4fqklKA5AL4gTNvysH
	8nF8+KddU4cLhkuHx+cQ98nZIj2FtyDWplIKScWJx63lADCz+of0PyBOiFq9cBAPsXFaXBwYgWY
	li+vXp48TQ8S4BQmxmocEF0qQi7YaIq12val2YLo7+LIUVMpECOYecB4388M6IpCV3PnN7DGLzy
	Y/7Sv4b4y8Owiq6ZVL2FLp9uq1VwibWOXkppedBpoQLJtk3xYmxFoXD9pOcToFyydKo1w91AaWt
	WsqL8Rl5sH7wQqK96v+wop84vTuQwNcGnnJnW/E5pMn6HotANxD7tAhtqrCTuKJKesZb9
X-Received: by 2002:ac8:5f13:0:b0:532:c9be:7e52 with SMTP id
 d75a77b69052e-5330b5b8d66mr90990451cf.18.1790406507750; Sat, 26 Sep 2026
 00:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926041832.1649675-1-kuba@kernel.org>
In-Reply-To: <20260926041832.1649675-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 26 Sep 2026 09:08:16 +0200
X-Gm-Features: AclHuK-vjjWNdVERpUh4NLEJDeJVV3xyw8CnWlV_jRNeNjXoPpPOTaWcsWtZGFQ
Message-ID: <CANn89iLdVkThwG0A3tNTd57FdBSNk6xgp0p26f43u3FOBBYnww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: use two lockdep classes for the
 netdev instance lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 6:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> netdev_lockdep_set_classes() puts dev->lock in a separate lockdep class,
> by type (netkit vs dummy etc), with the intent of keeping the instance
> locks of individual devices as independent from each other as possible.
> In practice it does the opposite. lockdep only calls the cmp_fn for locks
> of the same class, so netdev_lock_cmp_fn() never gets a say when devices
> from different classes are nested. Instead lockdep records a dependency
> between the classes, and reports a circular locking problem as soon as
> the nesting happens the other way round, e.g. when devices are unregister=
ed
> in a batch.
>


> We can't put all devices in the same class, that'd be too permissive.
> netdev_nl_queue_create_doit() and netdev_nl_bind_tx_doit() lock
> a virtual device (netkit) before a physical device, without rtnl_lock.
> We can never allow locking in the opposite order even under rtnl_lock.
> cmp_fn cannot enforce this sort of rule: lockdep keys its chain cache on
> the sequence of lock classes, so with a single class both orders hash
> to the same chain and only whichever happens first is validated.
>
> netdev_lock_cmp_fn() itself has another source of false-negatives.
> lockdep calls it from within __lock_acquire(), with the recursion counter
> already raised, so lock_is_held_type() always returns LOCK_STATE_UNKNOWN,
> which means lockdep_rtnl_is_held() always returns true / held.
> Use rtnl_is_locked(), which looks at the mutex directly and does
> work from that context. We may still miss a bad case if some other
> process is holding the lock, not us, but that's better than the
> 100% false negative rate of lockdep_rtnl_is_held().
>
> One last thing, lockdep compares the address of the cmp function,
> so it can't be a static inline - that would work similarly to having
> separate classes, again. Move it to a source file.
>
> Tested by nesting two instance locks from a module, one scenario per boot
> since the first splat turns debug_locks off:
>
>   first       second      rtnl      reported
>   -----------------------------------------------------------
>   virt->virt              no        recursive locking
>   virt->virt              yes       -
>   virt->phys              no        -
>   virt->phys              yes       -
>   phys->virt              no        - (records the edge)
>   phys->virt              yes       - (records the edge)
>   phys->phys              no        recursive locking
>   phys->phys              yes       -
>   virt->phys  phys->virt  no, no    circular dependency
>   virt->phys  phys->virt  no, yes   circular dependency
>   virt->phys  phys->virt  yes, no   circular dependency
>   virt->phys  phys->virt  yes, yes  circular dependency
>   phys->virt  virt->phys  no, no    circular dependency
>   phys->virt  virt->phys  yes, yes  circular dependency
>   virt->virt  virt->virt  yes, no   recursive locking
>   phys->phys  phys->phys  yes, no   recursive locking
>
> (netkit and dummy stood in for the virtual devices, virtio_net and
> netdevsim for the physical ones.)
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v1: https://lore.kernel.org/20260923223545.3815583-1-kuba@kernel.org
> ---
>  include/net/netdev_lock.h | 20 +++-----------------
>  net/core/dev.c            | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 9fb3e93857c3..edd8cc2e2b36 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -110,34 +110,20 @@ static inline int netdev_is_locked_ops_compat(const=
 struct net_device *dev)
>         return lockdep_rtnl_is_held();
>  }
>
> -static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
> -                                    const struct lockdep_map *b)
> -{
> -       if (a =3D=3D b)
> -               return 0;
> -
> -       /* Allow locking multiple devices only under rtnl_lock,
> -        * the exact order doesn't matter.
> -        * Note that upper devices don't lock their ops, so nesting
> -        * mostly happens in batched device removal for now.
> -        */
> -       return lockdep_rtnl_is_held() ? -1 : 1;
> -}
> +void netdev_set_instance_lock_class(struct net_device *dev);
>
>  #define netdev_lockdep_set_classes(dev)                                \
>  {                                                              \
>         static struct lock_class_key qdisc_tx_busylock_key;     \
>         static struct lock_class_key qdisc_xmit_lock_key;       \
>         static struct lock_class_key dev_addr_list_lock_key;    \
> -       static struct lock_class_key dev_instance_lock_key;     \
>         unsigned int i;                                         \
>                                                                 \
>         (dev)->qdisc_tx_busylock =3D &qdisc_tx_busylock_key;      \
>         lockdep_set_class(&(dev)->addr_list_lock,               \
>                           &dev_addr_list_lock_key);             \
> -       lockdep_set_class(&(dev)->lock,                         \
> -                         &dev_instance_lock_key);              \
> -       lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);  \
> +       if (IS_ENABLED(CONFIG_PROVE_LOCKING))                   \
> +               netdev_set_instance_lock_class(dev);            \
>         for (i =3D 0; i < (dev)->num_tx_queues; i++)              \
>                 lockdep_set_class(&(dev)->_tx[i]._xmit_lock,    \
>                                   &qdisc_xmit_lock_key);        \
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0db..a8eb382f40ca 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -568,6 +568,41 @@ static inline void netdev_set_addr_lockdep_class(str=
uct net_device *dev)
>  }
>  #endif
>
> +#ifdef CONFIG_PROVE_LOCKING
> +static int netdev_lock_cmp_fn(const struct lockdep_map *a,
> +                             const struct lockdep_map *b)
> +{
> +       if (a =3D=3D b)
> +               return 0;
> +
> +       /* @a and @b must be of same class - both virtual or physical.
> +        * cmp_fn won't be called for devices of different classes.
> +        *
> +        * For the same class only allow nesting under the protection
> +        * of rtnl_lock. Note that we can't use lockdep_rtnl_is_held()
> +        * here, it always answers UNKNOWN from within lockdep.
> +        */
> +       return rtnl_is_locked() ? -1 : 1;
> +}
> +
> +/* A virtual device can be locked before the physical device it leases
> + * queues from, see netdev_nl_queue_create_doit(). Keep the two kinds
> + * in separate classes so the dependency graph enforces the order;
> + * netdev_lock_cmp_fn() then only has to rule on same-class nesting.
> + */
> +void netdev_set_instance_lock_class(struct net_device *dev)
> +{
> +       static struct lock_class_key netdev_virt_instance_lock_key;
> +

Right, they already get their class and cmp_fn in alloc_netdev_mqs().

> +       if (dev->dev.parent)
> +               return;
> +
> +       lockdep_set_class(&dev->lock, &netdev_virt_instance_lock_key);
> +       lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
> +}
> +EXPORT_SYMBOL_GPL(netdev_set_instance_lock_class);
> +#endif
> +
>  /***********************************************************************=
********
>   *
>   *             Protocol management and registration routines
> @@ -12183,6 +12218,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_pr=
iv, const char *name,
>  #endif
>
>         mutex_init(&dev->lock);
> +       /* see also netdev_set_instance_lock_class() */
> +       lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
>         netif_rx_mode_init(dev);
>
>         dev->priv_flags =3D IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_P=
ERM;

Some virttual drivers (like  tun and wireguard) do not use yet
netdev_lockdep_set_classes(),
I'm not sure if they eventually will.

We might ease their future request_ops_lock =3D true conversion by calling
netdev_set_instance_lock_class(dev) directly inside register_netdevice()

-> No EXPORT_SYMBOL_GPL(netdev_set_instance_lock_class) would be needed.
In fact netdev_set_instance_lock_class couldd be static in net/core/dev.c

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
