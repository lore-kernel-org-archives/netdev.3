Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301460;
	b=tIgw9m2jhampnuMF81FuTqGGfVmYjHr/QdQ9Rfj8KzsK3CgP4DFmKqh2iMKnASrQ+wNr
	 +6+GeE5MtEN0gVWxOy/cep9pmSQp61XLGqMg4B7AZ5lxhxFbM6b3509Uub79pO0RIDXcY
	 ueAhHDrYRcvfcNnZkl3L0kPWJnNUuFNfad8SneQpBlhvV+9W56pZplM9eyO7M04ygVDnJ
	 l6xkCOdRkMqWlNNezGgm8gbD1LJgW533CAnZBQSZGGnUw3K+B+a0gGS/uCwzpFZzl3Om8
	 guZ6FsvhAgOXb34yUplAc0Xu7QGMw/xp0lKFWb0F7cTptjqQv3avRoXJCRDOZU5rSUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cawB1yu5x8Q7YZwPnUWaDkm3zGLpJJu3DplPcK6FK44=;
	b=3sUBg48xq70O3G0beEhh23ADdFHPXAkVnncBq5OQUfOBFVdDDVTa85QhDCY375xsnRxo
	 6lb5Zcs0+hQg+FK3B2u1/dE2EaweAZl+jMJ3aekGiX5D4OqnJwkv0xQQpkwTOcthaT1W8
	 dKWZdv+ETI45H4Bbodx9YvLArsBbWm89VDNv/vPKVoCSNRdwSnRxi8P9h37HgFN//IL+J
	 9ZtDrQ4FhcjcwdKual++VaW7HzR9Tv6RsPF9iFO79DXjJc4Tuxw4J6db+sYDLC+3GXx+8
	 YULh2rap3N/vEYrVUVnARoGV4KFRJhmbI8QHac1OsLMvdGpeWkSvULHIevXXgQ4pgTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ipEW2xho;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P9+7vIQH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE0606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BE0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ipEW2xho;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P9+7vIQH
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TIR4g5908814
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cawB1yu5x8Q7YZwPnUWaDkm3zGLpJJu3DplPcK6FK44=; b=ipEW2xhoZW8XNvmm
	UvC7Y9C8Kxilxdg7AhcZthbFaP6dZQcx+ru1dhb/VPi5NpMwpWHDaJ4LM57i1YMl
	VWEBkn8MNanV7fgWkI0utRgY4wjqBeaxpcQpU5qTN2y108wQsn9N21Tfdz4PSj1/
	5rlz7IaYx5uu/NpHGx956CI66/metieVi6OUJOjEfQzSSIBDQ48KpwYKhOR66KHN
	HPWW4+0qGo4+gXCaWaMVFHXd8plFmRkG7DtvAzWf6J8I3+vfFgJgIi8tcSRuUT87
	77o4usUYlbk3y9iwx2aQ/sGnuUEg69MvFGLxe1EGneuU/buWBuwz/UCZYrUAixIR
	G15WLA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmbeartcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:17:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-944138ed63fso218156085a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793301457; x=1793906257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cawB1yu5x8Q7YZwPnUWaDkm3zGLpJJu3DplPcK6FK44=;
        b=P9+7vIQHk8lt3Oq23X+j76w+9FSCG9LgEvNAIApgpnM3lFG29f0iIgMk9bwx/R5dI+
         sqnpq9pLIfmw4Gx+dlbRBF697vqGj6VSiBVuZOGwcke4k0N3mx8Cx4Lv/rq/GKTMSndx
         1c5tXjUSZZWhcEBVHcjtD5Co8QiC+994ZOh34VfT+ioga540Q5+Zgn1uDsJC1pQcShlF
         T6m1ZEPcSnwowVkUK5vFxW126pd6cJcLKGNXNifQP3dh5l+G6m4xYz5TXnLpb/Dq/KLT
         Pzgf4ySdLLT3fwAGdbCc6hjE/p5tW3lKVcug9ZhLGBgLakNLzcIzUn8aK95RhjXYNhT6
         lMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301457; x=1793906257;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cawB1yu5x8Q7YZwPnUWaDkm3zGLpJJu3DplPcK6FK44=;
        b=mC639Hg+NCUsoKo8EcKyCQ49fVI4Q1GdajO+YrWbxB12OMSRLtfRXa1j9lMzQUXRtc
         lW91dq66qHltIpu37wbwdwo+qeqvOjJzwxqvgfCwrkPZnhm18O3l0jlGbqxC8un+cSBW
         BcYhMtJO+B7mJjwOPpx6IPQzPWvHmIdPdRzom2GCVI5vHtELDUlWFtqfVfcuYfdbHkLq
         ga7rzF9Qm8x/Of/EmM1pOElBm+hehVGEMZQsCx2ytytGPsVw32OjAhZx1Ojr71SNOHy4
         blDYxfhGZFbvaqoDPMf9N7VoJ2u58uX6QYHumasFu/Y0KQBlHiei8xRqp+PYPqyWOyIi
         nTMQ==
