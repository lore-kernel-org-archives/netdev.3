Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE23B71DA
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152745; cv=pass; b=ME+8Zw7EOxkN7FRExFUcesMGRB0TbhdQ71wlmlb7gkhAQmN13QHNsroxm7rLKVX0axgjZ0OHrKXH3F1S85GlH6JR4hPfJFwG1KBkUZpRJJTxaKX4JNG9Jfy6efFV6Qi48pvHsBPx7xHWURZ03mqFOsgnICEoebWyzXiFLbR8ZG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152745; c=relaxed/simple;
	bh=blVezLDhljCWNms4wfl8toeqxZquOtNbO8dPQ06Uf1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiWmUpVB5Gvg2zgWfNdyLow+kfv9YAhFz0pSOEtMhpVVrBI/RMo4snPrDR8wxZQEOuFUyRUy612tPLiDKJyOfQ2v3Z8UZcFv3tJSoae1kDocy/ooKAdV576P+GLjrcn/bPVmLuuxPWHEjZR6tbCD74yV4qGdV0GUpcIrDiD/3Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2BhBBfe; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2BhBBfe"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-934944f2d22so82267785a.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152742; cv=none;
        d=google.com; s=arc-20260327;
        b=gcpsknon7bWTL2BjQ54EyJ+RAdM3gYttA1jkrA4EPa0oy7TzkgV1JDLGt5e/w7Kj59
         xillRF7cIIYOGZyEBhsBDe+2EibFgLGKQfwJxX8mcn2uiF5iqvxB8SL3zUBRTuaAGjc6
         PCfWrfOeWQZGbn9u0XGlcZduV0pydfB1M1fjSmo/RICTm/vLmkK2qwFGWVibfXfzIiyp
         CYp8jCTyJSGhBHLOOrdCM+KUD42QnXsNnMeF6ipUkxeqXEX+Ebe7Vo26X16TgyiWlAxX
         Rxr8IWkRZqAd08/FsUo9fpgOtXYbfyO9NioUq/nDdI2U6cvz9DQsnqJ9DHmeRpIn9VHR
         wgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=Fpxn1GpKuvF1wlNlO3t1P3EWMif/yIeMoJ9Ua5YlMv0twQTvIyZ/Av/IGJzrUdJwul
         K9j23xK2ctomDYT+Nfxn60ohQCfx87d74/zko8ycSGmEM7KJMq50aDQ34oN8kiOFzJso
         9vGj+A2jtW3wqaIENIdA1Zc6/1XxKhyvczerkMbZ9wwl8g88s3wU33z55LAhPrfRG1Qb
         Qny80GBY6iJUAYQZVOj88MsCcdZZ2wMsCYLAokK6yXhUQklEJioyOSjKVe2fAoI1ASIL
         HEdcKqrjbHc+QCmR75nBe/9MAv2PiAwZvc5gLD8UfoGtaxRmCkqWYQaZCic3irfB81Km
         Plcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787152742; x=1787757542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        b=S2BhBBfenfnAGT3tMrAjMQsTCwv+cn5p8vqCiRVYaZ5jOD4D3BbZ/vH7uqTQ/MLIAb
         KTa4f9QV8wlxR9RtF6xFKM9CzzEOfF3sUB0IHrrhIBuCYOqshkQHUo5XfWCBpv0e+gYZ
         ObrNmzqzm2Sfv/+sdxZd/YsHXKLtcdMwSMYNTeRhDxo6ERLIq2r+7a40a3VpLlevjIwI
         LqecXVjrDmCI5EmaezfzXCgGSeNdEd2vURUfrzmNIrSS7ZK6mRnP3mPcYV6a/NtshRSe
         fGpMGaBk53LEHw+k3wcBGLVDvRgNbLabfgYf0vUUDZSz49GSd6B1e4m6Dz/MfAyRKJRG
         tmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152742; x=1787757542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        b=iZgedLHg6wZLknEvz9+whCYDqRmssyYNZJVRTuMObmmFrFx6ssrSPAZzVK18th/Em3
         2EQw487Se2uDhwZvaVIpfp9GSWXZ3mAfNngcrbvA3VX4Z5bLskKnYdGZBdXlxBoc2qPP
         YY4QREm2NtjZ4RLbyPdigTgM1lSbuUkm6veNu0JUytEQLVkrWJ8XWB1iH/wTWGWs1T7z
         NsGnYi+gLnDcZvtSSNAcUjjVlqK8IBXGXrmTDeNyk1KZrlq76HX+oeY3n+JSHwtKwiKF
         qJKN3HZzYBu4+lS9keBYXw4314DwH1wpf5toD+OKTo8FaMp2YNk6O8k7Ip4qahcUNnv8
         lqeg==
X-Gm-Message-State: AOJu0YyHGRBosxoz+OkJPjNFzYYwnnNHHpaYPD1wELfcUYHa9mblKOMj
	ArGNsKImkFmDutFhVgZ7i4D+VmLyDqyp1OYEZ3zNhweBPbE8ozSytnvwhKynt0Ifj2b0+fwP6jX
	OG61rE3S+RapzQV7EhzzWHA2iMJPnQzlwfIOOSGFl
