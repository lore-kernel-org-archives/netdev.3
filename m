Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B804A43FC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594959; cv=pass; b=iuegJJzlCfNCZjJJRfDWL8WDKRsTv3wlzIbG7ByvZbJr5av+R+Cp9tX/IWLcVtgOaExDsDd8vjLbBV5OsPnM0/rD5GF2hSo8AjR+Ndzo9RkId+QirkPaev2LpR0/8HONQ3wTybQo14Mqg9S04NOKNNT+63JpNFULJR7Pu7iM4J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594959; c=relaxed/simple;
	bh=YA6dMLttstOtO1d0Eq3XmU9NIm2AyOP6PLAJM0y89V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuxnzIt3RoijY3a4mXDXg0ki8XDMUqjUTRCc/ir4wvFY5wVZIwgIW+cZmsUs5NPLiaMi/9hV/8GaBkzu6tNpinOXOYVG8LLkxR2D280POc+EwyPMd25YUW/JkjJspWD/H++4jtOpO3fm9BK0He4RG/6xzP6d+Lzsb6RVOsMYTwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=dSaAmB89; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="dSaAmB89"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-8807e5b8fa9so1634161b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790594957; cv=none;
        d=google.com; s=arc-20260327;
        b=ndNVG2OhYsjCNiraQJtflodU2mPAbdtB6kOweMALAuTdvywh86C4Ab1qSvdFEjcwn9
         azw3xcdEbnfM6DFGyPDOUF9ZsCuQPlbgNkzhpvVb6WX7b4rOPsTADgFCJIGHJ9P5ABq4
         AbOgMzGbRY1ZBmJOM8FBmd1G2APU2rcxHVOiO4KY5Rxc+9mLBOhbK32O/rMOGYwf0ybK
         6NxnWHwO9STo9HQhI/ieHa0Emz2DXQGv8a8pD9StgShBM4cY+y2lWUi7PrX6e7S724aI
         yT58iPFD7PbmcoTRg92fXZoB7fYVUNE3WJbsFXVW2ubzcNqF8nEqTWoKjzUE37+QmpOA
         f88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17eIQOQFxHnUP3H19b5RNgorOawIQSpl0/xg3y8BpqA=;
        fh=lUiCeyh1TZNdnEgq5PxUakE86PySzjkat3R7zuzO520=;
        b=Ie1JqBClM8h92j2PnrXRJBqP5Gx4TvJ2cRuvMAIElx3YOBJuZAd7iMTL0swjTC25Tg
         4TBU77xKqY6DfwruBc4jDkoKmnpwmqMWNIvARMkM+y4Az+e5Sor2A+mZTgULoNoLyOkj
         GEYWkhwt05TQY4vBVHEDOlZ9/g+RjDmHNs/JxanTEsUP034qTEKXe7Ifa0Yxt/F9mgxN
         /EDEjXDjgxhjP1xvfM10qUIfc06t0VCu8/USvmG94CXp/W1BFpdehDFC6GeRDvELmW2g
         UoTf/mLyfJgeu67QVicZdiMcrRSRKiyo0pCvnxUiKCmf5gj7lce+g46b5qxXDOR9qg6m
         +BiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790594957; x=1791199757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=17eIQOQFxHnUP3H19b5RNgorOawIQSpl0/xg3y8BpqA=;
        b=dSaAmB89ydhotJxU/JnwYAJkpfMJKa+fEeOvQzGb/EaozJyvnJPOO+SUsprKJXH9on
         pPodJN1gSaX/+rBlj4QJQzltPwky4OTYsH7oJIFlyaCx3tAGxug4YA1zz6IsY6nwpU1W
         worki+PjhovhL+UoeICrrNlLPTME9i6RUGg0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594957; x=1791199757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17eIQOQFxHnUP3H19b5RNgorOawIQSpl0/xg3y8BpqA=;
        b=WurfRx9WnofkRGJaT+pMGGyjF4TgTLQy4k9ABVUE0noOkHKH+HdktN+WGUZYtgAon2
         quwWf9RUGgUdW11b0s5PjhQnAOjdpa7m2P2fM21W7xVijuyTUwEENHO7M09TEyxlQ83E
         5YB/rCKXyOTYJ5pGp6kEoADg0F3kTHA/wzpgdin3/iH4l9ucgV3fRTkL6rDuM3NGjvf4
         MYTM6dvoZ6HIGZydWrAiGTmrRTKihBamNtY1hvqAzXQ9EeFwvcDlwhslvK6dOYUALVB9
         JRBIPKRz0W5+LKKMCmMUzUzGiqZNT0UVPyfj1DUlT+gQ2/uGm8fMJGD6Dt7TiRsN5WFm
         7KeQ==
X-Gm-Message-State: AFuF++nf3jXw76E0XpOvKGl8s5SqtXwCQvnOzgFVtbZndg69u9fhwQzB
	Gjml1E97GmuK45mgABUzI8chTymaSWnXid7A2hM5ztcqekvHQMV488FB357KgyXAuEWwEdV4/FO
	ogw5IRGLpatwrx+AknE1aKSrBUpZf0mr5dztIJE1j
