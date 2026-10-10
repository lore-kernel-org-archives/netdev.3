Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556E34F46D;
	Sat, 10 Oct 2026 05:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609256; cv=none; b=DjvV7wolmEERrm+7RfqJDA1sou+vkxBlAIMA3ZeWkzZr5dFLKAXmFUGQZsjAHwiPaNXYKj1HiNcI4meFO8FagGTvD0kaOmG7i62lDqAK7dKK7441GAThK1SBKFV+/p5J7DcsduNBsFVfx9dmwOV+pzUFAH2rg3IniiHsRT0NNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609256; c=relaxed/simple;
	bh=M/fY0Zwp0KgaNL3HaS323uPgGyXRXYcpOc21x4gRM1A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DucwWW4zy4bq37NsbI2ipiJxTZRi/hRgG4pxyt1Wjw7CgxsuuQQHCeYnbsLQV7ceJh5IbsGNukURmXVagL2ykLzCyuY/FjAYzfDGt8gRyhI0PzTOcYbv95QIOClOsj3a/sNR+RTG3SdsJkgbiJUJ6ZxcX3aRp3HKCBAufRWsMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKVC3fjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKVC3fjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3101F000FF;
	Sat, 10 Oct 2026 05:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609254;
	bh=pMQWyaaVfY7hicmWCDHwvSG957W1lxSNDiZb8O6H47o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MKVC3fjLf46FoFoqpQLLK/xQWFCvoNfTk0If/LmjLaN1P1c4eiitGzD3yM5oLuBmi
	 2JHJcz1ITDj91p574HGtHeCuzlJolht8n2rRc7zKSJjmPX+3Fe85VPSjSSvMiHfkjp
	 fhSgocU5TSDGXjTiQdr6nK/QtanEe0E2cM5+idB6myGC7kUI9g9YPxuXVruHyXTjJ9
	 0pl9MqaYys6swFKe04+GvNAMzQrt9qVv44t88nu0SlupKrubfeN2+QIdIQW8ZYQE14
	 1xK5MmWBT22htCxWbir7XQCFsCc6cijglPGHtM1H3AE74NBI1SpHDBIx3ZhtIe4tQD
	 YoibK0mbTl8xA==
Subject:
 Re: [PATCH net-next v2 1/8] net: dsa: realtek: rtl8365mb: detect RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:13 +0000
Message-ID: <179160925352.434549.12136746885800799801@kernel.org>
In-Reply-To: <29f75a64-fed4-449c-92c5-c0b67f270504@yahoo.com>
References: <29f75a64-fed4-449c-92c5-c0b67f270504@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Not a final-state bug: a later patch in this series fixes it.
- [Low] The file header comment in
  drivers/net/dsa/realtek/rtl8365mb_main.c adds RTL8367S-VB to the list…
- [Low] The driver now recognises RTL8367S-VB (chip_id 0x6642, chip_ver
  0x0010) under the existing compatible "realtek,rtl8365mb", and its…

--

net: dsa: realtek: rtl8365mb: detect RTL8367S-VB

This adds detection of the RTL8367S-VB (chip_id 0x6642, chip_ver 0x0010).
It introduces a family C / family D split in the chip_info table. The
RTL8367S-VB entry is tagged as family D with SGMII/HSGMII on ext_int 0,
and priv->num_ports is capped at 8 for family D.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index da06f952a053d..80fc551992195 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -81,6 +81,7 @@
>   *  - RTL8367RB-VB
>   *  - RTL8367SB
>   *  - RTL8367S
> + *  - RTL8367S-VB
>   *  - RTL8370MB
>   *  - RTL8310SR
>   *

[Severity: Low]
This isn't a bug, but the header comment now puts RTL8367S-VB in the list
introduced by "According to documentation from Realtek, the family should
include the following chips". That list describes the single RTL8367C
family the driver targets.

The same comment block also separates out chips that "require the rtl8367d
vendor driver". The new chip_info entry tags RTL8367S-VB as
RTL8365MB_FAMILY_D, so the comment and the code disagree about the
chip's family.

The comment above RTL8365MB_LEARN_LIMIT_MAX also still describes one
family:

  /* Valid for the whole family except RTL8370B, which has 4160 entries.
   * RTL8370B is mentioned in vendor code but it might not even belong
   * to the same RTL8367C family.
   */

The 2112 limit now applies to family D chips as well.

Could these comments be updated to cover the family D split? The mismatch
is still there at the end of the series.

[ ... ]

> @@ -777,6 +786,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.jam_table = rtl8365mb_init_jam_8365mb_vc,
>  		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>  	},
> +	{
> +		.name = "RTL8367S-VB",
> +		.chip_id = 0x6642,
> +		.chip_ver = 0x0010,
> +		.family = RTL8365MB_FAMILY_D,
> +		.extints = {
> +			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },

[Severity: Medium]
On RTL8367S-VB the SerDes sits on ext_int id 0 (port 6) and RGMII sits on
id 1 (port 7). Is rtl8365mb_pcs_config() still correct for this layout at
this point in the series? It hardcodes the family C interface ID:

#define RTL8365MB_SDS_EXT_INTERFACE_ID		1

rtl8365mb_pcs_config() {
	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
	...
	val = mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
	ret = regmap_update_bits(priv->map,
				 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
				 val);
	...
}

RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0 (0x1305) holds EXT0 in bits 3:0
and EXT1 in bits 7:4. On family D this write would therefore put the
SGMII/HSGMII mode into the nibble for port 7's RGMII interface.

rtl8365mb_ext_config_forcemode() works from a different interface. It
forces the link through RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
and extint->id is 0 here.

rtl8365mb_sds_probe_option() doesn't check the family either. If the
family C option register reads non-zero, sds_supported gets set and
phylink can pick SGMII or 2500base-x on port 6:

rtl8365mb_setup()
  rtl8365mb_sds_probe_option()
    mb->sds_supported = true;
...
rtl8365mb_pcs_config()
  regmap_update_bits(..., DIGITAL_INTERFACE_SELECT_REG(1), ...)

Could this break port 7 RGMII, or leave the SerDes mode unset on
RTL8367S-VB?

A later patch in the series, "net: dsa: realtek: rtl8365mb: add family D
SDS13 PCS support", appears to fix this. It adds a family D branch to
rtl8365mb_pcs_config() that skips the DIGITAL_INTERFACE_SELECT write, and
it makes rtl8365mb_sds_probe_option() return early for family D.

Could SerDes modes stay disabled for family D in this patch, so the
intermediate commits remain bisectable?

> +			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
> +				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> +		},
> +		.jam_table = rtl8365mb_init_jam_8365mb_vc,
> +		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
> +	},
>  };

[Severity: Low]
The driver now matches RTL8367S-VB under the existing realtek,rtl8365mb
compatible. Documentation/devicetree/bindings/net/dsa/realtek.yaml wasn't
updated, though, and its model list still reads:

      realtek,rtl8365mb:
        Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
        RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL8367S,
        RTL8367SB, RTL8370MB, RTL8310SR

Should RTL8367S-VB be added to that list? None of the later patches in
the series update the binding.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com
