Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA845C704;
	Sun, 11 Oct 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748287; cv=none; b=FZeZwsg18fE4yIlqT+8CTx+LUEvhfqlqq/2eMFWCBbnzLga3Ey0FOmvJ7Rqkcb12Uzse6NwxuHyIpDwrl0XWY/X1SGg8Byivv5rWZgsdRo5Mlxmh15NftzQWIXFxvqTDITyV1XYdFYyK8XsADIsG02httj6nV7XM89EBg/0QLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748287; c=relaxed/simple;
	bh=Tia/gHRnBgpleLE5anqQukYwLXRt7ylF/6759rNAwnA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXhmJOoc5TQx81wVEFDT3vgZayo2wDjn9U41hhObQDLQ3M+NDJHjtbyf6n2Tkjtz5SCQio/n/xewfcbQt07eMUknNkkQ3HDU7+l5MFEGgfd3UBI4bhg9g+ICmZyOZs1MmahGonsaE6tR+XpxAMrKuyga67/VKK9Eo/gY3mRWv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFNSn9UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFNSn9UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C54B1F0089E;
	Sun, 11 Oct 2026 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748285;
	bh=ykj7HNzk8Pdl/5cXAhD96AuzkV87KHVj5gIz43qrl+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eFNSn9UIXIyGva0jbSR15dnvw0ospkV5J8YhC7PdTFz4/k0QYC5YzdUjpdnjIgjWn
	 olZ09tzlmEjkHWHtlDbVoqE5Ezljj1lp8CcBmh885Q0MeTPpAFUp9dRkyNq024NifW
	 KqRcM2Ml8kkuaxqvtIygh+NUlhPWBfC8P9v/BTTyZcLcGgXly179eN5NYtKtjyd/XF
	 SdJmG4fDuKMzS1S4JkIiwx/68HZohHwelL/KgSEkn3rPt95+pewnpkrM3wti8e6FPB
	 Ri0ULvkqAhHzH9pxrTU55FzDa6RvpUAsnyMIm42yI3ZZeZb2EaRdnxEEbd39oMswUK
	 UCD4SXaQiNb3Q==
Subject: Re: [PATCH net-next v3 4/9] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:23 +0000
Message-ID: <179174828389.434549.1449743071786355030@kernel.org>
In-Reply-To: <2b619d04-a3d3-4905-8232-f69be8546fab@yahoo.com>
References: <2b619d04-a3d3-4905-8232-f69be8546fab@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The concern says the family-D branch in
  rtl8365mb_ext_config_rgmii() can never run because no…

--

net: dsa: realtek: rtl8365mb: set RGMII mode for family D

This commit adds family D specific RGMII setup for extension interface 1
in rtl8365mb_ext_config_rgmii(). It clears the EXT1 RGMII TX clock delay
field in EXT_TXC_DLY and binds the RGMII/MII pin mux to MAC7 when MAC4 is
not using extension 1. It also disables SerDes 1, which shares those pins.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 8f3295c232362..c15b88ba7bb5c 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1263,6 +1284,35 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {

[Severity: Low]
This isn't a bug, but can this branch in rtl8365mb_ext_config_rgmii()
run at this point in the series?

At this commit, no rtl8365mb_chip_infos[] entry seems to use
RTL8365MB_FAMILY_D, so the new block looks like dead code for now. The DT
binding in Documentation/devicetree/bindings/net/dsa/realtek.yaml already
lists RTL8367S-VB (0x6642), which puts the binding a little ahead of the
driver while bisecting.

The later patch "net: dsa: realtek: rtl8365mb: add support for
RTL8367S-VB" adds the entry:

    .name = "RTL8367S-VB",
    .chip_id = 0x6642,
    .chip_ver = 0x0010,
    .family = RTL8365MB_FAMILY_D,

That makes this branch reachable and brings the binding and the chip table
back in line. At the intermediate commits, an RTL8367S-VB device tree just
fails chip ID matching, the same as before the series. So I don't see a
runtime regression here, only an ordering detail in the series.

> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_EXT_TXC_DLY,
> +					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
> +		if (ret)
> +			return ret;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
