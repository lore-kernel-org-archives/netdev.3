Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151C33936C
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430276; cv=pass; b=ueX5IOJZyoJyP2kPMcjUNl/fMHZjxqYvEP31TsdiDCN0DkHfrEVMez09cyRImNySNcFtYR31fVBzeuaohOchxgqV9mquLSoPsQy9mIumZfIjOkMi28+ZVh54Wt4Aci9ylsD0FG0EIqIf1K2ucV7CQU1vBNfdFfrfVGlj22spbYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430276; c=relaxed/simple;
	bh=FMDJkQ+5Yn3XFzayWsBxyLKWyK3fanzV5hCIv5prF6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5q3gdip8dbRM4c4iU3tVusQrKhAJPZpaor5/QCYzGjT2duPSUQ/J+Q1rJJzDinHHkCo7ZZcaZ/vL9vID/qJMkqWxd3hyXt/16DtX2RA1DJxVnsrD3FCLHytHMVAuzUHsI7Cg9KEN5Wt6/QF3LirV9E7piUjnDzxUA/dIkrRBj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=e7+ku6oU; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="e7+ku6oU"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1554573a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 13:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787430274; cv=none;
        d=google.com; s=arc-20260327;
        b=VpGHC2rgx/CpmjxqNZEB1FRC4QfDI//5MSgINOwMoiBMd281kWVr/RYfCkTq7eyzUi
         gH5Scmxe+A2P2RRKucVNRQIqRKUIQ2m0pYL3DHFBO88S3T0/b7cgwC3v1S2+Q1M5jMcy
         82xbUk5fcIJLWB+bGmYMPWp33g81DLjJzy5y0VwzTSB6ejIScYZlrrsnJV1q8LxdRxLP
         zj1mt8/Ui9PJ8kOD+S4Q/zL0KvZxJZdDWJXtm5oTyGx4ebmA0lo2o7T66nvv1B3w3GDp
         t8yvXp31JkGGs+JBUlpduSCWOBF/ZgRFIPDZHhlGD2fbiY/O5iLryFnH8EQI8rLayEsf
         Ez6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/4ViYb7LxaA1d6S1NShZJ7c+lMcmGamMQj4C2JlPn7A=;
        fh=s6io0SY5nrM24PdZ85674UF30gyBWVtRcmsz06WdWqc=;
        b=E33BeyjJEcJQGIJw8DYUocqGN/nlyXDwACRw6+Ohw98alb7hO37MumJgSYBAUIXFdo
         /dwMmiKYSZA8fPCxod8I8OoViY/MI5xkvPqsWeV4uKAIjmELAj2BWx48YZYkrKyTnHXQ
         DUBFScK/tvid/8vslk0YeN4ZR0bcteq+aKQuZ+WvHj9U+6Bms/8bhucS/evC7o5zqm5H
         l9ValWAABGOWbo5H+BfOL7ePDDIJrrY9tRIWTv/nCrbHsDIibR+Sgc14If9jPsWLaAtV
         ZdnwGlCIM/K56BzNpk0mrdhCycRzPtkYMjGaoIO+z4gWYbKdnCPokA9Sl7n3BFmOwyjD
         HcnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787430274; x=1788035074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/4ViYb7LxaA1d6S1NShZJ7c+lMcmGamMQj4C2JlPn7A=;
        b=e7+ku6oUP5Kg/6svWGZCV18sOTj4YBxb1WI3FYwx6u20BK0cmq9gbcZ8VITQl+se7d
         ghs8lzokhMFdAMqskwChQSErxob6PpMKHSdlUQ6pn9nnCkrXy0gRvBN48rTnvezdT7Ma
         rrM9VUTwberwzZYRf97yFIZTL5dJ2BkCctvNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787430274; x=1788035074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4ViYb7LxaA1d6S1NShZJ7c+lMcmGamMQj4C2JlPn7A=;
        b=U9P4u71AJpEx3dyLP1IwVqlYTcVblLJgrteEqZSMLVLmH2HjAZx1Z4DZL10/SoBMeB
         pelXEgsr26hUYhQ50Odyaacx6TJTzWEKqlHJx+xh3N8uuYWyNdVob5QfyIh+PrYIQWnh
         ibYC4XbPBkfgEsUxQNhf7e4kGvWUCRiGmHqDltUJnnzqmOV86qIs362fA/5d2YTb3QAe
         elCHRULTBa/nJTQkz6fjGKOdnRC5qSvB4hH/kRYn/BrZkDwHbk9tm9FpTUJfP9bCQK4v
         ekTxe+2OweoBDQ9rTTFd+MADAqWAZByv5OTlznkvg+DXDBgmF1VfD8KECO2wq4fv7Yrh
         JjxA==
