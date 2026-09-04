Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7C3C0605
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561242; cv=none; b=f4yQUfH8JzwjXDZAHIBVlEs+nfmOMffPnzLEQBcIQ6kvUQeR1HMaAm7P++nzTubsEn5YwZ1HBmxdw20pys0vJvKXCfIsBedMufQFQGoCXU/CyH7rHtpTla5ptP0WcXq9XcBtYO4/2MhC56AhGXSXYhd3Z7ZqGzdR1gd1+4o1xSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561242; c=relaxed/simple;
	bh=nxE0xgvvZiagQbZs2QK3gOmBmcr4vYHvmdb77D+/Z9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uibgWZE0eRF2eD9IsxLDXWyNEt4syuEpSFTaDkq+MF3yqQYamWt65Bsd+Z/ijWPXK+GSRZ2JyNnLncBbgvZKTepQryVn05rFaqRvfZahEM4istoaPX/+cKLM0U/9H8QBcXbecDKbCE0osx2wLetXGkfvMNiDi/PQ8wnAut+Gq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE3BgDkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE3BgDkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E61F0155A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561241;
	bh=nxE0xgvvZiagQbZs2QK3gOmBmcr4vYHvmdb77D+/Z9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IE3BgDkmzz3Q/OXdNShbEmLHIVKDPrWl9DznlRVu2BWjud3KzvfylWUqzZxnz8dS9
	 mfgXKPU74YG1qNtk4AFQfmiNhUUbX3l7xGoRH36C83sbNh11WrCVLRmgbu3khxEiVD
	 q83hfb4lWKrE8gqmqAj/Yf1syinGIQyoL9+W4Wlntz2FenpCD8+/6WtOo7JdygHvYn
	 qZA6SvlHFXLPqqp15IBqMBUuzFUpTdUKYRS+W501fkuDdwXK/HmO5AgdNmSYSu4518
	 qOL76cW5Lvisa4yb6D2Dvua55AvXUP61RStzeISe8W9wH3sgSoFY73XG7u+0wyR5ld
	 yucMUnaCnOxTw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so1398604e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 15:34:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3/fwITHBpHFX/Ud3uq4tw1fWnFdwxnV6he+2nfgNYD4JokaQK9ic9sUZpH+PA2w0/vYlzwTA=@vger.kernel.org
X-Gm-Message-State: AFuF++nqHOQNZm4oBFjwpNnURBwbGmxbPG3/DMW7j3a3suP9fBqkpRWy
	sNPQoMjdhuiVMjnkThvRv81viPQigUDOHLln8Wdf/J1FdNngOInENmI4fTmNl6OpgUfpxF83NgL
	VmR3gbKCy269/yj9c3jr3p0iAYZ9/3Fw=
X-Received: by 2002:a05:6512:1252:b0:5b4:ab2f:5bd5 with SMTP id
 2adb3069b0e04-5b616ef21b8mr2939337e87.8.1788561239924; Fri, 04 Sep 2026
 15:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092211.2922058-1-o.rempel@pengutronix.de> <20260903092211.2922058-3-o.rempel@pengutronix.de>
In-Reply-To: <20260903092211.2922058-3-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:33:47 +0200
X-Gmail-Original-Message-ID: <CAD++jL=GSV90efBmSkPwAg436XTPuv1N1vOMwh8OHp5=vsO9xg@mail.gmail.com>
X-Gm-Features: AcwNN1UiqJeqWKqlgo9fbea4qFveJ7cC7l21wguPG2Vul6NQfwRuexTu7LohcJY
Message-ID: <CAD++jL=GSV90efBmSkPwAg436XTPuv1N1vOMwh8OHp5=vsO9xg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl8365mb: add EEE support
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:22=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> Add EEE support on the integrated-PHY ports, controllable per port via
> ethtool.
>
> The integrated PHYs have no MMD registers; their EEE registers live in th=
e
> switch's OCP space. phylib accesses EEE as MMD registers, so add
> phy_{read,write}_c45 realtek_ops that map those MMD accesses onto their O=
CP
> addresses, wired as the user MII bus C45 handlers when the chip provides
> them (rtl8366rb etc. unaffected).
>
> The hardware manages LPI on its own, so advertise EEE to phylink with
> no-op mac_{en,dis}able_tx_lpi callbacks. The LPI timer is a single global
> per-speed register, so .set_mac_eee rejects the per-port TX LPI knobs
> rather than silently ignoring them.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Excellent work on this Oleksij!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
