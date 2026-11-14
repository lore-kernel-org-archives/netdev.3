Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626245;
	b=3hHHxOB4vCH+9gKs/2UvBr8u8EsYT5WMpQplpEJc0LLRFhcKU/N6TJfytzUm1XQcrwSK
	 oji8VE8GXRBQsJ3PY9XtKcNfvBUjwIffC7lztIttbgdyJAFf8zVQ7vO/H1IIGdgJnNQb7
	 tGXqFzIwhFmN2JndxckZ2c+N9Wckft88RufP2nfdOQSDkPtzWNdFYFFmlMywcBFc/IrYI
	 Y44in1/D9mM8Vsxpa5Ts13V5scVrXpyjNji3z+v1PoqIAEpnwHLLHaL5VKtkxJ2oJphJU
	 CI7GIMVzGzvgdUvKJMa0kKTTyge2yJM+frmqLE0CFep5uW/6gfx8XcfComvt6eCQaXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626245;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UeUmQlHI016FWc2GtU+omrnUDG8yr9QFHyk54TJrDgM=;
	b=1E0dhAu/PtEYlhhheXAnnWf4HsmP4DsSYVWtXfE6L6tbYhFyIFfUCXPIdl4zeTcwbrvD
	 DJs+bh9+ekhXFv5vrpyeyg654Zy11czXklMm5Y1BrB6hTSmrQE9Bj55KgMKu7Gtk3r1KK
	 p1YVEaVaw8SvUj26vHtBBvfoeQuY/VDTi520DODVe6qylY6EnUTsA6WSE6QBb20+IPif4
	 z1KOhlEEgl8ojINiInHWt8A6tMUcUqL2pdPsByOW+g1nUwbGmXDpKLHhWjtiyb1vvZlPS
	 ZXI/es/noGOHaKu8EWfXYKkP4q11IUGdZd2a6XIQuifjJVawCbGUW3Dx/xv34N8yEDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpGArjdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C5606A880;
	Sat, 14 Nov 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpGArjdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C841F000C4;
	Sat, 14 Nov 2026 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626244;
	bh=UeUmQlHI016FWc2GtU+omrnUDG8yr9QFHyk54TJrDgM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mpGArjdtKnV/cOSeWxM8hccBn42b+WGWl8ZM8EJi+Rk7xv82LYXFCcUM1Pxmt5ZfE
	 E5C8sLQ8cVa8B6PYe8eLjeb4bVLl4/9X7o/2YCbvFrcx5kIiwG8zeGeRT3Z4ZvrHcU
	 HfbtwGdbB4GIrlDOqr6t9zBvHm2h8aPKob28ygnAjWXe/nG+mLs1KXKQP9Wg1b8Rl0
	 3dVtV2AR9Cz15Oif0ygswJLou15J/+zYzUA1UpKKs7GOtL1Wuqj2t3k+ElOYS2Wuwf
	 HLlJvi1YRGTvxKHAOqn1gRTrKXIXNHg6hI6TsbWDcap13iH7enq8S6ina9EsZcCrG+
	 b0Poh6UXJxwOQ==
Subject: Re: [PATCH v4 net 4/4] net: hns3: fix use-after-free in debugfs read
 during reset/unload
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 03:17:23 +0000
Message-ID: <179462624369.2199510.9731791501410411401@kernel.org>
In-Reply-To: <20261111125810.3359030-5-shaojijie@huawei.com>
References: <20261111125810.3359030-5-shaojijie@huawei.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch serializes teardown against debugfs readers with
  dbg_mutex, but the reset re-init path still hands the new resources to…
- [Low] The patch changes debugfs behaviour in ways the commit message
  does not describe.
- [Low] hns3_set_ringparam() runs under RTNL (ethtool core) and now calls
  mutex_lock(&h->dbg_mutex) without first telling in-flight debugfs…

--

net: hns3: fix use-after-free in debugfs read during reset/unload

This patch adds a dbg_mutex to struct hnae3_handle. The enet-layer
debugfs show callbacks take it, and so do the client uninit path, the
reset uninit path and the ring reallocation in hns3_set_ringparam().
The readers also re-check the INITED and RESETTING state bits on each
iteration and return -EBUSY when the device is busy.

Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 1347edac76993..a58ca42dbcd97 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> @@ -389,6 +389,12 @@ static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
>  static const char * const
>  dim_tune_stat_str[] = { "ON_TOP", "TIRED", "RIGHT", "LEFT" };
>  
> +static bool hns3_dbg_is_device_busy(struct hns3_nic_priv *priv)
> +{
> +	return !test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
> +	       test_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
> +}
> +

[Severity: Medium]
dbg_mutex now serializes readers against the uninit writers. Is the
re-init side of reset covered as well?

hns3_reset_notify_init_enet() reallocates priv->ring, priv->tqp_vector,
priv->vector_num and ring->desc without taking dbg_mutex. It then
publishes them with a plain bitop:

hns3_reset_notify_init_enet() {
    ret = hns3_get_ring_config(priv);
    ...
    ret = hns3_nic_alloc_vector_data(priv);
    ...
    ret = hns3_init_all_ring(priv);
    ...
    set_bit(HNS3_NIC_STATE_INITED, &priv->state);
}

Later, hns3_reset_notify_up_enet() does a plain
clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state).

