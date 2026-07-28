Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0D329E44
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273498; cv=pass; b=IshIFyPB1ERb5paCg6oPvxFWeo0B7Dfk+1Ojpnbc4r6PCXVQtYE/xSvAGrzKXKC7CtkE5rZER/+kKrdxXyss7soJ7CNE7zR9RXJaa4QA3qJpe/mHieb5h1zZs3PYxM+EVrDaKdqQqzwvzBCq9bD2oOdcuUdkqi73o8kJ53944oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273498; c=relaxed/simple;
	bh=xJrssxJkw7QPt7xiDw39o+/VbJYqf65Ck8phfNmCI2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOZKlaEcXFt2DAcHsjXIGmgH+GEIZvw87ZHKr89e3Z6NlmdRDOCjGg+en84Fwgs0BK8fFPbm45icWpNSt8/4SWKzHWLCnLknsgTRAbSV1Kduc3vtn23yRsSw1Nmz/6ImEU5mjFGV2iQmOQjQp/coKKDwLMLLou7e0BBuf8s+6Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ISoqdTCH; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ISoqdTCH"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso3332665ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785273496; cv=none;
        d=google.com; s=arc-20260327;
        b=bmWER+kYJwALO4A3ITE93eApsFNPlpm8g4n4EWC7YpwjnRnBXn3auliv829NxqCsM7
         7VzrB8a13xPFIInfDeZIWOkB8iEX5O8s1erPRDmW6BUWxoIP0aHS2Qaxiir05wBrJTle
         IBxvfJWFQm+UswVnOKWrnl4BLVobnGFezxJp71p56y431zPIVohEGNertZ5k+tSyBSCn
         /H6/KQUBK+f9j4maIml5HX/fYwWWpXwbxP2nh9SUBPCvkwl7dgx/YC+FIrwuXnS6Bsga
         5Mzz7iqYJboJYZyqpj/sY6PzKMXuzIcZUnZr8mQks/YCucWKxIdflUbQLeU7BhZjXDTK
         LI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kLhEXM7LzS9viQAgL4Z/X3Om72VS3L3ol28O3eIfUM=;
        fh=4qZ280xUwfL9bu9hVhF19yqGPnvPvCY9nwkXHc6uEPk=;
        b=qaIbK2yjbqimghajm2cnC47q3cmYEnlP31DAvoh7FH2rfePxmnOgXQIkhkUbSXPq/v
         jE0FOX9owenIgEeLUibEL0mVqoKMHB/qxmBtyZdNfeQnHNSKwCkxx/7OAfj16V0diMd0
         bVGbLJxfSE4jqnhmEDAQEMWInomqCa1sWL2GCRsVNnixZSkgW5UXdTeuVTqrzpbJm6Fj
         QlQMQtPNV+Myjmv1ltq1dz4+tllftOyOJIQouf8tvcKsw4B5OffHGHTr6RJeR93lTxai
         ClL3TSIxLnhXoJvngEtYOmVD1+NIHqJG40GucVCdq9MRu/+RALITg8sYOidf8Py938gT
         nbXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785273496; x=1785878296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7kLhEXM7LzS9viQAgL4Z/X3Om72VS3L3ol28O3eIfUM=;
        b=ISoqdTCHrer5lHUsCWZkJGWw2d/7PEyWMMsxIYsqcMWhgtgXOpnsIBiK+t0M2G8UBG
         z4fGSGzld0bXD8Xy5yYWQ16EBT+K2nGbewyFTLvbhTrlIQa6/yyAo/dQ7b+sWqKHIEXS
         lLyzADAfIbBJ+QMIxNAgDJywhTxw2l8l+w7FZTlQRiGl9qb5r4UhLW1FCh8n3JkEyOwp
         SDlgG/gDrKk5zBb13DWlfa+90hKAJfrOQHCeVbkeIKnvrESfwtdJWLrTjsWxwtw3toIZ
         E37/OzhVlVW6zku7C3hvibfBU95W15tsMoN4Z5oVdNm3grTMLHBA0U4RMF8SPd38heU8
         8TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273496; x=1785878296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7kLhEXM7LzS9viQAgL4Z/X3Om72VS3L3ol28O3eIfUM=;
        b=NBWco8X4IOT/YNMpMHl+6SruRpHzbJwjdRFc5GyTOqq+TfxoKQdf/lGdhWCm2e6Xe3
         MBkI/3Mprb40sITFfuHVJmZb3rw8/37FQcTL9aN6OhTYA3OWVDjvLZY3bEvOSLam48ky
         SR8qO2PWoGGlgFgOWTnVKej0jZpAUFq9FEwApMZzLF76WO+R0uRxGBo8uX3vYWIWgkF7
         XbSctBMzwYPAeNmLUJ/FKh9XNjRvVcszDv1JuTN/O2mcIBuR9KyQkpSB7oqXc1ZOepcZ
         UIOcmxOS7Jr7wnpTgfU36DtKDs8i7TJTp4tjG2rkhybI8MoJs6dSme/PgsiJdNk3xvyM
         9dBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdFH3Mm44/rWFBIZJShGkINEhCoqA43gkijIYPFJnAvCIccW+whkmrfimSeK/ahO7W4DVCnag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ps5wG5tUmlOepOrK3xAyOUK9qcsKnlguNnwh3rEP5KGI2veT
	Sq+jFc82gIIehL3BQbMu8KZFs2TPZTKFHTE8i7ZxWF85P4gnfIXDFMPAM0CLZfb8vpgG/RFwHHZ
	UMDB+lm/If+qUphLoeqQFvh+6vfMC7cCYVPui1OIUGGdwN8zo/QiTkhdP
