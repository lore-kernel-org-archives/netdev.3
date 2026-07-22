Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7633938B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718663; cv=none; b=MsUbg3XQZ9CpUxfGqcrwJlxg1C70ZuIJUfwdy+veEQLe5QUcT84dxWNi7AcfyForWji7C3DwBjOIFAW7B8Y5iT27DjDSOYKCh+qq4topRca+1hcE66EDGHd/qAgeG1zQHWUi4ltsuaiFagQ0QW22NzIMtpTdOfb/GpQ3xHVIizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718663; c=relaxed/simple;
	bh=K24m+qYmR1NzZqb/MiTgXdxUNfIS1xjrVZ2qj4xPKdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Utem2Bh7zvfGby8UbJZQMEaPnhR2v4vq9fT+UZOmaljsLzRNEjryQrn/LD9qRcyrosm42vOySBpZZW4xG233RC4dVFFC06/7kY//KIEcbDsPD7SFsf7F6DjfP40oN3Y9NxsMZjJ74wUXkE22bZS7DKVQShLARlZ4M5UD8Dr2ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BEbdBk+0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BulT+Q4j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEbdBk+0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BulT+Q4j"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x1Jw523770
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DBiJMMuoPrEtOmc6U9mz7KkNj7CRMIomaeyR0Akre3g=; b=BEbdBk+0APpK28ih
	ShWUOgvZ35zLSxslUn6iqm3JEp+FrsoALoZ5cZaq0jfFSdD1BwHA/wylqasHYXDe
	vbm4AAh4FOC8YuGb+tEJfHLdfqqA9Q0ZP2tWSZ9yDkma5F66Lo8e8qL/CZYHyul9
	rFf0rMqajhzxudIWty/+hxXMebKGgGzsjpWBteobdKP1ic59x4rKcqgeLxST2No+
	z+GVxWhKKI8dmi9ChuUDyUmecO5WTS41tXZTrGGRSxP6uY/BVrH7RTSwhZxG40SL
	xvhuN6uswoMHwbklFR95swBFD3oYw4WEKKVBzB4zjsLMdYZAf2kNdtwc0O26xm27
	Ow4Mrg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt12ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:11:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab041eced3so15310735a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784718661; x=1785323461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBiJMMuoPrEtOmc6U9mz7KkNj7CRMIomaeyR0Akre3g=;
        b=BulT+Q4j7+UukJCSsQY7eXkqzFg9+Iwbau38fslRz5sZOsE3kGX61IUXNt/BdKjAow
         /Qak5qB5ec+0l5W5UMIxrv5qrqDEJAdeuDuQxUztcIhSJEuB22vbFMTSjr8jV/MQIckO
         VGWHAFrJ0tpQWERFVI80t267aZ7dX+mGCoObSmvpT0aeG8TNDjK2PJ9sM0c0/vl2t3kz
         zhvzqEWruYRRC1yBvTGWiKeIFS4W+A6fc/Tre/UCLoGPuPZSkn6dCgTYxZeLuw3IyjJ7
         PXfOaedVblQ9gS6RVHpKZm5ix59tqsbXCMb5vBG2PSbCNI4a6auQiZxvU4FIYHVGSIaK
         XXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718661; x=1785323461;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBiJMMuoPrEtOmc6U9mz7KkNj7CRMIomaeyR0Akre3g=;
        b=QNOPKYfeB0UTVVuc/ZwLzYzhCulCnZaJY6adlZD/y2S6N1LWvuLvqNx4dzP9I5Eo8u
         bBXQS8c6cOA0hGF+z+81M9BZKgxx8jMDuilxlb8bF1gZxjoWaLcnhLP5rNUZm0R54B4b
         RswK5D1AIZzZi125kYXOfUWVmR7AjXHbWGB4lR4xm+3pYf5dLRRo3fnbae2Rf/o+MHXy
         /BgKcBLBfU/HbgVmSafJVKDskweiBIaXy2gSh/tw/SzShzj4resfJSIDFusRr0BSxagK
         ElMtmphTEyqhV17pasEKP1v2ucpYxjEb6tnUItqmMLMjQNJIj9fqGQTjUZvLbYY0Yd/5
         7k8g==
X-Forwarded-Encrypted: i=1; AHgh+Ro2j4yVBHk/VZgsSJTdAxHV+a1eZi57KedCXjEiCTl+C87b1w9bTmplIe0ErtsiuI+sJSoLnzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZO6i6VjES9XZALN1EdfN5fgQ+hY64AjXCrfrVURQKV9UOLPO
	CYO6hYl57o1NLbiYJHsGRChgmJa6aF97n9fQkMymED3G/GqxxlDrttjEbYtR8TPr1TinhzRjTKh
	Id98QWPtUQfzrNgDqdWPFM/2JCG6E2QILm14XMOZSG0IFVdzFMzs+eUtOfo4=
