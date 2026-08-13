Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDB427FBB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603572; cv=none; b=AjNS+1PZF072eesYS36fibn2JB6a5GGOn9IrYulF0dmKpVUxbD9IOdRp+GEuFX4OkoiljiSVjwKsXUSLTSFHkBAcRv5lwdkBx3pfsgL4/al1NWsF09gtyvGkegDQGYJDPwsC+JC+iWOYyZDilwx0FcDVwTYL+MgxKOzpn6B+Pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603572; c=relaxed/simple;
	bh=BRfobLbfeOJJ0EnO53sItmeTk65R+pAlylFvZIbGPnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMqXtYBqGvAFCSbDesLxzLvrrCsr4hvgeAV59QjmleONeSGoJRIhq8WBjZtV37kGF9rYjyht2rjUEEhNE9cS+6UlVUJYOnbjL3mjpuKMPdqdD0Euz7To18omuylRmMmwxy0d5C6gnnsrTLOAI593oK4PsLd2SzTDgIbA9uncJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FL9QivbR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FL9QivbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=HBNXqTBjBPuqUpGRMyVtC9y5T2+kJGkmKYaqIixwWFc=;
	b=FL9QivbRBtIPOI5bOSj0EXWbhg9oNxGaOr7N8ux4PffIK/STCUt74Ch4aoUu+i
	fDQowFUE/lZ0CYgglUFeeB2Mf/E15NdOWZ/xyHVri1EqNKYHkburyXAhEXD8pIMF
	yzyuSNmdAnB5KKe4yMcxIu1+PDNnwi6Ii6wSjFv94TU2k=
Received: from [IPV6:2409:8a34:e20:2071:80d0:c039:58a9:2d19] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBHhKL3Z31qBabHPQ--.13192S2;
	Thu, 13 Aug 2026 14:45:11 +0800 (CST)
Message-ID: <b6d6fcca-aefb-46ce-9ba6-b9e1036b80f6@163.com>
Date: Thu, 13 Aug 2026 14:45:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ipv4: reject RTAX_MTU values below IPV4_MIN_MTU
To: Ido Schimmel <idosch@nvidia.com>, Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <cover.1786094799.git.edragain@163.com>
 <ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain@163.com>
 <20260812120827.GA3410841@shredder>
From: Yong Wang <edragain@163.com>
In-Reply-To: <20260812120827.GA3410841@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHhKL3Z31qBabHPQ--.13192S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrW5ZF15WF4UWr18Xw1rtFb_yoW5Cry7pF
	WUta93Jr1kJa47uas2vr1I9ayFvFs5J3W3WFn3Wr45Zwn09ryIgrW0ga1Y9ryjgFs3uw4I
	qr1jg3s3Xws8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnNV9UUUUU=
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC1BkSMWp9Z-kgBQAA3C



在 2026/8/12 20:08, Ido Schimmel 写道:
> On Sat, Aug 08, 2026 at 04:01:15PM +0800, Ren Wei wrote:
>> From: Yong Wang <edragain@163.com>
>>
>> ip_metrics_convert() caps RTAX_MTU at the IPv4 maximum, but it still
>> accepts undersized non-zero values from userspace.
>>
>> A route installed with "mtu lock 20" can later reach the IPv4
>> forwarding fragmentation path. With a normal 20-byte IPv4 header,
>> ip_do_fragment() reduces the payload MTU to zero. ip_frag_next() then
>> keeps producing zero-length payload fragments, so the fragmentation
>> state never makes forward progress and the kernel loops until the
>> softlockup detector fires.
>>
>> Reject non-zero RTAX_MTU values smaller than IPV4_MIN_MTU while keeping
>> the existing "0 means use default MTU" behavior intact.
>>
>> This fixes the bug at the route metric input point and avoids adding
>> redundant checks in the fragmentation path.
> 
> Sashiko is correct that this is also reproducible without setting an MTU
> lock. See [1].
> 
> Better to fix it in ip_do_fragment(), in a similar fashion to IPv6.
> Something like [2].
> 
> Sashiko review:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ccd14fb1411b8b9c466065582e43f6a6c0743842.1786094799.git.edragain%40163.com
> 
> And please note:
> 
> "Patch authors are expected to proactively look into the AI-generated
> reviews and handle such feedback as any other kind of review: either
> debate it or address it. In both cases a reply on the mailing list is
> expected."
> 
> https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines
> 
> [1]
> #!/bin/bash
> 
> sysctl -w net.ipv4.ip_forward=1
> 
> ip link add name dummy1 up mtu 20 type dummy
> ip address add 192.0.2.1/24 dev dummy1
> 
> ip link add veth0 type veth peer name veth1
> ip addr add 198.51.100.1/24 dev veth0
> ip link set veth0 up
> 
> ip netns add ns1
> ip link set veth1 netns ns1
> ip -n ns1 address add 198.51.100.2/24 dev veth1
> ip -n ns1 link set veth1 up
> ip -n ns1 route add default via 198.51.100.1
> ip netns exec ns1 ping -M dont -s 1000 -c 1 192.0.2.2
> 
> [2]
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index e6dd1e5b8c32..e6bbae103e4f 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -790,6 +790,12 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	 */
>  
>  	hlen = iph->ihl * 4;
> +
> +	if (mtu < hlen + 8) {
> +		err = -EMSGSIZE;
> +		goto fail;
> +	}
> +
>  	mtu = mtu - hlen;	/* Size of data space */
>  	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
>  	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
Thanks for the review.

I checked the Sashiko feedback and reproduced the issue without route
MTU lock as well, using only a 20-byte MTU on the egress dummy device.

So the metrics side validation is not sufficient. I moved the fix to
ip_do_fragment(), adding a direct mtu < hlen + 8 check there.
I also verified that the old kernel still reproduces the
softlockup in the no-mtu-lock case, while the updated kernel no longer
gets stuck.

I will resend with that version.

