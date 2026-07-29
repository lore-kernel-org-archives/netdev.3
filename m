Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D44ADD88
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333974; cv=pass; b=PD92ZZegoPVzNhgpv6yRi0Ztry70kB/FgR7ksQ89bmAJx++ONNtKrDtaK5HNDLOtedzalvBvQ/ZIBTRBqqz1osMgBgSuWhNP8ENcx4bTe65pFJdYPPaNfpaGKm/toz0mUpCEvqsNoRgRNg0DAsBfVckPsFa6xVvGeZTjylMaPps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333974; c=relaxed/simple;
	bh=t0L6/+neIyKR+lpvwA16X79uo+Ys/nV7SVVkDLtkfUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxJ3qiK1Pr/CeZ9QOrWEmt2NhQNLGxC1ynx3OyBVS3G4ph8eXTRpN0mogXGiVpe8whKkQT7JWbyZa2nrNgxdCep+94rStQWPJTigBFP9PI3rDnbxMHrdHFmInSvHPiHy1/03394csjE6Bml11cG6gPAqG4LqRLzFToRyqq6I2Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK5dajNc; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK5dajNc"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-495e5f0f428so67435b6e.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333971; cv=none;
        d=google.com; s=arc-20260327;
        b=BdoQciqKlRGxHEvn8XmUHdYjwD7VML07PtgKVZ88FqTfTQUZr4xyWX5qTgxx+0MSV2
         XhKXdfDfZBoSSYKRJChzjVo3Zz0mnMpRYpHL00afJSoCOSMK2RTwUschAueJ3TUlf6TF
         XNz5pRdupV4/B3rw0wiIi4LOJB4D+jUMWfncWEOEzNSqQkSs3gpoJ3v9nMkBWn6ZBjIA
         TomnbCLUDe3goQcs7dYYvAGEaxOVFcgnTsHBetwAqZybD9NjEnvlOXhti3xvulnAkNLU
         j6oOnVb3cJtHi7ER2Ntv3CKm9JWwQJkcFtz6DEV8i8bVjp6mGY094F8OoXHg/v5LjpJE
         7QFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8z2cUWZZ1C0Zbf1Dqq5H0GuloWwBhdaF8EVDinxe7bE=;
        fh=RKuy1viP/zt81FStTPFUi4hfpmksvRxeEqOP5vczQ0o=;
        b=PPbZi0dSGshiJyJOI7RKPgjw8bPp3YONMybimr6Vx4HW7vm7INBjJBARRPoz+T8hxf
         S0me9chSXEqH5x1oWnji3EFJBW5kTqFggI5/k4JUux4+bwnRdS5G5uWAGC/xlHooJo34
         e2HkmlOgNDvAbE1daIlC+CnvYgyDTWPupKnftU65Wy6pTB3wBCsa30ON9y+kMo2SmoP6
         rK6HkAYDYqlrTnSdWtqrHdeEXL7EevXascG3X0k1zdkoIQSiySjQZLaw8YVcFbai0KW+
         pRcyICIoI4O2bqH6dE11BhtSRBTCutnciikeRbuCzxm/nrXBwY7xOWSgJowZjfTSnHBd
         N6VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785333971; x=1785938771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8z2cUWZZ1C0Zbf1Dqq5H0GuloWwBhdaF8EVDinxe7bE=;
        b=mK5dajNccsI0j5/ykEm3juz49mYKbIca3qiHbUqzU8jfXW84HNXuGVALn5+sny+i2+
         wBFJ3+Qbo5R1wo5GfQ6ngxtISSXzVj4GCW/VMBg6uK7iBjm6xU+w3eMi8B3zSvvhhFzN
         +Di2RIPVJKPF/uyuMjwDT2szkUqpqDrUS0/6682WivKQzSEvIYV07uSNa75m9MQU7HPD
         XDjPoSNdgvWVA/4onnIfuE9OonasBp6wgBWuPTfc44Caz9rDWRY+8CzIP4Wxr/p9jh2j
         EW7i7l7c+58XeMOkyB28tdtRNNDEinIpuqXmrA8pnAAZp1i1QeJFkQ/6AirL06LJd8sm
         L++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333971; x=1785938771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8z2cUWZZ1C0Zbf1Dqq5H0GuloWwBhdaF8EVDinxe7bE=;
        b=MvHXj0EERIix3jaT3olZJA/75Tud1ne50qMTY9GcEKEqM2lSpuNuOo0l/MadCSq/GR
         lK9Sa0A7sCPOH2mZyDaqRr2EN6Q5waTMJAwzmf58Woxx0VQS9gx6a4sVNMLwijwx8QWU
         o5hThyFGJ/d1bdv5w5uz5opFK8Bgr9HlosWRWtzRWe0bLWieuRVJu47LED2FkpQRi9dr
         cLRV7yujFaZLbGD+5xw4lIzaJmdAn1Td49bKSbYfnv2ltPKDo+vE+bfZGnmvJDuXLzG4
         BAHy4BOPLjPQPThe32pmiTVEx++6dtfQIkuvBvS0CaWlDOVEdWqn6d5RY6NOMpTItA2J
         9brA==
