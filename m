Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D441A903
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229095; cv=none; b=e6FQeeRUrcvCCc05pvwCM4OMGliGimyqvTj+YhaiZiQ35JwseZBjq8CP7mdbpqa4Q2kdbmYkZIcbXRb+EBChzn00p5FNHqa5AVhsyzzsP5OYnSPyy7P/1R80L3MTs8ELkdDtnv+ND5YAPvKdACwKq/R0fehrvU918OzEKGtEFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229095; c=relaxed/simple;
	bh=o1DdN2BAqB+RwlvujzPL+tmjXmn7xHOTQPxRxJOfF+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+o67IEtXeQlvbpzSuwHkLvlktnsop4Oek5lew+WdnIGkTssFKMEs+JS0kweONQlTzVErQB5lXejd+BULj/Ak/57Ywh2KXYJCzZ4F8OvU4VYUpYfoTWXgjFqoJBwqcdxH355pLjsPj0P1O5ouBzaAkvfvby1nXAkP/bf/1PUJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCzo5cGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCzo5cGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E82F1F000FF;
	Mon,  5 Oct 2026 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791229094;
	bh=ssNngxccJb9GMrBBdm78UGfxgNKGvyWAKOtou/kAniM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WCzo5cGP3IxJcU4OMPeUNvcVliajME/XRG5J6qpE6grOXACJTa/acU1SMT7R8iSUD
	 GyvKx9HCLa44q3QiyQrlj9/tpANmTE2aQBIVFsgE/BFvfx6YfUM5E6DwLATgLt7RZc
	 D7HYD13DqbXTHVm1vM9b5pkAVlgASwt4KoVXRlL30/cLbaMi1REs8ayRAK1cGeb6jx
	 cJsK+sF6tKiR2Yl5bhlNkdEDhaMl/lsPwl4vfMOwyjgf1qeCOBvX/12BS77QvqL1uc
	 NXutF9oSvvEeP6JHbkFkhpLRborEjl8jfOhVeqXAELhjNVNHpjgb3yc8zooX8edGud
	 MMitTV6NxC7hA==
Message-ID: <3663b5be-27a0-4b37-a8a1-f9271d02777e@kernel.org>
Date: Mon, 5 Oct 2026 21:38:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 1/3] flow_dissector: avoid u16 truncation of
 skb->len when computing thoff
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, mst@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com
References: <20261001191140.2818991-2-edumazet@kernel.org>
 <179121420852.434549.8121508269046937218@kernel.org>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <179121420852.434549.8121508269046937218@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/5/26 17:30, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The fix is incomplete: __skb_flow_dissect() still has a second
>    path that truncates a length to u16 when it computes thoff, the BPF…
> 
> --
> 
> flow_dissector: avoid u16 truncation of skb->len when computing thoff
> 
> This patch changes the thoff computation at the end of
> __skb_flow_dissect() to compare in u32 instead of u16. If the result
> does not fit in key_control->thoff, it is capped to U16_MAX and the
> dissection is reported as failed.
> 
>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> index 8aa4f9b4df810..27d8a01bc9230 100644
>> --- a/net/core/flow_dissector.c
>> +++ b/net/core/flow_dissector.c
> 
> [ ... ]
> 
>> @@ -1692,7 +1693,13 @@ bool __skb_flow_dissect(const struct net *net,
>>   	ret = true;
>>   
>>   out:
>> -	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
>> +	thoff = min_t(u32, nhoff, skb ? skb->len : hlen);
>> +	if (unlikely(thoff > U16_MAX)) {
>> +		/* Cannot be represented in key_control->thoff. */
>> +		thoff = U16_MAX;
>> +		ret = false;
>> +	}
>> +	key_control->thoff = thoff;
> 
> [Severity: Medium]
> Does the BPF flow dissector path in the same function still have the
> same u16 truncation?


Seems legit, I will take care of this in a separate and stand alone 
patch next week (after LPC)

> 
> When a BPF flow dissector is attached to init_net or the netns,
> __skb_flow_dissect() returns early and never reaches this out: label:
> 
> net/core/flow_dissector.c:__skb_flow_dissect() {
>      ...
> 	result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
> 				  hlen, flags);
> 	if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
> 		__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
> 					 target_container);
> 		rcu_read_unlock();
> 		return result == BPF_OK;
> 	}
>      ...
> }
> 
> bpf_flow_dissect() still clamps as u16, so the int hlen (skb_headlen())
> is truncated before the comparison:
> 
> net/core/flow_dissector.c:bpf_flow_dissect() {
>      ...
> 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
> 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
> 				   flow_keys->nhoff, hlen);
>      ...
> }
> 
> Then __skb_flow_bpf_to_target() copies the value as is:
> 
> 	key_control->thoff = flow_keys->thoff;
> 
> Take a linear head of 65540 bytes and a program that reports nhoff=14,
> thoff=34 and returns BPF_OK. (u16)hlen is 4, so both offsets collapse
> to 4, and __skb_flow_dissect() returns true.
> 
> That seems to be the case the commit message describes:
> 
>    "Whenever skb->len (or hlen) modulo 65536 is smaller than nhoff, the
>    truncated length wins and thoff is set to a bogus small value, even
>    when the dissection succeeded."
> 
> and:
> 
>    "report the dissection as failed rather than silently returning a
>    wrong transport offset."
> 
> skb_headlen() above 65535 looks reachable. packet_snd() skips the MTU
> check when vnet_hdr.gso_type is set. Both packet_alloc_skb() and
> tun_alloc_skb() grow the linear part when len exceeds the fragment
> capacity:
> 
> 	linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
> 
> So a GSO write of roughly 622KB on 4K pages gives a linear head over
> 64KB. Attaching the BPF dissector does require privilege.
> 
> Callers that trust a successful return would then put the transport
> header inside the L2/L3 header. Examples are skb_probe_transport_header()
> calling skb_set_transport_header(skb, keys.control.thoff). Another is
> __virtio_net_hdr_to_skb(), after "net: always dissect GSO packets in
> __virtio_net_hdr_to_skb()" later in the series. The later patches in
> the series leave bpf_flow_dissect() unchanged.
> 
> Should bpf_flow_dissect() also compare in u32, or cap hlen at U16_MAX,
> and report failure when the offset cannot be represented?
> 
>>   	key_basic->n_proto = proto;
>>   	key_basic->ip_proto = ip_proto;
>>
> 

