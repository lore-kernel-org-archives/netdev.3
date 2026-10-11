Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E836F916
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762706; cv=pass; b=t6t7b+GyUfhWadLoTdNqH3XuJqGauvCNdO1VM51HckzMNugP0dgyKFo5osTW2z5K0r6l985VjWsQFEfNgAOnRf4fm+ySYLP5bBThrLNcnw/ORZXC5pzA4ai3nI0/xDjWILl40e2rx9OeQK5jeR6S6IGJgsljaicXETWDDqxkKkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762706; c=relaxed/simple;
	bh=PUddo9pEFxTSjGXLyVs4rfryj8Najc6DKM5Xcj7JMFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP0K0/Wv3zgxEuHnqtVNv+VWLpPY/FdkDhx7SJ5TvL1sue2yWRckR2JYHJ6EWrTJMCVG9Z6sBk4VTzM73Bo1oa6X591YYFXneJ14MbSdNQrQz5uOXtMxSyuNbedsIUWUhNHNoey9eAynEqFXG9aZCqvRUwQsKn+h8IOH21A/S3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yra3c78X; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yra3c78X"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88c72646f03so564329b3a.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762705; cv=none;
        d=google.com; s=arc-20260327;
        b=keeAUnDT4J1YZTHhpQTbmrdGR4ku6gVr47TkrG0yQvIJdJVbbjPxmrkkM06qOn2pjV
         hBNCEkJyAYlcwpdmI2TUSB8eDK4C7jcd4i3cgztCLO5mOaktndxlKDO5z4qc5smDtvK/
         7RpV8EV2FJumhV90xta7raRjeAb5IdScFbmgOD+RbMRy+DKr2G/rWmWPbyobE0D1LHzE
         smmKMcszuOCh0jMi67CJzLMEgSNU9n+pQQZKtOeg6t5GotPvsnA3thy53h3bVzmxbysY
         rIaZdOQE82pd9SyOPH5xmv0wUdGeHVEzzfk5IeSGycHMlu/xZSJ27PMe3iRAZQgEaIH5
         xWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        fh=NFy4m0wmh36dq8lMzR7nYbpqRPLOkHsJEjWAxh8zqww=;
        b=gS3n6qKuqRwabjBt52wlBELLPrP4HDmmHQhBu/xV7puoqubS0AA5I2ue0UqUJC2R0j
         Qmk4EUiLiD7FC+1AmJr838yaHQwI3XEP1qmvSl1Is7FsBbYwnW8lSAdMEaQquXDaJInh
         zSsB8EdK9k6UcTaPsCVPOhXiQ9CGsIF2IFdfuzn11YzmQhUptUlsfKiTIs1ngUEGkI0R
         lnMLvLE4BuuHIx1fmtUKv6ndqXFETRxRWdd1cK1qKO2Vofcui/FsiDazIVRtnrvd4D0G
         f1pKjYib5NU5yAqVkOl+9chtvTShZr30yKa6HnunFvJSaPI6QQKfoOrdflroU25U1Te/
         q2lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762705; x=1792367505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        b=yra3c78Xvm7neZqmFUSw+ORyKK/r0eGeL9BA8ZDaXb/svOwmjeGPRxuoQ7e30/glpk
         4q/RpMgg0TYDHrf0dDm9jjsW9SbYjOGXLsrF47fwjjij82MjCprc6N52b0ZpcomBDBAQ
         jAsKSy3S1fg0If1HAScE4kumTmr0pKOA9QlEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762705; x=1792367505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        b=UhdvhMNveOKG4tq/2V2izyyi81fIiOeI4qmA+JTfvN28EiXui9XYcxle3jrDns+yg1
         r6oQmp4yPmMyDsnEweQpbk5nlQHEq40K2IwpqHPTFzOzN3bBKxjvgYMeNqeXG2VKR4OV
         adW3/kyVqkoJ/1RYcWwtGL4d6yGxA40xN972L50AP0GoUxGurQOytwBlRAHtsf9iSs7h
         DToCeXX1xbZdw6uHwVj4F6AsHtKz3BReMnp7oY369PFJw4hdbRlnQz5On5pMsIyMlUtp
         wiT4j+T7HjNiZeKi7CSxGZSn6UuZk12za8bEPpTITLlITd6KCdkUAVe+Sw86HSs3mhfX
         qNCQ==
