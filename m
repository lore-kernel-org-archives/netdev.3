Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501863;
	b=L7WCZXtv3LJvIJeSpKSbIQeHXe/NrMgxV6C1TEHszxO8VWv9ptWs/oZ476kBJP3F211i
	 AowY/bnnPjssR7XKXDPauqV2A6a8t8nkhWJL3EHlb7Sem9tecTVZD573WGHfL7nN5iVQX
	 O8anjqU/3+g8nXhI7Ustv8QK4F0c2zmlC9vWvtLq5qtMVEqXxP16b+LwwGHMAxKRxaReZ
	 Q32l9ETyT3eWSO+m8diouHLj0nhlBYWtOzlKfu+NPzAZz1fLIXYTFZHc8XTJAF36MIsE1
	 cvWGxssNj2NTfBWpSetR0OtLpNVhHZ0RSFOEzIKjRUZrymLo12Z0oy6LmeqN4wZTdVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501863;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WcNEi9CgsmU0LNhm6ygVBGSAUr7Sk7BxZ5A17QlLUg0=;
	b=bCMiVUDSmBl8kn9ueBhNpifXkZK3bCw7N2+FH0M3uruOkCsfDI8YoLjnBO/5p/nmzdK3
	 /YwQ9Elj1XTRlhU8QACXzXxP9YdWlrhxL+xRFBw3Q34LstqxCLNCmQIOzK5SB3QHYrsf8
	 a1ZHsipdcX2QsotuVAdgfgdsU2ibpwVPzKjxlc44zhUFQC0j1E6VGByfCFe9aXKTx0tIr
	 fBTb8I47PWU9bjZGVAcISUDD9WkyvZEIKHhy3zH5kLhrPX7N/m0Tk+O4yIY2fsvmuHdCn
	 oihhQtSxrwIDUA86gcUgbi2DfxhFdsi90pVqRY8fTYwAw3IwEwtyL0UDEpa8yDtv3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNxqOimF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48960A3803;
	Tue, 20 Oct 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNxqOimF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A6E1F000C6;
	Tue, 20 Oct 2026 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501858;
	bh=WcNEi9CgsmU0LNhm6ygVBGSAUr7Sk7BxZ5A17QlLUg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fNxqOimF6pNiEdwKUDbYKaNJUsg5JVDCfETgunUpmQNq2aG6FrZRNjfI04W1yg0Ox
	 kJ7w8tOOFbOQHjuLKpDrJDo0CvOZ3ZjznN1nkI/TuYUdIDPybr3e2RE5Ev6D3HHHJq
	 obmqonoXhZxlQUMrKZpe3n3GYUqjaVYUQ51CSkvZxlQftS1rE5IG73vLx/1iPf2p32
	 znUrQZmQ9nsz6np8XwEnL8HBSf+FFPQ4ScPI+DSUU0pG1fvmA3QGxOdzzXduQHACEx
	 Gn68hLNYeadrLx+TQER34PnmxpvUL1M8z52CusRzXXeB5pLjy0rvyWvwGGOFk2aMxk
	 76fizPopi6ylw==
Subject:
 Re: [PATCH net-next v3 9/9] net: stmmac: mediatek: add support for MT8189 SoC
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
Date: Tue, 20 Oct 2026 13:10:56 +0000
Message-ID: <179250185640.3135.8563969041455803395@kernel.org>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-9-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-9-25daf2bbcf35@collabora.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The series reverses the MT2712 delay-stage dividers compared
  with the baseline driver and the binding.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but in
  mediatek_dwmac_clks_config(), if clk_bulk_prepare_enable() succeeds…

--

net: stmmac: mediatek: add support for MT8189 SoC

This patch adds the mediatek,mt8189-gmac compatible to dwmac-mediatek,
along with a clock list and variant platform data. The new variant reuses
the MT8195 callbacks with a 0x270 pericfg offset and 180ps RX/TX delay
stage dividers, and it enables the TX clock output.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 147e217b86620..d480c339a16d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -45,8 +45,15 @@
>  #define MT2712_RGMII_DLY_TXC_MAX	17600 /* 32 x 550ps */

