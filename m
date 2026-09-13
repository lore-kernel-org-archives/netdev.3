Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24484367F59
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295668; cv=pass; b=McGrBfct+pqZR80iXaj5jiC+bNbgPaK7oT/J4OwaXmfY9B24tH1x4D4Sp+JkMrmQaN70n/KGuRDnTpn1CexVB2G8MrFpiA8qtBLa6fd+WDjPDgTBgeZw1u5EsML4JGILM/jub82p06lfZc5/bjH/ZUJt4fyf69HV7cms4FLjTz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295668; c=relaxed/simple;
	bh=90LY6em8mxd7T98jUzeconjVDsBxDyoaeIzD3QrmZeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjlPxdt3/G1DoTr1jNxjby5mMqBpeIuLw5p9q+JcaAP91b/Iqtx0DSKkd95qAA4eT3XhNToIovGKhrLOBHaUVVrnBt1Z5V8MyRZdimjsEg4oU+PngeTL/MW1UKCLnBNs01yHf7cUe39ujCCCjDFbj5Kq11V8ZMDn1aSgv0RyvrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PTIauC02; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PTIauC02"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-869ac301739so1900379b3a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789295666; cv=none;
        d=google.com; s=arc-20260327;
        b=FQoHgH0qc4beiwjp5QbfXctD/qT/1tZSZ+4aCWQPugApJk2zJvPMy74enFeQTOLw9A
         PnpfFJfoESbKrf+6xeVQ0EUxEZ0dmohlbY8FMLAz50OU9LMZnl/WuG+Oes9CA2bev9dk
         THDkVpHU8XL12zYzwl5lFVPnBRHhURl+sa+I7SMkZU86dPYTlEFar5SrYe258B2Wafc2
         4WQMbYdlYggxp3XIBmsXXkSRmHxT9j6RuJU+5HMqtozFj+oy5pDGFr9LdtWI8y7uHG+D
         DFE8DfSOoE9RQSRl7YLnjAheoKOXDO6U/ybaz638ZbIyW4+Kmr3em8Lx5RmXAFo56psD
         gEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        fh=vCHoBfwFCJWyl68FVWUTf1rfILilEOtl/9VhL0ntufQ=;
        b=lpz7LDwbGWYC78D3GEf5Vf5tW5ppO6xifmTBlEtDK8mI/9H9WleNnRII9xjZGQX7sG
         W/CpLG8hXSqjuYqrLb1PVdwgK/Ylis6eSGDgxo1K+NFtkSGEfbC5p8R5KseZ4/N63Z4y
         VVidYTDvV6rWUjwLbWVmiyM13hej958G2fJvNxTQrJBntKM9UpJF7y+5heLH6ecrjpzx
         XwkNfZYEM5D8mjxaS53PtuzosMFPfp5xLu4mmyxjp5yf9JVPy33jK19LXbX1BiGh/YJP
         ZCij6vn4p4Mmc9g4htzXkD9rG1go1nv/kbKwGese8YXXpC5D41won/bola24Ofk696zq
         diNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789295666; x=1789900466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        b=PTIauC02R/nYTdyFnYOs1fwy3LchQ0MIE8VVlc+TkimK+bPTS/3NNeTo7bUOSQULy3
         /aJwC+fSetNtuiLYRCmwbGUK8HKE9XucZJpV5FRCZ/9QxnUIIXk8C8exkt806SpSKNLi
         sEQG55TVzJEZZJoxsOmcmejI7shGS10kK4S7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295666; x=1789900466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        b=JEXS3bGgMlsdTAL1ujGTbaBLINzad6+oJp2SG+hs48Cxw+pjgPdRsuRvSa6N+fBn7o
         Ic0z0XmkaeXn3cEzTXlNEkDHycnK6goF/6GSg4wyFn6NMs/KSRfE92i5/tgLZEUUSLW7
         +Ovs5VqahYUwlFfpX0hXM6VEUVAfYHK4KoKBs5Ctwxa3LMQIAYJnh+uB08doG8KCJSEa
         8NGSe0Eojs+8hP9MLW01UIhgSRuryg1XGsZSNTnd5/nsH2P6Eq5/nvrojWn/QJpjIMsI
         7yQIUJNkWb8y4xB5b5bcnSHbYkvsjdeA6KVNjqhzMo1PmSPHn0PGaF6YJGpSc5t4MZss
         msHQ==
