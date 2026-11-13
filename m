Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540905;
	b=SztxJQZa7CHRrov1zR2U8CyDm3x4JACb1qqiL+PtQilpwIMrtqFUmPaSm5iOfUFcLwOZ
	 a2wOjted62/JUKSWcL0jIpyIX5bTzMasBOD1UE+Afy5MBqQ2iqdENs3OH16exRwcd8ER5
	 ARcpVLjPOaFG7BnY9bNGZwurnMsSkPcS7YYTqKHKK7XDpdzl7J4+zbqU0lstx0d8lrkyK
	 fxrAhd3aX1A1uge500/rtvL02Nb5fYYkPgR/olCOWQMdscz/j+gh3TB6MDYXY/i1XNsuC
	 KRDINlXCA99B3opBzg62AfPkUBTeP5Uy90GTfaIOFRwJLojnSXgqnPyHxE7Amtfu41Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
	b=VH534L+q+GCtrXX744fMMu7EdZN8t9BWnaGzpiw+0imrIOjEPeaQMOqgTj7ynkS1wDdj
	 tl0tFTDkEWllXkMXQUNSKQu28xjvjeyyhy/xk9HiUdycoVUlMjcSe2+oFX9VA1LQk0MKY
	 Bs1zD6w7U43Ro0eCqFcItPvZORbN22CS2ZKqhVGQwK7btCrD0e5ImSBCiln5QvIUNfCMQ
	 vIrhYdqzu2P0ZoZHmK5FISE4WQMPa0SJxM5G/WxY8Kyts4Uwe7LbNVHt2zLDh+I+8xbP9
	 e3b93CNUwTry2WEf21dXNZZ+nPRmRlv92Z3Z9KiIROroDJGsJSx/wv9D7CQvCO9T2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRnXIVRB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTaLV2oO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A9606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 521A9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRnXIVRB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTaLV2oO
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2JqRE3273406
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=; b=gRnXIVRBJDeM8ySw
	aPNieEiH7Q31za35m7BrDXSXEwzVomjsjQmGkm4/SgoUxgWkcCtfB99OQ5Wlez8X
	p9Avu5YAaCgt5F/3mUxfJKrMz3MVgU3cglt6YLqxcYi4++JGPGeE1Y+eNB1RfbiF
	IldTPCGIsLsb0GZL+cK3UUv/y2gmhXNyhvVqhhvROtlbLIONAp/gGQOABiUI4+ly
	+eSxZJxnhnrFlgzT2lAyrrN7M8gC+r7K873liA/SHsrV+fN8oTsW70bHscT1jGgG
	Jav1fzcVOB5XlpJ6DVvZSPVnbZv+aDbbCyjNq3plOrf3KVAuTOtJFOQCjQQRstLe
	8ppyDA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufgh40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:35:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd652c0385bso332633a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794540903; x=1795145703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
        b=PTaLV2oOe3UKjSpdSc2iI73FcRNBDEWGiPqwIg+uPoJjTj9JmjbHf5BccxN3dpSgDK
         YRQYmJ3P9kZDUMYkZG/JBG6UB9Mg8M/B2qJGCP3PvORsfJOcPknJEn7hYwiTDYz00RS8
         GcBCrI/eGVqXgJa41vBvnvnrVqUdHHl5tdKQgO62tbZ7zaGjCXG8jRLY2KXpEg9Cafyi
         F3rRyqiIzDyJ7lXZmhRFwkkTFH1ZNEB2Fx26g9t7Z56eLx1hthODRXG69Ro6i97bEMCk
         TtXb9CZ1Vi+AD1Mj88XbivvmOrKeaVTVudNJpl9Cn8tEA7Zu66pEIXMWu/1+8VUyuAtr
         NWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540903; x=1795145703;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPZ3HOktLUKO7C6+7rK8PWwT7CibQnKEc7TizM3393o=;
        b=ovWzHL9WF399V9rp3O4xW6g2ZW/+zaFKNYyC2GGzo1xSU0WxvvBEoymjQS+lOCtyi0
         AhED6427vPzoh8dfw2l5j09uwQw9Lb/r9UlcaJTqW/0ubgSMZ1+N5LxTp6m61rM8/WHV
         uH3pPo5ouFY47a0DWTbRAwxo8lLiIMEP3LsyOy0K3FwGilEUf185AcVw9d/wq/bPUFVM
         TjPP0ePpik1D+rymZHXfXGxniqhRr9H54PInuBbdWBN2R5eM+D5t4NMDVH/bWUDsMrzc
         CjZsYLAYAT2/vZhpK5gVuHVqs568IDiQADNBY69oe0CK8XuSrRvjfg8SsU35Gz5q1gW/
         4Prg==
