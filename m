Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083744CF59
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085528; cv=none; b=tk/CppFGOxz2KQ1367PmJtpgOTJFgGG0a47Mk9HCeIhT+NN6ss+E9ehygZ/b23rTKMPDCG3viHjmFTG6KcXPtZz6lvsPqwXj6nTiBjAY+DPnCh8c2dhdnrv5eaG9Pr3cpTl6DKTKARj7PBpnz2v++xrj2K9z05bIfuli2JsqsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085528; c=relaxed/simple;
	bh=wupVbE+Z2FGa5WYZ2+P30lxPgF8IKddNTj17sqTXF+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdWHC5YAf+DtOXOkQU6oYf096c5cSjQLUcA2r+7E6Oah1aKplHSa0VPwOCboMlW7A8cqjuozB+nrC/A6TLEeNZsDxWyB6VnrA9N70qvdiabNm2tM7eh209vjJs/DY41qw1AP8lLaBZVejcl4bdfGOdkFOVx6EeSXdMqJ/FtdRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGdmQKa7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGdmQKa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C371F00A3F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786085527;
	bh=16heBEpwwt0hJ/m1c23w/ckEM24/QO4sSIOuhFeIYAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SGdmQKa7DZ1F2QjDoCBxBKLxevO20aDp8SgpP6isEer1ltX43wnGkOb5zZj74FPlb
	 DMBsw5iZ7OeGRm/47HyaUpV//LEauAa85k0VLjs6K2GFLOhYRyRd4aTHkKrDDJd8Sx
	 qlsvAPFo//Gi9kz4qNuQAhmZVFH5XGWrFxLsgjdWtgxxMrA/oBHPwUf5Ydmx/1SBiZ
	 LOhh64K9ZeeX3C3Mx4KkKhCA/7bLoJGJYZvb+d9tpwOG5dE6VtpRjOA8B0rPA7ORze
	 Xy+514PS64ZCemIvnj2G9vPfQkFZcg+VMmCFZb57awBmFIHrqlL3OwQweGojG7N8W8
	 w2CXiPFTbOcvw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso3217713e87.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:52:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RovMv7n7E57D2Og/q1o5EI9EJFjYUq9oDf6bFvk8rMA43SUbvj6Ynen/ylxqfmLVeq/MkiTwcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4LLRRff832AZR+TwGkTBaXuso1WgIxdvj689N38+5gvKVVtS
	GhwpqKf70r0pZ4fjUqzQsL4o6SzYIYWbn1+CeR+DqBjJDpN/NwrzTuvFAlmTvGPL4X4bGyNJ7ja
	zpAakwd4XVHglCBdz1hHj6K0KEYDN9U0=
X-Received: by 2002:a05:6512:61a1:b0:5b2:e6a6:af74 with SMTP id
 2adb3069b0e04-5b2f4b88b51mr3035379e87.8.1786085526143; Thu, 06 Aug 2026
 23:52:06 -0700 (PDT)
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
 <anVedv6aV1hguF5x@pengutronix.de>
In-Reply-To: <anVedv6aV1hguF5x@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 08:51:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
X-Gm-Features: AUfX_mzIheQyoZuYYL7VIkOJ0ALKr-ClEhyDx1CSypgboNbiGIrukUWW8xAt0ik
Message-ID: <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	netdev@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:26=E2=80=AFAM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:
> On Thu, Aug 06, 2026 at 07:40:29PM +0200, Linus Walleij wrote:
> > On Thu, Aug 6, 2026 at 5:56=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutron=
ix.de> wrote:
> >
> > [Andrew says]
> > > > static inline int __must_check clk_bulk_get_optional(struct device =
*dev,
> > > > static inline int __must_check devm_clk_bulk_get_optional(struct de=
vice *dev,
> > > > static inline int __must_check devm_clk_bulk_get_optional_enable(st=
ruct device *dev,
> > > >
> > > > If clk has them, maybe regulators should as well?
> > >
> > > clk and regulator have different interpretations of _optional
> > > when encountering a non-existent resource:
> > >
> > > clk_get                 return error
> > > clk_get_optional        return NULL
> > > regulator_get           return handle dummy regulator
> > > regulator_get_optional  return error code
> > >
> > > So devm_regulator_bulk_get() is already the "optional" variant, but i=
t causes
> > > all existing users to get dummy supply warnings.
> >
> > So is this a big problem? Does it cause any other issues than
> > dmesg noise?
>
> As tested with local sashiko setup, new warnings for existing system
> without good reason will be reported as regression, so it will be
> blocker for net-next inclusion.

Strong reverse centaur (*) warning on this one.

I'm not sure this is how Mark want such "regressions" to be treated.

I think a few dummy supplies is just fine and it's rather that Sashiko
need to be taught not to treat that as bugs/regressions.

Yours,
Linus Walleij

(*) Reverse centaur =3D humans touted to please AI, as opposed
to AI helping humans, sarcastic term coined by author Cory Doctorow.
