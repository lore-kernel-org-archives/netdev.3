Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D09328B4B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168506; cv=none; b=fzazZEhpJ4LiVUGRsqRhZihaFnw6Q2P1DgR5rAK8ZjmF65Ef7UJ52mZBiFKzytRqPRDUjkUs8FB3XW6aYLkE6EZ/aQw9uRtdSi6nvfjAm5OgstAUSI4Au3c/Y5Peq4xm7YWn2X//wUwcMvAWZGnuYQv6wIzWFzmkyJ32q3XZYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168506; c=relaxed/simple;
	bh=QjHIjjeoTPKm4tEtKF5NR4KQhMmUScvXbRonqJcx9PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTUhEpkKVRpKGu7gA7LQoO/ESDaaTwc8R6nZn1kB1wADBhNZAFSt1Sbo5sus28J3VYMMfzoeSBNUXz7y9rNY9c63Xc8mHwwCAl1W3laIbvSFZPylzcqf0Jq0cTpzmrGh75nRcq3ghKq1rlRmwo1Wh0VL7KZnhYXldPORNzXk4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjbmBUGs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rf8Az4oF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjbmBUGs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rf8Az4oF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbVr91831826
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/8/bogxolhpJekeg2Bw4vuv3w4EHwlCdyg+CTOZ6DpA=; b=hjbmBUGsZ0EUvL7/
	e5u0Q1621SR8kknoWNstiLgk5CLdjjyVaY4E/1dzERdpZ6Zm/6qmOISsF59P74gw
	z44LhV9UeR7rNbJnCVdkRR6xiy39Ow2UbvZM/Y91jNJF/gRjJesk5yDE0Y8sv4Vw
	cjZ38YpaiK1/zz5dwPcnRKtm3HKAWTCwb38islo7ZsTDdI4p1EFRGkQImSRTIEah
	AfsCr82pvoXhj+fINera9BZuRjQzc7z/QWK62mjsZl5VZDSXfb3iyOK43zF1YrRc
	+9ucELOMVUgK3DLzwgA8V0Q8G3uVoJPjbGy76rokz0dSIj+6lauuC+fXr3kOwsnb
	zbrMHA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma40km-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398d3a12589so266048a91.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790168504; x=1790773304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8/bogxolhpJekeg2Bw4vuv3w4EHwlCdyg+CTOZ6DpA=;
        b=Rf8Az4oFXax0hPOK7LeI7urgEh9At29qmJEQ7Gbt1SNrBTYlPECnAGMmyjFjgebNPx
         hgLvo0uxEM+RIwua1j3mpVTv4zKJbLTSuMtewTgaH8DBqJsePN+O3M1HT1bQGO+9wNVp
         YI8bY/mSX9FGEhz3Fub5uDaD/itJ4gZkwym5zLfcRk2/FdKFM9aZ/yjW9nn8ZFlf5uwB
         CEHeoorrbRJEkPrGU1Zs//55o219KiozGYrGcX8Fp3QOwTT8nhra0N4vxvCQD23pqL9o
         k+teh9q5Vzepv2BMPl3/d88Dr64Eav+ItC1AgivCRMsTNLo70pPnDCv7KVs5hwOihYCv
         OH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168504; x=1790773304;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8/bogxolhpJekeg2Bw4vuv3w4EHwlCdyg+CTOZ6DpA=;
        b=H+IlYjdT5uYr2M10l5zgfQGwonTgYTizKLcLTUWh0WjyI1lxuIP7Z3S6F/jIvj70ST
         V+uVeUeF/bgZlKPLFbd0fwrAYkshllmF+njzXR/vdurWZktmozWZb2o5Rn/ImmjoYR2m
         rV4AqZnh4DC0W8+ZV3F0/yjTUMQ/spRGXCSc3FVU4i0ip3KHp8Et1YprIy91aVawYs9l
         pCxDdx38akLr6wOLRZU3POapaRfoDL5njgWS/hWSWx5GD21Oydz+XUMUn/pC3zS8BJIG
         cn/izUF8gKksKNJoAUqNyGTqjIIPgkRafnjtFJyxClRrHWmcbGxJ88920K/JUu9056xb
         8e5w==
X-Forwarded-Encrypted: i=1; AKwUvBxBXQP5J+xv02cYZmEYIGpNcwO9YVnmawNpWGYuNf0p1+QLvoKRvpJZ8+4PiAr2TyHIbptJmaA=@vger.kernel.org
X-Gm-Message-State: AFuF++mKrfP5sZ21RR5EkLqwyehNDLGR3+FSvpFXUVMb7K1Tk/IAJBtE
	B5bu+PX6Q00oKVrTK2gEr8jtyLw6BRED8Urmuxgfih/JgOMe/XSGd5+TdwzCZhURYjpu+XgCkHG
	YL02/24dW6/81dsVhOxV9crX9xbClsyLghLsukgtnc0IIxBQbt2dumB3yk34=
