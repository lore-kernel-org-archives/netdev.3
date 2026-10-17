Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CC23EA83;
	Sat, 17 Oct 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264096; cv=none; b=c2qDCxp4rgLHN0tTbL7psd/NNQuKpwAyvvUFur/4OCpE8owpB30BIyY/Hk+oY50lRNP9+EAzPNY1miS6xR4NnpxPCTqMy17w6fuGXtfNwD1iYIcmkXdWTngSpnb3ML8guNF5eHWUrHt4lsHdolZTgree+74pR/LOa0vmXQ9YYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264096; c=relaxed/simple;
	bh=c51o9l3/NhHX26W3POToEcNavGwehAUBX4h4UJ9toSs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKFkcaAlwEncSWqa+q9HKXftrlZPREdUKYLKkUZXqzfZHeXOS1QZaka9EE+7KMRlY0XR8GAsrVV3BwA0lB4PAhMDtUruS53F4ZkIn+U2LpmyS87C7LRkQvZzuL7/eiUqF/RiiaoaSMfArtnxgaaZliH29XItHt54441knnztI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jigt6WS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jigt6WS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A21F000C4;
	Sat, 17 Oct 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264094;
	bh=80e7dn/9HosAZfscXoCerVzxvFXCY8gzTImPcrb+cas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jigt6WS/v8NaNnoQ/m9rQZHuMrE2oJlyk3oL6Hn7qo3Aqp+VC2El0HLIQTQ9uyuCR
	 f+qZMNHeKG+l0cq9jt7q3J/ck3OYifbWtZH6jQ4WoWb+PN7lIahfhBmhmsT0EvA3AM
	 cN3rNDON8q78L/WkmJonddQoqsYMNHM87OBk49XXsySah2szc4zJP9Eoy6wGu/qkSU
	 I5YXlnetyLuqB008GFQdoXAXnmS8BihkB5Mu2o3QHPprd53o7frHpqSoXlHkyCCR+W
	 CJZihwQimOEo+eAlY3LjODnu+YBarfb868Jx6ykBZWrcwMrcmZMoWGa4yb0BPGND7U
	 U0JNHtHqCcJzg==
Subject:
 Re: [PATCH net-next v5 1/9] ibmveth: fix netpoll races with RX replenish
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, tlfalcon@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, zdai@us.ibm.com, pradeeps@linux.vnet.ibm.com,
 ksiva@linux.vnet.ibm.com
Date: Sat, 17 Oct 2026 19:08:13 +0000
Message-ID: <179226409314.3135.18021801258743580648@kernel.org>
In-Reply-To: <20261013182926.30417-2-mmc@linux.ibm.com>
References: <20261013182926.30417-2-mmc@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] napi_disable() waits only for ownership (SCHED/NPSVC) to be
  released, not for the ibmveth_poll() callback to return.

Pre-existing issues:
- [High] Not introduced by this patch: ibmveth_remove() calls
  cancel_work_sync(&adapter->work)…
- [High] Not introduced by this patch: ibmveth_rx_mss_helper() trusts the
  IPv4 header of a received frame.

--

ibmveth: fix netpoll races with RX replenish

This patch removes ibmveth_poll_controller(), so netpoll now polls NAPI
directly with budget 0. ibmveth_poll() skips RX replenish when budget is
0. ibmveth_open() now enables NAPI just before request_irq(), after the
RX resources exist.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index abebdb1fc2628..4a5869183be66 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -717,10 +715,18 @@ static int ibmveth_open(struct net_device *netdev)
>  		}
>  	}
>  
> +	/* NAPI can run as soon as it is enabled, from netpoll during the
> +	 * direct close()/open() pairs or from a direct ibmveth_interrupt()
> +	 * call, so enable it only once everything ibmveth_poll() touches
> +	 * exists.
> +	 */
> +	napi_enable(&adapter->napi);
> +
>  	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>  	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>  			 netdev);
>  	if (rc != 0) {
> +		napi_disable(&adapter->napi);
>  		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>  			   netdev->irq, rc);
>  		goto out_free_buffer_pools;

[Severity: Medium]
Is napi_disable() enough here before the goto frees the RX queue?

