Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483764;
	b=sbQPe2S4H4/aJPStSc+slnRp72Gtd8HoFhnRxW04rmL4SbY0uHKYYoOYSIqdrw387xkK
	 AVpe+XLBeojZHg4c9eF4V3c28sD/zeegdlQ4b9Xs0SLRRzBwaIeDmHRU4BXPQT7p94KTl
	 e/SRXTiLtGCvb6hqR9OVk0Pbv5qMxVwGl6938FP/QtM7F0m+vANNUDhvn1Yjo2nU6z9Cu
	 1qFOKHQmunbBusL8LhHdKXy/1nmwrsv6lnxEmiNzDjVR+ZFO2bEf8Zs2vHlnrFA3G/OqJ
	 CXyEQg9VixbNFLOJKqxMoYTFXfp78oPdAJ6+jbHN5raKCGY5HwiWff6kKl6mxn2YiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483764;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LHCiPDk8G+fGsyNfzKoIcyu08B27Kk/9+LmXkWxcOGU=;
	b=YBLpiC5oRzt8f2ntEjVXZ6aybHl3mHGLqem/AEXTIRHElm142WGL+d9MCg0Cj3FPJLWD
	 AynYMWtgu+WQsSsR3UWiDVszC2uS2ao2Xa0Uq067b/hlLpfUuUH4K77zQpmm5f25F8Rnp
	 6cGCUeIkn9o6nR1nAGLnfXzuMNJWWzrVTInVIjVkdaJ6QxvYF0euewJo8u9eSo6qh0F/g
	 8qSP6jNDI1Om59/yFxrdGx6FyeTVhhEheo8t7jouV+H550wVCvF3GsjvLJT8WkwNnTRAi
	 Dak2QbtOr0GxWC8pPVgN0RrTGIJM2OOgC6IezDAJ4xKyH6SdEtJn9J4eKUia7kyxn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoT7n5nD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E49606A320;
	Sat, 31 Oct 2026 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoT7n5nD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B491F0093A;
	Sat, 31 Oct 2026 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793483764;
	bh=LHCiPDk8G+fGsyNfzKoIcyu08B27Kk/9+LmXkWxcOGU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UoT7n5nD+zLB30SY7gvRhDPXLcqlPCO8BrWxXtGmwfY5RUEQYnFk/cqqI8bdC65uQ
	 2ayhax5doUWVfl9d+wqdAE0Ms3F+rgFAGyfAuuPrragl4JJ1+1SEb45MjefGEcbkQG
	 vgEb19iYKcC8DHgQqNIe8OfWsqZqTKd0OU/SDWzA7fKqlbmbevit/l5nUFCxZq8+5z
	 Ox5kUaJSBomgfZG5f0WkQ2W7N8+8Hjm/F8BKLF6TNYKBrDbZiwiWu6UKIemKhUr6UM
	 Q2xwPwAD+kxvZdjKQCh4cch9TRoo3Bto64U5vaJV8+iKymNWlULm1YHAEtiXyeNbiv
	 DfodC0A+iXq3w==
Subject: Re: [PATCH net v3 5/8] net: dsa: b53: use the correct override
 register 2 Gbps bit
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 21:56:02 +0000
Message-ID: <179348376296.3131.18140178740714009002@kernel.org>
In-Reply-To: <20261030211617.288562-6-florian.fainelli@broadcom.com>
References: <20261030211617.288562-6-florian.fainelli@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch makes b53_force_port_config()
  (drivers/net/dsa/b53/b53_common.c) write BIT(7) of the per-port GMII…

--

net: dsa: b53: use the correct override register 2 Gbps bit

The IMP and per-port GMII override registers use swapped bit positions
for override-enable and 2 Gbps speed. This patch adds a per-register
speed2000 bit to b53_force_port_config(). The function then uses that bit
both to clear the 2 Gbps selection on 5301x/58xx and to set it for speed
2000.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 378f47e7250cd..75033b28100ec 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1370,17 +1370,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
>  				  int speed, int duplex,
>  				  bool tx_pause, bool rx_pause)
>  {
> -	u8 reg, val, off;
> +	u8 reg, val, off, speed2000;
>  
>  	/* Override the port settings */
>  	if (port == dev->imp_port) {
>  		off = B53_PORT_OVERRIDE_CTRL;
>  		val = PORT_OVERRIDE_EN;
> +		speed2000 = PORT_OVERRIDE_SPEED_2000M;
>  	} else if (is5325(dev)) {
>  		return;
>  	} else {
>  		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
>  		val = GMII_PO_EN;
> +		speed2000 = GMII_PO_SPEED_2000M;
>  	}
>  
>  	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
> @@ -1392,11 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
>  
>  	reg &= ~(0x3 << GMII_PO_SPEED_S);
>  	if (is5301x(dev) || is58xx(dev))
> -		reg &= ~PORT_OVERRIDE_SPEED_2000M;
> +		reg &= ~speed2000;
>  
>  	switch (speed) {
>  	case 2000:
> -		reg |= PORT_OVERRIDE_SPEED_2000M;
> +		reg |= speed2000;

[Severity: Low]
Should the set in case 2000 use the same is5301x() / is58xx() check as
the clear above it?

On GMII ports, speed2000 is now GMII_PO_SPEED_2000M, and b53_regs.h
documents it as chip-specific:

    #define   GMII_PO_EN			BIT(6) /* Use the register contents */
    #define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */

Before this patch, reg |= PORT_OVERRIDE_SPEED_2000M on a GMII port set
BIT(6). That is GMII_PO_EN, and reg |= val had already set it. So on
chips other than 5301x/58xx, speed 2000 behaved the same as 1000.

With this patch, speed 2000 on a GMII port of any chip that is not
5301x, 58xx or 5325 (for example BCM53125, BCM5395, BCM5389 or BCM63xx)
writes BIT(7) of B53_GMII_PORT_OVERRIDE_CTRL(port). Since the clear is
gated on is5301x(dev) || is58xx(dev), nothing ever clears that bit again
on those chips.

Commit b6a8a5477fe9 gated the clear because this bit position "can have
different meanings on other chips, e.g. for BCM5389 this controls
scanning PHYs". The set path was never gated the same way.

The IMP-port side of this mismatch existed before this patch. This patch
extends it to all GMII ports.

One way to reach it is a DT fixed-link with speed = <2000> on a GMII port:
phylink_parse_fixedlink() only warns and keeps the speed, and phylink then
calls b53_phylink_mac_link_up()->b53_force_port_config() in MLO_AN_FIXED
mode. The 63xx RGMII path in b53_phylink_mac_link_up() reaches the same
function.

Would it be better to gate reg |= speed2000 on is5301x(dev) ||
is58xx(dev), or to reject speed 2000 on other chips?

>  		fallthrough;
>  	case SPEED_1000:
>  		reg |= PORT_OVERRIDE_SPEED_1000M;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030211617.288562-1-florian.fainelli%40broadcom.com
