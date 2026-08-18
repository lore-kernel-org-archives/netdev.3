Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715A4A23
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017640; cv=none; b=OQR+mAPONOfXjp0jRKRtWP+jpT1ViwkTGb1z2tgBt9eoIrbnck5YYR4sqWXrb6yAvWVzAyCeXv3oV4jZOVI6V2ighycNWMFAB0VmoKKeHviEi3kw3IIeZIpPcYile/d4glTohGpVU1wFgKazhlCVX+Tnn7Erjk1P3FpdwnTHq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017640; c=relaxed/simple;
	bh=og3fOjFk/2stJF+nKuCPVGaVKvJY1vE3XOz+83CVuco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZw7+M6xbbrLh4UCHC6JfBjRUgi3AY8RakV/RZv2jamfUazeW/qbsImDAPLtU5GaAQdsbwBNghGR0XiDhp1cxC04Vts9coePp0u6DuBqssXRFn848zaFoL8d8Ru87FsVBDsvi9YSqJa+PmKEY+cR5kqU+3iySbjXAwEM64y7PF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6wPuGQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6wPuGQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDE11F00A3A;
	Tue, 18 Aug 2026 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017639;
	bh=vBl4BR2i70MzIRt+YA2cPqlMbq5OaTO/K6e/n4feFVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6wPuGQP+k49kEZgBoWnHIdY+lhRl6QgCMm6Xqv33rwviGrYkPN4OuI2ktpteZSbX
	 U73f1xAqAlmBk/DdbtPh2TkzHuioO1gPgyv1HpjS9xC623sDhjr6J+t29RW/fEpWND
	 go4JPdIsxeTPoG5ogDlYNcppfr//JP9+E1U2asIbThmXbExRMU1W3YMVqI0ibWlSYb
	 gIN/tLZoIeJ7drD238AmK0nuGyuhcG77MCmy5496qrcD1b9KHgM7zyU7fHACv6Di9Q
	 3B+miha5oFU/5i0RHYZzGh/kDlbfeKkSiQC1Q45GP5NRXP6cL5ekEI2Rc709mOl/CU
	 bdN0ZIFzghZWg==
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
Subject: Re: [PATCH net-next v5 02/15] ibmveth: Prepare MQ RX adapter data structures
Date: Mon, 17 Aug 2026 18:47:17 -0700
Message-ID: <20260818014717.3853945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-3-mmc@linux.ibm.com>
References: <20260814073642.24630-3-mmc@linux.ibm.com>
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
ibmveth: Prepare MQ RX adapter data structures

This converts the single-instance RX state in struct ibmveth_adapter (napi,
buffer_list_addr/dma, rx_queue, rx_buff_pool) into queue-indexed arrays sized
by a new IBMVETH_MAX_RX_QUEUES, and adds queue_handle[]/queue_irq[] plus
multi_queue/num_rx_queues bookkeeping. All existing references are
mechanically retargeted to index 0, and IBMVETH_MAX_RX_QUEUES is kept at 1 so
behaviour is unchanged.

No Link: tags are present in the commit header.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d8..7cb828b476c1b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -482,24 +486,24 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>  
>  	mb();
>  
> -	atomic_dec(&(adapter->rx_buff_pool[pool].available));
> +	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>  
>  	return 0;
>  }

[Severity: Low]
This isn't a bug, but the v5 change notes below the --- separator say the
"extra atomic_dec parentheses" nit from v4 was dropped, and that "this tip
patch keeps only the mechanical [0] retargeting".

The atomic_dec() in ibmveth_remove_buffer_from_pool() still drops the
redundant inner parentheses that the baseline had:

	-	atomic_dec(&(adapter->rx_buff_pool[pool].available));
	+	atomic_dec(&adapter->rx_buff_pool[0][pool].available);

Should the changelog be adjusted, or the parentheses kept as-is so the hunk
really is index-only?

[ ... ]

> @@ -1876,6 +1886,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> +	/* Initialize queue count - always 1 for now */
> +	adapter->multi_queue = 0;
> +	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +

[Severity: Low]
At this commit these two assignments in ibmveth_probe() are the only accesses
to multi_queue and num_rx_queues, and queue_handle[]/queue_irq[] have neither
a reader nor a writer anywhere in the driver.

Combined with IBMVETH_MAX_RX_QUEUES being 1U, every array conversion in this
patch is a pure layout change with no behavioural effect.

Is it worth mentioning in the commit message which later patch first consumes
each of these fields? Reading the rest of the series, queue_irq[] and
queue_handle[] get their first users in ibmveth_toggle_irq() and
ibmveth_register_logical_lan_queue(), num_rx_queues is read through
ibmveth_get_num_rx_queues(), and IBMVETH_MAX_RX_QUEUES becomes 16U in
"ibmveth: Enable multi-queue RX receive path", so nothing is broken here.

>  	if (ret == H_SUCCESS &&
>  	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT)) {
>  		adapter->rx_buffers_per_hcall = IBMVETH_MAX_RX_PER_HCALL;
> @@ -1898,10 +1912,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
>  
>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> -		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
> +		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>  		int error;
>  
> -		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
> +		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>  					 pool_count[i], pool_size[i],
>  					 pool_active[i]);
>  		error = kobject_init_and_add(kobj, &ktype_veth_pool,

[Severity: Low]
This is a pre-existing issue and is not introduced by this patch, which only
rewrites rx_buff_pool[i] to rx_buff_pool[0][i] on these lines.

The kobjects registered here live inside netdev_priv() memory, and the probe
failure paths after this loop call free_netdev() without a matching
kobject_del()/kobject_put():

	rc = register_netdev(netdev);
	if (rc) {
		free_netdev(netdev);
		return rc;
	}

The only teardown loop is in ibmveth_remove():

	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
		kobject_put(&adapter->rx_buff_pool[0][i].kobj);

which a failed probe never reaches, so a netif_set_real_num_tx_queues() or
register_netdev() failure leaves live .../poolN sysfs directories backed by
freed storage.

Worth noting this is addressed later in the same series: "ibmveth: Enable
multi-queue RX receive path" adds ibmveth_probe_cleanup(), which calls
ibmveth_put_pool_kobjs() before free_netdev() on both probe failure paths.

[ ... ]

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index c0ef03cad9b9a..fc6a01e810c6e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -257,6 +257,8 @@ static inline long h_illan_attributes(unsigned long unit_address,
>  #define IBMVETH_MAX_TX_BUF_SIZE (1024 * 64)
>  #define IBMVETH_MAX_QUEUES 16U
>  #define IBMVETH_DEFAULT_QUEUES 8U
> +#define IBMVETH_MAX_RX_QUEUES 1U
> +#define IBMVETH_DEFAULT_RX_QUEUES 1U
>  #define IBMVETH_MAX_RX_PER_HCALL 8U

[ ... ]

> +	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
> +	u64 queue_handle[IBMVETH_MAX_RX_QUEUES];
> +	unsigned int queue_irq[IBMVETH_MAX_RX_QUEUES];
> +	int multi_queue;
> +	unsigned int num_rx_queues;

[ ... ]
