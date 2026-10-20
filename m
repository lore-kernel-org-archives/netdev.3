Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481429;
	b=LGDv72oifX8XwxaTQHY3jA4hDIsxVazNZ6bZDd+FIeN3LiUNAPQz7lWnIMcvSaTzstmE
	 ELzeFCH2t9jaA60OZOSMYKUpinVnqHqo7guf9vaU1GgsKNpClF8W9OYTIBA6iTwWMbY9Y
	 +kj9/pZ39UCXxcJ1z7lJpsTAjyMuSYiiKC0S0hjmT7pva2juuHoYQr4Jj6iNPdYR0hkIR
	 m2SxjZErVsN9vcLGgORcDKCmpgwircdzKuDkrNCaXQxMH44mlRDWdVIlk9gTJ2mkcVCG+
	 Rmhu2lj7bNCFjJIBdZmfN1Ve+CIMyG50HyVlGl0ugTo0+b5BObFfiq/L7UWD0h4UTQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481429;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bBqxEusXiRhPWLDC7mjlDTqytugjoLWLWe2UT0oEOns=;
	b=l/i0mUCfFTSfVGr9w1Nh00cFXBl0cQbZ3n2kJn+vPrpfbQQ6sr1L/ATsq7EOMhhoOjki
	 n7jxtSZ/yiTdpglUnmw5IVGGyc9WkdM5ThSlQp2MUkUOYWO3aTCdzSykqgLQnBX8If3Gu
	 jGGz/yBXeQF4l4VcfYKJwVpZRE7FtygDfHqxYfIDgjwUNsSh0FVgg7UJJFkQc+9kNtlvz
	 B3AVKGVEGoYI9T26gP53hfrm1mh5DpnCKTPqEopZ8tOrFGFEMTGE+kJrMRsh9sJZYBmQY
	 rHvQ/fLoLrn9PZ8tuAU++E1Oa3ScKVHkPsaLPyqy6W+xIe0vl0QT4onz6D0Z4lBue2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XWnIhHFy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kTc9OZVP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22222606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22222606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XWnIhHFy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kTc9OZVP
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tVCb3306691
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bBqxEusXiRhPWLDC7mjlDTqytugjoLWLWe2UT0oEOns=; b=XWnIhHFyxb7aEpiq
	xeGv4niNxM+L/QgL27aVfxAgYAY/CEE1QzmhjLa6+jGoiaW84KWmSZe0lDskvWhd
	0x/3T1vXqVk+/JqHvYTP6r/Hmq24EYMTOcQmOdSJpb8c8+QtaFQMIoSOw3N27nid
	aVBWUsTpBvNGoSS4UcjicM/Pn4uNxq8p0RIVWUzFWVdw8t3Eyzs4isbEtLa/SF/i
	d+PTTBTAbf0fzupF6P5cqKu22u1SyS/h8UY947kRTzsuHqg0OBrpEyJ26w/C2P7c
	AAiz0mxqPta+zbVcilSFtVz0yw8GzFgSXARsNTAuwMEG4PWMz7yZMGQOxVGCkowS
	cTXqRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ssbku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:30:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5350173dc7aso5440441cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481427; x=1793086227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBqxEusXiRhPWLDC7mjlDTqytugjoLWLWe2UT0oEOns=;
        b=kTc9OZVPsOz94BhSsVNIGqO9tCGce/zX5sarupQmA1NnhEYX8I4TRn5ghDt7iR30YX
         by9EsS4ve7ZrCK8gBNO8cXqQl+lzuxvZotnZ/oFE611LG0sxXnrtPEnM8NBAhM6ciAkF
         snNZ3/7aJmE4IQ0ifpCs++oZOcDs7fJsYCPR8mrjp8yedpr6sM/tTHGEa/hDdIph0262
         WMpIQospwpv2zezLuWuppFu2udrGpcfIQYBueDzW0Su123WTz5WHTe0mJsYxYoQS3BZv
         QzwURjCNrhOeukt+xyK2EYmMmFcRuONWrAalEJXgcbAe+GngIwhay/MCuZcSf9DqidHB
         krFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481427; x=1793086227;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBqxEusXiRhPWLDC7mjlDTqytugjoLWLWe2UT0oEOns=;
        b=Ege5UrDcPCNyr+hcdqGGNkyzmuldEGDIyzRQajlVnrI+CxfjY6X8EuvjnacbtUcXad
         ye0vF9DTI4C7z7r0VJlIgnllsnTb9RAhwU82kVbNhzjece4jTX8d+2BTa7erLfynI1Rx
         haZLFVZQvnXNbvKR19qFNgucE65dXD8TwqdbimQ6dNfQz2OIWIlm4SHMgsku44rD6Gal
         YOeGTEJI8Neq7ygMFRFoOerdn1Ux0Li/9R6WCZnN4zFxqOiawQmArXUp8+0650nI67Cf
         YuCua0aKDgsZ5zlhiY+NRXx4fgjmhox9Jk+km2lrrSkwUKZstXasN6UAwSKBmSkcCQme
         8qRg==
X-Forwarded-Encrypted: i=1; AKwUvBwKv3cFdRgZUzCTczWbCW5IQ/i4RU4UjahHVWYLrg2s01NrbgS/Pr1HEJ/k9VFsnYdKlsrl43o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDRoY2kdpfhpJ+K/rVZJOTCwQAl3TBVHVhL7HS3mkvICShU6XM
	kGkEZlMrGrldRMpoA8K2jPJrN6+DiXXTc44Usuh+SvNix7oZyjzj9YGhDdmCWDRmYX3ObQuCZEL
	UDys8sicXMyjZCAEP2EMcnMs8Wezsj9PNujigqbQ+VpwtVlRAfGKD7Cm/haY=
