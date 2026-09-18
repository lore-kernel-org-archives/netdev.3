Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE451DB14
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756970; cv=none; b=hsDr54UGEnERdmA1tHERYP3ja1+tvOwt/TuJZGIRWRNRVk54ZnvwYVOQe/oP/hL4JBaPImwKiLJWJiYzq1B7Z4TpUCS2NkQjkFLd/aIDHKEdRzzFDr8xjpuxCFOuGJgyfVb4YyAZ7yWMi0Pf/B4v09zmKb4EKo+8vV8YI8WMXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756970; c=relaxed/simple;
	bh=kjfD2pR1wI5asH4ZzShDy/txAmoLafJgTjxtj3BLThA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REqaIgECXcjcINw1jnCPrDU/5lan9tMRsbk+xdmeV/ngJVILBB2Wvg7pV4mwi/uPJ8K1EgQfP72uW5WEIdohcAkZAPMUEJbRw7MPHzqB/MzcwjHDyjIWf09T565clHnVo26I7hUE3W8aZTzMe7wKooKVTGYjZrgR//z0tk71Kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb5iYbVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb5iYbVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9571F000FF;
	Fri, 18 Sep 2026 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756962;
	bh=pgJgjzAcNQpjk2T6p7VSHtMr3mphioACZ9gHRblGaB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bb5iYbVGgKmDX37APnRMSraFuzMvzuvtokmZRJehXX+A+J6ObDCiLVyqv1lynTV71
	 3hzsFzsOPp4SdF7Zf1YNTrwGdQesvqsE2SXfCbHYECDcyyEaGOSrbqkhZd1lhUD9ey
	 C9cAeXfEMkaBRjY6WND9yoHVDE9MHCy8oB1AAxg6nZhVfYlsxvKYGLPTIM0EUYUR7O
	 K8pdukS+nxShNjk2IbLgl1PnQdFapLDhIpZW4FbQMNrOv2SjlnCv4ZyqBoVXKC7OqX
	 hFNgJLoLNJpWvPdfumu6eKHS7hpQUWbWSysthUVPojkH1LawN4l2A4MsYCn+9zxeVq
	 3m2XIIIs9pSTA==
Message-ID: <b6a3076f-7459-4c24-a7f2-fe5c6c88b9d1@kernel.org>
Date: Fri, 18 Sep 2026 12:42:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB
 changes
Content-Language: en-US
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <58147155-1763-4e10-a3af-f8751c1505d5@kernel.org>
 <20260918065103.28295-1-ralf@mandelbit.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260918065103.28295-1-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 12:51 AM, Ralf Lici wrote:
> On Thu, 17 Sep 2026 13:09:10 -0600, David Ahern <dsahern@kernel.org> wrote:
>> On 9/17/26 4:09 AM, Ralf Lici wrote:
>>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>>> index 7f69e8890b5b..a28974cc36e8 100644
>>> --- a/drivers/net/ovpn/udp.c
>>> +++ b/drivers/net/ovpn/udp.c
>>> @@ -250,7 +252,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>>  		dst_cache_reset(cache);
>>>  	}
>>>  
>>> -	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
>>> +	gen0 = rt_genid_ipv6(net);
>>
>> this detail about routes should not be buried here. rt_genid_ipv6 really
>> should be local to net/ipv6/route.c
>>
>>
> 
> I agree. Keeping this detail inside the IPv6 routing code is exactly why
> I sent the RFC linked from the cover letter, and I would appreciate your
> thoughts on the proposed approach:
> 
> https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/
> 
> The pattern of obtaining a dst and only later sampling its validation
> cookie when publishing it into a persistent cache is widespread in both
> drivers and the networking core. It is racy for IPv6 routes with
> rt6_info::sernum == 0, because rt6_get_cookie then reads the current
> fib6_node::fn_sernum, not necessarily the value corresponding to the
> lookup which returned that dst.
> 

the patch is focused on detecting a genid change at the time the dst is
cached. Why? It can just as easily change immediately after the double
genid check, so you are not really solving the problem.

Staleness is irrelevant until it is used again (ie, genid can change
many times between dst_cache_set and next use). That is the proper time
to recheck the genid and refresh the dst as needed.
