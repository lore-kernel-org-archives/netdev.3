Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792522764;
	b=e2OKc7GU3yBYRGuXbm5lxRX65YRc4WaGrqHQcWeNYouGSD6yP5ZlIZXLPdudJ5Yyn06l
	 YirpY0i1DujtKVfGDz4iby5XMQeAw8ucd83ywfofxOoCv9Zg0YwPHV8ZG+xJJn3305pAh
	 hnJnbiP+x9Uss1g7N8cCiywXKlCxez3DNO0n1HH+AcCBQvLRnAn6Qtdjty4mghb3sEcSZ
	 Qdzp+LxVEvWuxy22MT8kf/0p5elW6lOo/7lBBDQ5gq6I/iAWlROmjc9s9T6EJJsSgZrHU
	 BiavHwSMA/ki9Yx2nT84CWBmA8TVkDKF/KQ3tQe22tgeaxnTn4UVaD/qz4XYKsBmVhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XQ36xuvgD5KgmjQFERxUCvHwC9F6c0TJyW3P0s80Oao=;
	b=VLeK9Sjv1ak3W7c+NZ0Z2hUhjBIeRpW+w56LEVPFdNwmPoIEJ/C+awrALXJWuuj1p+/W
	 GcO3eS5NY54GQAV1EWACM5X01cNiu1iiU5ks4x3P0M5JMgE80HtAo+hLxUiZnOE4WQlJm
	 VZBx41Q6F/TYHCgGn2F5r6n7tj1BUbMb3WWM4RkphGapDqFPC9QbH9m2fOTxSoCoTrwob
	 XA9FetWmHgxV6OCPcNYA80GBjkkKLTeFSF+9lx6R8ee5OC75adsH8nE68lh2JW+Gx3nDv
	 g4Bm5uqD3AFW05weOv/nlGPG2if6oLNv82OplZTEGjD2ZGQQwjjYW4fWvj4gn7PtVWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jZjAbbHG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC58606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC58606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jZjAbbHG
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso812714b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792522763; cv=none;
        d=google.com; s=arc-20260327;
        b=mOhc65gfNnqNI/8gcs9MjZGNZlfuYjCEt6C+Xda/JrKTCfZ2l5GfagJZSuMcHscuMW
         aFfWQ7M6kVDDpfIs+uDU9ArPJ0inHF0fqbOMZs0xtpmdGW4rZ6+1sfSgBWwb+nEARld1
         FKXei071nLMGXFvAlkpSh3rggp1KpurshhnMozpjZGqSPJA2K1dwwhtfggJJOoZavrAO
         ZX48NpkYtIVEtVq+MZgTknritxIAq925fiwt/q3LjyvikqNM4sldpA1ja2ALiCgvmKq9
         2TBTh82nuOML7tv1LGXmRBKmC+Yuxt338TUt9muWgMjaGkzKGxzn7VGPh7ZUp7optsuJ
         rLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XQ36xuvgD5KgmjQFERxUCvHwC9F6c0TJyW3P0s80Oao=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=gS8Pugdx2BT5Pb8oL4bYiYGMLuhE8naR+u0+BJF+s53YnmV+hIB+KJJOJiRRxLS7rr
         Oz2r7a4oJbd9Xo+nzW/jlSybNHD0gx5RPiRo6aFChyfe21vXi6U7ruhmjrD8Fpvt/6Do
         fMJYfDLbxF2TjD19sIL2y4bx1e+gfeLn4TBVryL61AhUennw2mpHW6WutPDbHXDaH/Ja
         qsw0XOQsTGnrG5Fh+kI4bjCOumWA4cn6UCKZ+o1Ry8WmFu4M4NytS6tiSyIJQQfAfurU
         9AF2zGzi2w4aCH1Wl6pguNKw8pRw9+sf0VGNuuMOqBUkZU9Of/qicQLM5N/kdW1jOtlI
         jZRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792522763; x=1793127563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQ36xuvgD5KgmjQFERxUCvHwC9F6c0TJyW3P0s80Oao=;
        b=jZjAbbHGNYcsfiPcw10ziMADDOHKrTHJ9f3bE4I7DvoqQpVcdE4RovgFy6jyndSlNC
         n09az9zU0AnsTBupJbCznOY1t71H5Y9HRtA8IxIY19vLegiK1n3wyJUHjqiXz9cOw0Zl
         65RoadNjnCYSKAOJicjEzU+WEjoX0+ExAM93o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792522763; x=1793127563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQ36xuvgD5KgmjQFERxUCvHwC9F6c0TJyW3P0s80Oao=;
        b=ck9co2JEZ+tgvWLJwpNGu6+VwkcAnNQEvBKsH3ur9zZ5hr86Em58eoZmlxbonFk4kE
         RiIVDSIEPOLdMae4+A6mngCn9yWrOmGlBL2DLH91WuSxm/0cbyb9FmjMIXCduhYx0W6M
         sxZhp68OFB9n25+Q8fJUqAulU9RUVFbc0IqKzU61cIpKvXDkQZhSXBbHFQvQm84rTGOc
         kGUl56pA8yH+CpadDG7j09X7ijjAg2F7i4cakJKrDtIXuXIATMV1mXeui4nDhXInMRdx
         DR04FXsmSmzuTOShUJdHzl9p/bKB80dGJPCOtIBY2DftLiudawxpOZlMimwzdwAgAkKX
         8J0g==
