Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588B2F3C3E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420108; cv=pass; b=sipxFp+vV7GA0jnaJOuAZkw+4WH/c2eXFxMpHSecU+eHRd05DHRCJGJo03Xml33IF+AIbMLiOVg6MSfRbkLEc6MnNxseJy7N0/m5TZ1yOb+JBrUvueRlhr7T/ZNr49nGg5AccP1F72iMeLXj7H31mRjkSwgg3OwMihtST4AD53Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420108; c=relaxed/simple;
	bh=cMjWDaeL0MLyXOfFNxNqFnLeygHjkRQpMLbWhz/ywUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/1h8d0Ff3x1iBFUFqESSB86/ls/Ozc8NVqFDE0v1bXHPB+8zbRF7y6CBFwR3pyE2lc1P8z7/jtZB0freVmhcrK05iI1/1E5IGmByBUMsNlTfSiXE+DGDQlCbwsx9Vfc7kCSpgo/TIhb3zsGKKswjkOo0cZ20SPLQfQ8zEK2xuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQylYb8J; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQylYb8J"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1742310a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 20:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786420106; cv=none;
        d=google.com; s=arc-20260327;
        b=Ip9shOBd0FaGBbEUiezj01RWsos5PolcVa6AszwpgzLKr+a0D08kxVbTpfDioX7ZIN
         R0HLnsnRxFgOTrPO7xdxQvMKMKEqYetpEubMtE76x8eM4tJyeKtd0G7hjscYBTzOfwkU
         oeMueUg1645pa4uNpjbi7FpEaRZ0IHfqAJdm2IeEUlhHMbnEh/OHmd5NvH/FqmbgTVln
         jSWjYblOcGvz39Qa3HuWWQ/hg2Ciza1kwgl6rBHpPzcAiW/2gJArdrQHeMb3G33ZvPSk
         QmiKvDqJCHrcWLBXXeRBj0q32qWzaQL9Nc85vu6u7rbDTDgEHIx2d/mz3P/UgmQbxPRC
         4sMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ito7n2If3uSD8C9Qqkia8ZnAZJHx+PuaQXgX5G8EEdI=;
        fh=vbMBwYxKVMhnDbjMlX/QjCYT+fhqAOw0ArIG8a618Z0=;
        b=Sm3RqU2ctWrhU2aaguBq04fJ4WDbfq6q9xqql9K8LSuoSQ2IYQ+Wnmz2Pq3Nq1sGT4
         gPvvOr8k8hpIV2USLslZRq/5Y0WmQ94b1pNBfYJ3TwzSDVPGeAT8jHRIJ2hFiRBE1O6c
         I1hLrly74LK+Ep4dlP3Oz3awucR1V+e1nvIS6RGMLTgtMwVZUdfgfU1fYAmBtNrz/h3x
         AD1n1yrEbhfeDmUQwJhcp2nFfHCT0V+jpNcbmMfXAtMY7oWP4o2eI4sDkeZrRzYOPSXO
         a4YDhQAMuIs0z8a3Et5kMxboii3OHSFJDOLPgvgE/u20navDAv3M8RMnTjyt4DqClaAP
         qgkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786420106; x=1787024906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ito7n2If3uSD8C9Qqkia8ZnAZJHx+PuaQXgX5G8EEdI=;
        b=dQylYb8JMJvl+KlA0jQ0JVPZbY4dCSZ7j9HsBts/j/i+wVmNBg+Hh03iN+QYyVd86T
         J3/VyxkTbwmOpSPj1Tyc1x0x7jMAzfg+o6iMsBvlOW9LQ4Yu0VCwn3RNTnfe4OJeLpd8
         ZtWNDZ0dspe5kohgG4oAymGB9f+W0ODEeXGlEQckaxkYMltfyW3l0efZX0ZgIoZmqNqh
         +ImNWmlZpC15iPbyFxCYPmUik697nBa/4OHg6bnzBie2HYSu18R9d5pFm7EsB0QJBDwF
         iMZDeflGsknPXWwl7JRb1yTTKA9w5yxmXWxPhct5XANgErvUARODrbzoRBpJKDORCbW7
         kT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420106; x=1787024906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ito7n2If3uSD8C9Qqkia8ZnAZJHx+PuaQXgX5G8EEdI=;
        b=bJCu0RkZhuzLKjoV1r1zDSLVrxO31ktvXlBaFJ6qFOZrSOwP9pL7Ws5uQL5Y/27XnZ
         FDujd8eQvSy98I2XIpDgVZZpXoPxIkQFaXzbfdc61acrUgMU97zooWwaAXuq0+B/Q5Co
         G2Lh5weEzpmoCBuP3AoJmJ3sNZ8C/9yWBoNZhfW1qKS4vTZqHKQ8ea4/6S/zxvew6gCf
         0grx+i3dIk/6XcZbfGT7QHVWCUBcfGRm3LrKStNG7iTXl9td7Jn5NXocCtJEc/Zse+an
         ETiOZhppFH92kvaSro87BxN+/w+6aQDWsHzd3DLkdWvENsCj+2hvA1BHhvdp2+CQFxGe
         ApUw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1vyISlwSBWthRPOiCjcYDNOCtAOQuQS3RcbNNhXwwgZScZ2CusUnpZEKYjwjyNNsIKEJKsKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuk/RoaJ0gWTUaE7tNgo9gOmpXzfRaPGlwI8b9kyVKjhLbd7fD
	79PEkr8+Hg0gAIu0EeHbbNhJgom4nk7/3zhLEwjLDayhzTJDHX9qpvoEvLnuWcbl0vccx+VFP4e
	o80diGCg4bA5QC1kz9Bp5t7M6inzKUI0=
