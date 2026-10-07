Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA36DA00
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392469; cv=pass; b=h6ZZpoxr0FeTc1qf5LO6X7PEWiSXEqjZPRSJDTpfloAxrC3fy8APBHNN5Baxwe2JpmrXrD/aDF1fdkncvTlYjl7O0+JeHXDNvkxNf6yuaLIz8410HzLOn6LSWST1UXUUNK+JmqJQJXc+z+l3N8wQJgFzIkXMJ+dd2zQ0VGisNGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392469; c=relaxed/simple;
	bh=lbi4xj2Emd1g7pOLi1U2ASUewhb5WLgJ4dWZmBXY8TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeaUVvT7sH4DbGdquL04JGNIL1yv6hKtw3x5D+IEzfMeqCCGPdmYGzxV/uUrKzNlHINdy0fbUl55lcxKRbRqEPHdVb/eUL07HHqM1OQTJ2hlnGYuLtpVMgcCgN1iWKdEf67MkwonIMFFXVwe6G96Bb92E60soW2yrfmjhPV3YqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzTcTWpY; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzTcTWpY"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-784980b88acso268656137.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791392466; cv=none;
        d=google.com; s=arc-20260327;
        b=GqxfqEiYaemh1AXzrjyDZnDHY9xoHQ3SttLvGGkYsfTpeXkvfcXUQaVnfJQp1j2Uwd
         Q0sdIayUngHAH+ciXrg+bGKKYOU/ZhCUUhiL4NlvdnrYm6QL+65eU2rricG3g0MVKvSP
         /Sih+ZVXeVZkAX1aGIqIbZl7wmFhJcJDxdyW/DBl/HYIgJT5omnJnqemo0lkYVuIk9L8
         fKBnr2xVlHX9THOKx2uxNmVPD7pYaii+H2JBnL10K9hnaflCyWSGz0EaQiTaaNNygNLA
         44nnkB9cXV0fb18uKj7E1TeHevxRTPnZXEvJId7ZbBP8jicaHG93BFlF0FaZ5nKHd/H+
         0LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZbURIN7PUtX8kqOYTTPfURjX3hnAcmDB9GNBxJTsiE=;
        fh=ubaKMFDvIY883HSIw+h5lWUg6mmRRl4xg+UhrRmDKp4=;
        b=FEoWlks6IYtL7uqlun3jCCeOcRS+nsqJJfiSgdAmTRtldHf7ebkRToneKB7ncP9cJ9
         ajmviH2O5ZnF7zFUrIngtGjz7HRZ3bo9bHdF0THsDSGlSWSWWG9cZFso16QB4or/jFJc
         kkKjugSLc00L27Ji6ckUE37X6dnXsKt4J4zXXGR2tdoGYCH9dnx9EyqCNxuzsKvR2XkA
         gWmARLIJOr9QQaIBEcv2MyCjAzwSjeSPdw0vwAdJn6TsNZXLjAvamtOLuPS5reXl4Br4
         5Az1+O+IbLiqKZTXK4tn6Xvn4WW3Ji+rkWwr8Cb/4qXm0KUwfsBQisLzXN51wcGzb2f9
         uoYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791392466; x=1791997266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZbURIN7PUtX8kqOYTTPfURjX3hnAcmDB9GNBxJTsiE=;
        b=dzTcTWpYCFXATiNRgrUVH5sjbY1942rgLe6Nw3yP8zFIfZMVD2zyPB0mLsO388v7zl
         CQTx+RI16V0OacCKhul28xZdppvMCnLOgK4y+q4xLGybDrgd7VEAvEEda42Vj8C63FRq
         clJgrdtxnXdCxK0j2yfNP5k7NKEfqle0+318NxTiZGZLBSxMzWTzlHqmBBx2fPnEvAz5
         I1p3EmpxHLXyd0AfmyYt1TqIXbdN2Uxrwn0jqls0Ii0Wh9i+IxCnBB6BWqD4wT3WmGP8
         bcr2LXjx7mF93TUP6XiICI32+U5/eKEwcJj+F1vb2DLiAMi4azaHueGXqUZWn8KfWCcJ
         t8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791392466; x=1791997266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZbURIN7PUtX8kqOYTTPfURjX3hnAcmDB9GNBxJTsiE=;
        b=sRH8svjZ9O5NLMlj1OFHXYHevVlfg1vUZ/9iKMOvpTJ0hTUYXehIkMfGaD/+gjuc3d
         6VeYyPOHoUQP9lbaai1Vrl0mt+KR0lg7m4qPEa4X5PfG+sUw415yr13Cp2khfC6NiWKU
         kfNnFA/Rl2BBa4wZ71N19t8IpifY/PEpSh3MwS2PDptewg6lP5Vhumgd/uk2gd7+nbEr
         XWY6yGMwKGoVEH8XIoBYeAx8xpNomhGkofn0z1UlbxoPepxI1Hh24uE83u13mONDkpcG
         GGuA2B85x/v9z20lspeZWj8J12omIFwvtIgHlz+zbfxNxb18U6egW0ociLuwY2knMjX0
         vKLA==
