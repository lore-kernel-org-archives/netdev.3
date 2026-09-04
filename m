Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3291503BCF
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539993; cv=pass; b=SbQQKIrlDP3BnDT/PjydkaTqhThCfcJsKF4cdK0F8lzSWc/pI5TwO1q24Wo7GQyr2OwQrowp7wzxCdwgXWur5cCp/Z+qrpzbx+eBXZ1oxJscMa8Htl0SpHdMjLRjm4q6UxTGm9I9rZn8jwxOPiq0YvqsFVDn1aj0cXP2WbkyHx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539993; c=relaxed/simple;
	bh=UXQHDA//Xgi4Xq5SvEFMG2ChOWfzl6YcNQ6aK1bC3zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGuK0Pfv2Yw0tvOk60QCEEfbvTc4wM3xO3soVQmlmVHPKb4sxQ/bYORTwo0s7ubkoh/UvPFLUuakOq7DYRW8kq1kUHIBs+CuwW9hZ66LL/MDzbOHnHbH3YY2WtN0r5XvkOBqjbJ+bPvWKJzN5n2fv/ea9WstiZSdmuiNjvfjYN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/XlKiKH; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/XlKiKH"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b28d7c729fso977793b6e.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788539989; cv=none;
        d=google.com; s=arc-20260327;
        b=BVC9VP3g0GwAq0tZqVdKe306VCgDrAozUyDgs9pTl+9avORq7de+L9WtuwxfEtEfrh
         Bs2DHyCtw+4zSeq/i4punWwoFydjMqfdDh1n/FMpW2wGMQdbvyv+2TLtmqDcAmrKu+OM
         Vxf4OLqPhvrNybyQLZCUV8WJPs4ZUNslEAI7c/P7jPaunYpo7E2T/6X1IQQOSr3ZSq3u
         rqTLgghtCv0hsBSkpGvrTUz7ljPPy8coSa8MLPsUA94Muw9Qcy44SH6fOo21ADbAOuBU
         m2gTN/Rj4IW7z4YbW4pekiVDZ0vJoIeoxdUCEJ80CprU9q/I7gGfoSzsr38oV6xqhlji
         MFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RofA0hbvv9ASZJURx9yLpYN6t8iWxjME25uhz3es1YQ=;
        fh=LK91fYHjo/OgYzOuPU3dNhSyGKSo5cmvy9Erodobm7M=;
        b=ixVBQxxR2TDL3g8ZssIlnPd0EOUeL4gWDDpS0/iHMK2oJGqrqMPE/EfwOMUF2ylEaP
         uYm6NNePeE8DccDRI2n0o//+CT6E8riUHiXiljePPUhZZLEfv4xs+DAk7Z0NEjmVGSd2
         y/QHEsPzl5iIv4/OnyWl79IxxWQK6wBlth4KeyUD88diqIqD7Toa2VhV+V3Mb4raQrTt
         CZlRNv7jKlGM5CVa2S1aUD/mIJH414P/zwmT6WmgbSM/E9GPAdK97dgej+nRhwAV+5Iw
         dv8qBGs5RqJedk91Mb4n7LOmUkmNPN0p0IZo1NQCLT6Lhjtw6sUsWI1XvjfgiJwxKNku
         C7UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788539989; x=1789144789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RofA0hbvv9ASZJURx9yLpYN6t8iWxjME25uhz3es1YQ=;
        b=I/XlKiKH5p7yCCl3V8waQUFma5IPr69zuinDpAJiOc3/OdKabSFyiJ3phh1YKbt7JN
         SI2Z4G2lV14y1Zyber+l6ILRj/dQGWASKUFpxfX1Z2FUVl6oH+JZCDEjzNYT9CjVSm5m
         gHz9rQT5zu5J1kWQ1uyeH+dMbXCKnjmxdp3WAMVtkoXt4NOjlTzp3Os6vNfZbn1sxBwT
         wBgtG/sX9k559KqBT75m4WXUJilyPLXqu5UEG2SV6MNtQJuOtHSNxzdSrj++ni2Gfkfa
         rF/7SBRrXwSRnJGiGMZquX3QfKDjNlTnGOJkMTY/mH8JC82wgA5hotCRJQXOYXwYoC24
         cp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539989; x=1789144789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RofA0hbvv9ASZJURx9yLpYN6t8iWxjME25uhz3es1YQ=;
        b=nkld9yHcZntEFTYr6cp61lVUaekhJbaylpvoOcWcIx2Q98d2m4xr9ls+v4KwJ+N9tH
         HMy30chxS1r+fpyp7v9n7DkYx1BqO0MRkN+igttk4RxpZNo5Opsc4Cn8079fkCVPM9ei
         9XKtnk13aVC7wSlVSbmKOuWQwddDlCr9UqxXkwBvFd7L6l1aZPjY32/7YBNxq3Xukaf/
         jGQnRnRtfbCyKz5ylN0CRA2hcJ38NhBapLlu7P/VAhwHThbMz7JoUcn2ecg2SC5S0h+L
         pAJIOivtPasfifibeiRFCHiGkRKdPq/F4HOQHQzG3mxfxTESQyY8yk77t70nf+uqjhQf
         TTqw==
