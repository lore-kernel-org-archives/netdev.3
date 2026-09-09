Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BC53D0DE
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952784; cv=none; b=JKELJ1aIcRP3uieFkQT77aARP9gNFKn8EFNhDGMtbPSQKpyb6FVV3k+bQmcoiuMBf2b9cSgBrY7SGIWsiuFlZztNT14UdrZaF3VJjfhFfAmMEdYJGdRmYCBfPS/LitLhR2ShMJwKXqkM+KlxFPNDm/yyxL9bCRKghl71nO/SVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952784; c=relaxed/simple;
	bh=eETRbzMJn8kFrHdjkPv75pWI84ym/O2XGiAGVOJ3dmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1XbL3o4bPox0piReSE4pMeifWhAAnGRFH4jk26jduhDNaQBFEAoSV5wyzW8dMHNuREnVnekXGy04ATTptoEg1XSRAz+vJ0jxLFKN6egIJ3gvjEMF0Yfo00ozkMwJljnfLoJu6aC9YrsO5laf/1w8R0SmiBq7DWMF/1Svf0R5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCtARrMh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZGfJc4xc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCtARrMh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZGfJc4xc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689Appj61726120
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dwNPyXHU4JEuyCFbr1xwWa+OLlqFRb6m/XYayok10vU=; b=gCtARrMhA9M3dbNB
	vhDMIGhuwVkijNSSrJUZtxtvz9cUrHiyRlvO+Pett2QQuwSv90RltunwSYAR2QhF
	bBhWkKcxK/7XF6p9Z4NTkGhRJuYe/KJnq7uRc6xESK9g8/Qvz7OD5EwgdwqJpWe4
	+Mmf7cywTg4mMMTs/fO2bJKeNhh+A9MBpu4o4V8rBzK2NXOgizPriljKWAHNP9Ao
	NoiUZ/dwYFPyBuyY6q0ge++NXWOUikLQ0vJI4zELg0sv9EKkw32TCd8dUvIwvDww
	grDsZs8/rh64C6kpoyU6YXpDVyEL9lSww6KeExHZvb9Ans/YLj6FOWkNz5TZD3w6
	TksE9Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj0cpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:19:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9310484c005so78990485a.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788952777; x=1789557577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwNPyXHU4JEuyCFbr1xwWa+OLlqFRb6m/XYayok10vU=;
        b=ZGfJc4xcRilZumF0D2Ktsqc/HJqvRFETryG9oA35bAKcTRrZFRjaGyUzD/59ZP3heN
         FPfjGY+HQ8MwdnhPq5hcsjMODNzxoDKzOgx9rtIyvvCnYw9dCabt+jlm7HNZG7VrjPZT
         GNQ1Ngb//nNySpBLRnsm2lrNaWFA+lNc0dp8FlidEm8bGoi/K0QH/l8EAy9I0XYO8aFM
         GrcjapoVadvqP/GT2LvVdISru//Oou0K4cmpIdJNZXNMUWpH36fyQHHiCpgZn6WE9QaO
         7dhy8y9VB1vPw9LnaCn/dam/BK4DrA30Gp0qgOxDdtNBfUkJ6ydNvuDkDIGvPZHN8GUo
         0rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952777; x=1789557577;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dwNPyXHU4JEuyCFbr1xwWa+OLlqFRb6m/XYayok10vU=;
        b=W+oU4wk405tFaIGtdJD2mU+sKtkWEMn25JNdug50L1aiDzl0iA9ckmYLTHVr/hRG23
         kBOfJBkDn0q/x6Mar295XKjDMCj/hdys7ZqASBakZ6m9rlssqi5N5wEILDCNq4/kOHBw
         UrGI2xfxWGzaJbef9BO1IF28eWKLAJnjRRpnmQYR9ZWtuhmub2bamwiMNf/eHzUbi4i8
         z67oMn74TwN049IcUFVATVefv9peT0mS+aT93iCcRPsiG4hh9dSOScmTa0BOR6keE2mk
         dXdAtQBW/2UrEhZLyMZmeoNt/Ydk56L2nC+2q+gFjWjIOTukGYx5bmjpNowXtoeKARY2
         C+vg==
X-Forwarded-Encrypted: i=1; AKwUvBw9EjP36QXr9ty8RMfqgQ+HXzrzrlpaZ9kjQNMTMw6JHMTnHzkUTn7aquMZ1OcUR6yZhhsiVrA=@vger.kernel.org
X-Gm-Message-State: AFuF++nEw5tLarLOtY++Ej1iOen3ZDLHiYLhOcoWC36kSLE2iiOM22x2
	srjCqY/vb0uwojbJrMJXb29PXhF9tOWfHU3fALJM/cp1NgRejCj2Z93d5Bc3QFyntijHEzJqGUh
	z2PWpeea/9/qJMdRthtwmArByluc6nJAa3z7KIDe04iGseXr1wUq9I1KVDcA=
