Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC310470E89
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058002; cv=pass; b=AsI+LzLIknY4ICLCqdb0wxdkyEXBI3uoh1vKfsbTu3gfy5GNdTWmdAHN83SiYjb/HGdHENxdbeP+DBaCHwkij9bpDPIvy2xvTt9BprJphtC5AniHgbxPxFt7Kmm5Zr2BpEBE4MbmNuVuadiRRQid0pdeSGv4S+w7CCZGQwBpNTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058002; c=relaxed/simple;
	bh=CTlWdCdWn0sdpo/QtnGGY51FR9pVY4JrG0dJ4EyaUA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2tukndDcxd0mIjFYI+AO2VD6ReJVwgj+cSHXv0V2o8Se8g1IWlMMQyFWBEX7hx/GWmhDzaH4yLWKwkKKkJcv95HTr+AGY4LEOocYXt8tWKZ6EW4yuhWo5VsfwXi40fsJDp/MzIDZVIvyaHKwzy6sTo9b4wX6CsRxCBwoiBS1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3RcnGLe; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3RcnGLe"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f72317a6so235028185a.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058000; cv=none;
        d=google.com; s=arc-20260327;
        b=suTgR69XmQ6eYrwzGq6riiTff1o2iCRAJvFJhzMiBKI0DyJxe3eBxoTC09qTyFMGd7
         9lHawxil+dBpdl+4H5v/7heIkMPpsjhx0XdQKfjbGxwivG4Da+JHpx9PyfQGgB4yoCKT
         WDSALHcLReo2Hpsyvo6w3/3prR7BwrOLHusosFFzmkwAUT7vspATM8PH2V5VKTI5htrH
         r1heaqDQssECf/0Uzt/LwfDiKE/Orhvr2E0bGh93ODf9dmLb247aWJSJh8PFVdtydzsG
         j5244Uq554idBDhD6cqwAtTTNwkWlIzlHSglBjSjHVOkHDjC4Y6Jp4jQBZ+534ggPzv9
         E3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        fh=UsrKk07FccOpEtA/GUEbHfYk93l9IMcC52HeQuS9tL4=;
        b=OcydU7deHhtIGv/GZuywszy2kyVN3JXMERJfC6/w4iVUwYJCQuxTeT99lQOsBvWHKu
         FwRzio6Nr6br5HFgeHbZt8cY8n1YIhiQ7CXjy6AYrfT8ROOiyD1+j0lwW/3hLJBlzzy6
         dBC+g1duei5sIz3DKVRJC+EKDn4Jo/jxbz5JW4YREchg6uVZUDcGlYAxX5H9GNrO7IUC
         BaVvuwaSOPnrJshC8CiNUA6VOeRzFxjQ+ZuCxmO3+ED7/2JtT893fvsy+m73cKerpAMS
         5dKOD54C+PYGRSuTQR9k9BVTVxgjTks9rSBNRqkAg3gGQ870hcBh7RycLcxQZCrV9axf
         uv+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787057999; x=1787662799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        b=D3RcnGLeaTt9Q3kSIjGpAGGtU8/Q6TkAiwsAQqK+8lxxITB4mfvgTrNuH2A0D/5Cxr
         BctmRcqC9BWY17e8QoZxCFXAD0DWMruGiF43YN9dtzJUo6hewkDrSZzzHNOSAXnANali
         NKNletHEcZowP8SRj4l52Zd+NN3XCvvXxOTWpXttJrAYL146Fg9P3An3vH2Y4IPbF0RX
         rO78YqiPHQSdMSJR3zNPNS/z3vWvKWAOyG9ErVhaZNwX0C3N7aF2p4X6DEKiMYkZKZJC
         2lrjJnuJ6M96SIW3mwGanbGS3UJEyL1+uDv6BA820pTnhctBjNMQgJBkwiTtz7aiQN/I
         pWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057999; x=1787662799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        b=rOgRMGqzF6tM79bC3bv2wm6W2UOMfz3SpC18tLgnwE44Evz45Wd0ki2pkGjWQzP/Fa
         pFzwF/684jCISVCw1LhCKMNMvt0foruc39rmR22h6GF503JJODQMCPuWAbtCBHoeFWuA
         0GsIvMjsN4xLx5KFSbQHZg1PreO7IvGwwLNtlbKmrUguOb6/aX1pDcLhs6A0IJMieAsu
         iUiMl8wUdzr1HWaQM9MWxOKLKUfaIkmuzR2NqGpNU+odvcPi0eNZmHsXwZUmZwiNCHlP
         j6C2r3CISIoGma6N4+tiX9EEUtH6cSjCBmP0G3sI89W9doMjNrxD8zW9sLh0X4bnQKT/
         ojSw==
