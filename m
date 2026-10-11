Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8E1990C7
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722084; cv=pass; b=cI25pkBfd6SRHD/ZJgEEMPuYk+QVZPFyGSrA6qb2NhOVhFJYcITeDFpZskaT4qyngsuPdzHhdYSsvWgnvbSKuNGV6/uI8qMj9lP1hHRFOspAX5xE3Ych0sHU3bRmd8pLFxM6ryij0y8IjKwsHE+wt4TVYDWRFquTcaTP+7d5m/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722084; c=relaxed/simple;
	bh=D6V9u5ORzzjAQgFGUrLisPrLfQOatY/BmMyDm/LKlVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9FAlk/SqFMMHVWPjxPnvNN8CF4z3A7EE80MCWYYSjFkcrA8lVLAwvsQKR7Ofds5riXI19ZsCPiuMN7P8r4r4UIWq/DL+FtU3qJeUhCUu+QjAZsp53ZYO3sN+WBt/CKOtsBsimtSaIGj+LnfLtMoXrkW/twmU1U6tQZEwDtSvTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=g6M2PcoZ; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="g6M2PcoZ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-873a4edb243so626800b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 05:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791722078; cv=none;
        d=google.com; s=arc-20260327;
        b=BQxpgBFJUT2Tu8YgpAx4tsp1TwV3Za6uXu/QPP3bk790kodm5mT2gOwhhrV+Wd3UoE
         YSlg1n/3HTZHZ6KNhu9bYwekPLa133/70CnOnAQAXvesDYSlmZQEw9w3h3N+6yIJhWXm
         bGgF1mv7O/aQ1QBk4/Wk4uk8Tr0yhbF6o/T0MRnoacoA/EaLqrBHLtVTiw/tezIexUZe
         5UrGBikT1N3r5O6AsWjVaC1FsEwLHCIiE1jBEq1zlUUeLS1zK27hJUQtBt0LXWRy9KFZ
         d/hICd2dtKfdx5ZBf1+Xp62bjPGiGd4j5XEAGbNTEzkoxQHeNqLIfqf8wWHUCHYesZ/N
         9lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5MscJspoPgipIH59+xkblLiO7MQYfaj4zA3WKs8xjco=;
        fh=MyPeqE3c2UMzaQFTYpQUmkaruW3S1bPk+P4DCS0xpHI=;
        b=GBgaNMWO6M9TgLvtwjZJfrQ+34siHppLd2qvLHZfNQEHpSXoxfK58AHgZ22QA+gDWI
         6ZhCHp4OA136Bz/ruVNz/c5JzgBOy3zB07pDsw1o2GajeXK3Ecq10jziuHc0vpvWrehD
         FkCkuZANv8A4kejJKGydrD2GUO1SXNFcOtL9qZWpv+et+euZ2zfFjai7Lmq/2oaVmTUk
         w06w+w7EVcoo/Qn3M3lzWN0JIQ06VR8Lb10Jla8DaamZTmedVlK3yXek+k80+msPuW0N
         A/Se1rPLkm/hX6tAIddbTYbn7aymeWoBsssE0hH5pRY9Y8blymHbf7T82tWG4wgNiotS
         3QLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791722078; x=1792326878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5MscJspoPgipIH59+xkblLiO7MQYfaj4zA3WKs8xjco=;
        b=g6M2PcoZLZdjw0xeK9Wbv8XEi0rJxGmkpoeSq1SfoFBN8Go5YHfhXdpUGrHomc7E7e
         Kz1cbhuESJeW+n9hK1RegUmvWNOsCOszDZg3XrltqzPGPjfsAEjNv8LOigQqE/+n0Ksf
         nqfpsvy79PB1ke9pR1ePx7Xs8gCy0CL72e2yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791722078; x=1792326878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MscJspoPgipIH59+xkblLiO7MQYfaj4zA3WKs8xjco=;
        b=l6JTOEvjDDTAIOm2PfCKLbk70S+Gfo5JCX/Q+FWESfwq3BKMTxIIXnwrYnHfFfoigo
         bxtaaRQGuPs8B6Kxy36H2iHT6m0yBMR1sToayl57xFE6YETtfzKLG3WCIdeAtXnGDH8R
         /taamuoyf5DlDKOEmQ5KgUvu45nQMdtXHhesvzj3VMaaTj3L/Vwq+ae5e8JE/Ac5L5fz
         Y2l7dnxK4l3KkmnttNcNZE/C9bZMh0QuAGE8NBk9kLNJAdlctlL+spl65O1gzzZxlV5l
         tw4SvHTp4NnlSloYM1dkJl7Dc9m5O2PJlo71U9FY3ee40ui0xRz8OVjxbHjXBc073RgM
         VLpQ==
