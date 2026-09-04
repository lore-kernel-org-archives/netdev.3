Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3ED478870
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539339; cv=pass; b=fRz5beA0fPUrEBbx9MarVg2FqQIqkzPk0PlzbvkjrL1AlbrOfI21uw1LRBhsE6cPk2OHJxpHmIfhT7BkHh1zcZS/Cw9WC0AtM0kGLdqqrs4zd19WbOcAKg/c+hJJQ9qLWL1FTcgqezH+TO2stj1o9vZWmBXERFY2Q4roqVPW6ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539339; c=relaxed/simple;
	bh=lsSS+/D6cG5VHgA/msRSlnMK11s5Ph+q1MjmGQgb2l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2JNti+HBdhSBwdEtVRD5s0WYfqwNtl6Ds2WRPsQOR2A6HJFWkdtig4zPXiXGU2a6vhs/+PK85t1ak1IVEn1uVfy17UaBEPOLy5B8kESQc4Fe95Ih2ofB8KI6w4tu0KtK3fBYH3G/pLnLNjQKxQ85inXwCFvAOuCHeqSP26O1qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7YNkaT/; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7YNkaT/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1035439a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788539337; cv=none;
        d=google.com; s=arc-20260327;
        b=BzdxDfxzAEpHGuyW5OP/HT5pDWwk5tlBgVgs2tJiJHoWMrXonQD6SFCk601xNmj5O6
         jBpDZetuMBqnKsEPjruK6B9+Anet5HVfPlyhddI/ylrT4IQ6lsVMVZXUdGWoQ+I5VUVi
         Ul4ved6/DioE+KQ4l/6y2vaTBxYgxRIZvMp7rTat7E0TG76RM+zexFLoUgk8GFZeEVvd
         2EwlvwZTKI/zWOHuTH4VwqqfCyGW4XgrbVpomhY91DKBctLpgq7LkSDwIRYPRENLXHJn
         fK6NmwQ/UFp4PDXgV25rE6Zazl8K9fc8jwv+in9njuYPIH3JVnJeMvJZ1coioLpOxWVe
         pKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GEde1Wt5do5ZiTsskk8Kp1kL4Fhum3Pa1/g0msO1R74=;
        fh=Y5X4eSP76BmIdwgKJVf3UY0iIpx97ZK3mrpVSIz2bic=;
        b=i1wluoLQxACwHgYAuS2lcjMObifomtN1D09rDCPTtZ2dafZZkgbwXr+eQPx6jA/dr5
         M7IepddmSpGd8lSRgunOVZJbVvSgD7y/f0/YP0eDbn+0ue6f+Vn6NTW/zd85FXsJKTQA
         OOkPqDY64dzMgu0263PpgWBEF3rKvdgt2B6rbH+E4Lf9m1BawFQYaOEeZQLPqLARlZEx
         iRq1A3YErTd9D4S766d5KbkkowNgcLMNV/y3XvrVD75XmR6lU/IUjvO8ZRR0+8FEcCxK
         f2FpkSDj/r4x2XgGDeUaWoLMtnnj7gA+NcR2pRWK5EQNoXRpa5f7YN6sUmf3AdZNdUlA
         7pBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788539337; x=1789144137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GEde1Wt5do5ZiTsskk8Kp1kL4Fhum3Pa1/g0msO1R74=;
        b=b7YNkaT/YM/4xLBLOHs96MkF2q8cmTFTvX8wJuwnfXu5CqIAmi/yLZgWddTrVUrD4i
         bRSznTwDbef/372+TAr+R2/gN3QHH6CKr6o8UkoSoCTU9RmiPEpBN5oKquVKQokhhyWe
         ckfKHb/keuLasyCDELInY2yftmbcmBpJzqjIBXw7p2ZdmO9tlWMi7aJbB80nCzLqk6mK
         gB3b96Y3VD4ZdU9tolg/Mw8c2Ers1h+spnQH32yg4AH7WvBAVIwygMPWbmsF637V1H+a
         gX2dS/9xkxOF/PbcwKe1Wi8C8LIYTQCvfG5SC1CPFCKb02gzNCXb+P4+ubM7VlhtMG0s
         R0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539337; x=1789144137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEde1Wt5do5ZiTsskk8Kp1kL4Fhum3Pa1/g0msO1R74=;
        b=sSL1wyrYVGwtc6XPSWCy+jF9N+gf65nVZCx02w3CrBFny8j4reHseRmFWuGvaqcU5V
         4wfaFOGfBtLU3AoB4l+9mUmOokgX2cJ1ebQMnFMS0aHrWgMHdlVneuFa4wzVld2DfjCC
         /j3WTOXJ56+2bSZ7/DhhgqzKd/m1rY1PveIDHuJtwr2ucgSNlSA1C10Qg9gHlw+KAETp
         jnMK1vojVqbM/isyeu3nyvEdiiuxguVrvPCNbNS4xG726UefujJvTEzqXEmfKwguv4kO
         dTJml+FCSAEQwwe19dJjGAgmQtMsU7pr13dBEZDF/p+qv8bNm/Yo1Id8VrpM/XVfAtCX
         7MpA==