X-Gm-Gg: AYBFou3saH5ViS2KQvnofZFmDmAJK2Jx2l0a8EAE1eevAfWaboW6PTwV0/1FsPVeqSc
	mxR4rWdVhiE6+6m9D6U3qXvGzjKpFJfJmqByU0NewwVCFVBpWoP75k14f/OQbonaQioCZ/tH2LL
	Z5BKlfy/4pqDbXuKxUBpdttpwqJYCblmWRatvqJbiC5SYEOnfbI1KiQAncdeYcKpO4JBt44/2TK
	qXdtUNkuomCvAdTJcda9JMuG7aT7sEGP0GpKhhmXWMkh/aOr9VX6PEI5vu2QtKRfqOtvMBLO66G
	J4cy1BebXnJ6E31EiXtYeBYAWybVvQeVn2wX3qTa5T+pGQkRpXR9FLIAJPYr2QqeQnjTWW37dLt
	tQeSWJXQxamjJ0SBjPuNd4A==
X-Received: by 2002:a05:620a:1723:b0:939:288a:8a30 with SMTP id af79cd13be357-93980cc6996mr3076521985a.6.1788952777434;
        Wed, 09 Sep 2026 04:19:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1723:b0:939:288a:8a30 with SMTP id af79cd13be357-93980cc6996mr3076515785a.6.1788952776923;
        Wed, 09 Sep 2026 04:19:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9857ce120sm1367440a12.4.2026.09.09.04.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:19:35 -0700 (PDT)
Message-ID: <5c4258be-27eb-465c-b6c4-a0826904e48c@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:19:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
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
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyNiBTYWx0ZWRfXyWC8rJbkUB0g
 FqZlMsveH0M62M2AR6s0aKyj+sRW/H9UfMz/BReJkpezXncIYKak39+QfP35bTpOGDCQBuYFPhx
 IDPTIXDnh+VLGJydjOdg5ch82eN+o6Y=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa140ca cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Fd7G5nQXjrtoiyqt_gIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: uM8e7UqXFkIN0bxuhh_q4pTd0T6agy9U
X-Proofpoint-GUID: uM8e7UqXFkIN0bxuhh_q4pTd0T6agy9U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyNiBTYWx0ZWRfX8qfheFkGL0k3
 hO10Y0V6VaVAgtwc2gnNO9R/0mWRC/3wvwfbgPx1wOusnuE92Lqm5mjopa0upkRvIxsuPIYKqhE
 XifQBl/73otWRcXSyoghXrHGGdfYBcYhEAZfQ2idED1XVBtYUCOEgSfGy4VevuMaQqKamMr0za5
 sx5dmfS3ElUV3n2xwnV6fMyQSbhHORHy1Mx8LiTOnz4dB5sAbj7NG4l57iWAxH4xvP9QVIFPe9n
 9Q4x72669P8n7uc8z0jJo6aHIknitt2n9GLUVBmiUUdfXjKd/uMFxuSPYnweOZlLrrtwNbsSjR8
 +RKmrN69Sj02ZdxdvkhcQ9gulgdU+pi7KP/4p00HS3QFb6n+z/qrQDQW0viwGyWcBVf3oyAK9Se
 g6f0wIZhNFTU7qkMs1U19IfJeWIj1ZsISOd+sZNTudWX1nAZYTtZ6qqJhEhAlfM/DrChdQcfaPO
 zASSmGj2iE2xWKc25cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090126

On 9/8/26 8:23 AM, Mohd Ayaan Anwar wrote:
> The GPIO mappings on the IQS variant differ from the CQ variants.
> GPIO138 is connected to the RGMII1_RX_CTL pin rather than the NFC ESE
> Secure IO pin; the latter is connected to GPIO49. This incorrect
> reservation causes the probe of the second Ethernet port to fail:
> 
>   shikra-tlmm 500000.pinctrl: error -EINVAL: pin-138 (5d20000.ethernet)
>   shikra-tlmm 500000.pinctrl: error -EINVAL: could not request pin 138
>   (GPIO_138) from group gpio138 on device 500000.pinctrl
>   qcom-ethqos 5d20000.ethernet: Error applying setting, reverse things back
> 
> Replace gpio138 with gpio49 in the reserved list.
> 
> Fixes: 779aead2dace ("arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm")
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
