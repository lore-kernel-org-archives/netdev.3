Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701111;
	b=vNR6FV6HrhGPc1A4ew1XFrYrIf8pcM6OgHXA06krC9+DOtqQ/B93gXIvuXubXJEPNZqL
	 4mFb1hT6wz6N/NGPBRQrCFIH5WxksagCHV30V1zG8jIV7qTCB7kvSUm9HgU663rqpp+tS
	 h9xj8O8Xezjg5rWMGOWlvviLpuqOqRPZYZaaw7pTCmMUalJj3KwNXxI0W4WsYHyMYdvla
	 Z+6Ci5cAnbbb/oMqnjAJI00u03vYsstsndfz6/GK533BkMKJgX5SZuk2YNHfp60XdICLj
	 HVYSKQ/aEOb6JRlsL0HNIDDB0xLbS0NIqAuFSo6OI8su3i7W2crD/APVZXw18OkdTpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701111;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P6pKaddLieJPuDKVqFNHjYwbekK3mN/mC2mI+xptbxs=;
	b=qkyGQNKrjCm63AShJ6HJx4qZshIkUwOGU6LLffh9zqjIzNktzZ9ZGNWHoTkwYr15oYOz
	 SSy6Mo1fDEpCrJKGg4k3PtOtm9+NXIzCFdsmGaNKPhti/USnT+V8dRBkvdBOZxbolIcPG
	 iRgBorP6WoAzevz3p2ySZS7tJvlAI7tlHyUOnM+Sw6lUT5D57SEbxeo441/ttnmqKeBi5
	 LG7sS8/zylnLb7PprMzEvDhCZ1+fBg9qyeXQOawcerqPCuDlOYAZofh3qPxecUyAOOgYy
	 sLw3d7TQhAEDSmObdwwlzAleUAEV7QTxhRIdYQcjF4meigbMKCNX8RPXnHoWSetZQQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DghhoIX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C876082BDA;
	Tue,  3 Nov 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DghhoIX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B971F00A15;
	Tue,  3 Nov 2026 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701111;
	bh=P6pKaddLieJPuDKVqFNHjYwbekK3mN/mC2mI+xptbxs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DghhoIX49OJeVFiezEwGmGCIeDe7GfrES4WtVpGIGiiv6EObbNB2ALi4Chrmpb+Df
	 6FhmA31ZNi0Zkz25GsmfJ4y7XvAELe2HAogMoOPptzzvCLCOQ3l/CHId0/lpaADD7R
	 AqJNGpycM+v5N/ZhBYLVUNusOgT4birqwoo3SY5vXvgExFS11qftPpiFezFXftUjUA
	 oCAKlJ3Zk5uZc4VoN4UFuNK0WcifA2zcudp59n5NeXnWp4p9Hu9ilMQJ2aMJUeF1Y8
	 Ri+Kcu+R9X76SAfRnWt71GDIK2V5WraF6Rf/KaWlj5y/BOwfnlKV4mItkEu2RAYeS+
	 CJCEVidSnDBCA==
Subject: Re: [PATCH v3 net 4/4] net: hns3: fix use-after-free in debugfs read
 during reset/unload
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:18:29 +0000
Message-ID: <179370110993.488856.16079849196581146332@kernel.org>
In-Reply-To: <20261030095633.377289-5-shaojijie@huawei.com>
References: <20261030095633.377289-5-shaojijie@huawei.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Within this series, the earlier commit "net: hns3: fix interface
  stuck after OOM with full hardware rx queue" makes…
- [High] net: hns3: uncanceled oom_task in hns3_client_uninit() and reset
  uninit
- [Medium] The init-side writers that rebuild and republish the debugfs-
  visible resources never take dbg_mutex, and they publish readiness…
- [Low] hns3_set_ringparam() is the third dbg_mutex writer, and it does
  not follow the writer protocol that the commit message and comments…
- [Low] The patch changes what userspace sees from several hns3 debugfs
  files, and the permanent commit body does not mention it.
