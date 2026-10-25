Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932180;
	b=gyJiQd6FMSSRDEZvJHDfq63W23EiTLtyLaxnlW0Piipf7rFE/e1WGG2CJZQeII9nQHP7
	 zmH/z3oMbhUA9FJD4PUPUWDEvy7cOGh34RgzweLDoetEN7pmWQBJJ1PzIXV1mOzoxuLBK
	 vvrL/5AVZnafOL15CealCJr8PFwNjY+FG9GXJhTqVg8BYtn1tooCDBcMQgTFBWKNoi7q7
	 8kqYGaPMCKh6pNZqjx+/0qXPyytiHwy4dHP1fveMsIzFoMRjIn91I/qjCucexUL1nN35Q
	 xSVubs1YiWAJUoK2xBGtk/q/Tf9FMHKa0vklfVkmJ28BK2OMnDe0wIE/I/Uj25gkDRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932180;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dfJW5Cw5TEMrVjAHKPwoDYvPhiu8458sBOj9KSPO4gs=;
	b=N/kw2lwGXgHyxjbK+d1UF8wZ5XjXRV4l1bZFjAIh+43p3ZRJ8vu61dP2mD8HoPSEkglm
	 oTI53CYvHo1PDgXLGkwNOK3icn9GuuccT4ZT3YqdLci4uq7JV0NJUFMgyNTZR5heZBWcU
	 +aJvT4aHw6rQjF3nWd2SU6TV5kVfXuzz1n7gIIs4QF4bpbATniosfB6rrwTBiaPV0XEMI
	 igTFSgfdZE3OnTrl7f39Vs5mR3JPJ5GqZbTQdM4raCfVWdVt2RjjahbE7k5TLLdogYclc
	 cYNauXUcOwE0J0dGO/xWiOlHOrpaAt0gigBmMXREsLhu+RY7qHsvVL/nbsSg1lT4/7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1pVJKsR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB7606A321;
	Sun, 25 Oct 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1pVJKsR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29B31F031E0;
	Sun, 25 Oct 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792932179;
	bh=dfJW5Cw5TEMrVjAHKPwoDYvPhiu8458sBOj9KSPO4gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D1pVJKsRNUziksndSkpJVMJZsTIiV/97P1gY8m6KHF7E08zgDNddbMYv0m4d1Ze0p
	 JF3y/0ZqdkogcBdg5mOCeU+CqdEdWHqamsf69wXKXZeyYgYD1RCKEoUycmiwRXQVxV
	 TmzE+7pP/7tnYdZqPGhxFNpG505bnc82zrd0qy3vNueOTUZiEgWOATEYNZv6o4AuC6
	 5aKxrGZ2HOnegI0emNHvGlCLmdIKBV+NcgIditxAvQDc+mmn7ldnaWHQx9HT0F7IHl
	 WggiP+1ra4bvceZp8LE47Xza/pFve/mbXSwmN9JP7wdSR7dBOLwDKRyRiyEFoA7ZMy
	 hbxxzUyDN8kXA==