X-Gm-Message-State: AFq9FYKCr5W7ABisJB7TUI8117blfERoZ80SDCYeQzf59M0TYTbuN256
	rjQdcIuHapkLXfpIqaR3CflalSPfUeIwwiPfOV0rkCvp2M+vYo7O4XJRJNjCeFu5ERA9dhAr+yS
	o9wDDvfgVqcChB1szIEHmuy98KQOfpg205vyXEpRE
X-Gm-Gg: AYBFou01bvnGa5riK/jbmaD5Wg0GaZJqv0rsE8duNbGdm7ddU84fG2UrZ1h6C6IISH5
	ajMjm0tR/xQNGjzkdgC1G6M46Du/Bs3Tb4dW3aaR2Ae7VmjD8y8cqSbKsj8TxYiBCVTN+KOEySG
	Kd/6mHTvK5To7ooVSPYiVQBwS2gmzyrX/Ib50ZxDK6chFWvaPph5cBSXmKuwhLKWso3iPmdivGx
	FuOtNrmINdHPVbKuHpyUNKwuyzGmrc3USxsWDfkuMDxhww2SG2k+Gefaxu2lX0msvTrEOSgo8KO
	sOGupMDlAXkek4+ykdX8tD5/zLgXwlrmGX/6TbDNEX5QC2jOpPlIihOJvCRxEqdoMHIru+6QbfN
	qs0MeWm60FtgEYZ0PIBV1U+LdA4E4noEhqQ==
X-Received: by 2002:a05:6a00:c08f:b0:899:632a:9613 with SMTP id
 d2e1a72fcca58-899632a97f6mr1774790b3a.40.1791722077939; Sun, 11 Oct 2026
 05:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v2.20261007062551-2@mojatatu.com> <179171627364.434549.1472397105608939135@kernel.org>
In-Reply-To: <179171627364.434549.1472397105608939135@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 08:34:26 -0400
X-Gm-Features: AclHuK_9O6PguYvjcAUqQ40eNRehVnTLn6w40BzpoAuA1IHupVlbjFFVkSzCCsg
Message-ID: <CAM0EoMn-qNn=tpuRTeTuD8Y_Nc4jxerR7HfLwZZ-HkV6ygZvLw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_gate: reject oversized dumps
 instead of wrapping them
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, olteanv@gmail.com, vladimir.oltean@nxp.com, p@1g4.org, 
	eadavis@qq.com, dcaratti@redhat.com, dsahern@kernel.org, 
	stephen@networkplumber.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 6:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 (1) =C2=B7 Low: 3
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch makes an unbuildable notification block
>   RTM_DELACTION.

This is a really good catch. I doubt anyone on planet earth will
delete this way but it is a legit bug - so will send a v3.
Since I am sending a v3, I will fix all the complaints on commit
messages for this patch and patch 2/2.
The rest are followups we captured.

cheers,
jamal