X-Gm-Gg: AR+sD11d2OIKsYu+8ZtrJ3ytJcWbG8ump0hPmh8EhLWPcEfYkpcoaC9X93nzDnComLe
	unqrX/1vCnvDWulJZnMaEEkdWm6HRbaSayMeSih0A2LSkUzeQGoKENLDdRfBM2japiLDeQriNxQ
	/SZd9G3VegiMx7hlCp5S+7cAHVwkHhn5y05qx3r016vG7imYQdWnDdGU3RIyPXhs6LVHmTLd79Z
	VsSfJ/5Dg/OmEjrwJwLKD/xaY2d/Eoq+vEiVxFONoVjb2kDhdVho3HTIflt0Z7VIyuqdwzoR1MP
	xPo4BbawJoH1T5o2ALT8MksJc7fcMkHFCO8dzghkVWZmUAS0QuOlwO5ZDNEHMZEeMqCMNFtrD1C
	6
X-Received: by 2002:a17:903:2f47:b0:2ca:ed57:8586 with SMTP id
 d9443c01a7336-2d015cfb53fmr47675205ad.23.1785273495964; Tue, 28 Jul 2026
 14:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720204430.1886091-1-xmei5@asu.edu> <amJN67Vtl0atkj7H@chamomile>
In-Reply-To: <amJN67Vtl0atkj7H@chamomile>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 28 Jul 2026 14:18:05 -0700
X-Gm-Features: AUfX_mzhtSPiNGlqR0fbcyX7IYMNBYn4RAbiTl1aN4ldNhEeSyBDMIEwPCkj2GI
Message-ID: <CAPpSM+QoNMARuy+Lr_=oexFf8+V2Dfe51V51i6+QBUtL6eO7Hw@mail.gmail.com>
Subject: Re: [PATCH net] seg6: fix NULL deref in input_action_end_dx{4,6}_finish()
 after nf hook
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ryoga Saito <contact@proelbtn.com>, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:22=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter=
.org> wrote:
>
> On Mon, Jul 20, 2026 at 08:44:29PM +0000, Xiang Mei (Microsoft) wrote:
> > When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
> > the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chai=
n
> > with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
> > the lwtunnel state via orig_dst =3D skb_dst(skb) and dereference
> > orig_dst->lwtstate.
> >
> > A hook in that chain can legitimately drop the dst: nf_nat_ipv{4,6}_in(=
)
> > calls skb_dst_drop(skb) when a DNAT rule rewrites the destination
> > address, leaving skb_dst(skb) NULL. The okfn then dereferences a NULL
> > orig_dst, causing a general protection fault and a panic (the fault
> > happens in softirq NAPI receive context).
> >
> > Free the skb and bail out when the dst was dropped, instead of
> > proceeding with a lost lwtunnel state.
> >
> >   Oops: general protection fault, probably for non-canonical address...
> >   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087=
]
> >   RIP: 0010:input_action_end_dx6_finish (net/ipv6/seg6_local.c:912)
> >   Call Trace:
> >    input_action_end_dx6 (net/ipv6/seg6_local.c:946)
> >    seg6_local_input_core (net/ipv6/seg6_local.c:1621)
> >    seg6_local_input (net/ipv6/seg6_local.c:1643)
> >    lwtunnel_input (net/core/lwtunnel.c:465)
> >    ipv6_rcv (net/ipv6/ip6_input.c:351)
> >    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6165)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane=
")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  net/ipv6/seg6_local.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> > index 2b41e4c0dddd..45e66ba306ca 100644
> > --- a/net/ipv6/seg6_local.c
> > +++ b/net/ipv6/seg6_local.c
> > @@ -909,6 +909,11 @@ static int input_action_end_dx6_finish(struct net =
*net, struct sock *sk,
> >       struct in6_addr *nhaddr =3D NULL;
> >       struct seg6_local_lwt *slwt;
> >
> > +     if (!orig_dst) {
>
> This should be:
>
>         if (!skb_valid_dst(orig_dst)) {
>

That's correct, thanks. v2 gonna use it. Two small notes.

skb_valid_dst() takes the skb, not the dst.

The lwtstate NULL test is still needed on top. A hook can leave a valid
route that has no lwtunnel state, and seg6_local_lwtunnel() would then
read lwt->data off NULL.

So v2 has:

  static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb=
)
  {
        struct dst_entry *dst =3D skb_dst(skb);

        if (!skb_valid_dst(skb) || !dst->lwtstate ||
            dst->lwtstate->type !=3D LWTUNNEL_ENCAP_SEG6_LOCAL)
                return NULL;

        return seg6_local_lwtunnel(dst->lwtstate);
  }

Xiang

> > +             kfree_skb(skb);
> > +             return -EINVAL;
> > +     }
> > +
> >       slwt =3D seg6_local_lwtunnel(orig_dst->lwtstate);
> >
> >       /* The inner packet is not associated to any local interface,
> > @@ -962,6 +967,11 @@ static int input_action_end_dx4_finish(struct net =
*net, struct sock *sk,
> >       struct iphdr *iph;
> >       __be32 nhaddr;
> >
> > +     if (!orig_dst) {
>
> Same here.
>
> > +             kfree_skb(skb);
> > +             return -EINVAL;
> > +     }
> > +
> >       slwt =3D seg6_local_lwtunnel(orig_dst->lwtstate);
> >
> >       iph =3D ip_hdr(skb);
> > --
> > 2.43.0
> >
