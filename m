Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348286;
	b=nUylLKb+UhR5JX5Bne55OFiUYR9Xm1ZRn5fS5wo069wQoBchLjEIrkX8ugo4t6AhSl8E
	 cEmZpHTrQOrR1rW7WVnCRW+yc6cgVhvzd5Fgn/dXrIXPvQQkpLtW1+I7Y8/qxAVai8Pte
	 GQUasA0X32YuzLRjGan6M8rgE93rvKfVXq5HKVwklwYC3fenevFOmPofSOLC81UsId3ho
	 5pi3YazvQUVv3skTFBbNxsL75UfFvDIGTrxvX/m0JIBNUPNv4eSnY+2PsosFBLppOITZo
	 FuL4sDHYYO3MtCM/ksY8y2vAqmv2RrF2Dtzh8V1F6q2SLSeeXUSE2GuDDuXByQ2Hmog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FE9OFEAREbObkeiG8+NcXSlXqb0BjD28xvU3A8qsv8w=;
	b=mnkbMAtJJN8QCNkX/K9VDTZWBrP6HdDQOyGMJdoJs2lzq06Xgz9HMTj2aid5EgMsS3dA
	 SncKYtHkC+yUvd7W4G+cNKo0NV94RDNfF1QqDcslZ60ieL8n22DfVDikNIQpI4lqTzRjX
	 qWD3hh0UhEpc+i+ZjmXeTegFSD5+Asq/TSejqhancxEaJl2AtObdsKwd2cX8zDu1u5Prz
	 X9N+Xgk/0ovWzPO6jraMJE6U1y2w8ryvM10vPd5F8xzevSLmEjCUceMVKpDqscKnYS4gV
	 sO2PQsO4JFI1jxkX50qHadcrgW9FJaofKDsB+e5PY78KYmiNfnp9UhZIG6i/17tgQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7OkKIJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873660A2600;
	Tue, 10 Nov 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7OkKIJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C457B1F008A7;
	Tue, 10 Nov 2026 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348286;
	bh=FE9OFEAREbObkeiG8+NcXSlXqb0BjD28xvU3A8qsv8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7OkKIJZoB32e/DO+QRShttvfvaNb+H2rcUAD/ccdTvRX5NHXVrJcSmTvnATuQfB9
	 u4QbYhHg0D36RaOrI8t64THeRsBUpb1U4/LEdfvPrkJb3t3hC0Wv7p5SRWVVoRI4dI
	 lvxi4nZX5Q8mOEbNJl9oOTjJGGytFafMO9vUyfTTEiDCpKcu575ZmC7gHXJ9ESDaM5
	 4dYYjzdsCwIVgbMrWWGgvwRnSBYsg9lKSKaDATFCAtfDc8lnD+yE1FFg9L6tKH13wX
	 eZEOF2PQD3GrO0fQTiXS94qDX02YkoreO5Jo2czxFn3KFSaERiVMNQRBhhqfeHD+7s
	 g3JpGLsQ6Lyzw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.machon@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr
Subject: Re: [PATCH net-next 9/9] net: sparx5/lan969x: add support for changing the MTU
Date: Tue, 10 Nov 2026 14:04:45 -0800
Message-ID: <20261110220445.2337277-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-sparx5-mtu-change-v1-9-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-9-f27bab580463@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5/lan969x: add support for changing the MTU

This commit adds an ndo_change_mtu callback for sparx5 and lan969x ports.
It programs the MAC maximum frame length, resizes the shared FDMA buffers,
and updates the queue watermarks and the TAS guard band. MTU changes are
only allowed when the FDMA is used, and max_mtu is raised to 13982 in that
case.

> The MTU of a port is currently fixed to 1500, as the MAC maximum frame
> length, the FDMA buffers, the queue watermarks and the TAS guard band
> are all sized for a 1518 byte frame.

[Severity: Low]
Is "fixed to 1500" accurate? Before this patch, sparx5_netdev.c had no
ndo_change_mtu. The netdevs come from devm_alloc_etherdev_mqs(), so
ether_setup() gives min_mtu 68 and max_mtu 1500, and __netif_set_mtu()
just does:

net/core/dev.c:__netif_set_mtu() {
    ...
	if (ops->ndo_change_mtu)
		return ops->ndo_change_mtu(dev, new_mtu);

	/* Pairs with all the lockless reads of dev->mtu in the stack */
	WRITE_ONCE(dev->mtu, new_mtu);
    ...
}

So every board accepted any MTU from 68 to 1500.

With the new sparx5_port_change_mtu(), every system using register based
extraction now gets -EOPNOTSUPP for every MTU change. That includes
decreases such as "ip link set ethX mtu 1400", which used to work. These
systems are:

  - Sparx5 rev 0, because sparx5_frame_io_init() only requests the FDMA
    IRQ when GCB_CHIP_ID_REV_ID_GET(chip_id) > 0 || !is_sparx5()
  - boards without an fdma IRQ
  - boards where FDMA init failed

