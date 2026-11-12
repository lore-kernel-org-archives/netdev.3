Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527836;
	b=fY0hJykviHDfh6fxl/Qjx1rYsKmpFXaa9PT8dCZasGr3H2nqB9mY4qyhqUD3vPBrI9uG
	 LZhsZSD4jO4RMm0dcKPoBv3hFwMBT1GNpm0qrPt06chyRKEAn3GbaLR0EfH6b42pWBF8o
	 jCOO0I6ZOIzpPNVdlPGWmyHqpA9RDrUCe80TbwUSO2wWuG3vSSOntFdCLGHDKhEq/ZSp7
	 II687YLy49gVJz7YgXmoZN0hUQ3D55Sna40R2pWY5H5spGMLHhdgz2/zJoZm2tB+m1RCL
	 YYQcC8KOk+DT/LxUOhtGTIjOTwjDCp9sPSqicNVo+M5UF/bDt2+0fqEr1GP+WylefSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527836;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OdxNko8swMxQNehkVojSmtOH0S1SRG1cKkOw6mwbAms=;
	b=tLAMlKCsPq3Ail4rdr1e6nQjPEfhx8fLIFFRo6OaJMsrVGe4+h85jUlxZ3hYpHDvcktn
	 /7VKxI5+YhQ++z2uwiMJ/+HGqzLtGUv04kuvKHVYvhxYcyKDNKMbvWu1YdNsaBoUFsRkV
	 lRgDNLcwSKQmPS43dlxYIYr0BaVKwj0ppIs/HnngpWkx80KNbc+vJvgLTWjuROPNtXQSr
	 YW47pKceqlaMlYY5A8ZsEhHzv+P90+J7jO6YIVFtkuImAf6ZmYK8YmHugLelb12m8KBEm
	 SnR7q7dmtx9xhaLcEddG5c+6zroAai7vEY8V7pqJx1ijyXVzMI8zuQvoKeYcmoUa1Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbRe8NK+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B38606A888
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbRe8NK+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF691F000C4;
	Thu, 12 Nov 2026 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527836;
	bh=OdxNko8swMxQNehkVojSmtOH0S1SRG1cKkOw6mwbAms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cbRe8NK+v6gV8kOUCGVtLpTM8Oxo9W/eZ1ohIZq3hcltmSCeJvwH9p1Wi5xpj2est
	 qUJTjAQ9L5KiaHgANI+k0bK7IDNg4m/gryc6TrncvGA9sqaHlw+fQ5FKnDyh4Sl6Gp
	 kvwAhpOEgWBAEIoy3wkTN7kybEWshX6M58XzQrjV5fgNfT7F0nrAMzySSFZyhW2lxF
	 vaglohklJUPzemHo2jP+xY1kbhRcsI5dtrJFyUVOeq73Mrsspf/8AFVO6pzn2PnHCi
	 5zeN1Il/swLegnad+1fJjcXAvOdjcYdKYbC933+19dw5RaZWSpBfXGCCo3DXpGJuYA
	 Hyl3AdifOy8Aw==
Subject:
 Re: [PATCH net-next v8 15/15] ibmveth: Complete set_channels down-path
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:14 +0000
Message-ID: <179452783479.2199510.8962832293852344506@kernel.org>
In-Reply-To: <20261109235556.60604-16-mmc@linux.ibm.com>
References: <20261109235556.60604-16-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The down-path of ibmveth_set_channels() can now shrink the
  published RX count while close() has kept the LAN memory mapped.

Pre-existing issues:
- [Low] When mq_fallback is set, ibmveth_get_channels() reports max_rx
  equal to the live rx_count (e.g. 8).

--

ibmveth: Complete set_channels down-path

