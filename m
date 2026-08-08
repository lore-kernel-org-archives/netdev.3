Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89613B14CE;
	Sat,  8 Aug 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218504; cv=none; b=Je53sFpBhmUUFu2/YaDDvdppKrTdDC/RCWKGI7Cx5hHphSkKTG+2F2A13vHneAz6GATxbcn5kOhpFF3naU3RYgB88b0XtOQlEPUfOQ7pqxGAiBRgDPTTRAc5okzGZbu6bmQT7ZovD2GSBHm3NV8EA3vs4Xom50aLmnwnBs4AYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218504; c=relaxed/simple;
	bh=TKT9Br2oTdOl4qK6aLPGkwMX/uC5yYRVM28zqEJ1e7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHVIbByp6dX3j4RidSEhL/DAmuillxEUatxjlYt9UAf+Y9HLLVL3UJqMBXhANNWpiN1/HMiFWYAKrE5a09wyGjpVPH4bZvarQTkZ6p6zWogIrk9+XyUmpt0jieQ6Nr1eCLwMp3g2E6A1wTsxKLD/CWQILHP+fPokJyb5xHqPhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBuZq5Rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBuZq5Rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB801F000E9;
	Sat,  8 Aug 2026 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218502;
	bh=nbzfz0+54u9SR8lQ4IhzH67GEAQ97wcJnXa0JJdMuoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBuZq5RvTSsyBIY51pHNsCpqMdSqCvEPj5aNz/8FilstXOD03iRLywmIB4UMl/Iko
	 S6gEL3sfsEqn00IzhS7W58kc6xD3gXXG63NKNetBw+owPJY5cFYJ4C662wHMAfo424
	 Q8IWR6n2gKIv2WVTw2W1IDLOZiOUD9yZA2EDJu7vNDg6lwA4PcfuwBxliwJzzwr84Z
	 8z+B9DNMX6QgjwceFcVTfa4x34eGXanmZm03fONP5UacmynEDuCPnDnRAEYGRUCDww
	 2pL7ZJPSYiB9urOpqzCKizitUXPC0/H2HWfNWGmGi7BsPULt18fMmc4C7b4I7hlM4o
	 XbylZR21gB+EQ==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 05/20] net: xilinx: tsn: bring up the endpoint MCDMA channels
Date: Sat,  8 Aug 2026 12:48:21 -0700
Message-ID: <20260808194821.132723-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-6-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-6-nagadheeraj.rottela@amd.com>
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
net: xilinx: tsn: bring up the endpoint MCDMA channels

This patch requests the TX and RX MCDMA channels named in the device tree
when the endpoint interface is opened, gives each channel a ring of
preallocated SKB descriptor slots, resets the controller through tx_chan0,
and releases the channels on stop.  It also adds a XILINX_DMA dependency to
the Kconfig entry.