Subject: Re: [PATCH v2 net 3/3] net: hns3: fix use-after-free in debugfs read
 during reset/unload
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 12:42:58 +0000
Message-ID: <179293217840.3134.10721469015486402363@kernel.org>
In-Reply-To: <20261021121426.3096838-4-shaojijie@huawei.com>
References: <20261021121426.3096838-4-shaojijie@huawei.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] dbg_mutex is taken only on the teardown paths
  (hns3_reset_notify_uninit_enet, hns3_client_uninit,…
- [Medium] The Fixes tag and changelog put the whole root cause on
  eced3d1c41db ("net: hns3: use seq_file for files in queue/ in…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  rewrites the guard and makes the outcome worse.
- [Medium] This problem wasn't introduced by this patch, but
  hns3_set_ringparam() reports success for a failed ring resize when the…
- [Medium] This problem wasn't introduced by this patch, but
  hns3_alloc_ring_memory() leaks a newly created RX page pool when RX…

--

net: hns3: fix use-after-free in debugfs read during reset/unload

This patch adds a dbg_mutex to struct hnae3_handle. The enet-layer
debugfs show callbacks take it, and so do the reset uninit, client
uninit and ethtool ring resize paths while they free rings and vectors.
The debugfs readers also re-check INITED/RESETTING on every loop
iteration.

Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/

> The seq_file refactoring of hns3 debugfs removed the per-file entry
> state checks. Without them, debugfs show callbacks can access
> priv->ring, priv->tqp_vector, and ring->desc while these resources
> are being freed by reset, driver unload, or ethtool ring resize.

[ ... ]

> Fixes: eced3d1c41db ("net: hns3: use seq_file for files in queue/ in debugfs")

[Severity: Medium]
Is this Fixes tag complete?

Before eced3d1c41db, hns3_dbg_read() did a single INITED/RESETTING test
before running the dump. It shared no lock with
hns3_reset_notify_uninit_enet() or hns3_client_uninit. That is the same
window the changelog describes as "Plain state-bit checks leave a TOCTOU
window between check and use".

The ring resize race is older still. Since a723fb8efe29d3 ("net: hns3:
refine for set ring parameters"), hns3_set_ringparam() has freed the old
descriptors with:

	for (i = 0; i < h->kinfo.num_tqps * 2; i++)
		hns3_fini_ring(&tmp_rings[i]);

It never clears HNS3_NIC_STATE_INITED or sets HNS3_NIC_STATE_RESETTING.
So no state-bit check, old or new, would stop a concurrent tx_bd_info or
rx_bd_info reader from walking ring->desc. Also, eced3d1c41db only
converted rx_queue_info and queue_map.

Stable trees that predate eced3d1c41db have the debugfs vs ring resize
use-after-free. If backports go by this tag alone, would those trees be
skipped? Should a723fb8efe29d3 get a Fixes tag as well, and should the
changelog's wording about ethtool ring resize be adjusted?

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 1347edac76993..40d715924e588 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c

[ ... ]

> @@ -796,13 +823,9 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
>  	struct hns3_enet_ring *ring;
>  	u32 i;
>  
> -	if (!priv->ring) {
> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
> -		return -EFAULT;
> -	}
> -
> -	if (!priv->ring[h->kinfo.num_tqps].page_pool) {
> -		dev_err(&h->pdev->dev, "page pool is not initialized\n");
> +	mutex_lock(&priv->ae_handle->dbg_mutex);
> +	if (!priv->ring || !priv->ring[h->kinfo.num_tqps].page_pool) {
> +		mutex_unlock(&priv->ae_handle->dbg_mutex);
>  		return -EFAULT;
>  	}
>  
> @@ -810,14 +833,17 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
>  	seq_puts(s, "POOL_SIZE(PAGE_NUM)  ORDER  NUMA_ID  MAX_LEN\n");
>  
>  	for (i = 0; i < h->kinfo.num_tqps; i++) {
> -		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
> -		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
> -			return -EPERM;
> +		/* Per-iteration check bounds reset latency to one iteration. */
> +		if (hns3_dbg_is_device_busy(priv)) {
> +			mutex_unlock(&priv->ae_handle->dbg_mutex);
> +			return -EBUSY;
> +		}
>  
>  		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
>  		hns3_dump_page_pool_info(ring, s, i);

[Severity: High]
This is a pre-existing issue, but the check above only looks at the
page_pool of the first RX ring. The loop then passes every RX ring to
hns3_dump_page_pool_info(), which dereferences ring->page_pool without
a NULL check:

	READ_ONCE(ring->page_pool->pages_state_hold_cnt),
	atomic_read(&ring->page_pool->pages_state_release_cnt),
	ring->page_pool->p.pool_size,

hns3_alloc_page_pool() creates the pool separately for each RX ring. On
failure it leaves the pool NULL and ring init carries on:

	ring->page_pool = page_pool_create(&pp_params);
	if (IS_ERR(ring->page_pool)) {
		dev_warn(...);
		ring->page_pool = NULL;
	}

If the first RX ring got a pool and a later one did not (for example
after a transient allocation failure), can reading page_pool_info oops on
the NULL page_pool?

With this patch the oops would happen while dbg_mutex is held. Would
later calls to hns3_reset_notify_uninit_enet(), hns3_client_uninit() or
hns3_set_ringparam() then block forever in
mutex_lock(&handle->dbg_mutex)?

>  	}
>  
> +	mutex_unlock(&priv->ae_handle->dbg_mutex);
>  	return 0;
>  }
>  
> @@ -826,17 +852,23 @@ static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
>  	struct hns3_dbg_data *data = s->private;
>  	struct hnae3_handle *h = data->handle;
>  	struct hns3_nic_priv *priv = h->priv;
> +	int ret;
>  
> -	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
> -	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
> -		return -EBUSY;
> +	mutex_lock(&priv->ae_handle->dbg_mutex);
> +	if (!priv->ring) {
> +		mutex_unlock(&priv->ae_handle->dbg_mutex);
> +		return -EFAULT;
> +	}

[Severity: High]
Can a debugfs reader still dereference a freed priv->ring during reset
re-init?

hns3_reset_notify_uninit_enet(), hns3_client_uninit() and
hns3_set_ringparam() all take dbg_mutex, but
hns3_reset_notify_init_enet() never does. That function publishes a new
priv->ring while INITED is still clear. Its error unwind then frees
everything again without the mutex:

hns3_reset_notify_init_enet() {
	ret = hns3_get_ring_config(priv);
	...
err_init_irq_fail:
	hns3_uninit_all_ring(priv);
err_uninit_vector:
	hns3_nic_uninit_vector_data(priv);
err_dealloc_vector:
	hns3_nic_dealloc_vector_data(priv);
err_put_ring:
	hns3_put_ring_config(priv);
	...
}

The INITED/RESETTING entry check has been replaced with a bare priv->ring
check. So a reader in this window takes dbg_mutex unopposed and passes
the check. It then enters hns3_dbg_tx_bd_info() or hns3_dbg_rx_bd_info(),
and both dereference priv->ring before their first busy check:

	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
	for (i = 0; i < ring->desc_num; i++) {
		if (hns3_dbg_is_device_busy(priv))
			return -EBUSY;

If hns3_put_ring_config() runs at the same moment, the ring->desc_num
load reads devm-freed memory. If priv->ring has already been set back to
NULL, it faults on NULL plus an offset.

hns3_dbg_page_pool_info() looks to have the same problem, because its
check indexes priv->ring[h->kinfo.num_tqps] before any busy check.

Before this patch, hns3_dbg_bd_info_show() returned -EBUSY in this
window because INITED was clear. The changelog says the mutex "rejects a
reader that arrives after the writer has finished tearing down resources
(priv->ring is NULL by then)". That doesn't seem to hold once re-init has
reallocated priv->ring.

Would it work to take dbg_mutex in hns3_reset_notify_init_enet() around
the allocation, the error unwind and set_bit(HNS3_NIC_STATE_INITED)?
Alternatively, the busy check could stay ahead of the first priv->ring
dereference.

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 392653635bda2..cb6a23085be48 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -1258,6 +1258,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
>  	if (if_running)
>  		ndev->netdev_ops->ndo_stop(ndev);
>  
> +	mutex_lock(&h->dbg_mutex);
>  	hns3_change_all_ring_bd_num(priv, new_ringparam.tx_desc_num,
>  				    new_ringparam.rx_desc_num);
>  	hns3_change_rx_buf_len(ndev, new_ringparam.rx_buf_len);

[Severity: Medium]
This is a pre-existing issue, but can the hns3_init_all_ring() call that
follows here leak an RX page pool when buffer allocation fails?

hns3_alloc_ring_memory() creates the pool and then allocates the
buffers:

	if (!HNAE3_IS_TX_RING(ring)) {
		if (page_pool_enabled)
			hns3_alloc_page_pool(ring);

		ret = hns3_alloc_ring_buffers(ring);
		if (ret)
			goto out_with_desc;
	...
out_with_desc:
	hns3_free_desc(ring);
out_with_desc_cb:
	devm_kfree(ring_to_dev(ring), ring->desc_cb);

The error path never calls page_pool_destroy(ring->page_pool). And
hns3_init_all_ring() only unwinds the rings before the failing one:

	for (j = i - 1; j >= 0; j--)
		hns3_fini_ring(&priv->ring[j]);

After that the pointer is lost. hns3_set_ringparam() memcpy()s the saved
ring over priv->ring[i], and the probe/reset paths free priv->ring via
hns3_put_ring_config().

Would the page_pool, its ptr_ring and any pages that
hns3_alloc_ring_buffers() already returned to it be leaked for good?

> @@ -1276,6 +1277,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
>  		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
>  			hns3_fini_ring(&tmp_rings[i]);
>  	}
> +	mutex_unlock(&h->dbg_mutex);
>  
>  	kfree(tmp_rings);
>  

[Severity: Medium]
This is a pre-existing issue, but suppose if_running is true and
hns3_init_all_ring() fails. The revert path restores the old ring
parameters, and then ret is overwritten just after this point:

	if (if_running)
		ret = ndev->netdev_ops->ndo_open(ndev);

	return ret;

If the reopen succeeds, does hns3_set_ringparam() return 0 for a resize
that was rolled back, so that ethnl_set_rings() reports success to
userspace?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021121426.3096838-1-shaojijie%40huawei.com
