Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CA048AE00
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635044; cv=none; b=XieMDvs5Z5s0FSu0VoSIAiwushjgc856SUW8Y2fLp7JKF74OS92VJWNF+imyIz8SrapWOlDVZe7GZbHSOSkov65zN/QqiC4dvKg+fpb3E0eDcU8r9ubivFP/VQ32l4/utN53Lq/wKLAXX/JyBc2F2ScG97hugNVni7/7qN3BobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635044; c=relaxed/simple;
	bh=1jija8OEh1ywAonQwvSdwU16zTNI3SofStphjA8zOO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+7mj49+WJ044TemLgFQZjei03F5ZcvguGBN/TwrOxr26yVmfilnSt+6sbIYHpnkfGn8wYbVO4MvUkyMRcRi9y9w+x0D0aBtcmnxb5O4QwFPmNbO3RRVMu63Ic5UjLuqFk57oeBJD+0NQTd2neKkIrxSFQnkkrdyNWO51zYtQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxEWXsvm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pa18d3kh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxEWXsvm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pa18d3kh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LARNSV1499967
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5qjUmcggw2BDTIheMS9xNdAXdB5QLoEoMkHyDe70LSo=; b=AxEWXsvmLnem4C1t
	lwyJ1oFsdXoZs+pr9V/XnenoxPka49AiWHKB60eTSwguPTKPDgWCs48vLJJaYlte
	NUwKAeh8LTvZ4LsgfPutKBrV8gO6Pz7FOpWio+113sV8ifJpE6ByVc9Ns+qgXk2X
	l0a3nUkpevNjtHaNfyPmExkoXroVoEiJH+OzePReWoWmfm+ePUU0JzU/TTM8MDzi
	laIclFSU4IeCBPtQ19Qq4CBlevRlQKALv9vlJxioNs9oFNfN8ntucBQVW1u9jVaX
	rb7oQj05ajoTan9+B2M13vdtLiVHfNAN34ffeGvosnDf+aS4we6iuqVzuG6Upmut
	KChK6w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvt51e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:57:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930edae07a7so6889185a.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784635041; x=1785239841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qjUmcggw2BDTIheMS9xNdAXdB5QLoEoMkHyDe70LSo=;
        b=Pa18d3khmcm43ydtGEGAC50dPYECvHnfiCysSBJwOYG7dAfhjaBNG/34+q+F5QXlpK
         rUedYKxhfb2l+KclVtvAdK6hHkFcstdGpFFnoDuoca7wcT+HPzIq4f6qY92XwOt37myZ
         H/bZJaWimiNNKaGh7auEwqD2PqK/m0cZP7pzTkd35mCSsiBQ7lR1GP2gzasl4eYLRUoS
         iN0qD5lk906MCWs5ismXUZgVPxDI9iIYINTi5iV0rYqwf74GGqxfmJtHJ3sTUePg/xGO
         NrE/M0HFyP6nRQfdk5eXtjAkUWE0bbNnWVwhOaHfZWeINXJbm2n7brkZXvw39HEirWhR
         wMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784635041; x=1785239841;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5qjUmcggw2BDTIheMS9xNdAXdB5QLoEoMkHyDe70LSo=;
        b=WjVIfEn5tbhNOsj3TUdaQs2seNhGlZ1vPd51vd3ir9xH9JTRDOUdfzYVTXDazWke24
         Vqv/LNPKux3l2MAnxyIrKFB35mfGtFqo1hRJTLSG9ecr/MCfZxVXaTSMI91LNrL4i5wv
         6dO/BcZT5+UVrDnQAO1F8Y5AoiLg4GzEcM9OZPSwSDAcfANTFjEWxAOTI97W1es4rRH8
         jeyPVQ9NTcEMrp+uq1blsyFjkI8r3iDv3efJdJZoEiRcxlzyL0QbvDgBgOMTTo7PPBmF
         f92ApfaxFPW74ydUuB+0kZrmQ4msPA0ETjBo1XTQKO1W79ncAyw9iirANroTSukRIJRi
         313g==
X-Forwarded-Encrypted: i=1; AHgh+RrBvcqvs3BBqzhRVbwKr4DjPUKQnx2z5BTO3fEWFzs+LdSiLqlrnrYpNd2pG+zqBsgG0Y6AbCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2SSZifwj9yHHdhbjdQ8Jzu+WPerf3+TxcRlPqZo2eVy4TTt1Q
	hcHdvLfedTyLorSwOo1CsAABXaUHVRloq5jNEqNLjAeGRmKy2/gh7sX/Sc5skru5GfooG5JBMvt
	DawMuvjVCcikuFQxYBUTXvvX1s01kxjUbRpUswI/MqgUV5L/fioV/JbyT2LY=
