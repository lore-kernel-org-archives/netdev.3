Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83B483811
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401277; cv=none; b=egjW9k6stv13yiTqAcZh1g8fOgS9jDlenvvMcOpfFTlnL2Uu9pHZKXOLfya5jfy4VxZo6CFbXYFt8kjFDp42AgEtN2cpLdKf4YHAt2YHX9n33N5gmFwD81lZMXpJ6HsK/9l5WBXNl/Mt0bTYR6mkzjQ59ti27AXMLe0W7NmNQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401277; c=relaxed/simple;
	bh=dWR9g7GBpYjyCGJGKKhP/W42O462sZEZBJ5FfbgrmQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZDNM6fIXtMc6ndwR2Dg8LHJjAx/irBlqTOgAcl4gdjDxaml6ODdzUQNd3tce6h4Q8Pxoqico74B1zirNr3hY1wDni9hIzsnF9zUvqIzQH1S9Yj+6HQaWStbOoNMeqTYL9YyXmKckprc4cV6/bC8ApFlAa/aA/bNY+A9UXIazS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fEf0wvbc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJHQLV2z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fEf0wvbc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJHQLV2z"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OmRO3305151
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QTnLRYsj78blmQKt2A1zuJNV
	0HFF9cbULACp8sWIgiQ=; b=fEf0wvbcRbeM+z7ejAcuGsesqZiQkFCr7sfYxlP6
	neRDfXYoRhXiDN0FuK57H3r4s8slyzunOha/z5rj7S0SVwJ5n4NFhnSyJn3HbJ88
	ReEdApg5145ZFiVkv+lYUd41At8YZBQozSO3WZiOjRvfa17aIsPJa+EPNgoq1mgZ
	TFclDmr/oiy7x3wzqQZR+yanfdWnD7Qs7hQrW00saYJNhidlDSnyHx4QoXPHOIJ3
	1bx+U+2cdbCK9fpxuuES5Hmf2xXWyttmN7j1oufUKR1DN9TQLjGfLLuRA6omJtCE
	o7AifS9ru+MpUbdILtJQ2Asfiu+97jccRvlolEj6Oj95mw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gb3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:14:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4792636eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401274; x=1793006074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QTnLRYsj78blmQKt2A1zuJNV0HFF9cbULACp8sWIgiQ=;
        b=RJHQLV2zKAuoMyiiglyarBGCn0FvxqPNPxfRE7csxKj6jeOqawNB6xPL+vUW2Ec7nV
         Se8MtDC1LngvOtZf5GoKIPmK8fczF6FVAiBUdZjgsIUhV8puHs3icxWhfn+p8MusW1eL
         gvniZYfpMsG2qi4zZovFOt0LskW3ctwL4lvYeWzf/kXSsdp83Kvz4Xx/oXTG0e9w86F8
         UEncbYF3kSR969y0SMCWjdYl0oJ+rhQAvmRZW69WYYgjdkcxzQpQNbmpImxnzci1KPHY
         GjrWnqXYxB5E++7XCHfHk3OlzTYDy07F4kiVEaGAAVzLJaBS95JKZDyCbyZu19wvZXC4
         eu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401274; x=1793006074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTnLRYsj78blmQKt2A1zuJNV0HFF9cbULACp8sWIgiQ=;
        b=JVZZ/7K9mJAIvZo35vWTYpLmiFXsuRWXtuZYD+TdAoNqbp72qA+3ezfnHmRJWoRQ3h
         A0jKfKfbGLi2iJ+nZbEzvEXgSfKtKCK71qs+fQCgm6mWMFxBAaa4NS1zcPgYzGerSb0b
         U/296WVFU7442CZ7cvJEeUt8IgJlCHJHjr3YMP7MIHX6mFNdimi7whF4O7OB43fqA9OG
         /F16ZxBL0/k3Bf1yGjSQevGyPcm8oGh3Jrykub7N8sNNvXu6bvo9RtuZXA0pBq4S0B37
         U3KcOx2sm/d2cPxNDNNLB2QbuAROT4c4kNV1pxFGXBUnzHVBx1v/qDDZhVMm9pboWVFk
         mg1g==
