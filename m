Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276039CCEB
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979677; cv=none; b=SpUdsDJKEgDwjfpb+a0fPRNrnAI0RObC7l9x2JOdpu0e2G1eM7BPXVAJfTqfW1rqkh7477cv1plJrBS/4TNfivloQrgAsGTVFcBXdAQ5R/SQUGe1dkdjT0yI7w43D9zCrbHraPNsog6Wro+oDZkDStEKAlmRRH26r+DLJpONclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979677; c=relaxed/simple;
	bh=D0Vog32UN7wt6OyMbt/RQU7FbrnIrXD8jF5dwWA8kBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8CuG3VCZy+08/eGw/Lofv7X4eXBsMZJSkHttim4wc1PeNA9GMvWU+nKoTWCUMKAhHFwiJ29iz0s4OBHIxNCp7PrghZ3zX27M5U1FQIAnSznrGoJ8x70fN50vkwNgNmF6SS2KN/v0cDX+5OG8WxGhyKcyWIx9sl9xnYtL0hG5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+2Mbw4W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hpQr7hU8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+2Mbw4W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hpQr7hU8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689IgDep3140067
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 18:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UjINjCJofxG0Hx+eP6FeXopW
	ezSwVFKw/eXpAnjSr8M=; b=D+2Mbw4Wz1ucLoRCjZZYq5KAD1AGbhsfRnzQHz0c
	NJ/OCD86miYFWT7NTTxn/tDTq1Nt1v0MoZm1WNhedXC8T91qKTtoXwh8h1VXTR5N
	djCIWugcZBIO36+Ro1yyqOMaz8qcEDcATI29LaegHqNzz1wcKuEa62vEzyrQ58Bq
	9632bd9XrcqTC09twWXiLZcHMYQWSIhNK3vEa1lYXJOQMaNLM6sD3HpJvjmac4Fz
	PJo7Rt5tq6PE5Ef2+/UKWuhHTtZTT4yO2KEpxm4JV39E3j7Q1bmKRpMmJcERWe4z
	mp5sxmCC0jDZMS4oMQeIrZUAcFSWmkv5Lllt03sFHHEPOA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg00sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 18:47:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e80ce3597so109839406d6.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788979671; x=1789584471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UjINjCJofxG0Hx+eP6FeXopWezSwVFKw/eXpAnjSr8M=;
        b=hpQr7hU8UsN9Q63oCUF4e8RL0vAFilEvtuH5YRsRE2Q3zAgsuCBZqi9+hjyWNRQI1K
         NOFl/QjuKroZi63qlOiPqbnig/E0t+1rfv1jHo9qeC2dwrDwkVbvegndarEfLPsY4pmH
         p01Amc8K0zxYIoX6oxH67sf0CR1+nif++MG5Pm+9YRsuplvjZioXPNw7Ejt0LLL4P1BL
         /3BjpE5gC9gIadRgHh5J5OPtSd9bg//aSRfdaGE0xSUtBJh4PRtDx2jhS3MCrMwuVTrH
         KMQ46Br5fFHoNeJ4fl7z5f8bsORlci1ZxlD42pYwpf6rQ1pST17eM7tjIG26hFXQx63B
         MRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979671; x=1789584471;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjINjCJofxG0Hx+eP6FeXopWezSwVFKw/eXpAnjSr8M=;
        b=gDf//JC5Wx9MjNJ4ZgRf2TIPC+XFrseuNSsWmmEvqBdluRfpwUv2mQmsI4sF381SD8
         NpKuUMcCdvF6kFR4JQl+ncDpMiTreCe/q4/SQc7Uu+TyXIypZ7xfzPh1vpbLc2REj1hl
         OOwGzwE9PZmCTlkOaDmoIKomRJXBwSsPnspl5iGRHfUTuTSOSvnR/lEyqTv/0oJUlrLU
         k3LJXEZ4gk8Any3fI1V2guemWqFu5iCHa96LNzs2YzLrwDASdWPmY7jNDmAFg64MqsAy
         hj9/CqdSmX4WCynB+rL8uV0lkhNU0dRLJIsTj6QyhAi+z0L6H2nCDkYb/OGrJwfHp3Kr
         0KYg==
X-Forwarded-Encrypted: i=1; AKwUvBxXRkU+AUcw/um2C8upWFqDyzk45DD4CPBi3MbFspxSoKCTJCf9WsXaTIZqPsvA1g3xeWwxPJU=@vger.kernel.org
X-Gm-Message-State: AFuF++kG+36sAarCSWDxullMHjM93vIq1x+VQDbuju5vZr91y93Ul5wY
	fNbk81O7p01JcvN27dbNHogbY52PxirrFed+ZHbkRBqnlLKV+ok+gNGFnd2pToSGGCZIfwfmUh7
	Xw/AzIdfKE9REA+hcrTK4OvlsC9dfbVULKWGTkAS3E7Br5kAeO5jct2Q9gu4=
