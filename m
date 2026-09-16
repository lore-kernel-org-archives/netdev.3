Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B3356757
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562993; cv=none; b=EYkIyc/L6sWKZJaXYwvQhCyYI/vlcmwhfeAF0k3M4T12Faqy0JsKiPBrim7t6AHcEbRz9/XW2JscnP+QSdabE3fbFgyMjFe6NANHWQkLuCHr6qTWUtVsI+a0/Ga76ZdsMqNUHJzTyz4OnASbdnDY5+xIz2rmZZ3BMpgZnpYe3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562993; c=relaxed/simple;
	bh=SLs/CjzQdkPDSw0SJySGqb7Qo6h/1ntI5KFTdmdupQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht15MFz8e2ZuFLXb9ru7gWOECDVwXJM17tNxroHbgKgCLGk0QdAUTqMj3Bw4y35h/M8rgg80JXN3a/Br0fEZIfLPujMtZX622XEdeZIAQ/NeJJ0nDKxXw6/Dbq0LnJDXZ/BycNyiQr6GWnh9IiUy3t1O6Tn33p8Gk36yEgecIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBK2Og1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBK2Og1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE351F008A1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789562991;
	bh=SLs/CjzQdkPDSw0SJySGqb7Qo6h/1ntI5KFTdmdupQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eBK2Og1Nw7LdKn6m417oD1ggctVOWvZ5wZWWR4WL5/J3OzI0A2hj//FluwACGuHaA
	 6NuaoQZ/zdp8toNfGRy5ZGS/GdOn835eIFK7a9NxLBP0g3ULEocDGyf4vcV8tGmtkA
	 HMjM8j5K6J5htt0WPh2a0LUV6aOvOCGpnhltnoh38/9s/OI9WiTLrdf/LRAmiqBbog
	 DFxKVKzs0yTPzyHBDu6H81ytASn/Dk+d7Wb0Dui2qhSV4i+hRT1Z7GQwMD6Ng6Gac6
	 wADMJn/Scb8pOodbGj1hp4C7ltrVk8GO3Dz8YQ+ICTD6Hmzdz31/rioTmVSykZvkk/
	 Z0cJyqBeqmJLQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so902040e87.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:49:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz0DLUNW1bIktWWmgY0ybeiDZ99uFgzes/T/W3xqSqk8zfgSI4gBc4GzydqZQWjNqZZfEPiO3k=@vger.kernel.org
X-Gm-Message-State: AFuF++kvrFkFrY9JVYDTswLFPv+QsyEX+8IejPKwgoYYnU7saEM7fxAb
	HL0zrWPOTN6wPMyUt7YyIqdRpkH2lHrKmTun4jMVeu+muybjiOxiacA/87tEwRnteHqlen14guL
	+hROqxB6Oa80/u1D5vzMZGgKkY8W2D7c=
X-Received: by 2002:a05:6512:23a6:b0:5b6:1836:8082 with SMTP id
 2adb3069b0e04-5b8b665593bmr1261329e87.28.1789562990182; Wed, 16 Sep 2026
 05:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916090102.349157-1-o.rempel@pengutronix.de> <20260916090102.349157-3-o.rempel@pengutronix.de>
In-Reply-To: <20260916090102.349157-3-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 14:49:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLnPuwLf_zvyiiVttxwdD5vHpSiA1HiCZXyp8agcySctTg@mail.gmail.com>
X-Gm-Features: AcwNN1X3iccLXXNQOloIHQja7QR8IaLX7dXlckkP58W6PtJGSuJ0iSelFMjLN2k
Message-ID: <CAD++jLnPuwLf_zvyiiVttxwdD5vHpSiA1HiCZXyp8agcySctTg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: dsa: realtek: rtl8365mb: extract PHY
 OCP address halves with FIELD_GET
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:01=E2=80=AFAM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:

> Extract the two OCP address halves with FIELD_GET() before handing them
> to FIELD_PREP() to build the ADDRESS register value.
>
> rtl8365mb_phy_ocp_prepare() previously fed FIELD_PREP() the raw
> ocp_addr >> 1 and >> 6. FIELD_PREP() masks the value to the field at run
> time, so that was correct for the current callers, which all pass a
> run-time register address.
>
> FIELD_PREP()'s compile-time width check only fires for a compile-time
> constant value. None reached it here: the address is computed as
> PHYREG_BASE + regnum * 2 from a run-time regnum. The EEE support that
> follows adds callers with constant OCP addresses (0xa5c4 etc.); clang
> folds those into the inlined ocp_prepare(), so the shifted constant now
> reaches the check, overflows the 5-/4-bit field and breaks the build
> (gcc does not fold it here). FIELD_GET() narrows each half to the field
> width first, so the value already fits.
>
> No functional change.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
