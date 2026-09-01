Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A062F616B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244322; cv=none; b=Ulk7FeBOGzV3YFsXyYMW6ROD00KXygOOd5QgxshUcK70bkLbPvJXWsWPH4zmOjGx2IzZwmqzFfAQ4AeFweUZmL6fPwaVI5E26RFzWq06rHDOHVGUYLSuUaRfQWo+9NIKSc7bHFoaujxhp5s9vpiUbEnSfIV0sQu3T9EkjQ7bppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244322; c=relaxed/simple;
	bh=dQ8SLE497iwC0DArYD177oqNcp5Fug/EARLixjeSte0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X8IT/RRXIBkift2B282AVZgK/3+eAKKKs2XyRcLwWU0jk4tyDc1CXsTlM7xSM59V72VCbNzVQyFXkAjvcr+lRzUQDoeIWsIewRdsQuHGvjFX2qwVpVzbNcs3CV9rpOta3nBQG6ZnoPmSZwDka8zHmG/FzRKnFjOGb1SQPzZwsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pH8wtk0h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JGuPtHtL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pH8wtk0h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGuPtHtL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810oocE979001
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 06:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6cX5HNKxIBAWwbUlALiWmXjsVapEiRZSrc2PP6beZxU=; b=pH8wtk0hyAhoI306
	u+ULz1hrwveakP327Goo0bRhCDredi48wX2KfEAMyYZckB6Rqb6fECslMSSG3dy7
	GOOxKeB2vzoY52/nQD62I0a5Wsu0xNKbG5/k/PRNQSMfvs109bZX838HZG8LcTTj
	j8CKy2jc0FiH0NsKSg7W16mRYzaDPpuXsVJcNLVNiHPrUuR3JVpVqp0cOkaHvip4
	Z4C8eiLtfRSvS86BWjNslo61UBlU6kPfMLbLcUXP28Rdm5FIUO7hEEbVamYERxSl
	RujrAVdQEpHJRi2F/Cp6QszApeJ5aYMdZQEywO2hxnLgvHwgR4elbltat3My/EgN
	NnUAqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dua0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:31:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so864170a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788244318; x=1788849118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cX5HNKxIBAWwbUlALiWmXjsVapEiRZSrc2PP6beZxU=;
        b=JGuPtHtLJUfWV3X9rJ4+dkt5duBqOAfH7/Gu1QB7UUmmiaw1sx2fQDmr49HAO3nWs1
         bFtTi4JTzuK80INAj1afLNBF8phIhe+FlNSYO2FqTkWE58wKWstkQ64T9MyeKYJWZZ62
         qKCoFZ+P8gytShkHAf4g6tQWf98GnsZp5r0IJTC1pNW6qSTrd5tbnXgxKACYxo59+zCw
         eUz/C+0649X0NYwkLR5d0+64X8fG+TjAO88V3ks8u4A5JN+KyWZfjuzlDYrrJoquXlHr
         mtHVwgAu3/9S8vhjXfx09dJWfhXQL0CUygN6qBiFPQJKm17SxJlvqr7EzjHATuzY6Huj
         NxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244318; x=1788849118;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cX5HNKxIBAWwbUlALiWmXjsVapEiRZSrc2PP6beZxU=;
        b=PvSO7kiV5e3oho5T7ah0Gu/EkdU5apqzI/aEbzmHpezN4wSeQZmVPizdR8RVEZ4zvC
         SPxPr2Z+wNYl76oGvzyeeMbB8mTgN8GNNnq2+OF3iTAuXPrV9qCiIgmX81uPY0Rd+N1C
         Ci4kirJNOS7jcPhvXL4X/lPnHS2Ts9qDrc3/Z8XnuuLIeNWrGQG6KpV4sBEVOtfYQqSM
         PKqNjlEMB1D4oa+RVfnVRkCn5WHzwNLuiL+682iPw5JPSeoV8QJ51YDCa5S9Gqh6gZiZ
         N6c2tuR1B8jVUm4DjbQDIdy7yJH/vjoxGW0DRBZIGcugF9xUqoQg11R75q+FpEz/XOcn
         K9jQ==
X-Forwarded-Encrypted: i=1; AKwUvBztd3FErxmfFvaDNeQ5IK6PeFHSN3R2aMz8kLPtOIvC9/fVLGqPYPQlKYXvD/HPRSEUT1hc8KE=@vger.kernel.org
X-Gm-Message-State: AFuF++kFa/+NNZx+Z/Ja4Y3p4SsjmYU99EAxl5Ko4peYO/mhcIDh/i5a
	CQyH+30Ydc059ZR1D+NJzcY2k8IRgfpI0LFon6FrXmney78gB2XWbpZNRYspcZJRTcgWkohdR1e
	GbjBWQVkY03+EX70vLUMCzPAe5EMVfIZj8ACSMkOsDT9CIYT87Xow6B/s12Y=
