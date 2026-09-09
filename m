Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54935C1AE
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974787; cv=none; b=ObuZ8DjK3mgn31DBGRXIwH9MRDjoyBjzmU2niEKlwFvs1MfWTdkeLbI+CXpZjDw9k8NXB7pZjpzX8tJ3wyn0wHkwcKS4xIYsQWTDbGkjZ7/+RQl9Abi+9S9BrOEbKJ97ntCoIb/irNDgeHH6vPywMVXVZSI2+1xYP9FmXwOJFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974787; c=relaxed/simple;
	bh=YuhMC+ikAd+pjOQay2Ig0CjXXaSBPmUs/yYHR+5uMzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QEAYNmOxIZon/Eupz8fF6CZyUhRHxZ6ETPyz+DAgGzqMVaGQGix6Plh/JhROE/P6Tm3p/eHTDK4G1VhdtOXH4nGv/4EKyp9p6aJQdwcjTMyaqAncOh014rr0kwcArNPZ7kE6pfOtDxS2pwSXc35qQ2bAj0GaV08g5InTZ0FyB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4CMqh96; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g1LFYfUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4CMqh96";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g1LFYfUY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7ZuO3133780
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 17:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TvnR5tjlXGe8UBW8k3JIMB+3DEiF8Somqt3qxNxJN1o=; b=L4CMqh96zJuXA6P3
	VTRI3yFqqw95fvKIuKcU2CC6CMLspWKcEJvHZHajWXz5OGIsGaOWQXzEe8RfCaT4
	boA7iEJSkWCEi8d7Ydk8H1+SPckgNCMkj+brCfTsGe/No5ejIxsf0AWviYC+Scmj
	tbWA2xEk4kCoXJLLZK9BThScM6zDhuOzndM3XpWWtnvrIQBVgzaWABkqQAqLElUX
	a/zpgGWtyaSR//7LKrAhGGjnDt0m+LmYU9O4Y5Oz6tq3bW+bL7yAeiHAX0rKHsC/
	5rORAWcgMsDYM9X7joFWeCvbUbtv9qU4AwoneNJXZVuuWzlXSenvP21gb4woQvjt
	ojHTOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru1w93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 17:26:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so109797185ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788974784; x=1789579584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TvnR5tjlXGe8UBW8k3JIMB+3DEiF8Somqt3qxNxJN1o=;
        b=g1LFYfUYkxYX/BfnH34DSNk7QssZ7Utd/rpiu4lX+oSm+kbSYr/uBdpSh9Y9ZMKWXP
         GXmuA1e1ing82hcf4GLZKkfjKmxQKktf0N1inQRuDUncNS4ykNGnSDuNSIofAj6buFKx
         yjOX4f6VPUC86aeYbIGyFfTrkKMPecNFBs9vMf1uF3kcOltSTq952oo/dI8NxR3trgFG
         bVi2hOCPJBYAAiibwnT2B6QeinJJIqgqP8DsMEyLnxCkr+pS+kruzackK58fXwn6IBJf
         GY03/O/LUVZmXyfQkFCNuFRKFoIUt2DXGeysHZ+q01o4+skmxJ3pzd/G1Hehr4w53WRx
         erqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974784; x=1789579584;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TvnR5tjlXGe8UBW8k3JIMB+3DEiF8Somqt3qxNxJN1o=;
        b=G3W8Y8zUi3bClgPYrQ/STX0b0GvAHqfbEgqTsDUwWXGXduDO3TXV50XpGvmPyhjxLn
         qBNkE0ZliWmjj7o4tBqIPPRxrwZjo8r8f9M7qENamz5bV1N7j2PdTyFC83/Bo9eXS691
         s70hVjfgICrtA5Aou9iz4bBiOMewhN8/0jjfnqCD0t+sovT/IdZhfHCOc4N3x/HYhdhf
         05LpbFkumzsry31BByGx6zTcDfHWM47JQXdA6G0cNm3EM1uBW+tKbTF9IYv+n1IxutXG
         h3ZZe0R6O4B6k1IcnUeYol7YT5aHajWUcLIQBnvQhhfgHUxmIGQdNQWvUkKXQFMfYpCG
         GHyw==
X-Forwarded-Encrypted: i=1; AKwUvBxHOizpos+dc+vXhyFjHsP48+7cBtMPi5HGmE7qDOvbSikks3ArZW046EiGtPo7Rf8K9Ewxdq0=@vger.kernel.org
X-Gm-Message-State: AFuF++mSE57tOszXMo+Cncx7riYyXZ9MdHRxD+QL6bw5GBIyl5z9eBY0
	UmHWs4yhWvXQMX/85mNs64KjZECVOQnYlHu0N7JBHzvTNnTiWSzSFC+QuQEeMlPP8PgYIWQnkGx
	42FjIYayCgrzAL7rUy3ZF9jjpSuYccxLXPVAXyXcZQFG+BPCJrfauY4M96g==