[Severity: Medium]
The context here shows the MT2712 defines added earlier in this series. Are
the MT2712 RGMII and RMII stage dividers swapped?

The defines currently read:

#define MT2712_RMII_DLY_RXC_STAGE_DIV	170 /* 170ps per stage */
#define MT2712_RMII_DLY_TXC_STAGE_DIV	170 /* 170ps per stage */

#define MT2712_RGMII_DLY_RXC_STAGE_DIV	550 /* 550ps per stage */
#define MT2712_RGMII_DLY_RXC_MAX	17600 /* 32 x 550ps */
#define MT2712_RGMII_DLY_TXC_STAGE_DIV	550 /* 550ps per stage */

Before the series, mt2712_delay_ps2stage() divided RGMII delays by 170 and
MII/RMII delays by 550. The mediatek-dwmac.yaml binding says the same:

  For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
  ...
  For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,

mt2712_gmac_variant then uses:

	.rx_rmii_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV,
	.tx_rmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,
	.rx_rgmii_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV,
	.tx_rgmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,

mt2712_set_delay() picks these dividers based on the phy mode. RGMII TX
still divides by 170, but only because it uses the RMII define. RGMII RX
now divides by 550 instead of 170. MII/RMII TX and RX now divide by 170
instead of 550.

For example, an RGMII mediatek,rx-delay-ps = <1530> used to program 9
stages and now programs 2. An MII/RMII delay of 1650 used to program 3
stages and now programs 9.

This came from two earlier patches in this series, not from this one:
"net: stmmac: mediatek: simplify TX/RX delay handling in mt2712_set_delay"
and "net: stmmac: mediatek: add RX/TX delay stage divider in platform
data". The first one's commit message also describes the old code as
"550 for RGMII, 170 for MII/RMII".

Changing only tx_rgmii_delay_stage_div to MT2712_RGMII_DLY_TXC_STAGE_DIV
would make things worse. mt2712-evb.dts (phy-mode "rgmii-rxid",
mediatek,tx-delay-ps = <1530>) would drop from 9 stages to 2.

Could the define values be swapped instead (RGMII = 170, RMII = 550), with
tx_rgmii_delay_stage_div then using the RGMII define?

[ ... ]

> @@ -751,6 +777,8 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
>  static const struct of_device_id mediatek_dwmac_match[] = {
>  	{ .compatible = "mediatek,mt2712-gmac",
>  	  .data = &mt2712_gmac_variant },
> +	{ .compatible = "mediatek,mt8189-gmac",
> +	  .data = &mt8189_gmac_variant },

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
MT8189 now uses the same probe path. In mediatek_dwmac_clks_config(), if
clk_bulk_prepare_enable() succeeds and clk_prepare_enable() then fails on
plat->rmii_internal_clk, do the bulk clocks stay enabled?

drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c:mediatek_dwmac_clks_config() {
    ...
	ret = clk_bulk_prepare_enable(variant->num_clks, plat->clks);
	...
	ret = clk_prepare_enable(plat->rmii_internal_clk);
	if (ret) {
		dev_err(plat->dev, "failed to enable rmii internal clk, err = %d\n", ret);
		return ret;
	}
    ...
}

This path never calls clk_bulk_disable_unprepare(), and
mediatek_dwmac_probe() returns the error directly:

	ret = mediatek_dwmac_clks_config(priv_plat, true);
	if (ret)
		return ret;

The resume path behaves the same way.

For MT8189, rmii_internal_clk is only obtained when
mediatek,rmii-clk-from-mac is present, and the MT8189 binding forbids that
property. A binding-compliant MT8189 DT therefore gets a NULL clock and
cannot hit this path, but the driver does not enforce the binding.

>  	{ .compatible = "mediatek,mt8195-gmac",
>  	  .data = &mt8195_gmac_variant },
>  	{ }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35%40collabora.com
