Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54483448CF1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033262; cv=none; b=N/O+lkfswC41Zr2XFzcT+i7tEcEl6AGyaCPNUC6v9MimbtTBzyEmZ6KGI+q2e1cO9Nr9nA8PdcBbj6ia4DwgjsmN6VglZo+k/Cm7BGO9711xKk1opYAHi1gSNEwBkwzlJ8fUPuRsvs8kCwWoUfaJDEboV/f2MnVR1+P8i/BZ+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033262; c=relaxed/simple;
	bh=HxmJhot2Hkmx8KcbkMWlsRdtrPbsnn/o6Dxp0y5sTBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6kzM8ZSuZe3Op6J3czxqmwT5B8m/wMP6XX1MGW6Ut6z94lQ9jCryB5R5Vw1HQ0juCDYSsoSbH+fR9dTJgsgDYfloaNi6i6pSKK3kz1qAJ2UpRtTrIfdvmpAe0nsV2YxSKBA1VqTqiB4TTcuMOIk3lM+Jy08hMydN+39wIEGqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3NmDd6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3NmDd6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB531F000E9;
	Tue, 14 Jul 2026 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033261;
	bh=n+Wyn57KjP5oHM+z3oUceSxitNAFuqbXlpQlF0kZhS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i3NmDd6dvGgkrx9o+8tKK4dYcebW5AzRP/jTTSPeveINF4azlVg3eHud669p2Vspv
	 ZgR30El8Ctkm2atN3D75wqfnjmSBbz2dHH19+XttqkD6i3h7IIYfJmuY5iTkAziiYI
	 Fs+hOPCwuNxe7vt21dHm1x/KzZbimEMHzyZ45JzeglBT+GIodnG0pFi54lBFKP4InZ
	 jDIRbh6dv60p0aT7YE4hqG6xtMZs3TQuT5CqgmUGP1SF2SiD3CiuR0i0tel0GoAHac
	 dQFO74ODkTWMpadluyk+X0iG4iI60E1L1+QjCHVe7g7s/b05C1slshNOxePSJzFO4D
	 8dBnV3Mp44oHw==
Date: Tue, 14 Jul 2026 13:47:36 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au,
	Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next v3 08/15] ibmveth: Refactor open/close into
 MQ-ready resource pipeline
Message-ID: <20260714124736.GK1364329@horms.kernel.org>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-9-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706193603.8039-9-mmc@linux.ibm.com>

On Mon, Jul 06, 2026 at 12:35:56PM -0700, Mingming Cao wrote:

...

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c

...

