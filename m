Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C994BD35E;
	Mon,  5 Oct 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212686; cv=none; b=oc03+YC/sOTBNCqhVAh8ADeede47toEeWBnicWKYNdeLmiwnqtie7n4ysNiS+MdmfU5tvXS1iAHZP6BpmxlWo6DJ51/7JN8u2cgXmM2sCml7/BcV3E1F7btyJqDisK3BFFYUPJaZTxHTYh2NGU47pSO0PGjIn6dTARoVL7P4jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212686; c=relaxed/simple;
	bh=vq4ypD7pfm+l4SRcMFthGIS/4VGFtFE3ZvXh4ztYCg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bH0UofTGh9Zu/sc0IA2NL8hLALsmUyzyzBgWg/HXxLZ+x8yGGnzki1EgKxX+fWXAk6mpxQT/wYyHM4yfTVIeoIv0BNEAy3qk1ap0IsCb8y5cYy3zQwZf7PzWUfgz+F04pJM/+MbhXOpnGQUYYeoBDqFduSschF1bq1c4GOjTBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L59hxpyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L59hxpyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE9D1F000FF;
	Mon,  5 Oct 2026 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212684;
	bh=WJBxmPwonp5Q98B3F9LC9lcZ/4I0LgrqHq+ZdGw5H0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L59hxpyJjSWUiK6pSj3DsyelGlVOIstemqQLDkOgwMIlhMvVETEFACYAVGpiLZcCi
	 edUeunwN6GkfJBUM0B5ZFt20lY4bnbNkVotm1Io8lsxg/UK6sAJz8D7itE2wLuNS3l
	 mWpFi0uIfA4uW3V/T4Dz3YB3YcyEZA8do82d4FiM3RR7Il2jiFPh/vT8WF8P4XHYmK
	 wRnnf4EpsDhd7HZ8Y+ZY1pWOZbEik1/E7coqxHqspMSyOXL5xp6K31xdmR5wvem4K7
	 SQoRoc6kz4sWFzM6FnzKGccUSEkyAbp8khP/vdMT0EVAH0sOXVAkTYBF5MNzDIn/A6
	 twwA6UMiwWgrw==
Subject: Re: [PATCH net-next 4/7] net: bcmgenet: derive the receive buffer
 length from the MTU
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:43 +0000
Message-ID: <179121268363.434549.2122507463306243653@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-4-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-4-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The ENET_THLD_PAGE_LEN comment added by this patch says 'A
  descriptor is one page, which also holds skb_shared_info behind the…

--

net: bcmgenet: derive the receive buffer length from the MTU

This patch replaces the fixed 2048 byte RX buffer length with one
computed from the MTU through a new RBUF packet ready threshold, plus the
64 byte status block. The patch also programs RBUF_PKT_RDY_THLD and sets
TBUF_PKT_RDY_THLD to its maximum. A new priv->rx_buf_len replaces
RX_BUF_LENGTH in the refill, sync, length check and ring setup paths.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 5cb3d25482a0d..bf889558f6ade 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> -/* RX buffer plus the skb_shared_info napi_build_skb() places behind it */
> -#define GENET_RX_BUF_SIZE	SKB_HEAD_ALIGN(RX_BUF_LENGTH)
> +/* A descriptor is one page, which also holds skb_shared_info behind the frame,
> + * so on 4K pages the page bounds the threshold before the register does.
> + */

[Severity: Low]
This isn't a bug, but is "A descriptor is one page" accurate on every page
size?

bcmgenet_rx_refill() asks page_pool_dev_alloc() for
SKB_HEAD_ALIGN(priv->rx_buf_len) bytes. page_pool returns a whole page at
offset 0 only when twice the request is larger than the page. Otherwise it
returns a fragment.

rx_buf_len is 2112 with the default MTU, so on 4K pages each descriptor
gets a whole page. On 16K or 64K pages, several descriptors share one page.

This comment also seems to contradict the existing one in
bcmgenet_rx_ring_create_pool() in the same file:

	/* Buffers share a page. bcmgenet_rx_refill() syncs each one for the
	 * device, PP_FLAG_DMA_SYNC_DEV would sync the whole page.
	 */

That one is wrong for 4K pages, and the new one is wrong for larger pages.
Neither comment changes later in the series.

The ENET_THLD_PAGE_LEN bound itself looks fine, since a buffer never
exceeds one page. Could both comments be reworded so they agree and say
that buffers may share a page depending on PAGE_SIZE?

> +#define ENET_SHINFO_LEN		SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> +#define ENET_THLD_PAGE_LEN	round_down(PAGE_SIZE - ENET_SHINFO_LEN - \
> +					   sizeof(struct status_64), \
> +					   ENET_THLD_BURST)
> +#define ENET_THLD_MAX_LEN	min_t(unsigned int, \
> +				      ENET_THLD_MAX * ENET_THLD_UNIT, \
> +				      ENET_THLD_PAGE_LEN)

[ ... ]

> @@ -2252,7 +2269,7 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>  			      struct enet_cb *cb)
>  {
>  	struct bcmgenet_priv *priv = ring->priv;
> -	unsigned int size = GENET_RX_BUF_SIZE;
> +	unsigned int size = SKB_HEAD_ALIGN(priv->rx_buf_len);
>  	unsigned int offset;
>  	dma_addr_t mapping;
>  	struct page *page;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
