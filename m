Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683373;
	b=eKczAh3xFceVZ/MGhO1ZWVqnXMKK7hbq5nhIpaIpsi26qp+lL+OH+qN9vuI5+xoTi4U7
	 bqDq/8/9r3uzobzzjFYnLTe5tOSA5nH0PK2gywWEbM0KIzJXba5YUADfm4xdeMpU4tyko
	 6dwL3K0Ccpul7NbUPOiARdcJNqs5Itq+tq6TGMEEERKHlXqqpft1TCh1hMmKzisRXqISS
	 Sp0Nw5TsfbKL44N5ao8j4Aq7K/1jJyLaVAfpL81UNVOR1PGKkBXSP6Ol27WjGIRXkaOHe
	 QSDOoyISESOGdG45uRXlW7eiwndxFEzMkpmRVfc6qf7PYjJ1sroBPWqmB4i70z2u6dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683373;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BR98tkQVks6AJwD3RBrsYEU/yAAvutTQVgyJLvDwq1c=;
	b=iZ1Q3GyWkaQU+vi+G5hVXLFW49dnVe9NixGDd9nssUgc3rr2YC1jnLu/qhBcI9WJeJJ5
	 Rtt7NzotHYZMLANMAcAmEWNfUDLSLZJcZEbiSaF9aiCIIoflga5Gm/FsocPB+Lqi+Kew/
	 CsezIuq1EwID7+2Kb+r5KbSztR5C7nZERtHs1aWpo21tcfuZtnkOkKW0A2dYThZzV0aE1
	 6GQUFfu4w/Xw5ak1Y85Icl43rqVWXzXMK5BJzGAGk7Rg0/nUG2BpbLRid/X0+ANHoe1DT
	 wskVT57UxRritho/iE9grAKPHRZRBb/Z59VXn+fQgUDkzDFR2MA7S4uJ8Up/2or7xZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LkbyEAQI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GiSQvBxc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE4606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CE4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LkbyEAQI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GiSQvBxc
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eOI31431380
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 05:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BR98tkQVks6AJwD3RBrsYEU/yAAvutTQVgyJLvDwq1c=; b=LkbyEAQIuZ1FuxcC
	E+js3EmF9O8e6tCqEO7ccWe1jjgqM6gtp4s9G8kKbHnpO7DjwL3ejMcUy1a2BoH0
	pAvN4fvOVdiIkA4OQ5dsBF5YIs5IdeBwt1ScdgeuMsJaR+jGffOhFtm7MhoBPHZJ
	H9zMcQUdRrTfKGu9gWxR4sf7ybWUoHIBmQqlV6NcMafUOPxUuGZX+lyBdUVIDzJo
	oR7frJPUD8jpVHmCqT/tlM0OwmJ9cpPptwGcf9dU+nvyM2/ulcGSn/g5IN7zrtqk
	Io1+qFixD0t0WTE8U7LRM5KiqvTQkpJ1c9pwCh0DkDqFhp8cOdU/kazPsLMJ1Mr7
	1vKp/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq087228x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:22:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so292763a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793683370; x=1794288170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BR98tkQVks6AJwD3RBrsYEU/yAAvutTQVgyJLvDwq1c=;
        b=GiSQvBxcB7BgUobbQdfi3JXdzCdxibGo988G86roq4WYUHSld3TZYLocamJ0rFl0TQ
         pgvnO8q7XpNs33VWAQCg3o+ELJeUYEKl5ttnvBIebcNngECNyYpJOjbPchAIjpRckQKc
         DIhL0+M13Liv1Gks4Imsf212iK4JVx+jhnhUj+Pc/Nz3lTd8E9/1hTZNZxWBAConRP11
         0u0xKaUc0hO4FBuM7mRErVV49QdiLJzNbV3kMu3Ogf8QJLe1Ks5b+VaDkAJLslqkQAC3
         r+7N2HBk9Th1d34CkMw7Uzx3+aW+0ervrvGd2PhA+ck4XIP1xhWjNp+vFLspVIKICOoH
         fi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683370; x=1794288170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BR98tkQVks6AJwD3RBrsYEU/yAAvutTQVgyJLvDwq1c=;
        b=OJ3pfCgnai5dDzj/TsfdEctIKrSDpjn3/OU6/TKM36WEl944xEgOxFBZYQnM9ERmNC
         CFJD6OcxtzRXtcMLEJmt0FYgEH6Qz6BczN7XMep3TdNNtjw65Fc2zAXnRHzPtt8aMMsY
         S4BOUHZs0GlkLFwxrjx9YRV5HJ+6Ww13R55WUR6cfa3xVYhvz4UM6IFdAcES0RIjlyJA
         AzV2dI8pQUXMjzHzUaQKvsQOFqBZcNjlWWkqT7tmUBvJo/qYSkiCe1y4L/ztwDUYZtqj
         jBkIjpkhMBtZOZ6jU+zpO/uOld8twn9n5yvI+xcz1aHY7WA/MtsVFwCRXTZqFmw2v+IU
         XCSw==
