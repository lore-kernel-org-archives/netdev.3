Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0B4B04AC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017658; cv=none; b=aMNEtb0QEEQWy5idavxAEYXw+kwSFc4NGoNg+lsMCHd/BeRoRw2qDTnokZ4Rpmlwdg21LW5Tds4JvWzkOkjVWXQIeBDm3BKeUIlU2FgRGaXWKYttDlJAf7DNoCWTIAvpX14BCl5HjN1RUDS7W8M2siukf2ZhSBv06r0JmZLrQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017658; c=relaxed/simple;
	bh=yZugcoKE3ibqLb3RZ5maozyD6sS0ieo5nssbYxdbvo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCIUFUHUwVPYt069lpL0U72zyPYr8EVf1puYqtU6JwygIrtbmjdWxxibXCocRPMU0/0UXEZy7oRkc7lWYXdbi1W8dSTzyfz9I116q9nePxgLUuCxWsAe+KqD0TiaSplBOrzdeIbB6IfdGauOLuVwQKUW6MB8jEIiB08tZJ61Sx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKDHNPMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKDHNPMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FAF1F000E9;
	Tue, 18 Aug 2026 01:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017656;
	bh=0SYERTz8iYE+Oh4oGG4FMtYhnJ7wnKY5HCJr3RGnVQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKDHNPMHMSP483uPYPi9CW0uA3MwDqoHdEshFDVD7nsldA8QdVTJcuWo5LY6kUIev
	 yxUi24/cE2NuLs5JbcKowny+xfDzbLjaWTmR0u8zt5lcU9F+AtlDAhejj1JbGZ/C2C
	 11Z1WBGa4Q8Wwh4h0fizGQdIf7D8IjNoYL+xmjvVtIkxmaupzXayg0RT84SJ4kQ/Tt
	 yPcImSCG4iAJhNIzMi8qFUnbbIOZbcHXxs0ybxONo0kX+HtoOCXIL+X3EtAAFUdaLi
	 GqGlHxemSZ4tcYZmrmV+K/a0R8SHbvEdPtdxWFQMWK/tcG2JlY1xO2IgkYqCKAAZGD
	 ws1mZ/i2vzZ4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	nnac123@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davemarq@linux.ibm.com,
	bjking1@linux.ibm.com,
	shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v5 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Mon, 17 Aug 2026 18:47:34 -0700
Message-ID: <20260818014735.3854400-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-13-mmc@linux.ibm.com>
References: <20260814073642.24630-13-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Report MQ-aware RX counts in ethtool get_channels

The patch changes ibmveth_get_channels() to report max_rx as
IBMVETH_MAX_RX_QUEUES when the adapter has multi-queue firmware support
(else 1), and to report rx_count from the driver's published
num_rx_queues instead of netdev->real_num_rx_queues.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3202b657c9b8f..5d4ca4b3d3d07 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2522,11 +2522,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
>  static void ibmveth_get_channels(struct net_device *netdev,
>  				 struct ethtool_channels *channels)
>  {
> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +
>  	channels->max_tx = ibmveth_real_max_tx_queues();
>  	channels->tx_count = netdev->real_num_tx_queues;
>  
> -	channels->max_rx = netdev->real_num_rx_queues;
> -	channels->rx_count = netdev->real_num_rx_queues;
> +	if (adapter->multi_queue)
> +		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
> +	else
> +		channels->max_rx = 1;
> +	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
>  }

[Severity: Medium]
At this point in the series, does raising max_rx here make RX channel
requests silently succeed without changing anything?

ibmveth_set_channels() only derives its work from tx_count:

	unsigned int old = netdev->real_num_tx_queues,
		     goal = channels->tx_count;
	...
	if (!(netdev->flags & IFF_UP))
		return netif_set_real_num_tx_queues(netdev, goal);

channels->rx_count is never read there.  The core validation in
ethtool_set_channels() only bounds the request by the driver-reported
maximum:

	if (channels.rx_count > curr.max_rx ||
	    channels.tx_count > curr.max_tx ||

so with max_rx now 16, "ethtool -L ethX rx N" for any N in 1..16 that
differs from the current RX count passes validation, enters
ibmveth_set_channels() with tx_count unchanged, runs no LTB loop
iterations, and returns 0.  The netlink path in ethnl_set_channels()
applies the same max_rx-only ceiling and maps the 0 return to success.

Before this change max_rx equalled real_num_rx_queues, so an increase was
rejected with -EINVAL by the core; afterwards it is accepted and ignored,
and "ethtool -l" still shows the old rx_count.

For the record, this appears to be resolved later in the same series: the
final patch "ibmveth: Wire ethtool set_channels to MQ RX queue resize"
makes ibmveth_set_channels() read channels->rx_count and apply it via
ibmveth_resize_rx_channels() with range validation of
1..IBMVETH_MAX_RX_QUEUES, so the get/set pair agrees at the end of the
series.  Would it be worth ordering that patch before this one, or
mentioning the intermediate state in the changelog?

[Severity: Low]
A second, smaller point about the same lines: max_rx is derived only from
adapter->multi_queue and does not consult adapter->mq_fallback.  After
firmware refuses multi-queue, ibmveth_apply_mq_fallback() defers the
downgrade to the next open:

	if (!adapter->mq_fallback)
		return;

	adapter->mq_fallback = false;
	...
	adapter->multi_queue = 0;
	ibmveth_publish_num_rx_queues(adapter, 1);

so between the firmware rejection and the next open, "ethtool -l" keeps
reporting max_rx = 16 and rx_count = 8 while the adapter is going to run
single-queue.  Should get_channels() also take mq_fallback into account?

Also, at this patch the reported maximum of IBMVETH_MAX_RX_QUEUES (16) is
above anything the driver publishes, since ibmveth_probe() caps the RX
queue count:

		adapter->multi_queue = 1;
		ibmveth_publish_num_rx_queues(adapter,
					      min(num_online_cpus(),
						  IBMVETH_DEFAULT_QUEUES));

The end-of-series patch "ibmveth: Wire ethtool set_channels to MQ RX
queue resize" does make 1..IBMVETH_MAX_RX_QUEUES genuinely settable via
ibmveth_resize_rx_channels(), so this is only about the intermediate
state and the stale reporting while mq_fallback is latched.
