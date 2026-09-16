Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2E4EC674
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557754; cv=pass; b=DL1pDVb8xTFAnzTxx0hZC0FfRJNDnGJj7JSBBzw2HXgTok5Nde3kTRs83PM30bUb42T+8ZiJzIbh/FkKxCh/62u5/YwR9MAkoXt7PAc2sgP91wNk4vmkBjT1vCP1ZLQ6zYwbkMANbbJ+7KO3vVoEV+fgDXGcpPwMK1Kcpx2PrgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557754; c=relaxed/simple;
	bh=i9fMgn3pFO+cKaukGI7m6lX93VZQhWLU7HOLXULOL9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R73E6NVQ1TIlNCsh6uupBjJlXiMHVtILNCurr1YV3rDu6nT4e+sORomYu9Lmdd9+lTvmWMgS5M3ZBGuiOWg1Vn5zkfDIWiQg+2xr1tR5HfvjTbF6yEDpFylyU3eAaBHt5oTWye9uJIbM0ior9iuuA/Pd1iN816uUjsivgUmJZgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Qw0i5jIk; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Qw0i5jIk"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34907so817818b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789557743; cv=none;
        d=google.com; s=arc-20260327;
        b=pHdYTCKIM6i5XR7BEovS+O614BvKbKgr12rV94SxGZmhJJW+/zhQ9ZQhQLktTmBDsL
         RHSTpffNxBX24+Z+UpdAHc6Ni3LuHhWe94whaNcSZ66OjWObyEmRmGAF3EfxG/WOm6u+
         FuDgPga6wIdlo4kgUEqDRZJL1z6UNHOYaVEhvIC2BgQKPpSZvUIajecka95M69+H6Imc
         LA/oEpRovN32HQlhD0r0rvzjSSjOjFXbLKJr6mRCMcAmZk7KVM9L2miTQbb1gT/Xhfgy
         yQEvGLjS/tP01s+3YfsIezq2/JwMDcGtQqFK1uRy91O0NvNegDhKzsl8/rhSpQflW28/
         e3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8MqgKubQQeDu3ZBGOak5FkgZsiRbEzAZ82iAO/MP4ZQ=;
        fh=Ck+Ss38EkPx63nO47Ke8PbOPXUyk24XZeNmR5bR3qa0=;
        b=eaQIHoSIHxPZR+UHK0CFNSzmFLwTWlFNVwJy0e6sZkihBSn0QnYAN+vvvJei9lWmFG
         qTlQGGoUsoZrxbBRhdJ2LPqYO+ZDn37SP7zcEFWTy/4owwt/vc45kwdy3ek5RKlOp8++
         gU0n4/M0TZu+Ykkj3VNa3pTso1fA0gIfmxDVAJRl+isDZAxq9//axvsae1SsDsxRbDJs
         XJWNEsXWqWUZzPemzXEnjjRQovL4ILmMWnkkJkPbBKuallkt/gtXEy4EWdEF1iaIDQxP
         spCbXKJMTuh7Wj0yV7D4qfHMlD46ZoWuBFtTkz/LsRuE6fycvYG29BmjE+FQ1jBkaQ6q
         Ytow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789557743; x=1790162543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8MqgKubQQeDu3ZBGOak5FkgZsiRbEzAZ82iAO/MP4ZQ=;
        b=Qw0i5jIkXf+O9ZYjhNtVglGc3z+uk+rL5IeW02uJW54b/9JadCvpkL9fZbbzOf6lcP
         7AsBOkWX2rGz6/GF9/1MJAgJHlaEJIM3XxA4ako1fNVBwmZBc0kFpsWg8ifql3Me7Wj6
         d+QcsOVpp1i3/PH2e9++YOx8R5JFRJXHHgzmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557743; x=1790162543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MqgKubQQeDu3ZBGOak5FkgZsiRbEzAZ82iAO/MP4ZQ=;
        b=TNETBYv3fruMDxih0FvdIqQb5xt/rFYy0tXlvzfGjeolfzhw+K/X3O/inPQaK0DRI7
         0uVmTkpBS83e7UfXP1Sv4tdpJXic6JVPDmaY+Et6Y2Odlec5H4U9nyJ4BqcEsQmqFc2+
         3wF//ppjqSTEZpRfqhWz0AWqj+74gpl96MnY5YRnusqtDtzzWx+4IESbwNFYMYJ+8hVE
         vGJI92p4PXUhhMsnIdC0ko/UkwUW6jAECl3xwqTRUvX0cE8roLVO0wodJsKeCSDLPBIp
         DouAPOBzaQYeZtrMFfW2JUhvGZsfs/jK6WWvsaU95X8wcEwj2Y+4Pvvkcoyliz4YBZmG
         gBmg==
