Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC93B058A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273945; cv=pass; b=inBggFRfQFdKhTR5H8hIeK+haxPWUoYy2dga4rrCHTYph9JDNbshAJQvuV3YFujeZfuCcN6wJrqbpCoKcke4sg6pJTrTOAPCCVq/cvRo7wBIVoX31QT0bPsjit1tUv6c2QzKIyWFcbML++1pWIdbkSsgZwZNx89uRK+3hh7vrBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273945; c=relaxed/simple;
	bh=2z49YO454x+6uu0rrqxdOYf2rOaScddUZyoqUeAIaBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoD2Yup9n6wmrFSz2HhFhtsAzZruP1mI/OSsu9LGAMlIcN9o//1U4AkkMIAc+G1ytLX8YdihrL0KqPSnesJN+DmnXYZ7ivKyO/uKp2Jikm42NsR1pFitwgtcld3hLHygiP0lkSYlQJ25fTWs8kvnU+iCtKqQngmzl+AhfYB0tZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=k5GDwwz0; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=ma9G2Oal; arc=pass smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="k5GDwwz0";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="ma9G2Oal"
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HKhxHY1885280
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=s
	LoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=; b=k5GDwwz0SksfR0foN
	zeOQAVNr0qigINCmH47KF3LDZHH4QR+xJxgzSfVVnXFifJqBm+XL2MYTq4n4UYVC
	swm+bd+QBGfKF+TQSndFVcjnegFHXZeFp4+rtBHIod3ORqtbChfixDqUG3FH0rB7
	SslL5A7gY6L24mKyAeruDMtLc3Sk6yozF24+v8Gb7YY2lJcE94R/4XEDQhMBToIa
	Z9QF8YXt3a6yv6Pk0veNwzQ6BgmZYkA5KLxaDEWCchpSVwOr5iI5SSLKXxQatgMY
	V/e5paQHUhZtFUOYIsTrpW8ad46llDUePcIH8mu2+CRzPMny+Fjme4qkXvQlCEnX
	w3peQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hcgaj0ebe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:52:23 -0400 (EDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2021606eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 14:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792273942; cv=none;
        d=google.com; s=arc-20260327;
        b=MxktwQxigwfHEkpglnW6O0TfE7JWXOgaRSNkE8gWQJu5vzC40s1xe5dnigQC66Jdsv
         351pa7SiMamwTNQc1lFHgtfn68T1mngXsk4/4/8ejTWM075Hf+Q5FRnSuWhGmieNnZRH
         z55w0td41knVJ6mCYaE3oTqfdsq9Mtigt71UgC3F2aBiy9Y2xqyfveLqyPRNxfPh0ZGV
         xT/quWXUzn3dtkCyKmoyxwvDmhD82ZtbGU0VccE7IR2cP1Am8IcL7pyntf86QAZ1xsy8
         z0uKrP+6MBcdGXQ6RslKKSX70DfOO7hHvPubyR2Nhhej7J/YpNRwRlTTn2CUQ3k/IrB+
         0e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        fh=9PKFayLlaW7tNKtvUX4K+IMb3GmKo8QjVmRpOHgyBh8=;
        b=scmjD6WfGMh0hXVGhEjBeij4XZF377Vu6638z+4c+N3DvlNctn2vzrG/c/ji6ezrJp
         Mj9kZBeBJbbNf8uyrA4oZUL0MYZUjcNlEfCutWQUqfaS0fXstXe2IdLvLnR+77CslsA1
         DOfFsMVLjEMdIsBPiiprrI+BqlNOPMspTdgSSEB7IX+Lr/D11E2Ql4/l/mbzG/RS1Phd
         yD8vxuT6hTqAP1u9OtnvDfIaMmL7xDy+d6JwORcJGHHnzAC81+iTpNOc0vntUhxS0Li7
         4GucH4JpAwao2PaUQo34G3t4iBMtvLVX9oHv9p0AqWLjLWDt85I8oDfgfv6y7bCYRt2x
         SEcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792273942; x=1792878742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        b=ma9G2OalTq1NjVjlOQ3DE6iYAMao5P5q1KMiJVC3jDy3gNo+ec6/rwTcifBOVI2nM1
         BcdqfdXRxVdA2im1pA2MpnDHHHlLcyx3BrzALEviybJ4otMWcvp//7iIidLmA3p3JVlI
         m3tow7jhHjvXRsx18SZcC6kq5BDc0HV1QZOwm8UhQX5x+JjVVp/sczXMCI2dg1ZcVw+T
         bQ0rjZhHEKYplrA45FBSqtX1oI+DG5ToPHeZttgT3fItZY3Sf9c7dQiS2BIca1jlgj6D
         NCzWMEDGAQwfOi1kLoN1uehFPDj9/WK9NHgRPb8nhGj7gMpajDE/cngHwpQm5XOZLscP
         nrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273942; x=1792878742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLoXZ4zrSuG0DF9gDAxCqxwkk2HrNuzfj+cEZxHtwEw=;
        b=znPEbjfmq23lxTiBoTPjFevuFsoIjrqLRXEOTkIV+UNBz3hGye57gbm5vI7bSIYycK
         JDJ93qeL072ilVURuxfqP1j/oMwW5IKZWGSD2E9ln0HnZJWoM8T6p/Rg2iM9YAQXrh5M
         Yw0NbWoUSITn7lOVnX9j5tW4G+SZcyy+wlGk9HpMNohPhaiHFs1Rz18hIou8yRU8OAAM
         BsjYjCD3qVBM1i/y6wlLLOXqAqGI6fsI92Bqy/XO/kPrAtjnfr5FTZNGtOFrl4L9SW3y
         Nzs81aeOa9AAz7LiH2sWbtZJCSLfn5hTrhK4Vw62Ui9ZKNqZZx67OFeZH6ZgqMZhoqOO
         VN2A==
X-Forwarded-Encrypted: i=1; AKwUvBxZGiZ76p1CEdRJRJfVYUxwb5KivQySb6IAu4Bu4wMrloRNFIuBgEsiP9qzHpWPCoZnKqtn/yQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJByXBjdUXbjsSGoFgREy3k2lWI+a3aeatdrmM4uY5uxyudyrlR
	BHrjj5U2HOtKVsftGdTkNZZfetY5f+Qmxwl+1GfgioKQfE0KiRjsFwmMPWGUAt2wgkAsQB7pc4K
	2TiloLE0gGZQWLcuML17u9aI+rUJJuelMIbaRu4y/F9ls3aK3mk9M/MkLv+FLxEXdo5AZMZu33X
	jRlehj5NCtc1BXNJ+Q+OQt/tH94z1BnA==
X-Gm-Gg: AYBFou3Mur8AX678Dj1hfHQ2a7qNYJuzPD6I1o3qHd4kjEYZk9xbDiiS3CRKHbMUivz
	5BuK3P1VvjXqjBlRSriZPcpiwJ/NE4MEUmjueQ8c2S6jblumu5pAFAsSaa3UgTZ+uH3c3B0qbnj
	SrpIM3JBZVedU1zJOkT5gY88MydVMIgtuDVEuy9HMZQvMXjQ48V3sHBDNDaQ==
X-Received: by 2002:a05:693c:66c1:20b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-361a264acaemr5212524eec.38.1792273942135;
        Sat, 17 Oct 2026 14:52:22 -0700 (PDT)
X-Received: by 2002:a05:693c:66c1:20b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-361a264acaemr5212420eec.38.1792273939584; Sat, 17 Oct 2026
 14:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014195640.430824-2-kj2864@nyu.edu> <atCf_85Ei_J9CDtd@kwain>
 <CAPqbLS2sM9JZ8VbrzWviV-6XNRniKib_L+seaKtnCfR3pwMMig@mail.gmail.com>
 <atHQupHr7_ocAJ_A@kwain> <CAPqbLS0XXB53mnymFVZAVodc73r8E52PWRnxSwj6k8umqC7SAA@mail.gmail.com>
In-Reply-To: <CAPqbLS0XXB53mnymFVZAVodc73r8E52PWRnxSwj6k8umqC7SAA@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Sat, 17 Oct 2026 17:52:08 -0400
X-Gm-Features: AclHuK--2zbQAhbE8812SRoKdfqvhlJ6jnYw1O93FmhhB5V2pen0FpVk25aFiKQ
Message-ID: <CAPqbLS1uQ94We27Ot54oZmQ+iEwZfQztmOvz8dDRo3kOCq12PQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
To: Antoine Tenart <atenart@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pbYRXOiueza8NFl_BKzXAcwvBLxlAHbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfX3Isc0d4LruYs
 dNTF47uH4HILRZgRK/mMTFBc+mPpkEykgnjP4laLTHpp6ULsiU6ZbF7OA0k1wS7gM1pTLRq6Uc5
 PKHv7qjmQWZXpfoatrzGhFjcU9Kg1QIJnVbbQPmkFZQZyP6zzkLB+FSwL7RznDbxCAwerkEOpJU
 hPzRTvjN7cTHdI9iMT4pJauLpMVw8rSco2Qsx72n2753XcTQbQT6S5gYmYIeL3e13n1kKD3eqMX
 HYJhF7bTfmQToGqLkkkltrCMzKPyJ+YV0CPkWqKweR1OdzE3qdHLjYSNwCj59T59JHKRgzTLY+E
 lj4ucw+Mybx9S6jNHsaw0XNP/zrnUxxfD3wwGZbXWUQ2FEb13NFDglQrQiuprKb09PYwbI9Bnbm
 ds/gxUG/mRHNtS4TI3XJdJKW518i6YnOYyAORszZPkbIYybxDJfkAfQo35L4ZM+tCqmoLJHcibZ
 nEPawFp227ZeZtGhAcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4NyBTYWx0ZWRfXwpV/fL+7sqtv
 q2Jc+ZzE1BGIT7x/vW8+Ls5QkvreLmp78JOtAGDNToEuVr9t53DAEC7AIGrzyl1elmDPH66SBqj
 48i9uH+0xH49fMtz1vUv/ICmuc51qj8=
X-Proofpoint-GUID: pbYRXOiueza8NFl_BKzXAcwvBLxlAHbI
X-Authority-Analysis: v=2.4 cv=RMomjIi+ c=1 sm=1 tr=0 ts=6ad3ee17 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=_0uBWF9-lnOxR1nRej8j:22 a=VwQbUJbxAAAA:8
 a=s1qTDB3tYtKRdSl9UekA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170087

I stand corrected, by not passing any argument to RTAX_CWND, the bug
can still be triggered. Doing fixes on tcp_snd_cwnd_set would be
valuable. One idea I have is that if 0 is passed in tcp_snd_cwnd_set,
a default value of 1 is written instead of writing 0.

v4 has been proposed:
https://lore.kernel.org/all/20261017214845.28769-2-kj2864@nyu.edu/





On Sat, Oct 17, 2026 at 12:12=E2=80=AFPM Jerry Jiang <kj2864@nyu.edu> wrote=
:
>
> Afaik, I don't think any changes are necessary to tcp_snd_cwnd_set as
> users are completely rejected from inputting 0, which could give the
> assumption argument passed to tcp_snd_cwnd_set is a number larger than
> 0.
>
>
> On Fri, Oct 16, 2026 at 3:29=E2=80=AFAM Antoine Tenart <atenart@kernel.or=
g> wrote:
> >
> > On Thu, Oct 15, 2026 at 12:57:51PM -0400, Jerry Jiang wrote:
> > > I have considered rejecting 0 in tcp_snd_cwnd_set but afaik patching
> > > tcp_snd_cwnd only would just ignore the problem. My current patch
> > > should completely reject the user from creating a socket if 0 is
> > > passed for RTAX_CWND.
> >
> > I'm not arguing against the current patch. My point is warning on 0
> > values in tcp_snd_cwnd_set made sense before but since this is now know=
n
> > to cause oops there might be something better to do there.
> >
> > > On Thu, Oct 15, 2026 at 5:57=E2=80=AFAM Antoine Tenart <atenart@kerne=
l.org> wrote:
> > > >
> > > > On Wed, Oct 14, 2026 at 03:56:41PM -0400, Kaho Jiang wrote:
> > > > > User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
> > > > > This could lead to division of zero error if not checked properly=
.
> > > > >
> > > > > Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> > > > > Call Trace:
> > > > >  <IRQ>
> > > > >  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
> > > > >  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net=
/ipv4/tcp_input.c:4440)
> > > > >  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
> > > > >  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> > > > >  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> > > > >  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator =
1))
> > > > >  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator =
1))
> > > > >  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linu=
x/netfilter.h:319 net/ipv4/ip_input.c:262)
> > > > >  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_in=
put.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator =
6) ./include/li)
> > > > >  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator=
 4))
