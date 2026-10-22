Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677776;
	b=ZBHayNv1zVwS3BZECRngk/FKaHdWTpteCRD9Yo5WRrnFa/msmx3mdnfPPI5ycfRpEvlI
	 4mTENR1pUeekfWZ9O5t7bdV82dZZk6WO2zYCNArLXBr831dsN3ZbWVeC4LXCjx9CoKBEp
	 XNy5/uYcyMKqMQJV1HFyWFKK20wHg5kDdHxA8BfSfsnhJyv/iTQ2EO9Y88FsSwgIH691I
	 z6NCFRLB0tYf180N+xiAFNiKpNdDqm6v3BdgAMklaEAEnR+03/tisc/dx3ZUg+H9H17uC
	 0nTsUjq/smWnYykN8fnGvbRlKFEH2XE/DU7h/Um1SfYd4lXrtQ41n6BTcvtuPgITa2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677776;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MMvIVX1W7YbUBzv1Vsn7O+zoox8rhwsLu4nv9vQWM4I=;
	b=n1p/+AqH76N3EDg3b3ymvjwX53KEMdR49X2L99TYlFTybtNHao9+Ncd2Gk0puBoB4j1R
	 T/ZY3sXeU49npmNOB60eIGRSuzGhP+LUQf3ryLbGJq6FzV6K7IOI1+lTIHPtdo09IsdJU
	 +urSI6BARsR4i030co/177BTXw9uuD3rtdm0JapxPShZiRlmrdNLvdthQSiFyQyN8kptN
	 o9viKa0QmdiTOMxX6OhvA6RdLtUCUOVsZKwuXuM20IE/WqGGBQ/wCWJvttKYES6YO5h6o
	 LTSXDtKnx55qUoJK6sDC7Ug7KrTAHDBGn5u5At42gbwuYqakMwQyhYpcfqrbjxTncMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MquOjWda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F00606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MquOjWda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82261F000C4;
	Thu, 22 Oct 2026 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792677776;
	bh=MMvIVX1W7YbUBzv1Vsn7O+zoox8rhwsLu4nv9vQWM4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MquOjWdalYsZU9tyRxRgIgOsQMzS/0FEu/NiH5zCy9iwj+XR7UW1mSft2dKzIiXZp
	 QDkw19+3m3x8ztErU5qHWiGwp8IUv2ne+3G7GZ9daPa7yyPYhztgy7fJWHJKnKakJl
	 +y2CqrGP6ktdAwmn17NP9L3m06U8v1TckQ2gU4IIwNPK5QlYRkxT57wyQlEbb47kdQ
	 ixnhGboXJapEJjbms81ajnR0szzgAFhHjirE/5u6rmzEK0ZbUmdfLH4iT3FFws/hux
	 PYqRn3thKW2UEwz9hBlWqPWAa/XSio8++3dfJ3Xq5GNN/1Zqi6B4R7wNEOsZq16G5f
	 iKocTiyo4MGFA==
Message-ID: <885073f4-f0a7-4aa7-8ee9-e8c04d04f2fa@kernel.org>
Date: Thu, 22 Oct 2026 16:02:51 +0200
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
Subject: Re: [PATCH net v6 1/1] ipmr: only copy pktinfo to cache reports
To: Zhiling Zou <zhilinz@nebusec.ai>, idosch@nvidia.com,
 netdev@vger.kernel.org, edumazet@kernel.org
Cc: dsahern@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
References: <cover.1792476357.git.zhilinz@nebusec.ai>
 <0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/26 08:39, Zhiling Zou wrote:
> ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
> ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fields
> when packet info is disabled. Since the skb can continue through the data
> path, preserve and restore its original control block around the helper.
> 
> The original implementation copies the entire control block to the report
> skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted as
> IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled,
> corrupted option offsets cause out-of-bounds reads or a stack buffer
> overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
> offsets when their header is prepended.
> 
> Clear the report skb control block. Only prepare and copy pktinfo when the
> input skb has an IPv4 header. Synthetic route-query skbs use NETLINK_CB,
> not IPCB, so leave their report control block zeroed. Restore pkt->cb after
> preparing pktinfo for regular IPv4 packets.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

I have not seen this message, because my email is edumazet@kernel.org

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