>  /**
>   * ibmveth_register_logical_lan_queue - Register subordinate queue with hypervisor
>   * @adapter: ibmveth adapter structure
> @@ -1466,208 +1479,108 @@ ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
>  static int ibmveth_open(struct net_device *netdev)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> -	u64 mac_address;
> +	u64 mac_address = ether_addr_to_u64(netdev->dev_addr);
>  	int rxq_entries = 1;
> -	unsigned long lpar_rc;
>  	int rc;
> -	union ibmveth_buf_desc rxq_desc;
>  	int i;
> -	struct device *dev;
>  
>  	netdev_dbg(netdev, "open starting\n");
>  
> -	napi_enable(&adapter->napi[0]);
> -
> -	for(i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>  		rxq_entries += adapter->rx_buff_pool[0][i].size;
>  
> -	rc = -ENOMEM;
> -	adapter->buffer_list_addr[0] = (void *)get_zeroed_page(GFP_KERNEL);
> -	if (!adapter->buffer_list_addr[0]) {
> -		netdev_err(netdev, "unable to allocate list pages\n");
> +	rc = ibmveth_alloc_rx_qstats(adapter);
> +	if (rc)
>  		goto out;
> -	}
>  
> -	adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
> -	if (!adapter->filter_list_addr) {
> -		netdev_err(netdev, "unable to allocate filter pages\n");
> -		goto out_free_buffer_list;
> -	}
> -
> -	dev = &adapter->vdev->dev;
> +	rc = ibmveth_alloc_filter_list(adapter);
> +	if (rc)
> +		goto out_free_rx_qstats;
>  
> -	adapter->rx_queue[0].queue_len = sizeof(struct ibmveth_rx_q_entry) *
> -						rxq_entries;
> -	adapter->rx_queue[0].queue_addr =
> -		dma_alloc_coherent(dev, adapter->rx_queue[0].queue_len,
> -				   &adapter->rx_queue[0].queue_dma, GFP_KERNEL);
> -	if (!adapter->rx_queue[0].queue_addr)
> +	rc = ibmveth_alloc_rx_queues(adapter, rxq_entries);
> +	if (rc)
>  		goto out_free_filter_list;
>  
> -	adapter->buffer_list_dma[0] = dma_map_single(dev,
> -						     adapter->buffer_list_addr[0],
> -						     4096, DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(dev, adapter->buffer_list_dma[0])) {
> -		netdev_err(netdev, "unable to map buffer list pages\n");
> +	rc = ibmveth_alloc_buffer_pools(adapter);
> +	if (rc)
>  		goto out_free_queue_mem;
> -	}
>  
> -	adapter->filter_list_dma = dma_map_single(dev,
> -			adapter->filter_list_addr, 4096, DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(dev, adapter->filter_list_dma)) {
> -		netdev_err(netdev, "unable to map filter list pages\n");
> -		goto out_unmap_buffer_list;
> -	}
> +	rc = ibmveth_register_rx_queues(adapter, mac_address);
> +	if (rc)
> +		goto out_free_buffer_pools;
>  
> -	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> -		if (ibmveth_allocate_tx_ltb(adapter, i))
> -			goto out_free_tx_ltb;
> +	rc = netif_set_real_num_rx_queues(netdev, adapter->num_rx_queues);
> +	if (rc) {
> +		netdev_err(netdev, "failed to set number of rx queues\n");
> +		goto out_unregister_queues;
>  	}
>  
> -	adapter->rx_queue[0].index = 0;
> -	adapter->rx_queue[0].num_slots = rxq_entries;
> -	adapter->rx_queue[0].toggle = 1;
> -
> -	mac_address = ether_addr_to_u64(netdev->dev_addr);
> -
> -	rxq_desc.fields.flags_len = IBMVETH_BUF_VALID |
> -					adapter->rx_queue[0].queue_len;
> -	rxq_desc.fields.address = adapter->rx_queue[0].queue_dma;
> -
> -	netdev_dbg(netdev, "buffer list @ 0x%p\n", adapter->buffer_list_addr[0]);
> -	netdev_dbg(netdev, "filter list @ 0x%p\n", adapter->filter_list_addr);
> -	netdev_dbg(netdev, "receive q   @ 0x%p\n", adapter->rx_queue[0].queue_addr);
> -
> -	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
> -
> -	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
> -
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
> -			   lpar_rc);
> -		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
> -			   "desc:0x%llx MAC:0x%llx\n",
> -				     adapter->buffer_list_dma[0],
> -				     adapter->filter_list_dma,
> -				     rxq_desc.desc,
> -				     mac_address);
> -		rc = -ENONET;
> -		goto out_unmap_filter_list;
> -	}
> +	rc = ibmveth_setup_rx_interrupts(adapter);
> +	if (rc)
> +		goto out_unregister_queues;
>  
> -	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		if (!adapter->rx_buff_pool[0][i].active)
> -			continue;
> -		if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
> -			netdev_err(netdev, "unable to alloc pool\n");
> -			adapter->rx_buff_pool[0][i].active = 0;
> -			rc = -ENOMEM;
> -			goto out_free_buffer_pools;
> +	if (adapter->num_rx_queues > 1) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			netdev_dbg(netdev, "initial replenish cycle for queue %d\n", i);
> +			ibmveth_replenish_task(adapter, i);

ibmveth_replenish_task() only has one parameter
until a later patch in this series.

>  		}
> +	} else {
> +		netdev_dbg(netdev, "initial replenish cycle\n");
> +		ibmveth_interrupt(adapter->queue_irq[0], &adapter->napi[0]);
>  	}
>  
> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
> -			 netdev);
> -	if (rc != 0) {
> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
> -			   netdev->irq, rc);
> -		do {
> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
> -		goto out_free_buffer_pools;
> -	}
> -
> -	rc = -ENOMEM;
> -
> -	netdev_dbg(netdev, "initial replenish cycle\n");
> -	ibmveth_interrupt(netdev->irq, netdev);
> +	rc = ibmveth_alloc_tx_resources(adapter);
> +	if (rc)
> +		goto out_cleanup_rx_interrupts;
>  
>  	netif_tx_start_all_queues(netdev);
>  
>  	netdev_dbg(netdev, "open complete\n");
> -
>  	return 0;
>  
> +out_cleanup_rx_interrupts:
> +	ibmveth_cleanup_rx_interrupts(adapter);
> +out_free_tx_resources:
> +	ibmveth_free_tx_resources(adapter);

The out_free_tx_resources label is unused until a later patch of this
series, so it should be added in that patch rather than this one.

And it's not clear to me that ibmveth_free_tx_resources() should
be called when jumping to out_cleanup_rx_interrupts as
in that case ibmveth_alloc_tx_resources() hasn't run successfully.

The AI-generated review on sashiko.dev also highlights the error handling
here:

 "Are the unwind labels ordered incorrectly here?

 "If ibmveth_setup_rx_interrupts() fails, it jumps to
  out_unregister_queues, which is placed after out_free_buffer_pools. Does
  this mean we skip freeing the buffer pools and leak memory?

 "Also, if ibmveth_alloc_tx_resources() fails, it internally frees
  partially allocated LTBs. It then jumps to out_cleanup_rx_interrupts and
  falls through to out_free_tx_resources. Because ibmveth_free_tx_ltb()
  calls dma_unmap_single() unconditionally without checking or zeroing
  tx_ltb_dma, will this cause a double free and an invalid DMA unmap?

 "Finally, in the fall-through path from out_cleanup_rx_interrupts,
  out_free_buffer_pools is executed before out_unregister_queues (which
  calls ibmveth_free_all_queues() to unregister the logical LAN). Does this
  free and unmap the RX buffers while the hypervisor's logical LAN is still
  active, potentially allowing the hypervisor to DMA incoming packets into
  freed memory?


>  out_free_buffer_pools:
> -	while (--i >= 0) {
> -		if (adapter->rx_buff_pool[0][i].active)
> -			ibmveth_free_buffer_pool(adapter,
> -						 &adapter->rx_buff_pool[0][i]);
> -	}
> -out_unmap_filter_list:
> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> -			 DMA_BIDIRECTIONAL);
> -
> -out_free_tx_ltb:
> -	while (--i >= 0) {
> -		ibmveth_free_tx_ltb(adapter, i);
> -	}
> -
> -out_unmap_buffer_list:
> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> -			 DMA_BIDIRECTIONAL);
> +	ibmveth_free_buffer_pools(adapter);
> +out_unregister_queues:
> +	ibmveth_dispose_subordinate_irq_mappings(adapter);
> +	ibmveth_free_all_queues(adapter);
>  out_free_queue_mem:
> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
> -			  adapter->rx_queue[0].queue_addr,
> -			  adapter->rx_queue[0].queue_dma);
> +	ibmveth_cleanup_rx_resources(adapter);
>  out_free_filter_list:
> -	free_page((unsigned long)adapter->filter_list_addr);
> -out_free_buffer_list:
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> +	ibmveth_free_filter_list(adapter);
> +out_free_rx_qstats:
> +	ibmveth_free_rx_qstats(adapter);
>  out:
> -	napi_disable(&adapter->napi[0]);
>  	return rc;
>  }

...
