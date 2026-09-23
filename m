Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6B51A15A
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168557; cv=none; b=aQJZZepekoSSPptW5sMVMCKTi5JepL1GOxgj0vFBRoGIlDeW7HKRMupalgVvgtey2ipTKAV8jbBfLDrJku8SXpr+4gQ6r+qRiEXImHzAYeJlHJAYJ0WlDnV8+JFMi5kuKtclDAnNMd2OxMv8eYHi6KXHQHUb88odExrs7KoBcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168557; c=relaxed/simple;
	bh=aoukjc8PMMn3p0s9SeEc0oqDisI+Ii+3y99O6Pyf6wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLGW2byKZyq+9Ruwz5H2vWy5DWfJsm+eUg6y/iDvFjwm1jIRh6xeVFPeaEHabwlNJ4xK4jiQuedS02Tc7L/6GFVwr5O6yC5auakgeAbE2uQfMnA4BUXcSTAsx6ctS7xtQMJvFuHBXrnJa3SEfIxQa7t3yC/u+fbh/8Uz0mFtoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbLHUTb2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FvRL/zFg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbLHUTb2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvRL/zFg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbWUk1831847
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rdm7/qh6VqpSPExRnuHdeR6FEt70qNeO121xfyLDFm0=; b=bbLHUTb27h3tcQxh
	QY6hr+EnRUkbJT52ZVejQfyYAfBeVJQfaLWOiJaZBpP6CHYNPytADaHI3LnxRVgY
	/vM7daIFwgoK1qtR/fJD3DzOdQfYEralGbJoIfm7HbNR67b1Jfghlxo2UCFnXRDC
	RU76YEu20sgUbAN1TWs0h9qBNdr2I8evB9vIALMBpi1biWNgshbgSDP44+DDenxn
	9lAOQjLI9PaXHRfIbDe0/Sg2d7Q3hW2QePsY97FCiUKGZ6bmCsgz4ZtTYPVUJH7a
	PmwrlQTDAKz+F39TsA7pqs0m71PmKgwbi40AZinrHVTmnTaPw8pTAccROcwiRtEx
	/t2AhQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma40r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:02:35 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b381f60c4bso217705b6e.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790168554; x=1790773354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdm7/qh6VqpSPExRnuHdeR6FEt70qNeO121xfyLDFm0=;
        b=FvRL/zFgTFmMk2Jzi+2xDb6T7N+hexEnrYkrtbOAiL6AgghvuoWWKTrNbm/LeSQbc5
         bsvYGWqWtCV9jNmQZuv5p2i8A62/P5OEShEy4nxdoaPaw+eK6v7tztXEa5vTiMCpfe5t
         ACq29RZdrt1q/bgWKaT5QFgXIaDE3zuCE25ikKb07d/enfbYBF0F7zdH3fApAsXcZNWG
         zoO1bXMfZWniqUTrl8mXFDyXvH4Gk3qcGhx5M+AdsKPSweacdBIOgCu3CG2CzABP++MU
         Obu4hKNXikppAx2avGDgBY08bww0+0jR+jDcsf2tA40R8b41E9uYQraIS/cok8yQ0eCP
         choA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168554; x=1790773354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdm7/qh6VqpSPExRnuHdeR6FEt70qNeO121xfyLDFm0=;
        b=fPTaUEIJVd+Z47CgI5b6I/nAQQlA7+LcNlKCxobu2QgTUE2/Jbq84beFkGMgBWUb2e
         t6fKLgFKftLBAXWDlOFgFbQJKNPenVLYhvgeYrd1LYR3KApLCA2bEHnRMRuCLL7EQcfq
         iWRjqU5Z0+53Y9SExD1fWJQhTegHlLWozCvEgmBm5fjXV26gk2y1nE2R6voSDVTDuKTS
         dVGvA+sEwqVVNVEgCtWdQw8X40+ICcTGWepVZez423ViXcHyIGFNUgqx29zBbQe1R48d
         ii8zPUcuBNvWjem+7gSf17jVHP4Kucx8ZD4L5wm29RdRV/VHHSiH00mUOek69G6U5vBT
         JtJg==
X-Forwarded-Encrypted: i=1; AKwUvBzsNHNhQKe3jin/aZgy8WtVrTNbTvMQ0T5VtnXQ66wVGz0BikZ1MJKcxTTFxCHKWUhvr880Z4k=@vger.kernel.org
X-Gm-Message-State: AFuF++lifV9J+Nhydxwc/B0ta9eOxEwxqUz3WUky4koAOgtcxZG23Rc+
	GmGPj4dOUC2Kmi/eMNCxQu+UajO99l49vzSj+LJN53wg2p/43WJ4UeHlCNN1+1mwPlvdJLzzPPt
	+x89hEYliWxZmyDasss/gYHUkxkoPJQ8v1biov8hbWBgfxYTviZKU7PBay0U=