X-Gm-Message-State: AFq9FYLxei7lp0524b3j/UbZ3sgYuVElF8X0VfnxlTnirrvfz+PSWRwz
	CkEKtu5uSuWqnH9o3JUOLogysKyJ/jYfVhOqpIivhffAqbpfg8e8E08Q4XLqgKzjGPd3ygWTuoR
	FgM3V+lbmU39eaDe77MkoZd8ipiKFmV3L+qlWNIFw
X-Gm-Gg: AYBFou0v+npRB5lL+Y3GsIE2MhxEQ4lQ73hqyZwuUcFRz86wCFqYhRir3XdWdNu7zBd
	crZH3An5ix4Utp0pYY7wHjJxJYQjuXDn9yd0QSQ88ANNYTvK26HAf83raOrt9XNS6Kw78FcoEvi
	4i+TgFsDKwQApstNkP9uvE1/fjjTKQUDTPJnv7GycQmYbLWgB98Bj00+a16Q6wT2jb6wF2i87ER
	cvdnLnQGjCp+UGnqw/HG2jR7hwm/XiVZN/BE9J537jOkqbUsyAJETDXbofoC4Te7tam+GD6caN6
	sCyPd3a6kiFOrIYiglIcrERo3Q6ahAlsHfd9ERz/fUEQqDleecwyn+zLQkwIATU8dDYfbIKhP18
	lC0r6rT9W4tYN44epQpironwxQWCcL1+EFw==
X-Received: by 2002:a05:6a00:2355:b0:89f:fc75:6d99 with SMTP id
 d2e1a72fcca58-8a04d355f07mr8431215b3a.60.1792522762595; Tue, 20 Oct 2026
 11:59:22 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com> <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
 <87cxt4tgee.fsf@toke.dk>
In-Reply-To: <87cxt4tgee.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Oct 2026 14:59:11 -0400
X-Gm-Features: AclHuK-3d7nzgzf0Rb5nk6AUcxBLBETCb8nWT32tf6bWch9HLQ9ILYRccVPhl9c
Message-ID: <CAM0EoM=NXkYenPtS7RGj3sv+vQbAKrKyYGWFyMzzf6LUFzXc0g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/4] net/sched: cake: return the classifier
 result to the caller
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:45=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > The Fix:
> > cake runs an optional external classifier from its enqueue path and the=
n
> > computes the flow hash inside the helper. Have the helper return the
> > filter's overrides instead, so the caller owns the flow selection.
> >
> > This is preparation for the accounting changes that follow. Packet
> > classification and flow selection are unchanged.
> >
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> One nit below, in case you need to respin for other reasons; but I guess
> I can live with it as-is, so:
>

If sashiko comes up with something code-specific that is meaningful, I
will send another round and will factor this in.

