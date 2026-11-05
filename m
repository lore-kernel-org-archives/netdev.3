Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914847;
	b=sHYzc7eGRvN1nz66mInKKti+fxlOgyI3gtGiob0in87OKxVybYwK/lTgmWGKV6reCTjd
	 TFwatqZq0TMysJleXf7k3Alxlt61BStG2xxuR0YCNtdaAOZ9sNRfJCg1o9Az15BQIidVZ
	 geHou95Fqt9smnNjZmp7/dyzGzqvM/kyRqvrZWfzQzkxrYI7t0eWc1Do4e/wke7yFeJP5
	 zZCXcb5v9qfnlX7RdRgcp15KL+KI2/1PDkwi8JdmVCJdHtjQA136Cx0jHja6w6+Al1hmR
	 9rY9ky1SX0T/W24nR5I37umGPNWfnY1pPqU+4gb/4GxyZSgNDpNQ8kPwP+5G65sOp3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914847;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TiL2IkZn0wEC7iD+jl10xXWMOQDsgAhBHuaMbQTkHAI=;
	b=BMbHF3Ix4HT5KjxaTte2jcA5PSTgDLSaGtnRlwCSiL/CveYrdj5DyzxpbjsPFvUi4C9w
	 JS8FkRTiJCRc7zNV7mYqgD5DfZlzvjUMD+yf/FGRkf4Jnocqo5SH1+V0aJCVLzWhv4TwL
	 UjMutmkxCXpuDv3jgDuyAXlw9TMPx0TwCon5sopY03hS7qzVNBNxwPkBScbR+2r9y7IQs
	 uRjxq89XFQRPbk8ZCqCpp/v/LBKRaKV6C9ECU8puJr+Ws52IbBNc+r75OQOplrj7utby2
	 9XaUv09/Ao46xGBCN7cdJThqdxV1LQf2uAbFfq5lGq0wyvIJ8DKkSZ03ZkU17x2tFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gSEe04W0;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ixdOxXeu;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831D606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E831D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=gSEe04W0;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ixdOxXeu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5LYFqr3533785
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 16:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TiL2
	IkZn0wEC7iD+jl10xXWMOQDsgAhBHuaMbQTkHAI=; b=gSEe04W09Z+Nh8ZHcttV
	bnd4AF4WkzrRlwZafrX5JoEzr5CxThBeF3xKEZOIBcZf19OnJMHqvzml/CUUpRp7
	hIctJ0EZsgo+t93Nfw/HGZ7RF6zupDHhTHC7r7lBTWanUitvkGm/v6aK5dPekwsV
	8g4hY5qW70hw3BqJb+UcrTZIkWQfrbdqFYu0SgROjPeKsQKMlzvhzPn3pw3aCFS6
	qH+ubESFeDDgm5P8F1wFuYtYRe7NKtOchPSI/8U8xHRLTOwgr/bZ/tdVpFpQueX8
	Mmemd7/RyEzyyUvD7mLL4SXRSAq11zfPe0tCuhterVH5lvwXtNwemmeYxToFA+if
	ow==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hs0wfrmyx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:40:45 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9440b27c1feso495079785a.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793914845; x=1794519645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiL2IkZn0wEC7iD+jl10xXWMOQDsgAhBHuaMbQTkHAI=;
        b=ixdOxXeuQ6bjUfzLRCLvJWlLpU0w6m+xj6I4VCuvdLxTkTF1Jf09PtGGgxU006mWFg
         Fi/aIMVS8sEwnPoRnT9cJbuyb+3FzijAceFvzpexP6ikZllK81NbYC5JFeEEQrU3zkCb
         V5VcOmMDn9NRMGN/yVCtte7ASePnpZbRs9VtClQ21jDkDZ7qe0aRtFmwOEpmGqVfi9CI
         bp04iUjc4qxOt9FJA/N2QO9fbwxoZAm4EwEz076r1dG1NeGMHR9I2i0QLlTgFW90qhbz
         0cY9cWaFjuSedMDSuvXnpPVEmLxnQQHUUlRHND7522mfiR4P/gQPr+FnqWrU5jn1IqN1
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914845; x=1794519645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TiL2IkZn0wEC7iD+jl10xXWMOQDsgAhBHuaMbQTkHAI=;
        b=1nhrnG+XCby4uc0h+3o3YuvsoQL62Q3inSLS6YVnZ6rmYd6CumA6NTs3zbwLQAkBCC
         NzoNJnKC41x4azVAQ07TdyQ/6HaTNeEFDtSTknVtPgmmgm2Mn/RsYfvXdxj5bG7LA+iq
         k4J8pBjrQ0GP5Vz6rcuLniz5kMMikPdzxpYpNp7TP/eStbs55lqgU4FQfr7rp0zS2jgI
         DSqgicmzQ9ZqFY/gBzLmMbwSnaFMgh83uCo/DyIcgFito6f6yGvBbaTw2uWvSIQx6zA9
         VVHaQWraQMo5uCPwneMCvw1Qir4XvzyRAwwHurNj+5mxvqc9K792moDL7IgknXweXaBU
         EnLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBTzQF98ty739ssQI62ItM7F/b9vyS0tYh3nfzYMqU2OlVeVQfVkPUNbvxkOoAXAWOmgLSaB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j/kEGWZsad9K9c1qr9ExwnxE4ZvhvQ5r2rKCLShmjvCVFWamd
	g2BqGETyPOwCeyp21LiuI1ALPrSNqVqsr+uemLkrMeAMsmXsWA7Ncr1MyM7FgeQF0AyN6LSPoF1
	EYFOgcOEyakrXNsHbH3A7eVep6BoPSMhG02+et8j0ZH+ckickaWGeEg==
