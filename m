Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7821883E
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296008; cv=pass; b=IG4o2TmvdJiSmYYVxhf4FXiPc0u2uRnvhnf6R/HpHemrM7B9GfdUojeeju7kv7k0lyHq5iisD/jpxmQXszrXAzmVmZhCQULXJ/tNG/uovCuGo9XNf+U1p7Hx1IQTRX/JDOEnL0xC704Sk12ayhYYhHg/cT1Eh0zLroj6TnaLu0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296008; c=relaxed/simple;
	bh=inzo/cTODvlaboBfv0Rt39GMlPZuqOiurL9yL9dWm38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drX1ibMQsa206E1mmt9mNvLldmyO30tGbb1U/h68LU3fsFjWdHnml0fi88OpIh62715cTWpQevt+OSou9H/3EmtYPrQzlMrzAlnA/l/QyXw6S280xCviP9+WxFWrSYXq3bCMCs4UGhGkTbBxk+RK1bRGg5OPLfMJhPqT61NR4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xp9RoaX3; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xp9RoaX3"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a0so929565b3a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789296006; cv=none;
        d=google.com; s=arc-20260327;
        b=Vph2f8Z8ZFHtY5OPlT/+X8+TcPs3uHH/1od75huguC9UaxOGNpKSSs3vVocmy8b+Vd
         hiA3qOEaOc6Dsm9biPb4OUBN0C4EJ6DBfBOZ/FM/0/T5umYwwvlqjh2A8Omnw3b91iCH
         TT+OExuNdkqKkTtWHH1Di2w2KvIj17DL80Cy62FICslnFJKZ0/6EY2K4vHjg8PyGUNvm
         eDLa1WgcyW7SEBElXkBzpT5yrCLUskyK3PkkHhqwNOllmeC//M/zMNPMkB/P0Xh+r9o5
         kUxcK7+0fmOBTfNzJtqNjdy7cY8oAHph16boXveD/zB73BZwSxBQ2V4s09cRIbsNJOzo
         jnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xskcn0qMbofh+kYQXbTqEoSCWMBqJ80KQXaGsEc3+1k=;
        fh=zwdhoj3PDXryQG/cK8Y56AQ80PecJs+PfU2LJmQE7/k=;
        b=Ihr0Sekjr36uln+14EgFZY0BWCP2bOfXotlc5e2BA2ov/TUbU5OXM5b0Kk8mNAkcfL
         PYlYK9dacRX/osAOc3hr3D+eJmqo6HVxmv7eRRDRS2oz23Rkow3QymEpbBXk8ccg2cSl
         YjtBws5fv0H6mYmNqNFiQaa9YAc+G9KFrxDfNurg57br2Y0wZ1szbxzzFaTXsh1S8lDJ
         jdc/nAtKuupmlTHeGFcf42p8AsMlIsyIWy2owKLraHn1iXDdlf7Blow8aq7w+30Eth4I
         NtIdmesiSwUljz2zqs0Z9bwFfpi16yR4P4KweY8ASqkCfdB1baLFzP0ngPH0oZ2V2vZS
         PHOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789296006; x=1789900806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xskcn0qMbofh+kYQXbTqEoSCWMBqJ80KQXaGsEc3+1k=;
        b=xp9RoaX3w1v4iHPWy+PX9uxHFKW8/76fqoQbtxabJ+ZRVj+KhIxLrG1B0HuPy09xg/
         Uv/WBgcD46eOqOAnUSRIN/srzW0lv142Ruh5Oa1LwPUh2GusnlCKKI1c71wd6uKCqVYH
         hEBmNVmKqXsQPZUxH27wwMdUeIvM5xIpUF0Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789296006; x=1789900806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xskcn0qMbofh+kYQXbTqEoSCWMBqJ80KQXaGsEc3+1k=;
        b=CFylLBeApdqvL854H8zL7UL+I25H+utrs9D0B2zomMDtsUF8j+/s/t0sASaezaQZBJ
         6E8E0xWPwjeOPjuSsiYQS8yw+ceziiGAPA8fCrAs5aOPTRog5HAGAe9eNDmM6naLnEy/
         LgmjK0u2liMtpzmuCZk2/iOg0h+75h/HDJFZMnqTJX9S//mvTyjqvApQ93nB+PMI9VMX
         TCN4/bdYH4p0YlG/hLTHfjMNtzsCQDh3GutodZKEHdJY2iUSmJ4U+TzGZOSpesIVT25W
         4WPAJ0MxcG7qRSTeIm3gQM4lGip9GpCgLawovhV6cOh5LS6wL3FPZpzxEuiufT06tqw5
         Dltw==
