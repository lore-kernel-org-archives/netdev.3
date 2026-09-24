Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10853563FA
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222341; cv=none; b=cp1FSZ4IVTzb8B8PNA1DiDk10iiXiPhA2bCHAH9i6u+2dQhgNDavwxlttDiXu42SL9FFhNTqpvS9+0Rf1Pigbjfo6DV/HcjsnRvfTZf/2TIxwbBPsEGYH6wiIBaZjfhwIVpF+vZq5Lkdug43gEZV4RksT6+jvfDK4I9ZEFs7rUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222341; c=relaxed/simple;
	bh=mTHABsVW6LrK5x1PKQz0xfBMUl/EmalKRgXETRBbGF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzCmHe3KwNYh/lQjGb79JfFYKTBqd7cCdIcqZ1vGwAUnAAhUqA6QnaNWDVqbhhlSWPJ5rYa+Lj6odx8x1irfvan9sX42E9gMGCgQiMa6D3mZC1VsQ8rph9n0j5GA0ufVoWDOpPY3ES05agRW6Vp36bS+p049tzirl5Xdi3uCP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FXHbTmXO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OZEwwi9Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FXHbTmXO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZEwwi9Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O36jo11416639
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WRqR6EsbtaDsBw5NOzPpm7r2TQRIPV2xWoHRZ+CiMEg=; b=FXHbTmXOZAzY9wCA
	aEP3GeIS93HuSotfr7W6mMsy2jbOaQQ15mknxtxccgC0LMjd/CRCTsRFvjahASmH
	1QXOW1SB0S7twxUr7OwooPlbpRklGaof+l44L89BPqT3juTx+M/9gUwhefY7Q0B2
	uU9+rSt6tx+eaVo3Yk2xPqs2RhJezkqYPXV/yjOhToT9zADYzESSCnLxIF/34TVO
	Y6bEPPsJbOU5z6dAWdWG2gnftdaZLnrA7835q7B04zvCC4mLeuG+ctOmhoQnBP7p
	DZEDxWIlzSzFlzc5YtyWTBfH/BOaX+eUavzqD4C7YXFHkDyjnW8zAPIUWxecffnG
	8zQP6A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbk58s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:58:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8623e5d4279so2675772b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790222337; x=1790827137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRqR6EsbtaDsBw5NOzPpm7r2TQRIPV2xWoHRZ+CiMEg=;
        b=OZEwwi9Qwy16FoW1HRTiQZdrGcqARGWAAcsuWIYBR3n4bip+uf9b2gi/koPmEbGHfu
         WKUew0kZTtQyfvZfhseGGXC1UtsoUJZw4Qln466uBWtEWqw5QtFAPh2FG7aIQyQrZ64X
         Qbb7FP0fZPL8issVpMuvKYcBKkUtioJg8Bg+JByN2FNtCpmMTaL5shOUSJj+zS1HwN7s
         8SBEvJ82xrQdPM61kJqvUbL4qPI3/A0JZQ7FGIyO0NXZKs/9rLV0ghX8fZ3a8hw8j9S4
         UuKJ60rBHwvsZvt+rMgpUKvMf+tuLilR5dAQHDXkw9Uw1aKRFHRmp2kSETGozM9eS0bC
         04Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790222337; x=1790827137;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRqR6EsbtaDsBw5NOzPpm7r2TQRIPV2xWoHRZ+CiMEg=;
        b=Qb58XDdaKOahCLeqY30YKqxyl0bUw9hBVqNVFlNRfmU8bJQvUCc4RFuprmgVARBqK0
         Ja6cI5i3Tmykq2J3h6WBlFV3lj7BdvvTgWKzPrDU8SqmmRC8zjQ8BXaPsJYu+Dqflryz
         ciQ1G3Sjyn+N+fUGNYIhGsf8XadBc8l1G47SUWt7PsK6fZGUxFQ+0DLsgm2XpRJPYw1y
         IH+ik6sOsK5uGsJ/PBqO9VSJZiImAXAcBCUaEMt1C93Gb9IJdqXzqQOBxD0Wf3K/rwnP
         UzP1uwofaQP1Ufmw1s4qYswN4QqhdN3JltWL3S/FhRk1ZCitDfDskYFaUhrkB7771OsS
         rSEg==
X-Forwarded-Encrypted: i=1; AKwUvBzpAP2lebY5N2WEbweFGdx/CxzLz74Kze7RbJgoEeKkZMukwlCYP91eH33HD3COOjv3E4PhbkI=@vger.kernel.org
X-Gm-Message-State: AFuF++mv0rUhDotHtOkYZpfkcGcrZ6zs/pDGAlzuV2y7jcm8yadm2Ztz
	eQ1M/rLg3oOAgTsILqfjlCJYhJeofFmMzyaaNfg9Tn7YUE7MZRwjFUfUwnSBFgWdmlZETdcQXP4
	L7xG6accttWlOxa5pIb/1fI5GTabmb3SJ2xxOxAiLl4gKN/j+ONDmoIPYmbJZEf4yYFs=
