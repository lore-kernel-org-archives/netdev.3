Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC98233944
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960479; cv=pass; b=kW6JpH3BAr6bpyOuh+woA1uNl6WI/C1oohguh1UB7NTLbiKfve52YT0NDMlTR+7oOlZ9MqWClWfbC90d0cFD8/JHVNVBRh/+wMX53z8iBeRrCUKMaRHEU0iOSx47tUruIi/dRbtaw6XDV8e/u7IUA0q9OpPK4D/Z7xqv9qQSIn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960479; c=relaxed/simple;
	bh=FMJTfEik2REb5jKiCuc2p2wkDbrN+dxaRGA6A9oElSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTyrvrGFWpMA8TAEQ4kPO/JdEoDEfjDHs1iEDtumZyC8yLB/dAmzyPF2alFrkSaRkRtLFLR2LYWCzZUOGSznRMIN3UYkFmjqc2rJaYiZO5ls6mV5WDux/qoOoz3rGPF4JOMaHfcfzB+BEqNrkOp/Q2DsUlZwGS7ZgSeYmGKihd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXTNAgTz; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXTNAgTz"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so5635998c88.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 10:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960477; cv=none;
        d=google.com; s=arc-20260327;
        b=XCjU3ITlZXaPdaIfVd4PZ03xRvOmyZwJRzBSp+wMYtaZcspCIk+FJTzV5a2j30ynFf
         XvjF1Gx6uN6Zkobja6fC3YQaTa8uOYv1rNe+upxASxCGdyWaN0mhRiCwHyCZP3XYNkEW
         mb0YPlU5e61jFiscteoaoTxOijiXNc67NJh+gHMzaDGE7DXk2YkC/xP6HqX6mSe6rzQr
         01cCqUnaSIZSeGr+uEnwlEsFOHvddw5DMX8f3j3+wmjuenWLvXBEg1Xb64O3SB9N9Kc2
         XMHtx9/xuCeiNh3QPtjXfjj146KK2Rwz5IqqIzgj3QifqF2IFT+Bf9w08d2Hhw1n+6qq
         szQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElcmOj1vl6IaJkiuKibMtGEuaaI3eP7kPxb3/uSsoc4=;
        fh=FekqWI1sw3vHpgHq8+kSbcr0Tpu2Cc+aDbnGDCVZXAk=;
        b=XWDs8mQXVTCnmJ8GrrHEMjhV2a9qFjngt2ES4H9ktWxohu3wfCUPle4PoBQ9MBfgvd
         WZjoVLW6psg9Gx636FjOQ8Ae/h217Dej7sVQBQDmW2IW2uirYWj5beoHqrp6UE0eQtG9
         i000uNQZT5RiWLXbRV34s1N4XExYbRzxxpHBDX//n7PWDJzEAp6atQS7mRTowPyqobc7
         LpLGQvs7MWy/9S37gGfrCTOuYGjZLjx4Q6QJF9qUx3wkOViXUMM9euw7uYYurXliFof5
         aSuzTrr2x7K+pcH5hg94lHBAC+NsoOF58QxWQiiyDlxNhnA5dv0YaKpW+7Chwg5byStU
         KBUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790960477; x=1791565277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ElcmOj1vl6IaJkiuKibMtGEuaaI3eP7kPxb3/uSsoc4=;
        b=DXTNAgTztFvWjju4+YnnwpGANILvn+LEuqhpaFg+6G70cMXEizq2e9fUZn6U3Fj7HE
         MBp1CauIEjvxpJZc7kKYhNL3aWYLYGdjjRNxwGBv5pzTze70uk3jM0zv/iOQLl5tCgb2
         oG8xTorigN2NMv7+tZWzUzoMj22hU5msQI9MAvPVttnXCnbTsbOIR/DGx8gMPc6e9Mia
         zHUXY3FBZDQmarjPI8ceJLavq3hI6r0MTPvQhq++YITATI7ugMqGcp3+TpSxFESE3pKL
         IAE/WxWVXvlDxQRK0aZDNKAf0ur0EYp9fpJWL54d8Q/gNyY4Xn686og91x6XLALhirdb
         n1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960477; x=1791565277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElcmOj1vl6IaJkiuKibMtGEuaaI3eP7kPxb3/uSsoc4=;
        b=jynqk54dreT3RtUDN5YYp8WaKbGpaTCTN5mRODhbLr0VhTo4+TCeymZLpzLT89MTAf
         R7nBAd+Z/Th6us1gNV1o6svbSf7y36zLAsoGLlI6XihJHvx3bHnKpO01vFTGWRkKaFOO
         BXdSma6PGDH+Gkf4Py4knzUxxg73QXuzWcqJE5xzwLFSf1+M941boQ6JdjPge1ETnFNT
         jkhHd5gkgm3h3pmPjBJbKbNFSqiLFFF8y8M/lmhntZEk7mTaqcGQEejcYEZ9rr4AJVJQ
         msPjZC97V41Q7XoOhEDT707ulaSjJYMszHmQr+GxS8BGg9QzzvO7iKfxORejRew2T54p
         NrSg==
