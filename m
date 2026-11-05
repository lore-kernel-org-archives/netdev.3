Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885639;
	b=i2ykKfAxnZ4tRr/Trtfwo6OMjwnjyPzvvaDkz+qs6PEPToyE07MwPPBu/FD0phdnr3Jx
	 UB/DuI0MmszCnRWhIHztxUAHP8CiTfx4uiaR+/xOOmysr0A4LYkMgFoNjlez5Ule8ZQmv
	 fi608i0nGDbe/+UYugd94jYeoPgfyet4RPSKVkD+H+rnFjwXsJTI6F/v5g0IZWrPLC4Cj
	 STN2/xIpkook9dXk1qlStSaoNZ/cIGyE8sfLUv/fXch0UliRKm8z2MXe88JzLx2dw+KKQ
	 /2lvaOoPIbbxUcjvRi5JC8BVdbzgcSA20lGWfc7oWea00wHS4Z73bqJnAjKfsFP0eNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885639;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=I3bAWnKCJBnbyR0aJvBMJR5ltQ+PdODDur6AdradSno=;
	b=KjLTyIY9vwLgB0GDiz2D7kadqGXa9VzF8xMpWPZsTbMt3Zvxb/b8FHxO3dWt+BE9pQOH
	 OWAlfZAwn0x18ZRAbl5wGihWgSVwGgZRVCHytM4KGbWvo79d922EHURa6mo6UDX6KSPEm
	 dDWfwvc2GQ9HXjhrSh9WdrNJ3yzW5U7Yl6vh6prmmDiaNw9ICbd9F/NWwr2qpz+4DB0RI
	 RYWUQiVv57/opmup0dM0fbp4//WShPorHe8B+06y5QpDvZoTkwlH3Ubk8btiGDYbo8zu4
	 9iZ74i08s1iny9O/01sdQBGxr9349LYJJthA9dvqJOcWvxr6X499vFF64wyhPU+pLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SZmuEBRQ;
	arc=none smtp.remote-ip=95.215.58.221
Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D1606D801
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 530D1606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SZmuEBRQ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=de7uJZx7NF3cVuzxaJ2ihuCpEPiMGYjY4vUsWroOYR8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793885636; v=1; x=1794490436;
 b=SZmuEBRQwhGsepMtsIyF8VqiSHhCWYZsl7j8LRl9uN/eL95ThRe54HRIBgWbNIwN2Nu6AST6
 l/AaLrqjW8ULAuItWOkZ0eNF8Bgt/M8/ITxMyDRHO1899fH5RUuJ+G1Rt5ji5MghuymFnluHlk7
 +RQ39nXgqenRjQ+lR52UBwzQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d698f65570305b22;
	Thu, 05 Nov 2026 13:33:56 +0000
X-Mizu-Trace-ID: d698f65570305b22
X-Migadu-Flow: FLOW_OUT
Message-ID: <c8be6713-2378-4dc5-9959-fc7eddd800e1@linux.dev>
Date: Thu, 5 Nov 2026 21:33:47 +0800
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
To: Eric Dumazet <edumazet@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/20/2026 11:08 PM, Eric Dumazet wrote:
> Le mar. 20 oct. 2026 à 16:30, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
>>
>> Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
>> forwarded by a bridge can retain hardware GSO features and reach the
>> driver without software segmentation, if the egress Ethernet interface
>> advertises TSO.
>>
>> To force software segmentation, clear the GSO feature mask for
>> ETH_P_PPP_SES in harmonize_features().
>>
>> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>> ---
>>   net/core/dev.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index a6951ea08961..27483a2ad747 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct sk_buff *skb,
>>          type = skb_network_protocol(skb, NULL);
>>          features = net_mpls_features(skb, features, type);
>>
>> +       /* Ordinary TSO does not update the PPPoE payload length. */
>> +       if (IS_ENABLED(CONFIG_PPPOE) && type == htons(ETH_P_PPP_SES))
>> +               features &= ~NETIF_F_GSO_MASK;
>> +
>>          if (skb->ip_summed != CHECKSUM_NONE &&
>>              !can_checksum_protocol(features, type)) {
>>                  features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> --
>> 2.34.1
>>
> 
> Ouch.
> 
> harmonize_features() is called for every packet, GSO or not.
> 
> This is a GSO-only problem, please do not add more protocol-specific
> tests in this path. gso_features_check() is only called for GSO
> packets, and the cost there is amortized over all segments.
> 
> Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
> because of the can_checksum_protocol() check in harmonize_features(),
> and fraglist GRO packets (the main use case for PPPoE GRO) are
> segmented in software anyway.
> 
> This leaves bridged, non fraglist GRO PPPoE packets sent to a
> NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?

+Cc: Alexander Duyck

I ran the real hardware test on Intel igc.

igc_tso() requires skb_network_header() to point to the IP header, which 
is not the case for PPPoE packets, so it won't work on an unmodified 
driver. I therefore used a kernel module to inject PPPoE GSO skbs 
directly to the driver's TX path, deliberately pointing 
skb_network_header() to IP.

Test results show that the hardware can still perform TCP segmentation, 
but it cannot update the length field in the PPPoE header. So 
theoretically, we might be able to make GSO_PARTIAL work in PPPoE.

Kind regards,
Qingfang

