Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6C3ECBCF
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548472; cv=pass; b=RMoIkhd33OGHEZpUChIY9kSpa8n3oNYfzg8ep8KolAusIcHaa+jtgoQoojaEtNASF8oWzmcdNGaHncdHZRmAoIHo5KYSyGFcDSSdBE6XgUFb0KPhXC6704Ep6pnq4fIcYLAbgfLNPrrx970od+vP+HwJDLpYgFQCTRysCbZGrOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548472; c=relaxed/simple;
	bh=2OV53qj+Ok3sZRi1Cu45I3HwF6So2E+y40itVWLrldU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exyku85jcwetR+UdgXVWh5PMMMVYFY3EvbDnBGCriVQskx6EJ8zrPwBfNpFZEKS7NSukC/4bFsMMGYR0cAisM8eqyU9wmPEHXFv8FAxVh2jTAZSh88b6mpDZAroxvrZE7fwT9f5QN5c3GxvZ4Lfdgk1L26sSZso/MrXLQZgHTZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mQyeiOk5; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mQyeiOk5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84eb992a881so935837b3a.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788548443; cv=none;
        d=google.com; s=arc-20260327;
        b=Rj8U/vX9i0u+2bbdebAfmzHeBkauTO53DVrl3h3bbo0t5Zfig16kfj2Q5UKad42hTp
         3xPldsaoX3lu209y337hpHeVsBO01/KF/5HjQChrAc3zLCOQsgHpfmF3MfgHuFVOeO6S
         SnJofK6yqJus91kYmPMq1bREoiLUFP3f1Ee3dKUJiG3Bv47YbtfZItM9p96sV2R9ipof
         +ElPMvoCzazRaiJ0zIDtQ5xhZM08Drlrg1+CEzfKh25Pi7L78ryz+FGiUzp5elCQRqcR
         LHJXB19lnp4YiR9XQR36nPSWQcw8V6LfVlTxqFANOqGeyZXJFNxvi0fVEKZ8uNyhxCtI
         53XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xEH5wC1CsIXf1Wl3c1bH+jg+ggyRXswm+rvfZnXVjBs=;
        fh=aH7unqQfjsgTIXSweCBi0reLtRrkOGHxIK9w+YdQl7g=;
        b=KQkIg2pACaipjhqztEJc/mfNk2QEp9zB40Uu1ynybJOd3mfPwSzXocCoUay8GbVyrW
         vipbEQvYpFyeZpJb8dIVGFicBw+9pi3cPYvdzhJy1IZahrjwJBMOf5wmLvjIZaFreggF
         Qp9HYOsoY1hyTxfEs8sYnsNpvOnOChodXmyiozY8r6Y252VYO+UV5jPfJILjiiqhC7Ze
         R2aVHa4q0YdOGrPLlC0xFZIoNvF2a+S1a00/xJ0bU2lwCrx9ltOoUU29LS00HjIU+UbY
         qf2Y/bjQKGEXLsv0qfupO8AkqEgrWoBgThPRNps0Zax1eIqN0y5LApkVoj8BV3FoQ+Hs
         LZOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788548443; x=1789153243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xEH5wC1CsIXf1Wl3c1bH+jg+ggyRXswm+rvfZnXVjBs=;
        b=mQyeiOk5dJSJbhy+c1J3+B/BEKcezVsTv279dr09o8QAGCVCc9fD1yOW+3og2RwHHS
         MWGmIymyD2bDFyTIp/aVRoKunCcNCurepyamnhDwPGDoKEIfxi6hqSQA2viK/JDdktEQ
         6pGdI5Suo+G8hSnTngq481dS+c2IiYm8xCYOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548443; x=1789153243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEH5wC1CsIXf1Wl3c1bH+jg+ggyRXswm+rvfZnXVjBs=;
        b=XItceh9VGXzxZBvFRSy1Uv682c5OFBbQWbJuJgz1OVgi1Rg6bgBUI9EBb+RIbL6CYM
         EgUjH2GqCmSMi4CgmwRdaN6BcdiomxlOkG4fldxq8MKqE1YVTnBfRIqYvN98TQ3vGpEs
         8xOhC90G1AFrVlwJ+2cfaWwmH7d8lYKV6oo1yCVuMEQOq2Haz+1Q8eMUkiZabIxwKJ+T
         /4ExOVyxQvVrj5I+nFPL7dIaqVXQwEOxYiOt5455agv+GdzDnjkaSRN5fzAhXR6zjWJ+
         EQXYHfyVVAq1J3f0ycRm/agAZ0isVQk7DQEQ42hF1TPuiD9sbS10m6e1Ed0zVMj8slQg
         Y/iA==
