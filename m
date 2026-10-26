Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793031121;
	b=o8hdzQ3B9euu9+3MCmEft9I5jX6njNu6bNeu7DHcUvma8vLLZXHDXTUnB10GW7/BHtPS
	 zgkFmdZiynrcZHnjK7tteeM8hE2CQMxGx4ywQvkNwpJY319m8j3Ft/K/cQxUfaRBB2fCP
	 M/mEOQWnNupj5+WF04uvPWOwNNUWNJe4wE2uxTuouE/GaB9oPgdHtSdcy8er2P8OVrshl
	 M2Y4N8cPDESviLQifAenw5Cd4e7HPdlY9fA0B74TlERldB2QxuhEDs0qL7XQcm+LE4Nsh
	 vJbhUeVTzDhvZhjkdiBxIp94ze1dWzpSzDAq4kv0hHivNFVs3OAJQaGI4eGH0ERClaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g+jO8UtF+vwChY1eYvPs5m/UaJWywgw4H0Nc0Yjcw8U=;
	b=WZpQbzlu2W3dlof9PPRos/ik2bh1HpEFIUdoLke2pKtOnHb2kv8GJ1SpGKVclUmlhOKX
	 5L3hQe2SqhCxYIALA4XGbmJyzdmiW4GUGKN0FvgUNxZkKFUBiI+Yq7q+B/rvhs5PGT4mr
	 0UcKjHj6cPPPpioaMXS1FRUruOj38Og3oXlWrjpeTs6YISrb9liPLZSuatH94+cHesQdA
	 kiUPSxJ1umtRJefUmTn4Z3CHRJBV8RCUGBCssW4Y9XR1RePGvn5tyNE3zKvqzJ4m0s/MD
	 SYS5qW8OeW3j8J/G3xFIQsNCCs48WVF/Yt3BSGkn5urcpmB6IcdVn3P5a5CBvArUviQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D6N53ke6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D4606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 517D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D6N53ke6
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-679965fb848so3268187d50.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031120; cv=none;
        d=google.com; s=arc-20260327;
        b=m405mWGhKDy0lvbb5fLF5702tWy5gsQlWdUFWx3HUVPYI7gkRklfOZ21rLWJ1Cy5cJ
         +H3fR6R+BoYrvvvDx8eoGuCJgMICELuQg0ad6zJug7X979nbaJ/X6K9Sfa9xcBQelFWr
         foLnkqq5ryfbWI+uMYecccEmvhRS1eNMZW/fZWRfQ5c/X8czC5+Sl1DId7cSyUcAvaTo
         8qMxEWf5e1FzXnSVPhMDvcF9RvmHRchzBh39waKc01h63lM2n70NF7Fo+v02jXDwPtKn
         pd1bt7xXf/KFGjcj3oofinKUgv5x/nsVNMvnF3hXxKEvS5+tbeF5ME6tsULSlyI8jZs0
         sHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g+jO8UtF+vwChY1eYvPs5m/UaJWywgw4H0Nc0Yjcw8U=;
        fh=YLbNu57TLgW1tTp8R1g5GHpbFjSf143SzLm6UYkE3oE=;
        b=jlxCgj2Sch+mplWW+kyV9Rsi60ycEVq/Cuk4Ss43cWvScK6qQI9SCi+xzvx+p5Lzse
         kZVhb9MsPAcSbsI5FuOwVsqMMfRdLnT1p16Nb1Qy3Xjmodbw+wYcV5fYY/o3p7knShVu
         OsJ+flSWT6BEy3OBhU/1gN8IRFyZaZSAB1fO+92XqH/wGCT4OfU/8E7/vN5aPnbyibQA
         xqxUYjqyY4vJASublobL9EfxwErVIwYsoq4zIQPO1113mIYnRQsDZitwHjwt9LTVIxRo
         ZZYz6STb0q8Cm01vQBAlQesE/gF8XQxjigSyGK28v2wngYKE5p70VNAAWEUot5DVX8ef
         0eUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793031120; x=1793635920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g+jO8UtF+vwChY1eYvPs5m/UaJWywgw4H0Nc0Yjcw8U=;
        b=D6N53ke6ER6ewLIGaSEG63QcTcfV18jBsCfNOw+Qf4Yc0SpRpHF7p5Q2aJYvevTt/j
         qhmsHUAJVSQ8w0M2GaTF/OZfU9bj3Yxfd4rvFMD4Do+3axLHs6zImrWg8SxhOH2EQLFG
         xRmaJK9nF/aN5kCAhvhgzmgnQ3VoXzS/XZojw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793031120; x=1793635920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+jO8UtF+vwChY1eYvPs5m/UaJWywgw4H0Nc0Yjcw8U=;
        b=zE8bEH3goR2elIe2ZZbMdyJgnaDIiNEnXvp6V2Rf9JNzUKjcohjtLjbVlorR0jnjKQ
         LOldXHkY/IVrdcuPo0+qh3h646cXbbjmBCK5UYtZ68atrvfILLWykn5PJbTLZRkOxqqu
         +GV14jNUs+M/SWMUjVzz7UZjetPO5jwUu+KGSg7kKr5TGsOQI9HLXBdxg6Kcq+VLKibq
         C6I6mPGnDCw4k6XfjaclSe3dd1IV40dnX5EaGSDXaIxDvIbjLDdjQm4yKjIhvL6AzF0e
         Bs3hQyrAAbEHo/LGyNNAod7aSnY4nYhvTGGTW7z3nI3BV3X+xGd++bjV/vZjy45w2gxR
         g2/w==
