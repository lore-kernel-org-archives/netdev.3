Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930909;
	b=Zj/ba5N4sat8lUss+HCBMhc48XwlCAUfUCqSZe6L6LsGut/yNZ7LJCAffOokELlH8LGf
	 7hXSqOHykUn0kNFcsw+A+iDDfnqxNGNSOcqCKHLN6STdA3UEGLCf4cX2sNTm5LyxMLPaj
	 8OKtvRsNChId3M+UB6RGKWOJYhdcyp9LtgD9KUEgC4fg+85jZIv6zOVlHds5flfqDT7qL
	 LstPH/xySN26WwfYHLaHAoFoBOVzCZzwcuo53+osSVSzwFh9uQXlAPPrle+02fSi6eTYA
	 VzuGIBnrWe6zUleSshlj3jkXKPv9GiL7P6u8/QnT6yN7au+k5IsGhzQxZL42sgt/30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930909;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WS7CApNUNIMsQEToXiuZ7n60SsvckOdd5s0EGh2oKEk=;
	b=0lAgtzGrJowxN2UJxpMjT5zM0V3qXNGOCmiPDQQknWpza7DkqJi4p5DxBAkp07ffcY+2
	 zyEi+u+eSXtOZfBqgGzQqaCGw6goXz13yWvvqsaMl03LJbcZS8IG/tBZDZ34Hhl9YVmiV
	 XnnoMWWIO1SyKcbzCFI6PEBf1Y5RKthrjqhnIKaQjnGBstfLooDz+cvR6zHhBE5zn6EL8
	 REQm4Btk8MkYxNkfPWOVAXekzDU7ncxoF15aFW1KksOJm6z3g/rni/WfBPuwxncrEuzID
	 91Di1QuwRDpYJXwzC3e3+FJ45a0G4Hk5617myIGuyx3JCmi03GB4O4CXPPPE0OuyaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oqKc8MRT;
	arc=none smtp.remote-ip=95.215.58.30
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74F606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 02:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C74F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oqKc8MRT
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/kWDopwCJ5iePiSx3eT6IBYLtMfFMyr3Ivlvyuz+EIw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793930905; v=1; x=1794535705;
 b=oqKc8MRTf95A1KgxEw0rvV6fGdEtAJU8uYL+ttm2EZCh52y7rLKY3GNRX1v9hQBCnPo+8VQ4
 nC3+Qq1pPWNaRKGHGoNZ2UuAfVEqKDtno1X6ibfhbuP9re9gTsal3OVzSlhwTqUAC+oglM4HPon
 Uv0VqgEE5lfFPPEPdoRkev1A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1da6eafb048a5403;
	Fri, 06 Nov 2026 02:08:24 +0000
X-Mizu-Trace-ID: 1da6eafb048a5403
X-Migadu-Flow: FLOW_OUT
Message-ID: <f15c49f5-724f-4101-806d-24303c5408a4@linux.dev>
Date: Fri, 6 Nov 2026 10:08:16 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Eric Dumazet <edumazet@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
 <c8be6713-2378-4dc5-9959-fc7eddd800e1@linux.dev>
 <CAKgT0Uf_yYxp+tUJt4xYAnwqtK6LZY0KQYt0h4kt78=oQZxd3g@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAKgT0Uf_yYxp+tUJt4xYAnwqtK6LZY0KQYt0h4kt78=oQZxd3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/11/6 2:53, Alexander Duyck wrote:
> On Thu, Nov 5, 2026 at 5:33 AM Qingfang Deng <qingfang.deng@linux.dev> wrote:
>> Hi,
>>
>> On 10/20/2026 11:08 PM, Eric Dumazet wrote:
>>> Le mar. 20 oct. 2026 à 16:30, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
>>>> Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
>>>> forwarded by a bridge can retain hardware GSO features and reach the
>>>> driver without software segmentation, if the egress Ethernet interface
>>>> advertises TSO.
>>>>
>>>> To force software segmentation, clear the GSO feature mask for
>>>> ETH_P_PPP_SES in harmonize_features().
>>>>
>>>> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
>>>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>>>> ---
>>>>    net/core/dev.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index a6951ea08961..27483a2ad747 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct sk_buff *skb,
>>>>           type = skb_network_protocol(skb, NULL);
>>>>           features = net_mpls_features(skb, features, type);
>>>>
>>>> +       /* Ordinary TSO does not update the PPPoE payload length. */
>>>> +       if (IS_ENABLED(CONFIG_PPPOE) && type == htons(ETH_P_PPP_SES))
>>>> +               features &= ~NETIF_F_GSO_MASK;
>>>> +
>>>>           if (skb->ip_summed != CHECKSUM_NONE &&
>>>>               !can_checksum_protocol(features, type)) {
>>>>                   features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>>> --
>>>> 2.34.1
>>>>
>>> Ouch.
>>>
>>> harmonize_features() is called for every packet, GSO or not.
>>>
>>> This is a GSO-only problem, please do not add more protocol-specific
>>> tests in this path. gso_features_check() is only called for GSO
>>> packets, and the cost there is amortized over all segments.
>>>
>>> Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
>>> because of the can_checksum_protocol() check in harmonize_features(),
>>> and fraglist GRO packets (the main use case for PPPoE GRO) are
>>> segmented in software anyway.
>>>
>>> This leaves bridged, non fraglist GRO PPPoE packets sent to a
>>> NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
>> +Cc: Alexander Duyck
>>
>> I ran the real hardware test on Intel igc.
>>
>> igc_tso() requires skb_network_header() to point to the IP header, which
>> is not the case for PPPoE packets, so it won't work on an unmodified
>> driver. I therefore used a kernel module to inject PPPoE GSO skbs
>> directly to the driver's TX path, deliberately pointing
>> skb_network_header() to IP.
>>
>> Test results show that the hardware can still perform TCP segmentation,
>> but it cannot update the length field in the PPPoE header. So
>> theoretically, we might be able to make GSO_PARTIAL work in PPPoE.
>>
>> Kind regards,
>> Qingfang
> Is PPPoE being stacked similar to a VLAN or being ran as an L3? To be
> able to make it work for the GSO_PARTIAL on most these parts it would
> need to be inserted as part of the MAC/VLAN headers instead of as an
> L3/network header. The main problem is that the drivers normally need
> access to the L3 header in order to set the payload length and things
> like the IPv4 ID field.

Currently, PPPoE occupies the skb's network-header (L3) position. 
pppoe_xmit() points skb->network_header at the PPPoE header and sets 
skb->protocol to ETH_P_PPP_SES. pppoe_gso_segment() temporarily pulls 
the 8 bytes of PPPoE/PPP headers before calling the upper layer handler, 
then restores network_header to PPPoE on the returned segments. For an 
untagged frame, network_header therefore points at offset 14, while the 
actual IP header starts at offset 22.

> Really if you are going to support doing GSO with a PPPoE protocol in
> there you probably need to look at adding a new gso feature flag bit
> as any driver that will support it will need to know how to move the
> header out of the way.

LLM suggested the same and wrote the code, which I have not tested. It 
could make both hardware segmentation and software fallback work.

