Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1903E5A2B
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295314; cv=pass; b=fntSyGKmLljOnWcONQsvkdU2rih5NX+zy9g+RjtRhIyy2W3FZjdSrYylMe7IJO+YIAaEQkH3gtToM4wn6kU1njHMVXRL06d+mLUC0/FC/q/vY/qCFyadmTJMwORf79xaq5NZGQczyaKskpHkvcIYPUR+mPFF/bgDzeYTzNXXj4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295314; c=relaxed/simple;
	bh=kNWvEQCyRjaLgM1p3aLM1Srie9RvonzVk2ryxCAmXVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUHGb/3eEpM3j6PBsdRkKZORfrIAwRpST7MauOtCMGpTTGxosB6iEXGRHHrTJvy5dXurVLHRPYAYE9hUPGN+RCcI2R7r4J0DFh/T/6bfB7ZPehEVyZmVKhzjN6aZGPs87EtaFIcJcW3tVmQVNH07jGv23Db36ZItYCwYC5gIqtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=CKdSDQbX; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="CKdSDQbX"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25187so850423b3a.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789295284; cv=none;
        d=google.com; s=arc-20260327;
        b=T1AjH5I5XyoT3CwQU6mpG2lOMA/lql5/70tDASyZ49LvUdbD4RhpeAOjLWdA0vLE4D
         dQMMcyn1r4QEQB8M6YC+ppQ6ethmNFAy180glMtk70WXFrXsnHg1fPX5XQfXRKfWWjUP
         +lgyjBgI7qz6A/6QjuIfKryeExcIQzTRmtkPDJw74k2w1tzWt98Q8gYJ+hkWpU8kzyi4
         2yc6XJF7firoxew9yL+Hsg9ikntY6dGHxvQdCdMZ1SUDeOutFfWxNTDmswN6RwA3+tUF
         Z8ZVJbBcdk6mqPiwOl4ap9al6rg+g6/SSX2Lf/dtJ3pU8gpvzuGq6I9CNNRL9w6mHOIm
         x6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsJ1mHljxJwgy+8P0gqKctZDw60QtGQTkeLg/Pxi3DM=;
        fh=IuxtMWi8J7DAvhq6HIMX47znIBG3a0b9+gMZz6KWpAA=;
        b=MIlICMVu8boEdXku6g0slPfMJAuf1+Hv027aJUGzPKFMmDfQu1b+ht1TMezkzOswiN
         msFyeJAPPq3Uf2ttqJnd10b99TOzBlNfCudyjIOrZefYDhcQQxAgosy0qxhQMwiNsUU0
         41XXLWfWyrtD1tlz6p7Z3BZVD+ckxZFUs6GKGzKAyocHdN43W4NN+RmGiFf+Q/wRkSM4
         q/8T6rzzg59ZQmiS/ffaRSu8VLM7oAyghpKecY9tJ7S81ZjNuVqo9UL3PMbXfVzLiZiu
         PC506yMHMZQ99IQ5y7euXaVHtAoZkAvLU3jNhmejKYRPO9eWERu1ltqJoqYGWnaqzZVV
         XjIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789295284; x=1789900084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsJ1mHljxJwgy+8P0gqKctZDw60QtGQTkeLg/Pxi3DM=;
        b=CKdSDQbXWL2Bg6tFOjrI8wV+bSNMvLHV8s+7340F/5Pi00N57+Z//RcNAn0Qg0/uJc
         nKLw7ArraE5MOYzAitJjEvxwSzOiWbPcqBFbtlUP0SvKwgspEIR9kF26pH7meCLVGPg0
         vm4yTh9Q2lkcpEVaGrXgdl5d/tKptyxXaekgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295284; x=1789900084;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsJ1mHljxJwgy+8P0gqKctZDw60QtGQTkeLg/Pxi3DM=;
        b=LOfZyufLHdTZqsf6chlwx1yu5KFaDyMFzxEGw1sQCi2qA9FC8cEYa4TaXSwZ4KGlgJ
         dxYBlZBoowX3atBebY3AP7Oqkn1tQ1qXDRTDc5XgVvXJtC2UmaTtcpNAqkcT8i8xyNZK
         NszMcd9iynOO2nx1xMPhN7+dOwl8KcmXTvA94bmCztSC/VANxwkXgyBvn60Dj+WIcNBI
         rIlx8jhxPKV0ZT6fw6pF/Ev6d93Ini52E3n74M3ceYpTeOENl30L/xfO0PDUn/QkmtRT
         yVmv+cgX+SoVisvRUlKGFpDdeRApuPuK3WtELTn1a8cCIFuyU1J176nFlJaEev8LXgis
         v3cg==
