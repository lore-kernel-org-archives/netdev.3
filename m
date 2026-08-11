Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05473B14DF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431569; cv=none; b=eyl+pFDqRf+95mO7bERW/025zFs4m+W4j40awO/hO9puuCBkdcWv0oNDurJZz0hmDDQJSCm+8j2klR2BD94/EqO92VQTo9dQANy4Oz2yin+GbuoIBqvV7Ov3C44e0d2ywvdkzoK45LnhqwHNNp8uakYbXVpco1zNJ5tQXhWYPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431569; c=relaxed/simple;
	bh=aAQhDnlPmj7NjZuElAotMRr2hus7SLQx/6SvcFEuqQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhE/s0D7H8Q+anrb+5mABsFRx4lmaKLNF3md9X/X3eest9pJAogHGM4aihrIGTzZ2pD9VmWqX87064TKvCVSP4TfjnAdRcfVxl35LDPHc0fugMEqjfnQ09OMpLGPq3Rrbq1ipMR36JmMwFokGsd36DkJkQPUe3uRbFPCK963MQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qEJEsv1M; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qEJEsv1M"
Message-ID: <156834bb-8e40-496e-9443-9d515fa18eab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786431565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32V1eHIyFO1eGX/E3HUZeNfgF9Kyiz48JkQTaV3IfBg=;
	b=qEJEsv1M+c2q0mKNDHkZaO4WxC7QmgpGYC4eOb+mVGR/4k08G3SpvwDTaNB36SsaW1yKc+
	TSSKvPXsIPDM1wB7Ctr1moz5n0cF679Q3nATDOFakuW1ZqDHsMcAg8ei1VrEjJt9GW8kuU
	+or8sXBNusChdfadS9ubZUGTVCNJ7Q4=
Date: Tue, 11 Aug 2026 14:58:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: core: avoid WARN_ONCE for stale RX queue
 mappings
To: Li Xiasong <lixiasong1@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260810125029.1567742-1-lixiasong1@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260810125029.1567742-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/10/26 8:50 PM, Li Xiasong wrote:
> An skb may retain its recorded RX queue index while a network device
> reduces its number of active RX queues. For example, when a TUN queue
> is detached, queued skbs can still carry the queue's previous index.
>
> Both get_rps_cpu() and netif_get_rxqueue() validate the index before
> accessing the RX queue array. They safely fall back to local processing
> or the first RX queue, so an invalid index does not cause an
> out-of-bounds access.
>
> Using WARN_ONCE() for this recoverable condition can unnecessarily
> panic systems with panic_on_warn enabled. Replace it with
> netdev_warn_once() to retain the diagnostic without emitting a WARN
> splat.
>
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>




Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


I just run ethtool -L rx 2 on my host and got such message..


------------[ cut here ]------------
veth1 received packet on queue 2, but number of RX queues is 2
WARNING: net/core/dev.c:5132 at get_rps_cpu+0x1d1/0x4b0, CPU#2: 
kworker/2:1/59
  <TASK>
  netif_rx_internal+0xa1/0x120
  __netif_rx+0x19/0xc0
  veth_xmit+0x267/0x360
  dev_hard_start_xmit+0x64/0x1d0
  __dev_queue_xmit+0x803/0x1190
  ip6_finish_output2+0x2d2/0x700
  ip6_finish_output+0xfb/0x3c0
  ip6_output+0x81/0x180
  NF_HOOK.constprop.0+0x4f/0x110
  mld_sendpack+0x1bf/0x290
  mld_ifc_work+0x19a/0x400
  process_one_work+0x19c/0x3e0
  worker_thread+0x1a8/0x330
  kthread+0xfb/0x140
  ret_from_fork+0x1c1/0x2c0
  ret_from_fork_asm+0x1a/0x30
  </TASK>
---[ end trace 0000000000000000 ]---


> ---
>   net/core/dev.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index af260ff5462a..5db98b0a853f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5126,10 +5126,11 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>   		u16 index = skb_get_rx_queue(skb);
>   
>   		if (unlikely(index >= dev->real_num_rx_queues)) {
> -			WARN_ONCE(dev->real_num_rx_queues > 1,
> -				  "%s received packet on queue %u, but number "
> -				  "of RX queues is %u\n",
> -				  dev->name, index, dev->real_num_rx_queues);
> +			if (dev->real_num_rx_queues > 1)
> +				netdev_warn_once(dev,
> +						 "received packet on queue %u, but number "
> +						 "of RX queues is %u\n",
> +						 index, dev->real_num_rx_queues);
>   			goto done;
>   		}
>   		rxqueue += index;
> @@ -5443,11 +5444,11 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
>   		u16 index = skb_get_rx_queue(skb);
>   
>   		if (unlikely(index >= dev->real_num_rx_queues)) {
> -			WARN_ONCE(dev->real_num_rx_queues > 1,
> -				  "%s received packet on queue %u, but number "
> -				  "of RX queues is %u\n",
> -				  dev->name, index, dev->real_num_rx_queues);
> -
> +			if (dev->real_num_rx_queues > 1)
> +				netdev_warn_once(dev,
> +						 "received packet on queue %u, but number "
> +						 "of RX queues is %u\n",
> +						 index, dev->real_num_rx_queues);
>   			return rxqueue; /* Return first rxqueue */
>   		}
>   		rxqueue += index;
