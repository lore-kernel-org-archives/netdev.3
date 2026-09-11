Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A93515C5
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136769; cv=none; b=sGFnPuLuaoDOsgp+5MIxd4oCtmNDir0HNcpidYgJxYpsvm5nQj6atZvzMJmoT4SnwFOCNUkM/LAPSqs08rLCDIxQMFNJin5Kw4GEPNznDMHEkDwtsej0wjscA2hYhj1VZUzn+k/m4r3Dl9oOGXpycoseWOJxbvT+NwrXIlv3jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136769; c=relaxed/simple;
	bh=StmW96JqWZG7fKkrql9YvkfYJmFJ7jmdDutyVcOwjmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxls2A7hyQM3VVDlDw190k3NcAY/T/A5vtF/4J4XfA+/Vz5Gy7bGCd+y3KxIDyyfJ2CP/hKgk48mfyDbU4gF0g8XJUIv5/owjvVMwV2xiWhS/onbagEkZ+OB7+LsoPI9HRGVr190kSAgYXR7A/5UxOUI+JqwERxlCybsMROsR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5Ej9Iud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRlES1ei; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5Ej9Iud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRlES1ei"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCjaag524827
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uz25G+qDafHaYTcukJB4mX7gmdL4Il0RlndYwgEhWHo=; b=m5Ej9IudHnxlIbJp
	CqMiKZ87K0v0zFULFil/b6+JHUJQashozqlLTCGFTnEdGqz9YVLWb6vPxGKQb0bJ
	nbV4Xd5L2NSCchk7ojPnkY4ysRnL4vuVy7x+C18V/1PHXFmW3YTx652qAVa+IDep
	N+WYnFQ9SRqfF4xKkeL1hMhRIWphax89BMoMYUK4DbhfHYRY6n5fgZQpwne1wK1I
	qkFBK6AYX6QEti8kt37E3wzjUqvxIcXWRM7DOmW+6yYNe21zQNP1iG7vpTsxef2T
	UoE1Apj9rO7pT5LF8kzVZ/SjAGaxQHbh9KOw4aoAPi7Lo8u13Np6rcshLJ5usaH2
	0W7mWQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q13yhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:26:06 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78fcc331099so39811137.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789136766; x=1789741566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uz25G+qDafHaYTcukJB4mX7gmdL4Il0RlndYwgEhWHo=;
        b=NRlES1eiIc9cuyxssBZ14zXXNpoMmuZiRSZgcpzpWXuj3kzOozoWfMJ6m8pKJVUhnF
         MVfAuYRglJMx4qtCufLjdUrDqcxkGodVBeQmtnBp8Tr+40/m3Var9KmxeEdW+75xg4mD
         ZV3pzLuYCg3XlAPiBOXRfdv+mPEh9k3BK7Rf7y5UUYSccZZYeU9TxYzVBLKDD23Xbjn1
         5ewKoHb0fmtqdmTldj9eezmJYNtSn+CYvr6nLpSosulenpTr1sMzln8LiJNlT2IfluUC
         KIQE0vGnSIRt2mLOto7fyvQ9PfYY8yUcXVt7bC1ZROVm/F3q0xdcpuYsGtwTyXnMCrpI
         THaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136766; x=1789741566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uz25G+qDafHaYTcukJB4mX7gmdL4Il0RlndYwgEhWHo=;
        b=ej4z+yMtYXMeQ7JtyCQuFBvaOPLvEsELOloEKf91g07ZDBdk03IMF8Z816z0HmKGOr
         rzoDE6xJ1CAM67vZiWPnebN5sVDajGpR+XB/PXwO9ElJzRbZR7wjH3Fbf+X+2FqJsGjQ
         4bX9cjnj6/fIMdLz21Jg4A17Lr3Z9pnf01cb2tZGjU07JS2b1V1b9PNlySHZvbUrFdUu
         MgHfaPtntoPckm4bedOLl0rlgiCMXv7P1Xpmj8z5vB/YfNim3RczG85SvBGuf7o1kQkb
         ezESd9l2zrZ7nKxNV0OsqvPfKZRxSXsdC/7JQW4aidA+RMF6fcDSDxr2yvV+DkGJZQgp
         t5bA==
X-Gm-Message-State: AFuF++kpJWFzSjDbXtv93PnaNGmutmETeYZEyZSDZD3p5v4tVoW588K5
	WmrjU4AmzJqpZoBYvaLbXVgZtEZ4qFqCf/D0DXfRY3XkJaTv7B1QHsrDn1COJn23fYzUrSZGQKp
	swbqxx1BqnRTo2GZTm+oSn2vmLsikcWHhzF7y+RWCjUBAP/M1mFN/OU+A60I=
