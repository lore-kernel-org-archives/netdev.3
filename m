Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59930306779
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072321; cv=none; b=VrnjVx2ngfLo5EfNihwePxqIYHnYi9WVlBgXuw/ztByvDbwg07sIboFJ10GmtAfZaCCFz2HkZLXULQ6xvX5MWpf0551FaijUA/lqODUbErvFIG+cyR8X4BfEKWra0m7nYolDsQ/xMsMscrP5VVFrMR3xUpHAeExJVY2Lc8lBhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072321; c=relaxed/simple;
	bh=kxyILMalUuQLxFOXHfBifi4QpKBvSwNYyL2thETICsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdaWb1MiBbPK1hBq/lh/u3rYVAlpbOHPpUSzSIhGYJPHQEnGehyGA6N1UCD4YQBAu9hcbItlFnJ0Ru+6ureTGOf3u7cOPtEx5BJzrFORmJs2euUZxL5pB86SJcmR+UEtyAkNDHFhTYT4f/Zg+Xcbrj50TACf67L6ahMHpe83M8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBYtgcMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBYtgcMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D091F00A3A;
	Tue, 18 Aug 2026 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072320;
	bh=MeWCvoydjS9w6a5q0tI0tBQaYIo0S8X38ElouZ+By/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBYtgcMOfBsbFPeAuutKwAI5QDlsVqdNa2B1PASIPEwazHV+DAmv8erwH/HRYG/2Q
	 Qfa+HsD+26W4qEu9CLZO1k4WX5F9QljLzJAADJ+UmUDahqeWvkQDmU2cnUNzJOsOPu
	 Werin+q5f20LGeWHvit8eJ7lbuQ4GEkNx8og0KpOu0FOK1vuq+cPXidjqxBQF0p8PL
	 uZXtuYl16npFUxq7/5DCFQzFNt0sb1/yW69yjYB8qpqS6nveXmiRa9/TyDwpNeFfoT
	 sGCfyf8DXPNj/x0h48t+37Rpc9WSZGr5Qh4MlfyaJZUXVI8tuthAoGdCKMfpauYDdS
	 H2uARR+Fk9y1A==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	nikhil.rao@amd.com
Subject: Re: [PATCH net 2/3] ionic: detach the netdev in the PCI reset handler
Date: Tue, 18 Aug 2026 09:58:38 -0700
Message-ID: <20260818165839.4009172-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-2-f73b1a06c5f6@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-2-f73b1a06c5f6@amd.com>
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
ionic: detach the netdev in the PCI reset handler

Adds a netif_device_detach() call to ionic_reset_prepare() right after
IONIC_LIF_F_FW_RESET is set, so the netdev is marked not-present before the
PCI reset path tears down the queues, the BARs and the device state. The
change mirrors what ionic_lif_handle_fw_down() does on the firmware recovery
path, and relies on ionic_restart_lif() to re-attach afterwards.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c8..c15c4c705155e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -447,6 +447,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
>  	dev_dbg(ionic->dev, "%s: device stopping\n", __func__);
>  
>  	set_bit(IONIC_LIF_F_FW_RESET, lif->state);
> +	netif_device_detach(lif->netdev);

[Severity: Medium]
Is the premise in the changelog accurate?  The message says
ionic_reset_prepare() "leaves the netdev attached and registered for the
whole reset window", but ionic_reset_prepare() already reaches
ionic_stop_queues_reconfig(), whose first statement is a detach:

drivers/net/ethernet/pensando/ionic/ionic_lif.c:
void ionic_stop_queues_reconfig(struct ionic_lif *lif)
{
	/* Stop and clean the queues before reconfiguration */
	netif_device_detach(lif->netdev);
	ionic_stop_queues(lif);
	ionic_txrx_deinit(lif);
}

That call runs before every destructive step in ionic_reset_prepare()
(ionic_txrx_free(), ionic_lif_deinit(), ionic_qcqs_free(),
ionic_debugfs_del_lif(), ionic_dev_teardown(), ionic_clear_pci()), and well
before ionic_reset_done() -> ionic_setup_one() -> ionic_port_init() runs.

netif_device_detach() clears __LINK_STATE_PRESENT unconditionally:

net/core/dev.c:
	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
	    netif_running(dev)) {
		netif_tx_stop_all_queues(dev);
	}

so the presence gate was already closed before the teardown even for an
interface that is not up.

The only window the new call additionally covers is:

	set_bit(IONIC_LIF_F_FW_RESET, lif->state);
	netif_device_detach(lif->netdev);
	timer_delete_sync(&ionic->watchdog_timer);
	cancel_work_sync(&lif->deferred.work);
	ionic_auxbus_unregister(ionic->lif);
	mutex_lock(&lif->queue_lock);

None of those steps free idev->port_info or unmap the BARs, so the
ionic_port_init() free named in the message does not appear to be the
exposure that moves here.  Would it be more accurate to describe this as
making ionic_reset_prepare() consistent with
ionic_lif_handle_fw_down() (detach up front, before the auxbus unregister
and the queue_lock section), and to reconsider the
Fixes: a79b559e99be tag so stable does not pick this up as the fix for the
described use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but since the changelog presents
the patch as closing the port_info use-after-free, is the added detach
sufficient to close it?

The ethtool core checks presence once, before dispatching to the driver:

net/ethtool/ioctl.c:dev_ethtool_locked() {
	if (!netif_device_present(dev)) {
		rc = -ENODEV;
		goto out;
	}
	...
}

ethnl_ops_begin() does the same on the netlink path.  netif_device_detach()
is only a test_and_clear_bit() plus netif_tx_stop_all_queues(), with no wait
or drain, so a caller already past that check keeps running.

ionic_reset_prepare() is called from the PCI core holding only device_lock;
it takes neither rtnl_lock() nor the netdev instance/ops lock that the
ethtool callbacks run under.  Can the following interleaving still happen?

	ethtool GLINKSETTINGS			PCI reset
	dev_ethtool_locked()
	  netif_device_present() -> true
	  ionic_get_link_ksettings()
	    reads idev->port_info		ionic_reset_prepare()
						  netif_device_detach()
						  ionic_clear_pci()
						  ionic_dev_teardown()
						ionic_reset_done()
						  ionic_setup_one()
						    ionic_port_init()
	    (still dereferencing)		      dma_free_coherent(...
						        idev->port_info)

ionic_clear_pci() also drops the register pointers an in-flight op may be
using:

drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c:ionic_clear_pci() {
	if (ionic->num_bars) {
		ionic->idev.dev_info_regs = NULL;
		ionic->idev.dev_cmd_regs = NULL;
		ionic->idev.intr_status = NULL;
		ionic->idev.intr_ctrl = NULL;

		ionic_unmap_bars(ionic);
		pci_release_regions(ionic->pdev);
	}
	...
}

and ionic_dev_teardown() frees idev->cmb_inuse, destroys ionic->wq and
mutex_destroy()s idev->cmb_inuse_lock while the netdev is still registered.

The NULL test on idev->port_info in ionic_get_link_ksettings(),
ionic_get_pauseparam() and ionic_get_fecparam(), and the
IONIC_LIF_F_FW_RESET test in the set-ops, are check-then-use against a
teardown path that holds no lock in common with them, so the new detach adds
a second advisory gate with the same property.

Would serializing the detach and the whole teardown/re-setup under the lock
the ethtool and ndo callbacks already hold (rtnl_lock() /
netdev_lock_ops()), or protecting idev->port_info with a lock taken on both
sides, be needed to actually close this?

>  
>  	timer_delete_sync(&ionic->watchdog_timer);
>  	cancel_work_sync(&lif->deferred.work);
