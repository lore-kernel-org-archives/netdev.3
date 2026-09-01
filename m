Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C7242D67
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306746; cv=pass; b=RCumf8IcfCE1iDNdqJ9damcMAn4iLIJXaqvOtpOehzjY1a3y6TmFGhfPnE5Y2jldpxwupsF61btGF7axdNbQPGnU1POY9k+vd4hK/5i42at4J/YlYEV+LKuqtCztjx27psUMu100usmjd0ZoS7l4kC367IwWRM1akygCNoDlCaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306746; c=relaxed/simple;
	bh=iivTn96FfbbEjJViX0Fkcm09I9MH/O28qfnyMTTliJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5WQEiytSxDjLTHHde/FrBVyHU/Ihet/+a5g7YSZJrmIMJ/XfJeXQzS8wPBtTS/7J5W5kNGSJeIsEm2bLEVReVBMuuE1RoSQ1x9LnlFuQ8wm0aQMHZ3FKEUb47pvKsdA9pbB3cZzYcM4asQ6LhGJKAsK3YpJCtZ9MR+6+bIhMd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n50fftXl; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n50fftXl"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52f9e79ed93so4107831cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788306744; cv=none;
        d=google.com; s=arc-20260327;
        b=g2TdXTLrr6dtgz7vyTJEwT+IytmY0NTiiulWkbxm3z4n8tHDu2d9SQQ8lLo2nFxeeD
         05AuvnXhIRS+5HwCLt9NOhM2N0AXik+jg8kCUBwFQMQNUQm/w5tE7X3UfU8/DL4xE/c4
         1d9oTfYmZ+ngMyB4+nzP+PBMYSAgTJ97cYy9kGiKWjRI3dvUcb49Dgf20uLRjrLFVtjy
         GVWFnj5P132DpxiqvqVLj5M39BA/HA3PbRWbClbc0e3Jl+7uyapX0+HPgQMe5YIjU9lf
         tjOJQrju6iopg1bTvExiAu6fDD4Br0uV218ojZhu5wwljPQP/zGrJDnc1+3/PXDlKBw0
         cuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        fh=AukeYB0QOsqywlJ4iWkAnO6L+/H3Jo4TSzBag9fEpZM=;
        b=j+t7KaboVH9vPXKq0CQe9ddCE9dk5MSyDYoJU1qqPdllyX8Vx5ZTT3euTI2oR78ujg
         BaGNJSnTkWNv+X66HEbjdaJ+qzF1Z5i4PwUU/OFFCD6NkQmESXaOKctyCbczTI4LWXNT
         mS1/6g6vtPDsu2z46eG0vithjg5fZaxH2lHL+Vabl7jH7IupyYgDnieetFxahacXlFQX
         JiNN9RDgq0dxszjrV+L9Lp46R8Ivxvgb5DrdU+eZOzGUK+W4KVYlvxC6Ry1NEaYaVR+1
         HPsLMxPslDvTMTxjRVSTuod+r0EqhjfsrkmHfEg9C0B2dxPBQWJRwKXF3B+k6RWkIjPY
         +/Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788306744; x=1788911544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        b=n50fftXlgSjrKPpXQ96AEiE7vDlJ5HjQjwWDdUrTb6KOV1AXxkM/CdNZTDX3xHWJfh
         oPrUw+oWA8bT7lfIRV87suaERqya7qKxVDp6mE/1tCbx2fVIInq40IJQ3HZWguhmC5/5
         O3MGZQzXv2BONjARRhXipzdaVvRuTiQfyvwBTuZ+8cGmUIPcfgrFq3x2Th8bB0qSbDzW
         rgiPtwA5CT2ixCknmhx2ogpkdQtEgXaw3UVlGPhNbWwZRoGsd1C4WimIiLTUGYZW/2k6
         S94QAP/C8JnP4Lpm67yIOt/iQywgq8Kxz42j3xAmkhYfb9MJXgM7Oa844GOvUsQtenbX
         GVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788306744; x=1788911544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        b=KtYoDDbCTYKo8X0JBTsyu/WEE8inZTGzWvmAx41WL51tdDricnVTCWSQBgmONTdrow
         FwuvzshVCOiCp/iXY/EQkRZieJ36EtE34xB0AOVSr028e8/appxKQXNPiTR6Qp1XDBYx
         k79x0eaZjUXVbJo7HwcSqswOz4DjGfLJYl8EmarwbEyOlI2Ww2CbwqpiJ6cT/GmcwN/t
         W1XY7wR8EQ8dbRjBr74lcDLy2NqGeWQJ9WN/sPj8+jWUvHbwvUTSTyY3UW1J/fdPbUuu
         kRerI4VeC6ZJodvzW+77+JzAoUygE/wpijj8JxflDQpv38vgiHfYN+JfQBUB3p9fGBIt
         pJWA==