X-Forwarded-Encrypted: i=1; AKwUvBzsW1rxaMHcP+gNumJbbLzJPQwyNVETFP3I989r/tEx+UbwpT8KVswTjhJHeCezyP4x7xBeVJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXO+KSQJfxz9NEKsj1Q3Xk/7AeF8nCk0n3AMc4tvYRZ0GBVO6m
	Uyo5Lwia2KT5UvHgOcZaThmKmomFZeclwuiiWZnD9qVjtxlFlBD6TyrK64Xac5I/qXpDqYKUzR5
	jy/8xFGXEUxk8x+SIvhmnMvO0F3QDj5WKVS8KDIVK
X-Gm-Gg: AYBFou0SZinVAbfpYnL3DXdQBDw79hGBwNvh4gmKghzoiE4zqVPrw61KwC9Sd5aNOLa
	Q9ASDi0vYUXgPny6NwmySBKlUOCE8fNU6aBzb/SEOwQefswomUonaChRtopdj3Q55+i5DVN9uaZ
	TjtxB0ZWiQ0jl0UJJ38+hmu7UUoT+L49k+TwRdwX+MlUl4a2aI5pWjTeMy67RM5dcFLVa3eC/ku
	4Fk9WkatoR9WgmX34NdgEKXToddgxprh192+kK+q03jyCnppp607AHktIbTUy5pPjkDVjN21wPc
	pM7AkW8leX1RVJSIkkS7qsoSCsxf4RVrzWynIp7+xFb/HFC+RWd5g2MbfU82J3HxVqZrDV9D1EQ
	vCi0jyG3A/xbwN5YWDP11QoU17YVohXdNrCJmS+e/cbVkwFSvFTlQfcas36T0UDno2RsSyTKC/Z
	1+dxLkiuayIinUquuU
X-Received: by 2002:a05:690e:4390:b0:679:c9af:6d30 with SMTP id
 956f58d0204a3-67a453fa58amr2903732d50.54.1793031120103; Mon, 26 Oct 2026
 09:12:00 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com> <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
 <BYAPR01MB383065E105701C81A3D0472D80652@BYAPR01MB3830.prod.exchangelabs.com>
 <atplVXLEE_mNqhek@1wt.eu> <20261022212025.GV2823843@noisy.programming.kicks-ass.net>
In-Reply-To: <20261022212025.GV2823843@noisy.programming.kicks-ass.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 12:11:47 -0400
X-Gm-Features: AclHuK___KN_ZCi6KmdQxWiaEn7V7IZhvF8iqyoioEnZWSerq3wzmVRKx-efROI
Message-ID: <CAM0EoMkD7AL6ZE1Z21-fQteo55SJBVk_piTp4ekrYSybva2kMw@mail.gmail.com>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
To: Peter Zijlstra <peterz@infradead.org>
Cc: Willy Tarreau <w@1wt.eu>, 
	"zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
	"security@kernel.org" <security@kernel.org>, 
	"maintainer:NETWORKING [GENERAL" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:20=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Oct 22, 2026 at 09:34:45PM +0200, Willy Tarreau wrote:
> > > We will have some discussions internally, but in the meantime, we wil=
l send the cases to you as we always have.
> > > If you don't want to do anything with it, that's fine too. We will re=
lease the findings at rejection, or 120 days.
> > > Whichever comes first.
> >
> > The main problem we're having is that it's not possible to have anyone =
on
> > your side nor the reporter test a patch. But I won't rehash this, it's =
not
> > new, but *this* is what makes your reports way more painful to deal wit=
h
> > than many other ones. You (unvoluntarily it seems) act as an insulation
> > layer between reporters and develoeprs and that really doesn't help.
>
> This; Willy is far more eloquent than I am, but the zdi reports have
> been very painful. And as said; this has been raised a fair number of
> times.

+1 (from experience)
They just dump stuff and run. They wont even respond to basic
questions about what they send.
It looks like those parking enforcement people who have a quota of
parking tickets to meet on a friday.
As Willy mentioned, on the positive side, though they do produce good
reports (although once or twice the repros didnt work)

cheers,
jamal