X-Forwarded-Encrypted: i=1; AKwUvByhXy0CZ5rzG7VDQX7MSGsrAxDPa68t+jr7DqJiRZwlPhvAe7mSmdOu2wn6Bjdgv+qpQlQUrrY=@vger.kernel.org
X-Gm-Message-State: AFuF++lWcduDc91GhQTpTsEZ81tRUa1S7tXEx89vXfENp8Hp4+FkjLu1
	ZgI4q8YKBsfsst86HY1LudE0mG8wXaE+mI4WY3Xnkvp8Jkiz5kRjInJFMyHwi3rmF5FkITXCYhq
	IQS5+E8tsa5KcX+UhKFAm/kMawk02ApP3D8IwnVe6
X-Gm-Gg: AYBFou2DAqroHpQOrbXYbHdlCSz7wt4f4hfK4z6g6r8Q+zVCQ5YhJGjVlST2/xcvxO+
	PeU5Z0up9159i4INR5WrLWiJvQ6rvA4Dz3q48P8QNWvK4AJAFtVIbH+Yv57pQMeQYoYeRaxKUxE
	VmvLhBrGzdENkuHZMPehXY/tReVcevatH6SxPC1uzq6rCq9e1EYIfEw4jFN/FFDPGc/9QuihC4u
	7gnLUp503vmJT6n/X6/6gNZY+hNv5sca0jclbW3QOHXA1qRiYikyKQhgsJlYL8AQJ/U9J5/nFzo
	paX3FGoPvpZ3EvdjMDD9HVgDmy6R0BIzgW4pYfjZs1AmVZNPaTKnWC9XnmtVWqOc2PcQLHR+G75
	0v+o5MvwaPGGBgjNsecTpQz5EsWEloQRGt/ZJA05wPZ5EBb3uRd5q94pN9yDUW+SnVLQeujqHD7
	4O23wSHVRWAlJK
X-Received: by 2002:a05:6820:c0d4:10b0:6b7:83c5:fdff with SMTP id
 006d021491bc7-6b783c603d7mr2523731eaf.64.1788539988939; Fri, 04 Sep 2026
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-12-kuniyu@google.com> <178849140215.4131868.10205662438617953828@kernel.org>
In-Reply-To: <178849140215.4131868.10205662438617953828@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:39:37 -0700
X-Gm-Features: AcwNN1U2OL2C9r3w8kkN9cA7DUb4M-uFbyix7DawY76P49nrhQ000OkhKjXdgo8
Message-ID: <CAAVpQUCMmQaDbx2Hv4W7gg3R9pZrNXf1EVD=q=re7XO5VpCREw@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 11/15] neighbour: Convert neigh_table.entries
 to refcount_t.
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
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>

Both are false-positive.

> - [Medium] neigh_table_free() frees RCU-published, table-owned resources
>   with no grace period, while the objects that point at the table are=E2=
=80=A6

When arp/ND's ->exit() is called, there should be no inflight RCU
readers and we can simply rely on neigh entries' refcnt.

> - [Low] Teardown ordering concern: neigh_table_clear() ends with
>   neigh_table_put(), dropping the base reference installed by=E2=80=A6

If a user is reading proc entries, netns cannot be dismantled.


