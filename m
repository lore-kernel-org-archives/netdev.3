Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445623BCF7
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784868403; cv=none; b=J+jWrylFmbdKuMAx293wbxdM6Pn/qkLY2z4Z3kanrMuSszDIJ4KctGoaC5KpOqpwUoVDPla2ZQzMKxwrgIu+09a2H0dRInXQW6APQ9dSojjHkm4ZXOyC9OPeQxWgbyYYSCf3bb4/GGj2G3U7uiwpXmzhW4NrzeAtm8wL4i3e2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784868403; c=relaxed/simple;
	bh=rVkZOr71z6ecc/lXHb+MqO277rJQGUcX9YfkfACG+Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUVvzwB7CHufMuJSzs2yzBXytGWsLW3Yp5yqiRJ66KB1LkDbysI2jRpV/UmJmkOoHhirIn3FE0NCCmdimbhi0E0CGdp9cfI9gZxhYWnplz5dsaOJdOQJ2ZfvqBEkqrYYGrGVl244ikeOqICPuLWdnU2JoDjePk0eWUa1cj6Hxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxMolseq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L2hXNzhi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxMolseq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L2hXNzhi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O42WMX1893259
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 04:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rVkZOr71z6ecc/lXHb+MqO277rJQGUcX9YfkfACG+Qo=; b=DxMolseqtUPvVIbi
	KY5fI/kXhLQj682NjL/Lz4gI2YuiXYHmk6BL8j2dB2sQtbdSW7StjzRZMziYFV8c
	I49ECSDAVVydKKV/QlHRknQ+FkuzVKY6ExMIv7HLuGl+ax9tVb0bOsBBCjCQFuCF
	O47ukkrmB6nx1vDoOfxNP+OxdRvQ35HNBZEUrIxJqf/tjZ0vYGhD2cimTqByEir0
	bFXvN6Pzs3flLwqsUO3sRDtSwm5RVRzCPdCyeZlFlbsb8Y1XXfR0GfGd//AiIaiz
	01crQ5OVNldZIZLXeK8aj4RJvBZ+tdSZKPA55SJoTLqcCflFR7Y9d6NGDRUA9Eku
	d1LfrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p503we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 04:46:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae455cf6dso650065ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784868399; x=1785473199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVkZOr71z6ecc/lXHb+MqO277rJQGUcX9YfkfACG+Qo=;
        b=L2hXNzhi3p8mQzrumToGlPqhuCYlcCAlKy4qjFyEdnDfwwelguK5hkQIjpdFrcmS6c
         A5sfx+oc6ZGqrp9pRyCKkX6d4mPOFdJfP2LH/QtFiYrHynR6ut1sh3XP81uF9BG5mabe
         jhshM7Tg2DS6R3g+7xeTaoaTGErTPTYGAZG72ER3Gszwcvb+WcRGuzlhrJ/MvFq4cmB6
         +ElrqCFJjccs7NG48foZrI3uqOotoFjIEsLb/5CduFQHSACu/7tlAF36wyV5Dp/G2/0N
         59aAQV8fr8g3L//qsfT/64ejALFrVCPedPrGgc3OQXtU/zeL5tuTGfPP3c/tb1om612C
         Qj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784868399; x=1785473199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVkZOr71z6ecc/lXHb+MqO277rJQGUcX9YfkfACG+Qo=;
        b=edrANsvaz/nzqOuqtLAhgqA3lJFWl4CrR2/5+JDw+1+gmDV7qMOIiYUiBCtqdcXlmW
         +VDNFxX2fVBO7JiBSQrQeSoiuovQL46+aUwJYWNC3ZqTR1+8TEaWiq+0nA8YUAed/nxn
         NfExq6KbbpNqQbyyQlIad31oeQuFFkV34Y5wChGd3xv1qVRJjx3Ysh3HHbYCj2qFJ3eX
         9gH6rPAXGJieH0brVHCYOPNs801/6Iuquw4be7LPo4XYVVl3v3BsCzIdGa/oNcgG53Fq
         bwu8Wzr8neuYFe1Q++ijd4HTA8H80ISO/zZeesW6csVH24wLsXk4GCEVkpHVZBgnAI1m
         LMdA==
X-Forwarded-Encrypted: i=1; AHgh+RpJ4I9jjfukcjIV9EWKb/U9HcRBNDen10H0Ycf6NyTg2kq1j5i5snPsLgnMSCCutjBMqyR07xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxCNzk4xASMBePUvcolZzWUb2XIxfVQHof/Nu6Fj2SK7s/CED
	pRkoq4Wf7hemXiVnygrTv6d5B/0g3pBMjhFHnUJKcq0WCEeykb7jBBSLIkFf9KB0yYixgJv+DcC
	vqmLKwumy9O9u8AdGI/UCFadluhvyLOwCOANua1wB0oK7sHRcpqan7Xi2gGs=
X-Gm-Gg: AR+sD10/OCyZtpxA8p5GHhU2yPieWvMlPFWXNkYGEzmWLPq2uHRkFPuWeoUjdeCoN6j
	D0GdQNKirAm38r87O3QqX+6o3aDDucC8pNXZajvArNx8jHAQi7O7d6PKHJbIaYFGP9mmZR+7Mtg
	OU9nh+fWMRSMN6jvq0qJEPhO1nnJWIlMD2mwchtV5Hce67vuFf0k35hAnzQyoPj6LnePz9V1B9s
	qhEFORF8wtTpKDU5VKnMEG/DMGOOSfL+DF9yfITOkC9pktDmfSPCaQ3LY05G1z/hNxshxwiUyYI
	TYidaGnbrgz4KW0z6FT5Yfeb/Gn1oXowahTrY+41oy0DJJQyGcR4hIwRxVI0hZZCRlS7LjN9H6p
	z+KWv26RLTesrpOZva4La+HDVKbMpLdqu/A==
