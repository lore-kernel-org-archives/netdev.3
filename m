Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9A40928B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679532; cv=none; b=szG5phDr8DX8cbxL2s27edqV14LZEir3CkXW2TpV869Cb/1mvcob+vFSfOMfoxu9nb5/wSxtZq37qU+4kONNAOpDKm/irWeBTh5TcKbEBxc99SaIbgj10Oy1Y6H+wsO10lu3Eu08uChItgGpDk2jgwaI5BNK5hrYctzsASvIUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679532; c=relaxed/simple;
	bh=oi5rF7ouPBkJep/Z0t8y5KGsrjciPUV9ss6sOVuL96k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUHq+IQ5hMfA9i41oSqHwmV9X+ZdRTFbCuQfCYdLJTFkPHbvLPEX7ZJM9+CjNNifHO+HFm68lULtxTzCmXrENIlGBzpbEQlDFT7SZYN+S3eUQtg2JD93x1P0qnBHkghjaBZAxjD4OwGMjiczBQIgDoPhhx79ic9Kqi70kOczsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrMQzrGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrMQzrGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC81F00893;
	Thu, 17 Sep 2026 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679530;
	bh=edhHe8MLeq+HSvb8Lrs4e8N4eEnfh6Pbcheey4CKrMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WrMQzrGk1sMkYHJprkLBX80SalIXkdhNu0KYdUKDz94M3d1lwADa+Ni8cEU5ZSGuE
	 5yVEhQL1i361rdRyFZmwJnjgNvhT2wEZ/MKyeSomP0Y5/TofJD9ww3Jo8Lvc/a1wyk
	 vkEkFGmGgCBZ/h3ODWfdLTy9SMNw5ITunASG19I+LUvsTTsn9QOyk1S5vdT2TcviMB
	 LbFNjMBkO3UBh4j6MNrv/2Q0ZrdtNKHKlZQgJ1VecxG33guCBCmop5J3wnKQqOW3+d
	 GVRDZIIh+/1ibdpXVZoKKNzIXB3YZW0KMvJ+mUz0l9orIRENDC7NKnNVEouLd21XLr
	 GtrQL1S71bw7g==
Subject: Re: [net PATCH v2 3/6] eth: fbnic: use the Rx queue napi pointer to
 find the napi vector
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Thu, 17 Sep 2026 21:12:09 +0000
Message-ID: <178967952944.22033.10329187569173798096@kernel.org>
In-Reply-To:
 <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

- [High] The invariant the patch relies on - "The pointer is NULL exactly
  while the datapath is down" - does not hold across PCIe…

Pre-existing issues:
- [High] fbnic_queue_stop() uses nv->qt[t].sub0.q_idx as the queue
  identifier for every triad, but that field is 0 for two kinds of…
- [High] fbnic_alloc_qt_page_pools(): when the queue has an unreadable
  memory provider, the second page_pool_create() overwrites the local…

--

Here is the review report.

eth: fbnic: use the Rx queue napi pointer to find the napi vector

The queue management ndos stop deriving the napi vector from
fbn->napi[idx % fbn->num_napi] and instead read the association that
fbnic_set_netif_napi() published in netdev_rx_queue.napi.  A new helper
fbnic_rxq_nv() performs the lookup, and fbnic_queue_mem_alloc() returns
-ENETDOWN when the pointer is NULL.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 81a30e2d449b2..e93174fc1239f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

[ ... ]

> @@ -2829,6 +2830,17 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
>  	fbnic_wrfl(fbd);
>  }
>  
> +/* Returns the napi vector servicing an Rx queue, or NULL if the datapath
> + * is torn down.  The association is published by fbnic_set_netif_napi()
> + * and cleared by fbnic_reset_netif_napi(), both under the instance lock.
> + */
> +static struct fbnic_napi_vector *fbnic_rxq_nv(struct net_device *dev, int idx)
> +{
> +	struct napi_struct *napi = __netif_get_rx_queue(dev, idx)->napi;
> +
> +	return napi ? container_of(napi, struct fbnic_napi_vector, napi) : NULL;
> +}
> +

[Severity: High]
The commit message says "The pointer is NULL exactly while the datapath is
down".  Does that hold across the resume path?

In fbnic_pci.c, the publish and the enable are split across two calls with
the instance lock dropped in between:

__fbnic_pm_resume()
    netdev_lock()
    __fbnic_open()
        fbnic_set_netif_queues()
            fbnic_set_netif_napi()
                netif_queue_set_napi()   /* publishes rxq->napi */
    netdev_unlock()

__fbnic_pm_attach()
    if (netif_running(netdev))
        fbnic_up(fbn);               /* napi_enable_locked() happens here */
    netif_device_attach(netdev);

In the window between those two, netif_running() is true and rxq->napi is
already non-NULL, but the NAPIs have only been added, not enabled.

