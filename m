Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC333DEFE3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221320; cv=none; b=bHu6xx1rpAbRagerqD7i0gf+MyjbIEMDDRTvtiHdzjAOeqMSxp8ICT1sSqUrwu7gpqKKx3jnrGsVKtTxHUKcpBMSW30z5vZMivHHG6sldbAU2X7jeEEio6mJyKM2r3rV6lq/Y5xeaKq87uDqiEiSpr/MskCLPrTwoVpsbBEBJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221320; c=relaxed/simple;
	bh=nQzM03h0wDPGoZC/R0f6dhozLoiqT7BCJjf7f/hgEio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkxcUQZJRnBJJ9I4r14csNPhOJZauNj5IzTSqgLR4kj1zLWxLAQSJB/3+KJO7QS1og7+ZLD7l3x2DCBezP6Ps3WbNLNCLH5sjodNgVrh47J/k+y8nZfcYgaPV6B7uDRdCALilYXPvawJMm9rpg+WV0j75d/MIbGVBSNiuKwn1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WkMSrSxs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIu1qmtT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkMSrSxs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIu1qmtT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O36h1b243988
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3akuMu2P99UYG1jm27drky1RZoZJnbv6X6rWoGr+a4I=; b=WkMSrSxsjjYrE8tN
	8hb/HAhjHQvCJFCXPAhDBXduSkI+v7O5O7Il3SIEP7jickVJYqJuW7LhK5FgLGNq
	h8Q/ukIjDcGWBp1ZVhmFa391Q1Clll9/IZ4kpkYru+2wVbH4rtolfUnDSAqIktz3
	wIHgLF8uzyZVkTUZ1GZ/B/ldOp3B/5rzzzJ02e35hbHY/SiiT2UQX0/NuOba3I+n
	+1vJeYfyvnOcRypUg9Tr0muFO7eRJgPrjVt4aKX+ho1JXa9VCREmNZYuSLU53NKU
	YSsYQ3intb5Oa3JUbqjGRaW7XL8coFtokc9EkoMqIpeeGXt7CYMK/TRUShy/3LGK
	ndFu9A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7m2ch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:41:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-868db1b2c64so1386574b3a.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790221318; x=1790826118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3akuMu2P99UYG1jm27drky1RZoZJnbv6X6rWoGr+a4I=;
        b=dIu1qmtTjqNu9obHt943A3oncbTM3yM5ZIDKGUkom2e2+zfJ0K2imIJfuEz9/bMJGZ
         DfqtixVAXzuEtHfe2DY8wxAk7vnT44L0BK8ruzZ5ScdvP7/qOfKu+8960vtvOTp+O6oi
         T2U9i52jQ5UYP8WUjNYYwx3wpA5OySfdM2M9OBVVdFIFAM3QJzOXHtpudhwFDgAmvzMa
         ragvQCeZTPqLBaL7sdxEtDPJx3rj/YswjkC6uVki2YnJ0akJndIIqBMX50uhdM+k/xaF
         jCse/kWWD4h6SMh/ffFF6kYDLfgeyrgql4qcibfTWGQo99Z12FuH1GPYFK4oR0yxJoqM
         PoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221318; x=1790826118;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3akuMu2P99UYG1jm27drky1RZoZJnbv6X6rWoGr+a4I=;
        b=jbu6Zd6Ao9k7zC8z95c2z4POT+RgBLv1w25ut1kKjaXrOGzvOTOEgCWa1ru0cM0BkM
         xUeWu3l/+aXS0+c8EnP2SMU2zx0vVeZSzJfzisdX12pecZIl1Wdbx8eOKQyVTHhbM9D4
         7Tma15iUWqL0KjjTgdKUhvgOYGDG935FfnjBpMBnfQonEl8D8ozvcm/wosPict82cz9S
         b/iHC6k8jmaYQ1y8kF4El2eRa3A2zx1Qa4dVHsgVcZ02e+WafSYo7vMirdyk5uXJh1j7
         5JzQYYD3cOJW3feodniaN2hnnQnpaiVYAvPbsZlKYwttrttSgKHeHtFlgpU3evqogO11
         O9sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDz/GKOHMtwMrdFGvwarSearRMC/qA2ihk4HghW4PQHouaTLleXJW8AgCkqoohk/DBKBzt0TQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kgCsf0aIsJxwbdE5tWDIyyEwgk1EMMF6V83uudaUMqF+OcIo41
	efERw1tYSb9fvdoF1oJkfe3v6pagZYOMqbYDzPenTBF9gjJgRSp/M1O3q/sV+L+qWwnUwUMbxx0
	+aWFwy26KnrI5vcs8c65qGBajguuy7p61zk0Wc6Xk9meI9QqMwIVxsZ9KERc=
