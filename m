Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1753B604
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664754; cv=none; b=Um+mEEIeYVEAbL6Kqcod775vQpoq4kE6nm2mVNqSNEZhOF6/TxOFpsgMXhKOHcJ0+0wotaCnV2RcYUQGsSQEpIFC37Iu8F+w4mMMRUWLi4HMluw44dCqnsslGkVjXfRtWchPacFexhoz8fmeWDVixu8Z1/nh3mmfJAkkWqASzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664754; c=relaxed/simple;
	bh=K89NTdHV4s39TWMFaaBaEfSlU0LRczERuX7RTrIMNEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIpN7J5UKl10vUJBkHyrednMqztJEu69LJCitE0lWH1VoxxJqvLOQT6uet2/3IVUHuvN57OWA82yA5ROCatsOSIx3KsCM7W746EOPcne6wv9LwByVkxH3yYZBIVWnOz/BLHGWyYucaPXd2GYiYCs/OtgZcxXZ5uUhKh0AdNHaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tgd3GC9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPJXGDQ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tgd3GC9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPJXGDQ6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5kGg2728664
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RDl35+VXelpsEbre9UpAeTzdT2GlQK1m33TbNXBDA+M=; b=Tgd3GC9WhKH7gyHB
	3DIAh98G11HYVNgr+D7Tum/1A3Tz7K+TZxY4NV401TMseciyykXB269mWw6B6zbs
	jHxfmNX3FPf5ya8EI+Lfq8xbUpWkMXjdf4EbKkadvKH6l7m1exjjyvY/gzDC5dU8
	LaHRFEbpXRVi6QfKBXIC5pkGiUubaTcg1NNxtkEUXq0RcYfwi9b/FSuwcrvIzhFx
	vSb29F9dshZnr0HRO+67md7iLZ/T3xQHEOYZi6dVvpSERUVTCzylr2lcS/gimN7R
	CKyy5QN6+YXVNcjaK1+ZtC4f4DVzG2/F6nFJeK465yVXeVClC2/yU3RNeOTxoj1B
	M4X/FA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfpphgrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:05:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9336581a2so20984375ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789664750; x=1790269550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDl35+VXelpsEbre9UpAeTzdT2GlQK1m33TbNXBDA+M=;
        b=NPJXGDQ6fZVeygqrWbH0Ep2CqaCMkKgkt+vO0pKJy1a+WCHr6H8+KATBOi5jmzmt0K
         LQ7nhFn30brlf8UJFXe8Li33g9Ol/IwQBihg4cOoUv6/m/oLm9uirO6HkmeJmN+I8i9a
         3Ey+lElmX1yz26KvmWeYLvDXxBZPRTzNBBnWfqI1CMQDQZVSLZaLtVlhdshyJADWcpnE
         kbMQUcEav2TWdDOyNJxQDmNPJLaHworDtEH/e7wEacYWK2nLxW9iigB/s5//EK5vcUrY
         wslXmjTUGIqMVd8MtVlB6s1G97nFXNWmKLQ1EdiMxKbho8sU27JJC7zjlg2n4FyZcP3I
         UWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664750; x=1790269550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RDl35+VXelpsEbre9UpAeTzdT2GlQK1m33TbNXBDA+M=;
        b=Kc7L93FYn+aeYaRFZexg0xcJTRhMD4x3EDvzo/WL+XmoZTcn2/bscW3sPDOHDGXVq4
         r6XXE4uye2s58m5CuNlLTaAptuWIDHX6iPENXiJioc5zhKRvLCzRHF1dCO9BkKyo1BTv
         svrROeIaEqGYr5NPZtRB8xtxQ8hbwsUOHagRx7jTnlCwu45JSxkvx3xzhJHEHJgdG5mt
         LYB7Lgv1Kl522Aq4UnfENokb+xx7RAMt34Y+Q8AQ9Nn4HFrgZxjrL8QqNYRYCxC+OeBO
         huHuY+CbDcscTnjRSYH/k22SQrbhVfjVTrW16/svjVfZOLLAi1SUABxjJaDxz3/2PA7s
         Sp3A==
X-Forwarded-Encrypted: i=1; AKwUvBzdIVBNk0tPHgVULMYUzVrJoKmXzD3NCGials9h0hJ1qyutF61/i1u/+o9ZED4Gc2hT9vtzoN4=@vger.kernel.org
X-Gm-Message-State: AFuF++kuYEd/hQ3HynsUZ7+sMtpasdDphj73V/cj88C6bQ9ea6Fcn8ss
	/BEBUdEaskothi23P9c7zHb3VgQzQ+vmLt4plWp7PAkotwCVkfiEJ/VudzQ6IyuF1O/7QbqDcZu
	WW79P8fcFBn8s0LmC+UbtQD6KQRI7IO1EBHlTs4/XixbcQ/IohQY7dAwSmeY=