X-Gm-Gg: AYBFou31ZXxiZets9HBZgHiF3bgAXlK6/O+ut8se+w5q6Cg+ZOfMyfC0+wpM0pmQSkh
	0K8H/s5pA51rH/A7Cu+WBr22+i86mSInsDN0ouJvCA+jaUb3MUS30P7A2z3UHUTraxGUQSgNWXk
	MQHumWpF7SVJKbTZ+PsW2391wMjs9sF+3O6ZKMm/L87uBy1DMr8Lc9nMmm6r+Y8E19NnYn/6PVp
	AZ0hEr8OqxcJZSPz+7V9w2uTaUdJ+cYdOloAMXFBREqoj3m10zRif1Fc8G69/bGTcNeA9N5+2d1
	7d1JBqnxuIR+KaWC39WvE2WvZQvlwsPOpRmMfjUunENL7xRdU/RMPSYPSV5T51d1GsgS3P//cJ/
	vhVQB3XIq29nGJklSW4VpsLmOXXV2
X-Received: by 2002:a17:90a:da83:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-396d0de796fmr49247608a91.4.1788244318093;
        Mon, 31 Aug 2026 23:31:58 -0700 (PDT)
X-Received: by 2002:a17:90a:da83:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-396d0de796fmr49247516a91.4.1788244317572;
        Mon, 31 Aug 2026 23:31:57 -0700 (PDT)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm34010711eec.23.2026.08.31.23.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 23:31:57 -0700 (PDT)
Message-ID: <87244cbb-53b4-4deb-bf91-d5570879db09@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 12:01:50 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: Re: [PATCH 2/6] dt-bindings: ptp: Document TSCSS hardware on Qualcomm
 QDU1000 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-2-beed14e72510@oss.qualcomm.com>
 <184d7977-891b-4d18-983f-7d23a7d9ff83@kernel.org>
Content-Language: en-US
In-Reply-To: <184d7977-891b-4d18-983f-7d23a7d9ff83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a96715f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VFrjYgP8P-MpaLTDB6EA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA1NyBTYWx0ZWRfX5kuDzVvCTBb1
 CW5uvK9BKl6XwWi5dw9YQIUsI5MN5bIbWZDPtcAkjcLUT/Z+8bGJ+K2xyutfUtw2V9FJQyBvJEE
 NSAQ6lhYsibj6xDnyGbyBJb2CdhLMP6a1BQYpKIg5BB40736wmNDFRwEgqIjQSxcWnhtsTXMPkR
 l5xCuyeNvw9HCgIOIyEW0ujiljb7wsJleXSzfKDdGfaWy/C21UvyKTBw76ODSxrS6UJ7NKaXZZ9
 /Lj1KZiNdc64uGOumChhU89xwKlGSo6Q05SGtufhz4nPkKNA84DX50B+zVdIy2vruI7IBmijk0A
 vRSE9hEIpybRtUloLqeUDKWrn+oD9aPLSDBqZvhVDKlDvUt3nhjs6JNWcyyfnYz1+1oaD3y7FEy
 /+jpp4bDJn8tF1rm7I7SbQ0VAPoNnvXfyv7OL9GXsf+2q4qnxmKrrZQP9Gk5XqP7lsx2KGG4YaX
 nHP7+tUOlY5hSWSK95g==
X-Proofpoint-GUID: dF1R_wvquzbtL3DpcMZRZ-hARYNaotpN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA1NyBTYWx0ZWRfX3SnQoxRmDZCg
 hGVTB3eX8II0pVThfM/bpIwLrxmV9pf7MJ+72/BqMJT3w4Xovsx8ta8BlF19BppUJI6Zy/WRzes
 ZZHcVdg3y6193R18bphpEzkq8Yb+JV4=
X-Proofpoint-ORIG-GUID: dF1R_wvquzbtL3DpcMZRZ-hARYNaotpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010057



On 27-07-2026 09:21 pm, Krzysztof Kozlowski wrote:
> On 27/07/2026 16:10, Imran Shaik wrote:
>> Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
>> on Qualcomm QDU1000 SoC.
>>
>> TSCSS is a time synchronization subsystem composed of two main blocks:
>> Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
>> provides a continuously running counter used for timekeeping, while the
>> ETU captures timestamps for external hardware event triggers.
>>
>> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 187 +++++++++++++++++++++
>>   1 file changed, 187 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..39387614ef8939b7840df2f0d5640b9e142fb4e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
>> @@ -0,0 +1,187 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ptp/qcom,qdu1000-tscss.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Timestamp Counter Subsystem (TSCSS) on Qualcomm QDU1000 SoC
>> +
>> +maintainers:
>> +  - Imran Shaik <imran.shaik@oss.qualcomm.com>
>> +  - Taniya Das <taniya.das@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm TSCSS is a time synchronization subsystem composed of two main
>> +  blocks - the Time Stamp Counter (TSC) and the Event Timestamp Unit (ETU).
>> +
>> +  The TSC block is a timestamp generator that maintains a running counter used
>> +  for system timekeeping, and is functional with just the AHB and counter
>> +  clocks.
>> +  The ETU block is optional and captures TSC timestamps for external
>> +  hardware events, each ETU slice binding a slice identifier to an external
>> +  event selector. Support for the ETU block requires the additional ETU
>> +  clock along with the per slice interrupt and slice subnodes.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,qdu1000-tscss
> 
> Why do you create a new file with exactly the same binding?
> 

The QDU1000 SoC TSCSS has the per ETU slice IRQ lines. Where as in
Lemans/Monaco, it is summary IRQ line for all the ETU slices. Hence,
kept two different bindings for both the SoCs.

> Anyway, all comments apply.
> 

Sure, will take care of those comments here as well.

Thanks,
Imran
