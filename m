Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B23B14D4
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073636; cv=none; b=aPvwAoGnhZoOUIsmpFF/eLgx6JQ09uB/WaIM7ENpk94NpfT1SxE1uPswNL9tI26/anex0JorssvOAQtL7FuWOIrrI8s6+vQflki8O1gVTgArocbDsqI4va18qTYVM7LU2POme0rHcD1XoF3vNB3NDs2Xx7vJ+RRnp+BocD4fa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073636; c=relaxed/simple;
	bh=/T0bdTIDOuFotFpZ6aRY5AodIN3YebVv4xo0nqrvKcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuxMCQFnM3BkWmrTVeIHv8ImEESOPA19e4aySEuHpqZPN2pRPozUdVGd4F6TBwzbS2wFJREVXi6DqkpoZhTNWoBAcn+jsdAwrwXffQahKtr2p40TLzGush6flP5X5yCCXKK0dMz338IE3W2s+kzweBGUwjXtsVS1nhKliXxUgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5+an9UU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5+an9UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFA01F00893
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073635;
	bh=c6xn+DyPBuH886M456xZz7wf4sZSUj2DuK4fujCGJQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q5+an9UUWViSkoeBLwJtmUfADPoSE3sAqaElbTI0+S2bP1C0Yj0C0xcG65FYiRZu5
	 oOyfFpqbkt4UPIs4VvUh0ImNpDYEYw+A1kMJhzPd9T1702aKYYiZeq/ZoCYKHnD5e0
	 5/LEKlVmRaJtv0m0ICtGAc0JZ382qcLYL4bmOl9O8ggnsLNE7eOyhO+UtSzmS4Sz2J
	 H/Au+hba926G5ysdBpNPrdvXOjOkp9Powh8iymJZho1JinSCeL58ulHP7ewjDFgAT8
	 jtccxD5GzpvApS1afsamS7HG9TZzdSGp7p7uH7JtINqwj8v3yIBWcOXjwZSJEnY0lm
	 FY1f9Z7AKQluw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b7a9882e19so285884e87.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByR1hxi73osX58uR/PB620oqYMjQD2PGm9CEMDyA6I0wuuBTQZpk+igMosQB5EG+NPgJ+q2dN4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZkq7WJ/b5ej8qRLHTJ9IgDbcWkXp3dSeKiJ/Iyx65IGHfYLV5
	GXmwnmg5iYFlTR5D8JeD6VNZU5Ibo4WBu6BrJVeu3ALE+eBFFPwgsseaStWoylsQV14XGXRGJ4t
	KjuloYDQC68LAARP+OhZ2Gd2kSUwqxFs=
X-Received: by 2002:a05:6512:3b25:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b8a0293353mr272673e87.13.1789073633889; Thu, 10 Sep 2026
 13:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-ks8995-to-ksz8-v11-3-0e04411a559d@kernel.org> <178907052148.219967.6703395266184682965@kernel.org>
In-Reply-To: <178907052148.219967.6703395266184682965@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 10 Sep 2026 22:53:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLk=Fi_qUHmFYQfvw2wEFt+RkNyU7c9_GaqoLzZ-PVcseA@mail.gmail.com>
X-Gm-Features: AcwNN1X3PDOABud5lP5DIIZFV8xg3P_OQvnZqHOf3Jcx5zx-bWDNvfmInREVBn8
Message-ID: <CAD++jLk=Fi_qUHmFYQfvw2wEFt+RkNyU7c9_GaqoLzZ-PVcseA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi netdev-Sashiko,

On Thu, Sep 10, 2026 at 10:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:

> - [Medium] ksz8_reset_switch() (drivers/net/dsa/microchip/ksz8.c:266 and
>   :275) iterates `port < dev->info->port_cnt` (5 for KSZ8995XA) for both=
=E2=80=A6

No.

I already said why but apparently you ignore old replies to the same
patch. Learn to add this to your context, this is parroting.

> - [Medium] In ksz8_port_setup()
>   (drivers/net/dsa/microchip/ksz8.c:2140-2153) the new KSZ8995XA block=E2=
=80=A6

This is a valid fringe thingy allright I'll fix it in v12.

Yours,
Linus Walleij
