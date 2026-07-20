Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF62427FBF
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557291; cv=none; b=KzQR6Rw3EX+rcamTlFTGx5+z2io08qKyLmdC169lqURt/f4AeEHSCFEiT5TQ7KBg7ZOkjbC+cMtawfB7iNo8yfDdsuxIcauyShRa5mhIpQ1Xg+p3vc7mfjh/I7dMQsPIJGz91twqpuDPKFcSKCGEpFhwl7sITncbz9cFi2IG7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557291; c=relaxed/simple;
	bh=FbNVOT0zjfOFochT42IbJEGWm5ppzHbSsO+Oke8RL9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M17J/w3xrYPw1BuXGdJxKXa5v4tsWR7a6lm5q5s2uCGjFT+Ec8iHlPB5SIlyYNsvYYC7Jr981EiSLoE9cOS0vYK3XFNwk8rbH0cpXZf8VJclyVX/OnVZY6T+PF0UVgvK99XsP6lTUlPiTRRQFTg6AIxuFIT7TQ9h+239cbySfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNnJquPw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ww2bc20g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNnJquPw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ww2bc20g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDrUFo2329130
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp97wjloZeXeCV7fe4nxHbSXC8IefY+6Yaq1KnKIS1A=; b=TNnJquPwUQfp48Xt
	zBXJUB4zfpQRErnLs+frzlE6z8YB4++0NM+Ht7DuShMGQlwHLhNn6WeRu+G3AakP
	oXyVaXPx2hhD2mH/6r8ccOuQC0MN7GH+jGUnQYJM2MSJXzdsR5uUNlmJxV54aEam
	Dtn/B21zsd9u9fAof9y06dD7E5VNbVL6lEMG5WJuH5EvY0n0vgsr2svddvqa5dFR
	PCCMLzAcNh8E1F25ws3ezS/vGOljWXgddQ2Sf0Dd0IiBCGWik8XG50rTZsboKdVv
	t9RvC2t+G/8sPd7CTU6vf2u/p159TdwFLzZ0ZAxS8XCOLCAf5b0IvKn94e2fEMLL
	O9m2LA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs51a7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:21:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e6415f279so145030085a.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784557288; x=1785162088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp97wjloZeXeCV7fe4nxHbSXC8IefY+6Yaq1KnKIS1A=;
        b=Ww2bc20gZkdVqgZ2YL7nKH/ZGdRVetWqdU61KlJRJCrbdguvm+oqwrGObIQRzhP36z
         /4aYcGQjdqlZ1MNiJYuz4qFbkUCX2Tgv6zJSS7Ae2t7xCoAu21dKb5JdBVUodL4UNh/l
         XEmdrdE+ZwZW9x7Ga32hUNw127JyuaM79fncrqEDCAFMvn/8/fRnRNEankkTX8ZKuzTh
         aJAAP/0ADSVaANUFtVXIB1ggVZ0HLtMLHNo7UrH1WP5lsaeIok0o4GJjfaIiXnS5yWEU
         z3M56BK++zDAnYa8a0ZGSsqCsFD564vo35ggliF/rV9UwEUX/M+dQIgWeQorwn0ZiSIs
         YEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557288; x=1785162088;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp97wjloZeXeCV7fe4nxHbSXC8IefY+6Yaq1KnKIS1A=;
        b=LdkWDRB4FYz1QUOnLEe+gmmiysKxQKhDnHpFsSER+LgvfFLcYQ7a/L0Sp1G/qXZWbY
         P4L/jXeFucEJWXjLK91gaW794R/wD71iXIrBgEl1zC0aTJA8P4qwCkXyDVgtXRTewOMu
         Rddj0w1pWWNMgMYyZTik5Dv19C5JZS4V7JtR3a8N61XYXVDOqWwPBhqeFPCkObQ7z2bM
         TgfvbLlvUGuVliWpNfmU67GxavNmgfVLrohDpTAbPXVGB8OZq800SlYJCWSVnywB9k3X
         Q1eCNC2I5Nxa4PcZXBjm8Cld3OAAOEZ7UWFVrjw98hyPiWh4Bx4D+QkSju3VA93eYm7q
         Vzhg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8HhQZrtDULOzeZ0imq+13I6DUyO0Ap+Zm0SENF/CkxdpyUHHA81fI/qF4ijYFfrENrUbh1OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeIdClssg4skbLrHq4QKGsndLg6zLkh3bsLwpq3k9W98QryF9
	MpVAqaMfknRauBzCBX3w/GA2sil2cUOC3C/Pi4rjefx0eWjVn01vNzgxjXjCxFV8wJDZpfkvUPg
	o8o6snO03iwVHuQnruiCt94amqMuY1qj/uS3/uzwpkbKn2bxJh3DKY3KyUVo=