X-Gm-Message-State: AFuF++ni8Wpnlnq0sQAuBQF9mFWD9vTnf08QP+Ulq5lqsWJ9Wh0AYXq4
	MXFG0XGy45TgY8QlOG6+W3omoIGvwwaCwi4U22LQrteTBF/8XlM+iy07HsSlCH0UzChXUdo411G
	gqc3A+KzD/ftkQ6m5xeAipYU4GY6AGiByqEVUkCGc
X-Gm-Gg: AYBFou0/dpJi8wqCgwCJB/TZipYQjobLbEltVDUVAwFCrSPwiN4NaIY1inBhWZnUxyj
	EBh99n9oyAw2Q8ayxcXhKOJn02I0jaHtUZ8yPeUnlE9XP72lJ1ElErwpDcdR9or79mnAPxYxIjf
	qOynw8yafYHQX83Tq0hFgwLNA8mAO886I3O3+oswk69BInBhkjfCAsbQqScKmHI0Oks7DIoLjwt
	YWXRXZKLrWU2brCNphdhB6ggxTXgz72B1ToNSsM0Hi2LjDxLeuAEJE5++1l+R3MXrYTMxadVC9s
	QHYsqfskrzykUIn9RzGjIP95Y/xRpWmYJMsAzhdOY4c5DkAFpNjBfj8vvl+1yHH39/QR7roHpYE
	3zZLuMpAN4bAWVPDBdiB5eTs=
X-Received: by 2002:a05:6a00:4388:b0:857:7317:cff2 with SMTP id
 d2e1a72fcca58-8616a266f1bmr11528797b3a.19.1788548442716; Fri, 04 Sep 2026
 12:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com.5> <178851496497.4131868.4506740406009637307@kernel.org>
In-Reply-To: <178851496497.4131868.4506740406009637307@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 4 Sep 2026 15:00:31 -0400
X-Gm-Features: AcwNN1VDa4Ghdswb8Xi7BvlaZaZEQXVw6g3GygKdaBdnklKemsWZICSvEGXwP_Y
Message-ID: <CAM0EoM=soN+QzH7ZFW5th8ZC-53Kh7f178QK6ooZ-Su7re74rg@mail.gmail.com>
Subject: Re: [PATCH net v3 4/9] net/sched: hhf: clamp quantum in change and
 init paths
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, vega@nebusec.ai, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> - [Medium] The changelog's justification is stale on the tree this patch
>   applies to.
>
> Pre-existing issues:
> - [Medium] A TCA_HHF_HH_FLOWS_LIMIT value supplied at qdisc creation time
>   is silently discarded.
>
> --
>

1. [Medium] "~2 GiB / 2^31 figure stale"

Valid. Good catch on the backport angle.
Post-8f735d64382d the stab-inflated pkt_len is capped at 1 MiB, so the
hhf_dequeue() refill loop is bounded to ~2^20/quantum iterations,
_not_ 2^31. The changelog should describe the post-cap bound and note
8f735d64382d as the commit that closes the soft-lockup case. Stable
patches are going to include  8f735d64382d so we are good.
Documentation on the clamp itself is still correct defense-in-depth
for the mtu=3D0 case it also fixes.

2. [Medium, pre-existing] "TCA_HHF_HH_FLOWS_LIMIT at creation is
silently discarded"
Already tracked by our internal tracker as  bug QDISC-B855. It covers
the hhf flows-limit family; this specific create-path discard is noted
there as part of that fix's scope.

Summary: No code change requested for this patch.


