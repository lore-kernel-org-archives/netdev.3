Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512647;
	b=x3v095lBVXfjan0tS4jRs70QqbUIIoxC3W2+hT/1mDzKKCO5xqR1h0lHoqaUTocVG8ew
	 a3jAG+jrVcgJ2OrtNO4CwScQyHnmVtaklSnsspdRLw+iHHOO4IDbOvVuewch7TXxzwhDT
	 9q1q3ZNCy6QGpSUtzoPH0DxXtbnngOONDscDdCo/Oxb7E91XXWNs/2fjptQAV3IkpkZbd
	 uQnhUhxDtVjk0D3lW6GEfvo3Bj31hfgeycLEVRc+WR8cRiigI/RJ5Wu+qN7g12lvvKc9U
	 4kC+mfHamGIbbqUCn0sRfHTEnDN/OzcR0I5O3OH4foY1D+0lp0SOclErasx79jfwhdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512647;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=G/6kGUmNcoC4XU/YLpcwdTE/U/y5YRTksJEoErK8i3Q=;
	b=5Q2CxS9cLVOOiCbt8m+WN5aWdcFjDWiOVnLiKU8KtqkOBXzyLPbc21H7oQXA4Pek7Esg
	 VJnEtq9/s/coa336Xd808Xvgz8O7CtZ4auCwBa1C6/IvV9cFi9IZG3Qx+XxO17svu+4VQ
	 P0n9gCS8m7Vq2AVi7IgRSrGP74QHd6SCfC+CIUiX7XJx44/5I3As+3u6QMAPTt7NPKDSp
	 5JL77zGcy/Rduk7oQYUg9JzcM5+uFbPKmek03+ryLY2m6ybFCyvcY4k9goSJpUGjTdpF8
	 l7FY0E8iGFkI93A36LiHu3jRBwZSrRSmHfvuWkQqB3iI01afYPbkvaYxAb48OcW87XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hc+ik37J;
	arc=none smtp.remote-ip=91.218.175.17
Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E55606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E55606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hc+ik37J
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L7g9mcR6Nsn/m1DjPlzQxXZCO6qDBPFpGMoZoXjDkyY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792512642; v=1; x=1793117442;
 b=hc+ik37Jq9Fp+OyeblebgklxkllaarIMdj0ZoeRZxiARKxD6Sg3CzrNepLYUpcl3oXtCo5U2
 RyJyXvFCyHsGRYJ8q3wxs4/RsjtpLMEOYKBkfA6fnnqmCeEbzv3EUCDuM+dor1Xk3J0ldyiBR9F
 sPkLua8fnohaTEGk5Ccj1O+w=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 00df53f15c7f61e1;
	Tue, 20 Oct 2026 16:10:42 +0000
X-Mizu-Trace-ID: 00df53f15c7f61e1
X-Migadu-Flow: FLOW_OUT
Message-ID: <ee955f2c-c97b-4505-a996-f7d7c5d2a3f5@linux.dev>
Date: Wed, 21 Oct 2026 00:10:32 +0800
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
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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

I reproduced this on a VM veth interface, which advertises both 
features. The real hardware I have is an Intel IGC but I have not tested 
with it.