X-Forwarded-Encrypted: i=1; AKwUvBySU48TNJoDNP6mNCnnEyLak6RjcWANUPCX+bUD5/cbk5HrBfao3ZXx5Go6qaL0kMUvinuyAOg=@vger.kernel.org
X-Gm-Message-State: AFuF++keySBdYCGQMW7NLLSGd3sNHm1FAGhjUijuiUJGcT/OYHmULnws
	+ozKTPdy60yJnyf8Kh24opOCWCHcaDq70hv4+ZErI8zu5mj+zCjQkbN2CHX9kvdpD+zBcqXSxrF
	3mG+fa01HhIBQ6+3gZ9h24cYirSRvhoJBLGyTtggR
X-Gm-Gg: AYBFou0OdC2KkYRM/JwK2+x4mE4SZTQFIATOitXd4chgUdJ6+/kuVDcDezAU77PFHxi
	1/nTLtPLZYQC5jQP8Qw4wDqp2GwruSvHNYm43hmv7xOGc4KMlQZkXIYyZfPMk5fyMNJrStammbj
	z+tEaaN1Obq8OeaAi55Bdchf0w2OJ/tw2HHL3E375g5i1SxYzJbMtgQAU2puT59Sa8or1lA7xm+
	qTkC35izltpYX0cry+kMbgYkO4XL2tZh9CAFxqqX6WFjyUhGbIKxyRP3P28t18CEjzIASUnslIZ
	YdGpPXtpbfW1/e0XDxTxa+VTkoqdx+kOM8s4ZHCj6UlrFAzdPbOhYXnin3zWOstTP2iiFkcO1NH
	pOMvEtqqGtDHhy6h4z3G7x//pbxM2AwSicbfhhEtE6yQ4C/JC+lg8DkulU//sb4jtGciAWaJgou
	mmFmRgg6Ko5t/tWZcyHgWxPBE=
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id
 98e67ed59e1d1-39b262aaf32mr11507020a91.19.1788539336110; Fri, 04 Sep 2026
 09:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-11-kuniyu@google.com> <178849140082.4131868.5096987849252659627@kernel.org>
