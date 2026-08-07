Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3646D0BC
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090855; cv=none; b=ugHtw2caSXvd+2N2/MIqBym85vV+uRcHqGxulDoC/0mU978If/DAj4/OETRAsefgvOL6QrCK06yDFD2cbLI/lYrKAQ3jJBlc05liiaYhVe86FBcHrDSLjaNX2WTwFPghTau/hxnMSZGKSTdbem8CxWSm3WMSF2MS5O/MAcyZspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090855; c=relaxed/simple;
	bh=aK7zHllXF1kREWQZ6hcNkPLnGotDBABqxzo3Wr5IKuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2W0Xmmzh+6s1ZxD3mruEY/zxcxEb+V2+VWMLlf6YK7FWvCEqgGbRSZ21h50mAAdkY2MFnPnvOYxGCzsPrp14OHX7GxKA8nXXu6M5eSgPNOUvBtwC0vuAAkdlasPp5DYzRgn1WQKdg9xRYnMoKn4sVr8kB/nwgBcoaCPj3BnIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pix/gLR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pix/gLR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C91E1F00A3A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090853;
	bh=aK7zHllXF1kREWQZ6hcNkPLnGotDBABqxzo3Wr5IKuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Pix/gLR5VzRLCkyrSl4KB+e9mA7R6dmUVXAbd99MkUSXru2cRaG9rNGjXbmHvKa/p
	 e7Bf0+jNJI+SW2IBwKgS1UK5+MGrTPk4aolzMfQngPMT+poegCTC74t2uQYkp6Nn/O
	 R3mcZqJVjyFFHt3gfRdA3QVJmiMgkdXBCKvc5ksYx6aJH1y8YjxGBNFExkJ6dppOwO
	 3MAYAvdKXyOAaFMCFAtOViDYXvbluadhz0tS059d2DOnE1771HXSl960lyCAKrs+98
	 xewwMyIugsQM5c+cBrTQTNp8KB9E9klhJ5fX5RlUDe1ZA/CCbI0XGwPFkD7pzZfO95
	 JNV3ayqccO/rQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b021916bd3so3262053e87.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:20:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrD67XTIqFO13oJJUgrWG30O1up0neB/JeccFdIJKprKOr+rjKSoxS8Zhgd70PkjDzX//8scJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOKQt1uUQSU9IiauuTDXqdZeYj+Islmv9ZT9keC1C63zUIZze
	1YzRiZQLs3YUxzk0nmvuLhsgjSXEaQptjUeMplvNFD+E0ZxR35T7uFboqBKbRw4BoRVJnFgyIwa
	7B1zhwp2zG4fwErdNeOYS8yTGTgiHohA=
X-Received: by 2002:a05:6512:908:b0:5b1:543f:f5ca with SMTP id
 2adb3069b0e04-5b2f4cd0a73mr1978374e87.46.1786090852436; Fri, 07 Aug 2026
 01:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de> <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de> <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de> <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
 <anVedv6aV1hguF5x@pengutronix.de> <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
 <anWE2HD_Mrv9XlYV@pengutronix.de> <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
In-Reply-To: <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 10:20:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
X-Gm-Features: AUfX_my4v110hjvCCa_CQuVTR7llXzN2nu6lpNvuUqh_nbuMX3MkdNegAdj0D-U
Message-ID: <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, netdev@vger.kernel.org, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 9:49=E2=80=AFAM Ahmad Fatoum <a.fatoum@pengutronix.d=
e> wrote:

> >> (*) Reverse centaur =3D humans touted to please AI, as opposed
> >> to AI helping humans, sarcastic term coined by author Cory Doctorow.
> >
> > Without context, I would fully agree with this statement. But as some
> > one who need to adders new warnings on every kernel update for our
> > customers, I see the point of sashiko - new unnecessary warning
> > is extra unnecessary work for some one else =3D=3D regression.
>
> I also think we shouldn't dump 6 new warnings on other users if their
> setup is working ok.

If you think the regulator subsystem is too talkative that is one thing.

But there are millions of systems out there booting every day
with dummy regulator prints that have been there since forever.
New ones have been added over the years.

It doesn't mean dummy regulator prints are regressions.

Yours,
Linus Walleij
