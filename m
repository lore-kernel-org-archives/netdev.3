Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A92C21C3
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196635; cv=none; b=t3yX23iP3BXzeZvrGxOheVku+bSXQBsxne6JuJnjrjnZgTzginpIdtYo4tPNajWjLRwW9iSAn4LcExCZaV9pRYRkND+PRpnEgNSisH6wygzSMp2ZSuW6jTBuCQGlCM28USGw7L7nneJCBFiItdDX/n4W3zljAXKSRVZKNnUKUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196635; c=relaxed/simple;
	bh=tB0ZKLKCFGEgt+GHiRbmgJUxWRLVbIL4vVNCdgIZ44M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCq57MuVqobcDYMPYscBAou3dcGjCOvs5iW519bwj0Vkke9vZ8qQ8i9yD0vsUpTB+0gDqbIit8xMqSPedYazcYFiHTr92zLGPWCUfiqK1UiLmqH1M2/HT05bNYzLMzL0m/+g7R+oT5Qr1DpIlfGmFtdwo1WAfWmswrRmQpZzkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFwBy+iZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFwBy+iZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so316066f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758196632; x=1758801432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICaG0I0VIKMFgkrXS9EofB/RjAvCOsuEkOQQLS9ay54=;
        b=FFwBy+iZkLvkRl8xVCnRA57Jsl1a8EDJMb/JwQB9DNrgQsUCfwjTcRdqk8OXlLnshb
         30Nfu3FpOd7nnhVEWM8ilC6eYy1YtyLh5FxZyJJ1kmd1Y0yIH36OYN9lDm74/m9b3tJJ
         tmwzZSnE9yDD0utvSBcCImPsneH5+OG2zBHjO6VSJr3iT4xexRnSKlmAVd1kse6og46f
         vV4o7OsXLbpco3ewgrD+NtfOt4wQGIEOz3DLMtYyDyPSJt2MUljEb8KdGpjHbMLH3ULv
         aRwK+u9HhGMwq64VBnDzpLKcDlKEse5ME6rSPej6rtmEqT7fPobJbqroJN1bXeH70EXY
         zlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196632; x=1758801432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ICaG0I0VIKMFgkrXS9EofB/RjAvCOsuEkOQQLS9ay54=;
        b=bZOMSakaOEQpQvs4R6Q1UCk4fTpARiEqNu+lQEfQdd+w68TD96oibNzuE5utLf20tR
         rNjsDFxEmNDpXBOV5B1UAhk4ybL/PdEL35F06i/XL5S7k6Cqx4y2gAzqpI2yh6XsD75r
         sEV3B6QfI5EdeE7f5Qwbp3jsbiTTQoPce//BkLqDZNdFA+XItCYDPVO3frzsYKxXsCMe
         ww1l02cxTDNRKlfz3Ru78P7VBwBYVQXGj619+by14HE2D5GP8cU1++MB3N69penlD672
         Qkuz2xMbLxdSnU7hKTNG6ADv4qco3uWTRQehzGSxjC4eAyZgHwJOZD3UMHOh7kcJAgON
         1Y9A==
X-Forwarded-Encrypted: i=1; AJvYcCX+VLZiBxNY1grmwi8R3+8J9QTs2RlH127GFrOSKDSTkRcVEcedYeVCeaDd0S0Keqee4hRclIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+fj9Wd0+QYYcuJudEeo00uEWqd9eYUSlET/CHUFhN8J0Z/rB
	v+lJfXvG53nLvv/nzTAS/uCKA5zXVOBdfP7Ja7/8c8lCXt441ydsmRCA
X-Gm-Gg: ASbGncsV+J3hlYdjoKMLIWo5Qe2Fak2JvtvMD5DBe+5ekheKoE8KXJbbYL0ODsZ3dwj
	VfvzD/Hxp6o89njlzYRh/ZUcsa6ia9eNDai4Xa5zQ37n5KjVI1uI/o277c8krGZry3DD0cuP3R4
	0yA+ZukZP717CYw7wWG7xdElqVW2LwfgSc0HFdzFbvo2Oog7CG8u4w3jv67Z9V9ddmWEF0qn7Bx
	Wfv26YtL50foi8Q2WjSSCLPnZWOu/AB52RcW7wU1TIYKytKn6qnWERUW5X3z6H72ECMtBNMhbsR
	fok3Bk0XgzeI/f5CNLrwh+Stfb4avRJ3k/sh5FgMLp5e3X2N+YSyXDxMkUH69y24usDHlOogFR4
	3IQgah1R3RC9XJNUgZhfXPRS5cr2kbXP0/5rEGLXjSw==
X-Google-Smtp-Source: AGHT+IGfBpdk0CLV6hk3FoxFp4cpgN9yGK0l0Up+a7lNPSvaUbtj48gBjf0Ha3wudFx7KmtxC702HA==
X-Received: by 2002:a05:6000:220c:b0:3e9:13f7:5438 with SMTP id ffacd0b85a97d-3ecdfa466dbmr5059800f8f.55.1758196631729;
        Thu, 18 Sep 2025 04:57:11 -0700 (PDT)
