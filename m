Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E537C0E5
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585203; cv=none; b=ZcHopeTqRZhPPFKGh7XlRPJy6Mx0Hwn+YF4EMIhe0s8+bWGxlFngJsIXra9zqHyV0VlE9wSOR6HWH0Jb95TNca5ZllspdGidq7TIdzBwRwhbYzHTwlGKkd+w3qEf6vNkkFh6fcmXVqkdYZ3zKi7slnJg9jzAcIiNaO+/Vu0DQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585203; c=relaxed/simple;
	bh=lKaR0Ixsn+KEvclU3kMBfFrigzuusHT69/qAMDdM5R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKzOgaDLCxdfrXI1jsj78VYvF8/wh1idB9YojXoS7nm2sd9VzVbFA5S4qizw8BLGAo0fUjBeCGdzfnrpPsflstq6h46heJq2a1N4tQO2jQ/9NyEVrzIm52TNyc9f2A+nYPsfOw0AKCEnHkrtDdAaJ0HXikRqpjY5WIgIs4XNW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0yAHr6c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTR2U7rm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0yAHr6c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTR2U7rm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783585201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DozTIR+nzUC02mS+REQ9tbPGX8t0sdwCKHYcEWb+v8M=;
	b=E0yAHr6cBkBSU4lxgR2NGJ8N72UZo/NumMwL8NKxjLVRoG68mMnq/nCqIAHBqDLxJGdc5M
	tD8dXhHcY1IS1lwA2VUg5/QwRTTxDc55L3erzMuWWLgbf14nJ0SBZroNvFAx0cJaxADNqG
	AYbjS5DPD7V3sfF+NPerL7u9nAkdIGA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-9A-6Zo2HNMaKv-ZTuKqp4w-1; Thu, 09 Jul 2026 04:18:32 -0400
X-MC-Unique: 9A-6Zo2HNMaKv-ZTuKqp4w-1
X-Mimecast-MFC-AGG-ID: 9A-6Zo2HNMaKv-ZTuKqp4w_1783585112
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493ba771d1bso14834535e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783585111; x=1784189911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DozTIR+nzUC02mS+REQ9tbPGX8t0sdwCKHYcEWb+v8M=;
        b=WTR2U7rmTcW5OIXjhb975C6ADmLz4oCDYu9KKy0eIqAxOftwKwEm/fUdg7PMbvfwIu
         ZEahg/paLKEDZYIUlTUfrX3HJBot0QRJZ5VpnOgRRDBJMr7f/JBQvoAbOUHL6URCOll3
         E52PkMJKmwCUNJoRYSsUt2VfNvDJ1TA3p7LFu8ycbT41hnWevkpI8YxihgO830FOakCV
         U2Nh3Lv+bZRiAWqhoSixBXFyXD9QTLQw3LRP5CBqK9mpuYBePlUD98pAEsWuvker2kWI
         UxAvGbsp/m469ScD96zbUlZFQUfomoshc8zAC07Az0Dacu7B6/7Zhkxhe+R4xJnX7n/C
         WiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585111; x=1784189911;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DozTIR+nzUC02mS+REQ9tbPGX8t0sdwCKHYcEWb+v8M=;
        b=eNhGjYSvj6q1JyBY29PqgwXexJ5t+HgVyaOoE8b9rj4TjLdU5D2f2lMQtLu0YyeJV0
         LVgZriZ6O0N/T6a+Cj2sqtdVEc0lX4QWpOtcvgMAXwKfab4T+gjLb+p6LZG0jEN7ELM/
         rtxFCw8cs/hdL3M1pBfDgASuinXQT7YO04MTjeqjnyyfhrM+4S/mZqUcp7ruvmGs3Ezm
         3CqsSfokjbZ2WYPkk0W9oHbU6Fz1hEFFZsdExmiid039O36olZVQmB0FndgGjvCDV2jM
         OIooKiWdqYQsfDrRhE8j0Vq2s/KiKk78axPi3xVAcHqrM3paEL0di9CZbpI3Ldoz2X7T
         UeyA==