X-Gm-Gg: AR+sD106ULwlqcfJCsWSDQq4aOmcW3Y0URYlz+D3bvGCFBVZVCx7qRwK0f7sFbIsvGb
	KOkX3Ja5MobYOsHm6stqT7ZkRcLo74gS1bpYzrDk/fswnkS4tS9uD19WuDRiMw2aJB8fE2tzq2t
	XVYpX7ldc1EFUW9VW/g0Y2MtTEz5G2r9ba3C5AmDjjcjw4TWw+K/ls8FtK6wZ/6+PVjcChHnpDQ
	qf4w0AP802Ca+y5ScjIohivCnBdP343SqOPNAsgsBr/PXRMYw/q8Cy7mLiQSpNtd16KnUGOLAIU
	SsdjIr8wuktkmjr9GchcatVSud/4U5WB72RO35sI53G+NsUVgZ+aZ5fEsVHgDUYKgHHG6fYcVa/
	KTzk3Tox4ASS3lBFXdbey3m4rR6Len7zTR6VQ3X2078Uvkv8CXHBlBi3/3AMU55juOcFZ8cVLnv
	AWLk50O+U59Zn/xc4=
X-Received: by 2002:a05:620a:4728:b0:92e:59b0:df08 with SMTP id
 af79cd13be357-9371e20514amr485376685a.3.1787152741566; Wed, 19 Aug 2026
 08:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
In-Reply-To: <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 17:18:50 +0200
X-Gm-Features: AcwNN1X_gQ0jxbOVJSn2Ozs-cOZKCS2PtKqLSjl_wllIAfNV5SK2LsezXLUfmII
Message-ID: <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 10:43=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > Several qdiscs derive their per-flow quantum or backlog from psched_m=
tu()
> > > or accumulate qdisc_pkt_len() into a u32/int counter without an overf=
low
> > > or zero clamp, which can drive the dequeue/credit-refill loop into a =
soft
> > > lockup or a NULL deref.
> > >
> > > vega@nebusec.ai provided reports and PoCs which illustrated the follo=
wing:
> > >
> > > - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no ove=
rflow
> > >   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
> > >   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
> > >   unbounded up to INT_MAX in fq_change().
> > > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a=
 u32
> > >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a=
 few
> > >   packets wrap the counter to 0, and fq_codel_drop() then picks an em=
pty
> > >   flow and derefs NULL. fq_codel_init() also sets quantum =3D
> > >   psched_mtu() with no clamp, so a huge MTU makes the deficit loop sp=
in.
> > > - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no cla=
mp and
> > >   fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
> > >   fq_codel on a huge-MTU dummy device.
> > > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow =
check;
> > >   a huge MTU makes weight * quantum overflow the signed deficit, and
> > >   hhf_dequeue() loops forever.
> > > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a hug=
e MTU
> > >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles b=
etween
> > >   INT_MIN and 0 forever.
> > >
> > > Clamp the quantum to a sane range at init/change time so the dequeue =
loops
> > > terminate and the drop path never selects an empty flow. The clamps l=
ive in
> > > the init/change paths, not the per-packet fast path, so no hot-path c=
ost is
> > > added for a configuration issue.
> > >
> > > Conditions to recreate the bug: a device whose MTU (plus hard_header_=
len)
> > > is large enough that 2 * psched_mtu() or psched_mtu() wraps into the =
sign
> > > bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU),=
 or a
> > > crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> > > CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc an=
d MTU.
> > >
> > > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler=
")
> > > Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc"=
)
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > > v1 to v2
> > > Changes based on feedback from Eric and Sashikos[1][2] on V1.
> > >
> > > 1. Drop the fast-path changes in fq_dequeue() (Eric)
> > >
> > > 2. Clamp to a range, not just a lower bound (Eric). Uses
> > >    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not =
256).
> > >    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() =
left
> > >    bit 31 set, so a 0x80000000 quantum survived and still spun.
> > >    Upper bound is 1M, not Eric's suggested 16M. fq_change() already c=
aps
> > >    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent=
.
> > >
> > > 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unb=
ounded
> > >    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_QUA=
NTUM.
> > >
> > > 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-=
sol-1-6)
> > >
> > > 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):
> > >
> > > 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-=
6-sol-2-14)
> > >
> > > [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu=
.com
> > > [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130=
.16203-1-jhs@mojatatu.com
> > > ---
> > >  net/sched/sch_fq.c       | 17 ++++++++++++-----
> > >  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
> > >  net/sched/sch_fq_pie.c   |  9 ++++++---
> > >  net/sched/sch_hhf.c      | 12 ++++++++++++
> > >  net/sched/sch_sfq.c      |  8 ++++++++
> > >  5 files changed, 52 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 7cae082a9847..f7c92df085e7 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct=
 nlattr *opt,
> > >                 }
> > >         }
> > >
> > > -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> > > -               WRITE_ONCE(q->initial_quantum,
> > > -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
> > > +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> > > +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITIAL=
_QUANTUM]);
> > > +
> > > +               if (initial_quantum > 0 && initial_quantum <=3D (1 <<=
 20)) {
> > > +                       WRITE_ONCE(q->initial_quantum, initial_quantu=
m);
> > > +               } else {
> > > +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial q=
uantum");
> > > +                       err =3D -EINVAL;
> > > +               }
> > > +       }
> > >
> > >         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
> > >                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
> > > @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> > >
> >
> > You should probably split these into separate patches to ease code revi=
ew.
> >
>
> I didnt follow - are you asking to split the sch_fq into two patches?

No, you send a big patch:

 net/sched/sch_fq.c       | 17 ++++++++++++-----
 net/sched/sch_fq_codel.c | 16 ++++++++++++++--
 net/sched/sch_fq_pie.c   |  9 ++++++---
 net/sched/sch_hhf.c      | 12 ++++++++++++
 net/sched/sch_sfq.c      |  8 ++++++++
 5 files changed, 52 insertions(+), 10 deletions(-)

And today I had time to review the FQ part that we care about a lot ;)