Received: from localhost ([45.10.155.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f5387sm3275233f8f.1.2025.09.18.04.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:57:11 -0700 (PDT)
Message-ID: <c9c60631-861c-4c7f-bc3e-4b23f14ef0ea@gmail.com>
Date: Thu, 18 Sep 2025 13:56:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.1b773a265e8dc@gmail.com>
 <dca173e6-f23d-4f54-8ace-74329439c7da@gmail.com>
 <willemdebruijn.kernel.39980903d76e0@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.39980903d76e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:
>>> Richard Gobert wrote:
>>>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>>>> be mangled. Outer IDs can always be mangled.
>>>>
>>>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>>>> both inner and outer IDs to be mangled.
>>>>
>>>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>>>
>>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>>> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
>>>> ---
>>>>  .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
>>>>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
>>>>  drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
>>>>  include/linux/netdevice.h                     |  9 ++++++--
>>>>  include/linux/skbuff.h                        |  9 +++++++-
>>>>  net/core/dev.c                                |  5 ++++-
>>>>  net/ipv4/af_inet.c                            | 13 +++++------
>>>>  net/ipv4/tcp_offload.c                        |  5 +----
>>>>  8 files changed, 59 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
>>>> index 085e8fab03fd..72f69b22b28c 100644
>>>> --- a/Documentation/networking/segmentation-offloads.rst
>>>> +++ b/Documentation/networking/segmentation-offloads.rst
>>>> @@ -43,10 +43,19 @@ also point to the TCP header of the packet.
>>>>  For IPv4 segmentation we support one of two types in terms of the IP ID.
>>>>  The default behavior is to increment the IP ID with every segment.  If the
>>>>  GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>>>> -ID and all segments will use the same IP ID.  If a device has
>>>> -NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>>>> -and we will either increment the IP ID for all frames, or leave it at a
>>>> -static value based on driver preference.
>>>> +ID and all segments will use the same IP ID.
>>>> +
>>>> +For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
>>>> +SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
>>>> +Any combination of these two GSO types is allowed.
>>>> +
>>>> +If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
>>>> +performing TSO and we will either increment the IP ID for all frames, or leave
>>>> +it at a static value based on driver preference.  For encapsulated packets,
>>>> +NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
>>>> +DF bit is not set on the outer header, in which case the device driver must
>>>> +guarantee that the IP ID field is incremented in the outer header with every
>>>> +segment.
>>>
>>> Is this introducing a new device requirement for advertising
>>> NETIF_F_TSO_MANGLEID that existing devices may not meet?
>>>   
>>
>> No. As I discussed previously with Paolo, existing devices already increment outer
>> IDs. It is even a requirement for GSO partial, as already stated in the documentation.
> 
> Where is this documented?
> 

It's documented in segmentation-offloads.rst under "Partial Generic Segmentation Offload":

"... The one exception to this is the outer IPv4 ID field. It is up to the
device drivers to guarantee that the IPv4 ID field is incremented in the case
that a given header does not have the DF bit set."

>> This preserves the current behavior. It just makes it explicit. Actually, we are
>> now even explicitly allowing the mangling of outer IDs if the DF-bit is set.
>>
> 
>>>>  #if BITS_PER_LONG > 32
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index 93a25d87b86b..17cb399cdc2a 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -3769,7 +3769,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>  		features &= ~dev->gso_partial_features;
>>>>  
>>>>  	/* Make sure to clear the IPv4 ID mangling feature if the
>>>> -	 * IPv4 header has the potential to be fragmented.
>>>> +	 * IPv4 header has the potential to be fragmented. For
>>>> +	 * encapsulated packets, the outer headers are guaranteed to
>>>> +	 * have incrementing IDs if DF is not set so there is no need
>>>> +	 * to clear the IPv4 ID mangling feature.
>>>
>>> Why is this true. Or, why is it not also true for non-encapsulated or
>>> inner headers?
>>>
>>> The same preconditions (incl on DF) are now tested in inet_gro_flush
>>>
>>
>> This comment is about the IDs that TSO generates, not the IDs that GRO accepts.
>> I'll rewrite the comment to make it clearer.
> 
> Yes, this exact statement would convert the assertion into an
> explanation. Really helps a casual reader.
> 
>>
>> This statement is true because of the requirement specified above, that device
>> drivers must increment the outer IDs if the DF-bit is not set. This means that
>> MANGLEID cannot turn incrementing IDs into fixed IDs in the outer header if the
>> DF-bit is not set (unless the IDs were already fixed, after the next patch) so
>> there is no need to clear NETIF_F_TSO_MANGLEID.
>>
>> This isn't true for non-encapsulated or inner headers because nothing guarantees
>> that MANGLEID won't mangle incrementing IDs into fixed IDs.
>>
> 
>>>> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>>>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>>>>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>>>  	struct tcphdr *th = tcp_hdr(skb);
>>>> -	bool is_fixedid;
>>>>  
>>>>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>>>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>>>> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>>>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>>>>  				  iph->daddr, 0);
>>>>  
>>>> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
>>>> -
>>>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
>>>> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
>>>> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
>>>
>>> ip_fixedid can now be 0, 1 (outer), 2 (inner) or 3 (inner and outer).
>>>
>>> Not all generate a valid SKB_GSO type.
>>
>> Since SKB_GSO_TCP_FIXEDID_INNER == SKB_GSO_TCP_FIXEDID << 1, all the values
>> listed above generate the correct set of SKB_GSO types. This fact is also
>> used in inet_gso_segment (SKB_GSO_TCP_FIXEDID << encap).
> 
> Oh right. Neat.
> 
> That dependency can use a BUILD_BUG_ON.

