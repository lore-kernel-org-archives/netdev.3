Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A443BDC4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832178; cv=none; b=iJ4aYdrMdFfs1/sfIWHNTb0GFsBOS4oeGxY85VG7/tAk1n+8214FN/VXBDWBYajeE6boLnI0yuuAGvQOeRlP8nhllgRB6Y0RBoK/1mTQfO7BIUluVCHoz3Yrke2YeRbv+8Y2+ImZ5Oi6YQ2pKNl1qMPUN9HubHyW1MYEwJyYulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832178; c=relaxed/simple;
	bh=ghUKjuywlxz/hCPWTzHl6aHjG7cd3I+aDHphLy6uZJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXshNoWycTACMT6a+cySG+liMmUHNZ32e8Ccta21Jp0BJfNrkQjdAeoFQc7RYZtp5tbtfrSZOBKGmJY2jLXPnjEsJ3xkGygfVi/IU7snM93tvkjt9IwUxiMZ0c2NcRFVWJhjuVmVHRcp7CSlpQsJxtFdBpTGRrurcvm6fNOQZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TDaxdUbI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDaxdUbI"
Message-ID: <ae705a66-95b2-4721-9a41-a14f39cbfa92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785832174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RU8+Nz4vCEQS2uwrNX9QR2iiYmR7A0o4uhtyvH7UwVI=;
	b=TDaxdUbI2eDi69mU4KlARvdYfEDOm1IOWZKh0EtLYsatPhSBj8ePEhfWqisgoBdGwq0oSk
	hRiw0yXAPDtzyVmpbYy0bVhtN6gHFlrg3NbKZbk/MD61q9LLuK3KjdQA4hSC6daBr4wO9M
	h7E5bffe1y4KQqCKD8q3OHAqq++hX1k=
Date: Tue, 4 Aug 2026 16:28:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: pppoe: check register_netdevice_notifier() error
 in pppoe_init()
To: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Eric Woudstra <ericwouds@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, linux-kernel@vger.kernel.org
References: <20260803085957.142386-1-heminhong@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260803085957.142386-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2026/8/3 16:59, Minhong He wrote:
> pppoe_init() ignores register_netdevice_notifier() errors and always
> returns success after installing packet handlers, which can leave the
> module loaded without its netdev notifier registered.
>
> Check the error and unwind the packet handlers and protocol registration
> on failure.

A patch for the net tree requires a Fixes tag. As the notifier has been 
present since day 1 of the Linux git repository, you can use:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>   drivers/net/ppp/pppoe.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 4a018acb5262..035795b120e0 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -1278,10 +1278,19 @@ static int __init pppoe_init(void)
>   		dev_add_offload(&pppoe_packet_offload);
>   	dev_add_pack(&pppoes_ptype);
>   	dev_add_pack(&pppoed_ptype);
> -	register_netdevice_notifier(&pppoe_notifier);
> +
> +	err = register_netdevice_notifier(&pppoe_notifier);
> +	if (err)
> +		goto out_unregister_packs;


You can move the registration above the dev_add_offload(), so that the 
unwind path is cleaner.


>   
>   	return 0;
>   
> +out_unregister_packs:
> +	dev_remove_pack(&pppoed_ptype);
> +	dev_remove_pack(&pppoes_ptype);
> +	if (IS_ENABLED(CONFIG_INET))
> +		dev_remove_offload(&pppoe_packet_offload);
> +	unregister_pppox_proto(PX_PROTO_OE);
>   out_unregister_pppoe_proto:
>   	proto_unregister(&pppoe_sk_proto);
>   out_unregister_net_ops:

Best regards,

Qingfang