X-Forwarded-Encrypted: i=1; AKwUvByVmpVZTclNwhSlvu4ryjGxUpSUrsq2+5GApJkdEHcSXy7O6RosWYt+FdZ4GR7V7wSazdTVabs=@vger.kernel.org
X-Gm-Message-State: APuU4Z89zBs6DozPpaQ62PqVufqSDWyZHt5XeYFZjz5O4HGP3pjtaVNM
	qhsIQrKza7jB22Ge/0/RkD5vcDRw9zQyRWFOMH/9fo75Zi6jZjmcC0D+DA2eM5ngVbGdJn8Sfc1
	WmRASOfffLkFerydoATw1CiDLvoMOPZFMoACTDNq4/vdZnc67YQLRy1odnd3HUr+dWNU=
X-Gm-Gg: AYBFou1lXKAhH49jUWrSfRpyJw/DlIaEHA3X47zhXTP9LWbRWDpeQLrX3C+F4psG5iZ
	vVulhjAw23P6GaxDCEYlsF8otql6dQk7v00OpmxMzVkjoCzmKe0ZxnSv2yY28hrqdFMEGDqCl3Q
	2fRRMEnJPZ78YAphIbibUVwVRjrxANgUWQLGmpVwFgYyO+gu0rWUSl57ujgzO9DHkgH7dKYK9XT
	AWBaID1BaiVGdpYBfu1U+jV8EWINdn3w9tIr1c7NYVoI1EqRbBjuu4PSvbxkfRou708NHXErtf8
	yfJ3gDcSpv/1FPBpcnPbtAHVXAJe7uup/9mMjBwNYXGWZ/K9zOdqvcW9vx1Ytrobg4d7Yl7eisv
	YYTu5BUcG4oxWdPVtXfYNp6UO1vtSDrmgOfeKIowlM8H5uB2HDyiZDI6UiJENFAU+Nd6jqwbUly
	1ZA3ku
X-Received: by 2002:a17:90a:d887:b0:3ac:7a5f:2cee with SMTP id 98e67ed59e1d1-3ae6f015b72mr10962229a91.39.1793683370094;
        Mon, 02 Nov 2026 21:22:50 -0800 (PST)
X-Received: by 2002:a17:90a:d887:b0:3ac:7a5f:2cee with SMTP id 98e67ed59e1d1-3ae6f015b72mr10962216a91.39.1793683369533;
        Mon, 02 Nov 2026 21:22:49 -0800 (PST)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb363a62e3sm688502a12.4.2026.11.02.21.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 21:22:49 -0800 (PST)
Message-ID: <3a8bf3ff-bd02-47b7-98f8-e568d39cd086@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 10:52:41 +0530
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
To: netdev-bot+sashiko@kernel.org
Cc: stephan@gerhold.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, loic.poulain@oss.qualcomm.com,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net, edumazet@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        deepak.singh@oss.qualcomm.com
References: <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>
 <179292379798.3134.3640182983987741764@kernel.org>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <179292379798.3134.3640182983987741764@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfXzF7tgTtORqRx
 2opzNgJYzFTYH1Fm07pI5yL2E7Pbx0NR2sA5aikyQSX6Lp2GOnUk8ehiUb4wWYYYkXwYFCYhUxn
 Fad/T1eaLCrCX5vRuizhEwQz8Bchb4Q=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae96fab cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0nVg4KMEP9fHxcKd-jEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX0YjO4/6q5yPT
 FVteCFbZMj4Exo5tQtRaObqx77phh6frxHcuT8IoP8XnfrDKNYopxW3vJtxVDfRWEMxjMQTXn5Y
 ub6xhto4+EZ0bSgAbrxmNNQ1OLaPPGLEMoz5RVlUWg/25447osJDwBUuYMv/HW14F07+y9r5ThX
 nNx4BRAGWBbf/VQV/FHD+RVgInyARVE8FJGkuEVNt74tv8oADcbs0GXfnGtZye983HIx8vpnuTx
 TKVkdy8UFyhdwoWxNlWkWsOwpt22eKi3tzSyLvvWY7r/S4hupdHd/fqNCbgcvwPTGeGUdXfiRri
 4OVGUZbyayM35cY7uU/k4VF2qg811pHD0Ty0s7anvhmHQJ5OM2rZ2gn1IGzSNiIutIvDI5xznHi
 Wzzucraw9QmaT6LO8XqOKY09+nzmPDAR6y/bbhDWpqup9SK531/ZxZfua8ANh2bIIKiroE3N8a9
 XYM1vHFxvu0sB/kht9A==
X-Proofpoint-ORIG-GUID: RmSx7oI_8vNbObbyARIRAcMH7oRIwGgp
X-Proofpoint-GUID: RmSx7oI_8vNbObbyARIRAcMH7oRIwGgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030021


