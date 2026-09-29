Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEC470120
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710398; cv=none; b=gKIRUNgf/4NCPkOpG2xSJPJU/n+1+0AwJPrYf4Zde1PQK/AoFZ6xTkRosQ8oQbrckPyUQCPHasCtqE578t1xQVqxcZ/bgcxxEOp+WzvlzGcwPBwvlOBDsiX17khQf0OXbkyNIq734pls/KNmLqdS9VfIkmQRkejEpee4GxGDgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710398; c=relaxed/simple;
	bh=60CHDOpJtqLpp6gY2rogYOK7AAiu/JNpMIPkkSJ9FDw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3V6vR0XPsRa8eG9MyaCgijGiKOBbEvoV1g8YwcYx0u4L485qlukfINTj/TCG41ZErSiiYOTBuZGTk/XLUbcAAjQ3EiwSYmCZlzzKSVkW3JuhE21V09QMRoqFvDncINFBb/vOyU02dKPsGLUdgeG3JjA5hI0HWrRERiWZCtJlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3/2YrxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3/2YrxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345FF1F000FF;
	Tue, 29 Sep 2026 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710397;
	bh=uuTiuxp2mvND32WnJrw5yJBDRTO/GoFqn57Of633a0w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B3/2YrxX8QQ+zme40Ix0XobIn+t2O6N/LRvDefdoe4rdLviIRBVckTYDWeg0PF2vv
	 ObX5B0CMtIZuRTEBYGGY2PObg0LqPSyLfh4pXqlfg+efWPnUfvKOe/+ghpyCJe5DKv
	 z2Yhn7vnPgEYa3cM8uYTRVQrKtTYVNKc8i+jNKWEROBbIo326C9w+tcAP/tC9ql2rQ
	 aRMV+VR5+Wdty50bEgit7BJobeEy3W0WH3uelGlFyHVDwRjL90c5dH7apMeoiL7h0m
	 eScmaEt2uT6FLnsMQ/ndQn7RJg7Z0XfFnvbnJ34+ZrjyyeaTs0hCHMItQoO6SgMjSg
	 ehVt4iOVdvfpg==
Subject: Re: [PATCH net-next v7 03/15] ibmveth: Refactor RX resource
 allocation for MQ RX bring-up
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Tue, 29 Sep 2026 19:33:15 +0000
Message-ID: <179071039577.434549.807910519500023697@kernel.org>
In-Reply-To:
 <2320895ef517f70b063eca84766723ff20019748.1790319558.git.mmc@linux.ibm.com>
References:
 <2320895ef517f70b063eca84766723ff20019748.1790319558.git.mmc@linux.ibm.com>
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

- [Low] This patch silently fixes an existing DMA mapping leak in
  ibmveth_open().

Pre-existing issues:
- [High] If ibmveth_alloc_buffer_pool() fails after
  ibmveth_register_logical_lan() has succeeded, ibmveth_open() jumps to…
- [Medium] In ibmveth_open(), the buffer-pool unwind and the TX LTB
  unwind share the loop variable `i`.
- [Medium] ibmveth_update_rx_no_buffer() checks
  adapter->buffer_list_addr[0] and then loads it again, with no lock and…

--

ibmveth: Refactor RX resource allocation for MQ RX bring-up

This patch moves the filter list and per-queue RX buffer list and RX ring
allocation out of ibmveth_open() into new helpers, and makes both the
open() error path and close() free them through the same cleanup helpers.
It also NULL-checks buffer_list_addr[0] in ibmveth_update_rx_no_buffer()
and sets rc = -ENOMEM before the TX LTB allocation loop.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 7cb828b476c1b..01efd318baabb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -390,8 +578,12 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   */
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	__be64 *p;
>  
> +	if (!adapter->buffer_list_addr[0])
> +		return;
> +
> +	p = adapter->buffer_list_addr[0] + 4096 - 8;
>  	adapter->rx_no_buffer = be64_to_cpup(p);
>  }

[Severity: Medium]
This is a pre-existing race and was not introduced by this patch, but the
new check makes it a little more visible.

set_csum, set_tso, change_mtu and pool_store all do a driver-internal
close/open. netif_running() stays true during that, and netpoll is not
disabled. That means this path:

  ibmveth_poll_controller()->ibmveth_replenish_task()
    ->ibmveth_update_rx_no_buffer()

can run at the same time as:

  ibmveth_close()->ibmveth_cleanup_rx_resources()
      free_page((unsigned long)adapter->buffer_list_addr[i]);
      adapter->buffer_list_addr[i] = NULL;