- [Low] Sibling debugfs readers now report the same device state with
  different errno values.

Pre-existing issues:
- [Medium] In hns3_set_ringparam(), when hns3_init_all_ring() fails, ret
  holds the error and the old ring configuration is restored.

--

net: hns3: fix use-after-free in debugfs read during reset/unload

This patch adds a dbg_mutex to struct hnae3_handle. The enet-layer
debugfs show callbacks take it, and so do the reset uninit, driver unload
and ethtool ring resize paths while they free or rebuild rings and
vectors. Readers also re-check the INITED/RESETTING state bits on every
loop iteration through a new helper, hns3_dbg_is_device_busy().

Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 1347edac76993..ec08672372f03 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c

[ ... ]

> @@ -448,18 +454,34 @@ static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
>  	seq_puts(s, "HW_GL  HW_QL\n");
>  
>  	for (i = 0; i < priv->vector_num; i++) {
> +		/* Per-iteration check bounds reset latency to one iteration. */
> +		if (hns3_dbg_is_device_busy(priv))
> +			return -EBUSY;
> +
>  		tqp_vector = &priv->tqp_vector[i];
>  		hns3_get_coal_info(tqp_vector, s, i, is_tx);
>  	}

[Severity: Medium]
Is the state check enough to order these readers against the reset init
side?

The uninit writers take dbg_mutex, but the init path that republishes
these resources does not. hns3_reset_notify_init_enet() assigns new
priv->ring, priv->tqp_vector, priv->vector_num and ring->desc without
dbg_mutex. It then publishes readiness with a plain bitop:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_reset_notify_init_enet() {
    ...
	ret = hns3_get_ring_config(priv);
    ...
	ret = hns3_nic_alloc_vector_data(priv);
    ...
	ret = hns3_init_all_ring(priv);
    ...
	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
    ...
}

Later, hns3_reset_notify_up_enet() runs
clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state), again without
dbg_mutex.

Neither set_bit() nor clear_bit() is ordered, and the test_bit() calls in
hns3_dbg_is_device_busy() have no acquire semantics. The reader's
mutex_lock() pairs only with an earlier unlock by an uninit writer or
another reader. It never pairs with the init writer.

On arm64, could a reader see INITED set and RESETTING clear but still load
the old priv->tqp_vector here? hns3_nic_dealloc_vector_data() frees that
array with devm_kfree() and does not clear the pointer, so the stale value
would point to freed memory. For priv->ring, the stale value would be NULL.

The window is probably very small in practice. Still, the publish side
relies only on plain state bits, which is the pattern the commit message
calls insufficient.

Would it work to set INITED and clear RESETTING while holding dbg_mutex?
Another option is to pair test_bit_acquire() on the reader side with
release ordering on the writer side.

[ ... ]

> @@ -504,27 +526,22 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
>  	struct hns3_enet_ring *ring;
>  	u32 i;
>  
> -	if (!priv->ring) {
> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
> -		return -EFAULT;
> -	}
> -
> +	mutex_lock(&priv->ae_handle->dbg_mutex);
>  	seq_puts(s, "QUEUE_ID  BD_NUM  BD_LEN  TAIL  HEAD  FBDNUM  ");
>  	seq_puts(s, "PKTNUM     COPYBREAK  RING_EN  RX_RING_EN  BASE_ADDR\n");
>  
>  	for (i = 0; i < h->kinfo.num_tqps; i++) {
> -		/* Each cycle needs to determine whether the instance is reset,
> -		 * to prevent reference to invalid memory. And need to ensure
> -		 * that the following code is executed within 100ms.
> -		 */
> -		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
> -		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
> -			return -EPERM;
> +		/* Per-iteration check bounds reset latency to one iteration. */
> +		if (hns3_dbg_is_device_busy(priv)) {
> +			mutex_unlock(&priv->ae_handle->dbg_mutex);
> +			return -EBUSY;
> +		}

[Severity: Low]
This changes what userspace sees from several debugfs files. Only the
v2/v3 notes below the --- line mention it, and those notes are dropped
when the patch is applied.

When the per-iteration check fails, hns3_dbg_rx_queue_info(),
hns3_dbg_tx_queue_info() and hns3_dbg_page_pool_info() now return -EBUSY
instead of -EPERM.

The "priv->ring is NULL" dev_err() messages are gone from the rx/tx queue
and page_pool readers.

hns3_dbg_page_pool_info() also used to fail with -EFAULT and log "page
pool is not initialized" when the first rx ring had no page_pool. It now
succeeds and hns3_dump_page_pool_info() prints a "page pool not
initialized" line for each ring.

Could the commit message mention these changes?

[ ... ]

> @@ -796,13 +828,9 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
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
> +		mutex_unlock(&priv->ae_handle->dbg_mutex);
>  		return -EFAULT;
>  	}