X-Forwarded-Encrypted: i=1; AKwUvBxkZ/RuC6VXN1oLP5X/7Y4HbsjTvHCxaKVymEHyRHc4Ut2oLkpecFHW0oC+FFmgtv+3CEEL0fs=@vger.kernel.org
X-Gm-Message-State: AFuF++ldMAv1ft+J91cHPpUDFbjp3nI4r4P43d+cgr7o70k6Zy9lblkU
	arq4CPBwUnS9RjemWcTqh0tR8yhpxR1B8D1E0JC2ikJd1Is9HNgOpv/sEJwYcwqYxHBG/dqyyuP
	dagnpNtQpUDJ78aTa5YG6rEmtnioSuQTVwiIwrdvQ
X-Gm-Gg: AYBFou1E8b2ufcZ4+pe44JYtZIUlqIdgqLVxqJYBp6NoZi+efV9TBX0F31TXHDrNUnY
	uEjYshQrdXXc9lb1Lg+40lxvprsit0wS+O3oRnJMuN/jlBDjIyGp6uzmMfmCNnHcIqhaxsKqHKm
	Dx9t+HRD/rNUgxjGQZHRnP/6D/oP4p0H4lBfF8uEsg3KoGXxEtJzE5lx8IGZqyL6j95m1iAuU4F
	Sq1xfDAewHCr3pQwfXFa6F2kNbjMlo8q+i/IZbPVUM539P1nvHGLn2CEDBjE+afFC0vSvrl8Pah
	zCxhySEb45Y0GaG+I5xeSNWIfFqpY80EMoZO1y3D30haH1F70vJFfIr+WYGvniAV/xMSTp5SUhZ
	5FuEKKeaQZa2gNwNnBFbtiBm8J08PtGEMsYhZVStkkcHv6/AP+j7+XbjRl5rZwaEDfIpzhrKwm5
	A3uVcnkbcMxT/cQgiHY6+tRO+GGg==
X-Received: by 2002:a05:7023:a46:b0:147:94bd:18f8 with SMTP id
 a92af1059eb24-14f5cada007mr3953502c88.42.1790960475823; Fri, 02 Oct 2026
 10:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930200326.718459-7-kuniyu@google.com> <179090663305.434549.17214258093385242325@kernel.org>
In-Reply-To: <179090663305.434549.17214258093385242325@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 2 Oct 2026 10:01:04 -0700
X-Gm-Features: AclHuK86vCseCzCWMQ8KYF3B8pPNm3e4esHlLnNCetpYxQFyB4qq8KNqDsxunYw
Message-ID: <CAAVpQUBuN+J6Yt_+BKMiGTUNBwcthT2zQHckFhYyCVM3sR79kg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 6/8] ipv6: Use ipv6_neigh_lookup() and friends.
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	enachman@marvell.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, petrm@nvidia.com, jiri@resnulli.us, 
	ecree.xilinx@gmail.com, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch's bug class is still reachable through sch_teql.