X-Gm-Message-State: AFuF++mhw1h607In0iPGYusw9oRpsPOxrVyHV0O9B91UiOJmDEMsPezd
	dz/+Wh3GT0hhdlJuEdNu7ZKxz+3O/7lEZ+RUdnNlS08Q1nEKMLOSZ4A8LL05dQdKat0cu93QR9C
	5CZaBPYQtolyolsSB0vvv3oDTBMPk4manqWkINkMZ
X-Gm-Gg: AYBFou2Mrn/OYPObk9Z8qv86Vwh9ORKS7OscOKpKDBL+6Vpxv/tc82WV7fJZrf5v/YT
	DjIcmnh7sFh023gZQDXS+5RDFMv3z1KVxyU2S07HQIF67t51pr5nbvlkzmNwg5OAE/QajecmGxx
	LaNNpge1rtq8s14ie06ozSdUOsoxBlyXHq3PxWb+tfoyh2GvZumWThO7w7jEodY0MPseqvit7bA
	az/qRbYAN5SgK6sGvoM64DgU4DoeEazrOcK6XXDYZenjlWmDnclqzDGFewqLCOBjwaXtYgBn5Y0
	SXsS2EA9v64I3YsNzEXbApqvJal8wU02OuvmdLsAK3CUAO9Npeo9emldSvwc7mC6lgYyiRO89uv
	WaCCRtlnZHaYPdIUarEvZxsq1FLxB9KmKpQ==
X-Received: by 2002:a05:6a00:4c8b:b0:857:727c:a1f6 with SMTP id
 d2e1a72fcca58-86b3170e7c1mr21035206b3a.24.1789295666372; Sun, 13 Sep 2026
 03:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-B855.v1.20260911153152@mojatatu.com> <178924538361.3125.3706649335976216385@kernel.org>
In-Reply-To: <178924538361.3125.3706649335976216385@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 06:34:15 -0400
X-Gm-Features: AcwNN1UveGyXAGuMha_8k13f3akcEPJa49LaNvbOPV8S_M52ewBaXYsyzNBRaao
Message-ID: <CAM0EoMkMCM92WBrt7v+2Ov2xSGGAqen-YTZj4irJzNcArrQjDA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vtlam@google.com, stable@vger.kernel.org, victor@mojatatu.com, 
	hybris@mojatatu.ai, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 4:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] net/sched/sch_hhf.c: the new `[TCA_HHF_HH_FLOWS_LIMIT] =3D
>   NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT)` policy entry (line 530) is=
=E2=80=A6
>

These findings by sashiko-nipa are accurate but as in the previous
codel thread they concern changelog and selftest-robustness nits.
IOW, there is _no code defect_. The -ERANGE behavior change on add
path and the changelog overstatement are worth a one-line fix if/when
the thread is re-rev'd, but IMO are not a revision blocker


cheers,
jamal

