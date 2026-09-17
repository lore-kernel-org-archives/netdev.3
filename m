Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2C52F264
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664865; cv=none; b=bF13E+3T3HuBfagMNmmA3/xjE4X3kD35BFE9qWtVSSqdr/9kzD6UOq3DZYZ/DWFS0QachCDmkFy9vfVwtUCr+xMdof6ZGuylYry5J3zwuwbHsMAHZLY+yIKFO9s1cylOtiGGjVHHXDFc3bGmmD96mJ5EQIsXJuGPwu5Us1300IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664865; c=relaxed/simple;
	bh=vhtW36zbW6U2hQRyCFwQMzI3zVApqqEa57KQyKwSLEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgOHS4TyVSGTmi1mw7wCumfbI8i1KJsYK5Z0P5ySFy7fToQmNCb5DihFIYYc07y8x5iqHISKLCok1bFz1+CRPSahWZrtG4UK5NHWb4Kt2ojE7I0Z9vDgDagKX5/IduOCLmbkJZfL+Jnzam6mS1x0nvoj54KyOPQ0Z2BqIyPLsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hpXxIIZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FV1SGc6q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpXxIIZo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FV1SGc6q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5tTS1639712
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OnkjcGuQVl1beS4tDUCJl3BOauM32z7nrFMjHCzwJSw=; b=hpXxIIZoB3SeMm//
	wdqx6jjYrY+WFvIEVZCHerJpf8TulhvSoXC1qJ1RNO4Vs+T+kd+j7ueYnEV1tu88
	50Z21zY6iq3H+iM6BmTl1khcXxe9Aw1fsBWHRBnNs7vUIyNaH8Na1DZtsHbUIqSy
	MX7hWrcr9IoAFPCVhw4waDj/PdRfMOxXHWBH6J5g9f2YdNJYNzxkXLN1NGXpjq/N
	ejbxDnlbCgidIMBcsYnl6rThYPdYWqefeT8EnDoqtlBYz2rBU2FKvrhS0zT1k6Jm
	45pkdzom3g1PSTBOSgao6jgFGb0K1yuMuuSZSv5hppiREk/mdNUuZYgbQCLRX7e3
	quakzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grca0tfky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:07:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd7d0751efso12709295ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789664862; x=1790269662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OnkjcGuQVl1beS4tDUCJl3BOauM32z7nrFMjHCzwJSw=;
        b=FV1SGc6qvZ6EjUBbgMcSagRIaDIbRt0enFnVxloI1eE+3D5r0M/gcHRepGEmXeQFWM
         42h+Z4wCOuyHTZJ75mtDVMipunu6pqOkNNIK4DRzuYNRo/jfZtmRMPAYB462kZg9l5zD
         COeCxaml1vtBwQj3QfAcuwWyEzuLUo2I0DwdZvsabjVmwMl45LoeX3ubY3Cv+P6ZEa8O
         tYMjqT9WPoT/vf2TO7kz3B/J1pfSaJmGCuqHutHw2mxuZaVBGyrZMh517Ju1qehiEHx+
         On71sM8LgZvTCfvCMgTTpm55V0BM8HKI8m1+ZRehdpVAwLDnkXGl8MtfmzjUrJqeggFY
         XTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664862; x=1790269662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OnkjcGuQVl1beS4tDUCJl3BOauM32z7nrFMjHCzwJSw=;
        b=AEGmwKpQfiaLfG5c+yyLjjdd865XYmaxQlljtrAC1xH2ulIkbAjetlDeoxZr5G5eIv
         huA8cYQJU5sYsiLeS+V5iW7EEOY4Eeq3c1ZAKh9k4LpF3EcprgX4VLx7AMm3EqN2mBGH
         zuBxsTMupeWxenjlzv8iSl2EGTaXU9QA1+Rbuh2ad/RBvq0pAhEWCydESERGf19GxuTT
         KUXKgon2mR8zsY8Kz0+IrflPhQ2Kgl8AdndhJ6gz9jiziwpHREnZrGipwSl6WJXCh+w3
         ZcKq/V/haeKzH6wgu9CNfx5D6twb1eptJQRBtKP2xaOD9YXKCIdB8288MZKKN+WUEqqR
         iHNA==
