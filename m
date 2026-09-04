Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45927421F0F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555973; cv=none; b=Me4yH1rwxSSjykCTYko593a/COEejgMjjLf6BEY6UZZh5yMEWH3VZckoy5JN4aD19LtENUZ7sc74dRasYAacyzcS8LBDIIkX4dJb2uX/3/phh5Z7ngQBpsBS5OKhtPCNGmq37FezqO6u9gWb3avQld62WD3qHCyfSjhm1PPijVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555973; c=relaxed/simple;
	bh=FAC+Zj7qwKqYw7fFM0u215FoV5ND4YX8fjub2SpnxsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko0aoL4XYcDe+hwkZjdwe+QOOGbpsx4TCNzCT1tJPJ+N+doYY+IZYJe8u+fnSCOeBtMZldDwPx73BX+EBl4fX3wBopNnCLIskuGhiT6+e65f7sf6F18Gx+lmTyrvtR7Ltf+EbyMWe4wbn3hy3VkQZ3yXnQERtUp5LGT4H53dYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6tqP/YF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKCa0LoO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6tqP/YF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKCa0LoO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kbl3C4083760
	for <netdev@vger.kernel.org>; Fri, 4 Sep 2026 21:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pmKN2/HQZks0tpmHaapx54nu
	pIE8cyQNKHSbzgNzJiQ=; b=f6tqP/YFyo1lXLN2qbefS6WAXA3eHAq623fvow1m
	GSNGrPJZg5nEgTLReHGhb2yx4uLZTnrbVXNl0kXlLZMhTuhA5yJ9hvnDZplw7nXj
	Kz4i8xIo3AGWJhWSEFIoDJNio5RbhzAFoBCnAXJQep6LcAClfkDmd3i3ZSAmXg1F
	qSpPZv42f5QJ2mLUzoa3mQyMvAy2c35UCAG12UgfnfGGFuQ0s34wvxW4rUCGiKfr
	ajgOY+nOGJvkz44ft2VqlxQtvdPf6QkZvjuuMybFBebozZfh37kVd4XrNPDe4L4g
	4p+ZPYHvsfN9QKUhKNqkGWuPklMZI+r7Y5pkwjoAL8EzVQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00y9nh8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:06:03 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b1a220dfc7so817864eaf.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788555963; x=1789160763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmKN2/HQZks0tpmHaapx54nupIE8cyQNKHSbzgNzJiQ=;
        b=LKCa0LoONEchSlXArrJKU+N14L4f6KaML2w//9AkBNbpMIgW4gtNEDQSgbEw8Ks2NA
         UDe7I4SNgASNfS2K2CH1d0rWzAqzG4xGFolr4/N/f0U2l09Dr2uGfsVUKIt5rx0MBBLA
         +xmayAPFM1VaSr3O/jdpF5RPIgXfv5IW9X7aidegCVjS+nYEcBpWQC7DQJwBVVhrWsaU
         NLFpubswGfgbxJV1Rw6tNrYWbceyfS4URyaduiOz4dJnlThlbJJXL06+nknK5a3/tptN
         2/GjPIIF54j0ma18SavM15MB9BnxB0vN0kziBZPahi2MqzPOjJP3BrFP3VqmU2/xh3pH
         kLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555963; x=1789160763;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmKN2/HQZks0tpmHaapx54nupIE8cyQNKHSbzgNzJiQ=;
        b=N5sf6+peb8HALVIOWmKpbMfE+MsQ7FUpLkeOMu3lPjOpIHtPlBnc3eNhFRP3X+ODPz
         MCilYHR4wYUYDwueoySImLNOKtvh6KN87eOZWM+wgyK0k6U/PZURdkGfx5rPXF+AhPbJ
         YtxfBmnDgsnoeTEOPPFC3lL2z+bXOMWkQsiBm/tuLOca7TSUwlAiTwHEpCgTUYotSZxn
         ix1GLwPxF88v0eoRO9LYutYsPL4yNLc6AwoGQMsYuOkpr4V8qSLfuqGtr8BQ/R9gxx+V
         CVI6dx0bWa9QEB8+70jl75+SimFDugeSySitCJFNZ4HZqzVfFrofMkYwYnTNo54EtFAm
         dEaw==
X-Gm-Message-State: AFuF++lTbMQXXgd+b2htaUeHioMAryJI4HqI+cwE8zgGGNpvv+vLZvXE
	BSwkglqIuEDibWBTY+Pk/+nK/KBOc3ntnIlHZg8tBocCv91DjmMkJUvpJb/1DepKbJ7Ey9Jr+oe
	CKsPuxPZlxUA44zEOTVIljaKbORKqC1kGRgkhJm531YG5nmjdFp3RuR3A66o=
X-Gm-Gg: AYBFou285GPXXyAn+2RekpV5XvPdAGKNoJxdpo38nWNG7H4RHKYXuUqe49xn8/zoUgL
	W1LXnt4hKmWnNUcxNbB1qyyfagn2lB1kIJuvHlF1efHNumzY8vGH2Loir/TfqzCA5lf8fC150Hd
	gHOM3qWvjetbXQoBgvs2wN1Z3DLJuPObWvx551pKzwdczVrKVS6TknmYl3eS9Pmnn1WMjJ0LVDX
	u/+d+efQQXimEKNyd0z+IsP8pEDGRgXVaWJAeZXV6E8pXj73XkuKAPrqY8lG4Ztk1gbNbK1HCl8
	miRiyMFWEwUw949cKZX9LkqKKhPjAQf302wWSs0aKvytOg05qsB7yC+Y6TWWnwLFi3QYLAdbF3G
	rPMwNIjPqYw1VYw==