X-Gm-Gg: AYBFou2zcCnrd+O1hgG28Jw/kDCzsHx9cqT3ilr48ES+HNuC9zlOLODkQLe68OmSxik
	Od2HEOWaI8BROF5BSkUl0zHXEoAHz8NJWJ1LCOfFiTB/7yMfCAKYvnbskBe7VvhsH7iU0PbdsbE
	bjC3I/2mywzW5VfcRPyGtw7+8RESLZzSyEP5AQuiUsV0622OE3o0HNymgWnE/0aCtWf/wV+iGOw
	OBgooiSDFB5COXmBTKEpwW/dPuY3N0RDWQxlxf7Tg66k4bSgNwVD5Mhvdb95hTQYQpmqZcxc2Fm
	K/R39VUgyTylW7l+DrizpoPrK1aM0k0Wzre/rlXU0LnCB2E1YCFqT5YeYXjnJSHE5GRAB10ypVp
	KminODT/yq3lSDF864Wf85VDHTw6+v3mv2iytfGE=
X-Received: by 2002:a05:6a00:408f:b0:882:98e8:5202 with SMTP id
 d2e1a72fcca58-88298e855ecmr3316656b3a.54.1790594956699; Mon, 28 Sep 2026
 04:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <179058569406.3145.5884584307919911126@kernel.org>
In-Reply-To: <179058569406.3145.5884584307919911126@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 28 Sep 2026 07:29:04 -0400
X-Gm-Features: AclHuK91Uqt9UvTQXITDq67_nV0zoGj-gTKk3VHmEiwB3lMccRrNV1HQ926h9wk
Message-ID: <CAM0EoMnMa-aANANgrE-cwML7Bn=CwcpktehkSWW6W7vabkY+XQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, toke@toke.dk, cake@lists.bufferbloat.net, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, hybris@mojatatu.ai, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 4:54=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message understates the bug it fixes.
> - [Medium] The patch widens the per-flow counter q->backlogs[] to u64,
>   but fq_codel's CoDel drop decision still uses the qdisc-wide u32=E2=80=
=A6
> - [Low] The commit fixes a user-triggerable bug in fq_codel and CAKE:
>   wrong fat-flow drop choices and, before the patch, a possible NULL=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   cake_heapify() does not refresh mb after a swap, so each call sifts=E2=
=80=A6
>

This is confusing - from the subject line "[PATCH net-next] net/sched:
fq_codel, cake: widen backlogs to u64" it is definetely a review for
V1 (for the second time).
I already sent v2 after some discussions with Eric. Having said that,
the cake_heapify() pre-existing issue is a new discovery for a
followup.
V2 subject is: "[PATCH net-next v2] net/sched: cap the accounted
backlog before it can wrap"
I may have confused sashiko scripts by changing the subject line. May
be i should have made this (since it is a brand new approach) stay at
v1?
I realize there are overwhelming amount of messages on the list but i
hope someone (Paolo/Jakub) is reading this message and can check.
Will wait for the sashiko embargo to be lifted for v2 then check if it
is worth sending v3

cheers,
jamal


> --
>
> net/sched: fq_codel, cake: widen backlogs to u64
>
> This patch widens three counters from u32 to u64: the fq_codel per-flow
> backlogs table, and the CAKE per-flow backlogs[] and per-tin tin_backlog
> counters. This stops 1 MiB qdisc_pkt_len() values from wrapping them. The
> fat-flow scan and heap comparison locals are widened to match, and the du=
mp
> paths export the low 32 bits through the existing uAPI fields.
>
> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.=
com/
>
> > After a wrap, fq_codel_drop() sees a tiny maxbacklog
> > and drops from an almost-empty flow, and the dequeue-side subtractions
> > corrupt the counter further.
>
> [Severity: Medium]
> Is "almost-empty flow" the worst case here? qdisc_pkt_len() is capped at
> QDISC_PKT_LEN_MAX. So with the old u32 counters, 4096 resident 1 MiB
> packets in one flow X leave q->backlogs[X] at exactly 0.
>
> Take the case where flows_cnt >=3D 2 (the default is 1024), X !=3D 0, and=
 all