X-Gm-Gg: AR+sD13Y84vIlTmlHcwcXaJyNDQpDBC7zMqoUDFtYtUWncdLL0hZdm/EfyLAei+jePf
	0TlwrtbhcpCOkSwSF6eMDcrNrPgOgL/0uLB9rcZRZb8LUOr+GZflFfW2tehXx9OyP4Kb/UxVUM7
	a/Lrz0PtJC0p6j88oMJZw0K018tCasA1M2rsoU1qLg5aITPwnnIwLKMdn/gMuIMSmjkWNpxt8/W
	3KOh1b5e6wqYDk1LKPkmtxFziIdEhIvX94+vUtmzEAoESYstyNZMVbRRUOOQB5pjVWfeyhBarSo
	RXHrw32lUB9Gq2xH6vhI2ywgqaLI5vsrdw3/vgDkG/YsTQ==
X-Received: by 2002:a05:6a00:3d52:b0:848:6b76:592f with SMTP id
 d2e1a72fcca58-84fa8686d9emr220361b3a.5.1786420106140; Mon, 10 Aug 2026
 20:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804024053.765-1-nashuiliang@gmail.com> <20260806111054.648657-1-horms@kernel.org>
In-Reply-To: <20260806111054.648657-1-horms@kernel.org>
From: chuang <nashuiliang@gmail.com>
Date: Tue, 11 Aug 2026 11:48:14 +0800
X-Gm-Features: AUfX_mwic_ZzhPIY69a9AeWKghSXczVnnxezNltIN9B6YrL33tM8INJYo11gjqE
Message-ID: <CACueBy5bzaP+AWcHTdzD3xZuq1s_fp7gS6uCekHcHsW8X2TfAw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, willemb@google.com, 
	liuhangbin@gmail.com, krikku@gmail.com, skhawaja@google.com, 
	sdf.kernel@gmail.com, ncardwell@google.com, martin.lau@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 6, 2026 at 7:11=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260=
