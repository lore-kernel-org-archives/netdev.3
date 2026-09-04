Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F948F836
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540290; cv=pass; b=FEz94QTRDjpntsXyJ2ZK05Es03SHdVRyJxoI7AuTckst9007+txU2vKR+9DKwwN7d9LELYcSdXly313YSKl/CP5vkZn4hw1zRLK671TQVTi/VuRyHN9N2O5b3fEu2raU0cNXrEi+G8p00XACxAjeS8nKm7EceoXZwksKQdVPBTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540290; c=relaxed/simple;
	bh=N00X6pz4I70ksRoiy7iQ9j9wDJ4puqKy6fI1rnWtLX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChxylC8HZ2+52T60ffUmPvRzgn8KqJlwdEHELj143egbEIskpDTBwPo1L2yIL4j2qH1CBk9KVdFaVo5J2cDKDgNXanBzk1B3jWCpy1hYCBgBQ6SPBTcxpGmnAaUTZdkypqPRC/qdOjQrVTyvkgG4PEzFvPmqyRgNx6TfPGD1Zas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTh0kGAE; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTh0kGAE"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f64ea07036so1256919a34.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540286; cv=none;
        d=google.com; s=arc-20260327;
        b=Ufuxq8IeaNAgD338anNeKkoAlqXR9cgNhTc+iV6AWAvBxMb1FPzOBNDFL26PsI7s3Q
         j3zO0ImK+Xa0HTPS4HEZ3wW7pEg3GhfQ2C5eFtl+Et2o98N7X2LLVdu3bWhXo5bRJooc
         BMlx/dfkFtBWiqrEqDCbnaFqGEUqmCynKesN4sWYUUrkOvgn77y7kFeMH/+1tFSCrf+d
         yYQmLApxF5CKJd3i8cK7rZYK34AGu/4VIeNBFalqvaT93aehMUv6x1bnGBqAHhVTwqSv
         OYIpZ8lzp0iY61/VKWALpU2TsOtYBfEViA+ctYwUMf4yCbQt2b2LlPwQGWmG6BPzZ0aD
         qI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hIvAptDzO1J+QAjq41ydJle1hFdMgVNbiKH0hJXnBJQ=;
        fh=Nirl/vosApPvplm9k00miZu9OuLhvLt6mglPH8Pmd8c=;
        b=VQsiyAfR6e3OWlXLAlEWK3BK7j0zNsqwLy7Sucz2RJ8+AYyuRH25Dzv8qqwGUhDJq3
         JH772eUrzwIzEp4uUUQD4eaZDCSx/yGJ4i+RJtSLcj8mxzhWC1XNeDW9pHNeuCGyvN2Q
         7gyoABtE+SIh6FWWPQJGU6va8ZxZWls7I9vgB/41hGaKirmTDjyboZ36EZIjqxELhhli
         a3c5PZRrjQ+zpizz83u1XYv8ixSod1IhUzTghpxHfhTMunKNrkzqz8Wbis2jHSi3HvA+
         2uzh6PFOKU2AQ29g58x037/Z41zQjLWCl1ulMhlVrkORoK8rg/liZfjBdWLf/mOdwgqV
         mEoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788540286; x=1789145086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hIvAptDzO1J+QAjq41ydJle1hFdMgVNbiKH0hJXnBJQ=;
        b=QTh0kGAEoXvXnsmGK7cg+264C7EO+sl0gBy7v3U2dJDyyzwj1wOJVIIbbyjO/YcOLA
         c472Z0MaHsLl1HSZQhty36tttFL607iEqBUtMTOwQCjNWOO/it4kG4HSXKGmr5Jiawk3
         pfCNnfb1oI9gxk00SS0Ne0v0dedOO9gIVEQjaAhokxrd258CkN5VmxJZi8kWybWiHEXU
         vkxqku3Y2PKFXpzi1gmEeAdWpt3DrPeypEKQ6ouNA2vb6k44Wf34sr83Bly22uAt7dJn
         9pIRIiRrUZB0wFWC7gB08WTe6sYaxUjzbQ8AaKn9An8gLDy5t9pbC06fGDdfdEwnEzRe
         kSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540286; x=1789145086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIvAptDzO1J+QAjq41ydJle1hFdMgVNbiKH0hJXnBJQ=;
        b=Mp8BWJ9GR6U+Vqc9sqJzHmsKaqHfq94bX4Uxf7X/O5NqSuC/1lYkqDJnULSXm6lHE3
         qGbEFTIXfvdd+9/HwFCXUMZvS1OkK2hpScWy+dnAieImVqU+tvQRnXY1c9c9dQ1Ur47U
         MJgVK3RhhIKZpqnoNPKHLRKywwLTtHyzcQg9RN3M4Vt81oH9vSCAl0/N6VOqblmsDFho
         kG3amspCxZ4swnsdYweCl1lAwqHXSjmHZ/Mo8WmfVE803awBdcOJeQC8L6uxFkR2ffDw
         ON2u7EbjZtuxO/yZ3quB/WYT9yAtoQX8tAw4Ols/fAiF0bXFgVs+P/Siaox7NgCVAjge
         Egrw==
