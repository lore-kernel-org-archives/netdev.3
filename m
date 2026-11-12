Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475949;
	b=gYeRJfbPnfAOZ/fcn0cKaApiHUQKOASsANRUo4f2NePIbl0eyD31BbxEmTI0erwvSmKw
	 /j1O8jl+FepbTBNxYfAqDcnV7EqDdtdPU2+qGlDiYU3I/6y4ZFvOV12mtKBTtJeAYwLPA
	 f6aaAGb0bS8tdXXKaa9LrZGf+LWN9L6Ecb0uGRxq9IxQKcN5ZLQUDeT33H5pU8kGW1lUr
	 fLAEgRe/vpe+6bM8eUOT6uaFqzQ2lcGqoKZX+cSA4F525RhvuofH/ouYv43rLI58wHi0B
	 sC0UTLXOHGL6sjFcDZgGi99Kc/9MuCyzL9IgqzOiTD4/qIHiSZwMuSq28yEHeMiXQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OOR9CZ751DrXMTQaYLwERcixWRWhOaaQJxaNRIejM+8=;
	b=0cl/Qe6858W8CXsJL3WWCBhhygELuhYh7ReAzHoZqnv4ZjV2Siz4bqiLuaCKhyYPMAbb
	 8P9p19JOUss/mntOxHzXBE2mwHwgPt5NB7W4wCP2R53VFTUHTVufhE8E4y0ZoiCOT9WSg
	 4l++krZB08EyhU8x+2fUYt62Ksq5QkWvb18ZMMF/amCn+bZfBqtgse3c5zVJvywSAz5dQ
	 UeeWlnzlh27UnF/L444qG9vysd2HcjSpOJbRyFMFPm7nd+uvx8XKapgmwr41zG6lY6fER
	 ziuoLLTuml5yfHVkIbLakGzrjbIIydDHQcOHDdWxEESarl7wC2T4ZcvUpMNoUHgX9PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="VmF/cr7R";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HKHiWxFl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DC606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VmF/cr7R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HKHiWxFl
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9GPWQ903665
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOR9CZ751DrXMTQaYLwERcixWRWhOaaQJxaNRIejM+8=; b=VmF/cr7RgX5IKly5
	nB8ld7K5D9AzKUIOEugReBYCnCvRZHnKq8ckwwPd3MdCpgn6tDd93WdjDdaA9b6E
	l0WSMXMRdGhMoIrK7QPZTPN+yMR0023gcBHh+rvBynvJ6qVGJarBEd/2K6ZAWKcl
	DHi3lT7Rw+HeUI4zOpJDUzpLh8wrBibWKeYtghBDeSUwZ46uA/eFcxHiB0sK1pwR
	DYEhD6popASG7J9wELjVH56JMoJgHLIZ5uDiOiSzXEzXW4T4vJilMgZ9OWfhQ/3i
	nfMcHwtge9Ud3f8pW9WhIPlx4NMjYvP6zLErMZjKSranHj4kj8rXupXMGGXtMg4U
	sLscUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1uby4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:32:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b17b31c3beso1895485a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794475947; x=1795080747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOR9CZ751DrXMTQaYLwERcixWRWhOaaQJxaNRIejM+8=;
        b=HKHiWxFlkYv80AquZQMGd2DhrkssvCgE8nBFesdbIC84hbDY6DRytHx2g7QN8sgehI
         j1ypV02/EAAHW+mjBChHjWW180eXdqeplQIOGbqW1sNrbQpEWaX/gOYIqQvmVm79dXYL
         xBllAV7Xhy+bw8Njj386fmnrPp82OMm9aX5RklllWln3CKmI2P7Ph8npDq6zEVa737q+
         n4O0PjZM9Np7viOraOU4KdU3VZJtkIUjsn7tjunpufRXyJXp9GL/DzYxbkM7LCa3qRGp
         hA2b6WCsyW1FJTxPZ8ekmbQwjgR8OGZJ7eAI+u4CVKUCDom3xAkNqGOJSSTzxcXyBhfW
         LKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475947; x=1795080747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOR9CZ751DrXMTQaYLwERcixWRWhOaaQJxaNRIejM+8=;
        b=18Kf6wu9ic9hKstgIk2g4Cjzt1MjqL8h4cVTTCnLGDOEGD5TB8i8awxEP51RsqGG6Y
         62DNvW8B5RiKXn/3luTMLybLaEAEXIE7d93PM0tac89b32zMddVGiWKuz4c9bJmNDk96
         kyX84keaJdfUMstFviME6dtwCZ71YkHeoPTbf6217zyImRWkvVwJF8K0uNAmhPz+Kt2L
         152iz1T910VON4HrxatHOP6jYdgVciPw3DyURVjW+/BnHqU7d23CZgPC7p6AVo3F3Qr5
         gl3+x7IQlmT+GGL3tNUcunTrR67XXEBgJL7q+TOwb/ZzO8ErDlpz0Do8gcOQ1tUhgMIY
         75ZA==
X-Forwarded-Encrypted: i=1; AL+hErFJ1HvRS7jg/NKXP44MxvUowezxPe7FDH1YTK86Je6KKhecCVnwiZ6oGI+caq0UlxVOPKxwTjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HVned/KCEMXtdV85KoKCvqdi9/iirifnTU1rPhfIfxcipeW71
	tisG7RX4ZwfIWNIelhJNkhdXeL+SI8tJLe5xaUaiNehgx6pWSkyENovI06vFDfsrJuzziijZZGx
	jQ6exgY51nlBFyKDzoVnnMfPR2tQb7R3GYkdlVmKm+S1uVHydiWc+urrAsNE=