X-Forwarded-Encrypted: i=1; AKwUvByZ4BRfdu8tUtgaUmHPrQ2y1+STkZ6qcunH2j36X6shBFaNuXaBzleiMccK8MuygnYnrgZImVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi4JWREQpsk7vIsD2MQg6lvG8Vx3/DRXXM0HnusoDTc78tidZN
	N+Oqse8ibEDR3h+4LjIQ4ySlq7Ji3BgQldiO6Rkhw9TP4y4oYBMefH4e8AeF58cmlBNSEAuL15h
	tCUafetmFV1q2G5Uei6LCZNt+6jSSbhEyMKPrEMK0faJgMb+BGgxWhZilAsQ=
X-Gm-Gg: AYBFou3MYuVLNeEVB7rRFFQ0KgjUyP255cV8qzApgcjiBs9aS03NJtGp5aaef+la2Vo
	OesPHTSDvwqys0kUQx/ccI2yvl6WKfbL3kDLUxGHNrTgG8OPz5lx6pSHwehwdte6tK+kcVs1vkL
	/FFg9WPc4WGHm/+n+mEhPdX1+PTVUmtcvrxwh/oX8RcEQTDCzdpu4VllXXWRgckXWX7aH9PX0Am
	uL3RZ6EFnDuW5FXJomDg9HVdhTROJJZqQn41l2i6ecvFOlkKjVitbFjwFBbxzhwerwGIjQhUsMB
	s9a4Ayjyl/mR5t5V3ADFAycdQNs3dnjw7a/Uym/9HPSClhBwv/oNwj+fAtmnBqIc9dWLOSrzZRu
	eiYSlzqjvYmSEd5mUMDaacXTFEA8jdu53Nzva4p5JdUbSu3j1H2qEhkH3awu4xS4sct003sRpWz
	c=
X-Received: by 2002:a05:620a:84c4:b0:93f:211b:a88 with SMTP id af79cd13be357-94421712a75mr26302985a.14.1793301456916;
        Thu, 29 Oct 2026 12:17:36 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:93f:211b:a88 with SMTP id af79cd13be357-94421712a75mr26297085a.14.1793301456304;
        Thu, 29 Oct 2026 12:17:36 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm80549715e9.2.2026.10.29.12.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 12:17:35 -0700 (PDT)
Message-ID: <a9910bba-5a4d-4eae-905f-4e576b03e112@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:17:33 +0100
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
Subject: Re: [PATCH net-next] net: ipa: Drop unused qmi_elem_info arrays
To: Alex Elder <elder@ieee.org>, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
 <97e9474a-f491-4447-b128-e4a5687056ab@ieee.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <97e9474a-f491-4447-b128-e4a5687056ab@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UejE26SN c=1 sm=1 tr=0 ts=6ae39bd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=ee_2aqc6AAAA:8 a=CEbFsyCIg0w9jv0LxFQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: ab1Ztviw3GVbFzCQfXcRhPY1IG5Yo7vo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfXw2Cnf+G67Sv4
 tdVqMoPyGC9e4O8grymPFWcB2+pOVIBEvoO5ajirqtYLfFSoSem9bflQy6/WNP5lfo+VC2s17Qx
 d5rScv/MhSsadXY0qYbrKxcuz9TVPGPXD3DqaL5h9JY/gXNpviOcM9Xo8sh88XxDZDMGRqXNmjs
 IoYP4T8oOuK4e1mtU5ecs1ntpmqjfStSeuYkXwajLsjYfR2RPRM6eYLgsxbpg2gkdLlqv/gn1+a
 oq1zeQjM4N3b1RrLNFHGTP52SalvnBx/N/RBrLYasQKm15WYrmM1G7snNihswGh8AjDl5MyBrfE
 rjdUXk5jeI3l0X7pus2Wy0yIlhiWk2C2nk5oLL10A0RviPVxsq4iUqiKMxDfGmVB+Mx/7aulsTX
 L/11ECIa4mJJNu577GR74crCLzXg6LpWOyPRR1gF5hLJkRIALgCQKrjT7lEjyffF99jRSZWi8Yv
 o4se55gl/xOr+aVLx0A==
X-Proofpoint-ORIG-GUID: ab1Ztviw3GVbFzCQfXcRhPY1IG5Yo7vo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfXwYHbiyYWQjVb
 JY4KFPAo+pR0+hjZfxOtvzcQkqSszR2uvyNQVcNtXzIVnGp5JQF069CttniZE/XICxnGvVDbX4W
 hNhZc/TDvl76lb2iFhO3YaY6tVTZHj0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290075

On 29/10/2026 19:02, Alex Elder wrote:
> On 10/29/26 6:11 AM, Krzysztof Kozlowski wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Did you send this before?  (Why the From:?)

Old commit I forgot to send at some point.

> 
>> 'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
>> 'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
>> units, so they can be narrowed to file-scope.
> 
> I wonder why ipa_mem_array_ei was still defined.  It must have
> been used at some point...  Anyway, you're right, it's not
> used, so good riddance.
> 
> Did you find these by inspection?

I was going once through all these QMI arrays through multiple drivers.

> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---


Best regards,
Krzysztof