In-Reply-To: <178849140082.4131868.5096987849252659627@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:28:44 -0700
X-Gm-Features: AcwNN1XJY3A30kPcqFHGD7M5j9-EUq67HX0sVrMrTUfFQGwVa-wLuqhMbl4xg4I
Message-ID: <CAAVpQUBnK-Z6PQxtmfMk5JaOqrDw06MrV93TE3qjHss5Mdyiog@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 10/15] neighbour: Clean up neigh_table_init()
 and neigh_table_clear().
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
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> - [High] net/core/neighbour.c:neigh_table_clear() now reclaims the RCU-
>   published neighbour hash table synchronously: `nht =3D=E2=80=A6

This is false-positive.

IPv6 is unloadable and neigh_table_clear() is not called
except for nd_init() failure, which we don't care.


>
> Pre-existing issues:
> - [Low] neigh_table_clear() (net/core/neighbour.c:1881-1906) frees table-
>   wide resources (free_percpu(tbl->stats) at 1895,=E2=80=A6
>
> --
>
> neighbour: Clean up neigh_table_init() and neigh_table_clear().
>
> This reworks neigh_table_init() to allocate everything up front and unwin=
d
> on failure, and reorders neigh_table_clear() to mirror it. The teardown
> side also switches to timer_shutdown_sync(), drops the explicit
> pneigh_queue_purge(), replaces pr_crit() with DEBUG_NET_WARN_ON_ONCE(), a=
nd
> calls neigh_hash_free_rcu() directly instead of via call_rcu().
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 34da4cdc813d..36488dbd1512 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
>
> [ ... neigh_table_init() hunk snipped ... ]
>
> > @@ -1869,26 +1880,27 @@ void neigh_table_init(struct neigh_table *tbl)
> >   */
> >  int neigh_table_clear(struct neigh_table *tbl)
> >  {
> > -     /* It is not clean... Fix it to unload IPv6 module safely */
> > +     struct net *net __maybe_unused =3D &init_net;
> > +     struct neigh_hash_table *nht;
> > +
> >       cancel_delayed_work_sync(&tbl->managed_work);
> >       cancel_delayed_work_sync(&tbl->gc_work);
> > -     timer_delete_sync(&tbl->proxy_timer);
> > -     pneigh_queue_purge(&tbl->proxy_queue, NULL, tbl->family);
> > +     timer_shutdown_sync(&tbl->proxy_timer);
> > +
> >       neigh_ifdown(tbl, NULL);
> > -     if (atomic_read(&tbl->entries))
> > -             pr_crit("neighbour leakage\n");
> > +     DEBUG_NET_WARN_ON_ONCE(atomic_read(&tbl->entries));
>
> [Severity: Low]
>
> This isn't a bug introduced by this patch, but the diagnostic swap makes =
a
> pre-existing lifecycle problem invisible on production kernels: with
> CONFIG_DEBUG_NET=3Dn, DEBUG_NET_WARN_ON_ONCE() compiles to nothing, so th=
e
> "still have entries" condition that previously always printed is no longe=
r
> reported.
>
> The table-owned resources are still freed unconditionally just below, and=
 a
> neighbour destroyed afterwards touches them:
>
> net/core/neighbour.c:neigh_destroy() {
>         NEIGH_CACHE_STAT_INC(neigh->tbl, destroys);
>         ...
>         atomic_dec(&neigh->tbl->entries);
> }
>
> The unconditional freeing itself is unchanged from the baseline, and the
> next patch in the series, "neighbour: Convert neigh_table.entries to
> refcount_t", defers freeing of tbl->stats, tbl->phash_buckets and tbl->nh=
t
> into neigh_table_free() once the last reference is dropped.
>
> Is dropping the production-visible message intentional for this
> intermediate commit?
>
> >
> > -     call_rcu(&rcu_dereference_protected(tbl->nht, 1)->rcu,
> > -              neigh_hash_free_rcu);
> > -     tbl->nht =3D NULL;
> > +     remove_proc_entry(tbl->id, net->proc_net_stat);
> > +
> > +     free_percpu(tbl->stats);
> > +     tbl->stats =3D NULL;
> >
> >       kfree(tbl->phash_buckets);
> >       tbl->phash_buckets =3D NULL;
> >
> > -     remove_proc_entry(tbl->id, init_net.proc_net_stat);
> > -
> > -     free_percpu(tbl->stats);
> > -     tbl->stats =3D NULL;
> > +     nht =3D rcu_dereference_protected(tbl->nht, 1);
> > +     tbl->nht =3D NULL;
> > +     neigh_hash_free_rcu(&nht->rcu);
>
> [Severity: High]
>
> Can this free the neighbour hash table while lockless readers still hold =
a
> pointer to it?
>
> neigh_hash_free_rcu() is an RCU callback body, so calling it directly
> releases both the bucket array and the table object immediately:
>
> net/core/neighbour.c:neigh_hash_free_rcu() {
>         ...
>         kfree(nht->hash_heads);
>         kfree(nht);
> }
>
> Nothing in the new teardown sequence waits for a grace period:
> cancel_delayed_work_sync() twice, timer_shutdown_sync(), neigh_ifdown()
> and remove_proc_entry(). neigh_ifdown() only takes tbl->lock, which the
> readers never take.
>
> The readers dereference tbl->nht under RCU with no NULL check:
>
> include/net/neighbour.h:___neigh_lookup_noref() {
>         struct neigh_hash_table *nht =3D rcu_dereference(tbl->nht);
>         ...
>         hash_val =3D hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_sh=
ift);
>         neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[hash_val])
> }
>
> so a reader that already loaded nht reads hash_shift, hash_rnd and
> hash_heads out of freed slab memory and then follows whatever hlist
> contents are left there. neigh_lookup(), neigh_dump_table(),
> neigh_seq_start() and neightbl_fill_info() have the same shape.
>
> Is the table still published while this runs? ndisc_cleanup() calls
> neigh_table_clear(&nd_tbl) before unregister_pernet_subsys(&ndisc_net_ops=
),
> and the pernet exit path is what clears net->neigh_tables[NEIGH_ND_TABLE]=
,
> so nd_tbl remains installed in every netns during the free. An
> unprivileged RTM_GETNEIGH dump reaches it holding only rcu_read_lock():
>
> net/core/neighbour.c:neigh_dump_info() {
>         rcu_read_lock();
>         for (t =3D 0; t < NEIGH_NR_TABLES; t++) {
>                 tbl =3D net->neigh_tables[t];
>
> and ndisc_cleanup() is live today from the module-init error unwind:
>
> net/ipv6/af_inet6.c:inet6_init() {
> igmp_fail:
>         ndisc_cleanup();
>
> The peer site retiring the same object type still uses a grace period:
>
> net/core/neighbour.c:neigh_hash_grow() {
>         rcu_assign_pointer(tbl->nht, new_nht);
>         call_rcu(&old_nht->rcu, neigh_hash_free_rcu);
> }
>
> Would keeping call_rcu()/kfree_rcu(), or inserting a synchronize_net()
> before the free, be preferable here? The plain NULL store into the __rcu
> pointer tbl->nht predates this patch; what is new is the access to freed
> memory. This also does not appear to be addressed later in the series: at
> the end of the range the same unsynchronised free lives in
> neigh_table_free(), now additionally doing kfree(tbl), while
> neigh_table_unregister() clears net->neigh_tables[index] and calls
> neigh_table_clear()/neigh_table_put() with no grace period in between.
>
> >
> >       return 0;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