> - [Medium] RTM_NEWACTION for an action set whose dump exceeds U16_MAX now
>   returns -EINVAL even though the actions have already been created or=E2=
=80=A6
> - [Low] On the -EMSGSIZE branch, tfilter_del_notify()
>   (net/sched/cls_api.c) sets the extack message "Filter deleted; del=E2=
=80=A6
> - [Low] The commit message misdescribes what the code did before the
>   patch.
> - [Low] In tfilter_del_notify(), -EMSGSIZE is taken to mean that the dump
>   cannot be represented in a u16 nest ('no notification can ever be=E2=80=
=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   tfilter_del_notify() still returns without calling ->delete() when=E2=
=80=A6
>
> --
>
> net/sched: act_gate: reject oversized dumps instead of wrapping them
>
> This commit switches the nest closes on the tc action and classifier dump
> paths to nla_nest_end_safe(). A dump larger than U16_MAX now reports
> -EMSGSIZE instead of writing a wrapped nla_len. It also bounds the
> tfilter_notify_prep() retry loop, and makes tfilter_del_notify() drop a
> notification it cannot build and delete the filter anyway.
>
> Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatat=
u.com/
> Link: https://lore.kernel.org/netdev/179111893181.434549.1344966067026704=
8994@kernel.org/
>
> > tfilter_notify_prep() treats that as socket-buffer exhaustion and
> > retries with an ever larger alloc_skb(); a dump that does not fit a u16
> > nest cannot be built at any skb size, so the loop only spins until the
> > allocation itself fails.
>
> [Severity: Low]
> Does this describe the code as it was before this patch?
>
> Before, nla_nest_end() could not fail:
>
> include/net/netlink.h:nla_nest_end() {
>         unsigned long diff =3D skb_tail_pointer(skb) - (unsigned char *)s=
tart;
>
>         DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
>         start->nla_len =3D diff;
>         return skb->len;
> }
>
> Nothing under net/sched used nla_nest_end_safe(). So tcf_fill_node()
> returned -EMSGSIZE only while the skb was short on tailroom. Once
> tfilter_notify_prep() had grown the skb enough, the fill succeeded with a
> wrapped length and the loop stopped.
>
> The loop that runs until alloc_skb() fails seems to exist only after this
> patch turns the u16 overflow into a fill failure. That makes the new boun=
d
> in tfilter_notify_prep() a requirement of the nla_nest_end_safe()
> conversions, not a fix for an existing loop.
>
> Could the commit message say this? A backport that takes the conversions
> without the bound would bring in the allocation escalation loop.
>
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 6e48b4bc2d75..747d91ae6446 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
>
> [ ... ]
>
> > @@ -1693,7 +1696,8 @@ static int tca_get_fill(struct sk_buff *skb, stru=
ct tc_action *actions[],
> >       if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
> >               goto out_nlmsg_trim;
> >
> > -     nla_nest_end(skb, nest);
> > +     if (nla_nest_end_safe(skb, nest) < 0)
> > +             goto out_nlmsg_trim;
>
> [Severity: High]
> With this change, tca_get_fill() fails for an action set whose TCA_ACT_TA=
B
> is larger than U16_MAX. Before, the same fill succeeded with a wrapped
> length. Does this make a failed notification build refuse an
> RTM_DELACTION?
>
> tcf_del_notify() builds the notification before it deletes anything:
>
> net/sched/act_api.c:tcf_del_notify() {
>     ...
>         } else {
>                 skb =3D tcf_del_notify_msg(net, n, actions, portid, attr_=
size,
>                                          extack);
>                 if (IS_ERR(skb))
>                         return PTR_ERR(skb);
>         }
>
>         /* now do the delete */
>         ret =3D tcf_action_delete(net, actions);
>     ...
> }
>
> tcf_del_notify_msg() turns any tca_get_fill() failure into -EINVAL:
>
>         if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELAC=
TION,
>                          0, 2, extack) <=3D 0) {
>                 NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action =
attributes");
>                 kfree_skb(skb);
>                 return ERR_PTR(-EINVAL);
>         }
>
> The full path is:
>
> tc_ctl_action(RTM_DELACTION)
>   tca_action_gd()
>     tcf_del_notify()
>       tcf_del_notify_msg()
>         tca_get_fill()
>           nla_nest_end_safe() < 0
>
> tcf_action_delete() is never reached.
>
> With the 1024-entry cap applied, "tc actions del action gate index 1
> action gate index 2" on two 1024-entry gate actions looks like it would
> fail with -EINVAL and leave both actions installed. The commit message
> says this two-action shape survives the cap.
>
> The cap patch later in this series only adds GATE_ENTRIES_MAX in
> parse_gate_list(). It does not touch tcf_del_notify(). Without the cap
> patch, a single gate action with about 1815 or more entries could not be
> deleted by index.
>
> This needs rtnl_notify_needed() to be true, meaning an RTNLGRP_TC
> listener or NLM_F_ECHO. rtnetlink allows non-root receive, so an
> unprivileged listener in the netns seems to be enough to make an admin's
> delete fail.
>
> The commit message says "A notification that cannot be serialised must
> not veto the state change the caller asked for", and tfilter_del_notify()
> is changed to match. tcf_reoffload_del_notify() in this file already
> drops a notification it cannot build:
>
>                 if (IS_ERR(skb))
>                         skb =3D NULL;
>
> Should tcf_del_notify() be changed the same way? tca_get_fill() returns a
> bare -1, so -EMSGSIZE would also need to be passed up. Otherwise the
> delete path cannot tell the structural overflow from other failures,
> which tfilter_del_notify() now relies on.
>
> [Severity: Medium]
> The same failure also shows up on the add side.
> tcf_action_add()->tcf_action_init() has already inserted or replaced the
> actions by the time tcf_add_notify()->tcf_add_notify_msg() calls
> tca_get_fill():
>
>         if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_fla=
gs,
>                          RTM_NEWACTION, 0, 0, extack) <=3D 0) {
>                 NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes=
 while adding TC action");
>                 kfree_skb(skb);
>                 return ERR_PTR(-EINVAL);
>         }
>
> The commit message notes this case and leaves it for later. However,
> before this patch an oversized set still filled (with wrapped lengths)
> and the add reported success. Isn't the "-EINVAL after the actions were
> created" result new for these sets?
>
> For example, with the cap applied, adding two 1024-entry gate actions in
> one request now returns -EINVAL with the actions installed. This happens
> when an RTNLGRP_TC listener exists or NLM_F_ECHO is set. A retry would
> then hit -EEXIST.
>
> >
> >       nlh->nlmsg_len =3D skb_tail_pointer(skb) - b;
> >
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index a9f54988561f..3f0ce567fa2d 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
>
> [ ... ]
>
> > @@ -2200,8 +2209,16 @@ static int tfilter_del_notify(struct net *net, s=
truct sk_buff *oskb,
> >       skb =3D tfilter_notify_prep(net, oskb, n, tp, block, q, parent, f=
h,
> >                                 RTM_DELTFILTER, portid, rtnl_held, exta=
ck);
> >       if (IS_ERR(skb)) {
> > -             NL_SET_ERR_MSG(extack, "Failed to build del event notific=
ation");
> > -             return PTR_ERR(skb);
> > +             if (PTR_ERR(skb) !=3D -EMSGSIZE) {
> > +                     NL_SET_ERR_MSG(extack, "Failed to build del event=
 notification");
> > +                     return PTR_ERR(skb);
> > +             }
>
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. This
> branch still returns without calling ->delete() when
> tfilter_notify_prep() fails with something other than -EMSGSIZE, such as
> -ENOBUFS from alloc_skb() or -EINVAL. Does that leak the flower filter
> reference taken during the lookup?
>
> In tc_del_tfilter(), fh comes from tp->ops->get(). For flower,
> fl_get()->__fl_get() takes a reference:
>
>         if (f && !refcount_inc_not_zero(&f->refcnt))
>                 f =3D NULL;
>
> fl_delete() normally drops it with __fl_put(f). On this error path,
> tc_del_tfilter() does:
>
>                 err =3D tfilter_del_notify(net, skb, n, tp, block, q, par=
ent, fh,
>                                          &last, rtnl_held, extack);
>
>                 if (err)
>                         goto errout;
>
> errout releases tp, chain and block, but never calls tfilter_put(tp, fh).
> After that, even a later successful delete would not free the filter or
> the actions bound to it.
>
> The alloc_skb() failure seems realistic here. The retry loop grows the
> skb toward U16_MAX + NLMSG_GOODSIZE, which needs order 4-5 allocations.
>
> > +             /* The filter's dump cannot be represented in a u16 nest,=
 so no
> > +              * notification can ever be built for it. Drop the notifi=
cation
> > +              * rather than refusing to delete the filter.
> > +              */
>
> [Severity: Low]
> Does -EMSGSIZE always mean the dump cannot fit in a u16 nest?
> tcf_fill_node() starts with:
>
>         int ret =3D -EMSGSIZE;
>
> and returns that for every ->dump() failure. Some dumps fail for reasons
> that have nothing to do with size. One example is tcf_pedit_dump():
>
>         opt =3D kzalloc(s, GFP_ATOMIC);
>         if (unlikely(!opt)) {
>                 rcu_read_unlock();
>                 return -ENOBUFS;
>
> u32_dump() also allocates with kzalloc_flex(), and tcf_action_dump_1()
> reduces any error to -1.
>
> If such a failure repeats through every retry in tfilter_notify_prep()
> (about 17 with 4K pages), the loop returns ERR_PTR(-EMSGSIZE). This
> branch then drops an RTM_DELTFILTER event that could have been built. The
> comment in tfilter_notify_prep() only mentions structural overflow and
> genuine capacity exhaustion.
>
> > +             NL_SET_ERR_MSG(extack, "Filter deleted; del event notific=
ation could not be built");
> > +             return tp->ops->delete(tp, fh, last, rtnl_held, extack);
>
> [Severity: Low]
> The extack text is set before ->delete() runs. If ->delete() then fails
> without writing its own extack message, won't userspace get "Filter
> deleted" together with a negative errno?
>
> Flower, for example, runs without rtnl on an unlocked qdisc. Two
> concurrent RTM_DELTFILTER requests for the same oversized filter can both
> get through fl_get() and both hit -EMSGSIZE in prep. The second one then
> reaches __fl_delete():
>
>         if (f->deleted) {
>                 spin_unlock(&tp->lock);
>                 return -ENOENT;
>         }
>
> That path does not set extack. fw_delete() can return -EINVAL the same
> way.
>
> Could the message be set only after ->delete() returns 0?
>
> >       }
> >
> >       err =3D tp->ops->delete(tp, fh, last, rtnl_held, extack);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-H19Z.v2.20261007062551%40mojatatu.com
