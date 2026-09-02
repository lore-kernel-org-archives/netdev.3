Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB97E792
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307739; cv=pass; b=bdGXgTTPC1L7BREELeC9/swn1NuFi/+MeJtaBUje3qj65l6z9EzAql3VwKkIo3RgALq2o9InfXpIyuNepx3DGw+sLRuXWRhTRehqQ7GFVqzRW7Lbg32TXvxdU7g8Z1GWpd80tjgnO8/ctS3hLOPCSirYQPKeUZ3Ej2z2sC3cohA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307739; c=relaxed/simple;
	bh=uY7//sJtZ+PGgPIkLZj9Kz3z0P5hmZSPqQxFQwRLHIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwIOLg4ZMQXXPunCBF9P/ItlEx3eFC79/j5iNbdBbojesrqXKQ2BlOXshoPJqJR1vigGTSJd+quqT5ZWJzjfIqzhWfcWCTru7f+TOsUKiA/GRVskwlh+Mi2qoAG8arltoiCcR6WbLGqjOkXBSRIpziWcanPmAlabiK0U/E6ww/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DC00Aot8; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DC00Aot8"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52f83889a93so4952481cf.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788307733; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8t3zNPZGmXClKVBu6n3Vu6+Vq/Bjtm2XE3ERtRe716aRE3xYjUBQdVDcBhdFgl6f+
         xBszzIW5J/yWYI/bYlKB39EJ+CxGBz7qhlW0+DDPgIXVtQjEu/KnsYwvDlpHvTcDbanc
         rH+Rl17x62C9U8d8OlzpzPmCA3D81mYgewyvmcO6Jl5XRYn/mAk+CRxhPIo/D2DSvsXS
         QiReE3gb4KVu9GZDaF2CCWWDLvqO2sWlU4gnDGq0ovZ09+HXLc211pxQmeGlr0TXjORw
         Bnn+O7a7ANAV9kFyUW5usKi3U/EObO/Q1gwsdLRQequu0o4HnACep2o2nrI8StUlMM+v
         SLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        fh=AukeYB0QOsqywlJ4iWkAnO6L+/H3Jo4TSzBag9fEpZM=;
        b=etB+GVa1xMMGfshxWDmweAXwfDf59GlhLnBzDSZyleNOdZJbbxd/CJNKY8fdBRqTvA
         S0bwH/W81UPGa1eFvw4t4dDjvM03bVDdE98Nrtd3GDKFwHUKPZ6YZEz3+HgLAyNORTUW
         P/FS4T0G5JJHFyyR3S3ryHbHqr3U43P4jiWRaOHvD30sKsbVSps6HQ7oyvybafFech88
         5lhmY4xNVWG+GvHCcert930aX7gAiRN7ITgDlfiIBjiJzd3HR+zGCDPKf9BL2SHV3TBZ
         Bgu2b5kkgo1dpiCDpbzvX0YpO/+wavcLJoj1fYGJrDVZLvNaXJ5i3kSUXNuOPwiCntgn
         XPkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788307733; x=1788912533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        b=DC00Aot8fUzZbRq8j7NIlV735f9hRCYxdXxbPm9i+sPXD0s4TxnsHAHRwR3K5uIR8V
         wxYirVtAeX7H05+IWHWM382+dnpWTyF8YHVj+1y9Tc2bvQUnfS+UeRfIaaJgSq2RTmUB
         K3PrU30zPQt1UBQzB+1tQBW2rCcA9kZKn75N2egqDMCFKJSaT0XTOKXyrbgPGea63psk
         CsIgKiwrp+TxWTqWTvrP0C+yLMXVC7kqObmfCj2DNSG22K8243iZDciQWspf/O2XC/Xk
         CyGsd4yb+uz5Nr9ytTaTtddDHQIwx1MHMx0Whw2WVCTrc98OpsosiwHSvSwvzhQPnvRX
         Ucqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788307733; x=1788912533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        b=Iluo98L4AYENv1WFSIUzFyHd4Rij0b3RlSW0X8Rm0TU405V0UWoIZIJmv+FdbOb+0D
         lCyAMyExsHmYXxB+UrBECE/z2F4Gm9rYgkr7cCfc+MBkT/bjI5vCkLRTZRC6GATyR3h5
         ytu4YRPfSUL4ban4qVKeOsdYy+sAIyqVpXv1nVQVnqVoCopDAKunl9+FG5gmymTSVHnq
         XQihO7xkONvJ+8/SPTA57/nZgD4vSJan+0Fng2GlWxzlC502QlXEbqqBBs6Rl7q659MZ
         ivwtnuD4uG3qWAMVkUZPEVnpChSE3v9KDqBT39DSQRvJjKYsrC6Q75mng6ORL242P2yf
         xhvQ==
