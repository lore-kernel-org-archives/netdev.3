Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BC4A32
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151815; cv=pass; b=CRBMv3P6oUSVaOAK/Ttag5dM90mj9eBw9XIcsx7wRrcBH6dE2KE0jefu8sp414kRBbMcmDvhlpDAJz5lRSUOxVjuo9YrRoXblvIP3ezdIIUkMyH8WJt3fAzLDl9oLJimXzX+HqymlxVRPFHbITrseVjVU03EHn3wsvh9hdyjZ1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151815; c=relaxed/simple;
	bh=mMf0U6o0qdeKHHclzeOZGo6oIJhC1uhERWO0vT6QBbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wf76e/VZwcD+uAV3kzOxlNchZCFXoq5y24uFAPZJT/yg0h0WwZH3FdhDpajx7JwQkqvVEEiv/0Lyh6A6eVLbYaYKR+KVI8uFzW95wch7KQbktGJZQFAWa2zpT/E07weUMAy/7XzORzcAMDMJuRAHuoW6eYJPdYAZfmoVopM5kWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nCka2Ktu; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nCka2Ktu"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1469c1b83so1200735a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151813; cv=none;
        d=google.com; s=arc-20260327;
        b=jg5rYB5OW/QnfXQ7Nbqc9r/+D0JiVn/O5Tql2HxhLgPmd+DRRCctNTlefJAEBBE+jF
         x2GRX6hyOih7HnrYGffdF4EyIqO6QOoeUNKd8z0bIXgQHdbZ3H3a9sb5obw9NBCvCze+
         6txzrMqoNQ5RSaN5EbvBy1IPEsCxpmEc+PfHjKMrl0erJtJ6RcOiCHWPQq/R+52OGw65
         uaRktSgIviiEAC8IFmqbvRNfmeBofXN9K3ROHPCOJvezVYpIviyXyl3Alsm9wrp4vUnb
         wjOP7+bheNVTvBaly72z6Y3qXsL9fgfzg3KGyQxvH3PW4RhCQCjiaPuhAInXq/ut102X
         mvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hoyex0e91o3MEl5Qbeb3DK6p2jh3NJqR01Fn/dN76iw=;
        fh=M7oqS4dhWck/l2Fu3NRPAuwjyyua/Nnn2TtGiZ7CsYo=;
        b=cdlyx/eIx0lsctuQqclSjezFMvkEaykVJmoJMOo7i/zal9ZT4Ms0SVNYq6A+suRf+0
         Vgd1v7G4v0nIvCRjGmk6leKc6qXA14qNLH2RHzV6MzThKxv8pSRo6Ius79SdPxAYyOEI
         2uya9vRh8mk/Hj7K2yFCQSLXFHivHp2X3K9PxCu3sLQ1AD0w8b5tLJxoawTtR+/pRG8e
         9eF8HQxS6LeX4ohTgBibmZ+tFBPXCcBz/KOf8cHtObdG0gfp1WgWuNHORM4pkkhXqaop
         aRU0T5yhfQ+q37PKSoRDk2ECLD2CKLNISHJzZDNWNUK/uCrYSG1Ubs+88UZiWY88/fwC
         nykg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787151813; x=1787756613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hoyex0e91o3MEl5Qbeb3DK6p2jh3NJqR01Fn/dN76iw=;
        b=nCka2KtukL4K3xCwssFkYzRDR0yqeP3NU/egO4DoWmwBD1tkqWF1zlwz2g3XfagOZx
         6/W57yLlJLKwnLelePu9/SYeJUYMWbz3Ik6B+P3gSJlVY9r4rvUr4f3EwoRM8dQtDq7M
         n705XihaVVwKFxO7rpLnhuU+PwQNTlZnOoHoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151813; x=1787756613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hoyex0e91o3MEl5Qbeb3DK6p2jh3NJqR01Fn/dN76iw=;
        b=p1lFJUKTNZdGewYpTdwoANGd7Cz4Orm5s2Xft8IkeM+sL59bPfFGHuuBfIO1w3XYHJ
         GpurTRsmx67EsQ+jYYPqYeOV7VT6DKP+WTiGPNSBCmS+KnpGOwT0PD3zAK7KKRT/lDQA
         N69ewHc7tHIB5OVtNdNFoDewY+jhl1GCGuUouFxseJi+GV2pEmkFD0AUEhL+iCPY8uNn
         Swxvsh8Wuq3HPhzXavOFXNXSySrsv3GPtqbEeU9KUxflyLIJt4PVBKndAMdZ0zXkOAYy
         Q0x0CMCrdyW2zsCWrXmC+1+achbG2me9QTzWGcbKIlfJqrZ+z5Idh/Pc5aa/Olk1MY+A
         jU2A==
X-Gm-Message-State: AOJu0YyUEPSuacePw9blVTqaumAdITbDb1BNbCHyivE0bXI0YMV9nCdr
	wNaGWQZs+OX1cS/AbF73DepHDvao7NcFD74DoPFypyLvFzU0VAxwAPxN3nEQGHiE1CKpxR8VX1h
	xZArsr83mEnkueCwffh41kOc25uw+HFkHK+9PEYRA
