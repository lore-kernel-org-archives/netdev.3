Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DA171CD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067437; cv=none; b=dSv+nsVSiE3K1JwfbD9D5fwTYh/zM/rAaDCaimW71RBqI9UQQNxIswNOfMs4/ZOCvDL1cY/bAvLIT2vzZfRIL2lyss7iSChO41C38rFEVnWKxdOgNCobRPTLjX7HeDhICyb8MvzJy+z/TicdnfS0sdRbtbtjvWaNArNQ4of79YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067437; c=relaxed/simple;
	bh=cOLC6kKXzCGhQRg7IzaGNryAqxZq7ygluHZzkiqiPnc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=uDHfiS8mo8kNuxLWnAq56LOmoA6aZ5ixNi/lIOcgCzuxIPY6xZZZuv1I7LG0IwdaIbit0BOQQLMwLC0oJJ2W2Lei8MH4P67FMTsmRyC13c5gnZ3GgWfw3norcPBtOsKhavYXDEZ3Z0f64WXDLT+jcQa8yXiJQJNOoxyy69+Qbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TGEdS34i; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TGEdS34i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779067432; h=Message-ID:Subject:Date:From:To;
	bh=dtbsJkRYzWUCf9kXMKElLH3Ifd9kkSzbKDinBsJhaug=;
	b=TGEdS34irCTDpU91X6OiBq6kwXOll3pXxTE09v10oqul+5ouByBtEmgg+T6Vy12CIZzZlkuV5YGwJw/6+mz9DgSjnVzC7JA9HODL0FXCc3sfVhvTabJo5GYOnHwKIVyn//RrGh9ILE17P6qE3cFKjIOU5vooBUI5l+q3nsFxEZU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32he1N_1779067430;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32he1N_1779067430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 09:23:51 +0800
Message-ID: <1779067114.669575-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 4/8] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Mon, 18 May 2026 09:18:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index bb8a49f8c6df..cfb18a07e296 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
[ ... ]
> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_init_ctx ctx_old = {0};
> +	int err, error;
> +
> +	if (!netif_running(enet->netdev) || !enet->started) {
> +		enet->cfg = ctx->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(ctx);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_stop_rxtx(enet->netdev);
> +	eea_hw_unactive_ring(enet);
> +
> +	eea_unbind_q_and_cfg(enet, &ctx_old);
> +	eea_bind_q_and_cfg(enet, ctx);
> +
> +	err = eea_update_queues(enet);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: set real num queues failed. err %d\n",
> +			   err);
> +		goto err_bind_old;
> +	}
> +
> +	err = eea_hw_active_ring(enet);
> +	if (err) {
> +		netdev_err(enet->netdev, "eea reset: active new ring. err %d\n",
> +			   err);
> +		eea_unbind_q_and_cfg(enet, ctx);
> +		goto err_free_q;
> +	}
On the eea_hw_active_ring() failure branch above, can the netdev be
left with mismatched cached state?
The sequence executed by then is:
    eea_unbind_q_and_cfg(enet, &ctx_old);   /* saves OLD cfg into ctx_old */
    eea_bind_q_and_cfg(enet, ctx);          /* enet->cfg = ctx->cfg (NEW) */
    err = eea_update_queues(enet);          /* sets real_num_{rx,tx}_queues
                                               to NEW values, succeeded */
    err = eea_hw_active_ring(enet);         /* failed */
    eea_unbind_q_and_cfg(enet, ctx);
    goto err_free_q;
err_free_q then sets enet->started = false but never restores
enet->cfg or netdev->real_num_{rx,tx}_queues to the old values, and
eea_unbind_q_and_cfg() only nulls enet->rx / enet->tx without
reverting cfg.
Looking at eea_unbind_q_and_cfg():
    ctx->cfg = enet->cfg;
    ctx->rx = enet->rx;
    ctx->tx = enet->tx;
    enet->rx = NULL;
    enet->tx = NULL;
