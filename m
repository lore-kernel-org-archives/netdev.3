Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C037755A
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155902; cv=none; b=R1l9vQ930rAd3c/+TTJOHbmgcis1g8zPSPM7BfF8LANFsUTVfQwexYPSlMNu/GFqrEsAgQ05RUqsTRqmLb7cLJIlTiG8wJVcKkXoYc7lvJ1bPiRgg3ykURCEyDsdis7xuGOgGGvp1Kde6mxtys6wHIx02xHUt2LPlgi27ybz1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155902; c=relaxed/simple;
	bh=OV3G2Of95mcC6L6ov8Ulol8KFG+ZTFa17CEvraugteg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu4BK7/P/Hcoi1F2DIvjL2Zx4PolI2JfEN0l0uu78RYboxl7vjK+9m1S7FsUwWqzZ7Hg5tPPIH19ikdoG8/l6Np4+u04bv8IcwdancmRj92H8ygbN1TH9VcLBYqlhjTxMicabDhKpl6RDXW0XhByIsvCLoWppGIYpARbh3lddE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kvgasDCp; arc=none smtp.client-ip=95.215.58.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kvgasDCp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OV3G2Of95mcC6L6ov8Ulol8KFG+ZTFa17CEvraugteg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790155898; v=1; x=1790760698;
 b=kvgasDCp4A6LMjwZY15tEfdCK+gSirk8BvJFrolkbdILDOlfZmqC38NojQ+v+5GjF6oRciay
 /yDz/eqek+hTZKUEkgNZKS8+zn/lMqy3j+Cg3TXheHnczIBbQz1pr7wIuhkoB67ZjlG+b8N4Njz
 flTegwvPhT7PEO4Ape+GHr3s=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40c0b80a80dae18e;
	Wed, 23 Sep 2026 09:31:38 +0000
X-Mizu-Trace-ID: 40c0b80a80dae18e
X-Migadu-Flow: FLOW_OUT
Message-ID: <d3c19b97-76ea-4848-b360-81b1528b91a8@linux.dev>
Date: Wed, 23 Sep 2026 17:31:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] veth: manage XDP program pointers during channel
 resize
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Weiming Shi <bestswngs@gmail.com>
References: <20260921231856.1798630-1-kuba@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260921231856.1798630-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/26 7:18 AM, Jakub Kicinski wrote:
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().
> A later channel increase can re-enable NAPI and run the freed program.
>
>    BUG: unable to handle page fault for address: ffffc90000256048
>    Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>    RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                           include/net/xdp.h:696 drivers/net/veth.c:820)
>    Call Trace:
>     veth_xdp_rcv (drivers/net/veth.c:941)
>     veth_poll (drivers/net/veth.c:986)
>     __napi_poll (net/core/dev.c:7787)
>     net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>     handle_softirqs (kernel/softirq.c:645)
>    Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - different placement to avoid extra loops
> v1: https://lore.kernel.org/20260917153923.904124-3-bestswngs@gmail.com
> ---
>   drivers/net/veth.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153f..71227d0389aa 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1054,6 +1054,7 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
>   	for (i = start; i < end; i++) {
>   		struct veth_rq *rq = &priv->rq[i];
>   
> +		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
>   		napi_enable(&rq->xdp_napi);
>   		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
>   	}
> @@ -1088,6 +1089,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>   
>   		rcu_assign_pointer(priv->rq[i].napi, NULL);
>   		napi_disable(&rq->xdp_napi);
> +		rcu_assign_pointer(rq->xdp_prog, NULL);
>   		__netif_napi_del(&rq->xdp_napi);
>   	}
>   	synchronize_net();


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