X-Gm-Gg: AfdE7cklTCNJXnmml3OQ5gu1Wu8NEA1vjyb10aOztBSfLYNUZx3LIOV27fU9FUlvaoU
	zwQRtPmQTfE1dvPUXt+IwG8v+5HNPE8lQygIr3SeJhj5wc9Z5D4+4t63NboWfudgFRmFGyBZyBZ
	t9Z/zLKVK0dNxL3XcC07gHYEtNCOv+vVizTExxTK6BCb72P/8qaJcN/WWwxFheBL++BH8bhq/RD
	+/tMdW7/4ZYNs1KpdKwJ+l5OILVnGtpEF9ba8CHGYDXnH9AwKXK652JeuemicXn8i5t9TjMTsCE
	YqZQBaVsk+MYZpIky6N6E+w9lzWoFr5HnCBFJqejB5VdpYlRM+F1p/918uYB8zf6FL/SpXC8vLW
	B28GdaAXOWJ4plmail0HWBJl2
X-Received: by 2002:a05:620a:371c:b0:92e:6485:f640 with SMTP id af79cd13be357-930e7051f8emr232652885a.4.1784635040931;
        Tue, 21 Jul 2026 04:57:20 -0700 (PDT)
X-Received: by 2002:a05:620a:371c:b0:92e:6485:f640 with SMTP id af79cd13be357-930e7051f8emr232650685a.4.1784635040424;
        Tue, 21 Jul 2026 04:57:20 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fff537csm5702136a12.25.2026.07.21.04.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:57:19 -0700 (PDT)
Message-ID: <4fc9743d-3d9e-4130-9ffb-b64318a8373a@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 13:57:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-1-3f29da7cca76@oss.qualcomm.com>
 <alXhHH0mGvFeUMd7@linaro.org>
 <3a32a44d-4044-4270-beec-565171ad4bff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3a32a44d-4044-4270-beec-565171ad4bff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: esJJjpQmT69KHqoHvqMf4P2QavaQOebm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEyNiBTYWx0ZWRfX5vZaivjMGxlN
 X4wiWcbQ6uu2/3dl8dCdRK6K0/n71WvfQ52BnUvWU/wT3OdKbGIsj878MNMd1sDFYPptbwW0NN+
 RMHbGj2pTI1ItdWFPTwC/ckkN2PJXJk=
X-Proofpoint-GUID: esJJjpQmT69KHqoHvqMf4P2QavaQOebm
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f5ea1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TTPXGskHRsZgtGffa1EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEyNiBTYWx0ZWRfX9Xvi5XhBndXv
 6z4150CjQce0ns4vzTj1DoNH5YUEtz/hkxDxqYSy2nNDLRO+uy+TfheeAkhh9/71cxSVPZ4xadc
 fve5faiqeRByAKVwrEFnmNz6A5pKa9xzBKEzZwVW2paEgOGROZfJg0Ex6uOr6/QAtUouzndp8qN
 UMN06LOvpK9hinpzGAQqf+/A6zZnQbDozKA+lSh0sUyGP62o55JRokf4HdHAMhcCK0IuMqo5GMu
 z2LZao9oWrUG1Cyk8uXpGo3Z9Vlcoa7oRFncc9LGnnD4uP72+13rcJ2GorhtOtDYtSmnSFYX3zw
 LzTnwUYCuSu7hXzDqMxKM+zdTpINswMl2ghH7HbOdYkZ/A6kwVSfCwO/yQHFmRLrvP99dBDAqYj
 vupBoPcna1PswD0r5H9jq2Qt84rE78nC3K/VXO7KUjnNSL4FGycsyX4S7169YssAfdJyg1LMCWn
 lxZB0srLYh0I2JApb2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210126

On 7/14/26 4:03 PM, Vishnu Santhosh wrote:
> 
> On 14-07-2026 12:41 pm, Stephan Gerhold wrote:
>> On Tue, Jul 14, 2026 at 11:02:31AM +0530, Vishnu Santhosh wrote:
>>> On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
>>> the XPU enforces per-region access control, each individually
>>> DMA-mapped RX buffer consumes an XPU resource group. With only ~16
>>> groups available, the per-buffer mappings exhaust the table and inbound
>>> transfers fault.
>>>
>>> Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
>>> paired with the generic qcom,bam-dmux fallback, so the driver can match
>>> on it via its of_device_id table.
>>>
>>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> IMHO (the DT maintainers might disagree) this is not a different
>> BAM DMUX hardware block on Shikra, just a different firmware
>> configuration. I'm sure the existing SoCs also have those XPU blocks,
>> they just don't make use of it.
>>
>> Personally, I would rather describe this with an optional "qcom,vmid"
>> property similar to your bam-dma patch, allowed for all SoCs.
>>
>> Thanks,
>> Stephan
> 
> Thanks Stephan. Adding Konrad (Cc), since this compatible-string /
> match-data approach was his suggestion on an earlier revision of this
> series send for internal review, specifically because BAM-DMUX is a
> singleton per SoC.
> 
> Konrad, given Stephan's point, would you still prefer the
> compatible-string / match-data approach, or does the optional
> qcom,vmid property (matching the bam-dma series) make more sense here?
> 
> Happy to go either way once you've both aligned.

This all depends on whether the DT maintainers grant you the right to
introduce a new property and in this case I very much doubt that

Konrad