X-Gm-Gg: AR+sD113LhlN3m8Oq/9Sxa7mPVT6Kb0uQkAysS3kiBfQquj7+2h5UGpa7ha2k5lMEDN
	5f3998KTUkjVJEOsRFe/j0TzAL7bc/uiaMp/7Kwxj8Ml0ySkmrNmLLLw3ENTbOIJsmooCXdwgmb
	OumAQRdD2h9eyca3orVI4D0Faq/4KcOGceOHGqj+mLKYGDJxp9y0M9ULKhSqt4F28rXd5+L5fFI
	z5fFqhKzDqFZGodKZWwcPgI9Z4SmFA40cCKa/MH4cc/TO9az9kQQ7C9FvdoC8n00oZPv1w/a3Bu
	xSn19SBnMTHBRcrAMJPkejpVc7bOOJGdhjYG2BbaFN37SQ==
X-Received: by 2002:a05:6a00:4094:b0:848:2c6c:dfe3 with SMTP id
 d2e1a72fcca58-851d3aa292dmr9898809b3a.17.1787151812963; Wed, 19 Aug 2026
 08:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
In-Reply-To: <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 11:03:20 -0400
X-Gm-Features: AcwNN1XqripoK9HLMft7Z8IjnONclyHOSXysTjoh4sMUmaGQ_t0R2H_qbbz-vA0
Message-ID: <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:43=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Several qdiscs derive their per-flow quantum or backlog from psched_mtu=
()
> > or accumulate qdisc_pkt_len() into a u32/int counter without an overflo=
w
> > or zero clamp, which can drive the dequeue/credit-refill loop into a so=
ft
> > lockup or a NULL deref.
> >
> > vega@nebusec.ai provided reports and PoCs which illustrated the followi=
ng:
> >
> > - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no overf=
low
> >   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
> >   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
> >   unbounded up to INT_MAX in fq_change().
> > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u=
32
> >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a f=
ew
> >   packets wrap the counter to 0, and fq_codel_drop() then picks an empt=
y
> >   flow and derefs NULL. fq_codel_init() also sets quantum =3D
> >   psched_mtu() with no clamp, so a huge MTU makes the deficit loop spin=
.
> > - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no clamp=
 and
> >   fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
> >   fq_codel on a huge-MTU dummy device.
> > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow ch=
eck;
> >   a huge MTU makes weight * quantum overflow the signed deficit, and
> >   hhf_dequeue() loops forever.
> > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge =
MTU
> >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles bet=
ween
> >   INT_MIN and 0 forever.
> >
> > Clamp the quantum to a sane range at init/change time so the dequeue lo=
ops
> > terminate and the drop path never selects an empty flow. The clamps liv=
e in
> > the init/change paths, not the per-packet fast path, so no hot-path cos=
t is
> > added for a configuration issue.
> >
> > Conditions to recreate the bug: a device whose MTU (plus hard_header_le=
n)
> > is large enough that 2 * psched_mtu() or psched_mtu() wraps into the si=
gn
> > bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU), o=
r a
> > crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> > CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc and =
MTU.
> >
> > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> > Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 to v2
> > Changes based on feedback from Eric and Sashikos[1][2] on V1.
> >
> > 1. Drop the fast-path changes in fq_dequeue() (Eric)
> >
> > 2. Clamp to a range, not just a lower bound (Eric). Uses
> >    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not 25=
6).
> >    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() le=
ft
> >    bit 31 set, so a 0x80000000 quantum survived and still spun.
> >    Upper bound is 1M, not Eric's suggested 16M. fq_change() already cap=
s
> >    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent.
> >
> > 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unbou=
nded
> >    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_QUANT=
UM.
> >
> > 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-so=
l-1-6)
> >
> > 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):
> >
> > 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-6-=
sol-2-14)
> >
> > [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu.c=
om
> > [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.1=
6203-1-jhs@mojatatu.com
> > ---
> >  net/sched/sch_fq.c       | 17 ++++++++++++-----
> >  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
> >  net/sched/sch_fq_pie.c   |  9 ++++++---
> >  net/sched/sch_hhf.c      | 12 ++++++++++++
> >  net/sched/sch_sfq.c      |  8 ++++++++
> >  5 files changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 7cae082a9847..f7c92df085e7 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct n=
lattr *opt,
> >                 }
> >         }
> >
> > -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> > -               WRITE_ONCE(q->initial_quantum,
> > -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
> > +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> > +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITIAL_Q=
UANTUM]);
> > +
> > +               if (initial_quantum > 0 && initial_quantum <=3D (1 << 2=
0)) {
> > +                       WRITE_ONCE(q->initial_quantum, initial_quantum)=
;
> > +               } else {
> > +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial qua=
ntum");
> > +                       err =3D -EINVAL;
> > +               }
> > +       }
> >
> >         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
> >                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
> > @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >
>
> You should probably split these into separate patches to ease code review=
.
>

I didnt follow - are you asking to split the sch_fq into two patches?
My philosophy now with AI bug reports is to group them into a single
patch if they address the same pattern or bug.
Almost 100% of these were caused by people causing cutting and pasting
the same pattern from the original code someone wrote whenever they
add new features.
If you understand one fix in one file, reviewing the rest should be easy.

WDYT?

> About TCA_FQ_INITIAL_QUANTUM in fq_change(), you could have changed iq_ra=
nge
> that was added in  commit 7041101ff6c3 ("net/sched: sch_fq: fix
> integer overflow of "credit"")

I will look at it if i need to do a v3.

cheers,
jamal