[Severity: Low]
Should this return -EBUSY to match the sibling readers?

INITED is clear in every window where priv->ring is NULL. With their
pre-loop !priv->ring checks removed, hns3_dbg_rx_queue_info() and
hns3_dbg_tx_queue_info() now return -EBUSY in that state.

This reader keeps its pre-loop check and still returns -EFAULT for the
same state. One example is after hns3_reset_notify_uninit_enet() has
called hns3_put_ring_config() and before init has rebuilt the rings.

No user buffer is involved here, so EFAULT ("Bad address") looks like the
wrong errno.

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

[Severity: Low]
Does this writer follow the protocol described in the commit message? The
commit message says:

  Writers clear INITED first to signal readers, then acquire
  the mutex before freeing resources.

The reader loops also say "Per-iteration check bounds reset latency to one
iteration."

hns3_set_ringparam() only calls ndo_stop(), which sets
HNS3_NIC_STATE_DOWN. Before it takes dbg_mutex and rebuilds or frees the
rings, it never clears HNS3_NIC_STATE_INITED or sets
HNS3_NIC_STATE_RESETTING. As a result, hns3_dbg_is_device_busy() never
fires during a ring resize.

The mutex alone still keeps readers away from the rings, so there is no
use-after-free here. However, ethtool -G holds rtnl while it waits for a
whole show() pass, not one iteration. That pass can be a full tx_bd_info
or rx_bd_info dump of desc_num entries.

The dbg_mutex field comment in hnae3.h ("protect debugfs against
reset/unload") does not mention ring resize either.

Should the commit message and comments be updated, or should this path
also signal readers through the state bits?

> @@ -1270,6 +1271,7 @@ static int hns3_set_ringparam(struct net_device *ndev,
>  		for (i = 0; i < h->kinfo.num_tqps * 2; i++)
>  			hns3_fini_ring(&tmp_rings[i]);
>  	}

[Severity: High]
Can this path leak priv->rx_ring_oom_bm, or leave it NULL?

The bitmap comes from the earlier patch in this series, "net: hns3: fix
interface stuck after OOM with full hardware rx queue". That patch makes
hns3_init_all_ring() always allocate it at the start:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_init_all_ring() {
	...
	priv->rx_ring_oom_bm = bitmap_zalloc(h->kinfo.num_tqps, GFP_KERNEL);
	if (!priv->rx_ring_oom_bm)
		return -ENOMEM;
	...
out_when_alloc_ring_memory:
	for (j = i - 1; j >= 0; j--)
		hns3_fini_ring(&priv->ring[j]);

	bitmap_free(priv->rx_ring_oom_bm);
	priv->rx_ring_oom_bm = NULL;
	return -ENOMEM;
}

hns3_set_ringparam() calls hns3_init_all_ring() on a live priv, where
rx_ring_oom_bm already points to the bitmap in use.

On success, the old rings are released only through hns3_fini_ring(),
which does not touch rx_ring_oom_bm. Only hns3_uninit_all_ring() frees
the bitmap. Does every successful ethtool -G leak the previous bitmap?

On failure, the old pointer has already been overwritten, and the new
bitmap is freed and set to NULL. The old rings are then copied back, and
the interface is reopened (or brought up later) with
rx_ring_oom_bm == NULL. Every NAPI rx poll then runs:

hns3_clean_rx_ring()
    if (unlikely(failure || hns3_ring_is_oom_state(ring)))
        hns3_oom_task_schedule(ring);

hns3_ring_is_oom_state()
    return test_bit(ring->queue_index, priv->rx_ring_oom_bm);

Wouldn't the first packet received after a failed resize cause a NULL
pointer dereference in softirq context? hns3_ring_set_oom_state() and
hns3_oom_task() dereference the same pointer.

> +	mutex_unlock(&h->dbg_mutex);
>  
>  	kfree(tmp_rings);
>  

[Severity: Medium]
This is a pre-existing issue that was not introduced by this patch, but
it is in the same function.

When hns3_init_all_ring() fails above, ret holds the error and the old
ring configuration is restored. The code after this hunk then does:

	if (if_running)
		ret = ndev->netdev_ops->ndo_open(ndev);

	return ret;

If hns3_nic_net_open() brings the restored rings back up and returns 0,
the earlier error is overwritten. Does ethtool -G then report success even
though the requested ring parameters were not applied?

[ ... ]

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -5601,9 +5604,11 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
>  	hns3_uninit_all_ring(priv);
>  
>  	hns3_put_ring_config(priv);
> +	mutex_unlock(&handle->dbg_mutex);
>  
>  out_netdev_free:
>  	hns3_dbg_uninit(handle);
> +	mutex_destroy(&handle->dbg_mutex);
>  	free_netdev(netdev);
>  }
>  