X-Gm-Gg: AYBFou0lbxe6CxwAdbWoTC+ko55ZI9BFzoJbisGb6S8m5kwEHv2tJeernZ2CPA0A7F7
	Nxrfs56G4/fMb/OidUEd289ssIy5fCs9Npd3z0vHKi5nBIkA6i++sTbcx2aSHVCb72gaFyMdHuk
	1me4A9TRGdP1iCDOxfto1ZxIEt/8r5RSHD9bGLTYb16Yt1aW0KaTjJq1nQDleG6j8XIl748w18m
	irPUMi5zrHTPmcn2S5bJgbC7kk3TfScNj/hiH9xW/g2Gm44+4kUE8pUeF1Y9F8Zx/BqdVZdM/Z0
	0rmwNfVAo4cx3tkBMNkq0klVcfU2t5noxWCUdJ57ymP2hbJY4f5cGycoSNGQORgtDutcNGEWLBl
	UN7wGgI6ktqMBcA==
X-Received: by 2002:a05:620a:468f:b0:939:6db3:6cad with SMTP id af79cd13be357-9398035a913mr3836946485a.12.1788979670996;
        Wed, 09 Sep 2026 11:47:50 -0700 (PDT)
X-Received: by 2002:a05:620a:468f:b0:939:6db3:6cad with SMTP id af79cd13be357-9398035a913mr3836938685a.12.1788979670273;
        Wed, 09 Sep 2026 11:47:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm46103192f8f.35.2026.09.09.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:47:49 -0700 (PDT)
Date: Wed, 9 Sep 2026 20:47:48 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/9] net: stmmac: qcom-ethqos: add
 per-platform NOC clock voting
Message-ID: <aqGp1D6ySJpTK1fB@lore-desk>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
 <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slUpn+zr8Skpi/6V"
Content-Disposition: inline
In-Reply-To: <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa1a9d7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Jx9YaH9-bZbgU6IgifAA:9 a=CjuIK1q_8ugA:10 a=8sS7P86Wg6PPOb-1CJIA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX10geybvGoA0R
 Eov0nMrF2nfJrFrT7EDumGx2r1tzCsqy7AEmoYO7BwK3Hd3WA9ajnpRbul/U0GGnMaJ2rGgt605
 XAObLqMJip0UIaNcgfD04paR7N1cIDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX7i+DDI6z4tfo
 7hzqMGZGNd3Pb1RyESgFfbMgZupYtgPKauhcV19VT45EF6mylAG4n0CNoeZ/UpOKnajZibuUsuN
 HP4w0XRAxraWo7LaeJ5zm4dmLeRhLX7uE1wyqYAfy4V/+BI3gTAVuGhLABBxfsbz4KTvXNfJU03
 e1eF6wUs3ntzXh1nB4vQQ5oFWGqubaF6oG+5a3VqoYjw1AW1A0QTuAEd6AvbtoKdZs3U5lUxHXg
 7XKuE+QhLRIwXsMaZRq+40x8NEv7LcVI2FP3CA1MiYCbcoaiCDfKDC+JxfXF/6QiIM/v2z/qg2f
 zppJYIPX6FzZv/SOA8RcuwJ3262vxnvHeJYLCIBBiSOLmrCUDjhWda/FVkw2lS7p3tmtMNbrgdV
 +sVH0zpnuhIcZixUlZujQ23rcsqKyA2yFUTguiB3XzHdunXxcij696BE2L6oYIWUVWkaF5hURxi
 nb779eW1hO1u9CDVF9g==
X-Proofpoint-GUID: ycv7mdX9sj1yGFVGH1te5kygSXy_B8nQ
X-Proofpoint-ORIG-GUID: ycv7mdX9sj1yGFVGH1te5kygSXy_B8nQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090210

--slUpn+zr8Skpi/6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Some SoCs gate the EMAC's path to the System NOC behind dedicated clocks
> that must be enabled before the DMA can reach memory. Add
> ethqos_noc_clk_cfg and the corresponding fields in the driver-data and
> runtime structs so each compatible can declare its own set with per-clock
> rates.  The clocks are acquired during probe and enabled/disabled
> alongside the existing link clock in ethqos_clks_config().
>=20
> No functional change for existing compatibles. This will help us when
> we add support for Shikra.
>=20
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 106 +++++++++++++++=
++++++
>  1 file changed, 106 insertions(+)
>=20

[...]

