Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036723B63E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118088; cv=pass; b=nbZ7NHYtfLcMWeJNDO2p94FtuMKeXshAx4aVx0mCCY6frDfQ9GxTR5ZlIzIko3ldhfoXbRTTMJ+Yz5ZQrnX/VoyF8t50YqjbdyuZKA2CDVnKNQGyJDnPd1SollXsH9q1QuKGs8sEWdwH0BPVSxSp7ZzM8nhwx2r8fI9j6EdGD/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118088; c=relaxed/simple;
	bh=XDBzczrpRKL5wW2m8rH3MwCjVwBPwTkvMYmzDIeq6dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msC02lG6OLRuCVTA0Ubu5Cq54fJ8n9cd7pDTqNl3/3eAWq8myD6T2u3ZI1H9S+yNz8YP+a5QaOcIIcZ4X5Tjn/51TY0g0gwVnZrrH5z3KIGo30+/oI4VuFth2XHI1CUJcNcD1o310GjgUBRGAxEnGgFWqH0P8JHDi5xHDYrIH2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=IRf3N5M2; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="IRf3N5M2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa69131836so6415650e87.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118086; cv=none;
        d=google.com; s=arc-20240605;
        b=Or9s2YElscfdCyliGhwqRTYQ4Q3OPh8jIguSyTV5TkFUGjsc8/RdeczoxsIajT95Q3
         mEwiGUhCCW5KkH+H8ASA4pRlA79IwCNR0EVc19xpsHzy/0LWlxUwMKdZ1lmRdNZhjgc6
         CogGC5lKRghbJEVy8lwDBeIRZBo0lzp7/s3tMTeReoebeyo2Q+h3IHd1oepkMj/q5Bgt
         4KPX4PaywvD1UbtMtTSBXfgkiv7T5O8wiB80WDFES/vW9mBJJbGbnFCxdkJZFwXGBBpw
         uS6gVFLrUSDM2EVLBvS41AIA4AE/ENxtxvSWK6sXVVpRRfKjOxnd5gzKlxxvG6tosyx0
         CC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jXv+2mQdf4c6FEna05X3D5fAwMwuCoScbvcyZS3m9n8=;
        fh=m53zRXhSW4rzEzJwGmVjHT9x8UWC6lnUKlo6QEg8zgE=;
        b=D+ysQYMMAcsu9Fiv8RPHbrAN3KsTWgx3AkIMj5KCDHTP0NBSe0GwrlS04qZ6+UVVEO
         cNgZtB7p2E/r60h5cZLEAkxAC+qxeeshyWIuJcGNLaRN46PlGfhL17JM5GZaU+s4DETX
         Ijfw6Fs6tu5gflncBj5WLfE4/Z9h0TkuNyPG5Frvx6r4pv8h0w4PiDoSrIXjUHJm/85y
         NdhxN22/ioA2EaSJBHJb5t51F7oKw+t6epnPs9WzmOUWBGGwGi0KR+TIn3qrsUkJiclC
         rllJbNg9LS21uI4cd2iQxlG6X4TTFZUdXYGVYQpJIxPRTQ/IZlDMrZZ87/Wq3jBLhFNG
         mwaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118086; x=1781722886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXv+2mQdf4c6FEna05X3D5fAwMwuCoScbvcyZS3m9n8=;
        b=IRf3N5M2A4Ls8SCUs3y6wl/BJO/Q2tjuWWEGw0Hi7DIYjSUtKoF58sAtJCDXqWv95q
         Brwt2sx/Pny/tIm7ZPMWxGzB0tHUUqOVDa5Ignv/VyTxjwuokgoeThoOTCONwU+okvwK
         2X4h9z5XH2cxlygt4RuOexVJEfvz23sWNi3MFBm5Zbw0pcurs7FasparsFvVps5ZY5bA
         u2Uc+l5V10QqDZ65cziD67alZpuTgCSXVFnm2TOwi7LHzlScQphHgcwKhQjG+VrhAFpe
         QhhhfXEaadTmJsnn5TNph2QgcBUAxGWFktOniySIUooYGbRBMQM/6yxbQphHZbVQcPn5
         +b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118086; x=1781722886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXv+2mQdf4c6FEna05X3D5fAwMwuCoScbvcyZS3m9n8=;
        b=J6t2kl+CTEM/ccTlGD8Vt/pcEkbiqFqB+ugFMY5xQZEuKVyVduBvFCOE0+Ym20Rf0D
         I/uUhXwVmhki4TkyvfbctdjRR+a9jE3e9/6sKrMBXTEa5ts+6uaS0M1vGH6+TJ5s7jqb
         KEUof908HyV2chYd+qhhlmGJDED5W6219iEhXi1iIyRu2afo6On8iUG+UUCeU9vNNlnb
         svkWAV5+CHhW/O4MdBCIvS8WdGAXFL4qIEpfXk0VXiEPfNzIznB5pnDb5TQFswDCkhSw
         nOuM/e86ChiQSOk5Pr0vsLtWoCKd2/Q+Ix4XDZ6pvG0cZbtc8hZC7w5UDFOINxpS/j+3
         hm1A==
