Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59941D103
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706440; cv=none; b=tgRnvioRRfdWjpuF2HN1MxQOWb/hiI37d4dszZlwG7PGJyZDPNUPolzz7jsK6t6dOhYVyWZNEQwxV1d9PxvJ14IfqzLohiI4NPKzQCYHBcFyyGafmYGBEYHtYFn+XkBTyLJXpOVjhjM8r3Br/9GyHyWRvvOnxoxA9CXqH8VrYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706440; c=relaxed/simple;
	bh=1LcQ4b+Gi/OXEk/ousjyGSUfR3Rx2q/XBXnYVdXnQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mquZPjr6yq+YlPuts88x6V2Lrdk+18VMAikoaXXB09hEZ99oJyqRHJH6xNWVUJ+XcXil/Y/mP4FXys1TdykC84SOAoR8R1aHGSm48E8YbOoPQhe9IgcNDXq7r/0+UBlrurtbP4Rp7FwxNF7dWGkRDIDFWhpZmYL5V32hRDAQrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VWVoa4Om; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VWVoa4Om"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=syTJFIT6uRlThahTaPURx28B6cVdbQWRuMkM65l11ec=;
	b=VWVoa4Omfk66moNuPPDwmZ1X+tEQT1oH1n6vU1XMBpKo/1D8AXcSSw5ew50y7zXk6x/a4OZqc
	7QhEICFOph5VjD1Jkz9y2XSNYAFQQImFluNFKsfZZdN2zZumPE/gdoSsP/cvw9yMom8PEuX2wZ1
	spt0/pjPneZ651p6uCTDz1U=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLzyj2y8hzKm4b;
	Fri, 14 Aug 2026 19:09:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 451EA40572;
	Fri, 14 Aug 2026 19:20:31 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Aug 2026 19:20:31 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Aug 2026 19:20:30 +0800
Message-ID: <9e3ff760-69ec-4ecc-8256-d065db6c2af6@huawei.com>
Date: Fri, 14 Aug 2026 19:20:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: icmp: reject non-unicast input routes in
 icmp_route_lookup
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>
References: <20260811133037.3344927-1-dongchenchen2@huawei.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20260811133037.3344927-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> When the forward output route cannot be used in icmp_route_lookup(),
> it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
> the original packet's source address.
> 
> ip_route_input() only returns an error for truly invalid packets. For
> local, broadcast, multicast and unreachable addresses it still succeeds
> and returns an input route whose dst.output is set to ip_rt_bug().  The
> existing check only rejects RTN_LOCAL routes, so the other route types
> can still be returned and later used for output, syzkaller triggering a
> WARN_ON_ONCE() in ip_rt_bug() as bellow:
> 
>   ------------[ cut here ]------------
>   WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
>   RIP: 0010:ip_rt_bug+0x14/0x20
>   Call Trace:
>    ip_push_pending_frames+0xfa/0x100
>    __icmp_send+0x905/0xf10
>    ip_options_compile+0xc0/0xd0
>    ip_rcv_finish_core+0x321/0xae0
>    ip_rcv+0x1de/0x260
>    __netif_receive_skb_one_core+0x11a/0x130
>    netif_receive_skb+0x7b/0x260
>    tun_get_user+0x11bf/0x1c10
>   ------------[ cut here ]------------
> 
> If the original source address is unroutable, ip_route_input() returns a
> RTN_UNREACHABLE input route with err == 0, and the ICMP reply is then sent
> through ip_rt_bug().
> 
> Only RTN_UNICAST input routes have dst.output set to ip_output() and are
> safe to use for output.  Reject any input route that is not RTN_UNICAST.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>   net/ipv4/icmp.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 0caedfc7ca92..d58ac2f23f9f 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -584,12 +584,14 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>   		 * At this point, fl4_dec.daddr should NOT be local (we
>   		 * checked fl4_dec.saddr above). However, a race condition
>   		 * may occur if the address is added to the interface
> -		 * concurrently. In that case, ip_route_input() returns a
> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
> -		 * be used for output.
> +		 * concurrently, or if fl4_dec.daddr is otherwise unroutable.
> +		 * In that case, ip_route_input() returns an input route
> +		 * (RTN_LOCAL, RTN_BROADCAST, RTN_UNREACHABLE or
> +		 * RTN_MULTICAST) with dst.output set to ip_rt_bug(), which
> +		 * must not be used for output.
>   		 */
> -		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
> -			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
> +		if (!err && rt2 && rt2->rt_type != RTN_UNICAST) {
sorry, this judgement will reject bforward packet.
broadcast and multicast rt with ip_rt_bug has been reject after
icmp_route_lookup.We only need to add a judgment for RTN_UNREACHABLE
v2 will be sent.

best regards
Dong Chenchen> +			net_warn_ratelimited("detected unusable input route 
for %pI4 during ICMP sending, src %pI4\n",
>   					     &fl4_dec.daddr, &fl4_dec.saddr);
>   			dst_release(&rt2->dst);
>   			err = -EINVAL;
