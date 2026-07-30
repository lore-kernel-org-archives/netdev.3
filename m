Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448E404882
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409036; cv=none; b=TDULnLMaO6Mys0sWAH3hYUkfK4cm5f+ZD5kP8cH/hHemgZIxqx8VLCKSo+XPliR55GyTOZcNCPY0Ojv7flIzbIFeeygpfoJHYgo68TZfMYPktTqzZ0Wx1sOGMIagz9CPf46ZOjs3mUwgwBfXJjD1moTxet/LZhI8sknP8/kx8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409036; c=relaxed/simple;
	bh=ZPQPB3xBi/xKVbwZEUGRrv5xu6tvh+vX5h1M0oUIEzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLOWtYqRDEGUF5ZKf41k4YqVqba1NYlr8MoNxDlandz9Yx0Nb3adlvT0tNcxl1z/+Dm3AKB/+GKZvtQodcobgt4XboBcfsHoANlXGOfNFToEzwYnUmJ0JbqcvLHZcJ9jwzdbG00E5R5RgUCpUTDpLtLfpTqUZ6PQ/KVqrMmqi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UuPMJMvp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cq66/Ozi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UuPMJMvp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cq66/Ozi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2W7Q4191290
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSSgAkjVtZ/wW0D5KMiicODP9+dJfRMr/iPao2SGoG8=; b=UuPMJMvp/ZppRuvT
	IsBHIveztVxJwq5EzE4y03lTRjd5FmO1OzvDIdu+8v9Uhhk84G1buwwxfylzlNjN
	dWOUKnGYj6N92eAMoP8kqXUlcB0YcUHxqW/WZbK06hnQMLkF5OvAV6fcvSKDKt+C
	xF21myvTm9fxJy85+AbIjdkSRS0T9El8kIuo6gSDDRbj+bj2SXmph2UceSv2LuTw
	+r1BRmtLZdvuXkb2SAnB1BRK/SuUcaB2KxzqELYGStvqX/IqUcY6SBqnj3vSBN0i
	R3Ci4R8vAA0uOD1GxKbqWoMNUOukqbAmNwsSehkSnlqEaFa0jXBuFElPAtpL7t6t
	1PLtdA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3tygdpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:57:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so54874125ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785409034; x=1786013834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSSgAkjVtZ/wW0D5KMiicODP9+dJfRMr/iPao2SGoG8=;
        b=cq66/Ozi4msPRhbV1YC4AYckKS3/HDRhBM+YdqGjgTpjLPrpkKa+VqhZgcbiXPaakC
         y/+uwjQukwqi1V1MlaannBd3TlI5AeFIlUEEcCv3bezjP74QWYgLr0ogBUwzVqH0lSxk
         CcF1MFS7s5KskndpaGdwwaFE2bJ3ieRXQ1sQ8vmfmsY6YDjXQyq1BYFnKTX9QpEYiwm5
         +/kY9D2W8yM4hxlzjLR8FTKU7Pij0ad+mrViNUodt/8Xcye8iICEa9jtd2sg7TUY20vC
         LeIuaY4RTco89YHkyOFol1QEJ1zcjlcApWcNPo+iYrmiQJBF0dXZtEn7/NkvkvSlGtEQ
         e44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409034; x=1786013834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSSgAkjVtZ/wW0D5KMiicODP9+dJfRMr/iPao2SGoG8=;
        b=TX6qsxtdUw8xSp0hH1H2z6YhgEXU/SGifrCCbONBTqpOMWKVxndd4zzEKC9kPKcSJ+
         fZcSO+/W3nXl75gddiEwr9szYM+LJCspRebqO0cUxoUweMfAd8BXWeyKMwQrWuuVQtVm
         DudcBlEh8wHKh5Raq9At05YGSakULPlfyNwlDf3EI6gb/t9zIN8gzcKpJPINBj8u7eu6
         RdZZlOStyNobdoYhJfLEuveJtCOwCvmcNXspbUAKYbMqwOc1qugl0BKYmBAVXaAPIL2o
         IDft1BdNt5gJwDd77xO+ABT9KgRc/NeRmTsyf9D1lV0jtclRTq+s4OXPyr1c8tbdzVNh
         Q2jg==
X-Forwarded-Encrypted: i=1; AHgh+RpOxRfA90csNaMO5yMh24Qfo8DPRILr3OvlTRtQaMgPa+QXtXi9nJLI1NGHK68yZLsB7RqBrr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhKoA/5M+uN0+d3Z0uXNUA2nQINnOgwKkZIqaRrlKgHN9Z8Fw
	pX9zxa1zCdPAkTG/T/97CAQbsHIWOugEIdIs9sIMEUFrX1MPVQ4Cg15czAa83nBAPSA0A6RPYDW
	zaulUClQTGk8kiDslb+FRF3mC4Pj2dsgVcwXwXs/7oMHrHEB7pxzUFaYWt9k=