X-Gm-Gg: AYBFou0QfBKGrvqcC8vsTndHr7kD8QocmmviqfbjyOzxsk3FJzd/QtgbpAU6lStBVTp
	HTAzZ4ez+b4u0oqEgbhn7AkqZlCIb6n42SaTNONYJbn+8R2osF7Ded0+uoQtAfCQVaLw4mvYC1S
	+0jL3Cd54PVl4TXn4cEgizMAeOynoNu4ooUwFHWWeQlscYbufWu6oFIEQSg2ugknUJ4rZEUauUt
	jdclA76XcdWVVBAzyvQ4gtK7fW9aRPfqYwxE1U0hLO729HOnyIbyuhZMxEypEHEFvPDuzRnxa7h
	GlWKRe2DKjxaxvXSH7VKO5wn9VYICVpmqkNBdCi4+YLeEP50NP0guWnLvH17/k86Wab27UpOoxd
	+nWtm/48SHaOfhI2Ud5tbXlYMFjFr6w==
X-Received: by 2002:a17:902:ccca:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2db127cc2afmr548653475ad.14.1788974784256;
        Wed, 09 Sep 2026 10:26:24 -0700 (PDT)
X-Received: by 2002:a17:902:ccca:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2db127cc2afmr548652735ad.14.1788974783562;
        Wed, 09 Sep 2026 10:26:23 -0700 (PDT)
Received: from [192.168.0.108] ([49.206.13.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b40esm77278825ad.22.2026.09.09.10.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 10:26:12 -0700 (PDT)
Message-ID: <03b61010-2210-4923-8172-545c30fd97df@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 22:55:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: Re: [PATCH RESEND wireless-next 00/18] wifi: Add Seamless Mobility
 Domain (SMD) AP support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
 <20260908125017.0fb226c5@kernel.org>
 <404004c4c97bf776077685b7ec33a14fa777cd70.camel@sipsolutions.net>
 <80266eb9666d6106110d998cb6330868da55bf59.camel@sipsolutions.net>
 <20260908132004.29176fec@kernel.org>
 <0e950f7f0c3f5a2c1f6476e255716b09876624f4.camel@sipsolutions.net>
 <e7089219-ed02-4288-a678-660a52289e61@oss.qualcomm.com>
 <e9b36721c9e2b0b24c89c2e1b5b03b17c438f30c.camel@sipsolutions.net>
 <80b5c9ab-de1a-4170-9ea2-26242b767e93@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <80b5c9ab-de1a-4170-9ea2-26242b767e93@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa196c1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=1GmPaZxtcqOdqSZF9xWxyA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ly1jUebXebrwMyEau08A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cGE_6kztScJgkKJKwQ8q3SBLb20wco6B
X-Proofpoint-ORIG-GUID: cGE_6kztScJgkKJKwQ8q3SBLb20wco6B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5MyBTYWx0ZWRfXwPOU2NtucwSO
 cby/NeFUgoRbh2LHfE4y/j9/WHrWI6jwaTmOLSbpIkC1OLTpo5aOhTg0nYlFmslGury/tIgE/A6
 dDjwuFNC/p8QfNJ4KW7vNyh5U6uc2YE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5MyBTYWx0ZWRfXzk57KfXRwM5c
 fh7v2cwwZIMUJEkQ2RHaYfwlE8VhUZvJhnBF4ets3fH+a3tAulxjqTWUROdgy5tLCTcuccBNWIB
 8BzI0UqaNDskVAGLvA3lpaYlD8/0VkaH6bh9WKSD3TaIMX+kR9dy+qaOPXq5/HBratwDfkHTapM
 zbq3KXeW4ArkDBZfBU+DOJIojF0KdBni9X3YzOopraoc5XvbI+hZ/YTMAk3D1XvNArLUSV1+DzH
 abH8K5qg1OJZkDFTDZeohhkOxm1Tpe40UX9s8xKxHTag8ANGGRPXPVASSGybrmzYOqDVZTnjHnu
 Qvpd/Bq6hUK6L0Hy0Cl6y1+4TtXOdoZMmHu6KzdoVLyith1clei8zztIt1dyohd+vB2C4AFJkXr
 TiZnfjjkc/RqszYEGgg5Bp1LMbnQhwlz4MK9inxZ2dX5PB54Zg9DcK9+sDsAuMUyt/QkqmaLiU/
 kvo+wGjSGxI7qIHm1Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090193



On 09-09-2026 07:42 pm, Jeff Johnson wrote:
> On 9/8/2026 10:53 PM, Johannes Berg wrote:
>> On Tue, 2026-09-08 at 17:20 -0700, Jeff Johnson wrote:
>>>
>>> Apologies for the AI-like commit messages. Those are at my prompting since I
>>> want these patches to be understandable by folks who may not know or
>>> understand the underlying details of SMD roaming so I requested they contain
>>> enough detail that referencing the spec should not be necessary.
>>>
>>> AFAIK none of this code is AI generated.
>>
>> Did you read it? The comments (in patch 1 we were talking about) are
>> also all clearly generated.
> Commit text was AI assisted. IDK about code comments but I've asked the
> developers to be as detailed as necessary to justify the design/code,
> especially the SKB extension proposal.
> 
> /jeff

Thanks, Jakub, Johannes, and Paolo, for your feedback.

My apologies once again for the AI-like documentation. I think because of the design justification details and multiple rounds of AI-assisted reviews, the texts ended up reading more mechanical and AI-like.

Based on Paolo's and Johannes' feedback, I will come back with a v2 that explores an SKB extensions alternative and is more wireless-contained (with concise documentation).