X-Received: by 2002:a05:6820:4b88:b0:6b1:bf3a:ed8a with SMTP id 006d021491bc7-6b6fb4d7bffmr5403403eaf.14.1788555962968;
        Fri, 04 Sep 2026 14:06:02 -0700 (PDT)
X-Received: by 2002:a05:6820:4b88:b0:6b1:bf3a:ed8a with SMTP id 006d021491bc7-6b6fb4d7bffmr5403371eaf.14.1788555962494;
        Fri, 04 Sep 2026 14:06:02 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm8692399c88.13.2026.09.04.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:06:01 -0700 (PDT)
Date: Sat, 5 Sep 2026 02:35:52 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 0/9] net: stmmac: qcom-ethqos: add Shikra EMAC
 support
Message-ID: <apsysH9ia4x96a2g@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0anxhJ1wqpcgihgFGML7t-wuyMZ4Zjnu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE5NCBTYWx0ZWRfX/7QsfC+N3JYK
 08eI9qxTBPU/bRBbQgQc5pnJTvWNEibBnHAKNpgLMNC+7SGZoNr8z4VClKAAgXqicVx9vBQqjDw
 DEqam70UOPbi4FAOV5cKNxhXBccT2o5R82632GlE9lHVIFwnej9wpBd/jNWKO/wfpj4oNAAItA4
 JVUnmpGdvFrH3xZrGn8ALNKeyivM60EdQmYppBGKaX9vLaksv2WA6y8TPMfTqzZy0zj/YMl++vI
 bZNVpAgtiOfPp5jmZ1OjkrdrnXdHVTydKPvYqrLjUWbDswRNZrQBt2oXMJ1e79yxbmRGXWexou8
 njJoE0khzMY6YVcDGvI1uCBldoPZb+ReQBNMCRlp7cerWEwBFVEnD62xt32vaWal5XMSb2MoSaC
 3QEgnONlVWef59YaGrNgc1UFWkRXyV5ravjqlD36t3ZYEr+8CPdO/aJUZ138IkrnbFmpUU20tvj
 pmGFSmqOAIAqO6qJBCQ==
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a9b32bb cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=T3LL355Ksxp6dEOEn3QA:9
 a=CjuIK1q_8ugA:10 a=k4UEASGLJojhI9HsvVT1:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE5NCBTYWx0ZWRfX2pV4FeyLUudc
 jO2pWWfBzig0uT3dg8iSALZyaJaPz7uvOioVccaZbbwdHFlhUKbvLUWAOyGbGuwab7jAn561muz
 GmOpaqIBly6zdsdUjS/KLJHlxvBvfyo=
X-Proofpoint-GUID: 0anxhJ1wqpcgihgFGML7t-wuyMZ4Zjnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040194

On Fri, Sep 04, 2026 at 12:13:42AM +0530, Mohd Ayaan Anwar wrote:
> This series incorporates feedback from the RFC and adds the dt-bindings
> and driver changes required to enable Gigabit Ethernet support on the
> Qualcomm Shikra SoC. DTS changes will be sent out separately.
> 
> The series has grown from the RFC and can be broadly divided into three
> areas: PHY power supply management, proper support for RGMII ID mode in
> the Qualcomm ETHQOS driver, and Shikra specific clock dependencies
> required for NOC access.
> 
> 1. Shikra EVK boards use a GPIO-gated regulator for the DP83867 PHY
> power supply. Patches 1 and 2 add supply management to the DP83867
> driver so the PHY driver holds the regulator vote at probe. These
> changes are largely inspired by similar work done for the QCA8081 PHY:
> https://lore.kernel.org/netdev/20260605010022.968612-3-elder@riscstar.com/
> 
> 2. The generic RGMII fixes from the RFC remain. As suggested, an
> additional patch now emits a warning (patch 6) when the legacy "rgmii"
> or "rgmii-txid" modes are detected. A new change (patch 7) now
> initialises the RGMII link clock at SPEED_10 on probe instead of
> SPEED_1000, dropping the unnecessary 250 MHz source before link up.
> 
> 3. NOC clock voting (patch 8) now uses dev_pm_opp_set_rate() so the
> required VDD_CX performance state can be propagated through the clock
> controller. The Shikra binding (patch 3) is updated accordingly: an
> if/else block constrains Shikra to exactly six clocks and requires
> operating-points-v2.
> 
> Testing:
> The following boards have been tested with this new (proper) handling
> for RGMII ID:
>   - Shikra CQ/IQ variants (with the TI DP83867 PHY)
>   - QCS615 Ride (with the Micrel KSZ9031 PHY)
>   - Talos EVK (again with the Micrel KSZ9031 PHY)
>   - Talos Lyra EVK (TI DP83867 PHY, this board also has a GPIO-gated
>     regulator for the PHY power supply)
> 
> Changes since RFC:
>   - Two new patches add supply management for the DP83867, replacing
>     the gpio-hog approach for PHY power -- Konrad, Andrew.
>   - Use dev_pm_opp_set_rate() for the NOC AXI clock and require
>     operating-points-v2 for Shikra -- Konrad.
>   - Warn on legacy "rgmii"/"rgmii-txid" to encourage DTB migration --
>     Andrew, Maxime.
>   - Updated binding document for qcom,ethqos and snps,dwmac.
>   - Drop the duplicate "axi" clock from Shikra's DT; use "axi-noc" and
>     "pcie-tile-axi-noc" as the only additional clock-names.
>   - Initialise RGMII link clock at SPEED_10 rather than SPEED_1000 on
>     probe.
>   - Link to RFC: https://lore.kernel.org/netdev/20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com/
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

Sashiko raised some valid concerns, I will update the series and send
out v2 shortly.

	Ayaan
