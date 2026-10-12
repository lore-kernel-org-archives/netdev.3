Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09647C0EA
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814290; cv=none; b=edByt6o+0ZvZPiZclFk4dBanEgJSRVhz/kps9nnEfAqlLWnU8cFtF7UStiRxsQYGo3lhvr6oGuJu6N9UGwpbtt2Jdgq/UsUVCf1mbEehgGCRItqygQOZe63ZIPUTVxDpoOnqzLQyyOlP4GFgQMRAHQW9eOhCx6Q1Kmi6BN5/qWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814290; c=relaxed/simple;
	bh=UnF3rL1aBzd0WE2YVJcayU8K+KXqubjSqN10uSYTnKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZqdrVEmxyc1KxwdSH+c28TqeLHvVTffg9d89MQqMcnOjmLxQQzCQR669fN5YpYtTuledQIbxQPXulNfbW9fG9QGwp3r17d3rRDlcOiq5Bqc/xzvfYXiST2orZQULx8aq+MzJVbaQ2I6W+sAv4xt3AInDMCgNmyQrfIXrXGTaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cB7ViqXi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EA8ftLJt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cB7ViqXi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EA8ftLJt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC0CCq2275959
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vV0F9WzzjHc+sIpBrZvrViKNuz9fOg54zErptNldCF8=; b=cB7ViqXiOh6NzTSR
	fcjko0xLtwWVPMYd5uUkzpB1Kqn+zkoBkLf3toUgqWeXCvVrxFjy8NJq1LXBg7y2
	lRUoyRRuiYMYPX4pfhMeIeNH718be/9fS0KwhkpZyxD/nxCaGHycrxHodQjLI39C
	zEDEv4qSf/2knbUCA+TFlWoz+pWf+jVvr4nGv/2bbMMBxeYQ8Ef3CKEs938z3rwS
	55HntnqV8WcqvSoLpnzkkzLt0S4BQfT6wqMFyoBvB9jXc5Q+dj53QBciyWWuZe7f
	dfgA0FuH9GrANgRgHkb30grgmDljMtQamv/qAFiqfiJ4FX30FjHlp+Ye5rJSLqX2
	jMhYvg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq1qd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:11:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c01f3ae4eso83146eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791814288; x=1792419088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vV0F9WzzjHc+sIpBrZvrViKNuz9fOg54zErptNldCF8=;
        b=EA8ftLJtq8l5vJ8H24jRuyPtwT7wP3wuAMi9KIuGGDCe3oMQDtx2jkrf+/rYu1TBPR
         VDsvAvREcMnrB1aqx94KBMp1vBYPXL0F1WCJ8ivhyeC8bhGd33HvnCrex2WHw0+IMrZM
         4x/hsmXObtEx+RiJ/AUdOJYTKLOjO+4nxEi6+i0DV4JrfVbsb2Jm6pBJIIBYR32BVZpi
         RjautVxCGxiExu4Wc/MN2hd9l0aO4NiZHRICwWlOsYh5ePtqKvkqUbXe3wB8F8yLFJKt
         LP2RRO8Oh7GIoW4+ukA/wyOQw83m5ipSMPAwwQqL31zvNfkqqMP1VTp5PC6LAgdPQoQ7
         IoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814288; x=1792419088;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vV0F9WzzjHc+sIpBrZvrViKNuz9fOg54zErptNldCF8=;
        b=wSpxNeNz8J4r/LcvSOMf+1YsYqjh83/KO6iYbSIq8Zi/nT5VQtkpX1vwXEJnF4g98i
         RGKGLPmyMxrLNIwTx9jJ7kb4Hx7CB9zzDXSpRsb0qPbDezH3CFKWihXyBMi4cX5sgk6/
         kSm9BTiDpOuhINZWoYQPPjyNf+V/phFS7nWQie379aB8zBEi3E2cSt/jldpS2dPnsQG/
         zWG8CSHiZL1mXgFFHyscUTo22jUwREZIGZtGFdAXlQhRNU/mxuEdVLne/93OZ4D7TV1W
         3Ol+4H+1+iVIXDxolFFs0XaNcsAr1jmx1o0JzJzKldtDRootp1uk5Ge4d4Ct8D1pvZeK
         3SGg==
X-Gm-Message-State: AFq9FYICf2QViEols0trUNjytZrWFePNynjD/kn0TUVACDXP8+OSbGzT
	OKkAI/jlP+x+KoWyzPeaWd32AlMS4vFzAu7S2xZIpGcLeEeWtYiZFg6MNARKJ5Ij6ycB7PRqMFV
	m26N1ZJvDTaNLRop/r5Cegfg88fuej6xK3qGVkyyBPMDA1lnxQnJ06JCziGE=