X-Gm-Gg: AfdE7cluFysiu6KbeYfYRx+Kn1DHIRqkh6+mv8+nb+/JqFDF3vawpOkzFvD81zl1h11
	5aDjBip2ZinQ0VS6DZ/v1NVlNy4aS467bqKqTmsizR0vOriLz+jIKFfWYsFM1aNgzZHhUrv1j2H
	EPUiUoq2mEcFteLe3sp/mVonOhhNtp7HovHYt2o57opjcRUCuLFmcZc2whgehzT9395R/bg5KiO
	YZ05wfiEPvgyNt8fbKB0wtAKQqWKU6uo/7KdBoByZ+/O0D20ZMgZtfDxjDRtmDrbhdoB15kGl07
	52HL05Q2iXR7E2gNaOe9WZmAzYtYA3C9Ncp0agXILulkGcL2XdJCwjZ4YYLlIDKPPQhmnxu/Th5
	xbta98RQjF8LSqLFjTmlnkt/c
X-Received: by 2002:ac8:610d:0:b0:51c:845b:ac4 with SMTP id d75a77b69052e-525f9152ea6mr8628721cf.3.1784557288184;
        Mon, 20 Jul 2026 07:21:28 -0700 (PDT)
X-Received: by 2002:ac8:610d:0:b0:51c:845b:ac4 with SMTP id d75a77b69052e-525f9152ea6mr8628241cf.3.1784557287677;
        Mon, 20 Jul 2026 07:21:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17009add9bsm476934466b.1.2026.07.20.07.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:21:26 -0700 (PDT)
Message-ID: <9fc68256-6790-4889-b1d3-1802de852d96@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:21:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SM8450 IPA support
To: Esteban Urrutia <esteuwu@proton.me>, Alex Elder <elder@riscstar.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
 <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
 <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
 <8309e9c7-a110-478b-8cd4-c002070d2b4c@riscstar.com>
 <3e70d77e-6bec-4e16-ae88-a4f5161f182e@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3e70d77e-6bec-4e16-ae88-a4f5161f182e@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MCBTYWx0ZWRfXyDRfk4oyRLu+
 YT6uEgkVP2rFPZXnlaBNix4uCMUgCmW+kVQVxkmZsZH8ZPi7/U94zk10HxckSfnppZm0wx+4e4F
 LvRYbQ/FJX9qQRWwyEYUwJPCaKJ321Y=
X-Proofpoint-GUID: Dqg6m9oeagb6A7A7J00N-iI44eajkkCv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MCBTYWx0ZWRfX0uMU/wv2KZ5P
 Z5R9Ge7IFK57wpqWluFcSwbfZWE2gyW/LwU/TB/zP1Vu/aFAOwI7SF6bUJM/TXE5oRzEY6fOrvz
 1sm3pbTFXNXI7rDNUJQDjKeeAjJht7FR6rAFCAxeppWa0VpTaD91KRURzTQ+evMBJ/okUQX8osk
 x424dSMw5woIV7nYNpZtVVOx7dxS/xP5dosKHVN2H88hCxVZJ1xBTSaZf+A+u0DUjMRcD81CIR9
 y4JyYDeHamBM9r6Qh0XaWS9dhusgGUUH5dvH47sb0n0+/GnXvqZhKw49D6cYgCel8lIAyHayfgZ
 Q1msYolH6hm66pkof2ElVGTSgW9HkxUL+tc/nb7Pgy+ZAun3nFzvAPiGVY3bg7wo2o6s5LpS2gc
 F6E1Pqe10n/FYkCKil/tx289p9G0U0TgQvMZMQAq21fQlfeWkNTzca1mVR5J/kgn+Aw0haDDYYB
 OapTrj38e0mt0vrJulA==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e2ee9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Jb5X9PtZ9yVevDr6ntUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Dqg6m9oeagb6A7A7J00N-iI44eajkkCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200160

On 7/8/26 10:45 PM, Esteban Urrutia wrote:
> On 7/8/26 3:49 PM, Alex Elder wrote:
>> This was interesting to see.  It's something I should probably
>> document better.  Most everything maps to the downstream code,
>> but it's not always completely obvious how, because the upstream
>> driver has evolved substantially.
> 
> On a personal note, I'm surprised to see someone not from Qualcomm
> maintaining this driver. It must be hard, so kudos.
> 
>> This means that the SRAM size (ipa_mem_data->smem_size) should
>> possibly be defined in devicetree (as the IMEM address and size
>> now are).
>>
>> The SMEM region is used for "IPA filter tables", and access to
>> it is shared between the AP and the modem.  Unlike the other
>> (host) memory regions, the size used is *not* included in the
>> ipa_init_modem_driver_req message that communicates from the
>> AP to the modem where the regions are, and their sizes.
>>
>> So it's possible that the size used must actually match what
>> is expected by both the AP and modem.  If that is the case,
>> using the smaller size might have problems on whichever
>> platform (SM8450?) expects the larger one.
>>
>> So I'm not sure whether using the smaller size for both
>> platforms is OK; someone from Qualcomm might be able to
>> answer that question.
> 
> I actually went ahead and reviewed downstream device trees I found on
> GitHub (1) which contain both SM8450 and SM8475 device trees looking for
> the qcom,ipa-q6-smem-size property, which would correspond to the SRAM
> size, and to my surprise, this was set to 0x9000 for both SoCs.
> Most likely the commit I got the SRAM information from (2) never made it
> to production devices.

OK you meant the qcom,ipa-q6-smem-size property. I can't find what
it corresponds to, the name of the associated IOMMU stream
unfortunately doesn't hint at anything useful either..

Konrad