X-Forwarded-Encrypted: i=1; AL+hErFM/a192BFNu37IC5nmlN7wzz0wiMoCdenv3UBdX64j/kEg6MIO1of9H7vuCcZ3E5s3YfjmO8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ORx8FV0jFxw/EMaKRItuFukFHmGrXXZg9G1vfmGnQRPChOuIN
	jvvMo7y2JiJzY9ftXSFUSScgdSnBBFK0SG8WMsmabcijcokKbHAnKgOiYZ+MJFttswjRJ/bWZE1
	4WV+iUZsS3XRF7XWlFxQ5k4iGGcuSHzZnmy+pUbGstz42XUYtt4kHajASq28=
X-Gm-Gg: AYBFou0x+2Ub1k//EEYMyH0Eq1p7QsXH6TuhMnAUUCCAGiJ7+WGRSvQD63Gc0xgSsUv
	91mdyyYJ3U7c5NebmWTs063Pd3cF9NHpfbUbDlbcSOFejTGBdv+LRO45A0h/rkAV82ugtmadvZk
	Omk+kOkVKF/w8yhC9W7gLpMKXTg5hgnZKlvc3Rz1WGXp8GcGGQm7hg5F78yIAH1B3dd8f8fA71T
	B3YBslYJYAjbQ5oHMT9DagZJqucZFVtUhZtWCblqOJRqyEXPwa2wHCH5etZERnD38qkD0um9/2M
	ELXR3R3u6G6Sh+eEOPxZ3IjwJiv6jJT2B/AH3nDqGQ2s0SVtzzG1MasRIg6Z17P2c2x0ubWs0WY
	iArOlD06JObr93sPhDpN4ufKoRtJs6IPNoezcRZck+O3v9me5/+PFUEOSmJt2J3oYRH4+8w==
X-Received: by 2002:a17:902:e882:b0:2e8:3d48:4d88 with SMTP id d9443c01a7336-2ee0da31ea2mr13290275ad.7.1794540902737;
        Thu, 12 Nov 2026 19:35:02 -0800 (PST)
X-Received: by 2002:a17:902:e882:b0:2e8:3d48:4d88 with SMTP id d9443c01a7336-2ee0da31ea2mr13290065ad.7.1794540902273;
        Thu, 12 Nov 2026 19:35:02 -0800 (PST)
Received: from [10.235.8.108] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e4e47sm3464175ad.38.2026.11.12.19.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 19:35:01 -0800 (PST)
Message-ID: <15996045-3f5e-4680-95f9-925c97301ab0@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 11:34:53 +0800
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
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5210 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
 <20261111-qcom_ipq5210_nsscc-v2-1-7e2c1dda3ed2@oss.qualcomm.com>
 <20261112-wild-accurate-cockatrice-a80efa@quoll>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20261112-wild-accurate-cockatrice-a80efa@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L4qeP85uCU4LlcxckE5OU8K2-oZZvqUQ