On the reader side, hns3_dbg_is_device_busy() uses plain test_bit().
The callers then load priv->ring, priv->tqp_vector and ring->desc.

The reader's mutex_lock() only pairs with the unlock in the uninit
path. The init path never takes the mutex.

On a weakly ordered CPU such as arm64, can a reader see INITED set and
RESETTING clear, but still load the post-uninit values of those
pointers?

If that happens, priv->ring would be NULL, because
hns3_put_ring_config() clears it. This patch also removes the
if (!priv->ring) checks from hns3_dbg_rx_queue_info() and
hns3_dbg_tx_queue_info().

priv->tqp_vector would be stale, because hns3_nic_dealloc_vector_data()
frees it with devm_kfree() and never sets it to NULL. In that case
hns3_dump_coal_info() would read freed memory.

The writer issues many full barriers before clear_bit(RESETTING), so
this is hard to hit in practice.

Would either of these close the window?

  - set INITED under dbg_mutex in the init path
  - use release/acquire bitops: smp_mb__before_atomic() before
    set_bit(), and test_bit_acquire() in the reader

[ ... ]

> @@ -779,6 +806,11 @@ static int hns3_dbg_dev_info(struct seq_file *s, void *data)
>  static void hns3_dump_page_pool_info(struct hns3_enet_ring *ring,
>  				     struct seq_file *s, u32 index)
>  {
> +	if (!ring->page_pool) {
> +		seq_printf(s, "%-10u %s\n", index, "page pool not initialized");
> +		return;
> +	}
> +
>  	seq_printf(s, "%-10u%-14u%-14d%-21u%-7u%-9d%uK\n",
>  		   index,
>  		   READ_ONCE(ring->page_pool->pages_state_hold_cnt),
> @@ -796,28 +828,27 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
>  	struct hns3_enet_ring *ring;
>  	u32 i;
>  
> +	mutex_lock(&priv->ae_handle->dbg_mutex);
>  	if (!priv->ring) {
> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
> -		return -EFAULT;
> -	}
> -
> -	if (!priv->ring[h->kinfo.num_tqps].page_pool) {
> -		dev_err(&h->pdev->dev, "page pool is not initialized\n");
> -		return -EFAULT;
> +		mutex_unlock(&priv->ae_handle->dbg_mutex);
> +		return -EBUSY;
>  	}

[Severity: Low]
This changes the result of reading page_pool_info when page pools are
not set up, which has nothing to do with reset. It applies when the
module is loaded with page_pool_enabled=0, or when page_pool_create()
fails in hns3_alloc_page_pool().

Before this patch, the read failed with -EFAULT and logged "page pool
is not initialized". Now it succeeds and prints one "page pool not
initialized" row per queue.

The patch also changes some error codes:

  - the per-iteration error goes from -EPERM to -EBUSY in
    hns3_dbg_rx_queue_info(), hns3_dbg_tx_queue_info() and
    hns3_dbg_page_pool_info()
  - the priv->ring == NULL error here goes from -EFAULT to -EBUSY

The commit message only says:

    Userspace-visible change: debugfs reads under
    /sys/kernel/debug/hns3/*/ that race with reset, driver unload, or
    ethtool ring resize now return -EBUSY instead of potentially reading
    freed or zero-filled memory.

These changes are only explained in the v3/v4 changelog notes, which
won't be part of the commit. Could the commit message mention them?

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 14642f81efe1a..7005d8b2d010b 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -1252,6 +1252,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
>  	if (if_running)
>  		ndev->netdev_ops->ndo_stop(ndev);
>  
> +	mutex_lock(&h->dbg_mutex);
>  	hns3_change_all_ring_bd_num(priv, new_ringparam.tx_desc_num,
>  				    new_ringparam.rx_desc_num);
>  	hns3_change_rx_buf_len(ndev, new_ringparam.rx_buf_len);

[Severity: Low]
hns3_set_ringparam() runs under RTNL. The only state change it makes
before taking dbg_mutex is ndo_stop() -> hns3_nic_net_stop(), which
sets HNS3_NIC_STATE_DOWN.

hns3_dbg_is_device_busy() only checks INITED and RESETTING. A reader
already inside a show callback therefore never gets -EBUSY on this
path.

For example, hns3_dbg_bd_info_show() -> hns3_dbg_tx_bd_info() walks all
ring->desc_num entries, up to HNS3_RING_MAX_PENDING (32760), with one
seq_printf() per descriptor. Meanwhile:

ethtool -G
  rtnl_lock()
  hns3_set_ringparam()
    ndo_stop()                   /* sets DOWN only */
    mutex_lock(&h->dbg_mutex)    /* waits for the whole dump */

Doesn't this hold RTNL for a full show() call, blocking every other
RTNL user in the meantime?

The per-iteration checks bound the reset path's wait, but not this
writer's. The commit message covers readers that arrive during
set_ringparam, which are blocked by the mutex. It doesn't cover readers
already in flight.

Would it help to set a state bit that hns3_dbg_is_device_busy() checks
before set_ringparam takes dbg_mutex?

> @@ -1270,6 +1271,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
>  		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
>  			hns3_fini_ring(&tmp_rings[i]);
>  	}
> +	mutex_unlock(&h->dbg_mutex);
>  
>  	kfree(tmp_rings);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111125810.3359030-1-shaojijie%40huawei.com