Could the commit message describe this as a removed capability, and give
the actual reason for it (see the sparx5_xtr_grp() comment below)?

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> index b3725cf2dd44c..095925752f5f6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> @@ -250,6 +250,44 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
>  	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
>  }
>  
> +static int sparx5_port_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct sparx5_port *port = netdev_priv(dev);
> +	struct sparx5 *sparx5 = port->sparx5;
> +	bool resize = new_mtu > dev->mtu;
> +	int err;
> +
> +	/* Register based extraction sizes its skbs from the MTU at the time
> +	 * a frame is read, so it cannot handle frames queued before an MTU
> +	 * decrease.
> +	 */
> +	if (sparx5->fdma_irq <= 0)
> +		return -EOPNOTSUPP;

[Severity: High]
This isn't a bug introduced by this patch, but this check also quietly
closes a heap overflow in register based extraction. That overflow is
still present in current and stable kernels.

sparx5_xtr_grp() in sparx5_packet.c sizes the skb from the current MTU. It
then copies extraction words until EOF without checking tailroom:

drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:sparx5_xtr_grp() {
    ...
	skb = netdev_alloc_skb(netdev, netdev->mtu + ETH_HLEN);
    ...
		default:
			*rxbuf = val;
			byte_cnt += 4;
			rxbuf++;
    ...
	skb_put(skb, byte_cnt - ETH_FCS_LEN);
    ...
}

Without this patch, sparx5_port_init() programs MAC_MAXLEN_CFG with the
fixed ETH_MAXLEN (1518), whatever dev->mtu is set to. There is also no
ndo_change_mtu, so "ip link set ethX mtu 68" succeeds.

After that, a normal 1518 byte frame to the CPU (larger with VLAN tags)
would be copied into an skb with only about 256 bytes of tailroom. Wouldn't
that overrun skb_shared_info and the neighbouring slab objects before
skb_put() reaches skb_over_panic() and BUG() in the xtr IRQ handler?

The commit message presents this check as a feature limit ("frames queued
before an MTU decrease would not fit"). There is no Fixes: tag, so stable
kernels remain exposed.

Would a separate net fix with a Fixes: tag make sense, for example
bounding the copy loop in sparx5_xtr_grp() against the skb tailroom? The
loop itself is unchanged here, so it is still only safe while the MAC
maxlen fits within the slack of an skb sized from dev->mtu.

> +
> +	/* Never let the MAC accept frames larger than the RX buffers */
> +	if (!resize)
> +		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
> +
> +	err = sparx5->data->ops->fdma_resize(sparx5, port, new_mtu);

[Severity: Medium]
Can an MTU change leak the two-step PTP state on lan969x?

When sparx5_port_change_mtu() resizes the buffers,
lan969x_fdma_resize() pauses and resets the FDMA. Then
lan969x_fdma_tx_reset() walks the TX descriptors that are still marked
used after lan969x_fdma_tx_clear_buf(). Those frames were never
injected, but for a two-step PTP frame the loop only does:

	if (!db->ptp)
		dev_kfree_skb_any(db->skb);

	db->used = false;

The skb was queued on port->tx_skbs by sparx5_ptp_txtstamp_request(),
which also incremented sparx5->ptp_skbs. As the frame never reached the
rewriter, sparx5_ptp_irq_handler() will never get a timestamp for it,
so nothing releases that state.

The skb itself is eventually freed by
sparx5_ptp_txtstamp_old_release() once SPARX5_PTP_TIMEOUT has passed
and another two-step frame is sent. That function does not decrement
sparx5->ptp_skbs, though. So every MTU change under two-step PTP load
can leak slots. Once ptp_skbs reaches SPARX5_MAX_PTP_ID, every further
two-step timestamp request fails with -EBUSY until the driver is
reloaded.

sparx5_ptp_txtstamp_release() fixes up ptp_skbs and unlinks the skb,
but it also decrements port->ts_id. That is only correct for the most
recently requested skb. How should the dropped PTP descriptors be
released here? Would it work to unlink them from port->tx_skbs,
decrement ptp_skbs under ptp_ts_id_lock and then free them? Freeing
them without the unlink would leave a dangling skb on port->tx_skbs.

[Severity: High]
Can the resize path double free an RX page on lan969x?

With ndo_change_mtu, lan969x_fdma_resize() can now run at any time,
and it goes through lan969x_fdma_rx_free() and
lan969x_fdma_free_pages(). That function returns every non-NULL
rx->page[i][j] to rx->page_pool with page_pool_put_full_page().

To make that safe, lan969x_fdma_rx_get_frame() clears
rx->page[fdma->dcb_index][fdma->db_index] before it returns the skb.
The free_page error path does not:

	free_page:
		page_pool_recycle_direct(rx->page_pool, page);

		return NULL;

That path is taken when build_skb() fails under memory pressure, or
when the IFH carries an invalid source port. The page goes back to the
pool, but the slot still points to it. lan969x_fdma_napi_poll() then
breaks out of its loop without advancing fdma->dcb_index, so the DB is
not refilled and the stale pointer stays in place.

A later MTU change on any port, or lan969x_fdma_deinit() on teardown,
would then call page_pool_put_full_page() on a page the pool may
already have handed out again, to another DB or to an skb that is still
in flight in the stack. Wouldn't that corrupt the page_pool and lead to
a use-after-free?

Simply clearing the slot in the free_page path doesn't look sufficient
either. If I read lan969x_fdma_napi_poll() correctly, the next poll
calls lan969x_fdma_rx_get_frame() on the same DB again. It would then
pass a NULL page to page_address(). As the code stands, it re-reads the
page that was just recycled. Should the error path drop the frame,
advance past the DB and let the refill loop replace the page? That way
each slot is always either owned by the ring or NULL.

[Severity: Medium]
Can this resize allocate the whole RX ring with GFP_ATOMIC from sleepable
context?

sparx5_port_change_mtu() runs under RTNL. On Sparx5 the call chain is:

sparx5_port_change_mtu()
  sparx5_fdma_resize()
    sparx5_fdma_rx_alloc(rx_new)
      fdma_dcbs_init()
        sparx5_fdma_rx_dataptr_cb()

For each of the 64 x 15 = 960 buffers, sparx5_fdma_rx_dataptr_cb() does:

	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);

