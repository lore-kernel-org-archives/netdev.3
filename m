Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61933E352;
	Mon, 26 Jan 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441183; cv=none; b=YaITRDi1smBgbLP5rhIcQRirM2XTR7ZTcXvisRgS1KHwNXlimDvLtpljE8zOqAUvWiAjpJlEKOt4kwNbkpRROJUJAmeqAl9UR/Q4Igv5Tl/W8hEAnBVoiMh5Bmhjs44dg1MLyTF7h8RMggnvHNIqKK3wopIUi678wEKME7wXwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441183; c=relaxed/simple;
	bh=SRqS+y38YIXOhs6ehnUotQdiVYwta8kYRuUNmf2OMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNyU5008rNg3P/ce1JjCgXd95NJFGZ/AG5AgBAw2JJ806oDXTRjsXkND/8tfbIm7dSOz8S9MffB2wTKLqUCuaoKVTvQAoQlk8RAFXfi+3kCD9/OGOXZC/KblU3byfob4RdIwq5TjeXrZ0oBMerZKpob3PkOghfjjBAyIT9uX0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFnm4LGp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFnm4LGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41F6C116C6;
	Mon, 26 Jan 2026 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769441182;
	bh=SRqS+y38YIXOhs6ehnUotQdiVYwta8kYRuUNmf2OMmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFnm4LGpkWz+9rGWqbjbTkYhQlIVZdBW/EwyRtekVDrdQ1caR9uQeZXFYebihiuw4
	 vuDoe8RjTmdTy83+0hhR7SGWq2uhBFceEsM3x6LmeusdsI1lV/opnKHQt2OZ0iGZIz
	 DkEbKRbdj07Bno5AJp5maVzQenSlEkStldiC1lP9cN/t5AW4i8xNTxf75aFGzTDG7Q
	 hkpyFTm2JsgOYbRctdhgBdHNZi6VO1hYJyIINWKIFJoqRNFORhn7/M6voK4B/0Cwnh
	 +wcllBCvVA3LuTz9Qcm+huRUXFUoc1zTvuYWPHFg+m7J0+ABAAxcmE5ajVaqH9Xrv3
	 4VxmMxAekA34Q==
From: Simon Horman <horms@kernel.org>
To: dan.carpenter@linaro.org
Cc: Simon Horman <horms@kernel.org>,
	robh@kernel.org,
	kuba@kernel.org,
	festevam@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shawnguo@kernel.org,
	mbrugger@suse.com,
	mcoquelin.stm32@gmail.com,
	linaro-s32@linaro.org,
	davem@davemloft.net,
	s.hauer@pengutronix.de,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	Frank.li@nxp.com,
	chester62515@gmail.com,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	pabeni@redhat.com,
	jan.petrous@oss.nxp.com,
	linux-stm32@st-md-mailman.stormreply.com,
	s32@nxp.com
Subject: Re: [v4,1/3] net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
Date: Mon, 26 Jan 2026 15:24:30 +0000
Message-ID: <20260126152430.1390514-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
References: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII

This commit adds syscon/regmap support for accessing the GMAC_0_CTRL_STS
register on s32 chipsets, while maintaining backwards compatibility with
the existing direct MMIO approach for older device trees.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..2e6bb41f49e1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c

[ ... ]

> @@ -40,7 +44,10 @@ struct s32_priv_data {
>
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	if (gmac->ctrl_sts)
> +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	else
> +		regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);

Should the regmap_write() return value be checked here? The function
returns int and the caller s32_gmac_init() checks the return value
expecting errors to be propagated. For comparison, dwmac-sun55i.c in
sun55i_gmac200_set_syscon() does check regmap_write() return value:

    ret = regmap_write(regmap, SYSCON_REG, reg);
    if (ret < 0)
        return dev_err_probe(dev, ret, "Failed to write to syscon\n");

>
>  	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
>
>  	return 0;

[ ... ]
