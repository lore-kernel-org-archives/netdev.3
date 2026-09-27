Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0541D212;
	Sun, 27 Sep 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526557; cv=none; b=Kd1v2YEFgWR1sC/JxrJtAL1KpcbUrQXobViFIpBt26Rhc428kaiNsSkJFUmPzvnbVUxF5zDfXe2rv/DniUKHMblvrAC9I/Iznt49jVCbF5Z34oFU2Nmh1LOzaNaxmdjgk+Enj9kTHIS+eA0rosR86J7cnpJ9++7+GNQYfbfdrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526557; c=relaxed/simple;
	bh=q8JtvtTq8z4+iX7IRRQ56bggqOSa857gQn1IPNE2nJg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8Q3Tb+R6FaFoJKLiE0jk39Vis0i4rs25Mcq88lSnq9/iBdg/j4oLQ6/jpG8SgKKUxyY1zXS46YbbidgCBMTNMZUqHrRgtjsS48m0MXhCyU3OcvepDlDFsjunLL2lw3W4ohlenh0opaP5SYCz7Wl4RYbF4KT/8MyYW6bOYkfBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDY33W3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDY33W3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B31F00893;
	Sun, 27 Sep 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526555;
	bh=Gu8ErsYBV4PgFuSVNd6NTMG6a/XMTjplo6GasQz5ZLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iDY33W3T4QiioPZtBknBI0Hq0QgYFuTcCI7P1JfrkjQgq1FCbxJ1S8bhxkF6Mj8V4
	 CmD4CJv5XTM/MAPSN4+zoZmBy3jcKvTOXF5u+gi5KNLLj0V2Nxs0PDwqqW1sRfmpSW
	 dDL/CSRmlVQtRYf3EPkIIl8orwyCtq2sO4OeN0mWIk1TIKXxbadkhug4vJrrfxbnu+
	 SKik9AGA1zrqyXJv93oBRLX7Z7Cn9pKD8TveuPwAnt2b9zyz2m6cnv1HqhAj9OfkGm
	 XwaBadjHMC6PZkU/2g7NHVsAOsRBgmAvU7QJny8hm/K3BCFo0tHuL0xiCfq80EyEuM
	 XSOFGK03vXxIA==
Subject: Re: [PATCH net-next v15 5/9] net: stmmac: qcom-ethqos: set serdes
 mode before powerup
From: netdev-bot+sashiko@kernel.org
To: bartosz.golaszewski@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, vkoul@kernel.org,
 peppe.cavallaro@st.com, wens@kernel.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 shawnguo@kernel.org, festevam@gmail.com, jan.petrous@oss.nxp.com, s32@nxp.com,
 mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
 christophe.roullier@foss.st.com, brgl@kernel.org, radu@rendec.net,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dfustini@tenstorrent.com,
 linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 bartosz.golaszewski@linaro.org
Date: Sun, 27 Sep 2026 16:29:12 +0000
Message-ID: <179052655254.2160803.14087106323968541578@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-5-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-5-e82f33720737@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In qcom_ethqos_serdes_powerup()
  (drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c), the patch…

--

net: stmmac: qcom-ethqos: set serdes mode before powerup

This patch adds a call to phy_set_mode_ext() before phy_power_on() in
qcom_ethqos_serdes_powerup(). On SCMI systems the PHY driver needs it to
pick the right performance level, which sets the link speed. It prepares
for adding support for the firmware-managed EMAC on Qualcomm sa8255p.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a1..47b70b5e706f2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -601,10 +601,19 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = phy_set_mode_ext(ethqos->serdes_phy, PHY_MODE_ETHERNET,
> +			       ethqos->phy_mode);
> +	if (ret)
> +		goto err_out;

[Severity: Medium]
What happens here if ethqos->phy_mode is one of the RGMII variants?

qcom_ethqos_probe() accepts RGMII, RGMII_ID, RGMII_RXID and RGMII_TXID.
It installs serdes_powerup whenever a "serdes" PHY is found, whatever the
phy_mode is:

qcom_ethqos_probe() {
    ...
	if (ethqos->serdes_phy) {
		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
	}
    ...
}

The qcom,ethqos binding allows this combination too. It has "phys: true"
and "phy-names: const: serdes", with no condition on phy-mode.

Both SerDes PHY drivers reject any submode other than SGMII, 1000BASEX
and 2500BASEX. In phy-qcom-sgmii-eth.c, qcom_dwmac_sgmii_phy_validate()
is called from qcom_dwmac_sgmii_phy_set_mode():

	if (submode == PHY_INTERFACE_MODE_SGMII ||
	    submode == PHY_INTERFACE_MODE_1000BASEX ||
	    submode == PHY_INTERFACE_MODE_2500BASEX)
		return 0;

	return -EINVAL;

The new qcom_dwmac_sgmii_phy_scmi_validate() in
phy-qcom-sgmii-eth-scmi.c does the same.

Take a DT that sets phy-mode = "rgmii*" and also references an enabled
serdes PHY. With this patch, powerup would fail like this:

stmmac_open()
  stmmac_legacy_serdes_power_up()
    qcom_ethqos_serdes_powerup()
      phy_set_mode_ext()
        qcom_dwmac_sgmii_phy_set_mode()
          qcom_dwmac_sgmii_phy_validate() returns -EINVAL
      goto err_out -> phy_exit()

"SerDes powerup failed" is logged, and both stmmac_open() and
stmmac_resume() fail. Before this patch the same DT powered the SerDes
on without an error.

The other caller of this API in the same file already limits the call to
SerDes modes:

ethqos_mac_finish_serdes() {
    ...
	if (interface == PHY_INTERFACE_MODE_SGMII ||
	    interface == PHY_INTERFACE_MODE_2500BASEX)
		ret = phy_set_mode_ext(ethqos->serdes_phy, PHY_MODE_ETHERNET,
				       interface);
    ...
}

Later patches in the series don't change serdes_powerup. The patch that
updates phy_mode to the resolved interface in mac_finish() only touches
phy_mode inside mac_finish. mac_finish is only installed for SGMII and
2500BASEX, so an RGMII phy_mode would still reach this call at the end
of the series.

I checked the in-tree DTs. The boards that reference a serdes PHY
(lemans.dtsi and monaco.dtsi based) all use sgmii or 2500base-x. The
RGMII boards have no serdes PHY. So "harmless for existing users" holds
for in-tree users, and this only affects DTs the binding allows but that
aren't in the tree.

Should the call be guarded the same way as in ethqos_mac_finish_serdes()
(SGMII, 1000BASEX and 2500BASEX only)? Another option would be to
install serdes_powerup only for SerDes phy-modes in qcom_ethqos_probe(),
or to restrict the binding.

> +
>  	ret = phy_power_on(ethqos->serdes_phy);
>  	if (ret)
> -		phy_exit(ethqos->serdes_phy);
> +		goto err_out;
>  
> +	return 0;
> +
> +err_out:
> +	phy_exit(ethqos->serdes_phy);
>  	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-qcom-sa8255p-emac-v15-0-e82f33720737%40oss.qualcomm.com