X-Forwarded-Encrypted: i=1; AKwUvBzODUeHWUjsy67MGv2GhO5h5n+7wbpG+NEBXzi2wGhEi5pJWpg4MkkLNXkinPR1792TU44EJ2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++k01CjjITGbv6rLVTR/OYKrzyVwQuLbMrRhJPQjsbHF0n64gf0N
	LMxSxnSxFJceWv/+2+GDK0jco4ail27dv3ld5nwpP7JKloU3x4i8pQ+wF0zfu+eHp25MsK6FupT
	mslW/xmkl+zAEGF22d9AHirG86FwAcftCjCC3fY+m
X-Gm-Gg: AYBFou2urfeXmBAZRpvLGYO68XhMbJIEG/Daip7e86P43cp+fV7J7Wc75Sn+s1AQHYY
	zkuuA+NE+PJl8bvhknDvHwchl0xNBLNVfWMDORavCbFX9XRpweyRqbkGfchU1W8GmyqY/1izpVm
	u6zXmHXuadtS40m9G5i/4C+XxkQnWoMdcbYSoQocGs86NubssSKxMA3FDAXtXYfg1Oe54dPJ94q
	xXOhnmhGZ27c3IFmx3Wyi/aBnAgG/c0WyiVNH/aMQS0A5N7FkiOqKdo721wQ0S0Qk2qTPnyk+pl
	U227JUK5+/wYNBdKcGo4Vf5zicdZew2GR0e0SV+9lPLV0lZwXREQE95EFGQceOWsXdwf+ye+GXa
	Ag2IU3rSBFSwI+IM7dYNJPkbS+1Uufw8wChx8s0Rx6kmaTLBhibs+asc176TjmitehW2V022Kxa
	EH3MGFqbUF2a9W
X-Received: by 2002:a05:6820:998:b0:6b6:93d6:afcd with SMTP id
 006d021491bc7-6b6fd6c5788mr4816071eaf.26.1788540285315; Fri, 04 Sep 2026
 09:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-13-kuniyu@google.com> <178849140347.4131868.7289933510858041654@kernel.org>
