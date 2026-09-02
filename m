Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B048551D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352815; cv=pass; b=ugqT3H+SQf/6TS6zftZBjKRjvIgn924TnO40/phihmvNaGcnmHNbieHGrR7vZk/VB1v2IsLsL10BerjlzEwvo1YTGoFx6s50w/RXeiPn6h6YkzLF+PT445sm/PDRxLCapE+9oa9peY7GTweDYhmzMESEmZcYYYH8/vt15xcsCew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352815; c=relaxed/simple;
	bh=1yrXK+KMTWtQDhDpfeqZ4eO3AXkph/2cmD38nAMwoU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdJxleddgC/iVJlxgr8xHwbkn6tx/gtqCzAycWQo0sZXTN/fktMTMPVnddtJuRz+naPvoI0CqIUggpC+xySH3KQtfp6CIFRzDzY+H19984hRI01EoagPMy3S67zN9w9Wk0YhqTABB5w7Jb0h9VvTuQS7+Z40iYj2yXq6/cKYxPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cs+0sVWu; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cs+0sVWu"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so799374b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788352812; cv=none;
        d=google.com; s=arc-20260327;
        b=AeLVQ8DJfI98AtYU2hHgbTgTnFXVZDJuRlD5V1ZuT5EXzT709FZqcjSE71xu8zymkb
         V1Purmm70E99dsLFJY1qVv0nO9+ZJLIatCSK4uNPzZiWxrzFIwn6E/qyMuAW23lmpE83
         K91C/6omEiJLdN/n/3DTlYlL7hdFvW6+qTHKwOX0NNlPuuEqVrS6ZC+OyYNxsmFXqWw1
         Ffa58uLR+CP+RWPJhjoULtcTakNIdF3Q3nXR7WLZEjT7KGb4KnuxPjFO7ARuVbEnYAaa
         905HTwlckDeO/Kh2L6ZxcO0DGm7Zv51ZxuVQfqOzGGyyorra25WQ/Mdz3DQQn/ieicm7
         /9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        fh=m3lNRksJ4Yrn86ew3aCTlU7BBU/3gYiVHWMCIKF/PA8=;
        b=VaC1ozma0P692kUp2nZ0yFJXdD3N7t5Wf0Rh+AUk5G6dSrDtOnjKFjPvXgy3FP9iRo
         AehEo4UzCDDvr9VwzHqdycgtY3NxzGAMQXi9jNnjOrzD/2rhOpoylH+kY4Nj9A4Rf5vu
         /V4HjQFprX2vj0pT/MyYGKf1LqVzYgGjlFvgXpC3puzTXGxoz87YuTXtgBzdfB/QSJJx
         OXd++nx+8TrMN3M8w5AWggqCmt2IO8+IVhVeuyixMWwpgwPglapV9M27rcL7LXwMVzcP
         O0ao7ZHg96W4qdLmfoYj95HC4/KDGOeA2P6Cst6U4V6hpkTqKI6OxAFK8NKTce1VkgCv
         rkeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788352812; x=1788957612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        b=cs+0sVWuyCQ3AkqiJgAYqhaPN/UZkojc91n0XAOjF3cl0unyUTI6k5b7bB6DE4T4MJ
         3HyuNiTLzs1FE0U1u84Zea2X63I7zy2GnAM3h7PnHAMlprsnWZZf/zOZbSBte3agJIOL
         jIhsTH4Gvc+mETNNQ3Kny79uwYeWeM5vLQUmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352812; x=1788957612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        b=cNjhnBAbq89NtiIJ4zqejF2R0lOld1g3DYJLuzZlOr/ovXeYj5LPEmu031xABaF3xL
         1r/LjaiA1AaV84pIwkGisH5kQz5/cRcba7goQCrJCAfHsVEuDjWu372PlpaSP4gl98cx
         j7O6uz6lqdtDZryM6NLAUzI1jcy7WfESqBpCeMA1cKZdoL2rh748LF9MhDAeuF6afoMt
         Uf/O64SE7DDTW/Zn2ln8mj/yhpTfSN5eyJzT+t/enEXZAj8EL/HnHNU3UCT0BhJeWWVZ
         thwh2xT6Zk+uoUlvRZXkdeYnUJNcmqBtQ1tCWMrsSkY3VOIUN/R0jOr52D2tVDNJ4tnl
         dPEg==