>
> --
>
> neighbour: Convert neigh_table.entries to refcount_t.
>
> This converts neigh_table.entries from atomic_t to refcount_t and adds
> neigh_table_get()/neigh_table_put() helpers plus a new neigh_table_free()
> so that the table resources are released only when the last neighbour is
> gone.  neigh_table_clear() now just drops the base reference taken in
> neigh_table_init().
>
> A couple of questions about the new teardown path below.
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 36488dbd1512..7dc8f0cdbb45 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -55,6 +55,23 @@ static void neigh_notify(struct neighbour *n, int ty=
pe, int flags, u32 pid);
> >  static void __neigh_notify(struct neighbour *n, int type, int flags, u=
32 pid);
> >  static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *=
dev,
> >                         bool skip_perm);
> > +static void neigh_table_free(struct neigh_table *tbl);
> > +
> > +static void neigh_table_get(struct neigh_table *tbl)
> > +{
> > +     refcount_inc(&tbl->entries);
> > +}
> > +
> > +static void neigh_table_put(struct neigh_table *tbl)
> > +{
> > +     if (refcount_dec_and_test(&tbl->entries))
> > +             neigh_table_free(tbl);
> > +}
> > +
> > +static int neigh_table_entries(struct neigh_table *tbl)
> > +{
> > +     return refcount_read(&tbl->entries) - 1;
> > +}
> >
> >  #ifdef CONFIG_PROC_FS
> >  static const struct seq_operations neigh_stat_seq_ops;
>
> [ ... ]
>
> > @@ -1845,6 +1862,7 @@ void neigh_table_init(struct neigh_table *tbl)
> >       tbl->last_flush =3D now;
> >       tbl->last_rand  =3D now + tbl->parms.reachable_time * 20;
> >
> > +     refcount_set(&tbl->entries, 1);
> >       spin_lock_init(&tbl->lock);
> >       mutex_init(&tbl->phash_lock);
> >       skb_queue_head_init_class(&tbl->proxy_queue,
>
> [ ... ]
>
> > @@ -924,7 +941,7 @@ void neigh_destroy(struct neighbour *neigh)
> >
> >       neigh_dbg(2, "neigh %p is destroyed\n", neigh);
> >
> > -     atomic_dec(&neigh->tbl->entries);
> > +     neigh_table_put(neigh->tbl);
> >       kfree_rcu(neigh, rcu);
> >  }
> >  EXPORT_SYMBOL(neigh_destroy);
>
> [ ... ]
>
> > @@ -1874,6 +1892,21 @@ void neigh_table_init(struct neigh_table *tbl)
> >       panic("cannot allocate memory");
> >  }
> >
> > +static void neigh_table_free(struct neigh_table *tbl)
> > +{
> > +     struct neigh_hash_table *nht;
> > +
> > +     free_percpu(tbl->stats);
> > +     tbl->stats =3D NULL;
> > +
> > +     kfree(tbl->phash_buckets);
> > +     tbl->phash_buckets =3D NULL;
> > +
> > +     nht =3D rcu_dereference_protected(tbl->nht, 1);
> > +     tbl->nht =3D NULL;
> > +     neigh_hash_free_rcu(&nht->rcu);
> > +}
>
> [Severity: Medium]
> Is it safe to free these RCU-published members synchronously here?
> neigh_table_free() calls free_percpu(tbl->stats), kfree(tbl->phash_bucket=
s)
> and invokes the RCU callback neigh_hash_free_rcu() directly, with no
> grace period in between.
>
> At the same time neigh_destroy() drops the table reference before the
> neighbour body is retired:
>
>         neigh_table_put(neigh->tbl);
>         kfree_rcu(neigh, rcu);
>
> If that put is the last one, the table (the pointee) is reclaimed
> immediately while the neighbour holding neigh->tbl survives a full grace
> period.
>
> Lockless readers hold no-ref neighbour pointers under rcu_read_lock() and
> dereference the table through them, for example in __neigh_event_send():
>
>         NEIGH_CACHE_STAT_INC(neigh->tbl, unres_discards);
>
> which is reached from the transmit path
> ip_finish_output2()/ip6_finish_output2() -> neigh_output() ->
> neigh_event_send().  tbl->nht is read via rcu_dereference() in
> ___neigh_lookup_noref(), and tbl->phash_buckets is declared __rcu and
> walked by pneigh_lookup().
>
> The same file retires nht only after a grace period:
>
> net/core/neighbour.c:neigh_hash_grow() {
>         ...
>         rcu_assign_pointer(tbl->nht, new_nht);
>         call_rcu(&old_nht->rcu, neigh_hash_free_rcu);
>         ...
> }
>
> Note also that neigh_table_put() can now reach this free from softirq
> context, since neigh_timer_handler() -> neigh_release() -> neigh_destroy(=
)
> runs long after neigh_table_clear() returned, and neigh_destroy() release=
s
> the netdev reference before the table reference, so netdev_wait_allrefs()
> does not order it either.
>
> Most reader windows do look drained in practice (cleanup_net() runs
> synchronize_rcu_expedited() before the pernet exit ops, and
> unregister_netdevice_many_notify() runs synchronize_net() before the
> neighbour flush), so I could not show a reader that is still in flight at
> that instant.  Still, would it be better to defer this free with
> call_rcu()/kfree_rcu(), or to drop the table reference from the
> neighbour's own RCU callback, especially since the follow-up patch adds
> kfree(tbl) to this function?
>
> >  /*
> >   * Only called from ndisc_cleanup(), which means this is dead code
> >   * because we no longer can unload IPv6 module.
> > @@ -1881,26 +1914,15 @@ void neigh_table_init(struct neigh_table *tbl)
> >  int neigh_table_clear(struct neigh_table *tbl)
> >  {
> >       struct net *net __maybe_unused =3D &init_net;
> > -     struct neigh_hash_table *nht;
> >
> >       cancel_delayed_work_sync(&tbl->managed_work);
> >       cancel_delayed_work_sync(&tbl->gc_work);
> >       timer_shutdown_sync(&tbl->proxy_timer);
> >
> >       neigh_ifdown(tbl, NULL);
> > -     DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));
> > -
> >       remove_proc_entry(tbl->id, net->proc_net_stat);
> >
> > -     free_percpu(tbl->stats);
> > -     tbl->stats =3D NULL;
> > -
> > -     kfree(tbl->phash_buckets);
> > -     tbl->phash_buckets =3D NULL;
> > -
> > -     nht =3D rcu_dereference_protected(tbl->nht, 1);
> > -     tbl->nht =3D NULL;
> > -     neigh_hash_free_rcu(&nht->rcu);
> > +     neigh_table_put(tbl);
> >
> >       return 0;
> >  }
>
> [Severity: Low]
> This is more of an ordering question.  neigh_table_clear() drops the base
> reference installed by refcount_set(&tbl->entries, 1) in
> neigh_table_init(), but at this commit the table is still published: in
> ndisc_cleanup() the call order is neigh_table_clear(&nd_tbl) followed by
> unregister_pernet_subsys(&ndisc_net_ops).
>
> Once the base reference is gone, neigh_table_entries() returns
> refcount_read() - 1, which is entries - 1 in general and -1 when the last
> neighbour is gone.  That value feeds the __u32 uAPI field:
>
>         .ndtc_entries           =3D neigh_table_entries(tbl),
>
> and the %08x in neigh_stat_seq_show(), where it would print as ffffffff.
>
> Checking the rest of the series, this looks unreachable in the final
> state: neigh_table_unregister() sets net->neigh_tables[index] =3D NULL
> before calling neigh_table_clear(), the proc entry is removed and drained
> before the put, and ndisc_cleanup() no longer calls neigh_table_clear()
> at all.  At this commit the only caller is the inet6_init() error path
> that the comment above already describes as dead code.
>
> Would it still be worth dropping the base reference only after the table
> is unpublished, so the biased accessor is never read without it?
>
> > @@ -2275,7 +2297,7 @@ static int neightbl_fill_info(struct sk_buff *skb=
, struct neigh_table *tbl,
> >               struct ndt_config ndc =3D {
> >                       .ndtc_key_len           =3D tbl->key_len,
> >                       .ndtc_entry_size        =3D tbl->entry_size,
> > -                     .ndtc_entries           =3D atomic_read(&tbl->ent=
ries),
> > +                     .ndtc_entries           =3D neigh_table_entries(t=
bl),
> >                       .ndtc_last_flush        =3D jiffies_to_msecs(flus=
h_delta),
> >                       .ndtc_last_rand         =3D jiffies_to_msecs(rand=
_delta),
> >                       .ndtc_proxy_qlen        =3D READ_ONCE(tbl->proxy_=
queue.qlen),
> > @@ -3495,7 +3517,7 @@ static int neigh_stat_seq_show(struct seq_file *s=
eq, void *v)
> >       seq_printf(seq, "%08x %08lx %08lx %08lx   %08lx %08lx %08lx   "
> >                       "%08lx         %08lx         %08lx         "
> >                       "%08lx       %08lx            %08lx\n",
> > -                atomic_read(&tbl->entries),
> > +                neigh_table_entries(tbl),
> >
> >                  st->allocs,
> >                  st->destroys,
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
