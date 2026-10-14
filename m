Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEB4A1E04
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963850; cv=none; b=fYnXguq3b3zZqlZvi+3XlWMBTtoLekFhBDDjx7781pilgHNyO8eDkRqiQF8jR3/YGYrXbXSA5cpmY452GwcMZx7L3Hb1b5dl7JqowzDfwLgpYcd8HUSDhEQYbAv/xmLnXGPTCpheY7aOAHKxxUgvnSeEr4H1Ls8k8LA2HHQzU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963850; c=relaxed/simple;
	bh=R3DH/W8/F1I1fomUgkc5UfikhrAkhPlZqLDVrdjbMIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjO8dfGNmrzhmP0oYc9gSu0kXVkn4vqRV1R9WZKRbuzpqYsRXkFYhLFU7Bk+A1AqhVEE8+Ur9wp1MtYu5e1sVsUUrUz3oh6FlPsfjK7z8ghZCeZGg1+cIpshN0iCyI+hIMM8lsf5kUUdK8gCV9cwsntnoE4OjYDKtHuaz8L0lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lhcs8SBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BqcndHWM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lhcs8SBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqcndHWM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E68G132516033
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BTOjT4OUOzapuo6XNz1VJi2V1U4HM1++DKOVSU+njqk=; b=Lhcs8SBC/Z8xXDm8
	wb0Mku3t1BE/Vmb+aq3adm51ngjgKzsIBNnwfILHQkXdYMwiBV6198agU4EhpK2c
	LGbJPafhSczm4HnJp+jHGC8Jhm7ZDsOVyHSqBHszolA1I+eFSZyJ1YbzeLHUq6lJ
	3L7ouQuBy3UOp7wSfXRGkQuY7DL4o61npICoB3p4V8zhc9dcqYZK0e9Xu7imZQO6
	tmF6unthzf+Cgarn90hAQPsg0ef8Ej2zGk2gmZXbwuOUullkdG2o9PWi1/sQJMo5
	y6Uhj4pSKPukdsFyCbq7XaFjq5U1K1IHSZZ4e8O4n/SkJVh3cu4vBTop7Fy7UE8E
	1iq2dQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4708c4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:43:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so3300045a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791963836; x=1792568636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTOjT4OUOzapuo6XNz1VJi2V1U4HM1++DKOVSU+njqk=;
        b=BqcndHWM0B5G44GraxvQ4FIaWzyiq2HQ5xFJHT8v1+HYS3gKEzT8ZmAFOjj8kiw2f3
         VAuiF166f/zziDohe/Moi93uIPgJwoODRUoGy5V+J/Hotr6TbfJ546yvD5WWvFR/3c1V
         68DRDe0UYUkwnGCORUjiOPx7FdF8BHJXgl7a/RkANFCrQPJ9Pt7OQ/nWgIDiTKeEFbIf
         +cUcmHzoHkhN7ZsBubk2ipSUdgiUoqCpFNzBWPcJ1jEtgyzC9WhumEyf3Qo3+T3t3zZq
         oUdPpGeiKCMnRtk0ZTnV3CnYW7L6QJPtq1wOIPFq3d36RvYuS41xrZNJlzus5iq6Z/WE
         So1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791963836; x=1792568636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTOjT4OUOzapuo6XNz1VJi2V1U4HM1++DKOVSU+njqk=;
        b=Ut7BrScAzKlTzEk6+Y3BGJaJek5jNU8TSPG/QVC9HmaUkIL1LRscYVPMYhzaBLXanO
         g6EVHy0cjInCP0suIACgM/z5jiVNrpYSw7+nJTcCiZpWExfR31MIC1aUAtUGKyPBSffB
         rXAt6ZxKaF8pNBA9t3d7vgNSZ2IoesFrXktEqmYDmRetMR8LXbdnqUbWxtV6PvWHOF70
         Vrfi6wLZLlRw73aPRE8MqcHNkVds4Y9gfxXZQnWDz9bKeU943Kkg6bLDwptMrORlPkXe
         /4IfXQ4vtcJAlJIge7PHEtEB29wunOsBn6MJEeSAs5Gb52W7naOQJLVUsQWLeZd2mjmQ
         Fh9g==
X-Forwarded-Encrypted: i=1; AKwUvBzIARQrZlXmhaqkQ4Ti4M2y28S+3hdayLgFUxvFYogPGI4G1m7Jx1FslK3PBpk9PcbQ0xF9MEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6yR9xUlFeFpu6B6J068O7G33Aj08gmp/NahZFCkFxQ1dikxEm
	X6uhmHi6Ey0Jax/v5vqfASLr5ca/Ik/rO4Manv8l8Kr1KjQgy3z+vdaqjZcySQTJTLyUd5I7AeR
	VcSIUbRpkO17oCUvRtcEG6/BleM6q4mB+40iQSWAI3iAL2VmaYn5ZAcDo3PY=
X-Gm-Gg: AYBFou1RF7kh7Ev1Urg6xAoXf2Nwz46VjKfgfLUKv20pnFcxLI7vtRLV1AkdzEmiTgK
	zjTeuNPtMGMNBDsgBsMjOAVMzVzp9kw6lcxB0dq4kHg+NNrU7R7HJyEhNJbU4BabntrMn/YXapY
	zTs48nssXdGfPnnx/Xw9pT7cwNn66X7dVeouMrZk1LF79BxudJ85DdsUKOVDJRWQ6ldZk7iC8eO
	FRNpL0ui2BaXSEtNylFlM6gbSYDHRYpkH5raWzNF9aJnAIj2uRflkK6377p9UFxvfeDfJroNqql
	GLuIXlO85421hZTsK0jL627HID0XLaY3eScEMgI3RY9xNbgGWOy7ftyBqsUpVTsIKPeGnQD0rua
	COh+4w5CtEGxsRXPYvtTZhvTcqWCmt0an9hdjViGrty6y9YKxHENVNJb9mtP5Qx+pNQ==