X-Forwarded-Encrypted: i=1; AHgh+RrCf2yoSG77AHiwkZMLqmaNNvBzu3zmyewTjc7gdZWzz/QzV13qeDGYdfTs9pq+Fxu2vkqQh8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUDeLu/968FN71c9r7/BKBCd0SJsAabOoG2sOmxFAKF5vaGdP
	UHHPG1QVq5h/zhReiTCUeky1Pioily9p+PaxKOkOA65I2+VGEDM2hb+hjj08obeXdrhTLaqfJQ2
	1W8Pp6fh3ekN1hjgXXomVr95s+v3/ssM=
X-Gm-Gg: AR+sD10/VjZW6mvr600A0RtMlDxqdWBHm62xiT81oTgSgeW0MeSvSQYlQpQgU3oApWz
	DJDQ9GjDtTSNK0tRTYo8bW8xlLvJuE4OcrbGPSl9yQozB+u5yfC4C3hCz0/dlaiV4sxGpJzvey2
	tULs0vxMyZfRDBFY2pVG04SA/1/p7G/RlYnrko728xmeS3wWhUfLdpYDt2KDIfypmVZgqTnHkJv
	79Ma2NNw8x19BodcumUQ4EEC8Evk+3wRMZmS8koEC7s+pacxH+kyTFeQiIVMx6D94eLIx1TWQTO
	AoCtos5V0TfekyTJTY3jPBulBV9n5hgfNrhyEzwqfa6G8DO+JhQqRMz79UKq
X-Received: by 2002:a05:6808:144f:b0:4a4:da68:943d with SMTP id
 5614622812f47-4ad5bb1bf0dmr2706373b6e.3.1785333971281; Wed, 29 Jul 2026
 07:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
 <20260724-netconsole_move_more_final-v1-4-a5f7691db81c@debian.org>
 <CAGSyskW6iqoWk8DpLZbi=8xoME1J8LaSnjBNvAbAg6+b8kszBg@mail.gmail.com> <amnSAs8Ot4fR3lhc@gmail.com>
In-Reply-To: <amnSAs8Ot4fR3lhc@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:05:58 +0100
X-Gm-Features: AUfX_mytEfIvbsEso_HVMtxCtBGmkQ37abo7DCV-70QNJ0OUm84qTOJOVy4WljM
Message-ID: <CAGSyskUciEiQup-TdV185UfHa1y4OeS=P1SBJJhRPJvc1edL8g@mail.gmail.com>
Subject: Re: [PATCH net-next 4/9] netconsole: move netpoll_local_ip_unset() as netcons_local_ip_unset()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:23=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> On Tue, Jul 28, 2026 at 12:49:46AM +0100, Gustavo Luiz Duarte wrote:
> > On Fri, Jul 24, 2026 at 4:05 PM Breno Leitao <leitao@debian.org> wrote:
> > >
> > > Move netpoll_local_ip_unset() from netpoll to netconsole and rename i=
t
> > > to netcons_local_ip_unset();
> > >
> > > The body is otherwise unchanged, only the comment's setup-function
> > > reference is updated.
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/netconsole.c | 19 ++++++++++++++++++-
> > >  include/linux/netpoll.h  |  1 -
> > >  net/core/netpoll.c       | 18 ------------------
> > >  3 files changed, 18 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 3a7a2cafc6276..70f9c5bfb3720 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -351,6 +351,23 @@ static void netconsole_skb_pool_flush(struct net=
console_target *nt)
> > >         skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
> > >  }
> > >
> > > +/*
> > > + * Test whether the caller left np->local_ip unset, so that
> > > + * netcons_netpoll_setup() should auto-populate it from the egress d=
evice.
> > > + *
> > > + * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv=
6),
> > > + * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> > > + * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm =
=E2=80=94
> > > + * doing so would misclassify a caller-supplied address as unset and
> > > + * silently overwrite it with whatever address the device exposes.
> > > + */
> > > +static bool netcons_local_ip_unset(const struct netpoll *np)
> > > +{
> > > +       if (np->ipv6)
> > > +               return ipv6_addr_any(&np->local_ip.in6);
> > > +       return !np->local_ip.ip;
> > > +}
> >
> >
> > This whole checking if it is all zeroes in netcons_local_ip_unset()
> > looks very cumbersome.
> > Perhaps instead of storing 'bool ipv6' we could have something like
> > 'u8 family', which would contain AF_INET for ipv4, AF_INET6 for ipv6,
> > or AF_UNSPEC if unset.
>
> Agree, an explicit state machine would clarify the three cases: IPv4,
> IPv6, or unspecified (with netconsole deriving it from the device).
>
> Now that the helper lives in netconsole, the awkwardness is more visible.
>
> > But that would be another patch separate from this refactoring, so for
> > this patch:
>
> Thanks for the review. Would you be interested in pursuing that change
> once this lands?

Sure, I will send a patch once this series is merged.
