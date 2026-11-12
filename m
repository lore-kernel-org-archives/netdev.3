Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476025;
	b=eiQ6V1HYOhiXkBT0CkORJcUKFVmShzDjG+VJfjdUidMBIePP3hFfLADYVkj/pywGGvDj
	 mLpD4rpwN4F/dIR8HupuLippyLamxCkzFxzHIKO+Vw1AY+VNg82DOUFpMzvNDwkuE0pOV
	 a4RZPzbaD54+5V5ivmR0Oz21+X9mpqohxjmGSaev+177y5Z2h8p7M8Ep9DYv6OmJXvSjZ
	 d3Cu8/fgQNqhQQnmU5jLUpnTYjJqTdAtNM1qI8cFiKWOcQ56NHnisCvWc4zZHNyJ26ixg
	 VR2262wg8SxbNiwkCI99+n/+0KDruVmPBDlUTwWi92FAY27ngCx+UZzYQ4NNZv5wv+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iCHXDwClae4oFDnyJoawnDwBwVWh3VIIZGhH+xwjJ3k=;
	b=TUjGMsAUis7kgOBh/v6gr1cHy7gGoOT3PfUDaWwpCT/SBCrBlDzRZsz67Sa6Wh7xj1NP
	 YbtXImco/ijZ81nPumAH2PXXBlSqvtYSccX/BqB4Sb6lU/0GNq2zhOiAeaupAmEcrOXyt
	 uKtEG4fGAG9ILclM7S7GprX4tGgwG2GDdYGvTiU3NHw40TPsgURTfnA4uBBBUAqTlFljf
	 czBsaMGOuRlYWix2uK8N4ujvb6cZnf7s4fFHyN0HAsarpn6v4WjTjekKSQoYpUbz+ZlBf
	 87aeLBTF2Ie3CLoYXsa9oo7p6xgdsWKPdqC/0ZMstAV/xOpbe9ZidrulT2/oObuJRRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osA+UM6B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VZuxsT+7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D387606A33A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D387606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osA+UM6B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VZuxsT+7
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Dx62480117
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iCHXDwClae4oFDnyJoawnDwBwVWh3VIIZGhH+xwjJ3k=; b=osA+UM6BNguP8NUv
	I8hEASmlG4AHeys1KN0uBPHtIozTyZ4v6JhfNz8j7En4XqgiHU4VCoAhMUOFZBhp
	k2JfaVlJESvYgibKklGA+m7Gp5WYx852Nw765KdYrL/Id34tRM6ksKmXfvcqdN1p
	ZOOH86s8+ATr7Jwdos+9GXpABc7Y2iSI6TP77iJ6UCHmAVR/rIjKAuxYHNllre+T
	XVbSGAvwyoWC9WQb5v6wY5rUcbZ7j5QOuBnOkuN8CtROK7DcYyL7x3TalUK5l2AT
	taof6C9zPMOWcHiEJPkM9U4fsLDc9DwYp+Wq9Hlc6JejTHNg64ow7e2DE9pEcD0Y
	Tlg54w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4r27s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:33:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b930598cf0so5131875b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794476022; x=1795080822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCHXDwClae4oFDnyJoawnDwBwVWh3VIIZGhH+xwjJ3k=;
        b=VZuxsT+7DlIg/eOFppBPWMKG9i6N1yJmr3iIjOvI9tdxl+bVMI18ay3EHiD2y4HXAU
         cnT5yPH1Xq4dU98CVB/62oN9ASIxz3cyKiz7AeggxYDZmQfEDyjBQ3mzQoZg+RkwyvZO
         3e6FgpUKgRHTYsO+UoDck8mu4vsePzOtN70joXsOmHq8bVNya5HU2AWXuZs1IIRRXw00
         m8rSHrODCSqJjRAasGklsry7wtgsK80pQ1WF9DSSUOBPkSBRvnJKmK/8SshXxWJuJMeA
         LxoWe/1HhxbmU0ZxsmhDPaTfSC/cXpW88cKWCjQE2xTte1Ax4HUUNgUGqP5rWE+hEXzb
         KRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476022; x=1795080822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCHXDwClae4oFDnyJoawnDwBwVWh3VIIZGhH+xwjJ3k=;
        b=nvTrHXhgdCJ4Xz8dkfZMXV/xbnzZz641ZJniCjxILs6PNorX7HBPI6GW/X6YeQtZ5t
         nD2r3gb6Mbwfc4Qp+tYKyz6VPUp6Emr+5uhdG1Q+GuAMJbYQtj1DFWkK9UQnXMKcpGZv
         QUWzHIh0i+8eJzHrFzjma+uuhlysA0DdzNOcTDG/std4hCp5rYsjyuGG0bFB+zLVfEMt
         M+26D9i+tytL9VcDygNZ5H2NUNmb0lVlYUz2Gk2In+18BGnI2ZfFSvqeMeHBw8tny4jN
         HDBgBSoBfgmjy878zHvOU5BUIXLwlZjgMjr3UKjqXPD9p9C4uhE9d6Ame4S135h8VxF9
         I46g==