cheers,
jamal
> net/sched: hhf: clamp quantum in change and init paths
>
> This adds a 256 byte floor to the quantum accepted from userspace in
> hhf_change(), clamps the quantum derived from the device MTU in hhf_init(=
)
> to [256, 1<<20], and drops the old overflow fallback that set quantum to
> 256.
>
> Two questions below, one about the changelog and one about a pre-existing
> detail in hhf_init().
>
> >     hhf_change() accepts any quantum from userspace, including 1. With =
a
> >     crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=3D1 mak=
es
> >     the deficit-refill loop spin ~2^31 times under the qdisc lock
> >     (a soft lockup / denial of service).
> >     ...
> >       tc qdisc add dev dummy0 root hhf
> >       tc qdisc change dev dummy0 root hhf quantum 1 stab data 32768 siz=
e_log 15 cell_log 0
> >
> >     Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdis=
c")
>
> [Severity: Medium]
> Is the ~2 GiB / ~2^31 figure still accurate on this tree?
>
> __qdisc_calculate_pkt_len() in net/sched/sch_api.c already ends with:
>
>         /* A size table can inflate qdisc_pkt_len() beyond any real packe=
t
>          * (via overhead, the data table, or size_log); cap it so deficit
>          * schedulers such as DRR/ETS terminate their refill loops.
>          */
>         pkt_len =3D clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
>
> with QDISC_PKT_LEN_MAX defined as (1 << 20) in include/net/pkt_sched.h.
> That cap is present in the baseline, added by 8f735d64382d ("net/sched:
> bound qdisc_pkt_len to prevent qdisc soft lockup").
>
> With that clamp, the quoted reproducer (32768 << 15, i.e. 2^30) yields a
> pkt_len of 2^20, so the refill loop in hhf_dequeue():
>
>                 if (bucket->deficit <=3D 0) {
>                         int weight =3D (bucket - q->buckets =3D=3D WDRR_B=
UCKET_FOR_HH) ?
>                                       1 : q->hhf_non_hh_weight;
>
>                         bucket->deficit +=3D weight * q->quantum;
>
> is bounded to roughly 2^20 iterations with quantum=3D1, not 2^31. The
> changelog of 8f735d64382d itself describes 1M iterations as completing in
> a few milliseconds.
>
> Could the changelog be reworded so it describes the bound that actually
> applies here, and mention 8f735d64382d as the commit that closes the
> soft-lockup case? Without that dependency noted, a stable backport of thi=
s
> patch alone onto a tree lacking the pkt_len cap still leaves roughly
> 2 GiB / 256 refill iterations under the qdisc lock.
>
> > diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> > index 96acab6a8da03..fc72f825fbd92 100644
> > --- a/net/sched/sch_hhf.c
> > +++ b/net/sched/sch_hhf.c
> > @@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nla=
ttr *opt,
> >               return err;
> >
> >       if (tb[TCA_HHF_QUANTUM])
> > -             new_quantum =3D nla_get_u32(tb[TCA_HHF_QUANTUM]);
> > +             new_quantum =3D max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]=
));
> >
> >       if (tb[TCA_HHF_NON_HH_WEIGHT])
> >               new_hhf_non_hh_weight =3D nla_get_u32(tb[TCA_HHF_NON_HH_W=
EIGHT]);
>
> [ ... ]
>
> > @@ -624,10 +624,6 @@ static int hhf_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >       q->hhf_evict_timeout =3D HZ;      /* 1  sec */
> >       q->hhf_non_hh_weight =3D 2;
> >
> > -     if ((int)q->quantum <=3D 0 ||
> > -         (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
> > -             q->quantum =3D 256;
> > -
> >       if (opt) {
> >               int err =3D hhf_change(sch, opt, extack);
> >
>
> [Severity: Medium]
> This is a pre-existing issue and not something this patch introduces, but
> while looking at the ordering in hhf_init() around this hhf_change() call=
:
> is a TCA_HHF_HH_FLOWS_LIMIT value passed at creation time dropped?
>
> hhf_change() stores it:
>
>         if (tb[TCA_HHF_HH_FLOWS_LIMIT])
>                 WRITE_ONCE(q->hh_flows_limit,
>                            nla_get_u32(tb[TCA_HHF_HH_FLOWS_LIMIT]));
>
> but on a fresh qdisc q->hh_flows is NULL, so hhf_init() then enters the
> allocation branch which overwrites the same field:
>
>                 /* Cap max active HHs at twice len of hh_flows table. */
>                 q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
>
> So tc qdisc add dev X root hhf hh_limit N appears to be ignored, while th=
e
> same option via tc qdisc change on an already initialised qdisc takes
> effect. That field gates admission in hhf_get_flow():
>
>         if (q->hh_flows_current_cnt >=3D q->hh_flows_limit) {
>
> Would it make sense to only apply the default when the attribute was not
> supplied?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-0CFC.v3.20260901204856%40mojatatu.com
