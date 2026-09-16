Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7E481238
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561091; cv=none; b=ikLU1eBm2p+yD4SNm+Aiw+k37Fkz2VMFaMgSmaHcTbd4m6v/mvywABm4BdVF3b7Dzr4uDwpyZ4/LCpk5dmFcnz+UiCm0DvW3ZvxydHRsScDA/qJfTbnCyBgsS4Rido+SWZEE2bbG2UTjT3i9AhGzM0Madmmx5+6x531VsuuNqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561091; c=relaxed/simple;
	bh=XUlmkcZ5RWVZdPh6nzmGjp1yFPSyzH5dobkGwv2oChw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2nK01mBkmE9zvC+K+gPg9UgdGtrAoVHR4qhpcxXmBSywrvY4AiOD3czFsooVo/QR4IcDPaIlxVpuiC32ZxWmNZHBacSmywtLleRU1sXcLftalTCQIcQ8hYBP4jFeYuC1Qa6ww5M1Z/sY4gDphrBtGw+j8aP77J8J4d7CHabU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvGe5OLk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bgmpHDqV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvGe5OLk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgmpHDqV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92xrc2822753
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=btpq+GMkcN0fP8tlXTzfdclT
	vfX1VTNaQI1C0weG74A=; b=kvGe5OLkoa/Xv2QpWYixqouDqZYE5/tvPF7Mgwxk
	shYz1m2yyUODnAF5mEbiaUWk8vAl9w+g7WmEjP1chk8l2izKak0Hu1ly1pMFk1Jj
	grNqUilAVgf+E5ZVz9BjwCmj7xd3gQQ3ivTQL9UwYzCubEP5nG+RFT5ZfD3m4RKf
	P+K/4GmBxVSTeK6kQ8CMbQzlNGPcHAj7Bx30rfdV2mR73tfv/byCs3emZAhqn/L3
	ru2ub21KN2K9HtJp8jO+pqvLqU6PDW7JGkwB8oFOnIbFTtFDtp7Ac93ip0nD2IU1
	pZq2jCwICPxM7N6eHBeaoydwI8sup2sniV0VS4DMorR2HQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqfvfjrnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:18:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb48f41343aso2064622a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789561087; x=1790165887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=btpq+GMkcN0fP8tlXTzfdclTvfX1VTNaQI1C0weG74A=;
        b=bgmpHDqVIRPRazxMegizZ3D6++KMDVeKn7nTK+LnazoL1sSMzuCcoAsvKdfWwOjCzn
         t5e3TvoRAo3sSxk5z0MTIod/cKSiSPXc7+j9QgKjkeCHCl8W/t2vslgsiIpXX/4bKrcs
         yWKAHMu04Iwg6b7x5BG6YdaxTjJgMO3dUIQo5tlW0t+nF6xV9b86tHtMsxHzxlbQBOKf
         RpE3rrmlEutuu13aFYt3RvKyQ7/HGtcl7kb+OGUXdWJJXU4MVTbO4YpewK+Fcj6lQc3G
         rb1cYtKDiji0C2DF05JgYMwAt+/fmbeR3G39th0liYC2hRyG2Y2+HpT/Z8ODcW+qdxIH
         NiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561087; x=1790165887;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btpq+GMkcN0fP8tlXTzfdclTvfX1VTNaQI1C0weG74A=;
        b=L2dA5PcFT430O/2eEnuiWEkTzHeUmPxFnG7YDzs/3lA4FqZV4EWXXh4SpmRiQWk35/
         ehoXWv9NDIHlP9/A7WNk8QbsuVDnfNTQEgmG8Qc4+s8/Plw6R8Lk83XI1K4zANGNez2n
         or3SQc3wvjnp5Agy6C8tEWVdXFr88fXPAL17I2wBHx15zqMkX2c/3+dvUmN/FndSWrGQ
         ABb4xqBFI7UsV2KmoP2DiyYpMeCtWWumGDYjP2F85EYHHXV3WiQa0wc82OcV9rYCLweR
         HhcggnIsUNLMq6mLOX6Smdh6ANIG5o738i1Mo/aYNohTXd4EqH8NblKiBqzLwb9FuVpY
         9X+A==
X-Gm-Message-State: AFuF++mdI3pa2cVggpj4++ur3YOYbUcDcETk3Y3Tp7njfk+69So+R8KH
	yA/cmIkekXYd5R9+oxBrWqYADE6GRwHgPR63Bo+fCnt2t/UJJ2ZX7QBUQ5glAl1q/tylNaWgHVz
	nzcujxoI0qI+FKQbdR3jlK/tsmFcBK0zCTNXG8CgYqZAqIcvWPxt2PXHsdro=
X-Gm-Gg: AYBFou18lcYMwxPMrmz1JqWqwC/3W8NScSxonweOFOYNAhih+jyyMIDn1D+DHXwUyhr
	ziGL6HUuR2suz8OeMx9p2xDu5U/dp+llAmgThbgLvFlylsJYp5+Su3W9HvV+HZP8KN9gQWD4kD9
	gu48dDqW3Pq+BgwvYYSIwnXy8SixTFF78eKnsY8B7M1P0NdSlXAKpsJ0Y9roQ10y+bUajQjTEuN
	QIE3G78pm1lArs7A5WebvsILYf5A18Zm08wa0UB51GSdpoxKBlfhLBNxOslbUVRI45jx5fVVphC
	U81L0A6IUrJX2xeBHqZnN4UlTl45KkavNZgHQRN5iDfGZZOy1RDe6D+HlgRsET9d9mqPoONPtbA
	6jXuEvYwoPLkXRA==
