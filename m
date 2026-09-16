Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B80374A19;
	Wed, 16 Sep 2026 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539908; cv=none; b=snO5RPXVK7bnD+uAXaPB3qw0KlBgbv/QYkRoOrIhpSvS9BrjNdCi4zLuLxnbi59L53gszG7dH4yQr++ZFsLBMQNfygqzFCcRezWL/+Y6fjMG2YeNzYds9UDpnw74EuELOlPWBU4Uqly8k7CJwlFltDd2oxlVWsgTsr960Pw4uBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539908; c=relaxed/simple;
	bh=cw0c5kCd4TkBM5hZwhK2cpHUzr2qmrocyJfRwyF5558=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWeHIyrtCoadS7v7A3mg29IJCg9QaSE+SD1B214uS8IRT22maMosmT3QH7ASHAFfTx4nV7tQdWwrCMaTcpBINowSbTquZYEsAij8sxgfjOLqm+a//KnRDJbTFQh9t/QxsU08oUx2JPUvOkUJfy8jp+WkpUztvcMvbE+L7UtDu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y98w0ZPF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y98w0ZPF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EE0A21A0887;
	Wed, 16 Sep 2026 06:25:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B74B160337;
	Wed, 16 Sep 2026 06:25:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18C7511C7AFE7;
	Wed, 16 Sep 2026 08:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789539900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jabO0Vkelw7YcG1ABQs8mqKscqLCLVOyf7S9T+mfSyc=;
	b=Y98w0ZPF+sNCwXVAxHFjCeiyJ+M9FlZR3R2c9wasf1cNUtPJWT+zItZFrYnxjaf/YyRCOp
	/o1iCcX1HWCVrDa83SMc189JL9PmH0jyIGJ/26KZMtGdoqIIPv9UWQI2eTMjpNTD1+kVz8
	Qiui8abKYXvE4i2bKCh30zvX50N+mHfx98VbT3kbeCBlCO1WHj5oQttlJnQM8EF9H8jSmj
	YJ17jBpkkDhejj8OCzCObk/+E+0NFIGOPB/MGouT4/z56X1cGwZMYRi5ccNlIqoDX622qI
	3+s57szpuuFoD7udZRPVCTT7Si6RD61IvtnqJiW2WFL9zefMNlMyQTAKPn9jKw==
Message-ID: <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
Date: Wed, 16 Sep 2026 08:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: stmmac: dwmac-sun8i: Add Allwinner H616
 EMAC clock index and internal PHY support
To: Alastair D'Silva <alastair@d-silva.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 richard.genoud@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-5-alastair@d-silva.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260916044119.475666-5-alastair@d-silva.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/16/26 06:41, Alastair D'Silva wrote:
> Support EMAC1 and the internal Fast Ethernet PHY (AC300) on Allwinner
> H616 and H618 SoCs:
> - Allow reading a register index from the syscon property to offset the
>   regmap field for EMAC1's dedicated clock control register.
> - Add emac_variant_h616_internal with support for internal PHY, MII,
>   RMII, and RGMII modes.
> - Delay the MAC software reset until sun8i_dwmac_init() when using the
>   internal PHY, ensuring the PHY has powered on and begun generating
>   the receive clock before the MAC attempts to reset.
> - Skip setting H3_EPHY_SELECT for H616 internal EMAC, which does not
>   use the H3-style EPHY select bit.
> - Handle -EPROBE_DEFER cleanly during clock and reset control acquisition
>   in get_ephy_nodes().
> 
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Even if this is a duplicate some of the work done by James Hilliard, this
raises interesting points.

> Notes:
>     Tested on Mellow Fly-C5 (Allwinner H618) under Armbian, verifying stable
>     EMAC1 probe, deferred soft reset with the internal AC300 EPHY, and 100M full
>     duplex operation under load.
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 65 ++++++++++++++++---
>  1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb96233..1728893589a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -130,6 +130,16 @@ static const struct emac_variant emac_variant_a64 = {
>  	.tx_delay_max = 7,
>  };
>  
> +static const struct emac_variant emac_variant_h616_internal = {
> +	.syscon_field = &sun8i_syscon_reg_field,
> +	.soc_has_internal_phy = true,
> +	.support_mii = true,
> +	.support_rmii = true,
> +	.support_rgmii = true,
> +	.rx_delay_max = 31,
> +	.tx_delay_max = 7,
> +};
James's series [1] says this SoC only supports RMII (yet includes RGMII timing
control), and here for seemingly the same device, there's MII and RGMII
support listed.

[1] : https://lore.kernel.org/r/20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com

Maybe you can coordinate with one another, can we connect that SoC to a non-internal PHY ?
If so, can we use MII, RMII and RGMII ? or is it just RMII ?

Maxime