If the user later calls ndo_open, eea_netdev_open() reads enet->cfg
which still holds the NEW values that the device just rejected. Was
a rollback to ctx_old intended on this path as well, similar to the
err_bind_old branch?
[ ... ]
> +static void eea_net_ha_reset_remove(struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
[ ... ]
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> index fa0eec8af21b..9639f0c5c618 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
[ ... ]
> +/* rx apis */
> +void enet_rx_stop(struct eea_net_rx *rx);
> +void enet_rx_start(struct eea_net_rx *rx);
Every other symbol in this driver uses the eea_ prefix, but
enet_rx_start / enet_rx_stop use enet_. Was the inconsistency
intentional, or should these be renamed to eea_rx_start /
eea_rx_stop for consistency with the rest of the eea_ namespace?
> +
> +void eea_free_rx(struct eea_net_rx *rx, struct eea_net_cfg *cfg);
> +struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx);
[ ... ]
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> index bef0ebd6bb20..9872e360dd5d 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
[ ... ]
> +static void eea_ha_handle_reset(struct eea_pci_device *ep_dev)
> +{
[ ... ]
> +	if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> +
> +		pci_dev = ep_dev->pci_dev;
> +
> +		/* The pci remove callback may hold this lock. If the
> +		 * pci remove callback is called, then we can ignore the
> +		 * ha interrupt.
> +		 */
> +		if (mutex_trylock(&edev->ha_lock)) {
Is the mutex_trylock() with a silent-skip fallback below the right
pattern here?
> +			if (edev->status != EEA_PCI_STATUS_DONE) {
> +				dev_err(&ep_dev->pci_dev->dev, "ha: reset device: pci status is %d. skip it.\n",
> +					edev->status);
> +
> +				mutex_unlock(&edev->ha_lock);
> +				return;
> +			}
> +
> +			__eea_pci_remove(pci_dev, false);
> +			err = __eea_pci_probe(pci_dev, ep_dev, false);
> +			if (err)
[ ... ]
> +			mutex_unlock(&edev->ha_lock);
> +		} else {
> +			/* Device removal is in progress, so return directly. */
> +			dev_warn(&ep_dev->pci_dev->dev,
> +				 "ha device reset: trylock failed.\n");
> +		}
> +		return;
> +	}
When the trylock fails, the work simply logs a warning and returns
without rescheduling. The networking subsystem guidance lists this
specific pattern (trylock with fallback to skip the work entirely) as
a likely bug, with the narrow exception of work items that retry via
schedule_work() on failure.
The trylock also fails for any holder of ha_lock, not only pci
remove, so a HA reset request that arrives during any concurrent
holder is dropped silently and the device is left without recovery.
Would it be more appropriate to either reschedule the work via
schedule_work() on trylock failure, or to redesign the locking so
that the remove path coordinates with the worker via cancel/flush
rather than a shared mutex that the worker must avoid?
[ ... ]
> +static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pci_dev,
> +			   bool pci_probe)
> +{
[ ... ]
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> +static int eea_net_reprobe(struct eea_device *edev)
> +{
> +	struct eea_net *enet = edev->enet;
> +	int err = 0;
> +
> +	enet->edev = edev;
> +
> +	if (!enet->adminq.ring) {
> +		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = eea_alloc_irq_blks(enet);
> +	if (err)
> +		goto err_destroy_aq;
> +
> +	rtnl_lock();
> +
> +	enet->link_err = 0;
> +	if (edev->ha_reset_netdev_running &&
> +	    netif_running(edev->enet->netdev)) {
> +		err = eea_netdev_open(enet->netdev);
On the HA reprobe path, can edev->rx_num change relative to the
value used at original probe?
eea_pci_setup() re-reads rx_num/tx_num from device registers each
time, and eea_alloc_irq_blks() sizes enet->irq_blks based on the
new edev->rx_num:
    num = enet->edev->rx_num;
    irq_blks = kvcalloc(num, sizeof(*blk), GFP_KERNEL);
However, the netdev itself was allocated once with
alloc_etherdev_mq(..., pairs) using the original count, and
enet->cfg.rx_ring_num is preserved from the previous probe.
If the device reports a smaller rx_num after the HA reset,
eea_bind_q_and_cfg() will iterate enet->cfg.rx_ring_num entries
(OLD) over enet->irq_blks[] (NEW, smaller):
    for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
        blk = &enet->irq_blks[i];
        ...
    }
Should eea_net_reprobe() validate that edev->rx_num and
edev->tx_num match the values used at the original alloc_etherdev_mq()
and refuse to reprobe (or reinitialise cfg) if they have changed?
[ ... ]
