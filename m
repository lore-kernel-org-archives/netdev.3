Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519923ACA58
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072192; cv=none; b=IQNdnH1DmaS1eiMhYt9W6f9t2PXnxySi9AB/NeuaNlDwB7vHLHbnTI+/olv/M9eQinj58WeD5kn4WBsSy+4IsMwiQjpd8atq9zIoB6N+vgHfJeeXdfn36t08sFqS6D5/uPWDMOvWkEcXcdDuA8cLOnph7vX6utkAprlM9Q2czTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072192; c=relaxed/simple;
	bh=MbxlvKDKZ9Osu+V1TPAW7Ly0AgKfeGzgpPJWakLT/hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGbjVDpmTp/1EHHlYcYFp1DTqEaTRHpwsV0aOebtM+AV5SkWfIo90XbtsiRQz+mZ3mpZi8NIeJ7rmUEBJ3rkR0JQz5qhNfRFnA0vW44klZlBUBtNceXdo8dFyoCFsPSZ6VH47ivf33Ms9Pu95kwKjxc2I5U2ZpfwyQ2xgdNQk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohFxEDd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohFxEDd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BE1F0089A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789072190;
	bh=MbxlvKDKZ9Osu+V1TPAW7Ly0AgKfeGzgpPJWakLT/hE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ohFxEDd7p/4maIhvqTxXoHUa+0TGUyAvH/dVbfyPpI76HD8ayvKlE+Ys2KlxkSNGX
	 rghtGka8EHvptd3S8nzblMYj3QTsV2WX799yXUnUWlo4CGzSWKtPEQanNd+vYf4ebh
	 ZemP7frTJKzNyy9g1Sl+Q1vKpnGWHCQ/2nGk1REz1htfwuYa0KDz8Xy37qRy8S3IGl
	 oaTSjxQqTyuYkQ/DuuPkuV9mDSGB1TefYk3LwODxH3LiVtyqAbR0NTWiIq0GJwjwMc
	 inTjuC5T2QgsXyaggwZE/nuQ7cXEHAzvWdH2Q8SPbMGBdd+p1fscWbX9a412ugrcpe
	 P+2CmzE+SXbyQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692c6so1264811fa.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJObdL5MI2ZdFp7Ogw3baQT/Hob1KiyPGhb+JomMO5nlKEZkTp63fjAEiTkzSom2+6uuNC5Vc=@vger.kernel.org
X-Gm-Message-State: AFuF++kZC0qw4GT8qDIKEb5UE+E2qcycpD5nw75O3ngWfR9Di4WP6Hr1
	CcdbqLom1ZOVvgVXefmjdTL3RiCl63iMQhAOZLG86Y/eb3p3hwMd1I9E3TbX6D6ptYKiPOVuzpB
	npaz1YFgQNwr0Wsum0CdVm74eiVPYSR8=
X-Received: by 2002:a05:6512:2256:b0:5b6:183b:d21b with SMTP id
 2adb3069b0e04-5b8a033a3acmr194350e87.66.1789072188718; Thu, 10 Sep 2026
 13:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-ks8995-to-ksz8-v11-1-0e04411a559d@kernel.org> <178907051821.219967.3256918514060835882@kernel.org>
In-Reply-To: <178907051821.219967.3256918514060835882@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 10 Sep 2026 22:29:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLmSE--Z7wwqqoxDbnBaP4OqytHdgB_R7gB2wZj-gZEqyw@mail.gmail.com>
X-Gm-Features: AcwNN1WCXDZVcHriH4WDlSulEeEfhDJIRoxNQu3Du0SEba2ejY21PN4z9xYzTV0
Message-ID: <CAD++jLmSE--Z7wwqqoxDbnBaP4OqytHdgB_R7gB2wZj-gZEqyw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/4] dt-bindings: net: dsa: microchip: Add KSZ8995XA
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:

> So the skew only exists between patch 1 and patch 3 of the series, which =
is
> the expected ordering for bindings-first submissions. Is the intent that
> both patches land together in the same merge window?

Yes.

Yours,
Linus Walleij
