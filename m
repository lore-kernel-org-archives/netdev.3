Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF83DAAC8;
	Tue, 15 Sep 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440105; cv=none; b=OBzHVLbhpiil7j1mQLk5ecWzSi8zWecIxks3B6qIviw7ZtL6vlynO206+MxWYRL1/jsBy6cGs3F0NGQgL7ZxatLzeqgybpi5mFkT+QRQYAFsBtnfE0VLr3DOjThvLuLz1iYUBrRb5Ks0hcmVal2zCckwFogHl3lgFRJHyh1tBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440105; c=relaxed/simple;
	bh=JVIEa/gea+867WnaE11Nm0mXiDtfssVU289tE8mXg84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4bOticBwRhWRmtepZSfxrOyhZa26VqaQc4wBX3K8DNgA97m52GTjp69AbxU2aIah7JNK1xTCdx8y+4E1v5Ofn0hMJtXLuDGU0rof7CBTB4062KB5pN3+ReyszhCJ88gg/EIe9ARvWlEWFR89S7L4GHep05P2rerlVa5cFEWuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=b1G7VbMK; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="b1G7VbMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mdNO0xvMaNHs14Q/p5vFBalZr/pCJ55ZxUZivp+7FvA=;
	b=b1G7VbMK0t3ACDfq8ipE13L2kVzIn7r1nFzp6leGKJuEVZSMQIxKOQS5ZfAd6d
	XruLBDdNbwcqXZuxevxYcjrynLoEK7j/T2hxLqUC3Su/srGlN631kxNAIa5KaQGQ
	vhPSRQVea4rcmKxooFHPhKUN4BZQmQoaByrZuV9JL/gcE=
Message-ID: <dd9352e8-1067-41e1-83d3-f48dcff3cbc6@126.com>
Date: Tue, 15 Sep 2026 10:40:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fib_rules: add FRA_GOTO and FRA_L3MDEV to
 fib_rule_nlmsg_size()
To: David Ahern <dsahern@kernel.org>, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tgraf@suug.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260911071241.2701784-1-xiaolinkui@126.com>
 <962171df-34e5-4c98-bd09-8cc7f8caf3bd@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <962171df-34e5-4c98-bd09-8cc7f8caf3bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHEogzsKhqrkAdBQ--.60837S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW5Gw47WryUWr4rAFW7CFg_yoW8tr48p3
	s5C3W8J3Z5Ary7ZrsFga1rWryFqa43XFy5Jr9Yyayjyrn8tr4xGF97KF4UWayUXr4kWr98
	ZrWDWws293y8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaJPiUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBT91GqosDTQGQAA3m



On 2026/9/13 09:06, David Ahern wrote:
> On 9/11/26 2:12 AM, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> fib_nl_fill_rule() emits FRA_GOTO and FRA_L3MDEV, but
>> fib_rule_nlmsg_size() reserves room for neither. Its only caller,
>> notify_rule_change(), allocates the notification skb with that size and
>> treats a failure as a bug:
>>
>> 	/* -EMSGSIZE implies BUG in fib_rule_nlmsg_size() */
> 
> not really going to fail since the size has so many attributes that are
> not applicable to this rule.
> 
You are right, the other attributes reserved in fib_rule_nlmsg_size()
already provide more than enough slack for the common case, so the
missing FRA_GOTO/FRA_L3MDEV accounting cannot actually overflow the skb.

I will drop this patch. Thanks for taking the time to review it.

Thanks,
Linkui Xiao
>>
>> A rule that has both a goto target and l3mdev set needs 16 more bytes
>> than are reserved. nlmsg_new() rounds the allocation up through
>> SKB_DATA_ALIGN(), so the slack hides the mistake most of the time and
>> the bug stays latent, but the accounting is wrong and the notification
>> can still fail with -EMSGSIZE.
>>
>> Reserve the two missing attributes, keeping the order used by
>> fib_nl_fill_rule().
>>
>> Fixes: 0947c9fe56d9 ("[NET] fib_rules: goto rule action")
>> Fixes: 96c63fa7393d ("net: Add l3mdev rule")
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   net/core/fib_rules.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
>> index 7df216c17c67..5e84bc740191 100644
>> --- a/net/core/fib_rules.c
>> +++ b/net/core/fib_rules.c
>> @@ -1133,7 +1133,9 @@ static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
>>   			 + nla_total_size(4) /* FRA_SUPPRESS_IFGROUP */
>>   			 + nla_total_size(4) /* FRA_FWMARK */
>>   			 + nla_total_size(4) /* FRA_FWMASK */
>> +			 + nla_total_size(4) /* FRA_GOTO */
>>   			 + nla_total_size_64bit(8) /* FRA_TUN_ID */
>> +			 + nla_total_size(1) /* FRA_L3MDEV */
>>   			 + nla_total_size(sizeof(struct fib_kuid_range))
>>   			 + nla_total_size(1) /* FRA_PROTOCOL */
>>   			 + nla_total_size(1) /* FRA_IP_PROTO */
> 