X-Gm-Gg: AYBFou0K4Gq9aZ2VmaZkeoYy0ScZ/F5sFc0142FPanG3S5OHos46UeYpiI/wzVW6lnl
	CfER1BY8OsqtPePdcapA9GmRks4b/wB9NS4mc0jZIQb8LRbXI1SMIHu89hdEVRBv2m2eydOnzDO
	SxEhfXAFXvzRIlc2ZSfa9nKdQ0Jy5JhLvJ9D+YRN76EA7Bx4BdZKoBhnurOj4+KFJtz40sNI/fq
	av4J6bU46DnLQxL6ZwG/67pKkxjjJLMNoI3T+Ilxu7du2oA2m9GmtlzLoNE0Ul6V36xC770DP/9
	VQYXJ+flDWn7sxGjAWkXx3yDMX2n93gFxnHR3Fe1Dp3nZNRSGb6utlhdt1MjvsvTz+BXJjENv4A
	eLARWCQTm17OP
X-Received: by 2002:a17:903:96:b0:2dd:ad74:ac82 with SMTP id d9443c01a7336-2ddad74aeadmr12637585ad.29.1789664749513;
        Thu, 17 Sep 2026 10:05:49 -0700 (PDT)
X-Received: by 2002:a17:903:96:b0:2dd:ad74:ac82 with SMTP id d9443c01a7336-2ddad74aeadmr12637115ad.29.1789664748859;
        Thu, 17 Sep 2026 10:05:48 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ebf2e2sm30693095ad.42.2026.09.17.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:05:48 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:35:39 +0530
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
Subject: Re: [PATCH net-next v2 4/9] net: stmmac: qcom-ethqos: convert
 ethqos_rgmii_macro_init() to void
Message-ID: <aqwd482ftepFnbJz@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-4-bbe3389d0652@oss.qualcomm.com>
 <178912591286.219967.4678568368277035940@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178912591286.219967.4678568368277035940@kernel.org>
X-Proofpoint-GUID: PcCWA_BOvAuCLHR5oHPOH5Bq_dccArNz
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aac1dee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=qlcCTMnHKW_kJwwR1w0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: PcCWA_BOvAuCLHR5oHPOH5Bq_dccArNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfXx/5LMqQrUSZ8
 PT5t1J9p50pCwjWXvCo08GefvnzKBcX9AfBpFHdDRBiVuueLrKKhJsbmJ66CErKK/8pRkICcr2o
 8UQLx2DbzH2RlYGQcjR1N+d01SkDjQK2Fx8qpnyAsBpIvbifQHC5lJ+npiuFzb4cDJNvV32QqNk
 PsDH/68jtkC6+OQk8z2y0BHbNAPYc7aotCK7pnupv/7SozMgJ3Cwfbb1IwIHOpdUP7rdulr8JLq
 lXYqc2rzEkPzMLENLi9vboJURHXo+2xlBUBTXblhx65Tj2ekAEQ1eWbTsEcV5dLXDE19Nwk7Yxm
 mGSXtQ7aGeiL3k7WIm5FOJo+umjDJ/G+sjio+1ytWxPWgZtxNmbAuUo5F7iGEs8Mm6IWcBy4B1g
 X+oNt7+GAJtbS9ZyH0mjiWERqyouX+P5TSrAPYVRsDxGOMyyYUq1fVAwmbNguiElA90xmX7yO3L
 3VBDPeMfxvzHqj7KHxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfXytlvfQqtbbDj
 t05e1FTqTaorlDXVqWRXXAbBNqNMhO7+7a9+8/PINq6a5gvpDZaOJd/uJT0JC8mNdllVGxvzuZt
 qYcER/cV1PqGOxys0Jh78GqyAeawLyo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170243