X-Forwarded-Encrypted: i=1; AFNElJ8CsJXFUqqOWuhiv16qGWgmTtDDgd8O87yaG2CoyUJVwqRApZPpLBPjLh/Ty5eO6MZ9ekkRgVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvfND1rjOuLIzfBzeiPMyIC/mQ97lkinTHY+tEaszcDHjjjHl
	ayQzTE4s7JvK6GTt5YjOm6ByXJhN67myxcAlkYlno1B1ZQ8r5tIumJxjPNN+VoTMIgQOrEvJGoU
	lk/meg6yqd1ctGXGT2PANAdBCq6rcPRAqTX46a2f3Dw==
X-Gm-Gg: Acq92OHvpgztvLbmIybsIZ5+rsYkQ7wtrHHXr/Jo6FB5SZpTRHLaOTkhAXewDLJ1HH6
	HYyfypy2Vzh2QcylPypu9z3AGaKGHQCPiJIroD8uemGybzoXp/C8EPw9kDCLyXMEMg7Yh7FSfeb
	diAcuua4gMynxsyeTVCRGm/o0Id9VvfXvTe6XZkHRRmATI9XfWjm3mB6qup0Ki1d44CKLyGGUC4
	TwF8F8+v4iP0FPIch2sNAKoujP8g/4Q75huF2l88SCX4g4pXPuBx+ltYuRp0hIW8e+fxmowUgOO
	OP30Ec1n1iqeJBca
X-Received: by 2002:a05:6512:140d:b0:5aa:7779:803b with SMTP id
 2adb3069b0e04-5aa87b8a6b6mr8079636e87.5.1781118085763; Wed, 10 Jun 2026
 12:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608181348.1146175.b644bbba93da.act-nat-non-ipv4@trailofbits.com>
 <20260610015057.1474491-1-kuba@kernel.org>
In-Reply-To: <20260610015057.1474491-1-kuba@kernel.org>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:01:14 -0400
X-Gm-Features: AVVi8CfT8Te6_laGM7C9y_p7VQNUJ1u04TaRCLCdFsYLJQnQ_e1-AtKjP-_Urqs
Message-ID: <CAE+C+DbYWg7fM2yXm58+kKNPBzpcJ-5L6mzzw+GUZHkB=chFsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: act_nat: only rewrite IPv4 packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 9:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/sched: act_nat: only rewrite IPv4 packets
>
> This commit restricts act_nat to only process IPv4 packets to prevent
> non-IPv4 payloads from being incorrectly parsed and modified as IPv4
> headers. It adds a protocol check using skb_protocol() to skip inline
> VLAN tags.
>
> > diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> > index abb332dee836d..cb3e7a415da74 100644
> > --- a/net/sched/act_nat.c
> > +++ b/net/sched/act_nat.c
> > @@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *s=
kb,
> >       egress =3D parms->flags & TCA_NAT_FLAG_EGRESS;
> >
> >       noff =3D skb_network_offset(skb);
> > +     if (skb_protocol(skb, false) !=3D htons(ETH_P_IP))
> > +             goto out;
> > +
>
> [Severity: High]
> Will this check skip valid IPv4 packets that have hardware-accelerated VL=
AN
> tags?
>
> When a packet has a hardware-accelerated VLAN tag, skb_vlan_tag_present(s=
kb)
> is true. In this case, skb_protocol(skb, false) evaluates to skb->vlan_pr=
oto
> (such as ETH_P_8021Q), causing the check to evaluate to true and jump to =
the
> out label.
>
> Since hardware-accelerated VLAN tags are stripped by the MAC driver,
> skb_network_offset(skb) correctly points to the inner IPv4 header and
> skb->protocol already holds htons(ETH_P_IP). Should this code check
> skb->protocol !=3D htons(ETH_P_IP) directly instead to avoid skipping
> hardware-VLAN-tagged IPv4 packets?
>
> >       if (!pskb_may_pull(skb, sizeof(*iph) + noff))
> >               goto drop;
> >
> --
> pw-bot: cr

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