X-Gm-Message-State: AFuF++n1hFwV4xPUrhTF3qkYx3nrXfabQBT61B1qe0muUkR9yUkrCuVY
	ADtFozWwNWlnjkhBL1hyVfk34E3aLu2ibHzodb2iTdREtX2ewUWGmDeCjoaIU0eKhQMdibTFWy6
	FojQ5JGlxamxHAEsIwDoEv+3byrE03bL0QEE8Jla2Zv88z8xo3dHO5g==
X-Gm-Gg: AR+sD13MBUIm+OsB6dmrcZ+P5JpdhZxCROyBY7VtmEBH8AqzpQbNLdKOKR4/Y8oSsR9
	tJKx29ZEeDiwb6Mn1DPP+KNcRkcFjYKajH83dmZfiFsvkNDzcAc1ydH4tFnfy774QdD8jeCqKp8
	C5sTuC44zKtd3KSfiicHxmMDsD8GXE+tksKCmUgT/STRCEmZWbYO9VXVswmm6efKhIb/+tFYOYI
	peobc0OaVJtXUDlJxnVsri6duLEh6nYj8ktdcznwLJg3tf9rvCO2hkE3XKaboxQjL8TPMdO0ONY
	z7zrpSepoZjBFbOZsl3tVmdHKIe0S/gQ1Li6KJxgTg==
X-Received: by 2002:a05:6a00:e05:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-8520b970d34mr13159950b3a.7.1787430273795; Sat, 22 Aug 2026
 13:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143733.57538-1-jhs@mojatatu.com> <20260822200222.2211875-1-kuba@kernel.org>
In-Reply-To: <20260822200222.2211875-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Aug 2026 16:24:21 -0400
X-Gm-Features: AcwNN1U-X7iHs1mOcg-4MnVrEvge0GJ1OfDH4eu4AjY2N3IDo3l4c-t4URinBTc
Message-ID: <CAM0EoM=OeG2DUcy9TzUxYWwCr2AAeQbOVz1v21SFtOB02wuM9A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: account classifier filter allocations to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com, 
	takis@issaris.org, ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 4:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/sched: account classifier filter allocations to memcg
>
> This adds GFP_KERNEL_ACCOUNT to the filter objects, per-CPU counters and
> per-filter aux allocations in the tc classifier *_change() paths, plus th=
e
> shared exts->actions array in tcf_exts_init_ex(). It also adds an
> idr_remove() to the cls_basic percpu-allocation failure path.
>

Thanks for merging.
I have a list of follow-up items for this patch - mostly pre-existing
issues and others pointing to similar patterns identified by the
sashikos.

cheers,
jamal

> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 4e6a2812a4f32..be63b347640ba 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -3364,7 +3364,8 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struc=
t net *net, int action,
> >        * This reference might be taken later from tcf_exts_get_net().
> >        */
> >       exts->net =3D net;
> > -     exts->actions =3D kzalloc_objs(struct tc_action *, TCA_ACT_MAX_PR=
IO);
> > +     exts->actions =3D kzalloc_objs(struct tc_action *, TCA_ACT_MAX_PR=
IO,
> > +                                  GFP_KERNEL_ACCOUNT);
> >       if (!exts->actions)
> >               return -ENOMEM;
> >  #endif
> > diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> > index 492cd9ce8d46f..e2a94ba9fba76 100644
> > --- a/net/sched/cls_basic.c
> > +++ b/net/sched/cls_basic.c
> > @@ -193,7 +193,7 @@ static int basic_change(struct net *net, struct sk_=
buff *in_skb,
> >                       return -EINVAL;
> >       }
> >
> > -     fnew =3D kzalloc_obj(*fnew);
> > +     fnew =3D kzalloc_obj(*fnew, GFP_KERNEL_ACCOUNT);
> >       if (!fnew)
> >               return -ENOBUFS;
> >
>
> [Severity: Medium]
> The changelog says this "closes" the bypass that lets "unprivileged users
> to pin kernel memory outside memcg charging". Is that accurate when the
> larger, user-sized allocations on the very same basic_change() request ar=
e
> still uncharged?
>
> basic_change() charges fnew and fnew->pf here, then reaches the ematch
> tree through basic_set_parms():
>
> net/sched/cls_basic.c:basic_set_parms()
>     err =3D tcf_em_tree_validate(tp, tb[TCA_BASIC_EMATCHES], &f->ematches=
);
>
> net/sched/ematch.c:tcf_em_tree_validate()
>     matches_len =3D tree_hdr->nmatches * sizeof(*em);
>
>     tree->matches =3D kzalloc(matches_len, GFP_KERNEL);
>
> and per-ematch payloads in tcf_em_validate():
>
>     void *v =3D kmemdup(data, data_len, GFP_KERNEL);
>
> nmatches and data_len come from the netlink message, so the uncharged par=
t
> of a single filter can be much larger than the charged part. The same
> tcf_em_tree_validate() path is used by flow_change() and
> cls_cgroup_change(), whose filter objects this patch also charges.
>
> Should the u32 hash tables be converted too? u32_change() charges the
> knode, but the TCA_U32_DIVISOR branch in the same function still uses the
> default gfp for the up-to-257-pointer table that is published in
> tp_c->hlist:
>
> net/sched/cls_u32.c:u32_change()
>         ht =3D kzalloc_flex(*ht, ht, divisor + 1);
>         if (ht =3D=3D NULL)
>                 return -ENOBUFS;
>
> The same object type is allocated as root_ht in u32_init(), also
> uncharged.
>
> There are a few other siblings on these paths that keep plain GFP_KERNEL:
>
> - fw_change() allocates head =3D kzalloc_obj(*head) (fw_head with its
>   256-entry hash table) a few lines above the fw_filter allocation this
>   patch converts.
> - route4_init() allocates route4_head, which carries table[256], while
>   route4_filter and route4_bucket in the same file are converted.
> - fl_init() allocates the cls_fl_head plus the rhashtable that grows with
>   each inserted filter, and fl_tmplt_create() allocates the template
>   object; both stay uncharged while fnew and newmask are charged.
> - tcf_proto_create(), tcf_chain_create() and tcf_block_create() in
>   cls_api.c, and the IDR nodes for the handles being charged
>   (idr_alloc_u32(..., GFP_KERNEL) in basic_change() and u32_change()).
>
> With the boundary running through the middle of one netlink request, a
> memcg-limited task can still see slab grow faster than memory.current,
> which is the signal the changelog uses as the reproducer. Was leaving
> these out intentional, or is the intent to convert them in a follow-up?
>
> > @@ -212,9 +212,11 @@ static int basic_change(struct net *net, struct sk=
_buff *in_skb,
> >       if (err)
> >               goto errout;
> >       fnew->handle =3D handle;
> > -     fnew->pf =3D alloc_percpu(struct tc_basic_pcnt);
> > +     fnew->pf =3D alloc_percpu_gfp(struct tc_basic_pcnt, GFP_KERNEL_AC=
COUNT);
> >       if (!fnew->pf) {
> >               err =3D -ENOMEM;
> > +             if (!fold)
> > +                     idr_remove(&head->handle_idr, fnew->handle);
> >               goto errout;
> >       }
> >
>
> [ ... ]
>
> > diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> > index c297d7dbcf916..ac6d0fa5a40e3 100644
> > --- a/net/sched/cls_u32.c
> > +++ b/net/sched/cls_u32.c
> > @@ -1114,15 +1114,16 @@ static int u32_change(struct net *net, struct s=
k_buff *in_skb,
> >               goto erridr;
> >       }
> >
> > -     n =3D kzalloc_flex(*n, sel.keys, s->nkeys);
> > +     n =3D kzalloc_flex(*n, sel.keys, s->nkeys, GFP_KERNEL_ACCOUNT);
> >       if (n =3D=3D NULL) {
> >               err =3D -ENOBUFS;
> >               goto erridr;
> >       }
> >
>
> [ ... ]
