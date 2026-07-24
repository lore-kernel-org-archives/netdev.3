Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7504457AD;
	Fri, 24 Jul 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923075; cv=none; b=MlsdU2EMZEV+kJdgXwIIxBGDt2NkUvpaHWhBehBw6bQiko9scYsirFXeaDfWkCX1S6FFztiJ3X1pU05A2cZ2oqtJdmjS10nNt83BzbIZKkPuZx2ak/Fz/9cX3H/iXBVdi4y4A1zeM90MT4oxwVKX1BnP1kHG+kbRQBPy52i5EsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923075; c=relaxed/simple;
	bh=TN0RdiIFcBl3+H3qRyKiEoF6Fz4ZvO+t7CkIUrMNKpg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EPtZFrVL71x7JJ8O7t8mQf4NB0Uji9FTGICXjbSgExuj7/HgJ8jGOVEvSjtfp7gSj+3APgcOJpMGQum5QPBFLDGPTQxYi3jsL67yT8AxKjIPc3VZxvuH10lJ/97Q2SRiwxJk7EnzILbXgO/XZrYA3+9vLj0/BCWGMQhVJur6Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=t5eJO8V9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="t5eJO8V9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFAB7A38C5;
	Fri, 24 Jul 2026 21:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784923071; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sG8AdthhNftxG7YP15UhUw0PavOXg247eyQTOR//F/s=;
	b=t5eJO8V9pi8E1eW8J0AADjtiPYWZhCXGyh2DHdHfdbiBbD1MPijADRoXZOWMifb2G/X7sn
	UXrQFsGTqZiWhLhAaG3oHSWLYugTIA1VnJ77JNn34Lf4ZrxiVvr8Y2B2HcRytJfUxaEjQn
	E+GleF7OCFERBfvhWlr2dKDriTlG34t7UqWRu840/Tl5ZNr+aUs2lufdUU0ZRuSV5OWfZT
	X3sFwvQMGEtUiBu+LKac8fwpfRukeTZgGRbn8jMG0mVdX3fXwvRml25t0+Df6sxPD2WGFD
	t8B1fBVgGRSI/FWQMggifNtRWWJtYL0BeR3V1tDH5ZFUSeLhqvlylc2pVaLhYQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 21:57:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for all
 queues
In-Reply-To: <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
Message-ID: <49ccdd6682366239fef37bcfd99a908c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vineeth

On 24.7.2026 06:32, Vineeth Karumanchi wrote:
> The initial "tc" command was not overwriting the reset value of ENST
> registers if only a subset of queues were configured, leading to an
> invalid setup. To fix this, configure all queues unconditionally.
> Unconfigured queues are zero-initialized via kcalloc(), ensuring a
> complete and consistent configuration.
> 
> The queue_id field in struct macb_queue_enst_config becomes redundant
> once the array is indexed by queue id, so drop it.
> 
> Key changes:
> - Drop queue_id from struct macb_queue_enst_config
> - Allocate enst_queue[] based on bp->num_queues instead of
>   conf->num_entries
> - Index enst_queue[] directly with the queue number
> - Program ENST registers for all queues
> 
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling 
> support")

In addition to what Théo already mentioned:

The series targets net-next, but if this is a real bug fix it should
probably be routed via net. The offending commit is in stable since 
v6.18.

> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  2 --
>  drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++-----------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index a11052565436..4cc9aa9b2f9e 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1490,7 +1490,6 @@ struct macb_platform_data {
>   * @start_time_mask:  Bitmask representing the start time for the 
> queue
>   * @on_time_bytes:    "on" time nsec expressed in bytes
>   * @off_time_bytes:   "off" time nsec expressed in bytes
> - * @queue_id:         Identifier for the queue
>   *
>   * This structure holds the configuration parameters for an ENST 
> queue,
>   * used to control time-based transmission scheduling in the MACB 
> driver.
> @@ -1499,7 +1498,6 @@ struct macb_queue_enst_config {
>  	u32 start_time_mask;
>  	u32 on_time_bytes;
>  	u32 off_time_bytes;
> -	u8 queue_id;
>  };
> 
>  #endif /* _MACB_H */
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index d394f1f43b68..d58430fe9c41 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4329,7 +4329,7 @@ static int macb_taprio_setup_replace(struct 
> net_device *ndev,
>  	struct macb_queue *queue;
>  	u32 queue_mask;
>  	u8 queue_id;
> -	size_t i;
> +	size_t i, q;
>  	int err;
> 
>  	if (conf->num_entries > bp->num_queues) {
> @@ -4357,7 +4357,7 @@ static int macb_taprio_setup_replace(struct 
> net_device *ndev,
>  		return -EINVAL;
>  	}
> 
> -	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), 
> GFP_KERNEL);
> +	enst_queue = kcalloc(bp->num_queues, sizeof(*enst_queue), 
> GFP_KERNEL);
>  	if (unlikely(!enst_queue))
>  		return -ENOMEM;
> 
> @@ -4416,13 +4416,12 @@ static int macb_taprio_setup_replace(struct 
> net_device *ndev,
>  			goto cleanup;
>  		}
> 
> -		enst_queue[i].queue_id = queue_id;
> -		enst_queue[i].start_time_mask =
> +		enst_queue[queue_id].start_time_mask =
>  			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
>  			start_time_nsec;
> -		enst_queue[i].on_time_bytes =
> +		enst_queue[queue_id].on_time_bytes =
>  			enst_ns_to_hw_units(entry->interval, speed);
> -		enst_queue[i].off_time_bytes =
> +		enst_queue[queue_id].off_time_bytes =
>  			enst_ns_to_hw_units(conf->cycle_time - entry->interval, speed);
> 
>  		configured_queues |= entry->gate_mask;
> @@ -4448,15 +4447,14 @@ static int macb_taprio_setup_replace(struct 
> net_device *ndev,
>  		gem_writel(bp, ENST_CONTROL,
>  			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
> 
> -		for (i = 0; i < conf->num_entries; i++) {
> -			queue = &bp->queues[enst_queue[i].queue_id];
> +		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  			/* Configure queue timing registers */
>  			queue_writel(queue, ENST_START_TIME,
> -				     enst_queue[i].start_time_mask);
> +				     enst_queue[q].start_time_mask);
>  			queue_writel(queue, ENST_ON_TIME,
> -				     enst_queue[i].on_time_bytes);
> +				     enst_queue[q].on_time_bytes);
>  			queue_writel(queue, ENST_OFF_TIME,
> -				     enst_queue[i].off_time_bytes);
> +				     enst_queue[q].off_time_bytes);
>  		}
> 
>  		/* Enable ENST for all configured queues in one write */

Regards,
Nicolai
