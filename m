Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CA370D6F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708495; cv=none; b=cjfzQL3mq4aGgZ4ioy2v09tqlaC/nowZh7eAC8WAjoGgfzN43R/euLAg8ZDCM6QdioS8hcfUL+n+8AhoK2KUya6WywTYbwUWNAyaeVyS3LS9W+TN7VcVFYgRga++C+IMc6wrXH9BG5JZy4RQzzPnQI56u9NI59zSXAjvipILif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708495; c=relaxed/simple;
	bh=6V1+B3WqhLKA/tZq6vPxYpHz8+AiU7Pxe7RTGyLw8AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhZJsoWXEmVWjSDGj1CrXjb7I5JAd5o2aDkfEMiwZw/eolEO1yn6XhYryqu2bdbK6VHZDxCyYSRNEVEB78wFqUtRrFMaqwtBk++0wq9/QovaP/848OUhQwJdXBHitVYZAly51HN+jxRAnuiUqT95np0l/zw2+64fQ4Z2SjawLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0Ic+3bP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0Ic+3bP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772708493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igrqLx/MTUvFgvimDZHAB5tV8+/8LZfszcZrarTFNjE=;
	b=i0Ic+3bP4INuFPT+thTzJy0eCPG2BgOM9uVyOUwW282oldVIpS99CbWRuq/LlfiETcMG1U
	ii3IocI5QecjOa/rHkoOKQbegtAoJ1s7VgquXr0WCY1QwlB5RMw0kqcWUtwKDJk2o4wXot
	9K61vnt7k6BnODOUB6rLjTz+IWYtFtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-w2NQbcwbN3CQtGbam5WWLw-1; Thu,
 05 Mar 2026 06:01:30 -0500
X-MC-Unique: w2NQbcwbN3CQtGbam5WWLw-1
X-Mimecast-MFC-AGG-ID: w2NQbcwbN3CQtGbam5WWLw_1772708488
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA02B1956064;
	Thu,  5 Mar 2026 11:01:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC0913003E98;
	Thu,  5 Mar 2026 11:01:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: pvalerio@redhat.com
Cc: lorenzo@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	kuba@kernel.org,
	edumazet@google.com
Subject: Re: [net-next,v3,7/8] net: macb: add XDP support for gem
Date: Thu,  5 Mar 2026 12:01:17 +0100
Message-ID: <20260305110117.309126-1-pabeni@redhat.com>
In-Reply-To: <20260302115232.1430640-8-pvalerio@redhat.com>
References: <20260302115232.1430640-8-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: add XDP support for gem

This commit introduces basic XDP support for the macb/gem driver,
implementing support for XDP_TX, XDP_PASS, XDP_DROP, and XDP_REDIRECT
verdicts.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 1ae80938331b..009a44e94726 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fc6ea1391846..152cbf5eb33a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -3216,11 +3450,24 @@ static int macb_close(struct net_device *dev)
>  	return 0;
>  }
>
> +static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
> +{
> +	return __gem_total_rx_buffer_size(gem_max_rx_data_size(mtu + bp->rx_ip_align),
> +					  XDP_PACKET_HEADROOM) <= PAGE_SIZE;
> +}
> +
>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>  {
> +	struct macb *bp = netdev_priv(dev);
> +
>  	if (netif_running(dev))
>  		return -EBUSY;
>
> +	if (rcu_access_pointer(bp->prog) && !gem_xdp_valid_mtu(bp, new_mtu)) {
> +		netdev_err(dev, "MTU %d too large for XDP", new_mtu);
                                                               ^
This isn't a bug, but the format string is missing a trailing newline.
Every other netdev_err() call in this file ends with '\n', and without it
this message will be concatenated with the next kernel log line.

> +		return -EINVAL;
> +	}
> +
>  	WRITE_ONCE(dev->mtu, new_mtu);
>
>  	return 0;

