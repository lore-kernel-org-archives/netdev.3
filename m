Received: from zebra.wilibox.com (zebra.wilibox.com [62.77.155.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882E298CAF;
	Tue, 21 Apr 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.77.155.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750511; cv=none; b=G9bHFMjJyoxWQCKAonv3jxaIV9rrWE4qCGp0txawqHzklDlFinvVWHmIyCGQmAEjuPq/J6p9I7uDLP1bI6WegTFSYBwtg+qNZAGN/ZtqrBQtLck5/0PpZfFk2yQMxy+OwbYbkHtUQ6IyONqKK8/nc7z/cZnT2kqVEwuWnCPRFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750511; c=relaxed/simple;
	bh=cnIPRnm5PBDDyTR/zR4Abc3zrjVGKnSf65OYRnzPwag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4uuCOqxNq3R8WCjjU3zxu2jovmKJC1H4dM8dEBRkz8KSAT2eOYkAvt4RGmI4DT7DrWF26rj6NxGoyDFeNgnFMHdQyiEu44dDNNg6rjRkHwXJ+NLKWYblW8557YoQkrIwp6tE9KakZlkUi1wkoTo49/0MtBpL5LY9hGeJWa/tuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com; spf=pass smtp.mailfrom=iconn-networks.com; dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b=CeRyGg82; arc=none smtp.client-ip=62.77.155.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iconn-networks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b="CeRyGg82"
Received: from [192.168.27.140] (unknown [81.7.79.211])
	(Authenticated sender: ernestas.k@iconn-networks.com)
	by zebra.wilibox.com (Postfix) with ESMTPSA id 6DEE0173567;
	Tue, 21 Apr 2026 08:48:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iconn-networks.com;
	s=default; t=1776750502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7axhCo2WSbzDMi6IUqJOJ6DIevO+LG7hpx8OlTUlGs=;
	b=CeRyGg82xs6Q8jbBKtL28ijMxmyN0PllGulnaNpzX2t0+kGz2h2JDv1yEhDFNaQX4bk4lC
	rdt9SE3ZWR4wfw1GtHV9ZAQkxAJafxOG2ULbwU9E15SFTLsErqx2wfrThfqofjFEvY61Oj
	IR0XrRWHm1OFpZ7NWxV06Aw5RIMr1X70xGUn4LLHnKH3YU1ysb0lscLEHEJmy+AXskEluY
	tR2h8ZPDo2hD0DJJs2lI/plnA+HZA3927ogPBSlEi7OkRIxdMDLKOZmUP491tIYMLcvNi+
	qWx+tz1rmEm8gsgQ3nXzf22Jk/iFbMoZeASLXbDBAYt41I/VQq8BBAt+hjGJfg==
Authentication-Results: zebra.wilibox.com;
	auth=pass smtp.auth=ernestas.k@iconn-networks.com smtp.mailfrom=ernestas.k@iconn-networks.com
Message-ID: <6a04d2fb-e682-48f0-b095-4c12df50badc@iconn-networks.com>
Date: Tue, 21 Apr 2026 08:48:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] llc: Return -EINPROGRESS from llc_ui_connect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
 <20260420114138.1aa52551@kernel.org>
Content-Language: en-US
From: Ernestas Kulik <ernestas.k@iconn-networks.com>
In-Reply-To: <20260420114138.1aa52551@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-20 21:41, Jakub Kicinski wrote:
> On Wed, 15 Apr 2026 09:34:57 +0300 Ernestas Kulik wrote:
>> Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
>> change and returns 0, confusing userspace applications that will assume
>> the socket is connected, making e.g. getpeername() calls error out.
>>
>> Set rc to -EINPROGRESS before considering blocking, akin to AF_INET
>> sockets.
> 
> Please add a note on how you discovered this issue.
> Including whether you're actively using this code or just scanning it
> for bugs.

Will do. It was discovered while adding support for AF_LLC sockets in 
libcoap, the usual code path for client connections was failing due to 
this specific issue, so I figured the behavior should be analogous to 
AF_INET.

>> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
>> index 59d593bb5d18..9317d092ba84 100644
>> --- a/net/llc/af_llc.c
>> +++ b/net/llc/af_llc.c
>> @@ -515,10 +515,12 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
>>   		sock->state  = SS_UNCONNECTED;
>>   		sk->sk_state = TCP_CLOSE;
>>   		goto out;
>>   	}
>>   
>> +	rc = -EINPROGRESS;
> 
> Isn't this a bit of an odd placement? ..
> 
>>   	if (sk->sk_state == TCP_SYN_SENT) {
>>   		const long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
>>   
>>   		if (!timeo || !llc_ui_wait_for_conn(sk, timeo))
>>   			goto out;
> 
> .. I suspect you mean to target this branch, right?

I can’t remember now why I put it there, but you’re right, that would be 
the better place.
