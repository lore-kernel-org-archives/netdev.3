Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84945FFB3;
	Tue,  4 Aug 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855819; cv=none; b=OcsRVT/ex2uVW+yWm1iZcL1/PF3URNrTgiyNNK1+g4sclTrHv+5D2YFK2pK6Vy2BE0pU34zdclvx8TtsVMN0gCszp8RR8bw+ha/WzO50VKxjtY19u59WSWP0Tb2Wh4BslEY2Fz0PzRpZKs9MPusLZ6AqWxQbxDDSGltoTA39wG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855819; c=relaxed/simple;
	bh=2d+0kwXSdsVxRQA1h46DYXCp+cmCpVqM8K5MdYotb3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sRihpQuj1ZEVf4DMY1Ico2uwhC1vWdRS+HOmTqni4zoIBrlQ3Ic6flfqaslVxM2WHlI8eAfEj++b5SiivCPJ1YjVhoRc8bmb/k1oA0+qwutvPEZUEJ5CCYfeHL44nPZlOSxI1ezCvtpOIVWyuKhBQ8h8jKRQM8Os1TLRV+kOO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Iyqh5wpx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2pJH3F2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Iyqh5wpx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2pJH3F2"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FF15EC0112;
	Tue,  4 Aug 2026 11:03:27 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785855806;
	 x=1785942206; bh=BOKiXsupyStLiWuBcIH5e44U3q/vIZOUOqRAnjcxwn4=; b=
	Iyqh5wpx04P+KE/eojxZHA28SCH/DUg88rB8QIh9XY2/5UBDiozJiht9f1qHHfuE
	EAq25jjqt49qcypgRzij+DCT6EN2J/V8S7QpEIGTMrS+5+eQ40kxDzhKZ4znnaYH
	KmAdKdOXShfxWWoQOvsr0OipQZH9gCaZ0VZUEQAo5m5bWUn7yuMzSh3ZnmYoVdDF
	yJ8yLKZ2faR2buRIJSn3tTlv5fvBitYcPCmBZRnunD+iDiTS2HkeVzXDHdPfXyMy
	IKH1pGtiRbp36uhDYeLmYlBSwYkFYLn49zw9YLd3E+PKQVqeOg6ARFWRNUwOn6Rk
	I5QRxKIGJyLC2G5nqBrmCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785855806; x=
	1785942206; bh=BOKiXsupyStLiWuBcIH5e44U3q/vIZOUOqRAnjcxwn4=; b=l
	2pJH3F29cjoWWydj4iB+qkj/d0hAGcaUj0d78viLZhhwvZyzSURmSsfNtxgt0HNC
	6gx1yT+EvgyaM//+ooc5p0GhvV/dKBZoOs95MbrMhT2hONN5k1zVAr71MYdhiyYx
	YDIzVkABKO0o6a4klvatnZ7JX8drMPsEOYUqLBsuUZhUgLWF/51CpyfUHmGeHWZi
	mCamAkmcKYMyVpORGZKiB3TyEglow9fwkJGtCRTDMXQ4XdiEnQAigmmx4Qho1wdc
	jRs7ZjCLAXXZXGWqodc3j9Nz0zBMGnOJhVkNow2H3pXhL9n4TZEXtgG90yc98x7D
	4TKkjyv54y4BcTLaVVCMg==
X-ME-Sender: <xms:OP9xavON4w3pCsubFI_ysFN5mNitwbXDfb9euIGVwiwxceQFBGh6ZA>
    <xme:OP9xakyW_sxnQrVx074z87EqMpRl6v3EyI911kN4hJVokghxMsyo4gLK7WK10n6B8
    2VJV5YbxQFs0NO6L8VDNjh2k5YGO9c_rYakufZ46R6plyP7xD3MOQ>
X-ME-Proxy-Cause: dmFkZTFPJPzkVrHUNS8tdseR/I2i5GNycvcEuFXnXWAbF4eO2qTbDGR25kQyKDLbuIsHQ2
    ZLgV5CYHlEU/mDwmjSWtoz6k7iL4VP61k3rYSU3LCwYBRuKes+nlJvgeTc3FH80lcOezB6
    7De8kIS1ZW1qsx7uA9Pf8urEmM89K5OdNP3k9rsJ60fkeS1noGGiS4rdZPriQd5vYkTaeJ
    RigP8v3ZgQirfb+AH0vNlegXJ1OWgOhiVdOAH/0IV9fkxgqk+T2h6EaZBqyDUlWvnbZZS0
    dVuXpA2M3cRVcgJovEk3itZuXhA7J4FgMjPBQYo6w4tyNF5wzwtapZLtwqte/dh51ZAkMb
    FL3N3gNCpF9Foh7rszEVj/u5ekV8OHdttxU/VRxjITINq4UHLovtIZI41onTMBPRMShkca
    v2ZZJlFcetRBJ+Y5fnjzxbU3hQstYApj0p39YcbfN4tVOmkixz+uRyOVfvCTOnbs+bAnbn
    PwmDamjDPux3wNnBMzTaYVjqdxtbpsH3EvIWn6j78sfQht5CET8+s1Lj6ChSwaCqsiQT+5
    p0kXZU7pMzp+t9pdeHY0LT3bJQ0SsvxJN4Ib5YiXaiUarFMlsNLL4aawNeN8OUiaIN6/vS
    E6FawL9s3vWQPcvb2Z5hkD0V6Sa3Fe6QO3djgAFXV5XQbw7AJvt2BunHE/gQ