X-Received: by 2002:a05:6300:2204:b0:3bf:a38b:e8ca with SMTP id adf61e73a8af0-3c44b211035mr6789573637.59.1784868399166;
        Thu, 23 Jul 2026 21:46:39 -0700 (PDT)
X-Received: by 2002:a05:6300:2204:b0:3bf:a38b:e8ca with SMTP id adf61e73a8af0-3c44b211035mr6789544637.59.1784868398747;
        Thu, 23 Jul 2026 21:46:38 -0700 (PDT)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09ac0sm22951882eec.16.2026.07.23.21.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 21:46:38 -0700 (PDT)
Message-ID: <c8417ff3-db92-446a-acf8-8c73c83b85de@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:16:31 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
To: Stephan Gerhold <stephan.gerhold@linaro.org>
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
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
 <alXm0rp3NK62G3-3@linaro.org>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <alXm0rp3NK62G3-3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a62ee30 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2eDN7aXksB4whfXZn5AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 0yl7NCpXzmYQICtZoNBt6g8M_gEyG65o
X-Proofpoint-ORIG-GUID: 0yl7NCpXzmYQICtZoNBt6g8M_gEyG65o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfXw5HQMQMTKBTR
 lLHEUOglGMss4u1Sz7k/Lm6aX/8l13st3S4jGp1ab6/5lw3QrI9Zz0DdCbowz8WmUNk1ipD5FOd
 oV8dZ9yG9nu9IYENhrKYTBhR2ZmOE9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfXxl9ebVQmPUg3
 ywd5tdwjSrMs/ASx18eenDf529UGSMwMcaIunxA1pxUfJeFf/1II+8J9zzkZiJY2ZU7uVIdcpcd
 JEc3DtsHX43g770E9kGcQ0+g/haa/SXfRevEWmwG4JaZ6cqbE7nD+5kjPAy4EQr1xRe3G2Otwee
 C6wkIV9IfMzCMizE8vEqBhb8yqZ3SHF60WNUPU8rBqXiBfIc4s3C1zcMQfkEtIzci/9fQXHPSaz
 j/mq1sitFRr8E/BZEsMnTRHHUlUnXSn0QJrfR3i9n5C+/MuW1lgZeSvDjb2CjzEBQqwCxd/Gbmh
 V6U9M02afuoq0EDtb2Krrm+CTd9tVEBYcAQ24ZGtWiH5haiL9Pi4KvJVWpok9Xpn0NYmW26u2Xe
 /LRgH8rFp0RA0you+tivtT/imhzBXN0AYJQ4WaaceO2JffsBmLijc8kon6+AZoIt212YpHpJg0T
 P6bj1n/sdhdaaZKOiKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240040


On 14-07-2026 01:05 pm, Stephan Gerhold wrote:
> On Tue, Jul 14, 2026 at 11:02:32AM +0530, Vishnu Santhosh wrote:
>> On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
>> NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
>> per-region access control, each individually DMA-mapped RX buffer
>> requires its own XPU resource group (RG). With ~16 RGs available, the
>> 32 per-buffer dma_map_single() calls exhaust the table and the first
>> inbound transfer faults with an XPU violation.
>>
>> BAM-DMUX is a singleton (exactly one instance per SoC), so the
>> destination VMID does not need to be a DT property; it is looked up
>> from the compatible string's match data instead. Add struct
>> bam_dmux_data with a single vmid field, and a shikra_data instance
>> hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
>>
>> When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
>> a single contiguous dma_alloc_coherent() block and SCM-assign that
>> block to HLOS plus the VMID once at probe. This reduces RG consumption
>> from 32 to 1. The block is never reclaimed across a modem power cycle
>> (bam_dmux_power_off() does not touch it), so the probe-time assignment
>> covers every subsequent restart without re-assigning or reclaiming. It
>> is reclaimed to HLOS only once, at remove or on a probe error, and if
>> that reclaim fails it is leaked rather than returned to the page
>> allocator.
>>
>> Each rx_skbs[] slot is pre-assigned its virtual and DMA address from
>> the block, so no per-buffer mapping is needed at power-on. Because the
>> coherent block is not page-backed, received payload is copied into a
>> regular netdev skb before handoff to the network stack; this is an
>> unavoidable extra copy on the XPU-enforced RX path.
>>
>> Platforms without match data are unaffected: rx_virt stays NULL, no
>> coherent memory is allocated, and the per-buffer dma_map_single() path
>> is unchanged.
>>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> So how do you handle TX buffers? Right now, they are just passed on from
> the net subsystem. There can be up to 32 TX buffers in progress as well.
>
> Overall, I have mixed feelings about this patch. It looks reasonably
> simple, but fundamentally I don't understand why we need to go back to
> the old days of implementing protection using a highly limited MPU (in
> your case: the xPU).
>
> Why does the setup of BAM-DMUX differ e.g. from the setup for the crypto
> engine? Crypto is also using bam-dma, but it avoids this inflexibility
> by making use of the &apps_smmu. Is BAM-DMUX not covered by the SMMU? Or
> did you just decide to bypass the SMMU in this case? (If so: Why?)

I checked with secure systems team on this. Crypto BAM is
behind apps_smmu, so protection is enforced through the SMMU's Stage-2
page tables.

A2 BAM (used by BAM-DMUX) is present in secure domain and does not
support Stage-2 translation on this SoC, and there is no IOMMU domain
that can be attached to it. The only protection mechanism available is
the xPU.


Thanks,
Vishnu

>
> If you had BAM-DMUX mapped using the SMMU you would get all of this for
> free. No changes would be needed in the BAM-DMUX driver ...
>
> Thanks,
> Stephan
