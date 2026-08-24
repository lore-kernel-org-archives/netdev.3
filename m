Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34F45DF58;
	Mon, 24 Aug 2026 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587432; cv=none; b=sjjPFXbabjvYwjZBIHycI0XtlUYz71M0h3MBMU/C2PTIf/4oJnkBHp5OicFcjKXU+MMlnmfAtoDHL5t0uktIcGhbBzcxEAUPUUn07+bPEYCfDz/pPNm7WSh30+F9ftWz5+w4r8xMdZSPp1ckIueyzClpfxjBsZ/8dgrxa0rdCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587432; c=relaxed/simple;
	bh=DPaMRJiUgQd8F3lVQCMrtgnk8JfdPAqlkSesXgSjFrM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=L6QTVW8cIoa221JrmEc8mCPhqgZ1DSC1PB6IXkN+CgqGmAVIVwKXEUs6eKV8oNjM9SeQYl47F8/wLCuvNPjBCszADVGm0ovTSXQeLCGIWUJ7XsBgy0kq2YPs24/ic0GvydjjH0+UEkiG/WbGAZrR/55z/apxey60XU4bWKU05po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aMfQljN/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aMfQljN/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 047214E4138D;
	Mon, 24 Aug 2026 16:03:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB11A5FFC1;
	Mon, 24 Aug 2026 16:03:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78E4511C7984B;
	Mon, 24 Aug 2026 18:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787587418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Yw9p/e/gTObI0E0KW0aPmvh3/jojeNij8byOhPchOM=;
	b=aMfQljN/arHfb158wkr6CLAxSet5iYUnnt2uZH3SAyBHHe34JaDMHVlouYUDP/wu9UFPHk
	hhToPHJMaibC6ufFX3eAdBc4N0QOCeo3982Ddg5EQrWbF8Nx4HyjmUWDJUKiY1f9LSiZj+
	Z4qfvh5Sk96mK6eM1+uMQa95BFrAKYezzqHsO7LBQqj5M79l+3mFih7KxEYPtwLavaHp3o
	a3aFmclYXZxSB51anNKIJr9sIm2ahqqrgQkVk/ps+tRSZRlM7kFhE7Yueqf5+hyAy8XQsf
	w4Ct0qOqMzO8kHzgAy56q4Qg0mRmKjqhR8680oSotZYxSN/ShI1rvqATHHzXLQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 18:03:32 +0200
Message-Id: <DKXAUOKYDIWV.B30CB2QWDDXQ@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/3] net: macb: Make sure clk_init_data is
 fully initialized
Cc: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>
To: "Geert Uytterhoeven" <geert+renesas@glider.be>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>, "Jerome Brunet"
 <jbrunet@baylibre.com>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1787240118.git.geert+renesas@glider.be>
 <00772e2fb1f8433a5d6c47dbd28cb4149495e1ab.1787240118.git.geert+renesas@glider.be>
In-Reply-To: <00772e2fb1f8433a5d6c47dbd28cb4149495e1ab.1787240118.git.geert+renesas@glider.be>
X-Last-TLS-Session-Version: TLSv1.3

Hello Geert,

On Fri Aug 21, 2026 at 12:07 PM CEST, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 1476bce77f34d2a5..319e43098f57ed7b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5376,7 +5376,7 @@ static int fu540_c000_clk_init(struct platform_devi=
ce *pdev, struct clk **pclk,
>  			       struct clk **hclk, struct clk **tx_clk,
>  			       struct clk **rx_clk, struct clk **tsu_clk)
>  {
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D {};
>  	int err =3D 0;
> =20
>  	err =3D macb_clk_init_dflt(pdev, pclk, hclk, tx_clk, rx_clk, tsu_clk);

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

I cannot give you a Tested-by because this triggers only on
sifive,fu540-c000-gem compatible matching upstream devicetrees
sifive/hifive-{unleashed,unmatched}-a00.dts

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