X-ME-Proxy: <xmx:O_9xavJMyiVYP3X7DLfALGsQeeImGud7V6hnLN0kEDjW5Z-dlAUJ6Q>
    <xmx:O_9xapitxvV6I_kp0dl6EvnI4qz-IB4Bz8fHGtutyRJyJTDJGAZaUg>
    <xmx:O_9xaj-bnnqNPz97uI1nu3mEih-Zy1p42CJPY-KzWQgUzJCm2pnvew>
    <xmx:O_9xamNThNps6ccim6uc2IJbnEgaLOImbf7U2w3HLTGhspoy1avQXA>
    <xmx:Pv9xarhEqPQPpxeQGTX_wNv1mDT8nUQwUYd4t62GhEkUj5YFrR3erHcc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 69F1832A0063; Tue,  4 Aug 2026 11:03:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGiDCXf8z4CV
Date: Tue, 04 Aug 2026 17:02:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <75937d1b-8ae9-4daa-bc36-08bdf5a6c5a9@app.fastmail.com>
In-Reply-To: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026, at 16:38, Arthur Cr=C3=A9pin Leblond wrote:
> Commit dacf281771a9 ("w5100: remove unused gpio link detection")
> dropped the link_gpio/link_irq handling on the grounds that no
> devicetree user passed a "link" GPIO at the time.
>
> Signed-off-by: Arthur Cr=C3=A9pin Leblond <arthur@marmottus.net>

Hi Arthur,

The patch description could use some more explanation here, and
a clarification that you don't just bring back the original
broken code but add devicetree support for it.

>  .../devicetree/bindings/net/wiznet,w5x00.txt       |  8 ++-
>  drivers/net/ethernet/wiznet/w5100.c                | 84 +++++++++++++=
+++++++++
>  2 files changed, 89 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt=20
> b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> index e9665798c4be..e97ce3cb9183 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> @@ -25,6 +25,7 @@ Optional properties:
>    According to the w5500 datasheet, the chip allows a maximum of 80=20
> MHz, however,
>    board designs may need to limit this value.
>  - local-mac-address: See ethernet.txt in the same directory.
> +- link-gpios: a GPIO line used for the link detection interrupt
>=20
>=20
>  Example (for Raspberry Pi with pin control stuff for GPIO irq):
> @@ -38,13 +39,14 @@ Example (for Raspberry Pi with pin control stuff=20
> for GPIO irq):
>  		interrupt-parent =3D <&gpio>;
>  		interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
>  		spi-max-frequency =3D <30000000>;
> +		link-gpios =3D <&gpio 4 GPIO_ACTIVE_HIGH>;
>  	};
>  };

Ok, so you are using the binding I suggested originally,
which I think is fine here, but note that Rob asked for
the binding to be converted to yaml format in
https://lore.kernel.org/all/20260427145010.GA2502144-robh@kernel.org/

I avoiding touching it by just removing the broken implementation,
but it would be good if you could do this now.

> +
> +		priv->link_irq =3D gpiod_to_irq(priv->link_gpio);
> +		if (priv->link_irq < 0) {
> +			err =3D priv->link_irq;
> +			goto err_gpio;
> +		}
> +
> +		err =3D request_any_context_irq(priv->link_irq, w5100_detect_link,
> +					      IRQF_TRIGGER_RISING |
> +						      IRQF_TRIGGER_FALLING,
> +					      link_name, priv->ndev);

I think you can just use a hardcoded link name here, and
an open-coded gpiod_to_irq(priv->link_gpio) for simplicity. My
previous version kept this from the original code, but if you
reintroduce it, you can improve it further (as you did elsewhere
already)

I would probably also use devm_request_threaded_irq()

> @@ -840,6 +918,7 @@ static int w5100_suspend(struct device *dev)
>=20
>  	if (netif_running(ndev)) {
>  		netif_carrier_off(ndev);
> +
>  		netif_device_detach(ndev);
...
>  		w5100_hw_close(priv);
>  	}
> +
>  	return 0;

The whitespace changes should not be part of the patch.

     Arnd