X-Forwarded-Encrypted: i=1; AL+hErF3Sa4vskQOQl28fRCJbOmN7IUBWtcuWEi/IbHFfYcrEt37jPnEjkg29b488tppDdm6YBmcooI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lBgzHvaFcKqpRfAGonHt1zjH3pURHFfq2ZTsSPcxaxu0CVwwF
	OJ5FC1ACBTX5drG8IoRaAk+V7YmmuR8VYDXUajrJlsycrRPfHJUMQbs0kxN0HgfFThjj6mjRm9M
	4MEss0yuPY8YYn0f4AEiEOITPq8RyDZWhSz+Jl3XGfbxjqRqyjE1nVzR12O8=
X-Gm-Gg: AYBFou0wm93aWEU/E9JhL6Xq9d/1qOmKS3OpbYWAIgbuSTbskn0cWzyA2ZMtDz2f2e/
	CCeQY17ippBRdRn0ygCj/pNLf3d5XE9SGZD0UXjIuEedsDbSVhnM8HoDZYpJFnRK709jN7d+GXc
	NUxe9c4q885SL986Lpgj7GjVbVYe0vu49IuJTF9YRtEW0CC2DYSjRIGBpUsy4tUUif4l/sGeZgK
	Xu5fr2C+1bw3xc5yCQEYgJR2T7kRJ9yr7bmnOVR99rkn3RMr5LSD8qifgzSAdcbiP8yXiz/+QSY
	LzhgQDD5ZjxoUum350XzDDCMNAn+7CdNTAOWZNWQyJjzovcCHzVs995+7FFgUVVDiBRYNvn6F4c
	Asl40AAVG30skuaq7mYB8Bhm51jx3Jo/rXNpjtGPvKk0BbfgzBuqjoefy4hYxrIX1k67cUXv7DW
	Gr
X-Received: by 2002:a05:6a00:1f14:b0:899:13ee:1bd7 with SMTP id d2e1a72fcca58-8bc1c884c38mr5109961b3a.35.1794476021907;
        Thu, 12 Nov 2026 01:33:41 -0800 (PST)
X-Received: by 2002:a05:6a00:1f14:b0:899:13ee:1bd7 with SMTP id d2e1a72fcca58-8bc1c884c38mr5109940b3a.35.1794476021449;
        Thu, 12 Nov 2026 01:33:41 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e9dasm3224610b3a.34.2026.11.12.01.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:33:41 -0800 (PST)
Message-ID: <8d449b0f-72e6-4fa2-b10a-0e034e8bdfb0@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:03:34 +0530
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
Subject: Re: [PATCH v2 06/10] arm64: dts: qcom: lemans: Add support for TSCSS
 node
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
 <20261108-tscss-v2-6-d5f575010427@oss.qualcomm.com>
 <20261109-enigmatic-solid-sambar-ada2bd@quoll>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20261109-enigmatic-solid-sambar-ada2bd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BCXn0kgSAL4-5z9kgny6OG3Ie-yAXXsp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfXyUBuS8l3iG2e
 AiKAtEvlHAOcLs1pZUeaPysuQaWIZGd9LYLE3uSMCxGa5dpSuvN1KEYajV3Pn7lEB+IxUoO/s66
 enTzesTIMEyWlB7fr5xNT1BCvAOt5Vk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX9xt+9WuCLBJG
 UlHG6NfzTv0UAG2GITMvoCsp28Z+VE+RQ3SiFElmtF/R16DE3HxuNvfwK4oL/Dr/c2H6E0UUOM3
 UIIAN3RXcXhkg7OE3Rlnx3Fs5+UeIEj/k6BpWMjBus5d3MxuvR7jhP20ttg1YzHmxNVUE4CX1ec
 FfwtNNSpe5le5vNgPgKObAktAQ8hOLs59hspBuN7KRknHqDkJgitxrZWPfeRfflbYLQdKE4nbfN
 UMoV4lfDxGqxfjzMM7n6j6M0OsFwJMKZ2ND0pcS2FeM4BGNUSgUjypfbyHXsM6rQkefAHqhDKwi
 VCxcdVH9kYQVDz1vwg+oihHU+NK64vV7JV/tdl9uAN6eAokv1JVbIMxSgYsSI4HB9ztwskYtmha
 BiMEieUmnYdMqgfR3DzE/BD90Rg6b0FJ9kFODtPP7/AtGkIYnWhHBzVcM8giwUbWpqntr+3psqP
 xVJoEwtN9VGEDiZWo4Q==
X-Proofpoint-ORIG-GUID: BCXn0kgSAL4-5z9kgny6OG3Ie-yAXXsp
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af587f6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ClY4ILnnmydcLe65dWgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120037



On 09-11-2026 06:22 pm, Krzysztof Kozlowski wrote:
> On Sun, Nov 08, 2026 at 06:48:27PM +0530, Imran Shaik wrote:
>> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
>> SoCs.
>>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 1fdb72fa5518..4c76c820cacb 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -3022,6 +3022,18 @@ pcie1_phy: phy@1c14000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		ptp@1c80000 {
>> +			compatible = "qcom,sa8775p-tscss";
>> +			reg = <0x0 0x01c80000 0x0 0x2000>;
> 
> Where is the rest of PTP devices? Your binding clearly said there are
> PTP with one and with two address spaces.
> 

As updated in the bindings patch1, will add the ETU reg also by default
for all the SoCs, and will take care of constraints handling based on
the "qcom,etu-slice" property.

Thanks,
Imran