X-Forwarded-Encrypted: i=1; AKwUvByu/6iFnusLCCfFT2Udnwa6/uQ6xCa1ctOFnsGXdZm05N3VjlYYrfIWW2Rd27UmCaeItDycAxU=@vger.kernel.org
X-Gm-Message-State: AFuF++lDV6XxuZiat8gRqsss8m8To/OKR8M5+AtNp1b0qDKcFs5I7XHJ
	nwZ0qARYuZrgBUczLp/1ahbI/t70EZi1MUdsXcD15hcFnevvDV0c56mYiMrLkI/NJwg/7YlIBn/
	12a6962zSFiHgYrnNt4r931zjPY7J91p4nPZrkVgO3o8MJwvAJ97hsuS1Ktw=
X-Gm-Gg: AYBFou3AazK6xFaWyS6eR0CTtOwGnnmYjAVgO0v1UqH7m8kJ17QGXHyQD1C/NC6Cst5
	KJEQBK9StCb91307Twu91kG+WdmG8Bo65LfJXtMu09YARqikVZbhaiMMr33JJ3/bFon+GpCxChw
	bRocvVlyD/NGuNz6mC/lbNx3sxc6XSt7VAooB5yqT63d8QeIsvguPbzDw44FwpxZU70hnkBNvbA
	hNS7OHTzM1gjTE5nkTGGBfVl0WjrQx6TSsaFRWKiLwFuR904jMektD0BpCNFUFsYAgwKqMgrzzd
	5579UoYnpfpJ5eBJY88pLXi6TrbKtyRbhIfKoubPZJO3V6H5ny8eYPbL6xpI0bAYyb1QErhPcYa
	QbWVVLg7fqPVudQ==
X-Received: by 2002:a17:903:11c3:b0:2dd:ad7d:72e3 with SMTP id d9443c01a7336-2ddad7d74femr10397715ad.26.1789664861594;
        Thu, 17 Sep 2026 10:07:41 -0700 (PDT)
X-Received: by 2002:a17:903:11c3:b0:2dd:ad7d:72e3 with SMTP id d9443c01a7336-2ddad7d74femr10397255ad.26.1789664860991;
        Thu, 17 Sep 2026 10:07:40 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8e6a3sm30492845ad.7.2026.09.17.10.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:07:40 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:37:31 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, richardcochran@gmail.com,
        andersson@kernel.org, konradybcio@kernel.org,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        joabreu@synopsys.com, maxime.chevallier@bootlin.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/9] net: stmmac: qcom-ethqos: fix RGMII_ID
 mode to use DLL bypass
Message-ID: <aqweU+PCLaXi0fLh@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-5-bbe3389d0652@oss.qualcomm.com>
 <178912591493.219967.8863321460780410702@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178912591493.219967.8863321460780410702@kernel.org>
X-Proofpoint-ORIG-GUID: ijN7PXiBOKGkNIyh_7l35zmdD1KEIQoj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX7nld5BhOyxCK
 Yma3YJYIUlLqtlcFeDE6YHZLoQ48sDcGyGi1RPtKd158Lyj2hDhAIiYvtSVgZ6IINfodmQ+URVH
 QjcXLQ4nPATDg/EnxvQE24ZHj+Jmuvc=
X-Proofpoint-GUID: ijN7PXiBOKGkNIyh_7l35zmdD1KEIQoj
X-Authority-Analysis: v=2.4 cv=dOQzC+Zb c=1 sm=1 tr=0 ts=6aac1e5e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=vOTgahw99eS1XjnIhgcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX5BE2aN8sl8O2
 YHUfIaJdVEDnudME1g++h4XFCXEM/SrIZ1OBw8p5ZwuAqoinUlRO4OBxgTmb5pN8CVV0XDE66Mx
 AmG4b+aK4wv/9KiSM/Rm8EvOitG+IKRVvkUAPBbW8UVFcHgAgHHnSPJst+A/AkEL733P+UG9WrA
 cwNJRGUYrBD2jVT1rED2XGSiYpskKKD57wwaPyJhwlDlInofOXwCtj8hMD6g8oCaG1MQumJIMgp
 aFJE20BV2q9wwqTX1XFSQq8I12Q2ZbURqsSVFqEyPrjzFMct5wWh4imuJGh+IsSdCE8Z6gyHmqV
 qv9dmWGPd3U31+cqlWFBwjHT4PPfDIwbDCrxoFM09CLdOebVB7sa4PZVhYAvU7QwivLKA7PPn4i
 PqktXhHK8rQRGEC9PP4Heg8rmPP1HRmag3BKu98h+XYXQKC7rrWvTRz/+WeyFLU7DSUvq31HQfJ
 xxakF/HllXoJUZNmaog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170243

