Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF183AF66E
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150588; cv=pass; b=ZDMIHDzLxH2T85njY32HS8dSXvsrXq7Lp8YzXAeNfuXMoFp/Huq6hxSqyxXl6Xyt/hduvN+kM3VIDM8aqYSJmszCkB4pUqG1EU0p3azS+zulaVdXm2kvxdeVcGcynpIRr5MadvePxLcSXyufp/BMSDWpXn9e48dzuu4GIoF5lwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150588; c=relaxed/simple;
	bh=MkqX0W8IbJPEwSSAUuHUDaPQT350a/qmK5/0HidHyVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXae7GZPGO3QCGUON/JpdrwfcB076zrXJeqBDyo/7Njkaw+DEJOV8jl10WcePOZFz2AHZNltFkHEg0Glg3mW+//GI5gIAZ8P8mXUcq4oAjRudXTkEVcqjLcPg072LiB7KD2kaURksrfo2vm9hoslRdhPK2rDee1lYyt9BBBq5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7mKCOca; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7mKCOca"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a818fc4so7113371cf.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150585; cv=none;
        d=google.com; s=arc-20260327;
        b=nmCs/Kvg+b4s14UBchGqGK4UNWp9lUuac+iTglCEFYsYXCaHpmk52Nw30MBQ+6UVAP
         dT/sKSS6Q7NSshSMAfUPm8Jl3AUzqHLqlcpqC3lHF0Wn7yYECoJQsETGt+C/qp6tnx67
         Q/X1V+lHJLvNjOrXMyELkx2+9OPY8k2kv92hsjCK5HwgIUmrsB4nBwtVhBUdzVoE/a+j
         X2WfDxWZUzXufaCpNxHBVu/qt/xE4FLVoaELOdWFRSfaDcLR2bs7iz5RJesNE+dIKlKY
         yK3OxXo4yoIttR6FkIWboSVvo56F361wAK/Pc6K7wsexD1w78xVJL/2L7TCsBFBZn6DB
         ARZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=abHURphdFU4pbSec5ZizbPLvKJZrXwGryBqfe44xzAKMBINo/cAJ2Eent4R22cKjWy
         RsXD9zY0X/noY0wRc6aM7FTVpGvyOSAwtPiszpQjqfATrHXA+7QajypJ4KFEWKXRScOD
         8lWqlht1yiEszq7Uq3NBB5iunz9lvO1Z82b/rKn466OMVcDO4nz/Jl4mRiaVVtuusytp
         h9j4Wju4bjBXK88nAtI2xKLhqENvNMF+oHDCJEFqk69tf378oK55S6AAHkMTZjQY3akT
         EU4+uj/XpIXsVnr65RVuPbcO7rRZMLzl0OxzTuYBBo4mpWn5ZDGHnNy4K8q0hYaWibJm
         cRig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787150585; x=1787755385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        b=B7mKCOcaL1tw4wU4Oecdr3AsO7InUl8BbU/DNW4ZG8Ywlj+IFySqq17K2gtSM0axo7
         D9N3YeGB/byXpV+eGLsGygcRSQ/WIB3fF8RjfqpP0AyhaeFEYC21WDOI34E3NEAbPnnJ
         97zJ0LR9S1r4VzjJ0qR22oBYyXiO5vv1adk+tetgWBNS2dfTWwoa1hMLeXtSN+CSwxnH
         AYmOQOp/ZuKjHUQDOYE4KAgFTBbUerMuxobBkrlByBYmqUibx6SQWgPUYLLH8RKi/aTT
         noDm1AFawWX9ff1Gn4EK4hspK+IqlYVAzvISaXCrRJbpmCvpPkdk+C920w6Ux60PyNuD
         Dq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150585; x=1787755385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        b=O0L2mgWtETLbjHbBS9naGJL0LhKk3OP7x40KlkubV1KTS4e3YmKpRNofeeaU9ZzG0q
         ejYemzBRbBbBLoi3Y6UTGvEKlX2+8UMvCmpaE5fY7/zNh6OoQnOqojlvUKh57fVTcTPK
         NitWhG2rxeTFjAMpRZxVSxhWxKUriEKzbN8+ZReajgk/6flEGdM5TUM2oM5q+MgDm0r4
         jYEwcHoZiZ0Qhs1UcIXd9trXqIFW0rYOVMOSiODla5Wr74bva8E4pJbHj2ud1nDNk537
         HSuUgb+KBU42jpxuCJwZDZqBfdbpnYHL3ISCuZ7cEB+dOE2s+sctKZdv/KSyQQ0S7wF2
         QnFA==
X-Gm-Message-State: AOJu0YyC/XEEwiAa9hqD/nQUMuRhgGJ6CsW9/+oSUjBUSN240+FEdcua
	gVW4UMBL8DhzkQ3LmeZvzDYQLraJGWJvLKC7lYSoQpZtaviWQF2BKfBJk+dNXmRCEWMHzeE+uC6
	wlSvXSiAftFvZ/w86S/6uOrdt4MRVR0ENx2cmh+em