X-Forwarded-Encrypted: i=1; AKwUvBwojjQd9+U9UpjKCHlARjmfKo4FhvbW0xF35Db6TcKo6BLeFIQC4sAi7EDACyLpJMuy+ynq2Xk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKWeoBTfDsWpcqT/f1vi1FAJqQltXKjJVC2t3ZBkYZvyoUDLfK
	ec5y8VGRiEsPC32LTgDoAWzP2XVIV8rkxumXq00k0ELOszjFLbaQjt+pdTa4c4PBojxQXiCtl6h
	6NbkX7saH5GTB6sKpzdfREPoj9ycgo3XE94pJ+jZ/tfPNTA7pM8vJTomVfNc=
X-Gm-Gg: AYBFou3EJZGpcAS4YrTqwxfttX0XZIcwxjnaKpeKQNbsvHlTwj1oNOiJ92M+RS4Cudo
	flHaMOtN+9X6zJ5pYD6E0iepseXA5vZc7FjTzsXiU9dqv/F45mA2saFrWXPzPDtSHVsUYf9RWqP
	9SD0fMpSlrTIy7/q53qIqBMo8llSB989lx3VMbFC3M8dyxknbO75NvhpCOMUcjB8C4fDXwFHibv
	P19lWP3ZVfkhGW5616nIwnOa7iOb1ULGImP0Ci8hilzp0DwFxr4eURYWQF98Y2pCSeTdfQ+dSph
	XoGNVHjaxioksMcCdn3HCA3015W/IlQxjztIObdWP/krVkAoILtOF2l/MP82/KdOU98O6TtoCu1
	Le9Rg1xY4mdSg
X-Received: by 2002:a05:7300:e5c2:b0:352:4f11:8118 with SMTP id 5a478bee46e88-361a3813baamr10646766eec.40.1792401273226;
        Mon, 19 Oct 2026 02:14:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e5c2:b0:352:4f11:8118 with SMTP id 5a478bee46e88-361a3813baamr10646746eec.40.1792401272643;
        Mon, 19 Oct 2026 02:14:32 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34130421eec.0.2026.10.19.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:14:31 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:44:21 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Alex Elder <elder@riscstar.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        Daniel Thompson <daniel@riscstar.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        p.zabel@pengutronix.de, peppe.cavallaro@st.com, joabreu@synopsys.com,
        lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: stmmac: support the TC9564 SoC
Message-ID: <atXfbcsXo0d2Z7yc@oss.qualcomm.com>
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-6-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019030129.1470307-6-elder@riscstar.com>
X-Proofpoint-ORIG-GUID: d88chgzQnFFuZZMvuT7Y-Ox22eKo808y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXycsnfSRvn4Iv
 Nzpt4W/6EQnPq8bqq7NGDIx5IDoCM1nasDx8meXCn2ETCdmQy5Q1oMjKr0aqYFo58NS/NEiWXf+
 dc/Kf7nsIBJbVrI1CwaY4BL6ZDyGLJdmFkk3o+NRBYCglP1hd8n5qHx/AuSybsMTPvb+VgU/fuD
 OTlJgs8pwQSOIBobbDzn7RySH6UQ1w5sg82f6cr3Xifkl85wUUQQAL9fWs41i13Pt0H9IN/zSMT
 yYg1oHnVJKRHosAlB00BoOGdrjcsZD04o4yiomeguDnKdlESgAvCf9xbXGcoHbmwRo87EFgE9xj
 cCtIF1w4m2FDebdwOjWjyC5FH+Dg+XBzvMoBvdKvCBhGvnsSTnqMrjAUVdaEaXMoJbyRbV646/W
 2wGXoL9CaKUuCzlKYyMccyqH+F2odWM/Wf5xDYAH7D22Y+SbgVkhAAHrJ08QE4ugeV+D0/uolU9
 VqkZAPe0hqewM5mjHeQ==
X-Proofpoint-GUID: d88chgzQnFFuZZMvuT7Y-Ox22eKo808y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX03ryDM3MRpVD
 gVwREQTnamzX18n6FtjQ1wRHaGfUNVeSgJoNF6EbZyyyEx8LYgv28uMwLYlZkR1Tg3/CzGWf2hI
 B1IkHRF9HgYGUKWCccIQvzJ+9rmSsq0=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5df7a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ee_2aqc6AAAA:8 a=0b3DlNp43F3Af77sOdMA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190036

Hi Alex,

