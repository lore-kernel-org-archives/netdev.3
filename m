Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553594;
	b=Zbp5lRpJw+GAzYv8HpFW8+ANJsp28xleYARXiNC4mlxLdPT6NK8r4P1q8q/nv0AWQcIq
	 93QWbuqwEfUUd+YrmMGFObBdC+bQ5KADSTU7eyPwHYiDH5h1uHAzdFemKyReYUhDyWBKH
	 sLV4p/54zA71OhJi9cE7TCMwY2XyRzvmGVTM3z+I4Blko6NyobVFAtpSlpbcSn456VMD9
	 oBqN0g5AfzSapa+yyKaZzOFKrJTmp8viDaob9sD+AXbAS3wrAYNHP+jDJQXBUJZdaejmm
	 lNyrywieCbMN3AQ5UahcSqYh/Gr5A58OxB0vXBM3DOAEt105gxmU0h5i4byjZbD+gKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553594;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4dL6718CjmrEnD528xX0GaVmfeB3Ih1PoOomOicJTmk=;
	b=rNoyMs4+3h//LlSUhYem2E9U1yEgkEou1yl9Zsk/A7aHv0TK1jPNrv4Ct8fPjH3P+un3
	 SyqmrKUMGjb52HXId/qoWJYVdS2XbZnGNygNUxql96J0smo9EeLKnj6oq/dubX63tG5xY
	 XaKAWZcE8yqfAxT4DqMTrnpcX0+3/m4iCMTBQneAQyFEyArhIp8XBaXj8XYmLlHy8cqiI
	 VDSGZykY5R2I40ntJvTuFlGOvIqpCOyAr1fqaAABZWQUw215c07CZDoPxPnS6wGIVil5n
	 IVn4ghwT4QmH8DVy5EWiZVcY7aXg4PRDh0cpACDBspfmuy9eRoY/9tBHrhbvsUGsacg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aMDlVYwR;
	arc=none smtp.remote-ip=95.215.58.127
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE839606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE839606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aMDlVYwR
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n162zU1LsiDQjzL5WwI3PMMZWu0/W5egH3fDuHDdVqA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794553590; v=1; x=1795158390;
 b=aMDlVYwRpN9krvsVUUDdAkTD5n3zcnZlTPDsNtuo4EvH2Wpy9LW1yLpbgcBX/iX5ptCogGIl
 Br4xB0UsVnB7RWdtYDq1TR4WdRBvmgZqNwbq5H3y694BZWgg8ysffTpq3lv29yTVyyh1kJXKeyz
 AjZovhSj0L/MtEiEcg7H/P8E=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 58c73366565f7543;
	Fri, 13 Nov 2026 07:06:30 +0000
X-Mizu-Trace-ID: 58c73366565f7543
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 15:06:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net-next v2] ipv4: igmp: report IFA_TARGET_NETNSID in
 multicast address dumps
Message-ID: <ava26Y1CKb0CJrId@fedora>
References: <20261112082352.152338-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112082352.152338-1-sunwenbo@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 04:23:52PM +0800, Wenbo Sun wrote:
> Commit eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
> extended RTM_GETMULTICAST to dump IPv4 multicast addresses by reusing
> inet_valid_dump_ifaddr_req(), which already accepts IFA_TARGET_NETNSID
> and switches to the target network namespace. However,
> inet_fill_ifmcaddr() does not include IFA_TARGET_NETNSID in the dump
> replies yet.
> 
> In contrast, IPv4 unicast dumps (inet_fill_ifaddr()), IPv6 multicast
> dumps (inet6_fill_ifmcaddr()), and AF_PACKET multicast dumps
> (dev_mc_fill_addr()) all report IFA_TARGET_NETNSID when a netns id is
> specified. Adding the same behavior to IPv4 multicast dumps aligns
> reporting across address families and helps userspace consistently
> identify target-netns replies.
> 
> Emit IFA_TARGET_NETNSID in inet_fill_ifmcaddr() when args->netnsid >= 0,
> and initialize fillargs.netnsid = -1 in inet_ifmcaddr_notify() so that
> multicast join/leave notifications do not include IFA_TARGET_NETNSID or
> exceed their preallocated skb size.
> 
> This alignment was identified with the assistance of an LLM-based code
> review tool, confirmed in a User-Mode Linux (UML) environment where AF_INET
> RTM_GETMULTICAST dumps with IFA_TARGET_NETNSID omitted the attribute while
> AF_INET6 included it, and verified in UML that AF_INET multicast dumps
> now report IFA_TARGET_NETNSID, regular dumps without netnsid continue to
> work, and multicast join/leave notifications succeed without warning.
> 
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
> Changes in v2:
> - Target net-next as an enhancement/alignment change and drop the Fixes
>   tag, per Hangbin Liu's review.
> - Soften and clarify the commit message to reflect feature alignment with
>   inet_fill_ifaddr(), inet6_fill_ifmcaddr(), and dev_mc_fill_addr().
> - Link to v1: https://lore.kernel.org/r/20261111082222.327963-1-sunwenbo@cmss.chinamobile.com
> 
>  net/ipv4/igmp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 144fca158adc..831d003677ba 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1517,6 +1517,12 @@ int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
>  	ifm->ifa_scope = RT_SCOPE_UNIVERSE;
>  	ifm->ifa_index = dev->ifindex;
>  
> +	if (args->netnsid >= 0 &&
> +	    nla_put_s32(skb, IFA_TARGET_NETNSID, args->netnsid)) {
> +		nlmsg_cancel(skb, nlh);
> +		return -EMSGSIZE;
> +	}
> +
>  	ci.cstamp = (READ_ONCE(im->mca_cstamp) - INITIAL_JIFFIES) * 100UL / HZ;
>  	ci.tstamp = ci.cstamp;
>  	ci.ifa_prefered = INFINITY_LIFE_TIME;
> @@ -1538,6 +1544,7 @@ static void inet_ifmcaddr_notify(struct net_device *dev,
>  {
>  	struct inet_fill_args fillargs = {
>  		.event = event,
> +		.netnsid = -1,
>  	};
>  	struct net *net = dev_net(dev);
>  	struct sk_buff *skb;
> -- 
> 2.33.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