804024053.765-1-nashuiliang@gmail.com?part=3D1
> ---
> --- Patch [1]: [PATCH net-next v7] net: reduce RFS/ARFS flow updates by c=
hecking LLC affinity ---
> commit a4fc10ca836e4630c08de840b94b9f47a375f4d6
> Author: Chuang Wang <nashuiliang@gmail.com>
>
> net: reduce RFS/ARFS flow updates by checking LLC affinity
>
> This patch makes rps_record_sock_flow() skip the flow table update when t=
he
> new CPU shares an LLC with the previously recorded one, gated by a new
> sysctl net.core.rps_feat_llc_affinity. It also converts
> sock_rps_record_flow_hash() and sock_rps_record_flow() from static inline=
s
> into exported out-of-line functions.
>
> A few questions below.
>
> > diff --git a/include/net/rps.h b/include/net/rps.h
> > index e33c6a2fa8bbc..6dacf0888a6c2 100644
> > --- a/include/net/rps.h
> > +++ b/include/net/rps.h
>
> [ ... ]
>
> > @@ -55,11 +56,14 @@ struct rps_sock_flow_table {
> >
> >  #define RPS_NO_CPU 0xffff
> >
> > +bool rps_llc_check(u32 old_val, u32 new_val);
> > +
> >  static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
> >  {
> >       unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
> >       u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
> >       struct rps_sock_flow_table *table;
> > +     u32 old_val;
> >
> >       /* We only give a hint, preemption can change CPU under us */
> >       val |=3D raw_smp_processor_id();
> > @@ -68,7 +72,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr t=
ag_ptr, u32 hash)
> >       /* The following WRITE_ONCE() is paired with the READ_ONCE()
> >        * here, and another one in get_rps_cpu().
> >        */
> > -     if (READ_ONCE(table[index].ent) !=3D val)
> > +     old_val =3D READ_ONCE(table[index].ent);
> > +     if (old_val !=3D val && rps_llc_check(old_val, val))
> >               WRITE_ONCE(table[index].ent, val);
>
> [Severity: Medium]
> [Finding: main-2-4]
> [Sources: opus-5]
> Should the skip decision also require that old_val belongs to the same
> flow?  The slot index here is only a masked hash:
>
>         unsigned int index =3D hash & rps_tag_to_mask(tag_ptr);
>
> so distinct flows share slots.  get_rps_cpu() re-validates the stored has=
h
> bits for exactly that reason:
>
>         ident =3D READ_ONCE(sock_flow_table[flow_id].ent);
>         if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
>                 goto try_rps;
>
> With the CPU extraction fixed (see the comment on rps_llc_check() below),
> if flow A owns the slot with (hashA, cpu3) and flow B then records from a
> CPU sharing an LLC with cpu3, rps_llc_check() returns false, the slot kee=
ps
> hashA, and every packet of B fails the hash test in get_rps_cpu() and fal=
ls
> back to plain RPS.  Flow B can then never install its own entry.

This issue will not occur, and it will not degrade to plain RPS. If flow A
and flow B share the same slot (i.e., same masked hash bits) and their CPUs
are in the same LLC, it will reuse the existing flow A configuration.

> The same applies to the sentinel.  rps_sock_flow_sysctl() initializes eve=
ry
> entry:
>
>         for (i =3D 0; i < size; i++)
>                 sock_table[i].ent =3D RPS_NO_CPU;
>
> and _sock_rps_delete_flow() writes RPS_NO_CPU back on teardown.  With the
> intended mask, RPS_NO_CPU & rps_cpu_mask decodes to nr_cpu_ids - 1 on
> power-of-two CPU counts, which is a valid and usually active CPU, so the
> first record for a flow can be suppressed and the slot can stay at
> RPS_NO_CPU.
>
> Would something like this before the CPU comparison be more correct?
>
>         if ((old_val ^ new_val) & ~net_hotdata.rps_cpu_mask)
>                 return true;
>
> >  }
> >
> > @@ -136,25 +141,8 @@ static inline bool rfs_is_needed(void)
> >  #endif
> >  }
> >
> > -static inline void sock_rps_record_flow_hash(__u32 hash)
> > -{
> > -#ifdef CONFIG_RPS
> > -     if (!rfs_is_needed())
> > -             return;
> > -
> > -     _sock_rps_record_flow_hash(hash);
> > -#endif
> > -}
> > -
> > -static inline void sock_rps_record_flow(const struct sock *sk)
> > -{
> > -#ifdef CONFIG_RPS
> > -     if (!rfs_is_needed())
> > -             return;
> > -
> > -     _sock_rps_record_flow(sk);
> > -#endif
> > -}
> > +void sock_rps_record_flow_hash(__u32 hash);
> > +void sock_rps_record_flow(const struct sock *sk);
>
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5]
> The changelog says:
>
>   "Additionally, export sock_rps_record_flow_hash() and
>   sock_rps_record_flow(). This resolves a symbol visibility compilation
>   error triggered by 'tun' using sock_rps_record_flow_hash() in
>   tun_flow_update() when CONFIG_TUN is built as a module."
>
> Is that error pre-existing?  Before this patch both helpers were static
> inline in include/net/rps.h, so tun.ko and sctp.ko referenced no external
> symbol.  The undefined-symbol reports quoted in the v4/v5 notes look like
> they come from this patch adding a call to the non-exported rps_llc_check=
()
> inside the inline rps_record_sock_flow().
>
> Should the changelog say that instead?

