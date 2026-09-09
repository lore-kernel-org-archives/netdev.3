Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27583D5666
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952824; cv=none; b=PsSskTStvSzdFZFaPMirk3kcAlPhUIC0iPl51Bv+FS0HC+oFH2lmLOGocOhmNNKslaD0BIPLkS3MqNWIcvubbJiHB/cjSGO0JERr6uKx6Neejz+XLl7eESm0KJVFODZF1AegUKTq1KZzyoBsj8cvhbeOBWJxd4JbP3oqttAOlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952824; c=relaxed/simple;
	bh=DUsYlKkvwKjjsSNqIoQQxP51Bvntujpq0lq4unmaNL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxCe5Uv9/8fje4sv/IMmIwIYTdGBY6ah48KBkTdjT7kKPZTFa74NG/oCSJSuhRKoS9k1Nyxne3owG84JKTiaiUwSjdEBSVeePWybsGdWeJABK41SNZxxCNyUpPu5x9t7PPEV8SUF86ffu3pC0ffGS+XpZncHHJHhzgYdkCpv+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ECFrIsn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iTiP1I5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ECFrIsn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iTiP1I5U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Apb2o2084094
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 11:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vQtQQqwToKFipRp5aPXLXVSkmG9dKnTQCGGbK9gORPM=; b=ECFrIsn8p5LdXh0B
	008jOPQ4K4CKWRWQsmOHYYxhJtvGIah/owRDrTJwK87nEDb/SIce+cTYI5anaw8u
	aJ/SKqbT0yDtH2sud1oI8hfSIS6rxTu7KGQcoNtTNO88Wn/urWLOi0XmoWD+PVZt
	inriZavsQwbnYzkwF68vxXVB9EGDdkJtjeXAT8mFXFzabLDXSoKvCUdSsAYPgIEB
	L1NSOpC9g6GMyeXpfBneNkvk+TXmBFB+DcbLLHolwRVkClvV3mGewqN+U0bEDpPq
	v9syV2Q8+p31PFSEnXTU8ew83iGW2hf4IETsh6mQ7qKWNnDTRvRj7gIV0/0g3QR1
	gCyItw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rgg66f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:20:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939a28482e4so61208885a.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788952821; x=1789557621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQtQQqwToKFipRp5aPXLXVSkmG9dKnTQCGGbK9gORPM=;
        b=iTiP1I5UU2T+zIIQxxj2FCgpHWQqic5PBgYYfILSZ/Ezge3IGt9HMD8J46WtSkn/w2
         rBMvQyWn6ubgEglkDT0oAGmMGvCVViMcSvfyOA6BXhspGg83WQBL2IxEvBwi9QwyrXVb
         uSaaFOyf+3J4rqbGN6ZNPer0pETaA/S6iVE87R5zx5EJm7nL0RzfkQWBemi6ViTVHobw
         1FJB02Qpl8iU3nX9UvrscpHPBhR+9M/CJDUdVk5VAGqCW9Abyn0QV1ebXuuTA2W/3g2o
         TWElVMgUDoYu2bYUPAA244JGxajSdHC9gK1ymJ+dz9NMPpB+djxYeNW5CdQ4ol6bnRrf
         Nntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952821; x=1789557621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQtQQqwToKFipRp5aPXLXVSkmG9dKnTQCGGbK9gORPM=;
        b=rMXfzBfMwQ2j0Hd9htjI3Wb4dxZ3UqP1LoB1oNcT5Bhuurrwkvo+3KACYZX2iZ8jwm
         JF6AcPisD4k7cwnn/9kWzPq+qDPEcmNydAQLxDRZREwgRr0gA+gHtR6+ZO3L0bx/3znd
         ZQ+rzJHhmWkO1T03ysRQsLQayf1CTPRgceeHw7GGokuymYdKHGISOxhUkyRKvmJ7HKNL
         tYWRMbQhZMiIvMMJvW4FAupdb0khQsWsy5JUp8RgYrodTuE7Cch9NGicDldt08R0vPNt
         bgay5dgZTkatNANLeRsSOX+XApCP2prNybqVSEw6pRKooW3bbGAdCpRmDPr46sT4D0Pq
         cwrg==
X-Forwarded-Encrypted: i=1; AKwUvBwa0iLlnqKCW49HTK878mXISKGyw95A50d0mhT5UlwLHvX5Kds68j17gKVqbAMQL0CIAlNBoO8=@vger.kernel.org
X-Gm-Message-State: AFuF++mJEIRQ2SAIredpjoogiXjIly/XWs6nnIFSM6mB635zU7D6MQ1T
	O79QJU6Z6aqdTvFsiG7sHWF77RmqQ7XJLBJTPY1BFYsBZMiHkthxrccaf0Lycw03mORVMx8O6bS
	i+6L5mw766SIq9dM5LeEII3IIbd2UPaQbj/N9UQYgEOn2NybxTdpSBGSuzQA=
