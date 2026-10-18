Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BE4CF477
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362363; cv=pass; b=Cu2jcCliQG95TIwpEX2BCQsPNc9jhyqP7vnS0zCQ97a2IzR1A7DPa2UiIGO+S5kYXDLtckbg1+WkS2aMnRmC5QJTz2Xyg4ZK9lNIPlA960KJAu7dDEnGubvVNm1mr8QFLAJJeLl6P/yA/cCyX2EyccnwUx683W3D/UypeAdUInw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362363; c=relaxed/simple;
	bh=INz3UdEjhp/C9ceDxfwXogGuxA3UIFkQswrX3/37MAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqCwbN+p4xAMoeR6egXdkFOzJfXWicB9pLIHirZdEX2JmFtJm2caq/1l4C41UpE+sGhatGqM1NEuhgKeN6c4KMA8pQX4BQXApQYCawHFiLOlCch0e4GV2NZWElEL1Z9gzTVjfuy9WIMBipp5uXHni1TjmKZsncnZgeNRJb00KzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=E8ap2oE9; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="E8ap2oE9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so119417b3a.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792362361; cv=none;
        d=google.com; s=arc-20260327;
        b=qOZcMuUWJqdcxeB74WfNn1G79XiOM5VIF6LEAh1V2adBmjVaN5qR/VT2hGFfNkKhOl
         i8fALAxQzyjCza6O3AVG3+u2haZCB90RqfO+KO+L7hoNwwLQ/bpBjBKp3JGFm0/HoYBr
         Z53frK/Cb5HJ8NlBFMRqLX5amc5u/tQCmz3nXZkoHwTTa7AJmV4U7Y4qWJMfI+saAsS1
         zqUa8bu1dfa2pp2QgwEDYjf7zEhqZgovb8TFHgg6VxKnt2O8LHOFDELd9sYzVG3rW31e
         2bWfVgI5tYs+mHEcHpwIxsRt7YIyk9adMcBOe2EODsXQgaIFyOY4an+2HruATy90I+Fi
         55Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Azd9Q+6KhigAGcdFbn8+Q72iX4TmvBRBnGOiAUF6cyM=;
        fh=EakCbeaeMZaLWc73hRXASTYkVnV4XJfkDESzIjyhDYY=;
        b=I5Ezdz/0TlPlujgyD7ShszOisDrDN7QckAMm1G0zl9kP0OaV6Ho8pWQO67Mle/Wyo6
         6v0gjahaDxjmIa48X/5DwkBWo1HR0KVvqDXpnNeC4v2fSOVSa2Lwb+aDsEl5JxjikbLY
         X7KrylOKMd992Iu4v7xuFMPTdd89hUYs/tmJfzSGIl/nutzKh8dJ1MhUdZtUjp9r28vy
         kctvLI5e/IdvfiQVdgmxEJvHN45PY+ulXHvlELTCB6mSG1fIV0/6j+rwxuiOnMwouNs/
         pwfQEod8+wLsUwfYzQwy4ZP+4dxxDjiV7VrwdHAi5bAAPtpQ32bpYapWSuEww+5oJZcq
         YSaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792362361; x=1792967161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Azd9Q+6KhigAGcdFbn8+Q72iX4TmvBRBnGOiAUF6cyM=;
        b=E8ap2oE9Ee+QEAZkeMR632y6aMtb8b1vEaG2c/fe+PobGtU6f+A+hf1jocdVkWpu4y
         3e44PmJw4FdBVaNdZyCma1naQDi+qDj3tQS6pKLTCddRAM7MH0QO3W794nM4DWdzv224
         fK3ZBcoXjXe+uow2gRV1lsMOajv9zNS11YgYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362361; x=1792967161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Azd9Q+6KhigAGcdFbn8+Q72iX4TmvBRBnGOiAUF6cyM=;
        b=MHjBAu5yO8OTv7+kGy9F5wvCU+g6ughLevBy/LeJgHyZ0Sw42WrXLMBf7Dy51Oo1JL
         JPuLMBenKozJqSiFeqTQxS8M+I5ADGJvRZTyp6nE2HLpbP2YjGL2WC96bbHtOJXRMRvS
         Wobmgiv3kohHv2Im9eKLiEZWOAdcyvHeShi3SjSNVXdHg5Rk8EwiaTfekNsyirI6vg2f
         +5liggHz9GwZz6qPKPNvhLpTHLuOsp/t5/MKH4ZdKkuzG7KK1BF/FO+lUWHVwcqs6pPG
         XWBmSWmOdSorawTumLeZPXnESAY9A/nKASAigr8wSv6bTXw8ncioYMv7BGGjEXA9P2WL
         nxzQ==
