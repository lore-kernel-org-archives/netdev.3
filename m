Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7079309EE9
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063135; cv=pass; b=Qt8xgLTIEBKuu/yf+FVEYL/KA6pXvZ15k+rai7naHjztSuDEFvmyLc+NvtcU1DmGh/Cw2ZGmXNaoYNf9yBM8oDGJLbk65xG6XERi3jA8VOwnxZYY2xCoD39Dq+GfvG8IbpOuMEBu1u89e11KQ62ysGQ1fmryQHGJGfSO4kCc2/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063135; c=relaxed/simple;
	bh=DbPdiscsp9gXKF1ZYMIJPnEPbNbsfMhc+JlUgA7pi1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9HmSmRIcIRa/7jPLMI4joZBw+6DjNZrSbChwYL/6NBaQfggf+WwwHm27/N5ApkiAI4Cuuui+LW04Ob1zf/8tXjJl50ZK6Y6ALRRTrMxu7toI0muubr4VnDv3+R0USTqm+TG8rVxfWpYneE6FIvmXeiYu4dZT7zGYKUvQ9MOeac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mhnMmtEb; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mhnMmtEb"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c70d73210so972807d50.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 07:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787063131; cv=none;
        d=google.com; s=arc-20260327;
        b=hvIWcPAKbyBNSr44TccqQbCczTnx59G71pyKmxnpMlC6pL/tpdPIq6PBvtq96S/cdw
         MUJ8lEjlSNVo7ZWPlqd63N4C90G2gqdV+RZ/QuPPfOqS+HCygW8xcS39b+P/IfeLMGV0
         TuO1rK1MeNE1uZE19RhPCsJwEMcFEKnze7AFVouG/d7GGKV6CyYFJpucNj4oKrOkrk1K
         V6hXwxFHjiyDqnIyHhCnDiy8adZtDIgPLeAEuPKX8DuEkmPkFh+TB5W3xA78u+0ciWaw
         Rs6atcm6m4qP+l91T1J+jIhhruuEHoxtU5CPQLfUdbo1k8CZD0HLYlxLhX84MrTtGviQ
         EeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=597be7P55n2TOwpIhGBIUkdPf+71oienwEHCJySe6VI=;
        fh=tlFVqncFp2u5hCh5b0IQgqN6rTiQvueDZ5XJxt7CF48=;
        b=IGZn6J1AtlREizyZXwBlmhgTO1pDlN5HN+mf06BqIu/bqgVq4mbeuQaAOJ/KoPRapd
         9QHn554iUxEUlazyqc2u0bh7MxIRc4eUGi+6HpYXTRR2fjfKM1Xy9JLIqmnSNaXbYh6Q
         hrAeenSUBRrM1IgPgEsCyhU7ycbwByLnS/1m9PSbAKujMp0MErri1uSehXvn/AmZovCw
         +WyxOTtAYi2kYEhOvaM3H6zpwsHpb7is0jycxTm84FYtACsdGFUQuF5KBjgmLA6tgxlx
         0e9N+jrvE1QGVR3eFddVioJzBUIT9urU2IymkCGXsp6NAfBJp3U5rupUvgt+9lPRVu0Z
         55aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787063131; x=1787667931; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=597be7P55n2TOwpIhGBIUkdPf+71oienwEHCJySe6VI=;
        b=mhnMmtEb+rBeWC2jWKl2P3wLO92VQ+/NKdB8BMSb7e2cco8zsOWMgxjBtW5neIDo0R
         zRNFHh0IjG2ua8LONWHb6Z2WRvjZOsKcDMkUcBPDYxNNFMWDlY5qr9ZXiJsQgpo3FOj3
         ffasPRt18EJdVb773pnQgNZ1lcsCM/hfXlNlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063131; x=1787667931;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=597be7P55n2TOwpIhGBIUkdPf+71oienwEHCJySe6VI=;
        b=KcOFISB5ha3vKzFW163xG2JRuyIpjBLPnofX2dhyC1D/qoKJyapB0EG2Fyh4yjFbYb
         mPqirCYxNxtGHP5jdE+lrPIHKeTUbSb1S9YLoWTF61ZxAXczyp6N7YJGcW2023lCVTL3
         118/yXpmmieXtA8ZWREhGPBjv7Uwp3OgfBLG4PEu2IItTBNyuf+6GwWviHyNyyUGTGC1
         v4Tb4G8Zn31GCEVnSKgpGH0AHnaVjat06tRG7v6PaANNy0V719JdDKCYHgeo6F3vIS+t
         hOoXZrqxKQRAU0RuVU6d+3xR2eA7AAdHzWobs1hz5RDU2m3OvQvJvJK6jvntcwK0P9Eb
         SjuA==
