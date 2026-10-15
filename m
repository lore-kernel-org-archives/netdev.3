Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07F3ACF0F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097475; cv=pass; b=NEHwmCMI+0GLd8/XtDP8VPZzsgvVkzkp5A+MHWyrYJg37FK/cRGfF8+i5UXynuUSeBnsvlQTQyXiTy2dp7iu1brIRgqGDhZ8DY5MrJIYIq6lbkrgBtzp4bsyXPrOpz10FRa5mbKS+SkTsv+X7k7rs5I4hHBT9Wn4KdU75uEmMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097475; c=relaxed/simple;
	bh=2Dt4ze1PRtPcKMOQhYhXAM2HdUXW7CpVLr79L/hKjIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvxz9SfA1rn8VFw16bo80T8XsNKQ6VTmPBgY3XDU+P5MsF92H5M+RmazgnXYXGMfD3hCB+PODOhFcSD1TneEioE9mLTfeGqGzqL7e2foiIc3sHwUavglgVFEqwQzO9504Dvo20LlOjm17TXXdaRyhKLIssyL4tuH7k7uBnSeCZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Z7o6TgYO; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=K8WY3vQ6; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Z7o6TgYO";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="K8WY3vQ6"
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FJbIDN2776704
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=E
	jTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=; b=Z7o6TgYOAwaocZQLO
	RxsZ08glAUbeb+v7CAkOpuPO0q/dOErfoxhuK5uQke00iop+ZU/GfPu9/yjc4K7L
	tg3+W6ARyztVBI6V08Ii3DkMT5A6Eb56P5IS2NyAbGqtR7efsZhcvJyvHpH4pG30
	ixz0BxOkWAF58vdWCzRQsx8gA75itOI7ES74KCkTI5DXmrNfHGS+CN1F62pKlFkT
	xwGVC7QXh2YhkDR6v1Pbm/ZVqvSJcorLcbuVCkculNPfW1Zk5tt7lJXnGFvsXIp1
	rA1OoWfGDpbU739KHDyOJEWLfXUI6oMz7ikerdPq0xZY0r5EDCBd33PU1Nd0L93u
	dz6ZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hb2cvmb3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:18:35 -0400 (EDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3580c07911eso14740269eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792095514; cv=none;
        d=google.com; s=arc-20260327;
        b=CLzCS531DxxZxaIgj6HeDuqF/yrOBeH2hGwAfajPR9GDlSsRxW9EIrDsHClmWayNbp
         2V+NvjrR6CaqAejLGsZkDJys1uuNeiNx8J0/njj94w7CYFZqU0Bi2X+wmjnF5Y2O4hwF
         FFRYfyGaGO8zBGXNzgCKuCwHII6J9mtv5J32o0S0asLHqyuWJ31of2sV4CS65S7eYeIE
         CP+UycfK+yzhb12ZYpZl/0ghoBS4gpveJ3E2GyAWltpytoNNrkHSxi0ydkkYB7zgrMfr
         qUSrGJO2Ab+l6AlC9x1gDoSvxuzCC/cn2QORoZJ1l18wz1p8NNsjvFiV8QYGqqTp/frm
         vvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        fh=DreVrW5SquBBpyw3dK8EUdwxdUCyZkExa1SVHAbH+n0=;
        b=PoQuOPX1/UawpZgKFYGZd94yVm2buMMtvVh+aqHe3o7ZeWXyDJd8kv8NJpfTkV1Wjj
         Tv91R9ifXD98iA9d84xBMzXcOmP0nqK2By5CsZn+RnDTGCKZcKSVhBhhLH7hZYJNJGKV
         s3VnkYpFs6b4CrfCZWUqeUl6i8bgOXitALsPWYmtcW8IXsbbIgi+uubjvqMgqp4X1yBm
         hLo10Dk/RcEHpvypC9SDpZC591oNXTsWCpPFpf3FdKpcq86PjWNZ0RmAHvx5ftK52SQ4
         Iyh3DWALwK/aOuYpTEFfjLQgNlunsUX5jyhssyVO2wmTvIV5C8yXAKM8jB6baIaA/ifu
         Jt7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792095514; x=1792700314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        b=K8WY3vQ6UZoCX9/UXiHzZ1vOREfRJRlDPOY0vkrjGHoYIt8x+MPtath/6jW9mP7hZ+
         f3gzP71OopiwjZNi/RDL5f0ob0VZw3texzFEIvyo3ls1RsBdU+eW7rN+16VvP4WeEXEM
         Z1pL4bF2PqgUgb9HdKKZssvVSpIncBajOHNmGkH1iHWIa+5aM913PDdEBxarzMkpg1u5
         1rzXfjIAnUFeBU/T9N6vNMHbnXEOdojAKA8GMJSS8z3E3CL5Jxin9cU5BZ9vmtgHJ54s
         gjzptCPihKnIKSjXx43JV+V1mPFXUUz53HIl+ZgjK/YJ4xqbRPxzJscXiJJgui5Pc0Nd
         6hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095514; x=1792700314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjTzUdIh1JiWqCTQbTHIx2EY+cLBJ9IwG0EzO3Un/kw=;
        b=OZxTPMwUnrdBx54j2A0bsPV5PMNOB/eP8SjGYdhpWO+SqGi/BFxdmgGk+MISkpIFno
         c6yxZ74UvYei/C78cvjvr1W1cQ7ylf8bS3EkbfFs7Tf9QkzjPrFUAgT3OHQ/golWOiEN
         jP29zQi69IJSp8HHQgeyy5ZK6YURC+ztmyE74bLUKTrA69ji0H1VRe4a5RJ6cSWD1wam
         mvIKNrMsFGkk7d/1FJouB/jvWLvVaeopRA+hZhb2PN//VeLuCdqXUHjlGTIiXtW1kYez
         Bf6wM+IdnPW8a5rmvzWNrSKoynWBqDaIz7qgGkKADB7g67fwjePaFdwWLRjE16D0vqsI
         Dghw==
X-Forwarded-Encrypted: i=1; AKwUvByzFVxlSsoN6J8z80Aa+bhY20leJFu4UOLtE2kH1xRUE+ppNuI6xx8C2b6yA6WJOl71A0gBNWQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfQ0pBB4xnAhORydN7wS86jp/C1wnp5dAfu+cSQhJedPMmRpL6
	tnR6ExLvpAMuctH71V22ENtlV5awd1gjX5ajUxLBKcapfugsxQZvDdtSdAW+mfI+B/2lZC7o8S1
	ZpC58G8ZYUM/p/0GoNxLhFeFizpm+/7FrtcggR9DuEU6gHtVkX2+mPVJhzvAa6y81Ni8d77mOfu
	yPgcHmUlb1OmbRJ62JvuXFdcYkediXqg==
X-Gm-Gg: AYBFou1ZRQ3uIyyovlyPMooAcvj/UXRTR4iceExrIrP14vTRLo7QtkQouGQeKizxGXD
	frCREtiKtfgwCL/F8VKRKX6+WAtmSNHVxZ2mRg77dAPgTjqbhpie5InsiSQNlDfRd2AGOSu9/cR
	sgZrfSzbt7DSxKpWaxndDv8EA36HouTMguYaPa0rzfC9z3fDshsmiIkvvy9g==
X-Received: by 2002:a05:693c:8381:10b0:360:444f:a56b with SMTP id 5a478bee46e88-360444fa971mr1156941eec.12.1792095514081;
        Thu, 15 Oct 2026 13:18:34 -0700 (PDT)
X-Received: by 2002:a05:693c:8381:10b0:360:444f:a56b with SMTP id
 5a478bee46e88-360444fa971mr1156906eec.12.1792095513407; Thu, 15 Oct 2026
 13:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain> <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
In-Reply-To: <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 15 Oct 2026 16:18:21 -0400
X-Gm-Features: AclHuK_Gij50KpJSzBvvPkxLcAi-zGcFI58uFnfwogGtPPy3-y0tsgfoZbC6PZ0
Message-ID: <CAPqbLS1dK9wqSCtDGJx=cYTJnO8PE5YONj3bykomOFuGDyYmRw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qMteQp4Gk7-uj0ZChR2VokoWjK9ErJMG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX6zQfDQFtJhIK
 1ZJ2jBfByjzEG8eSnt+TwuhOueYjxWYxwmLbZhuLVdAcxvQHAC45FsDpm9HONTW5TYhjoVqd1/p
 bi/AMk/s6sJMXj8+n6xx2iIk3oi5/oc=
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6ad1351b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=tr4woWNwjDflhTIOjkZU:22 a=VwQbUJbxAAAA:8
 a=GMUWeUELocx5WyZuTCQA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX/lms7JjkFAtq
 DgbU1eiCynNUMhV9KghJ7SzwiD3XIu5Ds1YNJQC+RsZugVASlMgHHE2aTlMawBloB1uRz3on84N
 8ibAPfDTGBgbZi8JE2g5CL9PoE1le5j6rWg5cT/4mjdtrnApuy5ZJbTaUrfL8fhBHRlf8B1EMmt
 Ayy6V/3X9oX+CFdWrwJKua7gyEbvSmpw6Zl57y+Ez5Sy0pwifrBWP6rfXqflSsKcKEH2C/4KC51
 GZgRrIkS7CUgBATCXqo3uCSN+6mL/FMl6llu8pxN3CGRh6cOqMUmUdFaICEHzDxP7+KaUVtxnAu
 wud40jyI7/NEqv/XRtNR0q/TCuVvHJNkqp+Uf5IODvhLFIt/Jmljb9nQdBOVNObGkuaOXMG/Enz
 dU2NbZ33+bR00fDwERZGmcHknSkM+3n2W8lh9ZaoZ+nByZa3v3PtrZ6KidQCFBpkpwT4GwsZF6m
 MxMr/2EZigtJfcfPx+Q==
X-Proofpoint-GUID: qMteQp4Gk7-uj0ZChR2VokoWjK9ErJMG
X-Orig-IP: 74.125.82.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150080

You are right to point out the refactoring commit, 814d488c6126 would
be more suitable for this.

v3 has been proposed:
https://lore.kernel.org/all/20261015201549.4023-2-kj2864@nyu.edu/

On Thu, Oct 15, 2026 at 12:57=E2=80=AFPM Jerry Jiang <kj2864@nyu.edu> wrote=
:
>
> I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
> tcp_snd_cwnd only would just ignore the problem. My current patch
> should completely reject the user from creating a socket if 0 is
> passed for RTAX_CWND.
>
>
> On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kernel.or=
g> wrote:
> >
> > On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > > This could lead to division of zero error if not checked properly.
> > >
> > > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > > Call Trace:
> > >  <IRQ>
> > >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> > >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv=
4/tcp_input.c:4440)
> > >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> > >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> > >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> > >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
> > >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
> > >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/ne=
tfilter.h:319 net/ipv4/ip_input.c:262)
> > >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.=
c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) .=
/include/li)
> > >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
> > >  __netif_receive_skb (net/core/dev.c:6410)
> > >  process_backlog (net/core/dev.c:6761)
> > >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> > >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> > >  handle_softirqs (kernel/softirq.c:645)
> > >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/sof=
tirq.c:758)
> > >  irq_exit_rcu (kernel/softirq.c:775)
> > >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discr=
iminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> > >
> > > Fix by checking if user pass in zero as parameter,
> > > if so reject the value zero.
> > >
> > > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> >
> > This looks like a refactoring commit only, 814d488c6126 might be more
> > appropriate but please check.
> >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: co+71b6509cb791e531@bugs.sh
> > > Assisted-by: LLM
> > > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > > ---
> > >  net/ipv4/metrics.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > index ad40762a8b38..e83a129a25b6 100644
> > > --- a/net/ipv4/metrics.c
> > > +++ b/net/ipv4/metrics.c
> > > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx=
,
> > >                       NL_SET_ERR_MSG(extack, "Unknown flag set in fea=
ture mask in metrics attribute");
> > >                       return -EINVAL;
> > >               }
> > > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be great=
er than zero");
> > > +                     return -EINVAL;
> > > +             }
> > >               metrics[type - 1] =3D val;
> > >       }
> >
> > My understanding is tcp_snd_cwnd(tp) can return 0 and then the divide b=
y
> > 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> > tcp_snd_cwnd_set to not only warn about invalid values but also reject
> > them, preventing similar oops?