X-Gm-Message-State: AFuF++kJwvM6GQm62uzUjus9JUxfdzOse/SFFSll+1D73eHS/GzytL3A
	qvBgkz6R0tm2IStfuqBII2DBdcJ4efuFkX2v7qxmSvMHD8FE3exBdlJv+ncKZhtEySG7OKrIqMt
	QbSfrAOv2fCEAgVI/jBHZMYrJK/pGlFW/dOu94nxA
X-Gm-Gg: AR+sD12K5z/5ehcSID5Z6CVMU7N/qUWO7/AiL/pUYOtBxUX4R/854V4K7BV2L6uvp0r
	8hlBUpLdarRJOQXJvLGx+MZ2y3Sm3LLQfikxOZyl/VfDUVyjF1dmMpdoTuKmgN+jsBbx1pjDxLM
	lFWbGXlUBIGf0eKDKG8Umv3g5xXHInZaWcuz2ychPBVrrwOMg4CIYb+5Dc3sV0AO4Qf54gAo3nE
	p4JKV1T9k+krqtQjHgwhGP+/lLgUy5j2YNUrEfN9bZZRDw5uq8R6MCKq75lj6w8L0Hrw6xR5kCz
	EfPmv5IIyiL1AheESqtX7fvDLwhRR/E+CGgg9Jvd8J6qslzaZLAu5sFcw7AQZLEE4/U9djtQTOZ
	+J66OKJrJkc1unj71Qmfm5wrjEWbxqUrE+l5hJqQVfVaXH10UpwMlVdoCHg==
X-Received: by 2002:a05:622a:392:b0:530:18a:9358 with SMTP id
 d75a77b69052e-53036cc8da2mr9039681cf.26.1788307732357; Tue, 01 Sep 2026
 17:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
In-Reply-To: <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 02:08:40 +0200
X-Gm-Features: AcwNN1UUBe9iXZAqtGBWEmxc9KX33sNRlslLynVKaDAeXwN0HhCbP7KKBTpIbj4
Message-ID: <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> > TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
> > [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> > restoring the small-quantum deficit spin that the init clamp prevents.
> >
> > Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> > parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> > fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
> >
> > Conditions to recreate the bug:
> >   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> >   unshare -Urn suffices).
> >
> >   tc qdisc add dev dummy0 root fq
> >   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log=
 15 cell_log 0
> >
> > Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and=
 initial quantum")
> > Reported-by: Vega <vega@nebusec.ai>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 6144b5686f13..35f940b2205d 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> >  }
> >
> >  static const struct netlink_range_validation iq_range =3D {
> > -       .max =3D INT_MAX,
> > +       .max =3D 1 << 20,
> >  };
> >
> >  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> > @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct =
nlattr *opt,
> >                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
> >
> >         if (tb[TCA_FQ_QUANTUM]) {
> > -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> > +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUAN=
TUM]),
> > +                                    256, 1 << 20);
> >
> > -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> > -                       WRITE_ONCE(q->quantum, quantum);
> > -               } else {
> > -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
> > -                       err =3D -EINVAL;
> > -               }
> > +               WRITE_ONCE(q->quantum, quantum);
> >         }
> >
> >         if (tb[TCA_FQ_INITIAL_QUANTUM])
> > @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >         sch->limit              =3D 10000;
> >         q->flow_plimit          =3D 100;
> >         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20)=
;
> >         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> >         q->flow_max_rate        =3D ~0UL;
> > --
> > 2.43.0
> >
>
> If we consider dev->mtu admissible values, which are in [0, INT_MAX],
> we have to guard against u32 overflows
> for 2*mtu and 10*mtu expressions.
>
> Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
> and initial quantum") missed this?
>
> Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
> and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)

Wait, I missed the
mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);

Not clear why we have so many clamp_t(), this is quite confusing.

We could instead:

mtu =3D psched_mtu(qdisc_dev(sch));
q->quantum =3D clamp_t(u64, 2ULL * mtu, 256, 1ULL << 20);
q->initial_quantum =3D min_t(u64, 10ULL * mtu, 1ULL << 20);
