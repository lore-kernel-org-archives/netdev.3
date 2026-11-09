Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214365;
	b=qs9ZkIOWe8D+7EYtNaXP0cWVqQnRQRXBIEZcZX04uYb+tra98JFfso4dNuxAHZKFUHFJ
	 pQF04v8B3aGVw6ZyHzKvHi3L7IJT4qFcCTktroJ/fbcEldClkxj3wQWbf1HasH6BMqv4a
	 gJQFB7Q6YY37l3mYe/0fV1vVhB0qigltRi0Ro8/jpbzj7k1ZohCC4enwQAAVutYl6S+N0
	 URZsyvnUJtEKz0p4KJWdSX6Egm4/SB1EpLGKnuS+2QHy5nsB4XJP0Z4abWEIcJ9qrnxnK
	 bLQHe1q6+/aEYwW9KcNhRk0jam6AQL0CWceVpWbmYLlCcTKVD3HtiSJlTpyU2RP1BDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214365;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z/b0JCeHd4giR3CDPQxMDvXhf6SqEu80D1hSwgPctUI=;
	b=mRP38G5/UWvDdKdeAFL/AN9bKgy/YJmonoSDSIaDQsYdcFv4gDD43SEA7FZYgtCIo7mh
	 whGY+4fKs/MjFHCQcGfPZH9wCAK2VSiklvQ6W11bedzL99lNtbr372Fuq3bQwifiuocxt
	 XuNX8+VjvgJTBQ3IMreBgSL4bcCoyEUJR7ZOiZpWi+bpTvAeoNvU2fsqbAmWuw/3sklq4
	 ChtCL0TpLKQ17qKKISepNZ8Pd6E4LraQ1jR22sUlibnLTf9YAOSGJkBVT0Ckj6/DeRJzo
	 rvlZZaLV0fejiSi+loGDvHxBhwOWSZBKrdwgCaWbwKJWbrDdWIPrLT6D4m3rqFk8MRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlk6CKgb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27C6082BC9;
	Mon,  9 Nov 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlk6CKgb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB52A1F008A2;
	Mon,  9 Nov 2026 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214364;
	bh=z/b0JCeHd4giR3CDPQxMDvXhf6SqEu80D1hSwgPctUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vlk6CKgbI0SXgj6m96VeKgIX5VY74Ze+pg0jxLjmXFkKScvWLD+HpaDZybYGSUGPk
	 x5wtUIg4hUGOENJD2g7o1Rp8oo4etVeqBago+jqNzs5pWJIh6oTRaGd6zL82aY0R9N
	 XXPwTHks9iSXEMo2lqihlI4Q1DDU1kym7+8+a74UeKnkC+yIeR6XNYjYRZmGHzX4aT
	 dLAk9XsjTy5ms6DyEEP76sUnKmbP7gwCd6GZi+Pptsr18S5tdVHjqTqiy3/HqMntsG
	 unV871D9WXD62XRL2KW4OysoProAqo0DrKBLCtN66LYxGzrQlx09hfl/MuDOqRmXK3
	 w0B+YLYCPJnWQ==
Subject: Re: [PATCH net-next v9 04/11] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
Date: Mon, 09 Nov 2026 08:52:43 +0000
Message-ID: <179421436328.994134.5244949005980013878@kernel.org>
In-Reply-To: <9a9da3fd-2c1c-4911-aa6e-8a2100843bb8@yahoo.com>
References: <9a9da3fd-2c1c-4911-aa6e-8a2100843bb8@yahoo.com>
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

- [Low] On family D (RTL8367S-VB), rtl8365mb_phylink_get_caps() in
  drivers/net/dsa/realtek/rtl8365mb_main.c does not advertise RGMII for…

--

net: dsa: realtek: rtl8365mb: set RGMII mode for family D

For family D, this patch clears the EXT1 RGMII TX clock delay field in
EXT_TXC_DLY. It binds the RGMII/MII pins to MAC7 in TOP_CON0 and disables
SerDes 1 before RGMII is selected. In phylink_get_caps(), RGMII is no
longer advertised on port 7 when TOP_CON0 shows that MAC4 owns
extension 1.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 0d87d6bbe15a7..0b7c124abb1e7 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1799,8 +1847,26 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
>  	 * which remain unimplemented.
>  	 */
>  
> -	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
> -		phy_interface_set_rgmii(config->supported_interfaces);
> +	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
> +		/* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
> +		 * If MAC4 owns them, RGMII on this port cannot work.
> +		 */
> +		if (rtl8365mb_is_d(priv) && extint->id == 1) {
> +			ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
> +			if (ret)
> +				dev_warn(priv->dev,
> +					 "failed to read TOP_CON0, RGMII on port %d disabled: %pe\n",
> +					 port, ERR_PTR(ret));
> +			else if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
> +				dev_warn(priv->dev,
> +					 "port %d: EXT1 is owned by MAC4, RGMII disabled\n",
> +					 port);
> +			else
> +				phy_interface_set_rgmii(config->supported_interfaces);

[Severity: Low]
Is a warning the right log level here? Port 7 may end up with no usable
interface at all.

In the RTL8367S-VB chip table entry added later in the series, port 7 is
described as MII | TMII | RMII | RGMII. RGMII is the only one of those
modes the driver implements. When either branch above skips
phy_interface_set_rgmii(), config->supported_interfaces stays empty, and
phylink_create() rejects that:

drivers/net/phy/phylink.c:phylink_create() {
    ...
	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev,
			"phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);
	}
    ...
}

When port 7 is a user port, dsa_tree_setup_ports() falls back to
dsa_port_setup_as_unused(). When port 7 is the CPU port (the series
supports an RGMII CPU port there), the whole tree setup is aborted:

net/dsa/dsa.c:dsa_tree_setup_ports() {
    ...
		if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp)) {
			err = dsa_port_setup(dp);
			if (err)
				goto teardown;
		}
    ...
}

In that case the switch fails to probe. A warn-level "RGMII disabled"
message suggests the port keeps working in a degraded state.

In the regmap_read() failure branch, the real I/O error is only shown at
warn level. The probe then fails with a generic -EINVAL from phylink.

The commit message says:

  "so the configuration is refused before any EXT1 register is touched"

and:

  "The driver logs a warning naming the conflict."

Could the commit message mention that the port, or the whole switch if
port 7 is the CPU port, will fail to set up? Should these messages be
dev_err() and say that the port cannot be used?

> +		} else {
> +			phy_interface_set_rgmii(config->supported_interfaces);
> +		}
> +	}
>  
>  	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
>  	    mb->sds_supported)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9b73858d-fc09-4988-8bab-fd7b88db9412%40yahoo.com