X-Gm-Gg: AYBFou2dc8KWMLXSIucSKHWo8fsWuHhTpAn4rXx2zHscg64C7X6MeTdlUUO7+G4i8MF
	B2rxF4ULBuliZAKXuzx3KN1r3i2iSvaSktSmQxUvVGPlJLE0NV6gH+Km0mlh462bavoZ4kZjahe
	tmaidT2trHEo1LZt8k5BFYmeWdg0MJh7zwNws2MdMeej5AmBUZl99Nsv7qd/cn0Uz9rfbV5QrVN
	8w75TrD1hIHnJFT4w+OqG1Y7Q5FAuiK/th7M3B7LpNg1m28WLv8q4TidaE1Rx+IyCickTpkN4DG
	oi/7AXXFgNrqS5fVpf/hKR4Yyeyjp+0RRfvoQdToL+a9oyyt7eos8F70fj15lBbQTBQdx9dUInI
	eW9kE6g+ZZ8P/9icAfCGesymi
X-Received: by 2002:a05:6a00:1911:b0:874:705d:f656 with SMTP id d2e1a72fcca58-87e9b3b680cmr987228b3a.36.1790221318105;
        Wed, 23 Sep 2026 20:41:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:1911:b0:874:705d:f656 with SMTP id d2e1a72fcca58-87e9b3b680cmr987215b3a.36.1790221317574;
        Wed, 23 Sep 2026 20:41:57 -0700 (PDT)
Received: from [10.233.17.96] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb9416sm2123606b3a.7.2026.09.23.20.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 20:41:57 -0700 (PDT)
Message-ID: <6cf51763-9053-44e3-803e-6bc1e000e75a@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:41:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com>
 <5b7031ce-4f5a-49af-9d2f-202050f53aed@lunn.ch>
Content-Language: en-US
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
In-Reply-To: <5b7031ce-4f5a-49af-9d2f-202050f53aed@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o2mFMoLlVvYNLfteD1F8cBnQ6bL-Dzya
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab49c06 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bR27bNoyu6P1LqSCapEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxNiBTYWx0ZWRfX8OmYUejXpykj
 o2FBgpOqzspMHIZ0nclrs3TcL0Yi0VEd0khUrMaxAIJQrX+sOCT+T+iBma7NzZpJK/RxEnkzsHu
 rJlQrAV+CwWv6XFMtVOAJbVCauAet7cL2u7k2KuXFp9hWuazS2ArAw08XB5ilpJwji/UH+OsGwA
 lNPLCbgn+pgGEl1RbWoHDnuUmGJ5JDOC17n+Vz+KCuOPt0IGLz12gYAdSnDhuvlEQI+teN0BLtS
 xxJicENPdUHwYwhZWKbu0GuKKuJcKycW3owOx3PaGo/PtTizOENWwdK1S2TO0KiUSIWoqlU2SiJ
 JApZVmBJaEhnGiWjgahMgrzC2dUyG6DQcvrB8YC38DDwvki5s7iTwuT27eqqdmD0qaleW/Gr+Ue
 RXUew9ojELpb3VV3+mLgJCvXNUXiOngHpF8y9lOIY23Dj+t7eaohK3CfuwzjRYfRqpWQU/oEdlV
 US0NwQgyVwXdOzfT5HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxNiBTYWx0ZWRfX3v7BZJUSDrI4
 ei4gAZYvQfGd2w1zDqxnPqtb4Z+1yi0P8I1RNjvwOedrxHoNrgzJkfHXMVjyxXQ0wFLwq725E1Y
 Jdcz9qnSuQoXxBHNdU0eTE+Mh10Qd8s=
X-Proofpoint-GUID: o2mFMoLlVvYNLfteD1F8cBnQ6bL-Dzya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240016

We only have AQR113C hardware available for testing. The AQR113 may
have the same issue, but since we cannot verify it, this patch
intentionally limits the change to AQR113C only.

If someone with AQR113 hardware can confirm the same behavior, he or
she can send a follow-up patch to extend get_features() to cover that 
PHY as well.

On 9/23/2026 11:26 PM, Andrew Lunn wrote:
> Does the AQR113 also get its features wrong?

