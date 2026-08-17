Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4B434E51
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972784; cv=none; b=KwAfxQzfRlpqJEJsZVtXHP1xKY9IY5qULUTHhwGcE8UwUWhsdcTnloJBTZ61g453PieMkbj+RhYGpkuDrwstaGfxPscs6DFKQhihYc+WV0F7RCADD1yaQc0hUFJtMGhcYDtQZxSekZVRFh27TISkZd3yrEJB7O1G5ay97sVBaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972784; c=relaxed/simple;
	bh=a0RSjO/nCOtH/xCyAhNOXFoBGV70rriJqEczjOe3Fko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE84haagu1wWZTth3Ds400gMK7UtFO6dUeFNX+KoODBkElIXfyOJmDKR3r4vx8rYHkeN30nYGv+L7ioinVhHwXRj8dwz83V0xL1s4KV/1QZ+1yijIztBafyjLwOCj14w0pxKu5h7dynrXcV8Wf7GITtZVc/He+kwy3a4+9O18YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eq5nytZE; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eq5nytZE"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a0RSjO/nCOtH/xCyAhNOXFoBGV70rriJqEczjOe3Fko=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786972780; v=1; x=1787577580;
 b=eq5nytZEg3raHjkSAb4EfHoUGMAR3lHNXs00s3J9HZoJGuPIGBjLqFAa3jqtNdftAHh9Hc78
 WEmN7q9wlTxvVto73BscoMPnqKL6/YBJ+a/cKwMMnV2Bmmr8OBdpvcbe4TVnQg4Hpl8owAgDpyn
 ManQal0wjtWu3TOlDnePN1dM=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::6:5429)
	by smtp.migadu.com with ESMTPS id 8a316baa1afe42e0;
	Mon, 17 Aug 2026 13:19:40 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <355ab6f6-c92e-4c4d-95ed-afc0e7b04e4f@linux.dev>
Date: Mon, 17 Aug 2026 14:19:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: update queue NAPI association on queue
 reset
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com
References: <20260817082511.2300402-1-edumazet@google.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260817082511.2300402-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 09:25, Eric Dumazet wrote:
> In netdevsim, receive queues (struct nsim_rq) embed their own struct
> napi_struct. When queue reset is performed (e.g. via queue_reset
> debugfs), nsim_queue_start() swaps in a newly allocated struct nsim_rq,
> and nsim_queue_mem_free() later deletes and frees the old one.
> 
> However, nsim_queue_start() failed to update the queue-to-NAPI mapping
> via netif_queue_set_napi(). As a result, dev->_rx[idx].napi continued to
> point to the old NAPI struct. After the old queue was freed, a subsequent
> queue dump via Netlink (NETDEV_CMD_QUEUE_GET) triggered a KASAN
> slab-use-after-free read in nla_put_napi_id() when accessing
> rxq->napi->napi_id.
> 
> Fix this by calling netif_queue_set_napi() in nsim_queue_start() to
> associate the new NAPI with the RX queue, and clear the association
> with netif_queue_set_napi(..., NULL) in nsim_del_napi() during teardown.
> 
> Fixes: 5bc8e8dbef27 ("netdevsim: add queue management API support")
> Reported-by: syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a82c3d4.f7a79266.2f965f.0024.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/netdevsim/netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 4e9d7e10b527e5e4127331c141e4197afe0efa07..b4a99f3ceac60b66db4b30280db403d4e4319c99 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -529,6 +529,7 @@ static void nsim_del_napi(struct netdevsim *ns)
>   	for (i = 0; i < dev->num_rx_queues; i++) {
>   		struct nsim_rq *rq = ns->rq[i];
>   
> +		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
>   		napi_disable_locked(&rq->napi);
>   		__netif_napi_del_locked(&rq->napi);
>   	}
> @@ -826,6 +827,7 @@ nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
>   	}
>   
>   	ns->rq[idx] = qmem->rq;
> +	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX, &ns->rq[idx]->napi);
>   	napi_enable_locked(&ns->rq[idx]->napi);
>   
>   	return 0;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