X-Gm-Gg: AYBFou0aWJvG0K3ypDbRzjfcemNEdFCkWrRaVwCL/XwSXYa877+UMHWyfXnc0+oIXwI
	MMqMZq5ur1syteJiayy8GaFFdFk2JCPHUJlw5XDEIeu57yJ7kEB3LvzqbCoUqIZlpyOOEA0HCB2
	DZw22AQtrJdbW9bizRY49zSo+wQEvPbHGiJJzVX6XkH8XYAT33SY+jbH3U9VnM2tSiT6I/7f2PN
	T2XFceNHct38yjV5ZT+bHCJM7e9h96l9PtRJNp5+S1ey2bhhc94bUXwsCqTHx0ObtfC/p6FkTGN
	TujNllPL0c6WIyJLDdlF1rjuuiPlyZ02l6OyqZsnQBaSXhiQatZ4r7VB0Lt9Vb4CnQnPYzdiYKH
	dJxS/ppqR3R6af2ehlUHQAA==
X-Received: by 2002:a05:622a:110c:b0:535:1e4b:53ed with SMTP id d75a77b69052e-536460b5145mr176740661cf.5.1792481427229;
        Tue, 20 Oct 2026 00:30:27 -0700 (PDT)
X-Received: by 2002:a05:622a:110c:b0:535:1e4b:53ed with SMTP id d75a77b69052e-536460b5145mr176738631cf.5.1792481425434;
        Tue, 20 Oct 2026 00:30:25 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dcf72asm463264466b.18.2026.10.20.00.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:30:24 -0700 (PDT)
Message-ID: <c59ce48e-05ea-4632-aef5-78b9c6a4b21a@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:30:19 +0200
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
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: Add bindings for PDM GP_MN
 clock divider
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-1-1522662b6c53@oss.qualcomm.com>
 <bc3cdd77-9e67-4e72-9144-af854076b74c@oss.qualcomm.com>
 <f25e31fc-4767-4c1b-9c34-2b2f78444967@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f25e31fc-4767-4c1b-9c34-2b2f78444967@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX4O42Uf3Tc+Qu
 LLCwUG7YUZJncSaRE9JaIVMvaQJ7rncyR35RCN8Q8pxcustYa8IOyrlsCv06kO3e2HpVKj9ONy0
 ZixovJ2h1AnGOCSm4k3VTfJHq0giPs+G8hNhrp+HQm0Vdyz0X5tfmdIKzvMKSRspud6IiQZZK3t
 5m5pT2+gk5bWuIDEe7nesmVu49N4blThaZAV/81nzmsUK3z1UJN3AOmsolcOe3TORRrq7FjY4UZ
 yWXl94Orh9kBnPkNTxRWsJbfCeYEzyX5ig3vKHrSGhGLbA6gF9RmgsvSd4HRzVhAnfQvLLJnCDo
 bgNGLKmDJ/RDWOfHTi6+lYkiGjOYKu5hOhSrlHlvjmS4XtfX0nLj9wfd/FqZF6PTzml3ZG+2YpB
 f3fnwk8phi3fz8Ie4BWg9VDdqQ611xkWCOE6CLjMJs3jVAy9U0mf3xL2vx+PJoC5L5paoA6Nick
 hd8vd3ZHFruK7kpq8lw==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad71894 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SJAiqMQSjMSsh2023uEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: nm9Yb0bjLNiucxqWdRI_KS8l5pRRwmEf
X-Proofpoint-ORIG-GUID: nm9Yb0bjLNiucxqWdRI_KS8l5pRRwmEf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX+mk1DDZA1PHd
 BULesRWc1qaU4Z4FiK8WDwsDkO7EQCgQEttctX+E7UpiHUGOxYKlk0pXh0FZGpWEV6erMD8ZMLe
 FfBSzykcI7CZyWUAuPaJoCdrynXe2xY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200029

On 10/15/26 9:15 AM, Taniya Das wrote:
> 
> 
> On 6/9/2026 6:54 PM, Konrad Dybcio wrote:
>> On 6/2/26 5:21 PM, Taniya Das wrote:
>>> Add device tree bindings for the Qualcomm Peripheral Web's PDM GP_MN
>>> clock divider. The hardware generates a fractional output frequency
>>> from a fixed input clock (typically TCXO4) using the relation
>>> Fout = Fin * (M / N), with duty cycle controlled by a separate D
>>> register. The clock output is routed over a gpio controlled pin.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>>> +    gp_mn: clock-controller@88d3000 {
>>> +        compatible = "qcom,clk-gp-mnd";
>>
>> The compatible must be SoC-specific, looking at the table, we could
>> use these example socs for the versions of this block:
>>
>> 8960 (v1.0.0)
>> 8974 (v1.1.1)
>> 8994 (v2.1.0)
>> 8996 (v2.2.0)
>>
> 
> Apologies for the late response.
> The GP_MND block does not have any functional differences across the
> supported SoCs. To reflect this, the DT binding will use a SoC-specific
> compatible followed by a generic fallback compatible that represents the
> common GP_MND implementation.
> 
> compatible = "qcom,sc7280-gp-mnd",
>              "qcom,gp-mnd";

I think the dt maintainers may be a little grumpy about the non-SoC-bound
fallback

> 
>>> +        reg = <0x88d3000 0xc>;
>>
>> Let's map the entire 0x4000 that this block spans
>>
> 
> This region support 2 or 3 different blocks of HW and they have
> different functionalities and for which I am going to add the driver
> support. What I can do is map 0x88d3000 size - 0x1000. Please let me
> know your comments.

Sounds good

Konrad