X-Gm-Gg: AYBFou30sSEznL5pCF42i/dhva9LdJQwor/3OfBagxv2wazN+zxPRu5Ee3UEiD9BqvZ
	cCi/ewa8uG6/UKwAP7xcqj/nS/qrzOAvWIit8QECuh6sRyhZXArqepS33ibsPgwhKMjhlBQ5kMP
	z5YlllMiWufy0vgm2+NLRTOjNjBzWjGnkckQPhEZBdWwGw944hsNARn1f/+BNj+F99R9m8knH54
	P06uyPp1tCw3vVEaUyDsj48rDla7Xn5YZ5X3b3YyHBoc8ReQBkwLn4MczcJ6J34c7WwDRQyuDQw
	fnb6crt1sjmzqOKebtRlS5OHSgRnxH/qeWcuUbyWcKmQEfWlvfaFEE9tGMX4mc00FFAvIuiIvbK
	uCbVtESq4iZxCoP8BY6/d9ZGP
X-Received: by 2002:a05:6a20:1f28:b0:3dd:a196:69e1 with SMTP id adf61e73a8af0-3de0ea1cec2mr1157964637.60.1790222337340;
        Wed, 23 Sep 2026 20:58:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:1f28:b0:3dd:a196:69e1 with SMTP id adf61e73a8af0-3de0ea1cec2mr1157950637.60.1790222336873;
        Wed, 23 Sep 2026 20:58:56 -0700 (PDT)
Received: from [10.233.17.96] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0fc5casm2142631b3a.53.2026.09.23.20.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 20:58:56 -0700 (PDT)
Message-ID: <93e44830-d141-4ba5-8048-fbbaf4a2a63d@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:58:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
 <9a79f51e-50ec-4df2-b908-71573c81b69e@lunn.ch>
Content-Language: en-US
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
In-Reply-To: <9a79f51e-50ec-4df2-b908-71573c81b69e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfXwipE5c7S3ajT
 OdATCplMCmefFQaldqUeklknnU5+C66JWAcMIvru2rnHoezK77ihdDftFtLHpiY8s/3kMzhcGbj
 zYjCEXA6fngIQEbCK94iCpMSE7LTYVM=
X-Proofpoint-GUID: WSswuQadsfl39P0M4PtKEMpdZvVaaET6
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab4a002 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p6hV4UG1XhPPKoOh2iYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfX2a6fGOL1+HaY
 W4IJy1N8VnLcELdj/cyMKfFXA7BbJV/rdK76M/a/lFDNd5JE2BRjhk10y3565l7W+Dd1e9atrDx
 t+laulJEykCGCQb6zcKZ8mNWr6wLYq6ULJ7wxmWWrXO/1ps25/iMAV6HGOHzZSOkfoxkvj4Fq3J
 QSjmKJknWtyKczAtYrprXDJKQBTCYT4yM3hk3cKsmEwVe2EOUt0160QaaM8pdeg8KGWns0tQ/87
 F/TE8yKaGdhms65YE+b76DdH2+kpRrCjyV/xHbHk2GuGar8JsAba53I/GsxpsTh392OxNJAHIve
 OWlU67217PQVAHxvmeLelq/7dyOgjdQcHL+ggmusMnSyhUwwftlsPymfeOr0zzuPpHCX0bjbhF2
 V970jnELbNXTEuWwICJBSdMXtRchSzH10XnUWRbDfDPGI7HDYmoHVkNWC+kOl6MCg3mseHddUGk
 5EVeluQ+ESlQLkOd7eA==
X-Proofpoint-ORIG-GUID: WSswuQadsfl39P0M4PtKEMpdZvVaaET6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240017

Apologies for the careless submission. I will fix the changelog and
improve the commit description before sending v3. I will also ensure
patches go through internal review before posting upstream.

On 9/24/2026 12:02 AM, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 04:24:24PM +0800, Hongmei Xu wrote:
>> Add support for 5GbaseR within Aquantia phy driver.
>>
>> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
> 
> Did you even read your own patch?
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Please try to setup an internal review process, get other Qualcomm
> developers to point out all the problems with your patches before
> posting them for the world to see. Silly errors like this are not good
> for Qualcomm's reputation. Not that it is very good anyway within
> Mainline networking.
> 
>      Andrew
> ---
> pw-bot: cr

