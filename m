Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA51E5B68
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651300; cv=pass; b=U84nq5zLy6v4uEwt2pmWIcmZXcamavzbt8wEUeZY0cnCean1LFViNytimQkDIdhxRmqMRG+L7gTtRDJN4Zf5FYmjecFJ5Rg4mPDCClcb5FTHy9ucC2xMv3TlSBkcGqeGKRMzbUvG/DmYJi8868GZcS9KC5sKHyP11285A1I3XfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651300; c=relaxed/simple;
	bh=4t+j/BXBalwXPmR+JwRXFZWRqKHcAW3hueUDjIbFXHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwMS9dVuvN3Soi34DonfYLoaiPh7Xi7ahYGvYyH2lLptuHupBN/Hp7+NL8KnRxPYblv62ZSV0am1H4EGlix7zlNrQvPzo5o5FOj26RG6Ie/8xt/uuJQOsTPbOukZGoXwGJ6CWrGJ3YGlTSu4fRkk7HSzbrqw16pEVG5TaS/C/kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GTSc92Tc; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GTSc92Tc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4503173b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787651297; cv=none;
        d=google.com; s=arc-20260327;
        b=Kml4V5s/z+SlnfHTNd8LG7Fi1jyr47HzrcpUrwK1TptLMNzkmXJjLUb+AKZmIah+Pz
         enG3fYEKnara/HpTSc8fGMb2INn2RkX6Uqxfc5WDwgy9tLxMISoMK6NGZwvhW77FQpXS
         oFHal9HM5WcdJ+lfASihKCxfHvtRB6kANPyR7vSTxk8G7MW/9P2gu34BdF+OL2FdNGqA
         8oxZAfMVi24V3Cr8TbfVbABGC+MpTEAXy9DWzVIfPFGRzuQ1dklqAZAOt1D28WCG97b1
         yUrw3ilOjyCVvW3dRg2n1bjKYSWP8vAZcAtF4tWKLBX+SaJWmEoDrZJkSJNE08Zsgbbo
         dxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        fh=+0/985afELwKkaajT9e+T2qoswK/Rz37tvSCu8LAOdI=;
        b=VaQG7U29YJdmb8cSP4TjPp+K2dg1XLo6AjUDg2qgJFubhEt2vYxn+olQOaXc64UfQU
         uglnYOayXaoQlK5n5FXpffMIwSCx6CL3vSPM8N4Bw7qV8zaTqrBP49Otfdrh4a8Qd3Yf
         r5PSznWH8wpgGDEshvVs7jHbUhoI06vHI1w1e2hNJLX2Bs2XVSIRtE5PU1h/25/JH3l3
         6PbAj9ItKezaYdxh1Xbx09vIj4N+kEdvp6zDps9KNp6qHX3mn6FsB+yXfKFLQDV+ZezW
         fwBa8rVxNZsKXMICLKvNiafcSHO4YPuZbYEoclBaELXqo9XOiDmctJ0p1aoWYX4VTof/
         hKOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787651297; x=1788256097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        b=GTSc92Tc+E5z0mmzXiJpL9PIsw2+YRSGDHMWEa8PWYNbVHtOFjKtDd4mpphj7RDVOQ
         Ci8aLxb/PWbRRONWrkNT0twBFOCsQi0tjjmlzStv6z3O97FuHG3G1xtvLY6ROg3kqT+N
         8R35QxRxSVs9pgGHaeUdW3pMRuK4S9jDtvfOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651297; x=1788256097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        b=RL7GgGVvdjDtQdkxLJejbGjZkDjeolBX4mCUptIlXWPWnUOtMBoTvfIN6JogHvJSAt
         c2k84WKShUIyXw8g1MN64gwSnJ9vxlgxa7bPJKr0wjwsfLztVXh5bXg2Aknk9abnn4mY
         o5DHa50/DMzzHx/CDQocVaaQYwOx+l3EIs5wq9r7E6bg6YHpoCdTRrTvu5/Y+vFgbMwT
         /4IWddCf4bSnlZoRxi425Fulwb+xE7wc5roxzl/RmAKAc8yvbng6Flelis7gJuGml2ks
         d9RVBdUExGhKDLZBxwI9QwBdQVTPJQy54V7T2datfczXPZIxKWUNDvlDMuokcwA7vD7e
         nAgg==
X-Gm-Message-State: AFuF++kmfbgTlogEmcVR2Aa2R426cuY/KKu4dxrXAkGLklNjI2USO69T
	1lejFnWXDtbYwwlbYHUyYiwsVoe54HCPwdXDFnUfKOtvV7+S/eSZ/GKKZj3nezAUYuStsZEEdOR
	l4dpqEsNqD9jGjzVU4el1l+4sL3tVx4mbUD5HSxBZEHxaxurRN0WTyw==