X-Gm-Message-State: AFq9FYK0zL7ncGFYNH8A26svys3I/q1Rt0BrcdHwsp/ytLHtVXMXSo8U
	hy2lSOk5pyIGuQgNXPGtLxuVX0gYdLnfnr51vf/NvdMq0Zd2zTHtxAsxCaOJYURTZpQORmHE98I
	ABvFEUXuUILFbJ8NVtivh3PLdmJuhGCEOXYHU/WrG
X-Gm-Gg: AYBFou3tw49T8oyJcvwe+b6iAEIi1pxNsKaBtSRmvChK4wFmrWnuI4zrYz4F4aDHlkx
	op62L4xd4qED0euWmc5GGsNoLUQQSsbtt7wkDMhT3l3Ws8Q0KAQmMfIYbrdz+pmCDpijtfzRihp
	I9US+DMUcHiY0iDG1Tue6ljXMMJ225gKEIJAY8ntPbL8TyhVjgEpC6sdVOXuRsLH+NH82Kb6qR6
	UyZ70rEloCG/YJ10e/FNT+T+slsNWCtBOLzg10ZrBXwSuGXpXmhCule8JTbJOg5jcw0Lai5io16
	KOdCxdH+UtuW8pGIgGvNXlitc9ZaFlWQZBwPodxBOfXZ02b996m5+TgVvs4DOoG4/+ss9E0REmr
	2ipRyBOcPi1PhEsFHvBRjzplSrgZ76YM2VA==
X-Received: by 2002:a05:6a00:1808:b0:893:4980:630e with SMTP id
 d2e1a72fcca58-897c79deac0mr6891127b3a.31.1791762704699; Sun, 11 Oct 2026
 16:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com> <179175260626.434549.15434445852177291195@kernel.org>