No Link: tags are present in the commit header.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 062cb94c2153..fa21d59ade16 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -59,8 +122,27 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep);
> +static int ep_init_dmaengine(struct xlnx_tsn_ep *ep);
> +static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep);
> +
>  static int ep_open(struct net_device *ndev)
>  {
> +	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
> +	int ret;
> +
> +	WRITE_ONCE(ep->closing, false);
> +
> +	ret = ep_reset_dma_controller(ep);
> +	if (ret)
> +		return ret;
> +
> +	ret = ep_init_dmaengine(ep);
> +	if (ret) {
> +		netdev_err(ndev, "failed to initialize DMA engine\n");
> +		return ret;
> +	}
> +
>  	netif_tx_start_all_queues(ndev);
>  
>  	return 0;

[ ... ]

> @@ -90,6 +176,194 @@ static const struct ethtool_ops ep_ethtool_ops = {
>  	.get_drvinfo	= ep_get_drvinfo,
>  };
>  
> +static struct xlnx_tsn_ep_dma_chan *
> +ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
> +		  int ring_size)
> +{
> +	struct xlnx_tsn_ep_dma_chan *chan;
> +	struct dma_chan *err_chan;
> +	int i;
> +
> +	chan = kzalloc_obj(*chan);
> +	if (!chan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan->chan = dma_request_chan(ep->dev, name);
> +	if (IS_ERR(chan->chan)) {
> +		err_chan = chan->chan;
> +		kfree(chan);
> +		return ERR_CAST(err_chan);
> +	}
> +

[ ... ]

> +static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
> +{
> +	int tx_allocated = 0, rx_allocated = 0;
> +	char name[16];
> +	int i, ret;
> +

[ ... ]

> +	for (i = 0; i < ep->num_tx_queues; i++) {
> +		snprintf(name, sizeof(name), "tx_chan%d", i);
> +		ep->tx_chans[i] = ep_alloc_dma_chan(ep, name, true,
> +						    TX_BD_NUM_DEFAULT);
> +		if (IS_ERR(ep->tx_chans[i])) {
> +			ret = PTR_ERR(ep->tx_chans[i]);
> +			ep->tx_chans[i] = NULL;
> +			goto err_free_chans;
> +		}
> +		tx_allocated++;
> +	}
> +
> +	for (i = 0; i < ep->num_rx_queues; i++) {
> +		snprintf(name, sizeof(name), "rx_chan%d", i);
> +		ep->rx_chans[i] = ep_alloc_dma_chan(ep, name, false,
> +						    RX_BD_NUM_DEFAULT);

[Severity: Medium]
The channel names are re-invented here as a dense 0..N-1 sequence, but is
that what the binding in this series promises?

The dma-names schema in
Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
allows any subset of tx_chan0..15 / rx_chan0..15:

      dma-names:
        minItems: 2
        maxItems: 32
        items:
          pattern: "^(tx|rx)_chan(1[0-5]|[0-9])$"

and ep_count_dma_queues() only counts the prefixes, discarding the indices:

		if (str_has_prefix(name, "tx_chan"))
			tx++;
		else if (str_has_prefix(name, "rx_chan"))
			rx++;

So for a device tree that validates against the binding, for example

	dma-names = "tx_chan2", "tx_chan3", "rx_chan4", "rx_chan5";

probe succeeds, but ep_open()->ep_reset_dma_controller() asks for a channel
literally named "tx_chan0" and ep_init_dmaengine() asks for "tx_chan0" and
"tx_chan1".  Does dma_request_chan() not return -ENODEV in that case,
leaving the interface impossible to bring up?

There is a second mismatch in the other direction: the binding permits up to
16 tx_chan entries, while ep_count_dma_queues() rejects anything above
TSN_MAX_TX_QUEUE (8) with -EINVAL at probe.

Would it be better to use the actual strings from dma-names, or to narrow the
binding to the dense, at-most-8-TX form the driver implements?  Both the
binding pattern and these two functions are unchanged through the end of the
series.

[ ... ]

> +static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
> +{
> +	struct xilinx_vdma_config cfg = { .reset = 1 };
> +	struct dma_chan *tx_chan0;
> +	int ret;
> +
> +	tx_chan0 = dma_request_chan(ep->dev, "tx_chan0");
> +	if (IS_ERR(tx_chan0))
> +		return dev_err_probe(ep->dev, PTR_ERR(tx_chan0),
> +				     "failed to request tx_chan0 for reset\n");

[Severity: Medium]
Can -EPROBE_DEFER reach userspace through ndo_open here?

dma_request_chan() forwards that code verbatim:

drivers/dma/dmaengine.c:dma_request_chan() {
	...
	if (PTR_ERR(chan) == -EPROBE_DEFER)
		return chan;
	...
}

and of_dma_request_slave_channel() returns -EPROBE_DEFER when no of_dma
controller has registered for the phandle yet.  Since probe() requests no DMA
channel, the netdev exists before the MCDMA provider is bound, and
XILINX_DMA is a tristate that can be loaded later:

  ip link set ep up -> __dev_open() -> ep_open() -> ep_reset_dma_controller()

__dev_open() returns ops->ndo_open()'s value unchanged, so would
SIOCSIFFLAGS report errno 517 to userspace?

ep_alloc_dma_chan() has the same path: return ERR_CAST(err_chan) is turned
into ret = PTR_ERR(...) by ep_init_dmaengine() and returned from ep_open().

Separately, dev_err_probe() is being used outside a probe path.  For
-EPROBE_DEFER it logs only at dev_dbg() level and overwrites the device's
deferred-probe reason string, so this open failure would be silent for the
operator.  Would dev_err()/netdev_err() be more appropriate in ndo_open?

Both ep_reset_dma_controller() and ep_open() are unchanged at the end of the
series.

> +
> +	ret = xilinx_vdma_channel_set_config(tx_chan0, &cfg);
> +	dma_release_channel(tx_chan0);
> +	if (ret < 0)
> +		return dev_err_probe(ep->dev, ret,
> +				     "failed to reset DMA controller\n");
> +
> +	return 0;
> +}

[ ... ]