> --
>
> net/sched: hhf: cap hh_flows_limit at change time
>
> The patch bounds TCA_HHF_HH_FLOWS_LIMIT with NLA_POLICY_MAX() at
> 2*HH_FLOWS_CNT, passes extack down to the nested parse so the rejected
> value is reported, and moves the hh_flows_limit default in hhf_init()
> ahead of the hhf_change() call so a user-supplied value at add time is no
> longer overwritten.
>
> Closes: https://sashiko.dev/#/patchset/20260822195509.112717-1-jhs@mojata=
tu.com
>
> > diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> > index fc72f825fbd92..5dec1ed969adf 100644
> > --- a/net/sched/sch_hhf.c
> > +++ b/net/sched/sch_hhf.c
> > @@ -527,7 +527,7 @@ static void hhf_destroy(struct Qdisc *sch)
> >  static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] =3D {
> >       [TCA_HHF_BACKLOG_LIMIT]  =3D { .type =3D NLA_U32 },
> >       [TCA_HHF_QUANTUM]        =3D { .type =3D NLA_U32 },
> > -     [TCA_HHF_HH_FLOWS_LIMIT] =3D { .type =3D NLA_U32 },
> > +     [TCA_HHF_HH_FLOWS_LIMIT] =3D NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS=
_CNT),
>
> [Severity: Medium]
> Does this policy entry also change the behaviour of the qdisc creation
> path?  The subject says "cap hh_flows_limit at change time", but hhf_init=
()
> calls hhf_change(), so the same policy is applied on add.
>
> validate_nla() dispatches the max check from the pt->validation_type
> switch, independently of the validation level:
>
> lib/nlattr.c:validate_nla() {
>         ...
>         case NLA_VALIDATE_MAX:
>                 err =3D nla_validate_int_range(pt, nla, extack, validate)=
;
>                 if (err)
>                         return err;
>         ...
> }
>
> so even the NL_VALIDATE_LIBERAL level used by
> nla_parse_nested_deprecated() returns -ERANGE, and hhf_init() propagates
> it:
>
>         if (opt) {
>                 int err =3D hhf_change(sch, opt, extack);
>
>                 if (err)
>                         return err;
>         }
>
> At baseline, tc qdisc add dev X root hhf hh_limit 4294967295 returned
> success, because hhf_init() unconditionally reassigned the safe default
> after hhf_change():
>
>         if (!q->hh_flows) {
>                 ...
>                 /* Cap max active HHs at twice len of hh_flows table. */
>                 q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
>
> With this change the same command fails with -ERANGE and no qdisc is
> installed.  Is that intended for a Cc: stable patch, and should it be
> mentioned in the changelog?
>
> The commit message says:
>
>     Configs relying on hh_limit above the default were relying
>     on unbounded, unsafe behaviour and are not supported going forward.
>
> Is that accurate for the add path?  A setup doing tc qdisc add ... hh_lim=
it
> <value above 2048> was running with hh_flows_limit clobbered to 2048, so =
it
> was not exposed to the unbounded allocation behaviour described earlier i=
n
> the changelog; only tc qdisc change could reach that state.
>
> The sibling knob in the same function is clamped rather than rejected, fr=
om
> the referenced eb56a495f59b:
>
>         if (tb[TCA_HHF_QUANTUM])
>                 new_quantum =3D max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]=
));
>
> Would a min() on hh_flows_limit in hhf_change() give the same memory boun=
d
> without turning previously-successful add commands into failures?  If
> rejection is preferred, could the changelog state that the add path now
> returns -ERANGE for values above 2*HH_FLOWS_CNT?
>
> > @@ -546,7 +546,7 @@ static int hhf_change(struct Qdisc *sch, struct nla=
ttr *opt,
> >       u32 new_hhf_non_hh_weight =3D q->hhf_non_hh_weight;
> >
> >       err =3D nla_parse_nested_deprecated(tb, TCA_HHF_MAX, opt, hhf_pol=
icy,
> > -                                       NULL);
> > +                                       extack);
> >       if (err < 0)
> >               return err;
> >
> > @@ -624,6 +624,9 @@ static int hhf_init(struct Qdisc *sch, struct nlatt=
r *opt,
> >       q->hhf_evict_timeout =3D HZ;      /* 1  sec */
> >       q->hhf_non_hh_weight =3D 2;
> >
> > +     /* Cap max active HHs at twice len of hh_flows table. */
> > +     q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
> > +
> >       if (opt) {
> >               int err =3D hhf_change(sch, opt, extack);
> >
> > @@ -639,8 +642,6 @@ static int hhf_init(struct Qdisc *sch, struct nlatt=
r *opt,
> >               for (i =3D 0; i < HH_FLOWS_CNT; i++)
> >                       INIT_LIST_HEAD(&q->hh_flows[i]);
> >
> > -             /* Cap max active HHs at twice len of hh_flows table. */
> > -             q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
> >               q->hh_flows_overlimit =3D 0;
> >               q->hh_flows_total_cnt =3D 0;
> >               q->hh_flows_current_cnt =3D 0;
>
> Moving the default ahead of hhf_change() is what makes the add-time value
> effective for the first time, so this hunk and the policy hunk together
> produce the new add-path failure described above.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-B855.v1.20260911153152%40mojatatu.com
