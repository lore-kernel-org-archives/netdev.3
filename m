Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AE3EDE40
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853283; cv=none; b=ajov3hbVxZB1io7Onj53oN0H84E+Ues1sVBLjdiyVA++k1u+aOPrwUiXHbIPklQq9DGhScXFGvn6GG8Ft+VfBiKQmrIc8ulgyfDb0nCmY4d7gvT6P6Wz2+uGTTqnX+8CGx0/TW1NI39C9CUHMoajxvi12o9bUFhFwLtxH4OcjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853283; c=relaxed/simple;
	bh=OJ/HJEV95zbKoYJ3mdTiTc7gPIW1tf2Lw+OdLjlWXmo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=js1dXcQWPKMVb66aBcP5Y7zyzniSgKr7dS7N0Gqh5c4rq3l2khh9U3OEWQN1ox4puHuhLVmEm2/CVUGZxp8IT7GWQScMhbW5cA1feN9e4/zcAo7yH5jkLxXSdzN5+PebNgBKxhkkz2IcGYSk+WFxqTzvUy2X1PYcQt36O/MwKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y4pbGpSh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y4pbGpSh"
Message-ID: <fca5745a-dfa4-4e90-99fb-483536c94591@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785853264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmaqVfZmEPNNHuq2gS+2tfkTJb121im81Q+j52YT7hY=;
	b=Y4pbGpShvNJJsLG3uUF0TaJUryc3Q69KXqScBXe1H7/FQtyzBXC9+vG2/rLrQz/JYScNWt
	SGt777tjofzz2jF4BScIkz/6+AfS7kgxlvlAw/aZ6eCvygsRv6V9MEySiePlQiKzZUCNVz
	pRloTSNZ13vjQvTru7653lY/B0WfAcA=
Date: Tue, 4 Aug 2026 22:20:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: pppoe: check register_netdevice_notifier() error
 in pppoe_init()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Eric Woudstra <ericwouds@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, linux-kernel@vger.kernel.org
References: <20260803085957.142386-1-heminhong@kylinos.cn>
 <ae705a66-95b2-4721-9a41-a14f39cbfa92@linux.dev>
Content-Language: en-US
In-Reply-To: <ae705a66-95b2-4721-9a41-a14f39cbfa92@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/2026 4:28 PM, Qingfang Deng wrote:
> On 2026/8/3 16:59, Minhong He wrote:
>> pppoe_init() ignores register_netdevice_notifier() errors and always
>> returns success after installing packet handlers, which can leave the
>> module loaded without its netdev notifier registered.
>>
>> Check the error and unwind the packet handlers and protocol registration
>> on failure.
> 
> A patch for the net tree requires a Fixes tag. As the notifier has been 
> present since day 1 of the Linux git repository, you can use:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
>> Signed-off-by: Minhong He <heminhong@kylinos.cn>
>> ---
>>   drivers/net/ppp/pppoe.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>> index 4a018acb5262..035795b120e0 100644
>> --- a/drivers/net/ppp/pppoe.c
>> +++ b/drivers/net/ppp/pppoe.c
>> @@ -1278,10 +1278,19 @@ static int __init pppoe_init(void)
>>           dev_add_offload(&pppoe_packet_offload);
>>       dev_add_pack(&pppoes_ptype);
>>       dev_add_pack(&pppoed_ptype);
>> -    register_netdevice_notifier(&pppoe_notifier);
>> +
>> +    err = register_netdevice_notifier(&pppoe_notifier);
>> +    if (err)
>> +        goto out_unregister_packs;
> 
> You can move the registration above the dev_add_offload(), so that the 
> unwind path is cleaner.
> 

AI-review found a use-after-free. To avoid that, this needs to be placed 
between register_pernet_device() and proto_register().

>>       return 0;
>> +out_unregister_packs:
>> +    dev_remove_pack(&pppoed_ptype);
>> +    dev_remove_pack(&pppoes_ptype);
>> +    if (IS_ENABLED(CONFIG_INET))
>> +        dev_remove_offload(&pppoe_packet_offload);
>> +    unregister_pppox_proto(PX_PROTO_OE);
>>   out_unregister_pppoe_proto:
>>       proto_unregister(&pppoe_sk_proto);
>>   out_unregister_net_ops:

Best regards,

Qingfang
