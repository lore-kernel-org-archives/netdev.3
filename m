Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32246EC84
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661696; cv=none; b=O4NqD0RI8vnS4hNZYZIcWyN3Rb8/waB4NaXC7XnF7ocTgMPDn3LGDHY1xkTn5TZGa2DKCA1xeLvlkf6AXmJnAg/3szjHDpC6A10iVodczHcpexB6p/dqr8MX47K6IbxAdmdzAqG/zhsj6u2YC5pFb3jxOC71GbVoXe086xeOjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661696; c=relaxed/simple;
	bh=Sotpip3gBeIy/JGRPKE+/sLPJK1PnV5DsQrli8bNikU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqTno5cpHRPq4sn9t+3LQ+QuIHJ/t2nSOwAU3lWvCkHIGuF0rnNwOZNohNfIC6Ycal83PvcYhbLVaWDxDKQnFafUvdasAnvUW2uTItefGKKKU9UxSSnKI0w9gnsb/eApFajoyJT9J6isvb9V7QGF0nkCHqa8DXUdABvghg3coDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDgBhLv3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDgBhLv3"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8eefd4a8057so75278916d6.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784661693; x=1785266493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAv/YlHa2VEFYt54c/rqc8dCQWbyXaL++Oe+Q4jkiPU=;
        b=pDgBhLv3nDRyK3XHQLhVgBHSAmLf1Spd0hzk4Vxkxz5ENXLgtVcTm7/+ZC/SUAcCHN
         JqJ4Tu9ycxn/Ts60Kn1biRyYIDNbEzRVH6Q//wKJ7858EVfLQa3DasdfA9JecZCpUcwX
         qcn1o59bwmQgclIiUbS7+lv2dZoyti5SSYpg0dpZqh3hZLUQtSFRQxCLmL68pPcuA7AB
         Jt+Ay0WJLMqAKLPhncC2XXYef1xZEUtqBDMb+9hfus+UVqeYct0hECeAIlvgnUYw+pyq
         czmEivV8cX77SGbfEtp6k/AKmkiVi/+Z8NjTyD4CyCgOHQoctJa+LMhZhaMed5TgSnTZ
         V9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784661693; x=1785266493;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAv/YlHa2VEFYt54c/rqc8dCQWbyXaL++Oe+Q4jkiPU=;
        b=Nz+ejV6Zm1TC2M4CMbnPT4ay51rISIIbFin3VkByucSRoCh091FMh9vbsdZSjTgeGb
         5K8WtpqMjbS7Cbc/sTytxfDcQBNwOu50ELKGFYPj9NhxYSnCT5KfJxkYlwZUREOx393m
         Sopq07S6+8gXELLxv20WzdYcdQpNi2Y8lwJsy/Drh0UjpiwK9eLFa7GGcRR59Q1vlQy1
         cbprjyEo1WNP1eiduvuwHItYPmxwveDQpaY38yBPxXPYeseEiMmIyaZCxY0bcD1wsWKd
         D8DECfyK8VKvNwxEUlQbfO0KgfKf+0lOFCxJv/jyhRlloRZygVsszKblvuHDmjWDyGmd
         Ch9w==
X-Forwarded-Encrypted: i=1; AHgh+RqvTbHh+DkrI5E1JtwX1hv4S14dosL4zRQ2bCvDvs8AMZqfe23XGoiyajIqW4jAYsgw1rwMN40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMbyMA62j7TZTsyVyJgZfeG5z4X17cYANTmdh9VbbtTel/i/L
	KwecklTbSS+aI8VSXCnyui7hn3RpwW03M84rvLPErGGgC82U5dXFAJs8
X-Gm-Gg: AfdE7cn5mVP9X7Z3SkY0zAMR0GmuUne+FwxQIKrqioUx37sVuiIz6rALHAA7ebXWIVj
	snK66gItoRp9XSjX1QD2M2JnC2B5SpKT8OsINwCAgfDOnn8TELm51PdWZS+kLESQ70ssYZhpyfb
	8HLviqnHqK/md86B1rgxZguxOqkjgg2IIa/ilOL1nZ7yE4XgGj3pgA2Ye6cz1KMiC2Gn1uQZp0W
	UinSE8O/5uSO8BXfJukWcjISlsq3/yjwyoCcx3myHGjIA1q1wZgUDUiLM/FzFu5VKYTRxRnK3d9
	ADpRbaxyylW3IKg3m53ceV2Q4pI2SekdbWDOCHjXVd9bjBochFP0S6rV3jEF0//u9OgomNOfik1
	iRJCrBmaUY8pCwKt8RaO12G6gbMCjMG+2P/JzUvyGTkZ7WjdTnJv/mI73e+dtpVTMSMA3By6x2t
	VgQ3oId0I6rDIm9bewoLhgof/nAeZa0lqMuZGCn5g7E6bO5bpdx0Rp1pHZ50W4o0H7Wdxpn7A2S
	pS4hnZhU3I+cGYrO28R
X-Received: by 2002:a05:620a:690a:b0:92e:5444:9274 with SMTP id af79cd13be357-930b3ec8d65mr1909349685a.30.1784661693544;
        Tue, 21 Jul 2026 12:21:33 -0700 (PDT)
Received: from [192.168.86.61] (pool-71-191-208-38.washdc.fios.verizon.net. [71.191.208.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b92c0sm3370866d6.6.2026.07.21.12.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 12:21:33 -0700 (PDT)
Message-ID: <190879f9-2447-449d-acf8-9f9e26651b24@gmail.com>
Date: Tue, 21 Jul 2026 15:21:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/5] hinic3: Add ethtool statistic ops
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1784538912.git.root@localhost.localdomain>
 <e7bd2732afe29efdd23ce79c323bf91771cfed82.1784538912.git.root@localhost.localdomain>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <e7bd2732afe29efdd23ce79c323bf91771cfed82.1784538912.git.root@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 8:53 AM, Fan Gong wrote:
> +
> +static u64 get_val_of_ptr(u32 size, const void *ptr)
> +{
> +	u64 ret = size == sizeof(u64) ? *(u64 *)ptr :
> +		  size == sizeof(u32) ? *(u32 *)ptr :
> +		  size == sizeof(u16) ? *(u16 *)ptr :
> +		  *(u8 *)ptr;
> +
> +	return ret;
> +}
Why is this needed? It looks like all the counters in 
hinic3_rx_queue_stats, hinic3_tx_queue_stats, and hinic3_port_stats are 
u64.
