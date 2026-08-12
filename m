Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAC368D6F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544455; cv=none; b=d6k+bEjiD9FAdaLZVeDPLduGKfh1YMAzbPX4z2S5DzPP84JPc3GyHXR8Te08DVmobwaRA5Owbhcx3QThMHTSa8ZfpUoBIxwva8cS4uHqVP4Gxq0THvsw+Jc0nNgZTC0Rs5IwPuQbxRafhASRHZkwGGr8LjHHbIeW2/0phFdbWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544455; c=relaxed/simple;
	bh=FTxLxLVcKgDLQ6kEXSlc6/vInwZtDf4XDT1ysP7Hb7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sO5i5XkaQfq4Pm61hN9iCJSshNHXoFXGm17Rs8HUklD1c6gIB7ONKo7jk2ltVH8tL0rl7BIhyRHqBSVHroSpR6itiso0p9FCqcNh7pZ9sLDCtC9sLZBCZhLfIkSkz4HG5sf0LyAxQognVdapYfXs1Hr9SZXzeraIiJxty0ZWeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCZ7wyBc; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCZ7wyBc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FTxLxLVcKgDLQ6kEXSlc6/vInwZtDf4XDT1ysP7Hb7U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786544450; v=1; x=1787149250;
 b=jCZ7wyBcmDj8meISku1mlf1QoMaciSKb+jCVupheilMLO34uDiX2gneZBlVOROhD0IwfjocF
 lpzf8EGmRpLkmqnhzWeM/ySwfoG8MjwvnyplV1Wb4fD46EAMCRHTuf3rYak4VuoI1RM2pKqIf5i
 PARli1Y/0e+ZKa6cU4KUKHrU=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::5:4188)
	by smtp.migadu.com with ESMTPS id c344b6e716f5116a;
	Wed, 12 Aug 2026 14:20:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <70d14646-8140-4baa-88e8-1697690372b9@linux.dev>
Date: Wed, 12 Aug 2026 15:20:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ipv6: fix use-after-free in ip6_finish_output2()
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vasily.averin@linux.dev, vega@nebusec.ai, rakukuip@gmail.com
References: <cover.1786516730.git.rakukuip@gmail.com>
 <4aa3f53bc44e79572c6dd2340ec7b68ef1a3d87d.1786516730.git.rakukuip@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <4aa3f53bc44e79572c6dd2340ec7b68ef1a3d87d.1786516730.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 13:54, Ren Wei wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> ip6_finish_output2() caches a pointer to the IPv6 destination
> address (daddr) before invoking lwtunnel_xmit().  The LWT-BPF
> transmit path or other encapsulation operations within
> lwtunnel_xmit() can reallocate the skb head, freeing the memory
> that daddr points to.  When lwtunnel_xmit() returns
> LWTUNNEL_XMIT_CONTINUE, the function continues to use the stale
> daddr pointer to compute the nexthop and to look up or create the
> neighbour entry.  This results in a use-after-free read, which can
> leak sensitive kernel data, pollute the neighbour table with
> arbitrary values, misdirect traffic, or crash the system.
> 
> Fix this by re-fetching the IPv6 header and the destination
> address pointer after lwtunnel_xmit() returns
> LWTUNNEL_XMIT_CONTINUE, ensuring that the subsequent nexthop
> computation and neighbour lookup operate on valid memory.
> 
> Fixes: e415ed3a4b8b ("ipv6: use skb_expand_head in ip6_finish_output2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>   net/ipv6/ip6_output.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 368e4fa3b43c..d893c3dacfd6 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -116,6 +116,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
>   
>   		if (res != LWTUNNEL_XMIT_CONTINUE)
>   			return res;
> +		hdr = ipv6_hdr(skb);
> +		daddr = &hdr->daddr;
>   	}
>   
>   	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