X-Gm-Gg: AR+sD13OZADrg56Dms+Yzs+x99JOBbtZxyJsPofUH7xRnlUO/9tL0eCVJQxt3xMKwc2
	Hy2uHPQEfxNGKCZDsF2kH5EWibKZ1qtpgRrc7fy82lIVeg4srPh8gu1cC0LUGYNMjbKU9Pnzakt
	O1hTwvrXD9Uya5GNQIVt/Re1ninB1D2oYDyCiVVItxyR2eZsDvHLSA+JxMPWdPQeuUT5ppor7AZ
	ov7z9Z0cp9IKBflXoALXRFxFhNg3/+WS1qFiyYmFNxQFM+VWldDA3W4YwKDO0kjf7ChOyl49lq8
	A+v8qw6JS8b2WigsLR7YeGbuJwMdN/j63l5xxxMQXZcZkIacrrbFL6li0WbOQT2Tvc56CRQTm5N
	KHkgeF1n+Twvwhyud75qBHiSFhWyCOY25epefm8Fo/8jDXQY8d469K2TGVvnDDV/6SSks0jd/ul
	gCoTGMnPv0zZ12KOY=
X-Received: by 2002:ac8:5953:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-52dd577f088mr42352351cf.17.1787150584067; Wed, 19 Aug 2026
 07:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com>
In-Reply-To: <20260819143136.57350-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 16:42:51 +0200
X-Gm-Features: AcwNN1U9GKxgnOJkc2Jr561s0UMwJEgI4co2sC_RH90OJcR66PZEiypnkkQ35Js
Message-ID: <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Several qdiscs derive their per-flow quantum or backlog from psched_mtu()
> or accumulate qdisc_pkt_len() into a u32/int counter without an overflow
> or zero clamp, which can drive the dequeue/credit-refill loop into a soft
> lockup or a NULL deref.
>
> vega@nebusec.ai provided reports and PoCs which illustrated the following=
:
>
> - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no overflo=
w
>   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
>   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
>   unbounded up to INT_MAX in fq_change().
> - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
>   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
>   packets wrap the counter to 0, and fq_codel_drop() then picks an empty
>   flow and derefs NULL. fq_codel_init() also sets quantum =3D
>   psched_mtu() with no clamp, so a huge MTU makes the deficit loop spin.
> - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no clamp a=
nd
>   fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
>   fq_codel on a huge-MTU dummy device.
> - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow chec=
k;
>   a huge MTU makes weight * quantum overflow the signed deficit, and
>   hhf_dequeue() loops forever.
> - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge MT=
U
>   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles betwe=
en
>   INT_MIN and 0 forever.
>
> Clamp the quantum to a sane range at init/change time so the dequeue loop=
s
> terminate and the drop path never selects an empty flow. The clamps live =
in
> the init/change paths, not the per-packet fast path, so no hot-path cost =
is
> added for a configuration issue.
>
> Conditions to recreate the bug: a device whose MTU (plus hard_header_len)
> is large enough that 2 * psched_mtu() or psched_mtu() wraps into the sign
> bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU), or =
a
> crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc and MT=
U.
>
> Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 to v2
> Changes based on feedback from Eric and Sashikos[1][2] on V1.
>
> 1. Drop the fast-path changes in fq_dequeue() (Eric)
>
> 2. Clamp to a range, not just a lower bound (Eric). Uses
>    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not 256)=
.
>    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() left
>    bit 31 set, so a 0x80000000 quantum survived and still spun.
>    Upper bound is 1M, not Eric's suggested 16M. fq_change() already caps
>    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent.
>
> 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unbound=
ed
>    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_QUANTUM=
.
>
> 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-sol-=
1-6)
>
> 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):
>
> 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-6-so=
l-2-14)
>
> [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
> [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.162=
03-1-jhs@mojatatu.com
> ---
>  net/sched/sch_fq.c       | 17 ++++++++++++-----
>  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
>  net/sched/sch_fq_pie.c   |  9 ++++++---
>  net/sched/sch_hhf.c      | 12 ++++++++++++
>  net/sched/sch_sfq.c      |  8 ++++++++
>  5 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..f7c92df085e7 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct nla=
ttr *opt,
>                 }
>         }
>
> -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> -               WRITE_ONCE(q->initial_quantum,
> -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
> +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITIAL_QUA=
NTUM]);
> +
> +               if (initial_quantum > 0 && initial_quantum <=3D (1 << 20)=
) {
> +                       WRITE_ONCE(q->initial_quantum, initial_quantum);
> +               } else {
> +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial quant=
um");
> +                       err =3D -EINVAL;
> +               }
> +       }
>
>         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
>                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
> @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>

You should probably split these into separate patches to ease code review.

About TCA_FQ_INITIAL_QUANTUM in fq_change(), you could have changed iq_rang=
e
that was added in  commit 7041101ff6c3 ("net/sched: sch_fq: fix
integer overflow of "credit"")
