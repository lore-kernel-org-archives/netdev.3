Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C49B5BA
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097580; cv=pass; b=iXTYzOMILzSjVCcHeSwgAGPpPJFoqPu2GuuJz87alRoeg82WKiRLxXJEiyv3MFdgLBjFgWMlwOgkBWyrMgDtZGyP5lTmc+8aE+vBrWmbVO/cWwe3l/QwXQ2fyIiVzaaLFqjaqGp5Wh5ZpQZVsn48a9rtS/tyWWI5wLg70rtUqis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097580; c=relaxed/simple;
	bh=hxk1QMVCnerU7l4ILDOHxLnF1/4FmNo059jIytcT46c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Sc4DsBcmGe5qS3RPhSn1Y3eskp8rbWgtXVo17Yjzgh/dySBg1qsCeRxzVaFmT+Pu6CTD302GXH0MM/4Jg9y9W18gdbi029NkjYRScei8stqqWVNu5hWtR7rd8m25g4F7eDlpQ8ZKoy3Ek3ZcWKzTuiFgAcU4aFH8vsdaehTSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=zDwmN2aI; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="zDwmN2aI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc758830601so1767193a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097577; cv=none;
        d=google.com; s=arc-20260327;
        b=AxGjRpAknDY0p2do1sN30a/4TMxoxnza8CD1iaHE4pn/yGoDd6FEYsmlVZ+nZayoTO
         LdDM8AKxbnD3k2XOI+dnxngiizscOlu7H0R78QO9q9XfbV+YPv6iL98iW5wrLv0YQKqt
         MqrELgh1uJ9YJhSHJh9fSotBJeIvHp9YvD/XlYGugEtsMLUkqD6A0sqe6mEKxmH7XWy2
         zAyXgAV7xAcNrUiORju59KA4fDIIuVcrOgVNna5/2wBtzCm21ktUsQZHW2z5nGfdAO86
         wS7/FahAQAd1F/FGMbon3SdT89/sCfmUESThws0zuFPWIfls5cEwX5pskrH6tflZcdll
         DbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        fh=lcAA+AMPC/+vSODQfeIl08gXTdPOwtNNZbqVu1jvglM=;
        b=cRgTLYZ0raEe4uDqf1fZn3X4o2EVz6fPGp1c6Pz6eOOIh53gRIUa+kF5HV1BLm0jvY
         TNJMmfNHOPCThEpt0B1wNP1vAgypEhVIhW4RNNuzsj12NI7dIYHvo4COybnIvDuXHw3H
         m7uovVajc39Bq2QMrMG6ReMvdtN8i2SFhH8qJp9aIECyIeG+Rty+m/dNsPpdUbaLq9z6
         RQ6vdk+szEnTgCWRgslGfM2+P6SaAyRsAZAgHRC5xEpV/qem0zbjpKwuyG17xaAiA7EY
         YQo6GL9n3bjanvV6m6LB7/EVH4dJ5sqdKMnUF+dhB7XqbHgzSSUkTqOR3dLixX+7U759
         Uf0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792097577; x=1792702377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=zDwmN2aI33byk49i0k+0Tbs+be4tyoIiwisrHCykGmnNzN5Vlz+L1o+lsOUXwHBgtz
         fMPl8Nt9yew6NbZVwBQocwHDfkcliGfGf8HVxWLx4snSRU5Rf7C5KZa9fXF87dApVkPj
         IwK9Clflold6Bjf8bhg8y1ic6aEDGqcN/Fodw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097577; x=1792702377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=J1FJa36z4jRahGy7myXjFWLQzOY2bdNNDIDFZs3A9tD+jOwqGnDeOJa5anqOcuUSps
         dW44gbSGKCD2lrXfujRypDaU4dhZtst0ZProBoAHIFRid5c1n5+7AkXYac9OeNTe/jCH
         cRtNENlXd5o0lxtNSp2mRPHBcMMZ70vWS8N1jwHtwNk84lSmv54/ZrY0gBdjIMhjHt3P
         KDCj5ZktUVZljDgPjFF8tv71zCG1oJ/QLcKKrqA2KbY1ykfKwoz1/8MU/ThRsozY4Xbn
         hgnG2prhXOrQiGo+S3RWIoQWaxlIXK55Bg+cRYu0hKTFfuwTMdbgtr/IWXqfe9OL0VQn
         36Lw==
X-Gm-Message-State: AFq9FYJMf4A8H45JjMzP1LBBspcHRiSCUwV5hJJpf93i84MGHnQHVPZj
	OYGgWRQrOBEj+HNsYB/R+sXMUBpomisVxX6wpk9iLwP9UV7jxcunAOrDOIdu9Qp40eS6vNRAAJd
	AWgk9xNsbKIgxeBBpw+v+pSjbC9BblmS+WUyfCT8f
X-Gm-Gg: AYBFou0OyE0R/+bxmGunu5wzqoI1eYam7j6FxCNdUNUIEhAslbGqTDg9bAINUejc/Un
	5ovIcHp7KQbx1xocHss23VR2zgUrjrImChMmsVdeiXoGf/n07tY6WACELiZL5IL0yhKgI7+IgMi
	sl8uhs/6XmsypURFISW08IixOm/gGDNj/m+Ox2hvsidV6KMGZ+sKcl7EoBL0oUKEVoMVIatXx1a
	e9l9iOlqi72UYM/8z9kLOawOFJcdh06z1T5ZqeTbU/R9DAzsMrh7QCADNZGWMFB83mHGmTACSEe
	iur9uNz9KpfBqr0KDLd/+75EkebseHqthtOylMLzwIJLDXP4WaBKZO+6nkw3k7t3+cvpyCabH8+
	cA1UQ1pdxdspI+IQLpQE+VXWKt/xgeHcdZnSlCcEim8pv