X-Gm-Message-State: AOJu0Yz9jbL4BmibCTc5b4m06GtVFjyKhhyXTsnuJfv4w6+PSx9XAW95
	OjBH02aL4QY2W6wiRV2EraTJzm2DuNLRpZOgmSyHN5xfeY8XuB0lsjQLAy5JxHL5lHhKfrVY3fX
	/nVyqwJGrIHQZuMbGYkb6x1mXdKjzWAFZdAvI2lx1
X-Gm-Gg: AR+sD12pBaK6jLb9aI4MmXciXOhLEyPgjOjJnP8QG7snUmvEe2vcUmY8anNFrsrmqsp
	jmQ0x+MI2HXpaYyvsbitYzugCU6ghNnM2wtFRJOnfLG3eqjTPrmT+b2aMM8+CEawL8jCwBQzv2f
	hvAicm+LB0+VY0WYaQnr6bUWdB3d8afhDQZ4v46cWnIrFq5ciBo8Sn3VaTuE9ZVkHz0a1mbGGnJ
	fJMehNddGBcc1KfRdMto73+M44gw0SQ9bUwMPM4+ftPGRDhP42tl5b0CHmRooIiEzXvhiG0x02o
	g2Na4+aegSZpS4o4DDQwgDIE6Y4muSyS9Nt7MxhGikeU8yRkmzSo4OgE
X-Received: by 2002:a05:690e:c44:b0:667:da23:14af with SMTP id
 956f58d0204a3-66c72d4ad1emr12705657d50.52.1787063130635; Tue, 18 Aug 2026
 07:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101130.16203-1-jhs@mojatatu.com> <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
 <CANn89i+edjh3JMZKTwG-gVtvMv_ya-wVUfK-yuKahRcoUoYDdQ@mail.gmail.com>
In-Reply-To: <CANn89i+edjh3JMZKTwG-gVtvMv_ya-wVUfK-yuKahRcoUoYDdQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 18 Aug 2026 10:25:17 -0400
X-Gm-Features: AcwNN1XIO57XLKSI8uS4aMkYA4dH-uwsev03rInmRgJkP3rcZXxbYnlZ-0OcRP8
Message-ID: <CAM0EoMmgo0ZZuKM5CB5t9tP7zVovA7UJgmciMs2LuLBRyp4_uw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000185e3e0659530f20"

--000000000000185e3e0659530f20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 9:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 18, 2026 at 2:55=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Aug 18, 2026 at 12:11=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > Several qdiscs derive their per-flow quantum or backlog from psched_m=
tu()
> > > or accumulate qdisc_pkt_len() into a u32/int counter without an overf=
low
> > > or zero clamp, which can drive the dequeue/credit-refill loop into a =
soft
> > > lockup or a NULL deref.
> > > vega@nebusec.ai provided reports and PoCs which illustrated the follo=
wing:
> > >
> > > - sch_fq: fq_dequeue() credit-refill loop with a small quantum spins =
~1B
> > >   iterations under the qdisc lock (soft lockup); fq_init() computes
> > >   quantum =3D 2 * psched_mtu() with no overflow check.
> > > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a=
 u32
> > >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a=
 few