On 25-10-2026 03:53 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The new memory-region/qcom,vmid properties only cover the bam-
>    dmux client node.
> - [Low] Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml still
>    says (lines 18-21): "Note that this schema does not directly describe…
> - [Low] Baseline decision: false (resolved later in the series).
>
> --
>
> dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties
>
> This adds two optional properties to the qcom,bam-dmux binding,
> memory-region and qcom,vmid. They confine BAM-DMUX DMA mappings to a
> restricted DMA pool that is shared with the modem through SCM. It also
> adds a qcom,shikra-bam-dmux compatible, with qcom,bam-dmux as fallback,
> which requires both properties.
>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> index 33746c238513d..f7388d24c8612 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> @@ -22,7 +22,11 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,bam-dmux
>> +    oneOf:
>> +      - const: qcom,bam-dmux
>> +      - items:
>> +          - const: qcom,shikra-bam-dmux
>> +          - const: qcom,bam-dmux
> [Severity: Low]
> The description at the top of this binding still says:
>
>    Note that this schema does not directly describe a hardware block but rather
>    a firmware convention that combines several other hardware blocks (such as the
>    DMA engine). As such it is specific to a firmware version, not a particular
>    SoC or hardware version.
>
> This patch adds the first SoC-specific compatible. Should that text be
> updated too?
>
> The commit message also doesn't explain why the no-SoC-compatible design
> is being dropped. The only effect of qcom,shikra-bam-dmux is the allOf/if
> block that makes memory-region and qcom,vmid required. The driver's
> of_match table only lists the generic "qcom,bam-dmux".
>
> Separately, the subject line only says "Add memory-region and qcom,vmid
> properties". Could it also mention the new compatible, since that adds to
> the DT ABI?

The compatible was requested by the DT maintainers so the schema can
enforce the properties required by the Shikra firmware configuration.
The note about a firmware convention therefore still holds.

>
> [ ... ]
>
>> @@ -72,6 +76,22 @@ properties:
>>         - const: tx
>>         - const: rx
>>   
>> +  memory-region:
>> +    maxItems: 1
>> +    description:
>> +      Phandle to a reserved-memory node compatible with restricted-dma-pool.
>> +      The BAM-DMUX device uses the pool for DMA mappings.
> [Severity: Medium]
> Does a pool on the bam-dmux node cover everything the BAM accesses on
> Shikra?
>
> The pool only affects dma_map_single(dmux->dev, ...) in
> bam_dmux_skb_dma_map(). The BAM descriptor FIFOs are allocated on the BAM
> controller's own device in drivers/dma/qcom/bam_dma.c:
>
> bam_alloc_chan() {
>      ...
> 	bchan->fifo_virt = dma_alloc_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
> 					&bchan->fifo_phys, GFP_KERNEL);
>      ...
> }
>
> bam_chan_init_hw() then programs that address into the hardware:
>
> 	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
> 			bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));
>
> The companion patch "net: wwan: qcom_bam_dmux: Assign restricted DMA pool
> to remote processor" says that "BAM-DMUX DMA mappings and BAM descriptor
> FIFOs must therefore be constrained to a designated memory region", and
> that accesses outside that region "can trigger an XPU violation". It also
> says the FIFOs are covered only "When the BAM DMA controller references
> the same pool".
>
> However, Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml defines
> no memory-region property and has additionalProperties: false. Nothing in
> the series changes that.
>
> So a schema-valid Shikra DT would leave the descriptor FIFOs outside the
> shared pool, and a DT that works would fail dtbs_check. Should
> qcom,bam-dma.yaml get a memory-region property as part of this series?

This is covered by a separate binding change for the BAM DMA controller,
which goes through the dmaengine tree:
https://lore.kernel.org/all/20261021-qcom-bam-dma-vmid-ext-v3-1-299355e8dd3b@oss.qualcomm.com/

Vishnu

>
>> +
>> +  qcom,vmid:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 1
>> +    items:
>> +      minimum: 1
>> +      maximum: 63
>> +    description:
>> +      VMID of the remote execution environment that is granted access to the
>> +      restricted DMA pool through SCM.
> [Severity: Low]
> Nothing reads qcom,vmid or does the SCM assignment at this point in the
> series. A Shikra DT that binds through the qcom,bam-dmux fallback would
> bounce buffers into a pool the modem has not been given access to. Is
> that gap between this patch and the next one acceptable?
>
> The next patch in the series, "net: wwan: qcom_bam_dmux: Assign
> restricted DMA pool to remote processor", appears to resolve it. It adds
> bam_dmux_assign_dma_pool() to bam_dmux_probe(). That function reads
> qcom,vmid and calls qcom_scm_assign_mem() with HLOS and the remote VMID
> before the DMA channels are requested. The patch also adds
> bam_dmux_reclaim_dma_pool(), which runs on remove and on probe error.
>
> The driver matches the fallback compatible and handles the property
> whenever it is present. So the fallback semantics look correct by the
> end of the series, and this is noted only for completeness.
>