X-Gm-Message-State: AFuF++kn456fYHSIwai1QDrv0WlBvj0sIlguTqIcirjMER4qhJYiW2vj
	9Fg1v3oDTtvlN1leVQp7BAikV2W3F3gpMhkJSE/1uFooMul9bGz0riUUvPAiK8suwXtnP43nKAB
	/jBfNbpHZL3rTqBkDo+sodDoPTix5bM+l5me8D/jD
X-Gm-Gg: AYBFou2+9hCBFuOvEIlVdCN/WItZwcw014naM6pCuNtTY+ivAkHRTXPlKCzkimzRo1R
	oS6E9F+Y2IcLiQYqP+bPpxbT85XAaMNTS6x7AU23DEev240ma48CQxWToAdAYe/5CWOT/UV9aO4
	nn05DOkgXNh/yRU3MTTPWd6qexKcEKijDCozt1UQyBJVQlEXtq27dnhtt12uWyEap0hI049gVjd
	w5RiLrGGb5ipQadPhlLFspOun5AOOZYhdtrPcZV8NUlFe8ZnmeH+Uj+NsXZBDXXDkGaRZVpyDIT
	Z24qxnKuvz4RAj+8KeD4aTOIJV/iQYY3KdGtsJlPNjAbqhJC/D/tWjT+bPmT/XyM/TUr/05uLPW
	T8XbUSNDQoZGti29UOTyXbOXN+fJAjx1UIT77uA==
X-Received: by 2002:a05:6a00:2183:b0:857:727c:a1f5 with SMTP id
 d2e1a72fcca58-85ed4640011mr6311509b3a.23.1788352812452; Wed, 02 Sep 2026
 05:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com> <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
In-Reply-To: <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 08:40:00 -0400
X-Gm-Features: AcwNN1VEEvRrI0fCJStQeTRB4HwPfEl6ZGPqrGO-f0KV6-7LSGTQUkw3B_YuXmk
Message-ID: <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 1:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> > > TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps =
to
> > > [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> > > restoring the small-quantum deficit spin that the init clamp prevents=
.
> > >
> > > Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> > > parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> > > fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
> > >
> > > Conditions to recreate the bug:
> > >   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> > >   unshare -Urn suffices).
> > >
> > >   tc qdisc add dev dummy0 root fq
> > >   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_l=
og 15 cell_log 0
> > >
> > > Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum a=
nd initial quantum")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/sch_fq.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 6144b5686f13..35f940b2205d 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> > >  }
> > >
> > >  static const struct netlink_range_validation iq_range =3D {
> > > -       .max =3D INT_MAX,
> > > +       .max =3D 1 << 20,
> > >  };
> > >
> > >  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> > > @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struc=
t nlattr *opt,
> > >                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
> > >
> > >         if (tb[TCA_FQ_QUANTUM]) {
> > > -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> > > +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QU=
ANTUM]),
> > > +                                    256, 1 << 20);
> > >
> > > -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> > > -                       WRITE_ONCE(q->quantum, quantum);
> > > -               } else {
> > > -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum")=
;
> > > -                       err =3D -EINVAL;
> > > -               }
> > > +               WRITE_ONCE(q->quantum, quantum);
> > >         }
> > >
> > >         if (tb[TCA_FQ_INITIAL_QUANTUM])
> > > @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> > >         sch->limit              =3D 10000;
> > >         q->flow_plimit          =3D 100;
> > >         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > > -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > > +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 2=
0);
> > >         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> > >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> > >         q->flow_max_rate        =3D ~0UL;
> > > --
> > > 2.43.0
> > >
> >
> > If we consider dev->mtu admissible values, which are in [0, INT_MAX],
> > we have to guard against u32 overflows
> > for 2*mtu and 10*mtu expressions.
> >
> > Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
> > and initial quantum") missed this?
> >
> > Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
> > and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)
>
> Wait, I missed the
> mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
>
> Not clear why we have so many clamp_t(), this is quite confusing.
>
> We could instead:
>
> mtu =3D psched_mtu(qdisc_dev(sch));
> q->quantum =3D clamp_t(u64, 2ULL * mtu, 256, 1ULL << 20);
> q->initial_quantum =3D min_t(u64, 10ULL * mtu, 1ULL << 20);

Trying to understand your concern: Are you arguing for
stylistic/readability improvement or robustness?
The only place i can see where the multiplies you describe could
happen is what the 709f34f7c28d patch closed. i.e this part:

-       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
-       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));

IIRC, you are suggesting restoring the original logic (x2 and x10) and
i am likely missing why that is a must do? Does it break anything?

cheers,
jamal