X-Gm-Gg: AYBFou2rpUUmdZHSjNbKg2JQ8oxM9ioCXTRnMIOQQK085taDZIyZpkmxgQcsRiNvDSG
	RhPTKHQScm98icysSfGFYguuAGFmckmCIBFxF+zPX8RsCnnZn1Gx8AK7a6nNAwjK+l4TIAY4gyX
	0Ykg1AOYICY+l1oVKr5DCZ6WfFssS5RnlEsM7f1k/4g3141z16+/HNpe+1j2IwnXBivgVLxqpt8
	DCxm7YhU0sAuJ1i2S6OUmxPGmhcdFYyNHOg9EBNfQTXYTYvUG3pn7TBaj8FroIz/NvH/ZzBeO7k
	rmQMgnxb4NHsyRqfW7fY48MOiJJox8lllqefpSRGVv7Do18TrSpTWNz3LT2SPcc9NpSjcaJGjj2
	zJHyFA2ULO6qR8rjyG6T1EopRZE+JrWELOxB4DBlFsTmqdow5oNe1VpdEvOwV
X-Received: by 2002:a05:7300:2392:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-3537e0cd902mr22245470eec.27.1791814287588;
        Mon, 12 Oct 2026 07:11:27 -0700 (PDT)
X-Received: by 2002:a05:7300:2392:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-3537e0cd902mr22245266eec.27.1791814285401;
        Mon, 12 Oct 2026 07:11:25 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm35157578eec.25.2026.10.12.07.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 07:11:24 -0700 (PDT)
Message-ID: <52d0917d-49c3-4d24-b43e-d9321d8e1a2e@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 07:11:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: allow IR on a channel the wiphy already
 operates on
To: TangYi <1914018426@qq.com>, linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, johannes@sipsolutions.net
References: <20261012125955.1519379-1-1914018426@qq.com>
 <tencent_B6DCCE2CE592B4FCCDD65E6D07A91C4D6307@qq.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_B6DCCE2CE592B4FCCDD65E6D07A91C4D6307@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6accea90 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=dZbOZ2KzAAAA:8 a=MYps2yIq8nXn-yX_PDYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX7bUv8yCVuY3I
 poClRFZXxs5OhOvxXZG/scA0RTlsvZyKUNABOj2JTQFH37YlAU6dq3zQqY+hTYl/4Im3ZeiMmfU
 MfkOaz8Z/8uhzgOYV/2c/owmVxs/RK8=
X-Proofpoint-GUID: wWfLo8Oq3muC1GRBgnW9ZKbJ12ALUre6
X-Proofpoint-ORIG-GUID: wWfLo8Oq3muC1GRBgnW9ZKbJ12ALUre6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX4tMsCb9jgVZ8
 2GoMFDHfdew2T2RrTm6TXLZVRZegmTUMUhhIvh19Px57E+f+2dF6vv1GrvknrWL/K2km8bih70o
 1bu7GBjLLl50LXoXvoxc/XMuaSHnEUbYR0nqupHFKIuDe2FDSZEizY4+3GRHKa5hSYw8XG36/Cj
 3K1EaIcL7Af/tjmgLbTjDRDbOHsOz4q3ELCMXFZ84CUu1EuGubzrjAVn3YCrfqZpGUh+vC/ofoW
 MGx1Ly2JRyRSTi6faao9qWK/PXnGbA9ryY2mUVTFiMW3d+G53Lx/WiQqQFwA9x0Ce2CZcz3x6CG
 SKaUA0Tn3Dh7upKblpx7h90p9i0E1YRbhE26YSShKdklBfQn2AhY4OKLqZifVwDV4DJkAAwjBVz
 bM8w89eEA7x0muJXgAeje8CG8q9ZcTC86Pd0KTLjj6eWkYmItrKu3P3z5VowEJO3Co6xJDIde5n
 ziRbIW/iBAnw65DXSIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056

On 10/12/2026 6:42 AM, TangYi wrote:
> On Mon, 2026-10-12 at 20:59 +0800, Johannes Berg wrote:
>> This isn't how regulatory works, sorry.
> 
> Thanks for the correction - the "already radiating" argument was the
> wrong frame, please disregard that reasoning.
> 
> Let me ask the constructive version, with the concrete observation that
> led me here. On this iwlwifi device (Meteor Lake CNVi, firmware in LAR),
> after the station associates on ch149:
> 
>  - iw reg get (phy section) shows the learned domain marking
>    5735-5775 MHz as IR-CONCURRENT;
> 
>  - iw phy shows channel 5745 with plain "no IR" and no IR_CONCURRENT
>    flag;
> 
>  - and the iwlwifi source contains no IR_CONCURRENT handling at all.
> 
> So the domain rules and the per-channel flags disagree, and the
> reg_can_beacon relaxation cannot trigger (it requires the channel
> flag). Should the driver be propagating the domain's IR_CONCURRENT rule
> onto the channel flags once the firmware has a usable domain? Or is AP
> operation on such channels simply not intended until a country is
> learned?
> 
> Happy to take this to the iwlwifi side if that's where the fix belongs.
> 
> TangYi

off topic: you need to figure out your mail agent since this reply was not
threaded properly.

It indicates In-Reply-To: <20261012125955.1519379-1-1914018426@qq.com> but
that was not the Message-Id of either your patch or Johannes' reply.