You are correct, the error was not pre-existing; it was introduced by
adding rps_llc_check().

>
> Also, does turning these into out-of-line calls change the RFS fast path?
> The rfs_is_needed() static-key test previously compiled to a nop at each
> call site (tcp_recvmsg, tcp_sendmsg, inet_accept, sctp, tun), and on
> CONFIG_RPS=3Dn the whole thing compiled away.  Now every call site perfor=
ms a
> real call, including on CONFIG_RPS=3Dn where the new definitions sit afte=
r
> "#endif /* CONFIG_RPS */" with empty bodies.  An alternative would be to
> keep the inlines and export rps_llc_check() only.
>

If we only export rps_llc_check(), it doesn't clearly explain why tun/sctp
are calling it, since they actually use rps_record_sock_flow(). Exporting
only rps_llc_check() hides this call dependency.

I believe exporting rps_record_sock_flow() and sock_rps_record_flow_hash()
makes the issue and the dependency much clearer to describe.

> >
> >  static inline void sock_rps_delete_flow(const struct sock *sk)
> >  {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c1c1be1a6962f..ab74616f95892 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > @@ -5218,6 +5220,55 @@ static int get_rps_cpu(struct net_device *dev, s=
truct sk_buff *skb,
> >       return cpu;
> >  }
> >
> > +/**
> > + * rps_llc_check - determine if RPS flow table should be updated.
> > + * @old_val: previous flow record value.
> > + * @new_val: target flow record value.
> > + *
> > + * Return: true if the record needs an update, false otherwise.
> > + */
> > +bool rps_llc_check(u32 old_val, u32 new_val)
> > +{
> > +     u32 old_cpu =3D old_val & ~net_hotdata.rps_cpu_mask;
> > +     u32 new_cpu =3D new_val & ~net_hotdata.rps_cpu_mask;
>
> [Severity: Critical]
> [Finding: main-1-0]
> [Sources: opus-5]
> Is the mask polarity inverted here?  The entry format comment in
> include/net/rps.h says the upper part holds the high-order hash bits and
> the lower part holds the CPU number, and both the producer and the existi=
ng
> consumer agree with that:
>
> rps_record_sock_flow():
>         u32 val =3D hash & ~net_hotdata.rps_cpu_mask;
>         val |=3D raw_smp_processor_id();
>
> get_rps_cpu():
>         if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
>                 goto try_rps;
>         next_cpu =3D ident & net_hotdata.rps_cpu_mask;
>
> So old_cpu and new_cpu as computed above are flow hash bits, not CPU ids.
> Two consequences seem to follow.
>
> First, hash & ~rps_cpu_mask is either 0 or a multiple of rps_cpu_mask + 1=
,
> which equals roundup_pow_of_two(nr_cpu_ids), so the first guard
>
>         if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
>                 return true;
>
> is true for every non-zero value and rps_llc_check() returns true
> unconditionally.  Does the LLC filtering ever run?  If it does not, where
> does the ~93% reduction in mlx5e_rx_flow_steer reported in the changelog
> come from?

You are absolutely right about the mask polarity. I made a mistake when
preparing this patch and will fix it by using `val & net_hotdata.rps_cpu_ma=
sk`
for the CPU extractions. The ~93% reduction data reported in the changelog
was actually tested with this fix applied on the linux-6.1 kernel.

> Second, in the remaining case where the stored hash bits happen to be zer=
o
> (recorded hash smaller than roundup_pow_of_two(nr_cpu_ids)), old_cpu is 0=
,
> which is active and normally present in current->cpus_ptr, so the code
> reaches cpus_share_cache(old_cpu, new_cpu) with new_cpu being an arbitrar=
y
> hash-derived value that is never range checked:
>
> kernel/sched/core.c:cpus_share_cache() {
>         if (this_cpu =3D=3D that_cpu)
>                 return true;
>
>         return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, tha=
t_cpu);
> }
>
> Can this index __per_cpu_offset[] out of bounds and dereference the
> resulting address?  The hashes come from remote 4-tuples and this runs on
> the socket receive/transmit path.
>
> Would using val & net_hotdata.rps_cpu_mask for both extractions, plus a
> new_cpu < nr_cpu_ids check before cpus_share_cache(), be the intended
> logic?

This will not occur. When `rps_llc_check()` is called, `new_val` is already
a valid CPU ID.

> > +
> > +     /*
> > +      * RPS LLC Affinity Feature:
> > +      * Reduce RFS/ARFS flow updates by checking LLC affinity.
> > +      *
> > +      * Frequent flow table updates can trigger constant hardware stee=
ring
> > +      * reconfigurations (e.g., ndo_rx_flow_steer), leading to signifi=
cant
> > +      * contention on driver internal locks (like mlx5's arfs_lock).
> > +      *
> > +      * This strategy only updates the flow record if it migrates acro=
ss LLC
> > +      * boundaries. This minimizes expensive hardware updates while pr=
eserving
> > +      * cache locality for the application.
> > +      */
> > +     if (static_branch_unlikely(&rps_feat_llc_affinity)) {
> > +             /* Force update if the recorded CPU is invalid or has gon=
e offline */
> > +             if (old_cpu >=3D nr_cpu_ids || !cpu_active(old_cpu))
> > +                     return true;
> > +
> > +             /*
> > +              * Force an update if the current task is no longer permi=
tted
> > +              * to run on the old_cpu.
> > +              */
> > +             if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
> > +                     return true;
>
> [Severity: Medium]
> [Finding: main-5-11]
> [Sources: opus-5]
> Is current the task that owns this flow?  tun_flow_update() calls
> sock_rps_record_flow_hash(e->rps_rxhash) and its callers are tun_get_user=
()
> and tun_xdp_one(), so current there is the tun or vhost writer thread, no=
t
> the application that will recvmsg() the flow.  The affinity of that
> unrelated task does not say where the consumer runs.
>
> Also, p->cpus_ptr is not always &p->cpus_mask:
>
> kernel/sched/core.c:set_cpus_allowed_common() {
>         if (ctx->flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
>                 p->cpus_ptr =3D ctx->new_mask;
>                 return;
>         }
>         ...
> }
>
> Inside a migrate_disable() region (including PREEMPT_RT spin_lock
> sections), cpus_ptr is cpumask_of(rq->cpu), so this test is false for eve=
ry
> old_cpu other than the current one and rps_llc_check() degenerates to
> "always update".  The mask is also read with no serialization against a
> concurrent sched_setaffinity() or cpuset change.
>
> > +
> > +             /*
> > +              * If CPUs do not share a cache, allow the update to prev=
ent
> > +              * expensive remote memory accesses and cache misses.
> > +              */
> > +             if (!cpus_share_cache(old_cpu, new_cpu))
> > +                     return true;
> > +
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  #ifdef CONFIG_RFS_ACCEL
> >
> >  /**

I will remove this check in the next version.

> [ ... ]
>
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index b508618bfc123..b6d4ebcbb6a68 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -210,6 +210,33 @@ static int rps_sock_flow_sysctl(const struct ctl_t=
able *table, int write,
> >       kvfree_rcu_mightsleep(tofree);
> >       return ret;
> >  }
> > +
> > +static int rps_feat_llc_affinity_sysctl(const struct ctl_table *table,=
 int write,
> > +                                     void *buffer, size_t *lenp, loff_=
t *ppos)
> > +{
> > +     u8 curr_state;
> > +     int ret;
> > +     const struct ctl_table tmp =3D {
> > +             .data =3D &curr_state,
> > +             .maxlen =3D sizeof(curr_state),
> > +             .mode =3D table->mode,
> > +             .extra1 =3D table->extra1,
> > +             .extra2 =3D table->extra2
> > +     };
> > +
> > +     curr_state =3D static_branch_unlikely(&rps_feat_llc_affinity) ? 1=
 : 0;
> > +
> > +     ret =3D proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> > +     if (write && ret =3D=3D 0) {
> > +             if (curr_state && !static_branch_unlikely(&rps_feat_llc_a=
ffinity))
> > +                     static_branch_enable(&rps_feat_llc_affinity);
> > +             else if (!curr_state && static_branch_unlikely(&rps_feat_=
llc_affinity))
> > +                     static_branch_disable(&rps_feat_llc_affinity);
> > +     }
> > +
> > +     return ret;
> > +}
>
> [Severity: Medium]
> [Finding: main-5-9]
> [Sources: opus-5]
> Can two concurrent writers to this file race?  The snapshot, the parse an=
d
> the toggle are done with no serialization, while the in-tree helper for t=
he
> same job takes a mutex:
>
> kernel/sysctl.c:proc_do_static_key() {
>         static DEFINE_MUTEX(static_key_mutex);
>         ...
>         mutex_lock(&static_key_mutex);
>         val =3D static_key_enabled(key);
>         ret =3D proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
>         ...
>         mutex_unlock(&static_key_mutex);
> }
>
> If CPU0 is inside static_key_enable_cpuslocked():
>
>         if (atomic_read(&key->enabled) =3D=3D 0) {
>                 atomic_set(&key->enabled, -1);
>                 jump_label_update(key);
>                 atomic_set_release(&key->enabled, 1);
>         }
>
> then CPU1 entering static_key_disable_cpuslocked() reads the transient -1
> before taking jump_label_lock():
>
>         if (atomic_read(&key->enabled) !=3D 1) {
>                 WARN_ON_ONCE(atomic_read(&key->enabled) !=3D 0);
>                 return;
>         }
>
> which warns and drops the disable request, leaving the key in the state t=
he
> administrator did not ask for.  Would reusing proc_do_static_key() be
> simpler here?  It also enforces the CAP_SYS_ADMIN check that this handler
> omits.
>
> The "if (curr_state && !static_branch_unlikely(...))" pre-checks look
> redundant since enable and disable are idempotent, and they only widen th=
e
> window.
>
> > +
> >  #endif /* CONFIG_RPS */
> >
> >  #ifdef CONFIG_NET_FLOW_LIMIT
> > @@ -554,6 +581,14 @@ static struct ctl_table net_core_table[] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D rps_sock_flow_sysctl
> >       },
> > +     {
> > +             .procname   =3D "rps_feat_llc_affinity",
> > +             .maxlen     =3D sizeof(u8),
> > +             .mode       =3D 0644,
> > +             .proc_handler   =3D rps_feat_llc_affinity_sysctl,
> > +             .extra1     =3D SYSCTL_ZERO,
> > +             .extra2     =3D SYSCTL_ONE
> > +     },

I will fix this in the next version by reusing the standard
`proc_do_static_key()` helper.

> [Severity: Low]
> [Finding: main-1-2]
> [Sources: opus-5]
> Could this new sysctl get a documentation entry?  Neither the tunable lis=
t
> in the RFS Configuration section of Documentation/networking/scaling.rst =
nor
> Documentation/admin-guide/sysctl/net.rst mentions rps_feat_llc_affinity, =
its
> semantics or its default.
>
> The same file also states:
>
>   "rps_sock_flow_table is a global flow table that contains the *desired*
>   CPU for flows: the CPU that is currently processing the flow in
>   userspace.  Each table value is a CPU index that is updated during call=
s
>   to recvmsg and sendmsg (specifically, inet_recvmsg(), inet_sendmsg() an=
d
>   tcp_splice_read())."
>
> With the feature enabled the entry is deliberately left stale whenever
> rps_llc_check() returns false, so that description no longer holds.  Shou=
ld
> it be updated in the same patch?
>
> >  #endif
> >  #ifdef CONFIG_NET_FLOW_LIMIT
> >       {

I will fix this in the next version by adding the documentation entry for
`rps_feat_llc_affinity` and updating the RFS description in
`Documentation/networking/scaling.rst`.