> other flows are empty. The strict comparison in the fq_codel_drop() scan
> then never fires:
>
>     for (i =3D 0; i < q->flows_cnt; i++) {
>         if (q->backlogs[i] > maxbacklog) {
>
> So idx stays 0, and flow =3D &q->flows[0] is an empty flow. dequeue_head(=
)
> then does this with no NULL check:
>
>     struct sk_buff *skb =3D flow->head;
>
>     WRITE_ONCE(flow->head, skb->next);
>
> Wouldn't that be a NULL pointer dereference, reachable with CAP_NET_ADMIN
> in a user namespace? The reproducer uses flows 1, which hides it, because
> idx 0 is then the fat flow.
>
> The u64 counters fix this, since they can't wrap. Could the commit messag=
e
> describe the oops, so stable and CVE triage see the real impact?
>
> Is the claim about the dequeue-side subtractions accurate?
> fq_codel_enqueue(), dequeue_func() and fq_codel_drop() all add and
> subtract the same qdisc_pkt_len() values in modular u32 arithmetic. The
> counter therefore stays equal to the true backlog mod 2^32; it can't
> represent values at or above 2^32, but it doesn't drift further.
>
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101=
130.16203-1-jhs@mojatatu.com
> > Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatat=
u.com/
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> [Severity: Low]
> Should this carry a Fixes: tag, and possibly Cc: stable?
>
> The u32 per-flow backlogs go back to the original fq_codel and CAKE code.
> The only reference to history is the prose "follow-up to commit
> 8f735d64382d", which backport tooling won't parse.
>
> Other net fixes around this baseline carry Fixes: tags, such as "tcp:
> prevent collapsing skbs across boundary in rtx queue" and "llc: reserve
> device headroom for allocated frames".
>
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index dc93267029e70..8e99c85dab17b 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
>
> [ ... ]
>
> > @@ -1466,17 +1466,17 @@ static void cake_heap_swap(struct cake_sched_da=
ta *q, u16 i, u16 j)
>
> [ ... ]
>
> >  static void cake_heapify(struct cake_sched_data *q, u16 i)
> >  {
> >       static const u32 a =3D CAKE_MAX_TINS * CAKE_QUEUES;
> > -     u32 mb =3D cake_heap_get_backlog(q, i);
> > +     u64 mb =3D cake_heap_get_backlog(q, i);
> >       u32 m =3D i;
> >
> >       while (m < a) {
>
> [ ... ]
>
> > @@ -1493,7 +1493,7 @@ static void cake_heapify(struct cake_sched_data *=
q, u16 i)
> >               }
> >
> >               if (r < a) {
> > -                     u32 rb =3D cake_heap_get_backlog(q, r);
> > +                     u64 rb =3D cake_heap_get_backlog(q, r);
> >
> >                       if (rb > mb) {
> >                               m  =3D r;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does cake_heapify() ever
> sift down more than one level? The rest of the loop is:
>
>                 if (m !=3D i) {
>                         cake_heap_swap(q, i, m);
>                         i =3D m;
>                 } else {
>                         break;
>                 }
>
> When a child wins, mb takes the child's backlog. cake_heap_swap() then
> moves the smaller original entry down to m, and i =3D m. But mb is not
> refreshed, so it still holds the promoted child's larger value.
>
> In a heap that was valid below, the grandchildren are <=3D that value. So
> lb > mb and rb > mb never fire again, and the loop breaks.
>
> For example, take [1000, 900, 0, 700, 0], where the root flow holds a
> 900-byte packet followed by a 100-byte packet. cake_drop() drops the
> 900-byte head, and cake_heapify(q, 0) produces [900, 100, 0, 700, 0].
> Node 1 (100) is now above its 700 child.
>
> After the next drop from the 900 root, the next overflow prune in
> cake_drop() can pick the 100-byte flow instead of the 700-byte flow. The
> bottom-up rebuild in cake_drop() has the same one-level limit.
>
> [ ... ]
>
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 969b2510b0b86..3c20297cef07e 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -51,7 +51,7 @@ struct fq_codel_sched_data {
> >       struct tcf_proto __rcu *filter_list; /* optional external classif=
ier */
> >       struct tcf_block *block;
> >       struct fq_codel_flow *flows;    /* Flows table [flows_cnt] */
> > -     u32             *backlogs;      /* backlog table [flows_cnt] */
> > +     u64             *backlogs;      /* backlog table [flows_cnt] */
>
> [Severity: Medium]
> The per-flow counters are widened here, but does the CoDel drop decision
> still see a backlog that wraps? fq_codel_enqueue() adds the same
> qdisc_pkt_len() to both counters:
>
>         WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] + qdisc_pkt_len(skb=
));
>         qdisc_qstats_backlog_inc(sch, skb);
>
> sch->qstats.backlog is the __u32 backlog field in struct gnet_stats_queue=
.
> __fq_codel_dequeue() passes it to CoDel:
>
>         skb =3D codel_dequeue(sch, &sch->qstats.backlog, &q->cparams,
>
> and codel_should_drop() then does:
>
>         if (codel_time_before(vars->ldelay, params->target) ||
>             *backlog <=3D params->mtu) {
>                 /* went below - stay below for at least interval */
>                 vars->first_above_time =3D 0;
>                 return false;
>         }
>
> The aggregate is summed over all flows, so it wraps at or before the
> point where the old per-flow counter did. With 4096 x 1 MiB queued across
> any mix of flows, the aggregate is 0. CoDel then stops dropping and
> ECN-marking whatever the sojourn time, and leaves the dropping state if
> it was in it.
>
> stab inflates pkt_len but not truesize, so this can happen below both
> sch->limit and memory_limit.
>
> The uAPI field can't be widened. Could CoDel be given a private u64 sum,
> or a saturated value, instead?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-BA27.v1.20260922092618%40mojatatu.com
