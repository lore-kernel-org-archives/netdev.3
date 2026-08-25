Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403B3D9DB1
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649395; cv=pass; b=hpAnQrguUUR8kbpOktutsmZvBD5/6Lx4IjX8dX4JyfJz1q6toheCWl6OK50xRJCeuhGeTq34IrjZzI9+vizCLT/GWszOGE6cmRNjEw7NN7YAzBcxKDXbh8zda+MgkktiSzdoIc2IdzDD4TnoRuI7m5hRp659cLVdephPDShOYrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649395; c=relaxed/simple;
	bh=H1SQ4hT1KQqrQV7vp8N8BkgUmq8q7U6yAUaePAyRclk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0RGIDgMsHIeJqBlaxkBSa68gDpBkaDS9LHX3iHf2uy/5U0I6S6wHQiCBkCRysMnpP+znAdh9O0XtiMEbTk5yoeyfaw3IgybWj39kG0KtdxTnuqaUETqk2aVPWhBvq1Y+QqP/b0cdljEvMDHOJOm04q91GaEcqZzanREFSxyo6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=O0eCtH5X; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="O0eCtH5X"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e27035206so1843225b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787649391; cv=none;
        d=google.com; s=arc-20260327;
        b=Ed8IsXtZ/+qg2jbAsNpyVNe26RQAMQjYYy22BZsH+PbO6JgQw15hHa51bvgFF6SCbK
         gWyR0Alh17v68F3C7CK8EtFJ77k8hFgLKdhd0ud0l2sCTkPOGcN/J72FKQCOVQmUJxD+
         Gn3a/kEIopBDkr2wtWsB68U7wiDinVk0UHOVx8aq4Anh7Hak36OHcGsPwJJlGfKFU+3d
         8+7tlGQ/pnwRoeMZ+7e67e6S+uSltRdzbHo/fw7iBBJrNAif5KBLp2Ys2/SOZVvdCUl0
         ASYMB6u3amh+G+M0fKPXPwxqVHJGpxlng/OH2Aaqnnp+XlHjkqOI9oXXHtRlAwxaQFrR
         Vkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        fh=+0/985afELwKkaajT9e+T2qoswK/Rz37tvSCu8LAOdI=;
        b=P2ry+hbJWbJg/YD1qEhPyKM0vPMLWhgJ/NY6kB5nT/kxT9WyVEW9nuItUNpasiHkf6
         CXY+n2Gf62BZTyLv0vqdf9R4hKbJVG7ifTTmwrtar6eWLwX2oMZ3UocZOcTRBnI4dyUE
         TBkV0El33DpneogYH7AiojTulmFsLa9qx3vBchPfVUyxEoVP2G/hPOeXNQ+ft8mPNHCU
         adfQKMyUfnGrfART+uwzeA4AdkCWlemL2SKIvrTshVfYlBMynv/Ec7DAkgWIsyPvue3W
         UM2UfQ7J2v6evN7yYYGRMKLYra0pQJa1rJpZis78rVTc+ENG/4jcIvFNy03gshF74s3b
         hpXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787649391; x=1788254191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        b=O0eCtH5XeSlMe5GvOZxWYo6NQEfGagDs1O8inrdRt/WIMTnsgEj1cVmAryjtJ65SSQ
         iiLca48oaDfMLC01MpS7BlMSGgDynPdXXU07OBZC3BCJQRndyJtu1ic0G9Oga2eLrYOh
         UmIycSYcABaJpM5EKhOvLaqwtIOKVeszrxrj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649391; x=1788254191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        b=NpyFZlFlitvO1S6UA5LVB8BZ64e7hs/sUzAAbvqjxZNkOpybFOVN4dZ1Ohsub2FcIw
         ZpDRgR0b/+D21HdIEoMDv2MSBEZ0eaZEJVPBv4BKSlBYdeim2/3YROOu6DuKlbUVMNrx
         tft//MH3b9WpAaYPJWfZi6MSAQXOzzfjTPM6+SDMBX1WAktcfiQMP6fRbxSvnGyMeP2w
         eZDQgehnG30C34LrD/ccUSDz8EhzUPp9WoE3DYY22PCEAv+iipNW+l5Ta0UOTlftqDT0
         sUoIhJ+BG7cYL8KcsXz0otlPMlzsjem/7jcOmDif/lNW+iZqCmFV6+NnOZvRa4+cIoRK
         aU2A==