X-Received: by 2002:a17:90b:254b:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-39e1fb45010mr2698932a91.0.1789561087139;
        Wed, 16 Sep 2026 05:18:07 -0700 (PDT)
X-Received: by 2002:a17:90b:254b:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-39e1fb45010mr2698870a91.0.1789561086513;
        Wed, 16 Sep 2026 05:18:06 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bc26a65sm4761643a91.13.2026.09.16.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:18:05 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:47:59 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Thomas Karpiniec <tom.karpiniec@outlook.com>
Cc: netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Choong Yong Liang <yong.liang.choong@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
Message-ID: <aqqI9wOnradk9d7K@oss.qualcomm.com>
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=JYkpPkKV c=1 sm=1 tr=0 ts=6aaa8900 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MoAyQRu-XjFdVeW2IIMA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfX0kekkpwKkBMR
 NDAMaaBsK6N092Lv/JtSi2lBLs60d62U+2rU7jTzTLlp/yx2oC1mceKkMf4Yr+Wic18SKxZLVtm
 0Rxn680Cmy2yZTpHXji6Nif8oEbM90k9sSDfnzSqD44x0nHbYNtI0bVcrxww9wimgHCr3IqrnYv
 krX/9k9OPygQU/XuKMEBvo35mx1RZk0jDKpUBqsMApBupYThFdqfXOXxzgPK4tUtSq4Xg0Owjti
 l5vHjWemOee2XMW1UyV+btoOQ29QGHGy95EX39CbXn7iXfkZcWFe4LLBXq9u9At9VWP3NDIM2xt
 MBO2apS72oUihAMkD/HUZLD8zPioFsiqHLDA+nD/d2y2AeQsvxt/FPUIn5OGvj8hXubRzwGus7s
 OJIpDXfNakBaESsFBPhnfQPYUYX0PrzJF58TjPI5OMa944yOFObv6sDHAwtNjD5cKKZGDqqO+Wf
 pH/jM5pDbcbFqkbAK+w==
X-Proofpoint-GUID: kijdFy6G2sfL1yCz9uTRGVFuDmvT-pYB
X-Proofpoint-ORIG-GUID: kijdFy6G2sfL1yCz9uTRGVFuDmvT-pYB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfX0i0+WXkzRsAP
 bD1HUTRn58NA3JHhbOao4GGrfCi+y4GoduYnXgw0NxnoaOv0ake2r9u4+pHWXk/rfojP2IWVcFU
 V+HMTCCX1CInv7Vn/jRJQvXL/sOXRnQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160162

On Wed, Sep 16, 2026 at 08:39:50PM +1000, Thomas Karpiniec wrote:
> From: Thomas Karpiniec <tom@wendy.sh>
> 
> With a QCA8081 PHY and phy-mode = "2500base-x", stmmac reports only
> 2500BASE-X in phylink's supported_interfaces. Phylink consequently removes
> 10/100/1000BASE-T modes from the PHY's advertisement, preventing a link
> with a gigabit switch.
> 
> The QCA8081 uses SGMII for lower copper speeds and 2500BASE-X for 2.5Gbps.
> ETHQOS already reconfigures the SerDes in ethqos_mac_finish_serdes() when
> the PHY changes interface, but does not advertise this capability.
> 
> Provide a get_interfaces() callback for serial interfaces. Add SGMII and
> 2500BASE-X when the SerDes validates them, allowing phylink to retain the
> corresponding copper link modes. Leave the existing stmmac fallback to
> the firmware interface in place when no interfaces are reported. RGMII
> configurations are unchanged.
> 
> Fixes: 61e9be0efbe8 ("net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode")
> Cc: stable@vger.kernel.org # 7.1+
> Assisted-by: LLM sparse
> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a..3493e090f1a8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2018-19, Linaro Limited
>  
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_net.h>
> @@ -564,6 +565,26 @@ static void ethqos_pcs_set_inband(struct qcom_ethqos *ethqos, bool enable)
>  	stmmac_pcs_ctrl_ane(priv, enable, 0);
>  }
>  
> +static void ethqos_get_interfaces_serdes(struct stmmac_priv *priv, void *bsp_priv,
> +					 unsigned long *interfaces)
> +{
> +	struct qcom_ethqos *ethqos = bsp_priv;
> +
> +	if (!ethqos->serdes_phy)
> +		return;
> +
> +	/* PHYs such as QCA8081 switch between SGMII and 2500BASE-X with
> +	 * the negotiated copper speed. mac_finish reconfigures the SerDes
> +	 * accordingly; let phylink validate all modes that path supports.
> +	 */
> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
> +			  PHY_INTERFACE_MODE_SGMII, NULL))
> +		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
> +			  PHY_INTERFACE_MODE_2500BASEX, NULL))
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
> +}
> +

So, I had proposed this exact change a while back:
https://lore.kernel.org/netdev/aMgootkPQ%2FGcdiXX@oss.qualcomm.com/

As Russell noted, this behaviour is due to the messed-up integrated
PCS support in STMMAC/QCOM-ETHQOS.

I would defer to him for this if he's around.

	Ayaan