On Fri, Sep 11, 2026 at 11:25:14AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] The patch is worded as a bug fix ("fix RGMII_ID mode to use
>   DLL bypass", "Also fix ethqos_set_clk_tx_rate()") for two user-visible…
> 
> --
> 
> net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass
> 
> For phy-mode = "rgmii-id" the driver now powers down the DLL, sets DDR
> bypass and programs the IO_MACRO through a new
> ethqos_rgmii_id_macro_init() helper instead of running the generic DLL
> init.  It also stops doubling the link clock rate at 100M/10M in that
> mode, and drops RGMII_ID from the TX phase-shift suppression in
> ethqos_rgmii_macro_init().
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 44270c25d874f..53fb9de4d92c7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> 
> [ ... ]
> 
> > @@ -183,7 +186,15 @@ static int ethqos_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> >  	if (rate < 0)
> >  		return rate;
> >  
> > -	return clk_set_rate(ethqos->link_clk, rate * 2);
> > +	/* Clock Rate Requirements:
> > +	 * MAC added delay: 250/50/5 Mhz for 1G/100M/10M
> > +	 * No MAC delay (DLL bypass): 250/25/2.5 Mhz for 1G/100M/10M
> > +	 */
> > +	if (ethqos->phy_mode != PHY_INTERFACE_MODE_RGMII_ID ||
> > +	    speed == SPEED_1000)
> > +		rate *= 2;
> > +
> > +	return clk_set_rate(ethqos->link_clk, rate);
> >  }
> 
> [ ... ]
> 
> > @@ -493,6 +539,21 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
> >  
> >  	ethqos_set_func_clk_en(ethqos);
> >  
> > +	/* For rgmii-id mode, the PHY should add the required delays.
> > +	 * Therefore, power down the DLL and program it in bypass mode.
> > +	 * Program the IO_MACRO as per the settings recommended by the
> > +	 * programming guide for bypass mode. This will ensure that the
> > +	 * MAC core doesn't add any additional delays.
> > +	 */
> > +	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
> > +		rgmii_setmask(ethqos, SDCC_DLL_CONFIG_PDN, SDCC_HC_REG_DLL_CONFIG);
> > +		rgmii_setmask(ethqos, SDCC_USR_CTL_DDR_BYPASS, SDCC_USR_CTL);
> > +
> > +		ethqos_rgmii_id_macro_init(ethqos, speed);
> > +
> > +		return;
> > +	}
> > +
> 
> [Severity: Medium]
> The changelog describes this as two functional corrections, "fix RGMII_ID
> mode to use DLL bypass" and "Also fix ethqos_set_clk_tx_rate() to not
> double the clock rate in bypass mode at 100M/10M", but there is no Fixes:
> tag.  Should one be added?
> 
> Both defects look reachable before this patch.  qcom_ethqos_probe() accepts
> PHY_INTERFACE_MODE_RGMII_ID and installs the affected callback:
> 
> 	case PHY_INTERFACE_MODE_RGMII_ID:
> 	case PHY_INTERFACE_MODE_RGMII_RXID:
> 	case PHY_INTERFACE_MODE_RGMII_TXID:
> 		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;
> 
> so an rgmii-id link previously ran the full DLL init and had the RX delay
> programmed by ethqos_rgmii_macro_init() through
> SDCC_DDR_CONFIG_PRG_RCLK_DLY / SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY, and also
> got rate * 2 from ethqos_set_clk_tx_rate().
> 
> The partial mitigation for the TX side came in with 164a9ebe9742 ("net:
> stmmac: dwmac-qcom-ethqos: Respect phy-mode and TX delay"), which only
> suppressed RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN and left the RX delay and
> the doubled rate in place.  Would that commit, or the original driver
> commit, be the right Fixes: target here?
> 
> Related question: which platform reproduces the misprogramming, and on
> which hardware was the new bypass register sequence in
> ethqos_rgmii_id_macro_init() validated?  Grepping arch/arm64/boot/dts/qcom
> turns up no ethqos node using phy-mode = "rgmii-id" (only sa8540p-ride.dts,
> which uses "rgmii-txid"), so it is hard to tell from the changelog who is
> affected and what the backport risk is.  Could that be stated in the commit
> message?
> 

Since there are no current ethqos users of "rgmii-id", nothing is really
broken in the current tree, so a Fixes: tag might not be required.

	Ayaan