X-Gm-Gg: AYBFou0n+f+g2kmdpBOTWOo30qrKwtPBdbIl8P1BFg7ODxF98J3zo1CVAc2CGpy9a4m
	v8jT0UkgSO2Bc/JrfrjZUHlVR+4krxbDu1kUyDiEQ/qgKFN5PinUM7NO8oTL4zzddAyn+uCAjTw
	QJWmT0YlfyZe8dkq7vaDz+eyuJ1kslySKpkIn9E/2Liqm1kM0CPhzs5XxLAhs8m/xOdD010ubHB
	wnHIZIqqgA3n7b0+fI5p73JVw2R2i66Al2REGohwlxtzNjjjC7Od/QOqgfoToXgacMs0fmBHvuL
	aV6gbZHk0RalQcxEsFrFUsAKc+oZbPI4ShJqXiLKelbMsVIn4xgcdXAtrAbYUYB47Dwa3ct4kEg
	UGjsrIv9sMC0zgwfj1HyNig==
X-Received: by 2002:a17:90b:448e:b0:3a0:60c0:7f8f with SMTP id 98e67ed59e1d1-3a07e2f68c2mr3690113a91.0.1790168503729;
        Wed, 23 Sep 2026 06:01:43 -0700 (PDT)
X-Received: by 2002:a17:90b:448e:b0:3a0:60c0:7f8f with SMTP id 98e67ed59e1d1-3a07e2f68c2mr3690028a91.0.1790168502900;
        Wed, 23 Sep 2026 06:01:42 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab37eab45sm1650695a12.2.2026.09.23.06.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 06:01:41 -0700 (PDT)
Message-ID: <dde35cf7-10c8-4e92-b956-bc920c9cc5dd@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:01:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 4/5] arm64: dts: qcom: shikra-cqs-evk: enable
 the first Ethernet port
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
 <20260908-shikra_ethernet_dts-v1-4-69c0c5c7c124@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet_dts-v1-4-69c0c5c7c124@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0mGQM70w25Z_TwuyS3zt-TZ9TLezzM47
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX0iZ+AqMJnqjo
 XkSMOYmgwf5c2wsupJtpjqskKyYg1hFoBxp1tlRUHW56HPzfhhwboKjK2YZJOdzVtybjbTB+xH+
 Cm4G3fLy9UzOiGOWGrLeZASYUtHaSro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfXwDxQdpTbHtEs
 a/mkBufBUK3g2miN9R+XvyhAiS3laDjYwBWOIb9jNvf/NpUCuqJAg+MkuWQVMdK/OBWLiDnCwQu
 cJrpv9xUP1XUiywI1FjB/5GyhlVZYP4xGVhb4qqyQW4QyD1V2d/2P2WDi2AA3N2Xv5Mw5uEnhcQ
 ytM1ml9gVDJ9GYDTHFXpEUNMXvZpymvL/OcfEzhQeF4cHkUyRO+6BfOEwrMR/Qhr2TQ75mKVsKP
 d4sfCkcVZPRPoL4Ow5YtVOKpRmFRXnM401+36m3yTfj7X9Z6dKMEdTtPL3HuYwKriu5/FTGyHV8
 3YWqu3kaHBmAQchmyVY/LK1pTFURFwhuVSe5q/+ZL5dFUv5ajtdhnbGvVwU7DqBAPcqekkzMNmO
 3DTMNDqQNp4THEwq/D77dcZZA4rbdsmWZs7sEgXLiWjeIx8zRrXlvhS0lMs7++GiMQb/Ij1F8CA
 6Mts+vfN4eLTrwL4GJw==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab3cdb8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=YB9oFmEO9Py7Eu-ErZAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 0mGQM70w25Z_TwuyS3zt-TZ9TLezzM47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230051

On 9/8/26 8:23 AM, Mohd Ayaan Anwar wrote:
> Enable ethernet0 for the Shikra CQS EVK board with its DP83867 RGMII
> PHY. The PHY is powered on using a GPIO-controlled 2.5V regulator.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---

[...]

> +&tlmm {
> +	rgmii_phy_pwr_default: rgmii-phy-pwr-default-state {
> +		pins = "gpio149";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;

same here

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