X-Gm-Message-State: AFuF++nb7IfU9G/xQF6DnMxD7o7vt3/+o6gceXpoMqe7PqRFa0R/D0ne
	qJiXskar0gW1aad04AiAmdBtaHXLt2RAZussFoSNnsOEZDo62OoLHujDP6ur+QRM9zTBlhcUAQ5
	83m3ZQHUY0H4Tibf5V+OmwvWtm9NCon0A/A9lH2zO
X-Gm-Gg: AYBFou3YR7EeXLx394SQ9XOvvCWmDCuS2KiePZkZxbyykzaZ6SgC3g/qkf9mg0pBTkJ
	+5FOZ+bmOSQl3ZMWnVy6kl8iiZf/wsmEYUZDPC0MrBBD/iYTZryyBn+r8qu9L7VJPU/qxwYJmdR
	t47G/offUONNvvOZ2kWpNCC41SVyu2OnCpG1mRb/D9JHxsjz117wabXZn9U7CCKOhHteurhk7li
	pqDtTDlGayyDKmRTBar+K/qbgQfBCGzDCgfkHVB3xqkBIec9FxjTa6DSw9YbDgbtnhYAcyGrxGw
	RMu+u0ceg/RXi2ParyGlp4ohkugpm3mMWNiCVbvq9T5qNaBqkzak4hLHt489nOQbmh6Gzzc/gmG
	Ue5R+nzb7f6e19wvQlzgE6+qHRoXBL2YcPMy932CrCs4h
X-Received: by 2002:a05:6a00:1c8b:b0:857:7337:5db8 with SMTP id
 d2e1a72fcca58-8723d33bf51mr4172567b3a.22.1789557742377; Wed, 16 Sep 2026
 04:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-CTUU.v2.20260913192614@mojatatu.com> <178946024860.22033.17011861551160960190@kernel.org>
In-Reply-To: <178946024860.22033.17011861551160960190@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Sep 2026 07:22:11 -0400
X-Gm-Features: AcwNN1XsxXLM6J0LTBSUU9fkmcmhXf28zTmVQ5ISrk3I_xAfHBvMWCA8DSV2MtE
Message-ID: <CAM0EoMkGBit3LTYWui-LwXpMHo3Yijx8pbsOXVgz6jyqWyAOAg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: sch_hfsc: bound the classify
 inner-filter walk with a drift budget
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, sashiko-bot@kernel.org, hybris@mojatatu.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:17=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] net/sched/sch_hfsc.c:hfsc_classify(): the new `drift` budget
>   is a *cumulative* per-packet allowance of 8 non-descending hops, not=E2=
=80=A6
>


I am going to send a v3 - i think the tdc test needs some improvement.

pw-bot:cr

