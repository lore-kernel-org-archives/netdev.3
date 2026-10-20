Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501854;
	b=Rl8yXqyAfCBNveJkPtbDfuyzZChP22i49eKOvJyJCfSBlj0En2NId5xivCoiTzGB2gZ2
	 3PLN+1J7DHMRioKCam/3BumN0R6fC77P4TEa2IdIPP0gm1C5Be2zsr94iUvgYY9Qjmcxe
	 H2kAGxF33x0MT7ttMKbHN2mr/X6mC+NmdGHHnydkTmBKEUOE6llNECtz0OPOWJGhKDZNc
	 kYY0d/4AYnIa0CeyJpHrZLW92ykwJGV34XdIFkYZbVIuCH8t8eGKc2E6KA4YqX1dYfVT+
	 7NPujcFsmuFQm3gfbfXkwT9gDXtvP8a6PgJTQ/iEgF7+GGzmrJIhSVvNKUIrDNKPhOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501854;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zQNOmJxt2rSeS/12rmD03FzdRX9RNFsPZNdQNHDQyLg=;
	b=lnD493We1iekv9SUhB2vVIkBpK3+dgpqJoQvxBbof7FUgqIPc4LTT0HCTnbECBVvP7Wo
	 n8PMQRtGmaKRH3akD0ywaXKdWDAzSeV1dahaIeN9SWVQN+xVmeqRDY2ZRaoxFHKH9gZ2X
	 t+fcAXb1uE3RFjWt1e9gxtPYVhqEvgxvibbld0UlIpBLzePVKwdi3DcsMXSI+MOuSsLXJ
	 yNbbdxBsJG7Gux3+/KrstRjAeiLz9u/eQP2QGwiKJpn+JsUtvvX5DWaSN0uOedqYWwP7c
	 Z7hXmGk3a8IbqSbGiFXYFuH+cRdFiEU5LKM5g/mP5RqhrmnNLDZExBQNkEZfvRpwsXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY5hP0gu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250F606A319;
	Tue, 20 Oct 2026 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY5hP0gu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C501F000C5;
	Tue, 20 Oct 2026 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501854;
	bh=zQNOmJxt2rSeS/12rmD03FzdRX9RNFsPZNdQNHDQyLg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GY5hP0gu+LmpD5EJhySCN7FoeRPxL/8LOHk68CUd10RUlpk7ulB6EQ5YJ/p6a6wcQ
	 kbUl36HFvQZzNUUAOk+2vVLq7fXTP7rI5+8demneq2kvheF+EgZC0N7UjbEyeDuqm7
	 X52unML1XWZciIG0vLLbaJzHkiZGaqS3T4a1W96x1nJg+R3MKLodnsnEqyEFZbFkO1
	 186hnOZl9m4V4ecQYHxk0NBDV2LyuzKR6q40cbJ5yDOdhuWxXglfyUxvrfmKEsKLYI
	 QTW3c/6AvdZzmef/E8ySo26VyZ8M7VakV1ZmSSGMt2P5sDNdNt1uprtKQ1Rg5NECD8
	 x8Osww2bcJPQg==
Subject: Re: [PATCH net-next v3 5/9] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
From: netdev-bot+sashiko@kernel.org
To: louisalexis.eyraud@collabora.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, edumazet@kernel.org, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Date: Tue, 20 Oct 2026 13:10:52 +0000
Message-ID: <179250185245.3135.2311591498079484765@kernel.org>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the variant data this patch adds for MT2712, the delay-stage
  dividers are the wrong way round for the hardware, and the RGMII TX…

--

net: stmmac: mediatek: add RX/TX delay stage divider in platform data

This commit adds RMII and RGMII RX/TX delay stage divider fields to
struct mediatek_dwmac_variant. It makes mt2712_set_delay() and
mt8195_set_delay() read the dividers from the variant data instead of
hardcoded constants, and it guards the divisions against a zero divider.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 596411d4a5b2b..cb5bda53edb94 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

[ ... ]

> @@ -258,6 +270,10 @@ static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
>  	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
>  	.rx_delay_max = MT2712_RGMII_DLY_RXC_MAX,
>  	.tx_delay_max = MT2712_RGMII_DLY_TXC_MAX,
> +	.rx_rmii_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV,
> +	.tx_rmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,
> +	.rx_rgmii_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV,
> +	.tx_rgmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,
                                    ^^^^

[Severity: High]

Should this be MT2712_RGMII_DLY_TXC_STAGE_DIV? The RX line above uses
the RGMII constant, and after this line MT2712_RGMII_DLY_TXC_STAGE_DIV
has no users.

Compared with the parent commit, this changes the RGMII TX (GTXC)
divider in mt2712_set_delay() from 550 to 170. The commit message
doesn't mention that change.

There also seems to be a wider problem with the values. The previous
patch in this series defined:

#define MT2712_RMII_DLY_RXC_STAGE_DIV	170 /* 170ps per stage */
#define MT2712_RMII_DLY_TXC_STAGE_DIV	170 /* 170ps per stage */

#define MT2712_RGMII_DLY_RXC_STAGE_DIV	550 /* 550ps per stage */
[ ... ]
#define MT2712_RGMII_DLY_TXC_STAGE_DIV	550 /* 550ps per stage */

The original mt2712_delay_ps2stage() used the opposite mapping:

	case PHY_INTERFACE_MODE_MII:
	case PHY_INTERFACE_MODE_RMII:
		/* 550ps per stage for MII/RMII */
		mac_delay->tx_delay /= 550;
		mac_delay->rx_delay /= 550;
		break;
	[ ... ]
		/* 170ps per stage for RGMII */
		mac_delay->tx_delay /= 170;
		mac_delay->rx_delay /= 170;

The binding in mediatek-dwmac.yaml matches the original code:

      For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
      or will round down. Range 0~31*170.
      For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
      or will round down. Range 0~31*550.

The commit message of that earlier patch also seems to describe the
original code the wrong way round (550 for RGMII, 170 for MII/RMII).

With those values now stored in mt2712_gmac_variant, mt2712_set_delay()
divides by:

  RGMII RX:        550 (originally 170)
  RGMII TX:        170 (correct only because of the constant above)
  MII/RMII RX/TX:  170 (originally 550)

Wouldn't this write the wrong stage counts to PERI_ETH_DLY?

For example, RGMII with mediatek,rx-delay-ps = <1700> gives 3 RXC
stages instead of 10. MII with 1100 ps gives 6 stages instead of 2.

RMII with 5500 ps is inside the binding's 0~31*550 range, but
5500 / 170 = 32. FIELD_PREP() masks that to 0 in the 5-bit
ETH_DLY_*_STAGES field, while the ENABLE bit is still set from
!!rx_delay_stage_val.

The in-tree mt2712-evb (rgmii-rxid, tx-delay-ps = 1530) gets the
expected 9 stages only because of the RMII constant on this line. The
parent commit gave it 2.

This still looks present at the end of the series. Should both parts
be fixed together? That would mean swapping the macro values back
(RGMII = 170, MII/RMII = 550) and using MT2712_RGMII_DLY_TXC_STAGE_DIV
here. Fixing only one of them still leaves RGMII TX at 550.

>  	.dma_bit_mask = 33,
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35%40collabora.com