X-Gm-Gg: AYBFou11xP2PaQbd27O/MM8I4uyAcFrW/CpqivFJNmEIUZvnCXKLvICDHGOTjQhGrIB
	uc2Y4/cPOg6bgL57dhqcA6BhanRZ2IU6Ht9UMQGJlKWAna81qlG94OjJ7MQE96vqHSJWmKJh3y1
	PVkOwM4oXYiJgHW8S8lk4C1s1xjtMTYNBs4O7Y3y2aXEi5oPJQ9Ma/e9wIm9S8G6mcPSG+ar2U/
	orlV3Pms1HK30qO5BjitCJTxQtzm1Zr+TB19kKhhf+fNETwYPJTDDY6ZUByZcZh9DbfSLRDalw6
	t/kr8CS2HsDTHw0qh3irOgiZNNC0EO3uKfC2y+8aCXnOCF+XddHP2+Klxr3WE8ZHF+be9iVOGwk
	GJOLmZEM00UGKLcdSyJ8CQQ==
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr2960057985a.1.1788952821038;
        Wed, 09 Sep 2026 04:20:21 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:939:7e96:d296 with SMTP id af79cd13be357-93980964b18mr2960049485a.1.1788952820503;
        Wed, 09 Sep 2026 04:20:20 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036469sm760422566b.1.2026.09.09.04.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:20:19 -0700 (PDT)
Message-ID: <d56e598d-e598-4b9a-a6b4-1d1965aca656@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:20:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
To: Andrew Lunn <andrew@lunn.ch>,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
 <169b2cd5-d0d8-4682-8756-bacf545a95a0@lunn.ch>
 <aqAQ+BxwJstTlnU3@oss.qualcomm.com>
 <6e5624f5-410e-4413-82de-84cf864fd654@lunn.ch>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6e5624f5-410e-4413-82de-84cf864fd654@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyNiBTYWx0ZWRfX3pu5xMjSeCAn
 8YSdU1938jvwNcJNWPZKIjmh719W3EPiJ8TnSjSKpSYrLeKwVMKbIzuTZyVO5KTtvYICkRVRnwG
 JWAaKI+QcrbdhRjLl3MHYRWM3s+ix28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyNiBTYWx0ZWRfXxXK2QdFZHeZ5
 40MS7fZYb7uY30eOqZgOKYASCtqgv76RirEtcqiSMb//Tz10hrvQTlAgIQetJrzbmpwCiXp34a3
 KitSOLUkMmKP5hfjPJZwJUC1RS62Ej90Hg2rP++bXA6glmR+/ke6VC3N1H0JZJ8ZiR8ykQjHYmt
 BdnV87yBwrcSdub8fMLjDbM4oR5PCUecqikWotrsqzNjDlh389Qct3tK7hPukGYC+wm8LM5WwNn
 GXjq4MKKUwZQELmht9u/c3L3PeEp06CB41Ux9zB7bDX2qCadU7KvosLGAwO544iaFq8rKOioz2N
 gFNfqZkagee9tBgmNnGEHKZOftci/ij+NLkeGpamBTKJ3bjjyKjNgQXrYZNudrrZ9NS7O4C3Wdk
 43OeZeztMphm0HegJF9Xhnqe5N9drFBFlRXfUMA2PtsGAkiZOHjlmZ/FMUO2HflYeTOtZj1Xf+d
 xp/oscgsXHsYHgs+zaw==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa140f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=aGMi1ODkbYrmhBfOWAQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 7tjeEBtPbLDxVl2NL-ywDb6ogdIAr70H
X-Proofpoint-ORIG-GUID: 7tjeEBtPbLDxVl2NL-ywDb6ogdIAr70H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090126

On 9/8/26 3:57 PM, Andrew Lunn wrote:
>> You're right that it reads like a standalone fix, and that's on me for
>> the commit message. There's no functional impact on current users: the
>> reserved GPIO (138) is unused today, so applying this on a released
>> kernel produces no error and there's nothing to backport to stable.
>>
>> I'll reword the commit message so it reads as a prerequisite for
>> enabling Ethernet rather than implying a current break.
> 
> And drop the Fixes: tag. It is that which draws the eye and makes the
> Reviewer ask the question.

I noticed this subthread only after leaving my tag, it's still fine
to keep

Konrad