X-Gm-Message-State: AFuF++n/uWFlWWAbCzBpFB8gg5iKzboLqqHTE1/SYVeXQhHf3dLdstsq
	IongIOzoE/4goSlnkpZxarXg2x1jJ+Qyo356DiuLmu8LTNOHnfa305W5ICJj3iUp+GhkdGN3svo
	ryItQj46dtceU9u1G6YUZx+3w3gTJnhMSPosWDchO
X-Gm-Gg: AR+sD11If+3vcT1ofUVae7YIe5RDlZOROO7PqTzGeYY5j7hnlyQduYI+F7HIBdNw8oU
	lGywcdM2hs8F5WwmQju2dETw9og2FSR7fyVCRm3ZmE2YdSoPd2LGPBDuOxKMWZsCqsz+JaGpJG7
	7QY43cuukgacN2Z0xjDeLFxKFu6vywvUmNGl8/YzzalmPobZ2d3n+8HGLqYmjTA3kYKK+6oNZut
	y02O4NHCFeFsUaHX4Auzbir9+4E4K5VcjzGFQ+4lwBpjiNOv7Y3rrnE6ta9kUYVNmfq0c7+W9VO
	H6fX5QAv0LmXHr450qKo6D29gCAdottV3/i09LO1CxeE/qofEz5QomcP
X-Received: by 2002:a05:6a00:2e17:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-851fa024b2fmr53883728b3a.13.1787649391557; Tue, 25 Aug 2026
 02:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-5-jhs@mojatatu.com>
 <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
In-Reply-To: <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 05:16:20 -0400
X-Gm-Features: AcwNN1W4dU6fkQMaBEtZid1fXZrnyh2RgeBk2usssVcuBGElMZCq7KTBOpf55LU
Message-ID: <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
Subject: Re: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to
 avoid signed overflow
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>, "Sachin D . Patil" <sdp.sachin@gmail.com>, 
	"V. Saicharan" <vsaicharan1998@gmail.com>, Mohit Bhasi <mohitbhasi1998@gmail.com>, 
	Leslie Monis <lesliemonis@gmail.com>, Gautam Ramakrishnan <gautamramk@gmail.com>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 4:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> > fq_pie_init() sets q->quantum =3D psched_mtu(qdisc_dev(sch)) without
> > clamping. A device with a huge MTU (e.g. dummy with max_mtu =3D=3D 0
> > accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> > overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue()=
,
> > causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> > is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20]=
.
> > 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> >
> > Conditions to recreate the bug: a device whose MTU (plus
> > hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> > device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> > CAP_NET_ADMIN in a user namespace.
> >
> > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq_pie.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> > index 069e1facd413..b27d95418707 100644
> > --- a/net/sched/sch_fq_pie.c
> > +++ b/net/sched/sch_fq_pie.c
> > @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nl=
attr *opt,
> >       pie_params_init(&q->p_params);
> >       sch->limit =3D 10 * 1024;
> >       q->p_params.limit =3D sch->limit;
> > -     q->quantum =3D psched_mtu(qdisc_dev(sch));
> > +     q->quantum =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> > +                          256, 1 << 20);
>
> Sashiko thinks that the soft lookup is still reachable via pie_change:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112717=
-1-jhs%40mojatatu.com
>
> and has similar concerns for patch 6/6, too. It marks the issues as
> pre-existing, but AFAICS they overlap with the things addressed here.
>
> WDYT?

You are right, they overlap. I had them as followups (with a few
others derived from the sashiko feedback with justification that the
v3 init-path clamps are independently correct and the stab cap already
mitigates the change-path worst case to a stall; but those two a
(adding max(256U, ...) to both fq_pie_change() and sfq_change(),
matching the fq_codel_change()) are more serious.
So if you'd prefer a v4 respin of the whole series, I can do that.

Sashiko is a double edge sword - i think code quality is improving but
it feels like the work load has doubled ;->
Here's what i had as followups (some still to be vetted, just noting
what sashiko is stating to be reviewed later when cycles available and
potential followup patches sent):
- sch_dualpi2 unclamped psched_mtu
- sch_pie unclamped psched_mtu =E2=86=92 AQM disable / div-by-zero
- hhf TCA_HHF_HH_FLOWS_LIMIT unbounded
- fq_pie_change() / sfq_change() 256 floor missing (one that you bring up h=
ere)
- DRR/ETS quantum=3D0 spin (have a patch, was reported already as a bug by =
vega@)
- Consider two separate clamps for fq_codel/sch_codel (nipa
gpt-5-6-sol-3-15): quantum in [256, FQ_CODEL_QUANTUM_MAX], mtubounded
separately (no 256 floor on mtu)


cheers,
jamal
>