X-Gm-Message-State: AFuF++kMSgNtcGJtQzMKtCX1OnlgPvJnFxrgi2RdHMz6gaUUleO0ZAJ5
	gEQHIg37BJG5Q0Sdi/iTkZy0GDFR2O+zj7hPy69auwy8yJxOE/f209uAE/C0Daxs/2h3WkOzhxX
	5n+2zyG2OygOP8YoEfEJBe4LkFm0MIH/LBgnd3JTb
X-Gm-Gg: AR+sD125w1CxkB94XJvJ3OUjXPd2gi2Z90hn9zpNgy5rEx7hjVDZW4seIfurKVSvL4d
	3biMJGHbAb18wN5wPm92c94dgUcyWKz++ZEumM1bA4KHJ7KL1i5/rOpjD8wyp8RHcQ1qrPcKOqW
	ikD6n4eMSHLPCX435RkE4wyaRIKjvGsn/X7uYWDDzizsRvem1U5dEe6/qgnXIRFe2wqKmvlUdd+
	YlfqvNPgyNHlmixFQHIEv5+8fv0ovYgwFLnIUSExedCEN47TpisO0Ry/isztIPB+6oC87eWkz6K
	p7IOqaGotjhLIPkJcsiiBOtKeJik8lgQ7xBFxhEC0cDDIpnjbaXzbYGsKuHCVRPZpF6axMS8vQ1
	vvk140mT4AZMS5fi6ZZoEI/WetvSv4luHmOWunoVVkFvC4FEkVldMhS2XgA==
X-Received: by 2002:a05:622a:2443:b0:530:3542:c8ad with SMTP id
 d75a77b69052e-53036d271e0mr9187581cf.36.1788306743315; Tue, 01 Sep 2026
 16:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 01:52:11 +0200
X-Gm-Features: AcwNN1VpocPgjLbdeztjV8K8wARcLU0eMSx0w00rUl7qFiBL4oi3faAyjqbm9UU
Message-ID: <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
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

On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
> [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> restoring the small-quantum deficit spin that the init clamp prevents.
>
> Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
>
> Conditions to recreate the bug:
>   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
>   unshare -Urn suffices).
>
>   tc qdisc add dev dummy0 root fq
>   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log 1=
5 cell_log 0
>
> Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and i=
nitial quantum")
> Reported-by: Vega <vega@nebusec.ai>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 6144b5686f13..35f940b2205d 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
>  }
>
>  static const struct netlink_range_validation iq_range =3D {
> -       .max =3D INT_MAX,
> +       .max =3D 1 << 20,
>  };
>
>  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct nl=
attr *opt,
>                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
>
>         if (tb[TCA_FQ_QUANTUM]) {
> -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUANTU=
M]),
> +                                    256, 1 << 20);
>
> -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> -                       WRITE_ONCE(q->quantum, quantum);
> -               } else {
> -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
> -                       err =3D -EINVAL;
> -               }
> +               WRITE_ONCE(q->quantum, quantum);
>         }
>
>         if (tb[TCA_FQ_INITIAL_QUANTUM])
> @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
>         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
>         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>         q->flow_refill_delay    =3D msecs_to_jiffies(40);
>         q->flow_max_rate        =3D ~0UL;
> --
> 2.43.0
>

If we consider dev->mtu admissible values, which are in [0, INT_MAX],
we have to guard against u32 overflows
for 2*mtu and 10*mtu expressions.

Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
and initial quantum") missed this?

Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)