X-Gm-Gg: AR+sD13XGnXRqRY23D3mcWKBAHr5ahrnFZwArshM3scaxmK/vMMFWjA0oP+P+3ca1wM
	BQxAfHco09WK0HqKDfLVMtXtxTKT2DdyZuDMo6lTiP36g96Xj+hZTgEXwJn0IFC3scYM08fHOqM
	nwR7a811cSctsAS8agVQKkkpmH1NDS5lHw1GA8niDDx/KQ085OSnuNXgNoV2uD+ynPn5iuZkNsZ
	R9L8oYaUEQz6/O86f3ghkeVudWwtioVMP4RoE2gltxNdon0R3Eff283KmVu7ZGN4ACtfAqZyq5c
	XecmGw1SwhOBSKh2oXlymeO0C5JqmNKKvj1r1IqV6f1Q+0w=
X-Received: by 2002:a05:6a00:4501:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-851f9cd577dmr55115904b3a.7.1787651297483; Tue, 25 Aug 2026
 02:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-5-jhs@mojatatu.com>
 <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com> <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
 <4d9d542e-e25d-4ba4-b7c4-e51c82f3732d@redhat.com>
In-Reply-To: <4d9d542e-e25d-4ba4-b7c4-e51c82f3732d@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 05:48:05 -0400
X-Gm-Features: AcwNN1Ubn3mXrXd74Gl8HB_9tEsOtT67tVDajCH4VoPlfAPCyeZa98UYpBCm0kA
Message-ID: <CAM0EoMnCC4p-nk-VxR_ard2E6na3_fZYd165iOyXQM35QKz_OQ@mail.gmail.com>
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

On Tue, Aug 25, 2026 at 5:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 11:16 AM, Jamal Hadi Salim wrote:
> > On Tue, Aug 25, 2026 at 4:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> >>> fq_pie_init() sets q->quantum =3D psched_mtu(qdisc_dev(sch)) without
> >>> clamping. A device with a huge MTU (e.g. dummy with max_mtu =3D=3D 0
> >>> accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> >>> overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue=
(),
> >>> causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> >>> is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 2=
0].
> >>> 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> >>>
> >>> Conditions to recreate the bug: a device whose MTU (plus
> >>> hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> >>> device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> >>> CAP_NET_ADMIN in a user namespace.
> >>>
> >>> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler=
")
> >>> Reported-by: vega@nebusec.ai
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>> ---
> >>>  net/sched/sch_fq_pie.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> >>> index 069e1facd413..b27d95418707 100644
> >>> --- a/net/sched/sch_fq_pie.c
> >>> +++ b/net/sched/sch_fq_pie.c
> >>> @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct =
nlattr *opt,
> >>>       pie_params_init(&q->p_params);
> >>>       sch->limit =3D 10 * 1024;
> >>>       q->p_params.limit =3D sch->limit;
> >>> -     q->quantum =3D psched_mtu(qdisc_dev(sch));
> >>> +     q->quantum =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> >>> +                          256, 1 << 20);
> >>
> >> Sashiko thinks that the soft lookup is still reachable via pie_change:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112=
717-1-jhs%40mojatatu.com
> >>
> >> and has similar concerns for patch 6/6, too. It marks the issues as
> >> pre-existing, but AFAICS they overlap with the things addressed here.
> >>
> >> WDYT?
> >
> > You are right, they overlap. I had them as followups (with a few
> > others derived from the sashiko feedback with justification that the
> > v3 init-path clamps are independently correct and the stab cap already
> > mitigates the change-path worst case to a stall; but those two a
> > (adding max(256U, ...) to both fq_pie_change() and sfq_change(),
> > matching the fq_codel_change()) are more serious.
> > So if you'd prefer a v4 respin of the whole series, I can do that.
>
> I initially did not notice that the _change path would lead to
> "upper-bounded" stall, I think a follow-up is fine.

I will prioritize moving those two i mentioned as a followup as soon
as this patchset goes in.

> > Sashiko is a double edge sword - i think code quality is improving but
> > it feels like the work load has doubled ;->
>
> FWIW, I agree with the "double edge" assessment.
> A reference we must keep in mind is that there is no way back, so we
> need to adapt somehow.
>

Agreed ;-> Will take a while to adopt...

cheers,
jamal
> > Here's what i had as followups (some still to be vetted, just noting
> > what sashiko is stating to be reviewed later when cycles available and
> > potential followup patches sent):
> > - sch_dualpi2 unclamped psched_mtu
> > - sch_pie unclamped psched_mtu =E2=86=92 AQM disable / div-by-zero
> > - hhf TCA_HHF_HH_FLOWS_LIMIT unbounded
> > - fq_pie_change() / sfq_change() 256 floor missing (one that you bring =
up here)
> > - DRR/ETS quantum=3D0 spin (have a patch, was reported already as a bug=
 by vega@)
> > - Consider two separate clamps for fq_codel/sch_codel (nipa
> > gpt-5-6-sol-3-15): quantum in [256, FQ_CODEL_QUANTUM_MAX], mtubounded
> > separately (no 256 floor on mtu)
> FWIW, LGTM!
>
> /P
>