With the new max_mtu of 13982, db_size becomes 14080 bytes. Each skb head
is then an order-2 kmalloc allocation, so the ring needs roughly 15 MB of
GFP_ATOMIC memory in total, and the old ring is still allocated while this
happens.

Without __GFP_DIRECT_RECLAIM this can neither reclaim nor compact. It could
drain the atomic reserves that NAPI refills rely on. It could also fail
with -ENOMEM on fragmented memory where GFP_KERNEL would have succeeded.

Could the RX allocation used for resize take a gfp argument, so that
GFP_KERNEL is used here?

The TX ring in the same path comes from fdma_alloc_phys(), which does a
kzalloc(GFP_KERNEL) of about 900 KB (order-8) without __GFP_NOWARN. A
failure there would also print an allocation failure warning.

> +	if (err) {
> +		if (resize)
> +			return err;
> +
> +		/* The current, larger, buffers still fit all frames */
> +		netdev_warn(dev, "Failed to resize FDMA buffers: %d\n", err);
> +	}

[ ... ]

> @@ -306,7 +345,14 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
>  
>  	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
>  		if (sparx5->ports[portno]) {
> -			err = register_netdev(sparx5->ports[portno]->ndev);
> +			struct net_device *ndev = sparx5->ports[portno]->ndev;
> +
> +			/* The MTU can only be changed when FDMA is used */
> +			if (sparx5->fdma_irq > 0)
> +				ndev->max_mtu = SPX5_MAX_FRAME_LEN - ETH_HLEN -
> +						ETH_FCS_LEN;

[Severity: High]
This isn't a bug introduced by this patch, but raising max_mtu here makes
an existing RX refill problem much more likely to trigger.

sparx5_fdma_napi_callback() ignores the return value of fdma_dcb_add():

	fdma_dcb_add(fdma, fdma->dcb_index,
		     FDMA_DCB_INFO_DATAL(fdma->db_size),
		     FDMA_DCB_STATUS_INTR);
	fdma_db_reset(fdma);
	fdma_dcb_advance(fdma);

lan969x_fdma_napi_poll() does the same in its refill loop.

If the dataptr callback fails for any DB, __fdma_dcb_add() returns early:

	for (i = 0; i < fdma->n_dbs; i++) {
		err = __fdma_db_add(fdma, dcb_idx, i, status, db_cb);
		if (unlikely(err))
			return err;
	}

At that point the DB's status has already been reset (DONE cleared), but
the DCB has not been linked after fdma->last_dcb. The next successful
fdma_dcb_add() then links DCB k-1 directly to DCB k+1, so the hardware
never visits DCB k again.

Once the software dcb_index wraps back to k, wouldn't
sparx5_fdma_rx_get_frame() (or fdma_has_frames() on lan969x) keep
returning false? That would stop CPU RX on the shared FDMA for all ports
until another resize or a driver reload.

Before this series, a Sparx5 refill was roughly a 4 KB request and a
lan969x refill was order-0. With max_mtu at 13982, each Sparx5 refill
becomes an order-2 GFP_ATOMIC allocation, and lan969x page_pool pages
become order-2. Those allocations can realistically fail in NAPI context
on a fragmented system.

Should refill failures be handled, for example by retrying the refill
later, before jumbo MTUs are allowed?

> +
> +			err = register_netdev(ndev);
>  			if (err) {
>  				dev_err(sparx5->dev,
>  					"port: %02u: netdev registration failed\n",