cheers,
jamal
> --
>
> net/sched: sch_hfsc: bound the classify inner-filter walk with a drift bu=
dget
>
> hfsc_classify() can loop forever between two interior classes when two
> flowid binds that were each legal at bind time become mutually pointing
> after hfsc_adjust_levels() raises a level. The patch adds a budget of
> non-descending hops to the classify walk and drops the packet with a
> rate-limited warning when the budget runs out.
>
> Link: https://sashiko.dev/#/patchset/QDISC-CTUU.v1.20260908094501@mojatat=
u.com
>
> > diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> > index e87f5021a1995..b073efaf2bf5f 100644
> > --- a/net/sched/sch_hfsc.c
> > +++ b/net/sched/sch_hfsc.c
> > @@ -386,6 +386,12 @@ cftree_update(struct hfsc_class *cl)
> >  #define      SM_MASK         ((1ULL << SM_SHIFT) - 1)
> >  #define      ISM_MASK        ((1ULL << ISM_SHIFT) - 1)
> >
> > +/*
> > + * bound on consecutive non-descending (lateral / upward) hops in a
> > + * classify walk, mirroring htb's TC_HTB_MAXDEPTH headroom
> > + */
> > +#define      HFSC_CLASSIFY_MAX_DRIFT 8
> > +
> >  static inline u64
> >  seg_x2y(u64 x, u64 sm)
> >  {
>
> [ ... ]
>
> > @@ -1142,6 +1149,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *=
sch, int *qerr)
> >
> >       *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >       head =3D &q->root;
> > +     drift =3D HFSC_CLASSIFY_MAX_DRIFT;
> >       tcf =3D rcu_dereference_bh(q->root.filter_list);
> >       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
> >  #ifdef CONFIG_NET_CLS_ACT
> > @@ -1167,6 +1175,16 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc =
*sch, int *qerr)
> >               if (cl->level =3D=3D 0)
> >                       return cl; /* hit leaf class */
> >
> > +             /*
> > +              * flowid binds skip the level check above (res.class is =
set
> > +              * at bind time and levels drift after), so a walk can fo=
llow
> > +              * lateral hops without descending; bound them here.
> > +              */
> > +             if (cl->level >=3D head->level && drift-- =3D=3D 0) {
> > +                     pr_warn_ratelimited("hfsc: classify loop detected=
, dropping packet\n");
> > +                     return NULL;
> > +             }
>
> [Severity: Medium]
> Can this drop packets for an acyclic configuration?  drift is seeded once
> before the while loop in hfsc_classify() and the only mutation is the
> post-decrement above, so a descending hop never returns any budget.  That
> makes the budget cumulative over the whole walk rather than the bound on
> "consecutive non-descending (lateral / upward) hops" the macro comment
> describes, and rather than what the changelog says:
>
>   "Bound the traversal, mirroring HTB: count only the non-descending hops=
"
>   "a terminating lateral chain (the level-drift false-positive family)
>    still classifies normally"
>
> A terminating lateral chain longer than eight hops, or several shorter
> lateral segments separated by legal descents, would exhaust the budget.
> Such a chain is constructible with plain tc commands because bindings are
> only checked at bind time:
>
> net/sched/sch_hfsc.c:hfsc_bind_tcf() {
>         if (cl !=3D NULL) {
>                 if (p !=3D NULL && p->level <=3D cl->level)
>                         return 0;
>
> and levels are raised afterwards with no revalidation:
>
> net/sched/sch_hfsc.c:hfsc_adjust_levels() {
>         do {
>                 level =3D 0;
>                 list_for_each_entry(p, &cl->children, siblings) {
>                         if (p->level >=3D level)
>                                 level =3D p->level + 1;
>                 }
>                 WRITE_ONCE(cl->level, level);
>         } while ((cl =3D cl->cl_parent) !=3D NULL);
>
> So for sibling classes A1..A10, each with one leaf child, binding a filte=
r
> on A_i with flowid A_{i+1} while A_{i+1} is still a leaf passes
> hfsc_bind_tcf(), and adding a child to A_{i+1} afterwards turns that hop
> lateral.  Would resetting drift back to HFSC_CLASSIFY_MAX_DRIFT on every
> descending hop match the documented intent?
>
> Should this path use break instead of return NULL?  The two existing
> failure exits in the same loop break out to the default class:
>
>                 if (!cl) {
>                         cl =3D hfsc_find_class(res.classid, sch);
>                         if (!cl)
>                                 break; /* filter selected invalid classid=
 */
>                         if (cl->level >=3D head->level)
>                                 break; /* filter may only point downwards=
 */
>                 }
>
>         /* classification failed, try default class */
>         cl =3D hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
>                                        READ_ONCE(q->defcls)), sch);
>
> With return NULL, a configured defcls leaf is skipped and hfsc_enqueue()
> does qdisc_qstats_drop(sch) plus __qdisc_drop(skb, to_free).
>
> On the macro comment itself, is "mirroring htb's TC_HTB_MAXDEPTH headroom=
"
> accurate?  htb_classify() increments hops on every inner hop and HTB
> enforces a maximum depth of TC_HTB_MAXDEPTH structurally, so its bound
> cannot reject a legal walk.  HFSC caps neither class level nor hierarchy
> depth, so the value 8 has no equivalent backing here.  Could the comment
> and the changelog sentence "anything beyond a small budget is a cycle" be
> reworded to describe the heuristic that is actually implemented?
>
> Also, the warning text asserts "classify loop detected" on a walk where n=
o
> class has been revisited.  Would a message that reports the budget being
> exhausted be more accurate?
>
> >               /* apply inner filter chain */
> >               tcf =3D rcu_dereference_bh(cl->filter_list);
> >               head =3D cl;
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-CTUU.v2.20260913192614%40mojatatu.com