Can a queue restart arriving in that window get past the new guard and
reach fbnic_queue_stop()?  netdev_rx_queue_reconfig() has no
netif_device_present() gate:

	err = qops->ndo_queue_mem_alloc(dev, qcfg_new, new_mem, rxq_idx);
	...
	if (netif_running(dev)) {
		err = qops->ndo_queue_stop(dev, old_mem, rxq_idx);

One reachable caller is netdev_nl_sock_priv_destroy() on netlink socket
close, which takes netdev_lock(dev) and walks
net_devmem_unbind_dmabuf() -> netif_mp_close_rxq() ->
netdev_rx_queue_reconfig().

[ ... ]

> @@ -2841,8 +2853,16 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
>  	if (!netif_running(dev))
>  		return fbnic_alloc_qt_page_pools(fbn, qt, idx);
>  
> +	/* A failed PCIe recovery or resume can leave the datapath torn down
> +	 * while netif_running() is still true.  This ndo runs before
> +	 * netdev_rx_queue_restart() checks netif_running(), so bail out
> +	 * rather than touching rings and vectors that are already freed.
> +	 */
> +	nv = fbnic_rxq_nv(dev, idx);
> +	if (!nv)
> +		return -ENETDOWN;
> +

[Severity: High]
Continuing the point above: does a non-NULL rxq->napi actually imply the
datapath is up?  For the resume window the pointer is published while the
vectors exist but are not enabled, so this check passes and
fbnic_queue_stop() runs napi_disable_locked() on a NAPI that was only added
by netif_napi_add_config_locked(), which leaves NAPI_STATE_SCHED and
NAPI_STATE_NPSVC set:

net/core/dev.c:napi_disable_locked() {
	...
	do {
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

napi_enable_locked() is the only thing that clears those bits, and it has
not run yet, so does this loop spin forever with the netdev instance lock
held, blocking the pending fbnic_up(), dev_close(), unregister and ethtool?

Would a "datapath enabled" state test, or moving fbnic_up() inside the
instance-locked region of the resume path, be a better fit than keying off
the published pointer?

> +	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
> -	nv = fbn->napi[idx % fbn->num_napi];
>  
>  	fbnic_ring_init(&qt->sub0, real->sub0.doorbell, real->sub0.q_idx,
>  			real->sub0.flags);

[Severity: High]
This is a pre-existing issue, but since both branches of this ndo reach it,
could fbnic_alloc_qt_page_pools() be dereferencing an error pointer?  The
second page_pool_create() overwrites the local pp, and the error label then
destroys that value rather than the pool it should be releasing:

	qt->sub0.page_pool = pp;
	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
		...
		pp = page_pool_create(&pp_params);
		if (IS_ERR(pp))
			goto err_destroy_sub0;
	...
err_destroy_sub0:
	page_pool_destroy(pp);
	return PTR_ERR(pp);

net/core/page_pool.c:page_pool_destroy() only filters NULL:

	if (!pool)
		return;

	if (!page_pool_put(pool))
		return;

so page_pool_put() would dereference the ERR_PTR, and qt->sub0.page_pool
leaks because netdev_rx_queue_reconfig() does not call ndo_queue_mem_free
on the mem_alloc failure path.  The reachable trigger is a devmem or
io_uring bind on a queue with an unreadable memory provider where the
second page_pool_create() fails with -ENOMEM, or where the provider's
->init() returns an error.  Would saving the error before destroying
qt->sub0.page_pool address this?

[ ... ]

> @@ -2915,7 +2935,7 @@ static int fbnic_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	int err;
>  
>  	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
> -	nv = fbn->napi[idx % fbn->num_napi];
> +	nv = fbnic_rxq_nv(dev, idx);
>  	fbnic_dbg_nv_exit(nv);
>  
>  	napi_disable_locked(&nv->napi);

[Severity: High]
This isn't a bug introduced by this patch, but does the standalone-Tx
configuration this patch targets remain incorrect afterwards?  The rest of
fbnic_queue_stop() uses sub0.q_idx as the queue identifier:

	for (i = 0; i < nv->txt_count; i++)
		netif_stop_subqueue(dev, nv->qt[i].sub0.q_idx);
	fbnic_nv_disable(fbn, nv);

	for (t = 0; t < nv->txt_count + nv->rxt_count; t++) {
		err = fbnic_wait_queue_idle(fbn, t >= nv->txt_count,
					    nv->qt[t].sub0.q_idx);

but sub0.q_idx is 0 for two kinds of triads.  For the placeholder Tx triad
of an Rx-only vector, fbnic_alloc_napi_vector() sets:

		} else {
			fbnic_ring_init(&qt->sub0, db, 0,
					FBNIC_RING_F_DISABLED);
		}

and for the Rx BDQ rings:

		db = &uc_addr[FBNIC_QUEUE(rxq_idx) + FBNIC_QUEUE_BDQ_HPQ_TAIL];
		fbnic_ring_init(&qt->sub0, db, 0,
				FBNIC_RING_F_CTX | FBNIC_RING_F_STATS);

so the real HW block index only lives in cmpl.q_idx.

For an Rx-only vector, does netif_stop_subqueue(dev, 0) freeze netdev Tx
queue 0, a live ring owned by another vector, with __fbnic_nv_restart()
later re-waking it on both the success and err_restart paths?

	for (i = 0; i < nv->txt_count; i++)
		netif_wake_subqueue(fbn->netdev, nv->qt[i].sub0.q_idx);

And for Rx queue N > 0, does fbnic_wait_queue_idle(fbn, true, 0) poll Rx
queue 0's HPQ/PPQ/RCQ idle bits rather than queue N's, so quiescence of the
ring being torn down is never established before fbnic_nv_flush() cleans and
unmaps the BDQ pages and memsets the RCQ?  Similarly,
fbnic_wait_queue_idle(fbn, false, 0) on the disabled placeholder polls HW Tx
queue 0, which this path never disables, so under Tx load it would time out
and take the err_restart path naming the wrong queue.

fbnic_nv_flush() already carries the guard these two loops lack:

		/* Nothing else to do if Tx queue is disabled */
		if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
			continue;

Should the stop/wake and idle-wait loops skip FBNIC_RING_F_DISABLED rings
and use the identifier appropriate to each triad?  A configuration that
reaches this today is combined 2 rx 2, which fbnic_set_channels() accepts
since only rx && tx && combined is rejected; that yields num_napi 4 with
vectors 2 and 3 having tqpv == 0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178941996343.7700.9376081102002673062.stgit%40ahduyck-xeon-server.home.arpa
