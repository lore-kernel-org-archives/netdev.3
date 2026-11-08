Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147687;
	b=QRVdy9Ib81WZYqyeDlAwr4L2a8e/K+afEonxvp5f2FrMJ8TgJPZQG50SKqXlzQbyQ/H2
	 4itsReROQCJddHkBCiopSGV0GRbbi7aVklt1u3Kto+b0fgi/gpfFKA6IAP/lPO7ehH2Rv
	 gmuCYm0DjR/MOP5ykAza+vQiph2gZPPwKHZ4ck3zJq/U/LdkVs1NkpdJOozIW9mZMAk5m
	 KR7zNEjHv1Bte2PckcjhR68fJd3ydarzsu4JjTk9TiZWCmkMRQZCLY4xFCFsPj9Xef3Wf
	 4rKCIbalSCvBEAQqIBkozr0uMr8r8VPWL4fqeFTbQCfX1JkCJsMwwaDKiSgPz/PqKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147687;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PoMYxDel/hiZN5VsRIJuMtS+DizAYIXnjXfmj6smHw8=;
	b=uf+ReFqXB8SrAzEU4K/g5nrO2PlO9vzj9/fP5rc5UECgbc1mozXf3D4/AKB43UuFjgY7
	 9L6/+p/xvrG4yuQPHEWGL4JD+zao8wSuqCsraa8UZRpjUngOqAXBjj/AFelOGFLIdlvAG
	 eGwQXxu3c7zdYWLfCpr8v9II/6l50wp/FBLUcjfoKjVai3IkszRPScviJfm7iso7RusJN
	 MV5jbOf8E8Qdqjvs24SnCmSzrj0NI4iWpXntuaabv0fHU3uFWesLB1uVCotWyTvWa6XDE
	 R5GPMA3UmbbnWmTy2wpnoxl21LtbHyY7EPzHb9vUeBhIThsAJ/642/tlAPiK25z1aRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqu++GzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC126606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqu++GzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DCF1F00900
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147686;
	bh=PoMYxDel/hiZN5VsRIJuMtS+DizAYIXnjXfmj6smHw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Xqu++GzJbhocBzPwvKd45UnDRJFSMJaaf7ihiXES6fkR6vNk958NqN7IblZY3w+ev
	 24Q4Opb+phUM+rUpZkKxDUbTiADd27ffc5PvXuCuBh8SdewLunvZ6rKep/hfKw/mff
	 li/AGkEuW1kFiG+jYBtlMHc4mNXLQC+75vzKSfhLJqKAksWSJNaPkTpQesHCfTbKZC
	 ZdgMH5fFUIlXzmVjTyMOTQkuY8RCaxZ30c1Yl9BU8Sse40gE0bUhyl18nm6IyAkTVS
	 YGDpGWk22A690FMR5jrYDSAd6Rg7Ha36Wp+HjfHOiZID+RXBG83yFglaA33JsuVHCy
	 8+n8Xl2eJS1qw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab27b4924aso727271fa.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 06:21:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHNOUVpwG1GSRrFkpqahNGvnjk10tRcOBj+kMhx4AxhwDj4tCLlqegNZA/nL22tIR2CpdRt/Zc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7oq0BMPRA0akX85kF0lxf9SZUZTtEow8o/sxqiv+t0X1Fnv+d
	yUlPtyixLDHjzbx+/dVYnVgKwj+8aW1uIODNwtWw8/mvTND9PFcQWt5OYznM5AZMSSeEmgedoUi
	KNpftaO/9oeyMujf4cRvmbkd757zT1uA=
X-Received: by 2002:a05:6512:31d0:b0:5bf:ce53:f741 with SMTP id
 2adb3069b0e04-5c14c02c8f7mr398477e87.44.1794147685264; Sun, 08 Nov 2026
 06:21:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com> <7bdfd66c-3492-45ce-93e3-2c9e5a1a5872@yahoo.com>
In-Reply-To: <7bdfd66c-3492-45ce-93e3-2c9e5a1a5872@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 15:21:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLnr=P=GZ59A5X9SiQd0FJYg5p=PPRFpOTPs37j9h229kw@mail.gmail.com>
X-Gm-Features: AclHuK8sSermFPXSu0KsAk2mJ8Pzp58boFGJG6XMsnhI0rrWh_VLtbo5O2Ytm2o
Message-ID: <CAD++jLnr=P=GZ59A5X9SiQd0FJYg5p=PPRFpOTPs37j9h229kw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 11/11] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvin.sipraga@analog.com, gusfmora@gmail.com, 
	kuncy7@gmail.com, fabianotassotti@gmail.com, gabonpivovich@gmail.com, 
	contact@c127.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 9:14=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.co=
m> wrote:

> Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
> It is the first chip of family D, whose handling was added in the
> preceding patches, so this is the patch that makes it reachable.
>
> The SGMII/HSGMII SerDes of this chip sits on port 6 and the
> MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
> interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
> The chip reuses the existing initialization jam table.
>
> The chip has 8 ports, not 11, which is described by rtl8365mb_family_d.
> This sets ds->num_ports, the IRQ domain size and the bound of every loop
> over priv->num_ports for this chip.
>
> The L2 learning limit is the same as on family C (2112 entries), as
> given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
> RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
> comment is updated.
>
> Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
> to an IPQ5018) with bridge VLAN filtering and per-port PVIDs, and on a
> TP-Link EX511 v2 (RTL8367S-VB, CPU port over 1G SGMII to an IPQ5018).
> RGMII mode has not been tested. See the cover letter for details.
>
> Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
