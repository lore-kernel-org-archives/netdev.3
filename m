Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC5407CD1
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823089; cv=none; b=MDf4rvgaB+2hbEIO69Vc4gpu6KlXzA1Y2GtkFavZdyP8CKdRSUtBoYrkLZ4d/40PWvxsVWzClGsSIz5U8RU3hQ5n1TT8fEWZBWm1m1IY9RifsotbV4FTjsuyMziesDQ5xToxdcbvo9VhRuqInlDPnGjBBPOgnwrVscyVF8YuJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823089; c=relaxed/simple;
	bh=hjc+APBxG8BAnft1xBwXIOdKWJVGMl/z1UuFDPDGfwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L65hSQFLs/RqdIDnt8jyXMyI8yWOchak62e9za81PmBDdCpDj8NrvVNp5wZ1tiApTbtszIe/I93it1BffNoHHyHeAm/rGxUUVEfQpulAUQ3N67JP/52b+SM47j944YEH7Su/6+8T0E8qFG5djy98G8HUBhAom9oO/UWb93ZHiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FsbzbzUe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BxjzHvIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsbzbzUe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BxjzHvIA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4ki1508653
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=; b=FsbzbzUeTWSQxnA9
	kJPqCIMJUFmj4GvpwwryZIJKRcy5rbWo34809alM0V531WTuqJpuNEpnV2QoFW8p
	0cF8pj2AeiEaEq0bMOuvc6VHejiI/+nZ+nE5Xj/bi/gQvlxtt6iyZ+FdHPQDKaUc
	RfvDKEiDFS12tBKAjqsnhorkqSGubivxTg+9+TBr7Wae3oGxa/xngntKkAo78ND9
	P0nyRJYj9WlaMliHyYpbcOefCh8tgTvvLL30PONEzLfFPSXWKzI+9r67TDc3MnTD
	i6SRoiuQ71TIJGrJMbITeyjrvRBh6cj2hRCq6NOq/XEx9ENPbhxUJm8QEF/Tx6EV
	nI/wFw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j3hh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:38:07 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bda959ebcaso100831e0c.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823086; x=1783427886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
        b=BxjzHvIA77kVXv6/2ME97svUPezBbzQbY/oC2eLBp5HoFCzbHz3sMt4IEbPrWRyF2F
         m/FUPMlWXglNR30YU1qPio39B+/YFUgIpgSTpo9pSiiFQPpZruVQR4JkMSa9Wl+Fw8Xc
         UFa5QFSLYw3xiM2huNG/sleldhI+D1BST3n4SrQM0dwqoSvMiDP39mrMmL9G0fTmGpl+
         oUM2nE9cmZhembVomQLAIXC8aFipRJFKlhen2KAQp0FpQCqPIdQzJS4Zea9AVDtoHwWc
         ovEPYfBbF+KF95flFunbp6a/voaRTCEYE875uM2ztQB81LKyyu4LOAi2L+lq26XQtaEt
         Qu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823086; x=1783427886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OYUFv598H0zTgYaTxiad7MP70D3IXkLu00sHk72TbM=;
        b=pH0PNzSmen+bGMEr7BABy5qc2LDl+hFmFBljlL69ZUt40T0e5Q8KZXEEcAl6anIdpd
         oFYMqB4CW+uRep10lop9o58hatbi1VFAFOS3vkynkwaMY3cYr2Nwd409y6oTNTHzqFDa
         lz9tN5GauWvh0CNqcpaQzxGn582ApsnewpV/ZmyxKgQ+ICXh12qNyxAMwoHmrIoFxJN2
         2YAALDyLamIFX2o4BT+23fPNAEPwyRaJ8MqgCmY+1u5qbx8eJiStMoLy2/xVFFGZhO5Q
         c0DA5reIvzSrZDqwmKQ9aR7po/e7SMoXs2U48bAPQ2mPWSxaw/zkmkVGgvA3RWJK5sfP
         Gq7g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8V1c6GOgk3syIc1GQxXM5ZxGtGBTTSJnS6RCOKpE7Fuot1jaQnfboBby40l18jMoLLKESh5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczbP8XDX4qsbxeLlGLJ9gBwFfpvBnKQLk8tj3PR1L4ahI3Iy6
	xGlBCyBlpBTG1GMlHjJyHmblZiK/zgz6LLVc3DXWMnzKhMjjqFV/YYcv+pC5qduCZSd5owXb8yM
	3EWWu0qPMXz6wgU+2tcBZYTkgWkjofL48zmc5vdTMWwOOCXsZBfgm+cg/8mU=