X-Received: by 2002:a05:6a20:6f89:b0:3e1:c08e:38f1 with SMTP id
 adf61e73a8af0-3e1c08e7cedmr10140367637.14.1792097576957; Thu, 15 Oct 2026
 13:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-MD1X.v2.20261009135842@mojatatu.com> <20261015125822.GH83879@horms.kernel.org>
In-Reply-To: <20261015125822.GH83879@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Oct 2026 16:52:44 -0400
X-Gm-Features: AclHuK-3WqmxRH2VJ4NQkGPyh93QYe2dksXJg7Bq6GKxJGeNOPh9iFVtk_DYmvc
Message-ID: <CAM0EoMnhmww2koBL+V0fgKg4qp=3E2Bf23iUSyxtoBPYbYi0Wg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:58=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 09, 2026 at 02:09:03PM -0400, Jamal Hadi Salim wrote:
> > This issue was caught by Sashiko (nipa). A producer-side path cap is
> > already merged (ea4d4b5dddb5); this patch adds the matching consumer-si=
de
> > cap.
> >
> > The issue:
> > The tx queue is picked and capped in netdev_core_pick_tx(), before the
> > __dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
> > egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
> > that store is never re-checked. bpf_convert_ctx_access() bounds it only
> > by NO_QUEUE_MAPPING, not by the device's queue count.
> >
> > On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
> > indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it wit=
h
> > just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bo=
unds
> > txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
> > allocation on non-lltx devices such as ifb. Drivers that index their ri=
ngs
> > from skb_get_queue_mapping() (ex: ifb) go out of range the same way.
> >
> > The Fix:
> > Cap the mapping at the consumer and write the capped value back, so bot=
h
> > the qdisc's _tx[] lookup and any later driver read stay in range. The c=
ap
> > folds into the dequeue path instead of a separate walk over the returne=
d
> > list: dequeue_skb() caps the head, and each bulk helper caps the elemen=
t it
> > appends. netdev_cap_txqueue() already logs a ratelimited notice and sel=
ects
> > queue 0. The single-packet case pays one extra compare against
> > real_num_tx_queues.
> >
> > A bulk-dequeued list is transmitted under the single tx queue lock of t=
he
> > head skb, so every element must belong to that same queue. The fast bul=
k
> > helper (TCQ_F_ONETXQUEUE, taken on BQL devices by the per-queue childre=
n
> > of mq, mqprio, taprio and htb, and by any qdisc on a single-queue devic=
e
> > such as the prio root in the reproducer) must therefore compare each
> > capped follower against the head and requeue a mismatch, exactly as the
> > slow helper already does; appending a follower that caps to a different
> > queue would send it under the wrong _xmit_lock.
> >
> > Conditions to recreate the bug:
> > Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapp=
ing
> > (a tc BPF action is enough), attach it to a transmit qdisc (for example=
 a
> > matchall filter on a prio root), and send a packet. With a 1-queue devi=
ce a
> > store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=
=3D1
> > the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
> > sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so t=
he
> > trigger is root.
> >
> > Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc =
clsact")
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/179033713973.2160803.49145706939=
94398206@kernel.org/
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2=
.20260924072708%40mojatatu.com
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1=
.20261005193231%40mojatatu.com
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2:
> > - try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) cappe=
d
> >   each follower but appended it without comparing it against the head, =
so
> >   a mismatched follower was still sent under the head's txq lock. Compa=
re
> >   the capped follower with the head and requeue a mismatch to skb_bad_t=
xq,
> >   matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
> > ---
> >  net/sched/sch_generic.c | 53 +++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 48 insertions(+), 5 deletions(-)
>
> Hi Jamal,
>
> Weirdly, this patch is mangled and does not apply.
>

Weird indeed. I dont hand edit patches for shipping, so not sure what
happened here.
Brokenness checks out with my local version. I will fix and send v3.

cheers,
jamal
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..b65bec7e2643 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
>
> This hunk results in 31 lines, not 33.
>
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* A tc BPF program on a transmit qdisc can change __sk_buff->queue_ma=
pping
> > + * after the tx queue was picked. Re-cap it against the device and wri=
te it
> > + * back, so a driver that re-reads skb_get_queue_mapping() stays in ra=
nge.
> > + */
> > +static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_bu=
ff *skb)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     u16 capped;
> > +
> > +     capped =3D netdev_cap_txqueue(dev, queue);
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
> > +
> > +static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
> > +                                          struct sk_buff *skb)
> > +{
> > +     return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb))=
;
> > +}
> > +
> >  static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
> >  {
> > -     const struct netdev_queue *txq =3D q->dev_queue;
> > +     const struct netdev_queue *txq;
> >       spinlock_t *lock =3D NULL;
> >       struct sk_buff *skb;
> >
>
> ...
>
> > @@ -216,6 +242,17 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>
> And this hunk results in 15 lines, not 17.
>
> >               if (!nskb)
> >                       break;
> >
> > +             /* Re-cap a mapping changed after pick; requeue a
> > +              * follower that no longer matches the head, which owns
> > +              * the _xmit_lock for the whole list.
> > +              */
> > +             if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=3D
> > +                          skb_get_queue_mapping(skb))) {
> > +                     qdisc_enqueue_skb_bad_txq(q, nskb);
> > +                     break;
> > +             }
> >               bytelimit -=3D nskb->len; /* covers GSO len */
> >               skb->next =3D nskb;
> >               skb =3D nskb;
>
> ...
>
> pw-bot: changes-requested