X-Gm-Message-State: AFuF++lwOQ9Ous5cNaxiftyhnT1aRK8R2PKNqvj5hsnWNE1QxUzVHHBH
	m3pfVSbxKdGqv/zPdy1g1GZl2vHeukWoOR8zFU+WYkxJPF03b5fVoXs7t/m3f7BEo0o2qpLcEMq
	UuHrWOerVgqFEPtux83lP50A22Khn7YeSAWfYuBoF
X-Gm-Gg: AYBFou31gOK6ZfiDw54XoyX6VoJw5PvNb0cc35qWAaC48+KU9p2D72xNwbMT1Ov2Jyw
	oe4zTS2Nb2xRuUfN4k90DuFoEe5NqRfpIemAtoGrq2rqUZ6YlhUS+9sw5hTNsTMzZIKLkUawXou
	hLR8vIBOFXYYeZYmKBFZOpM6pqglLKp7DheLt4Xk7db+440JzoWb4M74YSDnBxEHBmoNnUdSyRa
	qb9NZ7MpRIsK17Ba3QMc2rEq+xbTHYkUM63/W6rxGeWuF+sA+ehgikUtlS7F9tKiCa1TFomYdqc
	vJI11bpMa506y6NrT6AQd9XePh7w5Ga5U3/f2zb//xsgbIZh7m9i+GM3aEQ4zyMt0gtASysrYMb
	PmhRL7YlV1GiKWP737JtPgFrxmdYylcJjdDE=
X-Received: by 2002:a05:6a00:1821:b0:857:72f8:dc97 with SMTP id
 d2e1a72fcca58-86ccbc47960mr11019917b3a.24.1789296006436; Sun, 13 Sep 2026
 03:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-CTUU.v1.20260908094501@mojatatu.com> <178924538639.3125.3879861212376394770@kernel.org>
In-Reply-To: <178924538639.3125.3879861212376394770@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 06:39:54 -0400
X-Gm-Features: AcwNN1VuKe3E1BwM18wXzPSzzFnkG9TlIKFONILWlN-tPcVA0G0-bywRMd9ZkkI
Message-ID: <CAM0EoMmXiB8G_ykHY2G+t3WM6MnyyVENQTr-iKt=e_R3h8ud=A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_hfsc: bound the classify inner-filter walk
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kaber@trash.net, sashiko-bot@kernel.org, victor@mojatatu.com, 
	hybris@mojatatu.ai
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
> - [High] hfsc_classify() (net/sched/sch_hfsc.c:1146) seeds the new cycle
>   guard with `hops =3D head->level` where `head =3D &q->root`.
>

Yes, this was an oversight on my part. I will send a v2.

pw-bot: cr