[Severity: High]
Can priv->oom_task still be pending when this teardown runs?

The oom work and priv->rx_ring_oom_bm look like they come from the
earlier patch in this series, "net: hns3: fix interface stuck after
OOM with full hardware rx queue". This patch reworks both teardown
paths, though, so it seems worth raising here.

hns3_nic_init_vector_data() sets up the work with
INIT_DELAYED_WORK(&priv->oom_task, hns3_oom_task). The only
cancel_delayed_work_sync() is in hns3_nic_net_down(), and
hns3_nic_uninit_vector_data() has no matching cancel.

hns3_client_uninit() and hns3_reset_notify_uninit_enet() only reach
hns3_nic_net_down() when HNS3_NIC_STATE_DOWN is clear. If DOWN is
already set, nothing cancels the work before hns3_uninit_all_ring()
frees priv->rx_ring_oom_bm and sets it to NULL. Nothing cancels it
before hns3_client_uninit() calls free_netdev() either, which frees
priv.

The work can be armed while DOWN is set. One case is the ethtool
offline selftest on a down interface. hns3_lp_run_test() goes through
hns3_lb_check_rx_ring() into hns3_clean_rx_ring(), which calls
hns3_oom_task_schedule() when an rx buffer or skb allocation fails.
hns3_selftest_restore() then leaves the interface down with the work
queued.

Another case is hns3_external_lb_prepare(). It sets DOWN with
test_and_set_bit() without going through hns3_nic_net_down(). If
hns3_external_lb_restore() bails out because of a concurrent reset or
a hns3_nic_reset_all_ring() failure, DOWN stays set and the work is
still pending.

If a reset or driver unload lands inside the delay window, the work
then runs:

hns3_oom_task()
    if (test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
        bitmap_zero(priv->rx_ring_oom_bm, h->kinfo.num_tqps);
        return;
    }

After reset uninit, that is a NULL pointer dereference in
bitmap_zero(). After hns3_client_uninit(), the read of priv->state is
already a use-after-free of the freed netdev private area.

Should the work be cancelled unconditionally, either in
hns3_nic_uninit_vector_data() or in both uninit paths before
hns3_uninit_all_ring()? If so, does hns3_oom_task() take any lock
these paths already hold, such as rtnl or dbg_mutex? That would make a
synchronous cancel at that point deadlock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030095633.377289-1-shaojijie%40huawei.com