X-Gm-Message-State: AFuF++knmPpO+8wscETn6m52qkrX0y1+/zK0R4a6Awuwmgbp4Wl18KQ4
	ntOekjhb9LkUjrduW+cjP97rw+CrddpckrS9ACGdlumvt1yrD5hqvIF7Y5xXRoo+pJL9Hf1qHOb
	J3ZagNPQIZr5V6yC9zIRLgnHnMj31OSzsULfufm8e
X-Gm-Gg: AYBFou04WvOnI9uiwLGgW7olsRC1IuzY4K3bJ13cdgCmOxFi1lFmqCTQHh7ovDu2OB9
	LhMolXFKVO5rh5I1zGMcEq/LVYnVikF7IfRWRU6qCCoh2trSxCwWP0OBkLTlROv1g4/1B1crtFu
	kAuCls3dTo+bx9MgnaxJ8jurPPuOsnd4VJCiyY+uaZupt+XkBmdnrAbK1pyoCYdp4dba3lD28Nt
	t6donyhjpFsSOfuQAUDXE1f3J8OFNRVj1oRPwV2LDtAqM4xVNt1zb8X9iCieUs02OZvdarhWmnA
	UeXHoFbl0MnaJ+HDExH+TLdp7U5TRy+wdQE8fqR5BBnM6gWCjp5Ms5uuiglhygWBdilWjeXmqDF
	izM+3O05mf5WLwuSzgwGDd92qocjOvAMlzg==
X-Received: by 2002:a05:6a00:3391:b0:848:2ab3:ddeb with SMTP id
 d2e1a72fcca58-86b31805fdamr21826359b3a.14.1789295283791; Sun, 13 Sep 2026
 03:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260912080102@mojatatu.com> <178924538043.3125.18096491736359251092@kernel.org>
In-Reply-To: <178924538043.3125.18096491736359251092@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 06:27:52 -0400
X-Gm-Features: AcwNN1V4nwgk76kDIMu53KNM_DcPMOoQmUOn28RRe2W8o2zUuB1mNfvpULddFLY
Message-ID: <CAM0EoMk6Di3L7=qTW2H=NWcU1MV0eb3ywNGFnmK=5x4g+8K_xg@mail.gmail.com>
Subject: Re: [PATCH net repost 1/2] net/sched: codel: bound the dropping loop
 per dequeue call
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, shuah@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 4:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] The new drop cap in codel_dequeue()
>   (include/net/codel_impl.h:189) is enforced with a function-local=E2=80=
=A6
>

Commenting on both this and the tdc tests:
All findings are accurate, but they are arguments against the
changelog and selftest-quality nits against an already-sent; IOW, none
is a code defect requiring a revised patch.

There is one substantive item regarding the per-flow vs per-dequeue
cap comment; i have captured it  is as a follow-up candidate and dont
see as a blocker.

cheers,
jamal