X-Proofpoint-ORIG-GUID: L4qeP85uCU4LlcxckE5OU8K2-oZZvqUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxNCBTYWx0ZWRfX9NnoKZK6AmyS
 ZV3JQICZe5RX74KiMMYQFs/rHZvr77ZoznBYb43nOfvWzNgVcdSXgl9Qs0I0GNnvvYEa13s0VyT
 yoDgjzhVqComxuKYxgW9e1oaUB3H7Nq1ah+ZDDCwk9r1fuTo61O+P3IOdDxIIbkwEuoX2xFGNGe
 booYa0oZ7qsoJqlKjzYMwZFwotmE7aQFARXmBYCvP3iH5CLCmKXHWB7mOOG43OisXpzpCyChdRW
 CHdCWB+3yjracSsE5kzngJ8KtKQT6ua/DnKE1y+vPTNu/YWReCyj9Yo8haAgX6waNRRqR03TXIl
 T0bTmwH+BcdgyhsqW34l2NIHSZVo6vltSjT/J9Dz3vEGX0tavC7C38Ndr+S2I1YvsNrWGbdhb8a
 gosCuoMsfCf1+B78SFz02V41r95efeFsS7QkjhoW4i7AirkyjS9doXDo7AD3l3iZdoV+RbPsnzx
 pjvd2xjD1a0n7LRQuAQ==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af68567 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vjzNbMJ68Ufz2hOSJBcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxNCBTYWx0ZWRfX/ak1uT7fSdXT
 UyX+zBMzk/aVcPImvyYqGyaf6hoCTaGfF7P98Kc+jvOrW7IEp9VglhHeX4ekaeZUsq4i9gPlYiS
 WRyyho38d8WtxRp/Bwsr3D8IOm5ACVg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130014



On 11/12/2026 6:57 PM, Krzysztof Kozlowski wrote:
> On Wed, Nov 11, 2026 at 02:00:55AM -0800, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the networking
>> blocks such as PPE (Packet Process Engine), UNIPHY (PCS) and EPHY on
>> IPQ5210 devices.
>>
>> Add support for the compatible string "qcom,ipq5210-nsscc" based on the
>> existing IPQ9574/IPQ5424 NSS clock controller Device Tree binding. IPQ5210
>> additionally exposes a pair of EPHY-RAW Rx/Tx clock sources used to derive
>> the clocks for its integrated 2.5G Ethernet PHY, so extend the clocks and
>> clock-names lists with "ephy_rx" and "ephy_tx".
>>
>> Also add master/slave ids for IPQ5210 networking interfaces, which are used
>> by the nsscc-ipq5210 driver for providing interconnect services using the
>> icc-clk framework.
>>
>> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
>> ---
>>  .../bindings/clock/qcom,ipq9574-nsscc.yaml         |  47 ++++++++-
>>  include/dt-bindings/clock/qcom,ipq5210-nsscc.h     | 106 +++++++++++++++++++++
>>  include/dt-bindings/interconnect/qcom,ipq5210.h    |  18 ++++
>>  include/dt-bindings/reset/qcom,ipq5210-nsscc.h     |  60 ++++++++++++
>>  4 files changed, 228 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> index a35bbc7b1924..dc7d90a99dc7 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -4,24 +4,28 @@
>>  $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
>> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ SoCs
>>  
>>  maintainers:
>>    - Bjorn Andersson <andersson@kernel.org>
>> +  - Luo Jie <jie.luo@oss.qualcomm.com>
>>  
>>  description: |
>>    Qualcomm networking sub system clock control module provides the clocks,
>> -  resets on IPQ9574 and IPQ5424
>> +  resets on IPQ9574, IPQ5424 and IPQ5210
>>  
>>    See also:
>> +    include/dt-bindings/clock/qcom,ipq5210-nsscc.h
>>      include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>>      include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>> +    include/dt-bindings/reset/qcom,ipq5210-nsscc.h
>>      include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>>      include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>  
>>  properties:
>>    compatible:
>>      enum:
>> +      - qcom,ipq5210-nsscc
>>        - qcom,ipq5424-nsscc
>>        - qcom,ipq9574-nsscc
>>  
>> @@ -42,6 +46,9 @@ properties:
>>        - description: Uniphy2 NSS Rx clock source
>>        - description: Uniphy2 NSS Tx clock source
>>        - description: GCC NSSCC clock source
>> +      - description: CMN_PLL EPHY-RAW Rx clock source
>> +      - description: CMN_PLL EPHY-RAW Tx clock source
>> +    minItems: 11
> 
> Please place minItems at the beginning, before "items:".

Thanks, I will move minItems before "items:" in the next version.

> 
>>  
>>    '#interconnect-cells':
>>      const: 1
>> @@ -63,6 +70,9 @@ properties:
>>        - const: uniphy2_rx
>>        - const: uniphy2_tx
>>        - const: bus
>> +      - const: ephy_rx
>> +      - const: ephy_tx
>> +    minItems: 11
> 
> Same here

OK.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 

