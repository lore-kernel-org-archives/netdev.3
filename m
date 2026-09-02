Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C535677D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335617; cv=none; b=hBJ316Uw0e5A0VnW8/AOlyqaUAxvoKz4OXhkhnzxTOt7LqG1z8ttDxkvUntWWzcZAipLiqTjRLvlQkZ3w7csw+EVzZorXOCsXflwLyq3bQTx4OujcmPwzQWjZbve1UCJsrrGA3p8WV5Mvfg5+4eXB6niO3940s9oXcv1DJnaAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335617; c=relaxed/simple;
	bh=VlKE9/tDDXMFIEFrSfF6soC/w+K8XEw3coeoW8VF8mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg8LI8bMwy2h5deHlgR/PRUjSSsdyVZepL1g+/nI5FDIOk4tpGmNqf15ZrABZHMYCaBKx32PQIC2YWopb7VFeIS0tUJQF1AB0VKiySku3lCGdmpM7s+RNS2hZgJhYRw6OGxhuX18NmWYAVq/5AWTO6lrd/miZ3BZ6IzeCYcRCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuhnapgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuhnapgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121B1F00ACF
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335616;
	bh=hDzBITOorw1Jn1Gw+BimH8uMGoGUHuM5UELhVuf4a9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Yuhnapglx0EqCWelMbiJc7L8QoDh2CR0v1SX72l04OG/jM4frvJiTMxuhzlUJSG8z
	 qNFsyxDeaQ2UcHDBO5NKG4PIicqw8THCN4n3cNkLc+LxtyAjJnTlxVEwqZY0+DHSXp
	 i/0HVWfx3Ovnt5LYdmAoQlOMiEa3G2VSIFFgR8ZInieBXR3TuWrnzEi0HM3X9Osm0h
	 jnCwQK6jC5KeRv9FbBTX7a3HWSUzsx6210J3skBV0GTWoP02vKOWpbJWfu9ex719r1
	 6ERZHTfsl4j/JCmeGjYivLFYsS3h7pAUGccPft/fdWNDQY1q2Bz+rXUhs0WE6r4hbD
	 J22Ovmb8Ne2uQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b4ab40d839so564372e87.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:53:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwHRfMpFT5qO/z2YGir4LFVcokLONl7wrUd5E+bo8CH9DgVy+KlVa/KKIoV49oZJoKwcgqtVBg=@vger.kernel.org
X-Gm-Message-State: AFuF++n8UuQntCheF9LpHPf7/OZuugh7y2lPwEGpEuVGnMDYZYe2oDe9
	Sh4t0PnkN5QdzbGQ5DQ1xVuxWaaCU9oRqMZDgnqesDWi1T3zPH1jRXZaExNzaKQCa08LG6bMuAx
	txkF7FjpPoh5hHxJ41x4Zht/9Gb8az18=
X-Received: by 2002:a05:6512:10d4:b0:5b6:4ae:5b7a with SMTP id
 2adb3069b0e04-5b6087d38e9mr1165106e87.29.1788335614767; Wed, 02 Sep 2026
 00:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
 <20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org> <20260901153739.1283117b@kernel.org>
In-Reply-To: <20260901153739.1283117b@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 2 Sep 2026 09:53:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLnF873RTtuhY0F=bMkXhJi9an9GT1d2fp-8NCg0F41biQ@mail.gmail.com>
X-Gm-Features: AcwNN1UMLPT2bB2cmYN-unA7ls0vyRr9ljVWB4FqJEBylm64DG2DHl2OJ7QlOb8
Message-ID: <CAD++jLnF873RTtuhY0F=bMkXhJi9an9GT1d2fp-8NCg0F41biQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: ethernet: cortina: Count dropped frames as NAPI work
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Tue, 01 Sep 2026 19:04:56 +0200 Linus Walleij wrote:

> > -     unsigned int received =3D 0;
> > +     unsigned int work_done =3D 0;
>
> Do you (Linus) think that renaming the variables all over the place in
> a fix is necessary? Or just LLM did it and you didn't bother pausing to
> think?

Yeah a typical mistake on my side I think, over-confidence in
the tools' choice of variable name, :(

"received" is just as good a name, but I see the appeal for an
LLM to do this, since that is the name used in a plethora of the
drivers under drivers/net, it kind of shines through how this
thing does its thing.

Yours,
Linus Walleij