X-Gm-Message-State: AFq9FYLx/tIDv3KuGG8v9HYduTJm8wngFYGPpj4pCAS2TRP7x854bROj
	sGh25w3LGvLJG2MUQl4YWbtNQSovM+266J314Nh3NG4t/kz7BCemP2GWL/GkyXVRZn9b5DnH032
	d0vTUHW8CRBAPIbvL4AFl3PmtRvx0DUxaXjOTLBp6
X-Gm-Gg: AYBFou0MwyQi+p5BcJnM3xLVS4ZnNr3ZXEt1/Tsiw4pQ3aIoxX/PM2i6z7DFtVu6nef
	hrhYWOFcjpZWrVKg5qokaCEem5CrAb4LsYaJlXdN2vNyjaaKklsKiJVHuLJvUuzhOlgCr6yVAkZ
	5Kov1G7F+g3UcOQHTTpai1a86SUUIyfeK59H6j1mSRQQGk94z+wJGmuwapAOlN9FzE0+8TE+GIf
	VDYTSw31bbxPyeXum6591fAZAMVbnJsiHVifyRowIhR9ruNps/IcRUHhK6AOrAysVDH/q/k8ZNU
	0RpyLT+96K+yplN16klrKTIG6uucg/05bTqqI6tN+R6LvWFlbff/sd1tVxj4SmD+dVP52CEvZG6
	o7B/W8sxBmI4DYL2rWvBqsK/CUK13wSL44Q==
X-Received: by 2002:a05:6a00:1884:b0:89f:7ac5:9d4f with SMTP id
 d2e1a72fcca58-8a04aa17675mr4971688b3a.2.1792362361124; Sun, 18 Oct 2026
 15:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v6.r0.20261014054826-4@mojatatu.com> <179231933068.3135.80340792633077986@kernel.org>
In-Reply-To: <179231933068.3135.80340792633077986@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 18 Oct 2026 18:25:49 -0400
X-Gm-Features: AclHuK_QodsScBMVgMXVBt_ra9ZMZAEyyDIYsdMJbL3ieICN1_2cSUJ4or49o9k
Message-ID: <CAM0EoMk+Dek+yDiCRHiTU-Pfqb9GBeLDY5svyx4ePN28ref+PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, toke@toke.dk, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:28=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In the new overlimit rejection branch of cake_enqueue()
>   (net/sched/sch_cake.c), only one skb gets the QDISC_DROP_OVERLIMIT=E2=
=80=A6

This is worth a resend. So will send v7.

 pw-bot: cr

cheers,
jamal