X-Gm-Gg: AYBFou0l5jHoZYcCJPBqWEo6BteTR7L1sDyYkB2GAmobBB+ejExYfPhuDJmKxjF3rMn
	JwkkaEo5VFBxyjO/BRvItJpKhmZME3MF0Ie92GuDapjv2yEFGca4HETnIFXhCWAZHtql7qarsXd
	Vnp//v6LU/eEHE1INL67aqUhW0leZ+3jOU8Lvn1iZ6ekwrv+ZNa2zUV7Pr77jbRLT7UFb2xPnsX
	VwMCsdZAaUWo8PHsvXQiBb3/tDBk3pZLZ5ZyyE8tRZHBowZSL1f9fA91ThJ64s253Qzec5Sx9Mf
	4bxLtL7Lu4I8XTS2yOI+9tR+nrg/xlzkqrH33bbaP+PPmoIBB8GefsuH1jdXckBPk4U7/k70a/z
	27+e3y4/sh5cWK7Jqi6hlsw==
X-Received: by 2002:a05:6808:118a:b0:4b5:7880:14ef with SMTP id 5614622812f47-4d5bb1321c1mr3001236b6e.6.1790168553548;
        Wed, 23 Sep 2026 06:02:33 -0700 (PDT)
X-Received: by 2002:a05:6808:118a:b0:4b5:7880:14ef with SMTP id 5614622812f47-4d5bb1321c1mr3001170b6e.6.1790168553003;
        Wed, 23 Sep 2026 06:02:33 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33ff75sm120445366b.9.2026.09.23.06.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 06:02:32 -0700 (PDT)
Message-ID: <162d22c6-3558-48f7-a1c8-5337218e8e20@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:02:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 2/5] arm64: dts: qcom: shikra: add ethernet
 nodes
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-2-69c0c5c7c124@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet_dts-v1-2-69c0c5c7c124@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gz5TqCP4I8DHpzkLYlvT8KqhIF0nakDk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX5iW5Xo0kVh54
 GiXx/7mory8k38g1x+sX4WSzvkaZ4TiPeTQabREKsU7yQFPQ4CIJp1oNVHZ203AGRoxNUoe12hP
 bGXPPxCtb1xvn7i0KOiZ2mMLp0dthoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX1uvsPmkCStmI
 KOLP78A0IqjZXMeg0Onmn+PvBJnGQU/0FaD20LLLZswdgmH4Oh838cnJyXdkifamJtqtymkAyqU
 TKIUQvR2HoUbE+IT2mQCsnmBAEjBnw0wD9vSl2B7zXO6rl330yAOHg1p7mA1rMt65pdBpQm0yVg
 U4/kMRRpCLROgFkA3zztpvZ+o4V3khQqnZPnCtEYt3FIAUScEbWpR6rji+6tKUOSUVGvXQbOYr8
 Ln/yHzv6EAW2jHOBl40hp8RAh7QTjXTEi6mPvH3OkecNSxABcRBBqLOeCSuRKQtVhZhptdiEaB4
 Sxs4EV0mdARnX+LpUj6OAZ0O5I4K73yPP1RHtJuShFaadP4uomNv8+0gNQdQhdL3XXSOEgsc7/m
 2D9qKp3hGVPVteV5HgFh3hqpS9Gj4F11TuGrvaNoSe2B1255f6FinvTrzDvD3rgY9nyx7HUxRMG
 eDxGqtAJabyZomPYuXw==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab3cdeb cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=osmAEHCOFALxNhKoBNcA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: gz5TqCP4I8DHpzkLYlvT8KqhIF0nakDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230051

On 9/8/26 8:23 AM, Mohd Ayaan Anwar wrote:
> Add the two Gigabit Ethernet controllers present on Shikra (ethernet0
> at 0x5d00000, ethernet1 at 0x5d20000).  Both nodes are left disabled;
> board files supply the PHY details.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---

[...]

> +		ethernet1: ethernet@5d20000 {
> +			compatible = "qcom,shikra-ethqos";
> +			reg = <0x0 0x05d20000 0x0 0x10000>,
> +			      <0x0 0x05d36000 0x0 0x100>;
> +			reg-names = "stmmaceth", "rgmii";
> +
> +			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "macirq";
> +
> +			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
> +				 <&gcc GCC_EMAC1_AHB_CLK>,
> +				 <&gcc GCC_EMAC1_PTP_CLK>,
> +				 <&gcc GCC_EMAC1_RGMII_CLK>,
> +				 <&gcc GCC_EMAC1_AXI_SYS_NOC_CLK>,
> +				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
> +			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii",
> +				      "axi-noc", "pcie-tile-axi-noc";

Ideally one a line, also for reg-anmes above and icc-names below

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