napi_disable() waits for the NAPI ownership bits to clear. It does not
wait for ibmveth_poll() to return. After napi_complete_done(), the poll
keeps running:

ibmveth_poll()
    napi_complete_done(napi, frames_processed)
    h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE)
    ibmveth_rxq_pending_buffer(adapter)   <- reads rx_queue.queue_addr

The out_free_buffer_pools path then reaches dma_free_coherent() on
adapter->rx_queue.queue_addr. ibmveth_close() has the same gap between
napi_disable() and its dma_free_coherent() of the RX queue.

A poll can run in this window. netpoll can poll NAPI once it is
enabled, and veth_pool_store() kicks the interrupt handler after
dropping RTNL:

veth_pool_store()
    rtnl_unlock();

    /* kick the interrupt handler to allocate/deallocate pools */
    ibmveth_interrupt(netdev->irq, netdev);

Can the end of the poll read the freed RX queue, or re-enable the
interrupt after close() has masked it?

The later commit "ibmveth: wait for the RX poll to return before
freeing the RX queue" in this series seems to fix this. It adds
synchronize_net() after napi_disable() in ibmveth_close() and in this
request_irq() failure path. The new comment says this patch hardens the
direct close()/open() window. Could that change be folded in here?

[ ... ]

> @@ -1542,7 +1547,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  		}
>  	}
>  
> -	ibmveth_replenish_task(adapter);
> +	/* netpoll polls with budget 0 for TX only, and is not serialized
> +	 * with a NAPI poll that was already running when it was set up
> +	 */
> +	if (budget)
> +		ibmveth_replenish_task(adapter);
>  
>  	if (frames_processed == budget)
>  		goto out;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
RX loop in ibmveth_poll() calls ibmveth_rx_mss_helper() whenever the
IPv4 checksum field is 0xffff, whatever csum_good says:

    if ((length > netdev->mtu + ETH_HLEN) ||
        lrg_pkt || iph_check == 0xffff) {
            ibmveth_rx_mss_helper(skb, mss, lrg_pkt);

The helper uses iph->ihl * 4 as the TCP offset. It does not check
skb_headlen(), ihl >= 5, or fragmentation:

ibmveth_rx_mss_helper()
    offset = iph->ihl * 4;
    ...
    tcph = (struct tcphdr *)(skb->data + offset);
    ...
        skb_shinfo(skb)->gso_size = ntohs(tcph->check);
        tcph->check = 0;
    ...
        hdr_len = offset + tcph->doff * 4;
        skb_shinfo(skb)->gso_segs =
                DIV_ROUND_UP(skb->len - hdr_len,
                             skb_shinfo(skb)->gso_size);

Can a short IPv4/TCP frame from another partition on the virtual LAN,
with check set to 0xffff and a large ihl, make this read and write
tcph->check past the received data? On the copybreak path, those bytes
are uninitialized skb memory.

With an oversized doff, can skb->len - hdr_len underflow and put bogus
gso_segs into the skb passed up the stack?

The later commit "ibmveth: check headers in the RX large send and
checksum helpers" in this series adds skb_headlen(), ihl, fragment,
doff and ip_len checks to ibmveth_rx_mss_helper() before it touches the
headers. That looks like it fixes this.

[Severity: High]
This isn't a bug introduced by this patch, but further down,
ibmveth_poll() can still queue the reset work when re-enabling the
interrupt fails:

    lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
    if (WARN_ON(lpar_rc != H_SUCCESS)) {
            schedule_work(&adapter->work);
            goto out;
    }

ibmveth_remove() cancels that work before it unregisters the device,
so NAPI can still run after the cancel:

ibmveth_remove()
    cancel_work_sync(&adapter->work);
    ...
    unregister_netdev(netdev);

    free_netdev(netdev);

If a poll queues adapter->work after cancel_work_sync() returns, can
ibmveth_reset() run on the adapter after free_netdev() has freed it?

The later commit "ibmveth: disable the reset work before unregister in
remove" in this series seems to fix this. It replaces cancel_work_sync()
with disable_work_sync(), which waits for a running reset and blocks
later queueing.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013182926.30417-1-mmc%40linux.ibm.com