X-Forwarded-Encrypted: i=1; AKwUvBzC1Btmr4KSpokXyqDwzOrMY0alThMJjPdbMnd0Keb0mxiGqBX0XwJieVZD5h+oCTZ5GfWvAUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOq9G3wIN/Non1P1EWVxuiOA7iW/59T0IcyBF160DVmyfqqmT4
	+yY2m1+KHmyZ2vsOL06+sY67bgBZ0AJ+vUtOpx0aF8TmSgKjiBAZNM0iF60WYvpw2e+20vTW+91
	M9wXbyU3W+xtnjcXgxZYkLthDM9WRrn0=
X-Gm-Gg: AYBFou2cIUBpJ7Ttma+NwfNujLbYGaYuTXKccexK2tbBvqJqqgBdq/0+8fBOWrWJJd+
	JylT9c2hlnGSFLVExSIHttnA2J8y+/5kA954FW49rUiG0P70h3jgoeMqI8C1KerJAS9C8QMgrAx
	WgKnyVwlRdQKLI+D69aKi2+p9tDrBa8WHT2nW0M3ZyYqFrTPX4Azv9sxaA4u0YnFazpnRWrB4vl
	yiU70TOwwDG6VnM4cQDl6QbgqWiKJ9rdhIms0Z0GacU7LHACUoogtWzJWptY5VumgFfR7rG8dt8
	4qetema5GRCBmV/y5WteJ3yYnRylRt4aTivmXWz6UxgG0x56E7GOS97vC3yg/HbD9BEabnIYsvE
	7u7RUt15ST0aT/d8ilgYi2A1pZtX1nad2fbKAq3UJkCat3qQrZggXUz1FN1dw/zlAHCSP8GKRJv
	LpeciJclUIgXYjkgTN+MCpVSGW4pY3sc7VuIRWQPuCh0Nn
X-Received: by 2002:a05:6102:441a:b0:7c3:a175:b3a4 with SMTP id
 ada2fe7eead31-7ca38e242e0mr699581137.36.1791392466173; Wed, 07 Oct 2026
 10:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org> <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org> <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
 <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch> <CADvTj4pm8fbgGDiyXVHubnM93qOey7o18O+MDU68MSisXVvHtw@mail.gmail.com>
 <f304ee6d-bbc2-4f76-964a-998c3febb8dc@lunn.ch>
In-Reply-To: <f304ee6d-bbc2-4f76-964a-998c3febb8dc@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 7 Oct 2026 11:00:50 -0600
X-Gm-Features: AclHuK_jUgMdUcYYqpUGuap2SPkyQESAVUFApu-SDG6nwRRhv-n0wwBC2Dl8Id8
Message-ID: <CADvTj4pniuLUzsHP_kv03rFUkUD87PD9yVZ=HnW0CsZX78OxLQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 06, 2026 at 07:27:05PM -0600, James Hilliard wrote:
> > On Tue, Oct 6, 2026 at 6:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Tue, Oct 06, 2026 at 05:17:20PM -0600, James Hilliard wrote:
> > > > On Tue, Oct 6, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > > >
> > > > > On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > > > > > Please do not repost the series just to address the above. In=
stead,
> > > > > > > reply to this email with the missing information, so that rev=
iewers
> > > > > > > can take it into account. If the series needs another revisio=
n for
> > > > > > > other reasons, please include the information in the commit m=
essages
> > > > > > > then.
> > > > >
> > > > > Please make sure you read this paragraph, to the end.
> > > >
> > > > How much detail should I be including?
> > >
> > > We want to decide should the patch go to net, because it is a real
> > > problem which bothers somebody. Or is it a theoretical problem which
> > > will never happen, so we might want net-next, or maybe /dev/null.
> >
> > I mean, it's in an error handling pathway that could be hit if there's
> > an -ENOMEM error on an IRQ-action allocation.
>
> ENOMEM does not happen for small allocations.
>
> https://lwn.net/Articles/627419/
>
> So at first glance, this seems totally theoretical, it will never
> happen. So net-next, no need for a Fixes tag, etc.

It looks like there might be a few other ways to hit this cleanup pathway,
not sure how plausible this is in practice however.

The unwind also handles other request_irq() failures. With forced IRQ
threading, including PREEMPT_RT, creating the safety IRQ thread can
return -EINTR if the task opening the interface receives a fatal signal
while waiting in kthread_create(). That reaches the same incorrect
cleanup without an allocation failure.

>
>         Andrew