>  static u32 rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
> @@ -689,15 +703,51 @@ static int ethqos_mac_finish_serdes(struct net_devi=
ce *ndev, void *priv,
>  static int ethqos_clks_config(void *priv, bool enabled)
>  {
>  	struct qcom_ethqos *ethqos =3D priv;
> +	unsigned int i;
>  	int ret =3D 0;
> =20
>  	if (enabled) {
> +		if (ethqos->num_noc_clks) {
> +			ret =3D dev_pm_opp_set_rate(&ethqos->pdev->dev,
> +						  ethqos->noc_clk_rates[0]);

assuming the first clock is always an OPP device seems a bit fragile to me.
Can we find a way to enforce it? (e.g. have a dedicated clk_bulk_data struct
for it).

> +			if (ret) {
> +				dev_err(&ethqos->pdev->dev,
> +					"NOC OPP rate set failed: %d\n", ret);
> +				return ret;
> +			}
> +
> +			for (i =3D 1; i < ethqos->num_noc_clks; i++) {
> +				ret =3D clk_set_rate(ethqos->noc_clks[i].clk,
> +						   ethqos->noc_clk_rates[i]);
> +				if (ret) {
> +					dev_err(&ethqos->pdev->dev,
> +						"NOC clock rate set failed: %d\n", ret);
> +					dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
> +					return ret;
> +				}
> +			}
> +		}
> +
>  		ret =3D clk_prepare_enable(ethqos->link_clk);
>  		if (ret) {
>  			dev_err(&ethqos->pdev->dev, "link_clk enable failed\n");
> +			if (ethqos->num_noc_clks)
> +				dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
>  			return ret;
>  		}
> =20
> +		if (ethqos->num_noc_clks) {
> +			ret =3D clk_bulk_prepare_enable(ethqos->num_noc_clks,
> +						      ethqos->noc_clks);
> +			if (ret) {
> +				dev_err(&ethqos->pdev->dev,
> +					"NOC clocks enable failed: %d\n", ret);
> +				clk_disable_unprepare(ethqos->link_clk);
> +				dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
> +				return ret;
> +			}
> +		}
> +
>  		/* Enable functional clock to prevent DMA reset to timeout due
>  		 * to lacking PHY clock after the hardware block has been power
>  		 * cycled. The actual configuration will be adjusted once
> @@ -706,7 +756,12 @@ static int ethqos_clks_config(void *priv, bool enabl=
ed)
>  		qcom_ethqos_set_sgmii_loopback(ethqos, true);
>  		ethqos_set_func_clk_en(ethqos);
>  	} else {
> +		if (ethqos->num_noc_clks)
> +			clk_bulk_disable_unprepare(ethqos->num_noc_clks,
> +						   ethqos->noc_clks);
>  		clk_disable_unprepare(ethqos->link_clk);
> +		if (ethqos->num_noc_clks)
> +			dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
>  	}
> =20
>  	return ret;
> @@ -734,6 +789,51 @@ static void ethqos_ptp_clk_freq_config(struct stmmac=
_priv *priv)
>  	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
>  }
> =20
> +static void qcom_ethqos_noc_opp_cleanup(void *dev)
> +{
> +	dev_pm_opp_set_rate(dev, 0);
> +}
> +
> +/* Some SoCs gate NOC access behind dedicated clocks. Acquire them here
> + * so ethqos_clks_config() can enable/disable them at runtime. The OPP
> + * table is used to propagate the required VDD_CX performance state via
> + * dev_pm_opp_set_rate().
> + */
> +static int qcom_ethqos_init_noc_clks(struct qcom_ethqos *ethqos,
> +				     const struct ethqos_emac_driver_data *data)
> +{
> +	struct device *dev =3D &ethqos->pdev->dev;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!data->num_noc_clks)
> +		return 0;
> +
> +	for (i =3D 0; i < data->num_noc_clks; i++) {
> +		ethqos->noc_clks[i].id =3D data->noc_clk_cfg[i].id;
> +		ethqos->noc_clk_rates[i] =3D data->noc_clk_cfg[i].rate;
> +	}
> +	ethqos->num_noc_clks =3D data->num_noc_clks;
> +
> +	ret =3D devm_clk_bulk_get(dev, ethqos->num_noc_clks, ethqos->noc_clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get NOC clocks\n");
> +
> +	ret =3D devm_pm_opp_set_clkname(dev, data->noc_clk_cfg[0].id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set OPP clock name\n");
> +
> +	ret =3D devm_pm_opp_of_add_table(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add OPP table\n");
> +
> +	ret =3D dev_pm_opp_set_rate(dev, data->noc_clk_cfg[0].rate);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set initial NOC OPP rate\n");
> +
> +	return devm_add_action_or_reset(dev, qcom_ethqos_noc_opp_cleanup, dev);
> +}
> +
>  static int qcom_ethqos_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> @@ -795,6 +895,12 @@ static int qcom_ethqos_probe(struct platform_device =
*pdev)
>  	ethqos->has_emac_ge_3 =3D data->has_emac_ge_3;
>  	ethqos->needs_sgmii_loopback =3D data->needs_sgmii_loopback;
> =20
> +	if (data->num_noc_clks) {

I guess you can drop this check since it is already done in
qcom_ethqos_init_noc_clks(), right?

Regards,
Lorenzo

> +		ret =3D qcom_ethqos_init_noc_clks(ethqos, data);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ethqos->link_clk =3D devm_clk_get(dev, data->link_clk_name ?: "rgmii");
>  	if (IS_ERR(ethqos->link_clk))
>  		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),
>=20
> --=20
> 2.34.1
>=20
>=20

--slUpn+zr8Skpi/6V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqGp1AAKCRA6cBh0uS2t
rJe5AP412HbG+cRGfi9lkrr+Gg/WmE/XOiGzUoflMRha2mmokAD/RbM96cAfeMgt
zWdQxOE79McBOAswltXFCrrAJhxVMgg=
=+2DD
-----END PGP SIGNATURE-----

--slUpn+zr8Skpi/6V--