cheers,
jamal
> --
>
> net/sched: sch_hfsc: bound the classify inner-filter walk
>
> This adds a hop budget to the inner-filter walk in hfsc_classify(), seede=
d
> from the root class level, and drops the packet with a rate-limited warni=
ng
> when the budget is exhausted. The intent is to stop the classify walk fro=
m
> spinning forever when two flowid binds end up pointing at each other afte=
r
> hfsc_adjust_levels() raises a class level.
>
> Link: https://sashiko.dev/#/patchset/20260824161809.4147223-1-victor@moja=
tatu.com
>
> > diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> > index e87f5021a1995..71744a6c2f38e 100644
> > --- a/net/sched/sch_hfsc.c
> > +++ b/net/sched/sch_hfsc.c
> > @@ -1133,6 +1133,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *=
sch, int *qerr)
> >       struct hfsc_class *head, *cl;
> >       struct tcf_result res;
> >       struct tcf_proto *tcf;
> > +     unsigned int hops;
> >       int result;
> >
> >       if (TC_H_MAJ(skb->priority ^ sch->handle) =3D=3D 0 &&
> > @@ -1142,6 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *=
sch, int *qerr)
> >
> >       *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >       head =3D &q->root;
> > +     hops =3D head->level;
>         ^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
>
> Can a legal, acyclic chain of flowid binds consume more hops than
> q->root.level and get dropped here?
>
> The budget root->level is an upper bound on the number of internal classe=
s
> visited only if every filter step strictly descends the tree. But as the
> commit message itself points out, the descent check is only reached on th=
e
> classid-lookup path:
>
>         cl =3D (struct hfsc_class *)res.class;
>         if (!cl) {
>                 cl =3D hfsc_find_class(res.classid, sch);
>                 if (!cl)
>                         break; /* filter selected invalid classid */
>                 if (cl->level >=3D head->level)
>                         break; /* filter may only point downwards */
>         }
>
> For a flowid bind, res.class is already set and no level relation is
> enforced at classify time.  hfsc_bind_tcf() checks the relation once, at
> bind time:
>
>         if (cl !=3D NULL) {
>                 if (p !=3D NULL && p->level <=3D cl->level)
>                         return 0;
>
> and hfsc_adjust_levels() later raises levels without revalidating the
> stored res.class:
>
>                 WRITE_ONCE(cl->level, level);
>
> So the walk can step between classes of equal level without cycling.
> A configuration that the current code accepts at every step, with no cycl=
e
> at all:
>
> - A1 child of root with one leaf child -> A1->level =3D=3D 1, root->level=
 =3D=3D 2,
>   so hops =3D=3D 2.
> - A2 as a leaf child of root (level 0); filter on A1 with flowid A2 is
>   accepted because p(A1)->level 1 > cl(A2)->level 0.
> - Add a leaf child to A2 -> A2->level becomes 1 (root->level stays 2).
> - A3 as a leaf child of root; filter on A2 with flowid A3 accepted
>   (1 > 0); then add a leaf child to A3 -> A3->level =3D=3D 1.
> - Filter on A3 with flowid A3's leaf child (strictly descending), root
>   filter selects A1.
>
> Walking a matching packet: A1 (hops 2 -> 1), A2 (hops 1 -> 0), A3 hits
> hops-- =3D=3D 0 and returns NULL, so hfsc_enqueue() drops the packet even
> though the next step was a leaf.  Before this patch the same packet was
> enqueued into A3's leaf.
>
> Would a configuration-independent constant avoid this, the way the HTB
> side does it in htb_classify()?
>
>         if (++hops > TC_HTB_MAXDEPTH) {
>                 pr_warn_ratelimited("htb: classify loop detected, droppin=
g packet\n");
>                 return NULL;
>         }
>
> The commit message says "Bound the traversal the same way the HTB side wa=
s
> fixed: a sane walk strictly descends the class tree, so it consumes fewer
> hops than the level the walk starts at".  Is that premise consistent with
> the rest of the message, which states the strict-descent check "never run=
s"
> for flowid binds and that levels drift after bind time?
>
> >       tcf =3D rcu_dereference_bh(q->root.filter_list);
> >       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
> >  #ifdef CONFIG_NET_CLS_ACT
> > @@ -1167,6 +1169,15 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc =
*sch, int *qerr)
> >               if (cl->level =3D=3D 0)
> >                       return cl; /* hit leaf class */
> >
> > +             /*
> > +              * flowid binds skip the level check above, and levels
> > +              * drift after bind time, so this walk can cycle.
> > +              */
> > +             if (hops-- =3D=3D 0) {
> > +                     pr_warn_ratelimited("hfsc: classify loop detected=
, dropping packet\n");
> > +                     return NULL;
> > +             }
> > +
> >               /* apply inner filter chain */
> >               tcf =3D rcu_dereference_bh(cl->filter_list);
> >               head =3D cl;
>
> Also, since budget exhaustion is reported unconditionally as "classify lo=
op
> detected" without any evidence that a class was revisited, would the
> warning be misleading for the acyclic case above?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-CTUU.v1.20260908094501%40mojatatu.com