> - [Medium] ipv6_neigh_lookup(), ipv6_neigh_create() and
>   ipv6_neigh_create_noref() choose the table with an unsynchronized=E2=80=
=A6
> - [Low] In mlxsw_sp_router_neigh_ent_ipv6_process() the dev comes from
>   mlxsw_sp_rif_dev(rifs[rif]) and is passed to ipv6_neigh_lookup(dev,=E2=
=80=A6
>
> --
>
> ipv6: Use ipv6_neigh_lookup() and friends.
>
> This commit replaces neigh_lookup(), neigh_create() and __neigh_lookup()
> callers that pass nd_table(net) with IPv6 helpers. The helpers take the
> neighbour table from dev_net(dev). It fixes a syzbot lockdep splat in
> neigh_mark_dead(): ip6_finish_output2() used the caller's net (for exampl=
e
> under xfrm), so a neighbour was inserted into another netns's table.
>
> Closes: https://lore.kernel.org/netdev/6abd69a9.80e1c6cc.22483f.0005.GAE@=
google.com/
>
> > This only happens when a neigh_table accidentally has a
> > neighbour from a different netns.
>
> [ ... ]
>
> > It is error-prone to require callers to fetch netns and
> > neigh_table and pass it with dev to neigh_lookup(), etc.
>
> [Severity: High]
> Can a neighbour from a different netns still end up in a table through
> sch_teql? This patch does not touch net/sched/sch_teql.c, and
> __teql_resolve() still pairs the master's table with the slave device:
>
> net/sched/sch_teql.c:__teql_resolve() {
>     ...
>         n =3D dst_neigh_lookup_skb(dst, skb);
>         if (!n)
>                 return -ENOENT;
>
>         if (dst->dev !=3D dev) {
>                 struct neighbour *mn;
>
>                 mn =3D __neigh_lookup_errno(n->tbl, n->primary_key, dev);
>     ...
> }
>
> dst->dev is the teql master, so n->tbl is the table of the master's netns=
,
> while dev is the slave.
>
> Nothing seems to require the two to share a netns. teql_qdisc_init()
> checks only hard_header_len, m->dev =3D=3D dev and TC_H_ROOT. The teql Qd=
isc_ops
> are registered globally. teql_master_setup() also does not make the maste=
r
> netns-immutable.
>
> With the master and slave in different netns, ___neigh_create() links the
> new neighbour into the master-netns table's hash. It also adds it to the
> slave's dev->neighbours[] through neigh_get_dev_table(). For IPv6,
> ndisc_constructor() takes n->parms from the slave's in6_dev, so the
> parms->dead check passes.
>
> When the slave later goes down in its own netns, this path runs:
>
> neigh_ifdown(nd_table(dev_net(slave)), slave)
>   neigh_flush_dev()
>     neigh_flush_one()
>       hlist_del_rcu(&n->hash)
>       neigh_mark_dead()
>         lockdep_assert_held(&n->tbl->lock)
>
> Only the slave-netns tbl->lock is held there. Would that give the same
> splat as the syzbot report, along with unlocked changes to the other
> netns's hash and gc lists?
>
> The later commit "neighbour: Remove __neigh_lookup() and
> __neigh_lookup_errno()." in this series appears to keep
> neigh_lookup(n->tbl, ..., dev) and neigh_create(n->tbl, ..., dev) here.
>
> Three possible directions:
>
>   - resolve the table from dev_net(dev) by family
>   - reject cross-netns slaves in teql_qdisc_init() with
>     net_eq(dev_net(dev), dev_net(m->dev)) and make the master
>     netns-immutable
>   - reject n->parms->tbl !=3D tbl under tbl->lock in ___neigh_create()
>
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/dr=
ivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > index ba8a7a44ce9ed..1f4753213b9cb 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>
> [ ... ]
>
> > @@ -2464,9 +2462,8 @@ static void mlxsw_sp_router_neigh_ent_ipv6_proces=
s(struct mlxsw_sp *mlxsw_sp,
> >               return;
> >       }
> >
> > -     tbl =3D nd_table(net);
> >       dev =3D mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
> > -     n =3D neigh_lookup(tbl, &dip, dev);
> > +     n =3D ipv6_neigh_lookup(dev, &dip);
>
> [Severity: Low]
> Is dev guaranteed to be non-NULL here? mlxsw_sp_rif_dev() can return NULL=
:
>
>         if (!rif->crif)
>                 return NULL;
>         return rif->crif->key.dev;
>
> The loopback RIF's crif is allocated with mlxsw_sp_crif_alloc(NULL), so i=
ts
> key.dev is NULL.
>
> Before this change, neigh_lookup(tbl, &dip, NULL) only hashed and compare=
d
> the dev pointer. ipv6_neigh_lookup() evaluates nd_table(dev_net(dev)), so=
 a
> NULL dev would now be dereferenced.
>
> In practice, host entries are only programmed on RIFs found by
> mlxsw_sp_rif_find_by_dev() from n->dev. __mlxsw_sp_router_neighs_update_r=
auhtd()
> also holds router->lock for the whole dump. So this looks reachable only =
if
> firmware returns a record the driver never programmed.
>
> Would a NULL check on dev before the lookup be worth adding for robustnes=
s?
> The IPv4 counterpart in "ipv4: Use ipv4_neigh_lookup() and friends." appe=
ars
> to follow the same pattern.
>
> >       if (!n)
> >               return;
> >
>
> [ ... ]
>
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 8baac4d852518..ea9f0a4c34f97 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -218,7 +218,7 @@ struct neighbour *__ip6_dst_neigh_lookup(const stru=
ct in6_addr *gw,
> >       if (n)
> >               return n;
> >
> > -     n =3D neigh_create(nd_table(dev_net(dev)), daddr, dev);
> > +     n =3D ipv6_neigh_create(dev, daddr);
>
> [Severity: Medium]
> Can the table chosen inside ipv6_neigh_create() go stale before the
> neighbour is inserted? The helper reads dev_net(dev) without
> synchronization:
>
>         struct neigh_table *tbl =3D nd_table(dev_net(dev));
>
>         return neigh_create(tbl, pkey, dev);
>
> Under tbl->lock, ___neigh_create() only checks the following. It does not
> check that dev is still in tbl's netns or that n->parms belongs to tbl:
>
>         if (n->parms->dead) {
>                 rc =3D ERR_PTR(-EINVAL);
>                 goto out_tbl_unlock;
>         }
>
> Consider a preemptible process-context creator, such as a dst_neigh_looku=
p()
> caller that reaches __ip6_dst_neigh_lookup() outside RCU:
>
> creator
>   ipv6_neigh_create(dev, ...)
>     tbl =3D nd_table(dev_net(dev))   <- old netns
>     <preempted>
>
> __dev_change_net_namespace()
>   NETDEV_UNREGISTER
>   rcu_barrier()
>   dev_net_set(dev, new_net)
>   NETDEV_REGISTER                  <- new in6_dev
>
> creator resumes
>   neigh_create(old_tbl, ...)
>     ndisc_constructor()
>       in6_dev_get(dev)             <- new in6_dev, live parms
>
> The new parms are live, so the dead check passes. The neighbour is then
> linked into the old netns's table and onto dev->neighbours[]. A later
> neigh_ifdown(new_tbl, dev) would change old_tbl's hash and gc lists witho=
ut
> old_tbl->lock. That is the same state described in the commit message.
>
> The rcu_barrier() in __dev_change_net_namespace() does not exclude a
> non-RCU process-context reader like this. The window is narrow and there =
is
> no reproducer.
>
> Would a check under tbl->lock in ___neigh_create(), for example rejecting
> n->parms->tbl !=3D tbl with -EINVAL, close this window? It would also cov=
er
> the sch_teql case above.

Good point, will update v2.

---
pw-bot: cr


>
> >       return IS_ERR(n) ? NULL : n;
> >  }
> >
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260930200326.718459-1-kuniyu%40google.com
