Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67664746A3;
	Fri, 24 Jul 2026 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933181; cv=none; b=HxO16wRuO/tFhEDsJd2YQllqAXS8/IJ0CgOB+d3zn73X74QxBZeX3a4XLoSw0JdFssDf4tF7XDWbtHrlzBeZhlNFsUPszcn72W5iCvi1kF5PiFLwEHqKZtK2uuskD6o8AaKSLW2bZXgIPy+MGuc2CtxQiJZSZw0NCKiWRdh+SjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933181; c=relaxed/simple;
	bh=5h3/hVOTJiRIciAZzBSRPdsrEV/CPJS70Btcat84KYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhugCXhDuV/r1NTLFYNoIz0ujOQz+sp8Ul8Q+zhwIerGEBJ1QAxCf+WSv91KdeXI2IJ5CtmhuO1xSwXc0qI4gqWxDCFZ/CqsH4UVDxLnSfpHTvQRliAmd3Q2fHZGBUMy5aK3r8X5MdVWhsAWL81R3vFDst0VnnNdV4B+Xq/WFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNutic3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNutic3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F21F00AC4;
	Fri, 24 Jul 2026 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933164;
	bh=K125TY74W87vhbOlzJ/FpCa02u74B+oM2H9sVUMeeOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNutic3y4iV6+eyYcy4rwQNwLeQzrjFdAqTJiqrBOyOEWptY1tUjsPrZCB7a+2Rce
	 7WKRN2fpfQ1BH4OSNlv8Ygz7piMxGyuqiTFOB8siO1bB/P+YFJYYg/dEVTSiGcUTE8
	 vnkofqb9758AL8BRwmY7SqDav0yzD69GE//A7v8wrhXIdBukMFDnjNUXOlaQv8a7bg
	 IIDvyg+zxVPf1kHcdIsUIza3Z+0MpbDf5Hv1uMxPb9oZ07wF+23iVfKnQBx42N2MsD
	 63lPpGj83DQB5USxWPX/mQEXEEV6YfJSeeDPKCHeiIPK+rS8ur8iXo7sySJCthZoVE
	 H0eTUUDBYX25Q==
From: Jakub Kicinski <kuba@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vkoul@kernel.org,
	peppe.cavallaro@st.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	shawnguo@kernel.org,
	festevam@gmail.com,
	jan.petrous@oss.nxp.com,
	s32@nxp.com,
	mohd.anwar@oss.qualcomm.com,
	romain.gantois@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mripard@kernel.org,
	christophe.roullier@foss.st.com,
	brgl@kernel.org,
	radu@rendec.net,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	dfustini@tenstorrent.com,
	linux-sunxi@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH net-next v13 09/10] net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
Date: Fri, 24 Jul 2026 15:46:02 -0700
Message-ID: <20260724224602.1650002-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-qcom-sa8255p-emac-v13-9-119f8699ef8e@oss.qualcomm.com>
References: <20260713-qcom-sa8255p-emac-v13-9-119f8699ef8e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function

This refactor extends ethqos_emac_driver_data with a setup() callback,
implements it for the existing models, and moves operations not required
in SCMI mode into it, in preparation for firmware-controlled EMAC
variants.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 43384960278b..3af1608fc21c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -5,6 +5,7 @@
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/phy.h>
>  #include <linux/phy/phy.h>

[Low]
Is there a reason linux/pm_domain.h is added here?  Looking through
this commit, no pm_domain symbols (pm_genpd_*, dev_pm_domain_*,
PD_FLAG_*, etc.) appear to be referenced.

The header seems to belong with the follow-up patch that introduces
devm_pm_domain_attach_list() and struct dev_pm_domain_list usage.

Would it be preferable to move this include into the patch that
actually needs it, so each patch remains self-contained?

[ ... ]

> @@ -765,21 +815,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
>  				     "Failed to get serdes phy\n");
>  
> -	ethqos_set_clk_tx_rate(ethqos, NULL, plat_dat->phy_interface,
> -			       SPEED_1000);
> -
> -	qcom_ethqos_set_sgmii_loopback(ethqos, true);
> -	ethqos_set_func_clk_en(ethqos);
> -
> -	/* The clocks are controlled by firmware, so we don't know for certain
> -	 * what clock rate is being used. Hardware documentation mentions that
> -	 * the AHB slave clock will be in the range of 50 to 100MHz, which
> -	 * equates to a MDC between 1.19 and 2.38MHz.
> -	 */
>  	plat_dat->clk_csr = STMMAC_CSR_60_100M;
>  	plat_dat->bsp_priv = ethqos;
> -	plat_dat->set_clk_tx_rate = ethqos_set_clk_tx_rate;
> -	plat_dat->dump_debug_regs = rgmii_dump;
>  	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
>  	plat_dat->core_type = DWMAC_CORE_GMAC4;
>  	if (data->has_emac_ge_3)

[Low]
Was the comment above plat_dat->clk_csr = STMMAC_CSR_60_100M; intended
to be dropped?

The assignment itself is preserved, but the rationale for choosing
STMMAC_CSR_60_100M (firmware-controlled AHB clock in the 50-100MHz
range yielding an MDC between 1.19 and 2.38MHz) is now gone.

The commit message describes a mechanical refactor and does not
mention removing this rationale.  Should the comment be kept next to
the assignment, or moved into ethqos_hlos_setup() where the
surrounding clock setup now lives?