In-Reply-To: <178849140347.4131868.7289933510858041654@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:44:33 -0700
X-Gm-Features: AcwNN1Uy02uwvCbbZxAtla-KhP9gTzPl1k1sAvch-SZd5KaatlfPcwKmp45ctLc
Message-ID: <CAAVpQUBo0zKO9FriDQzHoNe1kkO1vGw6M3bUbZL0sSVoF9rDJg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 12/15] neighbour: Namespacify neigh_tables.
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 3
>
> - [Medium] neigh_table_unregister() (net/core/neighbour.c:1963-1969)
>   retracts the table with a plain store `net->neigh_tables[index] =3D=E2=
=80=A6

This is false positive because at this moment there should be
no reader of net->neigh_tables[].


> - [Low] tools/testing/selftests/net/test_neigh.sh (extern_valid_common)
>   still drives "ip ntable change ... thresh1/2/3, base_reachable" in the=
=E2=80=A6

This is updated in the selftest patch.


> - [Low] The new per-netns neigh_table allocations are not memcg-
>   accounted: neigh_table_register() uses kmemdup(tbl, sizeof(*tbl),=E2=80=
=A6

This could be follow-up if we care.
Also, AI missed neigh_hash_grow().


> - [Low] neigh_table_inherit() copies init_net's gc_interval,
>   gc_thresh1/2/3 and the whole parms.data[] array with bare READ_ONCE()=
=E2=80=A6

No need to lock init_net's neigh_table lock, READ_ONCE()
is sufficient.



>
> --
>
> neighbour: Namespacify neigh_tables.
>
> This makes struct neigh_table a per-netns object: neigh_table_register()
> now kmemdup()s the template table, optionally inherits init_net's GC and
> default parms values, and calls neigh_table_init() plus
> neigh_sysctl_register() for each namespace. A new knob,
> net.core.neigh_inherit_init_net, controls the inheritance.
>
> A few questions on the new allocation and teardown paths below.
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 7dc8f0cdbb45..414422bcc0ec 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
>
> [ ... ]
>
> > @@ -1905,16 +1905,12 @@ static void neigh_table_free(struct neigh_table=
 *tbl)
> >       nht =3D rcu_dereference_protected(tbl->nht, 1);
> >       tbl->nht =3D NULL;
> >       neigh_hash_free_rcu(&nht->rcu);
> > +
> > +     kfree(tbl);
> >  }
> >
> > -/*
> > - * Only called from ndisc_cleanup(), which means this is dead code
> > - * because we no longer can unload IPv6 module.
> > - */
> > -int neigh_table_clear(struct neigh_table *tbl)
> > +static void neigh_table_clear(struct net *net, struct neigh_table *tbl=
)
> >  {
> > -     struct net *net __maybe_unused =3D &init_net;
> > -
> >       cancel_delayed_work_sync(&tbl->managed_work);
> >       cancel_delayed_work_sync(&tbl->gc_work);
> >       timer_shutdown_sync(&tbl->proxy_timer);
> > @@ -1923,20 +1919,61 @@ int neigh_table_clear(struct neigh_table *tbl)
> >       remove_proc_entry(tbl->id, net->proc_net_stat);
> >
> >       neigh_table_put(tbl);
> > +}
> >
> > -     return 0;
> > +int sysctl_neigh_inherit_init_net __read_mostly =3D 1;
> > +
> > +static void neigh_table_inherit(struct net *net, struct neigh_table *t=
bl,
> > +                             int index)
> > +{
> > +     const struct neigh_table *init_tbl =3D init_net.neigh_tables[inde=
x];
> > +     bool inherit =3D READ_ONCE(sysctl_neigh_inherit_init_net);
> > +     int i;
> > +
> > +     if (net_eq(net, &init_net) || !inherit)
> > +             return;
> > +
> > +     tbl->gc_interval =3D READ_ONCE(init_tbl->gc_interval);
> > +     tbl->gc_thresh1 =3D READ_ONCE(init_tbl->gc_thresh1);
> > +     tbl->gc_thresh2 =3D READ_ONCE(init_tbl->gc_thresh2);
> > +     tbl->gc_thresh3 =3D READ_ONCE(init_tbl->gc_thresh3);
> > +
> > +     for (i =3D 0; i < NEIGH_VAR_DATA_MAX; i++)
> > +             tbl->parms.data[i] =3D READ_ONCE(init_tbl->parms.data[i])=
;
>
> [Severity: Low]
> Should this snapshot of init_net's table be taken under init_tbl->lock?
>
> neightbl_set() updates exactly these fields under spin_lock_bh(&tbl->lock=
),
> with the comment:
>
>         /*
>          * We acquire tbl->lock to be nice to the periodic timers and
>          * make sure they always see a consistent set of values.
>          */
>         spin_lock_bh(&tbl->lock);
>         ...
>         WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
>
> An "unshare -n" concurrent with RTM_SETNEIGHTBL on init_net can therefore
> copy a mix of old and new threshold values into the new namespace.
>
> For what it's worth, the same fields are already written without tbl->loc=
k
> via the sysctl path that this patch registers per netns (neigh_sysctl_reg=
ister()
> points NEIGH_VAR_GC_THRESH1..3 and NEIGH_VAR_GC_INTERVAL .data at
> &tbl->gc_thresh1..3 and &tbl->gc_interval with plain proc_dointvec* handl=
ers),
> and nothing enforces an ordering relation among the thresholds, so the
> resulting combination is one an administrator could configure directly.
>
> > }
> >
> >  int neigh_table_register(struct net *net, struct neigh_table *tbl, int=
 index)
> >  {
> > +     int err;
> > +
> > +     tbl =3D kmemdup(tbl, sizeof(*tbl), GFP_KERNEL);
> > +     if (!tbl) {
> > +             err =3D -ENOMEM;
> > +             goto err;
> > +     }
>
> [Severity: Low]
> Should these per-netns allocations be memcg accounted?
>
> Two tables (ARP and ND) are now created for every network namespace, and
> namespace creation is reachable by unprivileged users through user
> namespaces. Besides this kmemdup(), neigh_table_init() allocates
> neigh_hash_alloc(3), kzalloc(phsize, GFP_KERNEL) for phash_buckets and
> alloc_percpu(struct neigh_statistics), the last of which scales with
> nr_cpu_ids for each of the two tables per namespace.
>
> neigh_sysctl_register() in the same file already uses the accounted flag
> for its per-netns allocation:
>
>         t =3D kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCO=
UNT);
>
> Would GFP_KERNEL_ACCOUNT here and alloc_percpu_gfp(..., GFP_KERNEL_ACCOUN=
T)
> in neigh_table_init() be more consistent with that?
>
> [Severity: Low]
> Does this break the forced-GC and periodic-GC subtests in
> tools/testing/selftests/net/test_neigh.sh?
>
> extern_valid_common() still runs the thresholds and counter readback in t=
he
> initial netns while the entries are created inside $ns1:
>
>         run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thr=
esh1 8"
>
> With per-netns tables, neigh_table_inherit() only snapshots values at
> registration time, and setup() creates ns1/ns2 before this command runs, =
so
> $ns1's thresholds are unaffected. The same applies to the
> "ip -j -s ntable show" readback of forced_gc_runs/periodic_gc_runs, which=
 now
> reports init_net's per-netns tbl->stats rather than $ns1's.
>
> The last patch of this series, "selftest: net: Specify netns for ip ntabl=
e in
> test_neigh.sh.", converts these commands to "ip -n $ns1 ntable ...", so t=
he
> only residual effect is a two-commit window where the selftest can fail.
>
> > +
> > +     neigh_table_inherit(net, tbl, index);
> > +
> > +     err =3D neigh_table_init(net, tbl);
> > +     if (err)
> > +             goto free_table;
> > +
> >       net->neigh_tables[index] =3D tbl;
> >
> >       return 0;
> > +
> > +free_table:
> > +     kfree(tbl);
> > +err:
> > +     return err;
> >  }
> >
> >  void neigh_table_unregister(struct net *net, int index)
> >  {
> > +     struct neigh_table *tbl =3D net->neigh_tables[index];
> > +
> >       net->neigh_tables[index] =3D NULL;
> > +     neigh_table_clear(net, tbl);
> >  }
>
> [Severity: Medium]
> Is a grace period needed between retracting the slot and freeing the tabl=
e?
>
> The store is a plain one, and neigh_table_clear() -> neigh_table_put() ->
> neigh_table_free() now ends in kfree(tbl), so the table can be freed
> immediately after the slot is cleared.
>
> Readers load the same slot with a plain load under rcu_read_lock() and th=
en
> dereference it, for example neigh_xmit():
>
>         rcu_read_lock();
>         net =3D dev_net_rcu(dev);
>         tbl =3D net->neigh_tables[index];
>         if (!tbl) { ... }
>         ...
>         neigh =3D __neigh_create(tbl, addr, dev, false);
>
> which goes on to take spin_lock_bh(&tbl->lock), rcu_dereference(tbl->nht)=
 and
> touch the per-cpu tbl->stats. Before this patch the pointer referred to t=
he
> static arp_tbl/nd_tbl, so a stale read was harmless; now it is freed memo=
ry.
>
> Some drivers also cache the pointer in their own state across work items,=
 for
> instance mlxsw_sp_nexthop4_init() in
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:
>
>         nh->neigh_tbl =3D arp_table(net);
>
> I was not able to construct a concrete racing reader: cleanup_net() runs
> synchronize_rcu_expedited() and unregisters all netdevs before the subsys
> exit ops, and the netlink and /proc readers hold a netns reference. But t=
he
> preceding patch, "neighbour: Remove __rcu from neigh_tables[]", justified
> dropping the RCU annotation with "neigh_table cannot be registered
> dynamically", which no longer holds once the slots are published and free=
d at
> runtime.
>
> Would an RCU-annotated store plus kfree_rcu() of the table remove the
> dependence on that ordering?
>
> >
> >  static struct neigh_table *neigh_find_table(struct net *net, int famil=
y)
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
