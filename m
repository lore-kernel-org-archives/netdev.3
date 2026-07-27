Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997A42089D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173222; cv=none; b=MNqQI6zk+IRItZD2QBmVblHJBSoadPidqx6vUGnrNpd0xj7yMVpocqLbGuvSKHq1BHyKgC6sT2tdczTyYixTKE8ARrXmXhPFEKCNc9aYm31N0RbYrsJHj0ES7N/PM9MKjZgVYOlMOIX4Q1TIKPlBaTiSqhJ8scmOAkpi6wTNkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173222; c=relaxed/simple;
	bh=iUroA9DGtoqcrLKXv4AlKjK6bV1A/bQgIhYO/isgD+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQB09H2cf40SA0oYij31oj+ZtvvIqux++d/rSjp1iFksvmfLfUfhVwmpebloi8TkhjUYFtAH+0DD5FitD0LzAz9Y0ZT0LETFuICiAUv+ttuOGoi9kgiXo7+X1anCtqJjIPirDndRGl4141yC8OCNapbrglhFHsUqjH211p+HeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI9ni+fQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI9ni+fQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so33071225e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173209; x=1785778009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l534wSL0n04RvCoYPuFBi1CqxAk3rFhmvrY80RgXDMY=;
        b=nI9ni+fQN+vr/L3TN9lGXkRhrH0GgqJZN4aEkKGCnSbBFjnXVEJibGxjucclHBOksT
         YAL/JbSdvMVefq6XGcHZm11cg+OBa0y20hLZLUPaNHZfrmhbDlZo5Tsjntn1YZaMXn+T
         NfjeD3JMLeYtjgBzDD6ev/Un+9y5u8Nzw9EceWGY/2GJV6rXoJbp+r8RIPd/0vIjsh/c
         Z2zZq0ipFyBMlbwlRS2xlBWr55yhzlPH0MMxAcyMqeXfue8X+6THoHERs7IoDCbBjMa0
         smfmOglENw7OahBtbk68LxBM3nfPugOKuOoYT04FmlEK4NsfzBUh7nFsDCNuEAkYYFKN
         MJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173209; x=1785778009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l534wSL0n04RvCoYPuFBi1CqxAk3rFhmvrY80RgXDMY=;
        b=a71HyWn6Cf0wzBY8Z+wAbht3cNHkuwh+k7QvS8wvI63nnUDDwxvIilC2YeWFTvaIi3
         8RNB3wmH4JX3oY7GUvjBXBxFSjl6mhFsFFayW/BqWdY7+yZLVL9OxW+j4vjtHDs+lep8
         QtbLasUKWIhO52sR4tsMYTwCHi8b+pnmiA3zUiwOKWNfcq56ymBiEXHH4iN7y0UbVc/a
         I9ZWF415WOr4g59y0bcjOQYO+EIIBVI5Mg8l5WZ/yHLATTJ0d1IC4Oa9kTfbhZM9KhIH
         JJp9kWccOx9/hEt5lppv2Prstx+UFk0UEP1onj/7TocP8mz+bdMqnqe8ApLd7TkRR32w
         iWhQ==
X-Forwarded-Encrypted: i=1; AHgh+RptLayB7H2clnU//gXDW1bSOHKq5kKvEmck8/I7jQQsRIllvVytEGUAXn/LcYR752bRDwoc1n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1CmYZU1atB+Zp1OoBGlgedIk3db9i7DJ5IOpglqshhfECDRm
	kf8hPAwWd4Znxrd1U9WlOGcbC4EnGhy9rdjwoR17Rhqy4ZuxO1iqCu7U
X-Gm-Gg: AR+sD12hODrd8gN7CSB0DWNSek2JGeIVCli7JS2hhbopOVXxFRQ0nLDncNpAnlUpRnG
	aSCeETxh0IKrHdydnSE4Rvz9NILQiNG/xoukXez8HVHcw9GiPihYVELnnJ/47qP462araxIi+Ia
	lKITyo+0wI/hNozclX6Ouhar4/hErI5o+A3ysWW/qHBq3HtM4L/7mtYUGGTaa1zfyLufPaNzNp1
	ImqBG9VLqml5o8fGBhmUr+EJGnZ88IBi8OqHipdYnlJLxP+KNG7ovU4orc9tSp8XwC+rzVW44pm
	a4EO+zQpwNs4G++w+sOoARlP6N8X3hgZqvDTNJQFrK54hUl6mByixYKNRG8oriEjbhIvRFRGPl4
	Jhv/NCvtGYksmbgOlw9J30K4kti2wjowWUguTl3B9YShrQnN1e2X721RYLf0v36Xy1JcUrjOarv
	CReOvoT5ddNPPCOY5xXnRhy/V7L/VlPyaxZBe2wr7YHPrWayUlLoHt2XatxWvVHkUKx5J/5DSWt
	/lYdDcNfItv3dLsqYgrmVA2cc0gMkhUKJ1yEFvQgSf7wA3iw9ib/7+HHPE4grPzejUBUh/6HngY
	+4v2udVQR/nc3ENf/UC9
X-Received: by 2002:a05:600c:3595:b0:495:7379:17b1 with SMTP id 5b1f17b1804b1-496c4fcc80fmr550765e9.30.1785173208761;
        Mon, 27 Jul 2026 10:26:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4f63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm51842962f8f.11.2026.07.27.10.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 10:26:48 -0700 (PDT)
Message-ID: <7e424782-2852-449a-9e47-62c299e0236f@gmail.com>
Date: Mon, 27 Jul 2026 18:26:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
 <ameLB_goNrMbscXO@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ameLB_goNrMbscXO@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 17:46, Stanislav Fomichev wrote:
> On 07/27, Pavel Begunkov wrote:
>> We should either have net_iov or page backed frags in a single skb,
>> otherwise it blows up down the stack. Don't allow mixing in
>> zerocopy_fill_skb_from_devmem().
>>
>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
>>      the former + for consistency.
>>
>>   net/core/datagram.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>> index c285c6465923..173b5d97bd40 100644
>> --- a/net/core/datagram.c
>> +++ b/net/core/datagram.c
>> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>   	size_t virt_addr, size, off;
>>   	struct net_iov *niov;
>>   
>> +	if (i && skb_frags_readable(skb))
>> +		return -EFAULT;
>> +
> 
> Maybe we should do -EMSGSIZE? It is already properly plumbed via
> skb_zerocopy_iter_stream (and you'll hit 'skb->len == orig_len')
> and it hits 'new_segment' in tcp_sendmsg_locked?

I made it consistent with zerocopy_fill_skb_from_iter(), don't see
the point of making it behaving differently from combination to
combination. Do you have some use case for that?

-- 
Pavel Begunkov