X-Gm-Gg: AYBFou0b8f1LgaLSwXMRYcdTwyDTqV1iPd6BlBYrM4z4VMs9/PuoKBtfKyFyWRf9YgD
	I1W8wxcprheinUFNSjNE0qQremKVRNOh5pIPdG7SbqvPw1z8SEFeGiGb05ANz1RQa6zohFiYrRw
	l0HORCFA3b75Oa3OeCb7FvwAw/9znuGAN0+YEicUgkSXhynHBIrwxZi1owsJRQnrcaP831fQ1cy
	ZRCaAV31CfTG2sXxRfdxsqXrYK+1CsuQMXlnPYC1E9Z2aAoeMUFhEJ9KZCvErGc7TMhIEYykoK9
	m2i4ppLrYyY1HjvABsKdt9JUUAUGXFodqVitxFJY6pgsUA7+YVawv5HynBgciLXNYhGQWk1dKBQ
	kL10C+SS5uEwYEyqFQy+kZUKhECVMU7fRIYiFxtA9fMz2Dvwx/X5K8Y1oRat2rdNQ7vXj3uqnuM
	sDQmOgRjInHCtEx/PoKo21dbFCiO0XhZ4yT/ZwUJRZutI3D0QrPpfEghSJhkMyXu3L5m4xoxrok
	uNiAGf0hCaTrDLEtyIMlP8nShR+Oa3c1yCI+eP0owj/SO93lYlUlOmpes4Zz9H2
X-Received: by 2002:a05:620a:1d05:b0:93f:3f86:c4e9 with SMTP id af79cd13be357-945f3632eb7mr58660885a.79.1793914845030;
        Thu, 05 Nov 2026 13:40:45 -0800 (PST)
X-Received: by 2002:a05:620a:1d05:b0:93f:3f86:c4e9 with SMTP id af79cd13be357-945f3632eb7mr58658785a.79.1793914844728;
        Thu, 05 Nov 2026 13:40:44 -0800 (PST)
Received: from [10.206.221.57] ([129.236.229.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48577ebsm547093585a.33.2026.11.05.13.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:40:44 -0800 (PST)
Message-ID: <74882357-55f7-4569-8aae-789a464748da@columbia.edu>
Date: Thu, 5 Nov 2026 16:40:43 -0500
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
Subject: Re: [PATCH net] net: cancel napi->timer after the grace period in
 netif_napi_del()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Martin Karsten <mkarsten@uwaterloo.ca>, Joe Damato <joe@dama.to>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Stanislav Fomichev <sdf.kernel@gmail.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu
References: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
 <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eo9KXYpX c=1 sm=1 tr=0 ts=6aecf7dd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JerxfvFqMz+qeRdZ4jtV1Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=0-2_M6cSbhsvEd0Ws-sA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: KT_auzVCfrJbWd8J0yP9WIWLmh1L5bNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX0uRyQOYOpIgJ
 0qoRYGB5fYdYz4ZCJRJsrFOvFOO0d+LdO6/0ZWtXvxH8pe3J5fU8s6mfvMNGzC4CnYjD95Y5bLq
 joB+cX3ejXV+tTcwz2N4Xp21y1SmgnjUdawdHVkh6ZRyltHRwNmCQwUbfkaM9ehcy4bAmEkFB7A
 4ydRg6H5uwWo/yFrq4hkDSYV/pJ5JzhjTk9tRf1pAHtYWXxlzlKno6sik591V1R2+DHT8aRm1pM
 EHHTtKIuMlbtctTrmby9q7Stri8qpV6ocXqN3uBaCWTU+x5iVzCrgWwAm8cALyvXwIjBKmrqybX
 m+uDnbduX8u5WdBMrAbopYI9/lyUOV14fXbMAwmwaC6lb3S046Q+FKXUbQbrebUERZ8ahMIOKRr
 P7WgU+Bso3szUreszaXnDuMY273NROOc3dC6xkduqt37fCCKAH66hJGeat7ncSGFtC7OJ25gBAW
 VNK4/N+7yr0Z2dgeHRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX85f58He8eFPs
 +ThWxEXEivpu5asTXkj9E3E7yDZprhphbW+4eL4TcMKzsi4yYI8jzzPiMDTiqtQ9HOcV7aewg92
 tQWcDO9ndpIkpK6DdGaMyn6NBx9TWna4pfKYFlJpVpNllFJZsgJh
X-Proofpoint-GUID: KT_auzVCfrJbWd8J0yP9WIWLmh1L5bNh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=10 spamscore=0 priorityscore=1501
 lowpriorityscore=10 phishscore=0 suspectscore=0 bulkscore=10 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050085

On 11/3/26 1:37 PM, Eric Dumazet wrote:
>                  hrtimer_try_to_cancel(&n->timer);


One case I'm not sure about.  If napi_watchdog() is running when
hrtimer_start() is called, the timer is queued again and
hrtimer_try_to_cancel() returns -1 without dequeuing it.  With
preemptible RCU two napi_suspend_irqs() callers could both end up there
after the delete.  None of the callers run in hard irq or from
napi_watchdog() so would hrtimer_cancel() be ok there?

> Can you give this a try with your reproducer ?
> 


Yes, it works.

I'll send v2 with your approach.


Thanks!
Mani
