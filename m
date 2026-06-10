Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73311CAF
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095800; cv=none; b=rhAmv8f/hSBjYbUjDnH2EAWdwfQ3gH1/ZebiihwYKT+HrS8KEWaFfqC+/D/2HGNOZkuBMpOCDMiQgvamnudC1tJybGod6l/7s7YyeIouIVXbWBMy+sBeIL258N5rSwAjDXartxU7U6GMpOVXeLzbtu3js+JUdzYLKQrN55w67w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095800; c=relaxed/simple;
	bh=t/mmtFIpn7BjmbAhOFWnWyWAruOaFZ94gtJYze76RkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K6MShRYe7JlfuzuTk6UQ3vzkeYqD6MUu/ECOqa/ElGIHg9wKM8tfcGKuvxb88S+2QxZ4gYKk6VKXwkwYfBMYzwjKAMYXt+WQVFisEUAz87MRtSfKJLGAhjAEhDEIbDkq9OG05g2RiKGULsAcODi1lRhFDAUSEBGZ20UjSvgULBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oB1cPcaF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oB1cPcaF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E8D844E42DFB;
	Wed, 10 Jun 2026 12:49:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF2865FFC9;
	Wed, 10 Jun 2026 12:49:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3863D106B8540;
	Wed, 10 Jun 2026 14:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781095794; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FTlxtAl4bHdfHTY/b2x8Cm3mgEUhaXXY9Yp0wUvIO80=;
	b=oB1cPcaFAx0PF3eoGV5N0y1vr/83rJElOPl9jNJZYJRgl4RwakZO7flnEAsnIAtbMSHQyh
	LuPlDKaLO/sZlsa6/Wbd8zZ32JSiacu/a3ucQxI5E8WzHwy9b7yvF2x9obg/pv64QuKuuG
	MShQkrYWiu6Y774LKkOeWIVp+mNpXQUSRpaPjqub2+0pxf/wG/exGQ3hOc2a+P5eo6iGr/
	we0orki1WuQGHDLeGQ70uQ3io8Myyx12ovnFTDTk2dlfX26bQYsdN394sHB3FwfMIve0MX
	cnL1yn9yB9mFn0t9XX7bQx7ba8MsFMKOwoft/h4ADYPIKSJTz+H7SvXncOEhfQ==
Message-ID: <f1b441f7-cc5f-4118-9504-82b1fc377f3c@bootlin.com>
Date: Wed, 10 Jun 2026 14:49:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: mdio: realtek-rtl9300: Make
 otto_emdio_read_cmd() generic
To: Markus Stockhausen <markus.stockhausen@gmx.de>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-4-markus.stockhausen@gmx.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260609052856.3142922-4-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Markus,

On 6/9/26 07:28, Markus Stockhausen wrote:
> The otto_emdio_read_cmd() helper still uses RTL9300 specific properties.
> This cannot be made generic as the I/O register has different layouts for
> the different SoCs. E.g.
> 
> - RTL930x: data in bits 31-16, data out bits 15-0
> - RTL931x: data in bits 15-0, data out bits 31-16
> 
> Add a mask parameter to the function signature and fill it properly
> in the callers. As the masks will always have bits set from constant
> defines, there is no need for a consistency check.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---

[...]

>  static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
> -			       struct otto_emdio_cmd_regs *cmd_data, u32 *value)
> +			       struct otto_emdio_cmd_regs *cmd_data, u32 mask, u32 *value)
>  {
>  	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
>  	int ret;
> @@ -205,7 +205,7 @@ static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
>  	if (ret)
>  		return ret;
>  
> -	*value = FIELD_GET(RTL9300_PHY_CTRL_DATA, *value);
> +	*value = (*value & mask) >> __ffs(mask);

If I'm not mistaken, you can use field_get() when the mask isn't constexpr :

https://elixir.bootlin.com/linux/v7.1-rc7/source/include/linux/bitfield.h#L299

With this change, you may add :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