> --
>
> net/sched: codel: bound the dropping loop per dequeue call
>
> The patch clamps the CoDel control law increment to at least one tick so
> the dropping loop always advances, and caps the loop at
> CODEL_MAX_DROPS_PER_DEQUEUE (256) drops per codel_dequeue() call,
> resyncing drop_next to now when the cap trips.
>
> > diff --git a/include/net/codel.h b/include/net/codel.h
> > index aa80f744826cd..183d43c2bd434 100644
> > --- a/include/net/codel.h
> > +++ b/include/net/codel.h
> > @@ -140,6 +140,11 @@ struct codel_vars {
> >  /* needed shift to get a Q0.32 number from rec_inv_sqrt */
> >  #define REC_INV_SQRT_SHIFT (32 - REC_INV_SQRT_BITS)
> >
> > +/* Cap on drops per codel_dequeue() call: the loop's work depends on t=
he
> > + * idle gap and backlog, both outside our control; resync when exceede=
d.
> > + */
> > +#define CODEL_MAX_DROPS_PER_DEQUEUE 256
> > +
> >  /**
> >   * struct codel_stats - contains codel shared variables and stats
> >   * @maxpacket:       largest packet we've seen so far
>
> [ ... ]
>
> > diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
> > index 2c1f0ec309e9f..8f26132d45b7f 100644
> > --- a/include/net/codel_impl.h
> > +++ b/include/net/codel_impl.h
>
> [ ... ]
>
> > @@ -154,6 +159,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
> >                                    codel_skb_dequeue_t dequeue_func)
> >  {
> >       struct sk_buff *skb =3D dequeue_func(vars, ctx);
> > +     unsigned int drops =3D 0;
> >       codel_time_t now;
> >       bool drop;
> >
> > @@ -180,6 +186,14 @@ static struct sk_buff *codel_dequeue(void *ctx,
> >                        */
> >                       while (vars->dropping &&
> >                              codel_time_after_eq(now, vars->drop_next))=
 {
> > +                             if (++drops > CODEL_MAX_DROPS_PER_DEQUEUE=
) {
> > +                                     /* fell far behind the schedule *=
/
> > +                                     WRITE_ONCE(vars->drop_next,
> > +                                                codel_control_law(now,
> > +                                                                  para=
ms->interval,
> > +                                                                  vars=
->rec_inv_sqrt));
> > +                                     break;
> > +                             }
>
> [Severity: High]
>
> Since drops is a local of codel_dequeue(), does the cap actually bound th=
e
> work done in one fq_codel ->dequeue() call, or only the work done for one
> flow?
>
> When the dropping loop empties a flow (any flow holding no more than 256
> packets), dequeue_func() returns NULL, codel_should_drop(NULL, ...) clear=
s
> vars->dropping and codel_dequeue() returns NULL.  __fq_codel_dequeue() in
> net/sched/sch_fq_codel.c treats that NULL as "flow is empty" and restarts=
:
>
> net/sched/sch_fq_codel.c:__fq_codel_dequeue() {
>         ...
>         skb =3D codel_dequeue(sch, &sch->qstats.backlog, &q->cparams,
>                             &flow->cvars, &q->cstats, qdisc_pkt_len,
>                             codel_get_enqueue_time, drop_func, dequeue_fu=
nc);
>
>         if (!skb) {
>                 /* force a pass through old_flows to prevent starvation *=
/
>                 if ((head =3D=3D &q->new_flows) && !list_empty(&q->old_fl=
ows))
>                         list_move_tail(&flow->flowchain, &q->old_flows);
>                 else
>                         list_del_init(&flow->flowchain);
>                 goto begin;
>         }
>         ...
> }
>
> The goto begin re-enters codel_dequeue() for the next flow with drops bac=
k
> at 0, still inside the same fq_codel_dequeue() call and the same qdisc lo=
ck
> hold.  With flows configurable up to 65536, doesn't that make the aggrega=
te
> per ->dequeue() drop count O(active_flows * 256) rather than 256?
>
> fq_codel_peek() calls the same __fq_codel_dequeue() loop, so does the sam=
e
> amplification apply on the peek path?
>
> The same reproducer from the changelog, with the flood spread over many U=
DP
> source ports so each flow holds at most 256 packets, looks like it would
> still walk the whole backlog in one dequeue under the lock:
>
>   tc qdisc add dev lo root handle 1: tbf rate 1kbit burst 2kb limit 10000=
00
>   tc qdisc add dev lo parent 1:1 handle 10: fq_codel interval 2us \
>       target 1ms noecn limit 1000000 flows 65536
>
> Given that, is this changelog text accurate for fq_codel?
>
>     "The cap applies to fq_codel (4b549a2ef4be) and the mac80211 TXQ path
>     (fixed interval, cap only)."
>
>     "patched kernel: same setup, at most 256 drops per dequeue call,
>      no soft lockup"
>
> Would a budget shared across the fq outer loop work better here, either
> passed in by the caller or signalled back so that __fq_codel_dequeue()
> stops retrying when the budget is exhausted?  Otherwise, could the
> changelog state the residual multi-flow exposure?
>
> The mac80211 TXQ path has the same shape in fq_tin_dequeue()
> (include/net/fq_impl.h), which also does goto begin while fq->lock is hel=
d,
> so the per-call counter resets there too; its fixed 100ms interval keeps
> the per-flow loops short, but is the structural reset worth a note as wel=
l?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-1L5H.v1.20260912080102%40mojatatu.com