> > > > >  __netif_receive_skb (net/core/dev.c:6410)
> > > > >  process_backlog (net/core/dev.c:6761)
> > > > >  __napi_poll.constprop.0 (net/core/dev.c:7830)
> > > > >  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
> > > > >  handle_softirqs (kernel/softirq.c:645)
> > > > >  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel=
/softirq.c:758)
> > > > >  irq_exit_rcu (kernel/softirq.c:775)
> > > > >  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (d=
iscriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> > > > > RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> > > > >
> > > > > Fix by checking if user pass in zero as parameter,
> > > > > if so reject the value zero.
> > > > >
> > > > > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cach=
e.")
> > > >
> > > > This looks like a refactoring commit only, 814d488c6126 might be mo=
re
> > > > appropriate but please check.
> > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: co+71b6509cb791e531@bugs.sh
> > > > > Assisted-by: LLM
> > > > > Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> > > > > ---
> > > > >  net/ipv4/metrics.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > > > index ad40762a8b38..e83a129a25b6 100644
> > > > > --- a/net/ipv4/metrics.c
> > > > > +++ b/net/ipv4/metrics.c
> > > > > @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *f=
c_mx,
> > > > >                       NL_SET_ERR_MSG(extack, "Unknown flag set in=
 feature mask in metrics attribute");
> > > > >                       return -EINVAL;
> > > > >               }
> > > > > +             if (type =3D=3D RTAX_CWND && val =3D=3D 0) {
> > > > > +                     NL_SET_ERR_MSG(extack, "RTAX_CWND must be g=
reater than zero");
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > >               metrics[type - 1] =3D val;
> > > > >       }
> > > >
> > > > My understanding is tcp_snd_cwnd(tp) can return 0 and then the divi=
de by
> > > > 0 occurs in tcp_cong_avoid_ai. Have you also considered updating
> > > > tcp_snd_cwnd_set to not only warn about invalid values but also rej=
ect
> > > > them, preventing similar oops?