X-Gm-Gg: AYBFou1bgDs4F1fEvMpCk6aGhNBfHbRyNU58cC+8yIUrI2yBWIlqpxTIFEQhtX8r/x1
	/CQ4d4nF9rPTG7/IavttNdiugouBatpFm3ILif+pR0wmR0CcwmV4GhQbNaa/9S60w8BwFTUHeER
	PesVVJnEcAmb3UISLu0As+MfGJJHfnbzEeL8vLt1SyGbmX5JWQvjnyqVcrqzxn734WismWNOc7k
	2ILiUTEzkKS2Kt9/BmSXS203uyan/BoMaw3LHJyFBjnF85mpMOfKaPLD27QemEIBGMZRFzPM5RY
	0gc++a+h8wUcUman9Oa8JwvX21JOK3gjPYhBB1QnfKTy4fQpgwyqchI+80jiuZ9NQ1cVaVCbtFv
	L01DC1GE0lQ2oIMdoeTosVqCEmI8HWZ6/xIBpsXa4tPt7lmpvgy8Bf4nmXLpHeSq2qzPRSDDdN5
	MM
X-Received: by 2002:a17:90b:1647:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3b182f26a0emr5088686a91.25.1794475947486;
        Thu, 12 Nov 2026 01:32:27 -0800 (PST)
X-Received: by 2002:a17:90b:1647:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3b182f26a0emr5088666a91.25.1794475946998;
        Thu, 12 Nov 2026 01:32:26 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c768e8sm3803578a91.11.2026.11.12.01.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:32:26 -0800 (PST)
Message-ID: <28202f96-f234-4c7c-be6b-3019e119bb0a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:02:20 +0530
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
Subject: Re: [PATCH v2 02/10] dt-bindings: ptp: Document TSCSS hardware on
 Qualcomm QDU1000 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-2-d5f575010427@oss.qualcomm.com>
 <20261109-sticky-caiman-of-research-65e9a4@quoll>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20261109-sticky-caiman-of-research-65e9a4@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX+EX+s5Dfam4M
 HI8n91pGEFqRVXi0M61+ZwEvUs8GwKqoUA20yFhuci6uAUUTO4KT5OqFfZSIr3ys2goXxLnjFJO
 RfMaibfhpuBr1yKZF2i/fTJuCWpWe/w=
X-Proofpoint-GUID: ThYZj-zeR2jqpxH063avlZ9Yy0p5USgZ
X-Proofpoint-ORIG-GUID: ThYZj-zeR2jqpxH063avlZ9Yy0p5USgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX9LU9ShGt94He
 jw6DiJdfg+jCsO2iGGvRP7QRa7/RvA04MNxtUPX32eQd572Wsx8+TehPRLEjCpqxMksEWciQS+p
 3LzsxE6aOj9x+uZ5IPfGXDUeBJc1tSKua+pox6gQojY7eGevdU78/7+OY76TG9W7HuHzHubaHR8
 vdnpmqQ7lE33NPEH9Kl6nmHusp+BLza6W5R25IqwxMxzm8B4tGuRhmYgf5ArMIblFJbPwxgqn+8
 PfGEg7KwYH2j8I8+Sr4GmxbdBfNPv+c2dMYL7vcw/qQFvkBBFVS4BMUJkKedk63GUn8ZXYfk811
 yDatwgVl/GEULvseHrKxfZ+4tonG1Xi+LThx56D/jIFPaEiaKTbXM8nfxrX9+7rzVa8JH/KwZcz
 VbMwrQE7mSy9FrlICdsU6pm+DOLxm0f71rYmxVJvlE0ZTxplkiN18SrE+26+97bw1/lizqXLguw
 buOn7d6hZD0iVBlzxdg==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af587ac cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VFrjYgP8P-MpaLTDB6EA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120037



On 09-11-2026 06:19 pm, Krzysztof Kozlowski wrote:
> On Sun, Nov 08, 2026 at 06:48:23PM +0530, Imran Shaik wrote:
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
>>   .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 170 +++++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
>> new file mode 100644
>> index 000000000000..52a063ec4b78
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ptp/qcom,qdu1000-tscss.yaml
>> @@ -0,0 +1,170 @@
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
>> +  blocks - the Timestamp Counter (TSC) and the Event Timestamp Unit (ETU).
>> +
>> +  The TSC block is a timestamp generator that maintains a running counter used
>> +  for system timekeeping, and is functional with just the AHB and counter
>> +  clocks.
>> +  The ETU block captures TSC timestamps for external hardware events. Each
>> +  ETU slice binds a slice number to an external event selector, and
>> +  generates its own interrupt when that event is triggered.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,qdu1000-tscss
> 
> I failed to spot the difference against your binding at patch #1. How do
> they differ?
> 

The ETU interrupt wiring between the QDU1000 and SA8775P/QCS8300 is
different.
The SA8775P/QCS8300 share one summary interrupt across all ETU slices,
and the QDU1000 has each slice with its own interrupt line. Due to this,
kept them as separate bindings.

Can add them into one file with an if/then on compatible if you'd
prefer. Please let me know.

Thanks,
Imran
