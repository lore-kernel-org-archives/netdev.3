Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720763D3012
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181901; cv=none; b=pKSwLVs4JOyoiwHHgFDKiYj+0ZESuh0Y1tePlYXpSOjMhUeu1O6FZMtIw9GSwXKsAhqa3EMYMyWBw7inWz+PI2s0S9atGAi7nM4JNZaFqU+ZFT72nR7k7juANRVXZX+52fnngL6jluX7u48orOJwJSfKIJmj/vFNWp5MZmqMNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181901; c=relaxed/simple;
	bh=sXOCRxXoafwoLxMu0M++Xq4HUBGFGEIvORPIOiwhvHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjFemh0egyunOlqHAZKIYo/TtZ22O0wMX1qbeYTBy6ZVxuZ8oonj2viwrtY+KtLQbVASPEStZWr43UrFScDwOHmAxZ9wrCvq6uXCA0VXR0Wq9hDqXBUOJJ9ei1IzBSwkKuQxntOY83EavJXXmgEsx5dtk/jxi3lOLy4ADx63gFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP8LZyZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP8LZyZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147341F000CF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181894;
	bh=sXOCRxXoafwoLxMu0M++Xq4HUBGFGEIvORPIOiwhvHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aP8LZyZmE9s7G4a9ilwECX5mCL+ZWBCkkHl8Ed5n8wo8+6dtYSDCYPj6Q7aHtbBmt
	 GtlQuVTEywubFFXDLcw8If7/WQe3QrRi2l+uShc4PPF6+r2qwUmiGAgFRucE+gnulg
	 rtRXzFt0/B/NP2OnTT+OAqNno3TpaJWacOcth4E3F/IZTUmdSoPnRRmTkvtyiB9zRG
	 P4NXdFPzJcJC/QSAvAjRW2i8G8BCmyirK3EbB6zDPSfIzbXpJp73dAHH0uAxKILZzD
	 xSgzGOIK1vYCSq6yLszwRFnqBd5nhZ/ZJkbmzqNvrZ5snxNUEAm6+mXwndwggduR8u
	 9yCiClrUfI1Cw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be4fea434bso288600e87.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByd3Dpw1g8yBtwJMglC8be6fegnzLBtj4Gm+xQkn2jWTawf/YBQidyTejAVstnfrKEjMh2xSes=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeoN1QQuypQN5gMGBhKnJgMLhvfsYDCLxy/Q/YwmwLx7pN/eBS
	I+ksovCaj+CfEwV0lfbZ6TfSPzyUg+9l6j2sVyPCO3tcdawH7tvNnknePp+99rTWJfW0jmBOoFN
	jursVLpaLV0uaTzmVNESJj6DPe039+Mw=
X-Received: by 2002:a05:6512:3e24:b0:5be:3e21:9274 with SMTP id
 2adb3069b0e04-5be4790ca52mr1367216e87.20.1792181892832; Fri, 16 Oct 2026
 13:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <3cb754f2-dc21-4de3-b245-b970719925fd@yahoo.com>
In-Reply-To: <3cb754f2-dc21-4de3-b245-b970719925fd@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:17:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbcR+GQUd41gJvDVvQdHs-ntKSYe-XoxJAYJUU=mdGyA@mail.gmail.com>
X-Gm-Features: AclHuK_XChkdtjtccuHGx6KE_4DFC9o1Vf6iXvfj14gfolYWBlCDgaxBQp1sl5w
Message-ID: <CAD++jLmbcR+GQUd41gJvDVvQdHs-ntKSYe-XoxJAYJUU=mdGyA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:09=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
> It is the first chip of family D, whose handling was added in the
> preceding patches, so this is the patch that makes it reachable.
>
> The SGMII/HSGMII SerDes of this chip sits on port 6 and the
> MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
> interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
> The chip reuses the existing initialization jam table.
>
> The chip has 8 ports, not 11. Cap priv->num_ports at
> RTL8365MB_D_MAX_NUM_PORTS for family D. This is a functional change: it
> sets ds->num_ports, the IRQ domain size and the bound of every loop over
> priv->num_ports.
>
> The L2 learning limit is the same as on family C (2112 entries), as
> given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
> RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
> comment is updated.
>
> Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
> to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
> also been seen working, but I no longer have the exact link partner and
> speed it was tested with, so treat it as lightly tested. RGMII mode has
> not yet been tested.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