X-Received: by 2002:a05:6a00:414f:b0:87d:e8a0:2389 with SMTP id d2e1a72fcca58-897c6a2ed8emr11225926b3a.21.1791963836232;
        Wed, 14 Oct 2026 00:43:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:414f:b0:87d:e8a0:2389 with SMTP id d2e1a72fcca58-897c6a2ed8emr11225878b3a.21.1791963834667;
        Wed, 14 Oct 2026 00:43:54 -0700 (PDT)
Received: from [10.133.33.181] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804ec645sm756056b3a.43.2026.10.14.00.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 00:43:53 -0700 (PDT)
Message-ID: <43e6dcb5-9735-4e1a-87fd-506ee431fa2c@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:43:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5424 PPE support
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com, horms@kernel.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com
References: <20261011-qcom_ipq5424_ppe-v2-3-8c7b057e2c43@oss.qualcomm.com>
 <179181021174.434549.3754588049756407155@kernel.org>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <179181021174.434549.3754588049756407155@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfX/hO51RzfwffB
 MSr3WKwkvSDiVAgtA/bpfhPNfxEL29YV5kAY7vUP2dMt3cosYJr6WpplXvQrFwRwo3lZXKEDnNR
 NfRYLZKcWqw4z1d3nlHevHvpiZt5DGstBlpdyM1fb2OWqFpHAdbWq4Fyql5T/tBN1vzmMcxBivo
 9II2VJJjC8N//mFDdLLiXayZy4r33YshFT8x+ljIOwz8Q0Yn6ZmKB9zzYbqGlcTLObXqVdwfsyC
 Sc9K5bX+HWw8EMahKRp+HVHqEyhIAtPX4Tir6DL3LCI4kso0KNKbPG7PKP2l9GR05M0Vmqbzlac
 LSJfiQ6hnLqXHhYGKdHQJ/xU085tHpLmwpijDM9D275UzxfJt2e4mBEjVc4G9QD7TsckfSGNGXr
 d2+7ZbWqYQB4zgSye1OK3BHA1xMgL9qCf9mdrWxxlTxkxuJpiy4hLZDJ2xYxVk47R/n8ZAPECJe
 UhEOF6kYAXQmoOhs7ow==
X-Proofpoint-GUID: dUy2xmTs1Y7fbMnqOyU9_51Qt8AOeTVc
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acf32bd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EH141z8j1nZSuVZU4S0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: dUy2xmTs1Y7fbMnqOyU9_51Qt8AOeTVc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfX7D3ds+leuokv
 9IxYZcLOinnSE3UbqrvFn/7F/jt9bp1CmwtOBMpYZrLUTuXCJtazv/39jNeyE9S7iy1auuWuV0I
 xGaGqfNBjaLTBQ7D/fVeD1zm8jbTrQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140030



On 10/12/2026 9:03 PM, netdev-bot+sashiko@kernel.org wrote:
>> @@ -182,7 +179,7 @@ properties:
>>  
>>    ethernet-ports:
>>      patternProperties:
>> -      "^ethernet-port@[1-6]+$":
>> +      "^ethernet-port@[0-9a-f]+$":
>>          type: object
>>          unevaluatedProperties: false
>>          $ref: ethernet-switch-port.yaml#
> [Severity: High]
> 
> The commit message says:
> 
>   Also match all Ethernet port nodes, so that ports out of the supported
>   range are rejected by the reg limits instead of being left unchecked.
> 
> Does this pattern match all the port nodes the schema accepts? The
> referenced ethernet-switch.yaml accepts both spellings for the container
> and for its children:
> 
> Documentation/devicetree/bindings/net/ethernet-switch.yaml:
> patternProperties:
>   '^(ethernet-)?ports$':
>     type: object
>     unevaluatedProperties: false
>     ...
>     patternProperties:
>       '^(ethernet-)?port@[0-9a-f]+$':
>         type: object
>         description: Ethernet switch ports
> ...
> oneOf:
>   - required:
>       - ports
>   - required:
>       - ethernet-ports
> 
> Take a qcom,ipq5424-ppe node with this child:
> 
>   ethernet-ports {
>       port@5 {
>           reg = <5>;
>       };
>   };
> 
> The port@5 child seems to match only the generic "type: object" pattern
> in ethernet-switch.yaml. That means it counts as evaluated and passes
> unevaluatedProperties: false.
> 
> None of the PPE port checks would run on it:
> - the reg minimum and maximum
> - the IPQ5424 "maximum: 3" limit
> - the required clocks and resets
> - the ethernet-switch-port.yaml reference
> 
> A "ports { port@N { ... }; };" container would skip all of the PPE port
> checks in the same way.
> 
> The new IPQ5424 conditional in allOf uses the same
> "^ethernet-port@[0-9a-f]+$" pattern, and only under ethernet-ports, so it
> has the same gap. Later patches in the series don't seem to change these
> patterns.
> 
> Could both this pattern and the IPQ5424 conditional use
> '^(ethernet-)?ports$' and '^(ethernet-)?port@[0-9a-f]+$', as qca8k.yaml,
> mt7530.yaml and lan966x-switch.yaml do?
> 
> [ ... ]

The PPE ports are Ethernet ports, so this binding uses only the
"ethernet-ports" / "ethernet-port@N" names, as required in the earlier
review of this binding. The PPE port checks, including the IPQ5424
"maximum: 3" limit, are meant for these nodes.