In-Reply-To: <179175260626.434549.15434445852177291195@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:51:33 -0400
X-Gm-Features: AclHuK_kjRfGvpSY8DvEfGEK2PVebcmLN2BToIWowkJX17XUAuoVSLI30UV31Qs
Message-ID: <CAM0EoMnWNnzLt+3fxq1ahvuzLb1vjLT4k5H-nojLpvkBLmtw1g@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net/sched: cls_bpf: accept dev-bound programs
 on shared blocks
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 5:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The v1->v2 notes say: "Style (gemini + nipa Low) -- FIXED: the
>   shared-block comment opens with /* on its own line." The diff does not=
=E2=80=A6
> - [Low] The commit message ("matches every netdev bound to the block"),
>   the code comment ("require a match with every member") and the extack=
=E2=80=A6
> - [Low] The stable metadata does not express the patch's known
>   dependencies.
>

Unless something else which is substantial shows up I will not be
sending an update to this patch.

cheers,
jamal

> --
>
> net/sched: cls_bpf: accept dev-bound programs on shared blocks
>
> This patch follows up commit 120977e2c096, which took the target device
> from block->q and so rejected every dev-bound cls_bpf program attached
> through a shared block. On shared blocks, cls_bpf_prog_from_efd() now
> walks block->ports and accepts the attach only when
> bpf_offload_dev_match() succeeds for every entry. It rejects an empty
> block.
>
> Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu=
.com/
> Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatat=
u.com/
>
> > Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bou=
nd to a different device")
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > [ ... ]
> > Cc: stable@vger.kernel.org
>
> [Severity: Low]
> Do these tags give stable tooling enough to backport this safely?
>
> Commit 120977e2c096 carries "Fixes: 2b3486bc2d23" ("bpf: Introduce
> device-bound XDP programs", v6.3). Stable trees from v6.3 onward, such
> as 6.6.y, can therefore pick it up and inherit the shared-block
> rejection.
>
> This follow-up iterates block->ports in cls_bpf_prog_from_efd(). That
> field was added by 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra", v6.8-rc1), so the patch will not build on those older
> trees. They would keep rejecting every dev-bound attach on a shared
> block.
>
> The ordering against the netdevsim patch ("patch 1 must be applied
> first, including in stable") is only stated in prose. Would a version
> bound on the Cc: stable line, or a prerequisite annotation, express
> both dependencies in a form the tooling can use?
>
> > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > index 188cf0f949dd4..07ad9556889d4 100644
> > --- a/net/sched/cls_bpf.c
> > +++ b/net/sched/cls_bpf.c
> > @@ -392,11 +392,31 @@ static int cls_bpf_prog_from_efd(struct nlattr **=
tb, struct cls_bpf_prog *prog,
> >       if (bpf_prog_is_dev_bound(fp->aux)) {
> >               struct tcf_block *block =3D tp->chain->block;
> >               struct net_device *dev;
> > +             unsigned long ifindex;
> > +             bool match =3D false;
> > +
> > +             /* A shared block has no qdisc of its own, but it may bin=
d
> > +              * several netdevs and the program is offloaded to all of=
 them;
> > +              * require a match with every member.
> > +              */
>
> [Severity: Low]
> This isn't a bug, but the v1 -> v2 notes say:
>
>   Style (gemini + nipa Low) -- FIXED: the shared-block comment opens
>   with /* on its own line.
>
> This comment in cls_bpf_prog_from_efd() still has text on the opening
> line. The only new comment in the series with /* on its own line is in
> nsim_bpf_setup_tc_block_cb(), in the netdevsim patch.
>
> Was the style fix lost when v2 was split into three patches?
>
> > +             if (!tcf_block_shared(block)) {
> > +                     dev =3D qdisc_dev(tcf_block_q(block));
> > +                     match =3D bpf_offload_dev_match(fp, dev);
> > +                     if (!match)
> > +                             NL_SET_ERR_MSG(extack,
> > +                                            "Program is bound to a dif=
ferent device");
> > +             } else {
> > +                     xa_for_each(&block->ports, ifindex, dev) {
> > +                             match =3D bpf_offload_dev_match(fp, dev);
> > +                             if (!match)
> > +                                     break;
> > +                     }
>
> [Severity: Low]
> Does block->ports really hold every netdev bound to the shared block?
> The commit message ("matches every netdev bound to the block"), the
> comment above and the extack text all assume it does.
>
> In tcf_block_get_ext(), the offload callback is bound for every binder
> type, but the device only goes into ports when tcf_block_tracks_dev()
> is true:
>
> net/sched/cls_api.c:tcf_block_get_ext() {
>     ...
>         err =3D tcf_block_offload_bind(block, q, ei, extack);
>         if (err)
>                 goto err_block_offload_bind;
>
>         if (tcf_block_tracks_dev(block, ei)) {
>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
>     ...
> }
>
> tcf_block_tracks_dev() only accepts FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS
> and FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS.
>
> sch_red binds shared blocks through tcf_qevent_init() using
> FLOW_BLOCK_BINDER_TYPE_RED_EARLY_DROP and FLOW_BLOCK_BINDER_TYPE_RED_MARK=
.
> Those netdevs own the block and receive the cls_bpf offload broadcast,
> but this loop never visits them.
>
> That leads to two cases:
>
> - If a block's only binders are RED qevents, ports is empty. A dev-bound
>   attach then fails with "Program is not bound to every device in the
>   block", which is misleading. The old code also returned -EINVAL here,
>   so the return value has not changed.
>
> - On a mixed clsact plus qevent block, the check passes without looking
>   at the qevent member.
>
> The mixed case is safe in-tree today only because of other checks. nfp
> and netdevsim register their callbacks ingress-only, so a qevent bind
> raises nooffloaddevcnt, and tc_setup_cb_add() rejects skip_sw:
>
>         /* Make sure all netdevs sharing this block are offload-capable. =
*/
>         if (block->nooffloaddevcnt && err_stop) {
>                 ok_count =3D -EOPNOTSUPP;
>                 goto err_unlock;
>         }
>
> Both drivers also re-check bpf_offload_dev_match() in their callbacks.
>
> Should the commit message, comment and extack say that this check only
> covers clsact-tracked members? The rest of the protection comes from
> nooffloaddevcnt and the driver callbacks.
>
> > +                     if (!match)
> > +                             NL_SET_ERR_MSG(extack,
> > +                                            "Program is not bound to e=
very device in the block");
> > +             }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-PYC7.v2.20261010165947%40mojatatu.com
>