X-Gm-Gg: AR+sD10WzZbZy1ArIta0GpKRW5s40HQCXqDEmB0pEWD7XWtqBhNWEfFnzE/27KrU2ad
	DMNb3JnGqV3uikE1DevjKRVXESaUes2BV9HKMyYzyftJgQsaiNrp215B4RUTkQRqNQ42vyokxIG
	4wFAjjB+Jfu3BQ/Ii4GODgRdIYfV7s2kdZgnJYEO9k6HbGwMVpUcbAjPvj4+SrxSgxjlky3ljRf
	TbF4LXxVvQY05gmxoIWmymrBUH0p3dg9Uj+rhh4cwzJBhqnaGqJttl6VRYA2Jz6PPeP1NBJ3OhV
	2bNjP6yLgVW+vdGdBtWkxq2g0PTsN/o37dU++jWVyanqtt97zZIlgMmtL2VZMGUlmwDGy8799L0
	xn/J/EY9bkJ+JQG97wVJciWKAnbfAUjoiYg==
X-Received: by 2002:a05:6a00:4614:b0:847:82db:9046 with SMTP id d2e1a72fcca58-84c29289482mr23150643b3a.26.1784718661206;
        Wed, 22 Jul 2026 04:11:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4614:b0:847:82db:9046 with SMTP id d2e1a72fcca58-84c29289482mr23150598b3a.26.1784718660708;
        Wed, 22 Jul 2026 04:11:00 -0700 (PDT)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17262d82sm1198320b3a.15.2026.07.22.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:11:00 -0700 (PDT)
Message-ID: <e4782951-8405-4868-9787-662279fcf365@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:40:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,bam-dmux: Add
 qcom,shikra-bam-dmux compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 <20260721-spotted-spicy-skua-cca66e@quoll>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <20260721-spotted-spicy-skua-cca66e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Fr-E4SH5-A9XoSTVpEZ2tBio1MwtLiuP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfX8vQYgZDoFWKg
 AtTtEiy21h4gvIbMMBDLMyBiLIYTu1YOCJ41Z04Tx11U5IkNKyOhngC9KVdncRs2YU1nnqWNsW2
 FAJClt8nJHpjwywcdo71uBnEhlwNot0Nqk0u5rJsrFYUaS9S9FeyB/andUTQ/aUDJ/BJXFopcMp
 5xkK/Iw+NpElyr2EYDujgEVQbTXBQbPSO4YIdq46utSCBmo74I3/e3sDFHs4PpfiQOiz7lSQZpV
 gjibl8VjSvvNSsbdcLXyVNYOXWZyS4FJpzP1Jl3oBWTt9VAK7pw0hYwv3I8PH7lDAnwO07FZfva
 UZEe18/VHM05qH9yMiVPcoHC5J9J9DwuaqnR0WJAMQsqxtUXYEfoKaBHDM3wuwq3MgV+8yVSEbc
 ptdFr3tWappzD0Sb+lRT019IudpYCbV9G+fXzrWtXmafwfFtOcbgHa5uaKDywU8aN8h3PWLV8ME
 0OTliISneREg/j0BeKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwOCBTYWx0ZWRfXw/zvMJYKgglE
 HDyBHEjyijalbldEMhTytnruiZb+WSxo/J3VE3e7KDSWzdIIboqbwoLAAP4B9gRNu5yfy2VNwvJ
 ffB8yQHmj9wKB2Nhd1hsJHyim7tPhyw=
X-Proofpoint-GUID: Fr-E4SH5-A9XoSTVpEZ2tBio1MwtLiuP
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60a545 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=WdCnjmZ1hKd-bg9JzokA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220108


On 21-07-2026 02:47 pm, Krzysztof Kozlowski wrote:
> On Tue, Jul 14, 2026 at 11:02:31AM +0530, Vishnu Santhosh wrote:
>> On platforms where the modem DMAs into the BAM-DMUX RX data buffers and
>> the XPU enforces per-region access control, each individually
>> DMA-mapped RX buffer consumes an XPU resource group. With only ~16
>> groups available, the per-buffer mappings exhaust the table and inbound
>> transfers fault.
>>
>> Add qcom,shikra-bam-dmux as an additional compatible for the Shikra SoC,
>> paired with the generic qcom,bam-dmux fallback, so the driver can match
>> on it via its of_device_id table.
> Drop, redundant. What is not redundant, why you claim it is compatible
> but driver code suggests it is not incompatible.

Agreed. I will drop the compatible change.

>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> index 33746c238513d72366bc52359fb10f275475b331..27f0fdf285c17d6bfdecd5e59cad09912a5e821b 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>> @@ -22,7 +22,13 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,bam-dmux
>> +    oneOf:
>> +      - const: qcom,bam-dmux
>> +      - items:
>> +          - enum:
>> +              # Shikra
> Please do not write redundant code or commit msgs. Look:

Agreed.

>
>> +              - qcom,shikra-bam-dmux
> It has word "shikra". Can qcom,shikra-bam-dmux be anything else than
> "Shikra"? Then why adding such comment?

Got the point. I will drop the comment along with the compatible.

>
>> +          - const: qcom,bam-dmux
> Anyway, the generic compatible was added to cover all possible use
> cases, right? So why it is not generic enough here? One more example of
> generic compatibles failure.
>
> Best regards,
> Krzysztof

Thanks for pointing this out. I'll send the v2 with a qcom,vmid(s) property
like we have in multiple other bindings (rmtfs, fastrpc, ...), instead of this
new compatible, so that it can be used for handling specific firmware security
configurations in Shikra.

Vishnu

>