X-Gm-Message-State: AOJu0YyoCUVjUGfsdIgzjGWxee4/vRraKUbxhtytoAjpMYUZtufUfHER
	Mqw7/N2wIB9f5oecM1NgqiBNv1YimIQBhVYzMs3dF3E+83tlmS+n6vRDLVf+4vGFBEACeiRh45L
	mgz5MZ1Z2qGxGytcyP5N/OIXS3SaGKWGBNu36wuGg
X-Gm-Gg: AR+sD12eEmsY6L8rZ2m7U1zgPNg/ArwMmIL6ZRe0LnOPICYwlliRAjfv4f8FhuGmx3U
	fiphnQelxNcDgHaI7v3/QN0nqosHfhyLdSEdRC9XptOF3bNmx+CUz11oHKhR+lnwUy2Fag8zIJk
	y1ZptSD0RCpa7TiApT1G356x9ZIWdltzv7Fx0RY0TvZAjnkmcwJ1HrwL6JLoncozdydR0stD9oA
	jHvrkUEUZ+bvS4Ld+Ear2DaDQ/ktUIP2hNl/jzcRWV9nqUOB/fgcFKKDpst2iA7JmU8BBtNfpLU
	RTLUXay3CMEdu7l2y8u/kVvTFyDSqh1rJ+creLDsJe+TsDZg8dq4pYTykaTqPy2p5MGx7X/1HcA
	cIDVksJKighPnHLXmC4LhJnLvWPAnjvwPfMSwqtg5fvYdXpmYuA9R6828E+bMoQ9uh1Iy492Kbt
	fGhAkRSJXpTWR+7Jc=
X-Received: by 2002:a05:620a:3186:b0:915:9fba:8794 with SMTP id
 af79cd13be357-93704adcd2amr715177785a.6.1787057998665; Tue, 18 Aug 2026
 05:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101130.16203-1-jhs@mojatatu.com> <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
In-Reply-To: <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 14:59:47 +0200
X-Gm-Features: AcwNN1VwsHCaP5nGD4dlBiEKOtnuzH8ayp4kATRtISfCWRsny2WTsEy-k6N2g3E
Message-ID: <CANn89i+edjh3JMZKTwG-gVtvMv_ya-wVUfK-yuKahRcoUoYDdQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 18, 2026 at 12:11=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > Several qdiscs derive their per-flow quantum or backlog from psched_mtu=
()
> > or accumulate qdisc_pkt_len() into a u32/int counter without an overflo=
w
> > or zero clamp, which can drive the dequeue/credit-refill loop into a so=
ft
> > lockup or a NULL deref.
> > vega@nebusec.ai provided reports and PoCs which illustrated the followi=
ng:
> >
> > - sch_fq: fq_dequeue() credit-refill loop with a small quantum spins ~1=
B
> >   iterations under the qdisc lock (soft lockup); fq_init() computes
> >   quantum =3D 2 * psched_mtu() with no overflow check.
> > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u=
32
> >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a f=
ew
> >   packets wrap the counter to 0, and fq_codel_drop() then picks an empt=
y
> >   flow and derefs NULL.
> > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow ch=
eck;
> >   a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit +=3D weig=
ht *
> >   quantum loops forever.
> > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge =
MTU
> >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles bet=
ween
> >   INT_MIN and 0 forever.
> >
> > Clamp the quantum to a sane minimum and promote the backlog/credit sums=
 to
> > avoid the wrap, so the dequeue loops terminate and the drop path never
> > selects an empty flow.
> >
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c       |  9 ++++++---
> >  net/sched/sch_fq_codel.c | 14 +++++++++++++-
> >  net/sched/sch_hhf.c      | 12 +++++++++++
> >  net/sched/sch_sfq.c      |  7 +++++++
> >  4 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 7cae082a9847..66e9c6e530d8 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sc=
h)
> >         f =3D head->first;
> >         retry =3D 0;
> >         if (f->credit <=3D 0) {
> > -               f->credit +=3D q->quantum;
> > +               if (f->credit + (int)q->quantum > 0)
> > +                       f->credit +=3D q->quantum;
> > +               else
> > +                       f->credit =3D q->quantum;
>
> Lets not add cost in FQ fast path just because of a configuration issue?
>
> >                 head->first =3D f->next;
> >                 fq_flow_add_tail(q, f, OLD_FLOW);
> >                 goto begin;
> > @@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >
> >         sch->limit              =3D 10000;
> >         q->flow_plimit          =3D 100;
> > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > +       q->quantum              =3D max_t(u32, 2 * psched_mtu(qdisc_dev=
(sch)), 256);
> > +       q->initial_quantum      =3D max_t(u32, 10 * psched_mtu(qdisc_de=
v(sch)), 256);
>
> We instead can make sure quantum and initial_quantum are in an acceptable=
 range.
>
> [256, 16M] would probably make sense.

Actually, we use 1M in TCA_FQ_QUANTUM in fq_change()

We also need to change fq_change() because TCA_FQ_INITIAL_QUANTUM can be se=
t up
to INT_MAX.