On Fri, Sep 11, 2026 at 11:25:12AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] In `ethqos_rgmii_macro_init()`
>   (drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c) the patch…
> 
> --
> 
> net: stmmac: qcom-ethqos: convert ethqos_rgmii_macro_init() to void
> 
> The patch changes ethqos_rgmii_macro_init() to return void because its only
> caller ignores the return value, and it drops the speed validation from that
> function on the grounds that the same check exists higher up the call stack.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index ac7d6d3e205a1..44270c25d874f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -371,9 +371,8 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
> >  	return 0;
> >  }
> >  
> > -static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
> > +static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
> >  {
> > -	struct device *dev = &ethqos->pdev->dev;
> >  	unsigned int prg_rclk_dly, loopback;
> >  	unsigned int phase_shift;
> >  
> > @@ -384,11 +383,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
> >  	/* Select RGMII, write 0 to interface select */
> >  	rgmii_clrmask(ethqos, RGMII_CONFIG_INTF_SEL, RGMII_IO_MACRO_CONFIG);
> >  
> > -	if (speed != SPEED_1000 && speed != SPEED_100 && speed != SPEED_10) {
> > -		dev_err(dev, "Invalid speed %d\n", speed);
> > -		return -EINVAL;
> > -	}
> > -
> 
> [Severity: Medium]
> The commit message says "the speed validation duplicates a check higher up
> the call stack".  Which check is that referring to?
> 
> The only path here is:
> 
>   stmmac_mac_link_up()
>     -> priv->plat->fix_mac_speed()
>       -> ethqos_fix_mac_speed_rgmii()
>         -> ethqos_rgmii_macro_init()
> 
> stmmac_mac_link_up() only bails out in the default arm of its speed switch:
> 
> 	case SPEED_2500:
> 		if (interface == PHY_INTERFACE_MODE_USXGMII)
> 			ctrl |= priv->hw->link.xgmii.speed2500;
> 		else
> 			ctrl |= priv->hw->link.speed2500;
> 		break;
> 	...
> 	default:
> 		netdev_err(priv->dev,
> 			   "unsupported speed %s on %s, leaving the MAC disabled\n",
> 			   phy_speed_to_str(speed), phy_modes(interface));
> 		return;
> 	}
> 
> 	if (priv->plat->fix_mac_speed)
> 		priv->plat->fix_mac_speed(priv->plat->bsp_priv, interface,
> 					  speed, mode);
> 
> so SPEED_2500 and everything above it are accepted and forwarded verbatim to
> fix_mac_speed() regardless of the interface mode.
> 
> ethqos_fix_mac_speed_rgmii() does no RGMII-specific speed validation either;
> it only distinguishes speed == SPEED_1000 from speed == SPEED_100/SPEED_10
> while restoring POR values and bringing up the DLL, then passes speed
> straight through.
> 
> So the removed test rejected speeds that are invalid for RGMII, while what
> remains upstream only rejects speeds the core does not recognise at all.
> Are these really the same check?
> 
> A speed above 1000 does appear reachable on an RGMII port through a fixed
> link.  phylink_parse_fixedlink() keeps the requested speed even when it does
> not match the validated supported set:
> 
> 	if (c) {
> 		...
> 	} else {
> 		phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
> 			     pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
> 			     pl->link_config.speed);
> 	}
> 
> and phylink_get_fixed_state() then hands that speed to mac_link_up() via
> *state = pl->link_config.  With phy-mode = "rgmii" plus
> fixed-link { speed = <2500>; full-duplex; }, does 2500 now reach
> ethqos_rgmii_macro_init() and silently take the non-1000 branches
> (BYPASS_TX_ID_EN set, POS_NEG_DATA_SEL and PROG_SWAP cleared,
> PRG_RCLK_DLY_CODE = 5, RX_PROG_SWAP cleared on pre-GE3 parts) while neither
> MAX_SPD_PRG_2 nor MAX_SPD_PRG_9 is programmed, with the DLL already locked
> by the caller?
> 
> The "Invalid speed %d" dev_err() was the only indication that the RGMII
> configuration is unsupported.  Would it make sense to move the check into
> ethqos_fix_mac_speed_rgmii(), before the POR restore and the DLL
> reset/enable sequence, rather than dropping it?
> 
> For reference, no later patch in this series reinstates a speed check:
> ethqos_fix_mac_speed_rgmii() and ethqos_rgmii_macro_init() still accept any
> speed at the end of the series, and the newly added
> ethqos_rgmii_id_macro_init() is equally unvalidated.
> 
> >  	rgmii_setmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
> >  
> >  	if (speed == SPEED_1000) {
> 
> [ ... ]
> 

In my opinion, there's something already very wrong if we have a
fixed-link setup with phy-mode as RGMII and speed anything greater
than 1000. So I am not sure this comment makes sense.

	Ayaan