X-Gm-Gg: AYBFou3VcIrFJWcyTui5jOUER5Z+1vHbcAqW7vERbuXDQ0Jls9TYmllTzFLYt8OXuti
	ruiKuy8Awx4At5g+JLWlF7TBcmYhQtZGtQXAyY1hHhpl3muqZjte7TT/Upi8MBvXEsjhcfWDCdk
	2WQoNDNuqd1DOHBe4pmxohWSjQQAYX4/XISt93KnWob2L0qIk2j/D6imgkTPLEtoQ1y9tRc9F+F
	aSrNWgqDCnikevIBerBI7nyQt58vDWGiWunNQIeNSMMzsX+w1hmE/Hm+9ZsaVcr8uc+wOR7tWZO
	+ibIhrtyv8sxVvuoQlmHOaLRIDL/vRtl2i+10Z0jHj5ZZ0FaDrriIbYVIeFjS4lP48oKVIAXSlM
	WW2m1wlk644XfR9UEtIJHSg==
X-Received: by 2002:a05:6102:41a2:b0:791:33c:9d1 with SMTP id ada2fe7eead31-792a6758b54mr1275623137.1.1789136765734;
        Fri, 11 Sep 2026 07:26:05 -0700 (PDT)
X-Received: by 2002:a05:6102:41a2:b0:791:33c:9d1 with SMTP id ada2fe7eead31-792a6758b54mr1275573137.1.1789136765193;
        Fri, 11 Sep 2026 07:26:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966021d0dsm86105266b.10.2026.09.11.07.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 07:26:04 -0700 (PDT)
Message-ID: <04e79cef-bbd1-4f4d-a249-f040c7e33435@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 16:26:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] net: stmmac: qcom-ethqos: add Shikra EMAC
 support
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
 <20260908-shikra_ethernet-v2-9-bbe3389d0652@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet-v2-9-bbe3389d0652@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa40f7e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=q6PzOI_h-AFGYkee8UYA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMiBTYWx0ZWRfX955m4f/C/Aas
 VaHtTcH0NpA/ZG4PgaPiteAgQZ7RBUOzFTOVVL8egN4SBHHgTtRyUWcYNq36AEqqcaaX2Lt9Tdr
 saMvxxGEGNUijTLy/VS+9bd0rwU9p32N5DuFX2bJhNwi4O2YD6bY6J01Hf8VSHhhdz/Mhe1OpsL
 N1R5xwE14f2DmwPGgBh/Cjnu/a1xwxRXMEQglTrtTasIYFkY+Yaovrd6a7bSQe4uLw2iU/ElFCt
 l+GKnNoziXK483RS8RM8hlCVd/tCKLFZml+YxPtsRD90JHCK1sBt3KskpLYd1ULaumhscbCGnf+
 XoVrcec3FQbY5Qh5dTYku88FStJfRVA87sT+Y3K+50FH7LcygOjUXxRjaJOU1vNNPP0veJ46idU
 c9FBLSOzStL9mcZoBags/PXS6bdzCU+mlcAbBAGDu/UrxCHgwcg69GP/9qK3PhxR8oiCLg1jyzu
 jstQWH1F5PFVb6AChcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMiBTYWx0ZWRfX0AsRCaePAIQx
 kzJWn742XBl2z1Jq2e9OORktKG/mtFLDmJiNAcq2zCKcocpJtoFM7ntIOPBPZrHxKY44nuTjD/0
 LvY3/C1x1E6UqPxhUnch/UFoHBHVBEs=
X-Proofpoint-GUID: Pi7bLGWVjlOTYqWzXKxcfd17mxMCeJQP
X-Proofpoint-ORIG-GUID: Pi7bLGWVjlOTYqWzXKxcfd17mxMCeJQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110202

On 9/7/26 10:23 PM, Mohd Ayaan Anwar wrote:
> Shikra integrates two Qualcomm ETHQOS controllers based on the Synopsys
> GMAC IP, similar to previous platforms.  Register qcom,shikra-ethqos
> backed by a new shikra_data descriptor that enables the three NOC clocks
> required for DMA memory access (axi-noc, pcie-tile-axi-noc, stmmaceth)
> all at 120 MHz, and the 36-bit DMA address width.
> 
> As part of the NOC clock voting logic, the qcom-ethqos glue driver takes
> a second enable reference on the "stmmaceth" clock, which is already
> enabled by the stmmac core. All three clocks in shikra_noc_clks[] must
> run at 120 MHz for NOC access, and managing "stmmaceth" through the same
> clk_bulk path keeps the rate-setting and enable/disable together.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 8871d285941162c72e2a8f79d2eef915d9283796..c474f1e5a043777a52bcbff8a488640f6dbdca30 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -328,6 +328,36 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
>  	},
>  };
>  
> +static const struct ethqos_noc_clk_cfg shikra_noc_clks[] = {
> +	{ "axi-noc", 120000000 },
> +	{ "pcie-tile-axi-noc", 120000000 },
> +	{ "stmmaceth", 120000000 },
> +};

Can we please put this into an OPP table, so that it also casts
the required power vote?

Konrad