The NULL check and the pointer load are two separate plain reads of
buffer_list_addr[0], with no lock and no READ_ONCE().

Could the reader pass the check, then reload NULL and fault at offset
0xff8? Could it also read the page after free_page() has run, as the
baseline code already could?

As far as I can tell this is dealt with later in the series.
ibmveth_close() clears adapter->opened first, calls synchronize_net(), and
reads the no-buffer count under replenish_lock before freeing anything.
ibmveth_poll_controller() returns early when !opened.

[ ... ]

> @@ -752,26 +902,12 @@ static int ibmveth_open(struct net_device *netdev)
>  			ibmveth_free_buffer_pool(adapter,
>  						 &adapter->rx_buff_pool[0][i]);
>  	}
> -out_unmap_filter_list:
> -	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
> -			 DMA_BIDIRECTIONAL);
> -
>  out_free_tx_ltb:
> -	while (--i >= 0) {
> +	while (--i >= 0)
>  		ibmveth_free_tx_ltb(adapter, i);

[Severity: Medium]
This isn't a bug introduced by this patch, but the buffer pool unwind and
the TX LTB unwind share the loop variable i.

If ibmveth_alloc_buffer_pool() or request_irq() fails, out_free_buffer_pools
runs its own while (--i >= 0) loop, which leaves i == -1. Execution then
falls through to this loop.

Doesn't this loop then run zero times and leak every tx_ltb_ptr[] buffer
and its DMA mapping?

This looks like it gets fixed later in the series.
"ibmveth: Refactor buffer pool management for per-queue MQ RX" moves the
pool loop into a helper, and "ibmveth: Refactor TX resource allocation in
open/close paths" moves the TX allocation into ibmveth_alloc_tx_resources()
at the end of open(). After those patches the two unwinds no longer share
an index.

> -	}
> -
> -out_unmap_buffer_list:
> -	dma_unmap_single(dev, adapter->buffer_list_dma[0], 4096,
> -			 DMA_BIDIRECTIONAL);
> -out_free_queue_mem:
> -	dma_free_coherent(dev, adapter->rx_queue[0].queue_len,
> -			  adapter->rx_queue[0].queue_addr,
> -			  adapter->rx_queue[0].queue_dma);
> +	ibmveth_cleanup_rx_resources(adapter);

[Severity: High]
This is a pre-existing issue, but it is on the unwind path this patch
rewires.

The buffer pool failure branch in ibmveth_open() runs after
ibmveth_register_logical_lan() has already succeeded:

	if (ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0][i])) {
		netdev_err(netdev, "unable to alloc pool\n");
		adapter->rx_buff_pool[0][i].active = 0;
		rc = -ENOMEM;
		goto out_free_buffer_pools;
	}

The request_irq() failure path calls h_free_logical_lan() before its goto.
This branch does not.

Execution then reaches ibmveth_cleanup_rx_resources() and
ibmveth_free_filter_list(). Those call dma_free_coherent() on the RX queue
and unmap and free the buffer list and filter list pages, while PHYP still
has all of them registered.

Can the hypervisor then write RX descriptors or the no-buffer counter into
freed memory?

The later patches in the series seem to address this.
"ibmveth: Refactor TX resource allocation in open/close paths" adds
h_free_logical_lan() on this path. "ibmveth: Add RX queue register helpers
for MQ" allocates the buffer pools before registration.

>  out_free_filter_list:
> -	free_page((unsigned long)adapter->filter_list_addr);
> -out_free_buffer_list:
> -	free_page((unsigned long)adapter->buffer_list_addr[0]);
> +	ibmveth_free_filter_list(adapter);

[Severity: Low]
Does this change behavior on the TX LTB failure path in a way the commit
message doesn't mention?

In the baseline, the filter list was mapped before the TX LTB loop, and a
failed ibmveth_allocate_tx_ltb() jumped to out_free_tx_ltb. That label sits
below out_unmap_filter_list, so the unmap was skipped. The page was then
freed by free_page() in out_free_filter_list while its DMA/TCE mapping was
still live.

After this patch the same failure reaches ibmveth_free_filter_list(), which
unmaps before freeing.

The commit message describes this as a helper extraction:

  "Runtime behavior stays single-queue (num_rx_queues is still 1)."

Should the commit message mention this fix? Should it also be split out
with a Fixes: tag, so that stable trees pick up the filter list unmap fix?

>  out:
>  	napi_disable(&adapter->napi[0]);
>  	return rc;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790319558.git.mmc%40linux.ibm.com