This patch completes ethtool -L for ibmveth. While the device is down it
publishes the desired RX and TX counts without allocating anything. While
up it validates tx_count before the RX resize and skips the TX LTB work
when tx_count is unchanged. It also sets max_tx to at least the live
tx_count in both get_channels and set_channels.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 510d9d80e2df5..3ced6f5bad2d7 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -3687,15 +3687,32 @@ static void ibmveth_get_channels(struct net_device *netdev,

[ ... ]

> -	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
> +	/*
> +	 * Always report the live RX count. ethtool -L is read-modify-
> +	 * write, so a TX-only request echoes rx_count back at us; an
> +	 * understated value would be applied as a silent RX shrink.
> +	 * mq_fallback instead caps max_rx at the live count, which
> +	 * blocks growth in the core without misreporting what is
> +	 * currently configured.
> +	 */
> +	channels->rx_count = rx_count;
>  	if (adapter->multi_queue && !READ_ONCE(adapter->mq_fallback))
>  		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
>  	else
> -		channels->max_rx = channels->rx_count;
> +		channels->max_rx = rx_count;
>  }

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. With
mq_fallback set, ibmveth_get_channels() reports max_rx equal to the live
rx_count, so the ethtool core accepts any rx_count from 1 to rx_count.

ibmveth_resize_rx_channels() then rejects every rx > 1 that differs from
the live count:

	if (goal_rx > 1 &&
	    (!adapter->multi_queue || READ_ONCE(adapter->mq_fallback))) {
		...
		return -EOPNOTSUPP;
	}

With a live count of 8, "ethtool -L ethX rx 4" passes the core range
check and then fails in the driver with -EOPNOTSUPP. Only the no-op
request and rx 1 succeed.

The comment in ibmveth_resize_rx_channels() says this is deliberate, so
that read-modify-write TX-only requests still clear the core. The new
comment says the cap "blocks growth in the core", which is accurate.
However, shrinks to 2..rx_count-1 are refused as well.

Is it intended that users see this gap between the advertised max_rx and
the values the setter accepts?

[ ... ]

> @@ -3771,30 +3783,84 @@ static int ibmveth_set_channels(struct net_device *netdev,

[ ... ]

> +	/* If not opened (never opened, close+open failed while IFF_UP
> +	 * stayed set, or close() kept the LAN memory after a failed
> +	 * H_FREE_LOGICAL_LAN), publish desired queue counts without
> +	 * allocating.
> +	 */
> +	if (!adapter->opened) {
> +		if (goal_rx > old_rx) {
> +			for (i = old_rx; i < goal_rx; i++) {
> +				if (adapter->queue_registered[i]) {
> +					netdev_err(netdev,
> +						   "RX queue %d still held by PHYP, free retried on next open\n",
> +						   i);
> +					return -EBUSY;
> +				}
> +			}
> +		}

[ ... ]

> +		if (goal_rx != ibmveth_get_num_rx_queues(adapter)) {
> +			ibmveth_publish_num_rx_queues(adapter, goal_rx);
> +			rc = netif_set_real_num_rx_queues(netdev, goal_rx);

[Severity: Low]
Suppose close() kept the LAN memory mapped after H_FREE_LOGICAL_LAN
failed in multi-queue mode, which is one of the states the new comment
lists. This path can now publish a smaller RX count. The
queue_registered[] -EBUSY check only runs for goal_rx > old_rx. A shrink
such as rx 8 to rx 4 therefore goes through while slots [goal_rx, old_rx)
are still registered and mapped, along with their buffer pools.

ibmveth_free_all_queues(), ibmveth_cleanup_rx_resources() and
ibmveth_free_buffer_pools() only loop up to ibmveth_get_num_rx_queues().
On the next open, the only thing that frees those slots is
ibmveth_free_stranded_rx_queues():

ibmveth_open()
    ibmveth_free_all_queues()           /* [0, 4) */
    ibmveth_free_stranded_rx_queues()   /* [4, 8) */
    ibmveth_release_lan_resources()     /* [0, 4) */

This works at this commit, because the helper scans [num, MAX) on
buffer_list_addr and queue_addr. Its kernel-doc only names one source of
such slots, though:

 * A scale-up register or IRQ-setup failure whose H_FREE_LOGICAL_LAN_QUEUE
 * also fails leaves that queue out of the live set with its slot still
 * registered and its memory still mapped.

Could the kernel-doc of ibmveth_free_stranded_rx_queues() say that a
down-path shrink in ibmveth_set_channels() also depends on it? The commit
message could note this too.

Otherwise, a later change that narrows the helper to its documented
purpose (for example, gating it on slots left by scale-up failures) would
leak the DMA-mapped RX rings, buffer-list pages and buffer pools of slots
shrunk away while down.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