On Sun, Oct 18, 2026 at 10:01:28PM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Add support for the Ethernet XGMAC functionality present in the
> Toshiba TC9564 SoC.
> 
> The TC9564 is a fairly complex chip that attaches to a host via
> the upstream port of a PCIe switch it implements.  That switch
> has three downstream ports, and one of those has an embedded PCI
> endpoint.  The PCI endpoint implements two PCI functions, and a
> 10 Gbps-capable XGMAC interface is attached to each.
> 
> The TC9564 implements additional peripherals, and access to them
> is provided by a PCI endpoint bus associated with BAR 4 of the
> first PCI function.  A PCI driver sets up the PCI function for
> use, and peripherals using the bus use platform drivers, matched
> by compatible string.
> 
> We use the pci-ep-bus approach for the stmmac driver as well, with
> each PCI function exposing access to its BAR 4 via an endpoint bus.
> The XGMAC device is defined within a pci-ep-bus node, and is bound
> to the platform driver based on its compatible string.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> ...
> +/* Fields and values for the EMACTL registers */
> +#define EMAC_SP_SEL_MASK		GENMASK(3, 0)
> +#define SP_SEL_2500BASEX		4
> +#define SP_SEL_SGMII_1000M		5
> +#define SP_SEL_SGMII_100M		6
> +#define SP_SEL_SGMII_10M		7
> +#define EMAC_PHY_INF_SEL_MASK		GENMASK(5, 4)
> +#define PCS_CLK_PHY			1	/* Clock from PHY */
> +#define EMAC_INV_SGM_SIG_DET		BIT(6)	/* 1 = polarity inverted */
> +#define EMAC_LPIHWCLKEN			BIT(8)	/* 1 = low power mode */
> +#define EMAC_INIT_DONE			BIT(21)
> +

Nit: extra tab before BIT(8) and BIT(21).

> +
> +#define PMA_HWT_REFCK_R_EN			0x1080
> +#define PMA_HWT_REFCK_TERM_EN			0x1090
> +#define PMA_HWT_REFCK_STRIDE			0x0014
> +
> +#define PMA_COMM_CFG_0_1			0x1888
> +#define PMA_COMM_CFG_0_1_STRIDE			0x0008

Nit: extra tab before 0x1090 and 0x0008.

> +
> +static int tc9564_probe_config_dt(struct tc9564_data *td)
> +{
> +	struct platform_device *pdev = to_platform_device(td->dev);
> +	struct device_node *np = td->dev->of_node;
> +	struct plat_stmmacenet_data *plat;
> +	phy_interface_t phy_interface;
> +	struct device *dev = td->dev;
> +	int ret;
> +
> +	ret = device_get_phy_mode(dev);
> +	if (ret < 0)
> +		return -ENODEV;
> +	phy_interface = ret;
> +

Nit: I think the call to devm_stmmac_probe_config_dt() will get the PHY
mode from firmware and store it in plat_dat->phy_interface so this is
probably redundant.

> +	/* The platform structure is allocated with devm_kzalloc() */
> +	plat = devm_stmmac_probe_config_dt(pdev, td->res.mac);
> +	if (IS_ERR(plat))
> +		return PTR_ERR(plat);
> +


> +static int tc9564_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tc9564_data *td;
> +	struct device_node *np;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	td = devm_kzalloc(dev, sizeof(*td), GFP_KERNEL);
> +	if (!td)
> +		return -ENOMEM;
> +
> +	td->dev = dev;
> +
> +	np = dev_of_node(dev);
> +	regmap = syscon_regmap_lookup_by_phandle_args(np,
> +						      "toshiba,config-syscon",
> +						      1, &td->emac_ctl_offset);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "failed to get config regmap\n");
> +	td->config_regmap = regmap;
> +
> +	ret = tc9564_reset_init(td);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize resets\n");
> +
> +	ret = tc9564_clock_init(td);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize clocks\n");
> +
> +	ret = tc9564_probe_config_dt(td);
> +	if (ret)
> +		return ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &td->res);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to initialize stmmac resources\n");
> +
> +	tc9564_mac_enable(td);
> +
> +	ret = stmmac_dvr_probe(dev, td->plat, &td->res);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "failed stmmac probe\n");
> +		goto err_disable_mac;
> +	}

Nit: Could this use devm_stmmac_pltfr_probe() and drop
tc9564_dwmac_remove()?
tc9564_mac_disable() could be registered as the priv->plat->exit
callback.

> +
> +	return 0;
> +
> +err_disable_mac:
> +	tc9564_mac_disable(td);
> +
> +	return ret;
> +}
> +

	Ayaan