In this and other series i learnt one small lesson that cost a lot of churn=
:
If sashiko complains about some pre-existing issue, I shouldnt jump in
and say "that is sensible, why not add it on the next update" ;->
It then becomes a recursion of sorts, sashiko starts asking for more
and more ;->
My temptation is to put as many small related issues as possible in
one series instead of sending one at a time and wrestling in the mud
with sashiko every week..

cheers,
jamal

> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
>
> > ---
> >
> > v7 -> v8: cake-only.  fq_codel_classify() is line-for-line the same as
> > fq_pie_classify() and fq_pie is not changed by this series, so fq_codel
> > keeps its original classify shape; the fq_codel backlog guard is placed
> > inline in sch_fq_codel.c in 0003 instead.  (Toke H=C3=B8iland-J=C3=B8rg=
ensen, v7
> > review)
> > ---
> >  net/sched/sch_cake.c | 35 ++++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index dc93267029e7..6432d10c992e 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(st=
ruct Qdisc *sch,
> >       return &qd->tins[tin];
> >  }
> >
> > -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> > -                      struct sk_buff *skb, int flow_mode, int *qerr)
> > +/* Run the qdisc's optional external classifier. Returns true when a
> > + * terminal TC action consumed the packet, with the reason in *qerr;
> > + * otherwise *flow and *host hold the filter's overrides (0 if none).
> > + */
>
> nit: I still think this comment is superfluous and should just be removed=
 :/
>
> > +static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
> > +                           u16 *flow, u16 *host, int *qerr)
> >  {
> >       struct cake_sched_data *q =3D qdisc_priv(sch);
> >       struct tcf_proto *filter;
> >       struct tcf_result res;
> > -     u16 flow =3D 0, host =3D 0;
> >       int result;
> >
> > +     *flow =3D 0;
> > +     *host =3D 0;
> > +
> >       filter =3D rcu_dereference_bh(q->filter_list);
> >       if (!filter)
> > -             goto hash;
> > +             return false;
> >
> >       *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >       result =3D tcf_classify_qdisc(skb, filter, &res, false);
> > @@ -1737,17 +1743,15 @@ static u32 cake_classify(struct Qdisc *sch, str=
uct cake_tin_data **t,
> >                       *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> >                       fallthrough;
> >               case TC_ACT_SHOT:
> > -                     return 0;
> > +                     return true;
> >               }
> >  #endif
> >               if (TC_H_MIN(res.classid) <=3D CAKE_QUEUES)
> > -                     flow =3D TC_H_MIN(res.classid);
> > +                     *flow =3D TC_H_MIN(res.classid);
> >               if (TC_H_MAJ(res.classid) <=3D (CAKE_QUEUES << 16))
> > -                     host =3D TC_H_MAJ(res.classid) >> 16;
> > +                     *host =3D TC_H_MAJ(res.classid) >> 16;
> >       }
> > -hash:
> > -     *t =3D cake_select_tin(sch, skb);
> > -     return cake_hash(*t, skb, flow_mode, flow, host) + 1;
> > +     return false;
> >  }
> >
> >  static void cake_reconfigure(struct Qdisc *sch);
> > @@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >       u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> >       struct cake_sched_data *q =3D qdisc_priv(sch);
> >       int len =3D qdisc_pkt_len(skb), ret;
> > +     u16 flow_override, host_override;
> >       struct sk_buff *ack =3D NULL;
> >       ktime_t now =3D ktime_get();
> >       struct cake_tin_data *b;
> >       struct cake_flow *flow;
> >       bool same_flow =3D false;
> >
> > -     /* choose flow to insert into */
> > -     idx =3D cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
> > -     if (idx =3D=3D 0) {
> > +     /* Classify first: a terminal TC action consumes the packet. */
> > +     if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &=
ret)) {
> >               if (ret & __NET_XMIT_BYPASS)
> >                       qdisc_qstats_drop(sch);
> >               __qdisc_drop(skb, to_free);
> >               return ret;
> >       }
> > +
> > +     /* choose flow to insert into */
> > +     b =3D cake_select_tin(sch, skb);
> > +     idx =3D cake_hash(b, skb, q->config->flow_mode, flow_override,
> > +                     host_override) + 1;
> >       tin =3D (u32)(b - q->tins);
> >       idx--;
> >       flow =3D &b->flows[idx];
> > --
> > 2.43.0
