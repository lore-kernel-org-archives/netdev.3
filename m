Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D84A3F04
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561199; cv=none; b=llQnramFnp2Qu63m6ZMKBW7LudZ9f1/BUhyLWx6s/xrzdxK0J/ljdFtVzOXByOxBWfSegw3SRRoQvXbfI1/CeuccrqMrKHn8hIl6vVsgFoMa9ym/zYvNNwq0Jpb5Jb3CCqNBcIw3v45NMQuXhrAkXuc6Y+jwpl6u7OF6Ax8/WOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561199; c=relaxed/simple;
	bh=3XYlV4JSROFDSueaTRqhWeDNnSTk+Xr2eMkcLQNA3G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNYQfRd04MI8G9Gef7v0HyGpUpT3vhgylvsYG5G2fgiTABzReLLPmyocAureKIDaNmQMEjeNmkDgOGAko01eWAja5XnhEbhSU+Z6O6mJm4kAFw22UdVGrs3uQRKzxYQg7jY5igQHNfw5niLMkC8MDPrXw06NpIXrLCbJXwN0W7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aelHAmtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aelHAmtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DC31F01559
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561198;
	bh=3XYlV4JSROFDSueaTRqhWeDNnSTk+Xr2eMkcLQNA3G4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aelHAmtQtF0eGxhBaT0I+OTN79ChnG0gG1jKi4yK8xNPgYuQf8rFuKTSIWf3FIMR/
	 3YIEo6b8fapX0MnJMf/INGIgL5YUiK5j8+QLR70EZgKKPga5FC0K22Hox0sSqHaN/W
	 RYlrCRV55Pqbvuye7j+Ti2CCiRn0ptgqI11Fe8YZ0j+ZYNVRhL2lUhul0F6KO+jdU4
	 6Hrv31Of/MygAGIWO8NGUcdIQ5/GunL5uvjcggDP7Wfk8iuhJ2DUMaSnwTkxS5lCUu
	 mouQ0BzfqhAf8WgMW2WafOIeffDrAnLoO0hT7oTF93+Dw0dplFphB/9POS5UXe8YHI
	 f1uEZSqN6Z6mw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so1375094e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 15:33:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzCqZB743bh6tE0dZrO7qKLFw9njmCcCyee3SdKSNjjh5MIGLGAj7XukYEtcDSgOQ7gJVMZqQc=@vger.kernel.org
X-Gm-Message-State: AFuF++lPGSyIcsWx/26vuCy8/v2kfkrAjnji7zqjv0i4/ucdkjVaJCs0
	Me4vIATnTHjX+OMeFIjvfX+5iByyWuZOqFGSYX4zbAS9YKB9dd+kN7hDs0I+UoV9O0yEcC4efjf
	OMmqUcZIPqvyCtOSF5D+AW478ErjJQJE=
X-Received: by 2002:a05:6512:31d6:b0:5b6:4ae:3ff3 with SMTP id
 2adb3069b0e04-5b616f4a301mr1344526e87.27.1788561197271; Fri, 04 Sep 2026
 15:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092211.2922058-1-o.rempel@pengutronix.de> <20260903092211.2922058-2-o.rempel@pengutronix.de>
In-Reply-To: <20260903092211.2922058-2-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:33:05 +0200
X-Gmail-Original-Message-ID: <CAD++jL=o3ct2z7VBGkSJDta6tieem1HHj7_GbEbFXgDphmdTcw@mail.gmail.com>
X-Gm-Features: AcwNN1Wr9anlUQmFqcl5KRFBhKgwTtbelmYb_8KJu6qGBvLTegjsPUcOferrDlQ
Message-ID: <CAD++jL=o3ct2z7VBGkSJDta6tieem1HHj7_GbEbFXgDphmdTcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: realtek: use C45 for
 RTL8365MB-VC internal PHY MMD access
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

> The RTL8365MB-VC PHYs are integrated into the switch and have no MMD
> registers of their own. What phylib accesses as MMD registers (EEE)
> actually lives in the switch's OCP registers; the realtek DSA driver maps
> those MMD requests onto OCP and exposes them over C45.
>
> For a C22 PHY, phy_read_mmd()/phy_write_mmd() would use C22 indirect-MMD,
> which this hardware does not implement. Point .read_mmd/.write_mmd at
> genphy_{read,write}_mmd_c45() so phylib's MMD accesses go over C45 to the
> DSA driver's mapping instead.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