X-Gm-Gg: AfdE7ckx9H6FOjZ4AJG9KvV3DuIrJO0fGrEz6nTtxyTj9REKcCxNcMMkMaSeQJi15u5
	doahFAUq7AS1k2X0hUD2CC+dsuBF+KAjl/deM6XFwMWl+p2/m25BajpwlhifgfBF50atG7UQGBN
	KH+N7H8yqPbNMLtcJLzY7uFxNu+MRdmv1Ft1lTR5mfusIw1gZtfqoH6gQFxFIuhyjEvERR52RNI
	eTlWPDSI6cjCWqy3NxZAViyT5aKomATYoO1uBGWS+YnmDvTMdd61f7N7s+xsoqVMO2laR1uzqe/
	0sFIynkrF5cvXT5XcNIBYGjzAeoP62upe8Yf6Pk+8whH8WQWaUqB6sXzM4EPPsJapYjUdElefSo
	wjYL2jyreZkSVECcKfOZ9Yx+HTcF1JI2GJgY=
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id ada2fe7eead31-73a3912c265mr460487137.7.1782823086351;
        Tue, 30 Jun 2026 05:38:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5804:b0:739:64ad:bf4e with SMTP id ada2fe7eead31-73a3912c265mr460459137.7.1782823085760;
        Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c95003bsm1081611a12.21.2026.06.30.05.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:38:05 -0700 (PDT)
Message-ID: <64e425ab-dddc-4221-81d3-3283e2961bea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:37:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/14] remoteproc: qcom: Select QCOM_PAS generic
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-8-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6TjtYHcw7D7OOTD4y2H7BNDlMR4tsXYb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX4WkO/5grI4Ue
 ZPxs6OZsC2zQ1V1qVylNU70hVr8Yn2A5nq+5aQnW7/5UADTLDFpf/bmtBdnbGBlxWDDxeTIlEee
 MoV1gQ58y+vMQEZdvCiqoct4a02G9JHZ96deB0ZA+EPkhQxk4QPsDzJNMOfWsAN2LWUoRjK3QpC
 JuYzt/GRP7k1aX3JW5Al0pszpz6HTGKYJbEKaHY67nUvI/1pDOM9ZV+s7E3KGvwuWAItaeiLmB6
 t2SitBNvMOiodCbbQQyGPVd03FeKqx8XhgTcGCk8LCl5fhRSrz36v13n65Vu5bHORuccnPmX2C+
 L1jRIzyu8cWQBEB2PWEy7hx/OHEqq9A60t+4rQLUNiQViXeTPfBV2DAVXnD6yc+je0RMWm8ihdF
 b6DYtjxjKmUemRb2aHv3oIw+U7PJJM+TG7DrNb+ccYVJgPdIbekHEeGBRHetor0csMprAByCGd6
 kkJh4bK9ywPsSqHxuxw==
X-Proofpoint-GUID: 6TjtYHcw7D7OOTD4y2H7BNDlMR4tsXYb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX9siICtagTHhp
 tdfNo/ObRxT/Gua2wcZmr/dnyHE2hQr0rQ+6BQ2aV0/lk4FHHrvLT0etGH7ktMkrXY2ip5sQNRk
 kU2xjZBIfIqvBYGX0jC9BMrCOQ8gCNI=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a43b8af cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9LJ1SYc1tAtFajrMtPYA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Select PAS generic service driver to enable support for multiple PAS
> backends like OP-TEE in addition to SCM.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c521c744e7db..65befdbfa5f7 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -210,6 +210,7 @@ config QCOM_Q6V5_MSS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

This is a NOP, SCM already requires QCOM_PAS

>  	help
>  	  Say y here to support the Qualcomm self-authenticating modem
>  	  subsystem based on Hexagon V5. The TrustZone based system is
> @@ -230,6 +231,7 @@ config QCOM_Q6V5_PAS
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> +	select QCOM_PAS

Likewise

>  	help
>  	  Say y here to support the TrustZone based Peripheral Image Loader for
>  	  the Qualcomm remote processors. This is commonly used to control
> @@ -282,7 +284,7 @@ config QCOM_WCNSS_PIL
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
>  	select QCOM_RPROC_COMMON
> -	select QCOM_SCM
> +	select QCOM_PAS

This is OK

_however_

It leads to a situation where no back-ends can be enabled

Konrad