X-Forwarded-Encrypted: i=1; AHgh+RoQVaWIOPzGFw1fcBnfAyig8z5VWpKsXhcAIAkHiqT+7AF1+Zy5ptBbJbFdunpLUp9GzLvfGyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygSVMcuMXqKEEvbpqPQaBwsoF49/OZDO/yb1B7pMY4zs1n/pr
	ga3D4wglFzZ2pArjtpjvY9Vx7Ckx1FpiyjgWyQu/R6qJIh1uzAffgNO0y6JCAF3mqr0uBhJ9cCq
	6PGX6k3MgfI5eG8DNhqc8CcpDUOQvz8xWAQyY8MLzT/zwwkpTrXmwHyZ8tQ==
X-Gm-Gg: AfdE7ckLczghGOG0RBL6HLDjrxjN2/Ky4OuM7kBIFgZSuPQ6wMiQ5bE8jshcuqe6wd1
	dbsZmLyTryftW/QakxgM3ulYpjS5hx8FHOUwRAeXEShhYglK8gGtLKnsjB/lee4WCl9Oti/XKMg
	3qyN1ioCm27Eww6cegS4CnYP+FV6cCvwFTv1ISWrEJaGc7kIF5N8zAR9CG1oXg5j3CUot2kESEh
	CKc7s46nbwMLgQzKuyglk7R04bYL8VkU59y7DbHq+1jvJ94u22ZzuoYO8QDG9mA+0RG/r6JqcdF
	ouTL9Kfimh1G7RG0wOExAvUmdzrs7r1UCjohBh7oBPI/KmPcpQJYHp/LNhEXrLmhnjEx+G+yPIS
	KKV7+Od2v0bmXS/Nb6qTMaVxKUl2BO3ymXGWQxcOPr+IsXSsllQAo2LDhKtw1u7mOfwewtpQm0E
	jBMFp62tL7MFyo
X-Received: by 2002:a05:600c:138c:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-493e688c6dbmr57555435e9.6.1783585111582;
        Thu, 09 Jul 2026 01:18:31 -0700 (PDT)
X-Received: by 2002:a05:600c:138c:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-493e688c6dbmr57555085e9.6.1783585111167;
        Thu, 09 Jul 2026 01:18:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6fb526sm48068405e9.15.2026.07.09.01.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:18:30 -0700 (PDT)
Message-ID: <58a19cc6-e22f-484f-b1f4-4cf063ce73d7@redhat.com>
Date: Thu, 9 Jul 2026 10:18:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org> <ak0SYEOvw6K_8C_w@chamomile>
 <20260708103525.GJ1364329@horms.kernel.org>
 <8d5fe948-6979-46be-866a-69a98ee391d8@redhat.com>
 <20260708183252.GL1364329@horms.kernel.org>
 <20260708190451.GM1364329@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708190451.GM1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 9:04 PM, Simon Horman wrote:
> On Wed, Jul 08, 2026 at 07:32:52PM +0100, Simon Horman wrote:
>> On Wed, Jul 08, 2026 at 01:10:58PM +0200, Paolo Abeni wrote:
>>> On 7/8/26 12:35 PM, Simon Horman wrote:
>>>> On Tue, Jul 07, 2026 at 04:51:12PM +0200, Pablo Neira Ayuso wrote:
> 
> ...
> 
>>>>> I think this patch is not correct.
>>>>
>>>> Hi Pablo,
>>>>
>>>> Of course you are correct.
>>>> Sorry for not realising this earlier.
>>>
>>> Human slop here made me wrongly apply this patch. Could either of you
>>> please share a formal revert?
>>
>> Sure, will do.
> 
> - [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
>   https://lore.kernel.org/netdev/20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org/T/

Thanks Simon!

/P