> > >   packets wrap the counter to 0, and fq_codel_drop() then picks an em=
pty
> > >   flow and derefs NULL.
> > > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow =
check;
> > >   a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit +=3D we=
ight *
> > >   quantum loops forever.
> > > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a hug=
e MTU
> > >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles b=
etween
> > >   INT_MIN and 0 forever.
> > >
> > > Clamp the quantum to a sane minimum and promote the backlog/credit su=
ms to
> > > avoid the wrap, so the dequeue loops terminate and the drop path neve=
r
> > > selects an empty flow.
> > >
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/sch_fq.c       |  9 ++++++---
> > >  net/sched/sch_fq_codel.c | 14 +++++++++++++-
> > >  net/sched/sch_hhf.c      | 12 +++++++++++
> > >  net/sched/sch_sfq.c      |  7 +++++++
> > >  4 files changed, 38 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 7cae082a9847..66e9c6e530d8 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *=
sch)
> > >         f =3D head->first;
> > >         retry =3D 0;
> > >         if (f->credit <=3D 0) {
> > > -               f->credit +=3D q->quantum;
> > > +               if (f->credit + (int)q->quantum > 0)
> > > +                       f->credit +=3D q->quantum;
> > > +               else
> > > +                       f->credit =3D q->quantum;
> >
> > Lets not add cost in FQ fast path just because of a configuration issue=
?
> >
> > >                 head->first =3D f->next;
> > >                 fq_flow_add_tail(q, f, OLD_FLOW);
> > >                 goto begin;
> > > @@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> > >
> > >         sch->limit              =3D 10000;
> > >         q->flow_plimit          =3D 100;
> > > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > > +       q->quantum              =3D max_t(u32, 2 * psched_mtu(qdisc_d=
ev(sch)), 256);
> > > +       q->initial_quantum      =3D max_t(u32, 10 * psched_mtu(qdisc_=
dev(sch)), 256);
> >
> > We instead can make sure quantum and initial_quantum are in an acceptab=
le range.
> >
> > [256, 16M] would probably make sense.
>
> Actually, we use 1M in TCA_FQ_QUANTUM in fq_change()
>
> We also need to change fq_change() because TCA_FQ_INITIAL_QUANTUM can be =
set up
> to INT_MAX.

Good point on avoiding fast path changes. I will review the others and
resend after hearing from the naughty AI.
So something like attached (compiles, untested)?

cheers,
jamal

--000000000000185e3e0659530f20
Content-Type: application/octet-stream; name=codel-patchlet
Content-Disposition: attachment; filename=codel-patchlet
Content-Transfer-Encoding: base64
Content-ID: <f_msyr6fpd0>
X-Attachment-Id: f_msyr6fpd0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfZnEuYyBiL25ldC9zY2hlZC9zY2hfZnEuYwppbmRl
eCA3Y2FlMDgyYTk4NDcuLjU3MDk1M2Y3YWRiYSAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL3NjaF9m
cS5jCisrKyBiL25ldC9zY2hlZC9zY2hfZnEuYwpAQCAtMTExMiw5ICsxMTEyLDE2IEBAIHN0YXRp
YyBpbnQgZnFfY2hhbmdlKHN0cnVjdCBRZGlzYyAqc2NoLCBzdHJ1Y3QgbmxhdHRyICpvcHQsCiAJ
CX0KIAl9CiAKLQlpZiAodGJbVENBX0ZRX0lOSVRJQUxfUVVBTlRVTV0pCi0JCVdSSVRFX09OQ0Uo
cS0+aW5pdGlhbF9xdWFudHVtLAotCQkJICAgbmxhX2dldF91MzIodGJbVENBX0ZRX0lOSVRJQUxf
UVVBTlRVTV0pKTsKKwlpZiAodGJbVENBX0ZRX0lOSVRJQUxfUVVBTlRVTV0pIHsKKwkJdTMyIGlu
aXRpYWxfcXVhbnR1bSA9IG5sYV9nZXRfdTMyKHRiW1RDQV9GUV9JTklUSUFMX1FVQU5UVU1dKTsK
KworCQlpZiAoaW5pdGlhbF9xdWFudHVtID4gMCAmJiBpbml0aWFsX3F1YW50dW0gPD0gKDEgPDwg
MjApKSB7CisJCQlXUklURV9PTkNFKHEtPmluaXRpYWxfcXVhbnR1bSwgaW5pdGlhbF9xdWFudHVt
KTsKKwkJfSBlbHNlIHsKKwkJCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJpbnZhbGlkIGlu
aXRpYWwgcXVhbnR1bSIpOworCQkJZXJyID0gLUVJTlZBTDsKKwkJfQorCX0KIAogCWlmICh0YltU
Q0FfRlFfRkxPV19ERUZBVUxUX1JBVEVdKQogCQlwcl93YXJuX3JhdGVsaW1pdGVkKCJzY2hfZnE6
IGRlZnJhdGUgJXUgaWdub3JlZC5cbiIsCkBAIC0xMjI2LDggKzEyMzMsOCBAQCBzdGF0aWMgaW50
IGZxX2luaXQoc3RydWN0IFFkaXNjICpzY2gsIHN0cnVjdCBubGF0dHIgKm9wdCwKIAogCXNjaC0+
bGltaXQJCT0gMTAwMDA7CiAJcS0+Zmxvd19wbGltaXQJCT0gMTAwOwotCXEtPnF1YW50dW0JCT0g
MiAqIHBzY2hlZF9tdHUocWRpc2NfZGV2KHNjaCkpOwotCXEtPmluaXRpYWxfcXVhbnR1bQk9IDEw
ICogcHNjaGVkX210dShxZGlzY19kZXYoc2NoKSk7CisJcS0+cXVhbnR1bQkJPSBjbGFtcF90KHUz
MiwgMiAqIHBzY2hlZF9tdHUocWRpc2NfZGV2KHNjaCkpLCAyNTYsIDEgPDwgMjApOworCXEtPmlu
aXRpYWxfcXVhbnR1bQk9IGNsYW1wX3QodTMyLCAxMCAqIHBzY2hlZF9tdHUocWRpc2NfZGV2KHNj
aCkpLCAyNTYsIDEgPDwgMjApOwogCXEtPmZsb3dfcmVmaWxsX2RlbGF5CT0gbXNlY3NfdG9famlm
Zmllcyg0MCk7CiAJcS0+Zmxvd19tYXhfcmF0ZQk9IH4wVUw7CiAJcS0+dGltZV9uZXh0X2RlbGF5
ZWRfZmxvdyA9IH4wVUxMOwo=
--000000000000185e3e0659530f20--