X-Gm-Gg: AR+sD13cV15wjsnNxAYnk8LDSvnqA7WUVAWk7f+ACUAXSxVakJ7T8lMW9pSwXGNYr0j
	kRfPRqa/8S/JoxhMNT9U5Tsx9/lJYVPVrAq6DBT4iqPfOh3oMHt0mk8xBq/pwBI8AXeMkBX0d/P
	cb5ZQy6Sy7wl7J4Iznu9TQx+M9JKPp4i9tHZXQWh42aQGmJ85ta8gMVxq1rQgx9TA3bW/5D3wSM
	SqrlVVagE+4/+tjTNqkFC8uMiQbXqzzCMEoKg8Qp9vcugbQB8KJbrG7RxkMQ2GqsOyPyUJuQyav
	6A+QbcPE203iObAFWbeegG5K0D4j19BtUsB2IRl5YSUQA0y3S3855DNlPWVwFD608YYNf3OnTaD
	JKxsACCEVbLdNThpxjUArs3ZZFHw=
X-Received: by 2002:a17:902:c40c:b0:2ce:fa3a:45f7 with SMTP id d9443c01a7336-2d035be39b9mr23128475ad.16.1785409033672;
        Thu, 30 Jul 2026 03:57:13 -0700 (PDT)
X-Received: by 2002:a17:902:c40c:b0:2ce:fa3a:45f7 with SMTP id d9443c01a7336-2d035be39b9mr23128285ad.16.1785409033257;
        Thu, 30 Jul 2026 03:57:13 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc8310sm25005455ad.44.2026.07.30.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:57:12 -0700 (PDT)
Message-ID: <6b52355a-796c-41cf-b604-ea866edd80bf@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:26:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ptp: qcom: Add PTP driver for the Qualcomm TSC
 hardware
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
 <20260727162008.2b93959d@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20260727162008.2b93959d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e_2atZqGoPrXx3WNRK8LPSsjURA8E8bc
X-Authority-Analysis: v=2.4 cv=JZOMa0KV c=1 sm=1 tr=0 ts=6a6b2e0a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=-goOgsFvLHZ0uZs3yIIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfXxuDb4C9LE7sT
 Gh9bGiygVD83jobOPVvXWUtpySjwgEZR26H95QJKANH1tl8vMK4mZtYXW1C77mNcqyrOi+8Dy32
 3LAW7uEJepe54ejQSe13yq9kfYAUXplx1arszBZJoQWgV/HiHDAcH27AnLs8e/HzwAGMniX8Jf3
 9qetxy8cdUwG0wykUUOI8QQ5kw+UC9bV8W+NlPVTRrQsKAT4wk3gRXT34EAUi0dL9aNOu38ctZ3
 7NeMkbz/eBu4b5ccEucRHwnNQV+g570hOz8RONWm95VeYGsZA1ObQ0FzZEQVfajQ7LYVIejuNvc
 YK9eInxQhzWOSZVAfCIrLfafV+hOMUsGrX3pxP9TRquAfVEQKbIjDZehtPTKUEvrZga5O3WxA7v
 kaAz8/Unk/LM87H3Sn1QkDrCSoUKu7stXk/Zjv+6stBFgpRTt6r1Q9xMpCH+4ogd4vTotlfvQoJ
 em7FrzK6OBIyVtsyXsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfX6mF8H161+36o
 laAERe4eLOs3GyDMbj4xXkROYzZ+HjPU4+EHI6eU+kwLVLtc9X5FPOvfbF+nDIxks/kxLjzje+s
 JJkReMwVDcvBlNLheaIcLaptbfVVEIw=
X-Proofpoint-ORIG-GUID: e_2atZqGoPrXx3WNRK8LPSsjURA8E8bc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300081



On 28-07-2026 04:50 am, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 19:40:59 +0530 Imran Shaik wrote:
>> +static inline void qcom_tsc_split_ts(struct qcom_tsc *tsc, struct timespec64 ts, u32 *hi, u32 *lo)
>> +{
>> +	if (tsc->soc->rollover) {
>> +		*hi = ts.tv_sec;
>> +		*lo = ts.tv_nsec;
>> +	} else {
>> +		u64 ns = timespec64_to_ns(&ts);
>> +
>> +		*lo = lower_32_bits(ns);
>> +		*hi = upper_32_bits(ns);
>> +	}
>> +}
> 
> Are you sure the compiler doesn't inline this trivial function with 2
> callers even without the inline keyword. Compilers seem to inline as
> much as possible these days.

Sure, will drop the inline keyword in the next series.

Thanks,
Imran