> - [Low] Before this patch, cake_enqueue() read q->config->flow_mode once
>   and passed that one value to cake_hash(), so key extraction and set-=E2=
=80=A6
> - [Low] The commit message calls itself a bug fix ('The Fix:') for two
>   defects that go back to when split-GSO support was added to cake.
>
> --
>
> net/sched: cake: hash before segmenting and reject an overlong split
>
> This commit splits cake_hash() into two parts. cake_hash_keys() has no
> side effects and runs on the unsegmented skb. cake_hash_resolve() commits
> the set-associative state, and only runs once the packet is admitted.
>
> It also moves split-GSO segmentation ahead of the resolution. The summed
> segment length is checked against QDISC_MAX_BACKLOG, and the whole list
> is rejected before any state is committed.
>
> > The Fix:
> > with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> > splits a GSO skb into segments it accounts individually.
>
> [ ... ]
>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> [Severity: Low]
> This isn't a bug, but should this have a Fixes: tag?
>
> The commit message calls this a fix. Both problems it addresses go back
> to when split-GSO support was added to cake:
>
> With CAKE_FLAG_SPLIT_GSO, slen was added to the 32-bit
> sch->qstats.backlog without any ceiling check. slen can be larger than
> the headroom that qdisc_backlog_at_max() reserves.
>
> A GSO skb whose skb_gso_segment() failed was dropped after cake_hash()
> and the shaper state update had already committed state.
>
> The new check also depends on QDISC_MAX_BACKLOG, which comes from the
> preceding patch in the series ("net/sched: cap the accounted backlog
> before it can wrap"). Any backport would need both patches.
>
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index adfe11737c66d..c67db1c61a90b 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
>
> [ ... ]
>
> > @@ -1787,12 +1814,55 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >                                        QDISC_DROP_OVERLIMIT);
> >       }
> >
> > -     /* choose flow to insert into */
> > +     /* Tin selection and key extraction run on the unsegmented skb:
> > +      * skb_gso_segment() rewrites an encapsulated GSO packet's header=
s to
> > +      * the inner ones, changing the keys. Neither commits state.
> > +      */
> >       b =3D cake_select_tin(sch, skb);
> > -     idx =3D cake_hash(b, skb, q->config->flow_mode, flow_override,
> > -                     host_override) + 1;
> > +     cake_hash_keys(skb, q->config->flow_mode, flow_override,
> > +                    host_override, &keys);
> > +
> > +     if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> > +             struct sk_buff *nskb, *seg;
> > +             netdev_features_t features =3D netif_skb_features(skb);
> > +
> > +             segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> > +             if (IS_ERR_OR_NULL(segs))
> > +                     return qdisc_drop(skb, sch, to_free);
> > +
> > +             /* The split path accounts the segment sum, not the
> > +              * stab-adjusted qdisc_pkt_len(), so the top check does n=
ot
> > +              * bound it. Sum the list and reject it whole.
> > +              */
> > +             skb_list_walk_safe(segs, seg, nskb)
> > +                     slen +=3D seg->len;
> > +
> > +             if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_=
BACKLOG)) {
> > +                     qdisc_qstats_overlimit(sch);
>
> [ ... ]
>
> > +                     if (unlikely(segs =3D=3D skb)) {
> > +                             tcf_set_qdisc_drop_reason(skb,
> > +                                                       QDISC_DROP_OVER=
LIMIT);
> > +                             consume_skb(skb);
> > +                             return qdisc_drop_all(segs, sch, to_free)=
;
> > +                     }
> > +                     __qdisc_drop_all(segs, to_free);
> > +                     return qdisc_drop_reason(skb, sch, to_free,
> > +                                              QDISC_DROP_OVERLIMIT);
> > +             }
> > +     }
>
> [Severity: Medium]
> Do the segments placed on to_free here get a valid drop reason?
>
> When segs !=3D skb, qdisc_drop_reason() tags only the original skb. When
> segs =3D=3D skb, tcf_set_qdisc_drop_reason() tags only the head. Every ot=
her
> segment keeps whatever value is in tc_skb_cb(seg)->drop_reason.
>
> That field is at cb offset 32, right after the 32-byte struct
> qdisc_skb_cb. SKB_GSO_CB_OFFSET is also 32, and __skb_gso_segment()
> writes to that location:
>
> net/core/gso.c:__skb_gso_segment() {
>     ...
>         SKB_GSO_CB(skb)->mac_offset =3D skb_headroom(skb);
>     ...
> }
>
> This overwrites the QDISC_DROP_GENERIC value set by __dev_xmit_skb().
> __copy_skb_header() then copies the cb into every segment.
>
> __tcf_kfree_skb_list() reads the reason separately for each skb:
>
> net/sched/sch_generic.c:__tcf_kfree_skb_list() {
>     ...
>                 u32 reason =3D tc_skb_cb(skb)->drop_reason;
>     ...
>                 if ((reason & SKB_DROP_REASON_SUBSYS_MASK) =3D=3D __QDISC=
_DROP_REASON) {
>                         trace_qdisc_drop(q, txq, dev, skb, (enum qdisc_dr=
op_reason)reason);
>                         skb_reason =3D SKB_DROP_REASON_QDISC_DROP;
>                 } else {
>                         skb_reason =3D (enum skb_drop_reason)reason;
>                 }
>                 kfree_skb_reason(skb, skb_reason);
>     ...
> }
>
> A headroom-sized value has no qdisc subsystem bits. For those segments,
> trace_qdisc_drop would be skipped, and kfree_skb_reason() would report an
> unrelated core drop reason. A value of 1 would show up as SKB_CONSUMED,
> and a value of 0 would hit the DEBUG_NET_WARN_ON_ONCE in
> __sk_skb_reason_drop().
>
> The qdisc_backlog_at_max() rejection at the top of cake_enqueue() tags
> its drop correctly.
>
> Could the existing slen-summing skb_list_walk_safe() loop call
> tcf_set_qdisc_drop_reason(seg, QDISC_DROP_OVERLIMIT) on each segment?
>
> > +
> > +     /* Admitted: resolve the keys and commit flow/shaper state. */
> > +     idx =3D cake_hash_resolve(b, &keys, q->config->flow_mode);
>
> [Severity: Low]
> Can the two reads of q->config->flow_mode see different values?
>
> Before this patch, cake_hash() got a single flow_mode value, so key
> extraction and resolution always used the same mode. Now
> cake_hash_keys() and cake_hash_resolve() each do their own plain load.
> On the split-GSO path, skb_gso_segment() and the slen walk run between
> the two loads.
>
> cake_change() calls cake_config_change(), which does
> WRITE_ONCE(q->flow_mode, flow_mode) before sch_tree_lock() is taken. That
> write is not serialised against cake_enqueue().
>
> For example, keys built in a flows-only mode have srchost_hash and
> dsthost_hash set to 0. If cake_hash_resolve() then runs in a dual-srchost
> or dual-dsthost mode, allocate_src or allocate_dst is set and the flow is
> tied to the host slot for hash 0. Later packets take the tags-match fast
> path, so this assignment stays until the flow drains.
>
> Would it be better to read the mode once with
> READ_ONCE(q->config->flow_mode) and pass that value to both helpers?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-BA27.v6.r0.20261014054826%40mojatatu.com
