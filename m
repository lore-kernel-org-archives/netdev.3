Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B111374E6C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791373; cv=none; b=UZimZq9NjwJtYButx2VFvrbqVQbYEIF6/GoAH0IDNOxv6niZjQiLlKR6K19mAPzueRCswCvRjCMSTfoK9BEXMefC/A10OeIxX3a+2pMbMxi1rbVUVuLkesIMZw4CHq9VmK4KoV+zPwlyaHGaSPr2gm8ZIhwhws1UpwVbFTrWQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791373; c=relaxed/simple;
	bh=KNAhsO+4pkk1drGeieJrcyyWdWq0hSXLsXMiUQeK1IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpU78dPEapxSmvKuCUTBub2RfWQDjefC7hKCMeJsPoeeUTyfwZ1CjRrd1vp5u0GF4nkVLCkCBI+O2XjmhJqZNLMTWtg4ziIEdKMs8eNRvrrFQ0h8sXao7RlRC0cmX+5n4ibR06FvDRV2UbT/BNNv71Ye3Jwj/D8uXbnE8lM+Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hnWHg00a; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hnWHg00a"
Message-ID: <86e82246-c842-4d0c-927a-52e21a996008@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784791367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCQdKcEX/tTqeLaSJW23dR73y6rZ1TlR2KuEE8PLyKE=;
	b=hnWHg00a7TBXMWVTaVgnRkH0v+5LDF/gxBChq13FKQuqZw6J/KZ+tl9TuKYqtWiLgntRSZ
	x6Jb0JjofAgqBlzjHTzBdB1OM0j9poVa3x5PBmY4maWqcJTplP+Y+0u8sxvE1B6LyycuuT
	BlvS+iHNFUUzjQzxeXXkVA5ebaKMo+Y=
Date: Thu, 23 Jul 2026 15:21:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ppp: annotate data races in ppp_generic
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, linux-ppp@vger.kernel.org
References: <20260722101605.2868548-1-edumazet@google.com>
 <b16aec0f-a90f-4132-820e-239ddadbe8f0@linux.dev>
 <CANn89i+E=JBRGj3cK+6mfVEX+PUjYrpkkWk1dB3VswnW4X_KGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CANn89i+E=JBRGj3cK+6mfVEX+PUjYrpkkWk1dB3VswnW4X_KGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2026/7/23 14:48, Eric Dumazet wrote:
> On Thu, Jul 23, 2026 at 8:24 AM Qingfang Deng <qingfang.deng@linux.dev> wrote:
>> Hi,
>>
>> On 2026/7/22 18:16, Eric Dumazet wrote:
>>> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
>>> index ef54e0a0462a175bb989db8dda895e9ae755965f..cacc4c3a37d2cda0aea2e176e5d0638f959e18a3 100644
>>> --- a/drivers/net/ppp/ppp_generic.c
>>> +++ b/drivers/net/ppp/ppp_generic.c
>>> @@ -866,16 +870,16 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>                break;
>>>
>>>        case PPPIOCGIDLE32:
>>> -                idle32.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
>>> -                idle32.recv_idle = (jiffies - ppp->last_recv) / HZ;
>>> -                if (copy_to_user(argp, &idle32, sizeof(idle32)))
>>> +             idle32.xmit_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_xmit))) / HZ;
>>> +             idle32.recv_idle = max(0L, (long)(jiffies - READ_ONCE(ppp->last_recv))) / HZ;
>> In the original code, the difference will wrap around on a 32-bit kernel
>> with HZ=1000 if the session sits idle for 4,294,967.295 seconds
>> (approximately 49.7 days). With this change, as the difference is cast
>> to a long, it will be negative after 2,147,483.647 seconds
>> (approximately 24.9 days) and then clamped to zero by max(), making the
>> situation worse.
> I do not think the code was ready to handle long idle sessions to begin with.
>
> Can you elaborate on the 'worse' part, because I do not get it,
>
> We perform a max(0L, delta) quite often in the kernel, in lockless contexts.
>
> delta = jiffies - ppp->last_recv ; can be ~0UL if another cpu was able
> to update last_recv to (jiffies+1).
>
> We prefer in this case returning 0 instead of ~infinity.

Now I get it. A CPU may see an up-to-date `last_recv` from another CPU 
but a stale `jiffies`, as the order of reading the two variables is 
undefined (sequence points and memory ordering). So:

Reviewed-by: Qingfang Deng <qingfang.deng@linux.dev>

