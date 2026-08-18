Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512F332614
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072320; cv=none; b=WuWedTpnGUbtM6HfY865uXg1I+5ZPavv9ueSx8JCQyH6RlfcSSnVNqjvPdEMlWCfWcxwqg/ne67BeVp1tsbolvEeYSYNKIyjW78qNw9lgCvqHLBH65ns0avNjhAg5wr2FmShb4RpQxISkZDDRgehbSZusRyfRD2Lf69yt4mPUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072320; c=relaxed/simple;
	bh=9poXcoyVNh7vMy7weszDwlLKz6k3ii63f62ytVnkCuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyWJ58e/12fqRe4xMTI7VfceLVhp8QF0rfflN7k8bC5VfwGmGFWbHq3Q72sg20GxlTqxAQr4ndMJgQ8EFyGHKQSUKLmbGO+KW1Y1AHtF2iJtg3oBtYPx6BBPTlFDJNPTxu/p9vTv5btCq9nHqhYRQv2yORgzkWljFvJlE2Y/rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJ+gLi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJ+gLi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB711F000E9;
	Tue, 18 Aug 2026 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072318;
	bh=3eAMW9UrVz4rYbmaMdBbqfwt/3WBajj4m4s+Bopgv9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JsJ+gLi0rU658/W4ptjBndIkzlMLwx85TV/MRSXDCnNrTEDeHyP/hfrazCt6odd/Z
	 D5EcxRug45hU9iih5ib0JVEqWVaSVEz04CaEjQwSzE2J7Gdm/BDm7IO3JQKj109ayB
	 nT515Fp9BrYAB8SYVHywinsjdGZbI+bfz9CggHOGVTEThOR2NebQ4n1EVXPattAby7
	 x8tI7YLgvhbLsLAMEYyg1O9vxPuf16UCl3wo7CPBjxV3kgOYf7WJ2huZs6TnhJa9EC
	 DmY3H+IxUi2En9KHc7nhkT2VuL2h33fGgaWyuJIe14XIkZ630wfpJfycM63FN00oyR
	 pi2reuA5oLfeQ==
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
Subject: Re: [PATCH net 1/3] ionic: check for a NULL port_info in the remaining ethtool ops
Date: Tue, 18 Aug 2026 09:58:35 -0700
Message-ID: <20260818165835.4009139-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-1-f73b1a06c5f6@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-1-f73b1a06c5f6@amd.com>
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
ionic: check for a NULL port_info in the remaining ethtool ops

This adds !idev->port_info checks to the ethtool ops that dereferenced the
coherent port_info DMA buffer without testing it, since ionic_port_init()
frees the buffer and stores NULL on device command failure while the netdev
is still registered.  The ops return -EOPNOTSUPP (or return early, for
ionic_get_pauseparam()) when the pointer is NULL.

A few questions below.

> ionic_get_link_ext_stats() and ionic_get_link_ksettings() already test
> the pointer before using it, but the rest of the ethtool ops dereference
> it blindly, so an unprivileged "ethtool --show-fec eth0" can oops after
> a failed firmware recovery.
>
> Add the same check to the ops that were missing it.

[Severity: High]
This isn't a bug introduced by this patch, but does the "rest of the
ethtool ops" also include .get_ethtool_stats?  That path still reaches an
unguarded dereference:

ionic_get_stats()            (ionic_ethtool.c)
 -> ionic_sw_stats_get_values()  (ionic_stats.c)
      port_stats = &lif->ionic->idev.port_info->stats;
      for (i = 0; i < IONIC_NUM_PORT_STATS; i++) {
              **buf = IONIC_READ_STAT_LE64(port_stats,
                                           &ionic_port_stats_desc[i]);

The only gate is in ionic_get_stats():

	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
		return;

ionic_extra_port_stats_get_count() in the same file handles the same state
explicitly for the same ethtool -S request:

	if (!idev->port_info) {
		memset(pes_cache, 0xff, sizeof(*pes_cache));
		return count;
	}

so the two consumers of the same buffer disagree about whether the pointer
can be NULL.  Note also that ionic_remove() does
test_and_clear_bit(IONIC_LIF_F_FW_RESET, ...) before the netdev is
unregistered via ionic_lif_unregister(), so after a failed
ionic_reset_done() -> ionic_setup_one() -> ionic_port_init() the flag can be
clear, port_info NULL and the netdev still registered.  Should
ionic_sw_stats_get_values() get the same test the other ops just received?

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index c4ab4b5caa0ae..0830422fe7bae 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -347,6 +347,11 @@ static int ionic_set_link_ksettings(struct net_device *netdev,
>  	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
>  		return -EBUSY;
>  
> +	if (!idev->port_info) {
> +		netdev_err(netdev, "port_info not initialized\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* set autoneg */
>  	if (ks->base.autoneg != idev->port_info->config.an_enable) {
>  		mutex_lock(&ionic->dev_cmd_lock);

[Severity: High]
This isn't a bug introduced by this patch, since these ops previously
dereferenced port_info unconditionally, but can the added test still be
raced by the writer?  In ionic_port_init() the free and the NULL store
happen after the lock is dropped:

drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_init() {
	...
	mutex_unlock(&ionic->dev_cmd_lock);
	if (err) {
		dev_err(ionic->dev, "Failed to init port\n");
		dma_free_coherent(ionic->dev, idev->port_info_sz,
				  idev->port_info, idev->port_info_pa);
		idev->port_info = NULL;
	...
}

and its callers, ionic_lif_deferred_work() -> ionic_lif_handle_fw_up() and
ionic_reset_done() -> ionic_setup_one(), hold neither rtnl nor the netdev
instance lock that the ethtool ops run under.

In ionic_set_link_ksettings() the second dereference is separated from the
new test by a sleeping devcmd wait that releases the only lock the writer
takes:

	if (ks->base.autoneg != idev->port_info->config.an_enable) {
		mutex_lock(&ionic->dev_cmd_lock);
		ionic_dev_cmd_port_autoneg(idev, ks->base.autoneg);
		err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
		mutex_unlock(&ionic->dev_cmd_lock);
	...
	/* set speed */
	if (ks->base.speed != le32_to_cpu(idev->port_info->config.speed)) {

Can the deferred fw-up work free the buffer and store NULL while the caller
sleeps in ionic_dev_cmd_wait(), so that the speed comparison dereferences
NULL?  ionic_set_fecparam() has the same shape with its two dereferences of
config.fec_type and config.an_enable, and ionic_get_module_eeprom_by_page()
computes src into the buffer after the test and then copies from it in
ionic_do_module_copy(), which would hand freed coherent memory to user
space.

> @@ -378,6 +383,11 @@ static void ionic_get_pauseparam(struct net_device *netdev,
>  
>  	pause->autoneg = 0;
>  
> +	if (!lif->ionic->idev.port_info) {
> +		netdev_err_once(netdev, "port_info not initialized\n");
> +		return;
> +	}
> +
>  	pause_type = lif->ionic->idev.port_info->config.pause_type;
>  	if (pause_type) {
>  		pause->rx_pause = (pause_type & IONIC_PAUSE_F_RX) ? 1 : 0;

[ ... ]

> @@ -424,6 +439,11 @@ static int ionic_get_fecparam(struct net_device *netdev,
>  {
>  	struct ionic_lif *lif = netdev_priv(netdev);
>  
> +	if (!lif->ionic->idev.port_info) {
> +		netdev_err(netdev, "port_info not initialized\n");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: Low]
This isn't a bug, but is the difference in rate limiting between the two
getters intentional?  ionic_get_pauseparam() above uses netdev_err_once()
for this message, matching ionic_get_link_ext_stats(), while
ionic_get_fecparam() uses a plain netdev_err() for the identical message
and condition.  Both are unprivileged read-only ops, so a loop of
"ethtool --show-fec eth0" prints one KERN_ERR line per call while
port_info is NULL.

>  	switch (lif->ionic->idev.port_info->config.fec_type) {
>  	case IONIC_PORT_FEC_TYPE_NONE:
>  		fec->active_fec = ETHTOOL_FEC_OFF;
> @@ -451,6 +471,11 @@ static int ionic_set_fecparam(struct net_device *netdev,
>  	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
>  		return -EBUSY;
>  
> +	if (!lif->ionic->idev.port_info) {
> +		netdev_err(netdev, "port_info not initialized\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (lif->ionic->idev.port_info->config.an_enable) {
>  		netdev_err(netdev, "FEC request not allowed while autoneg is enabled\n");
>  		return -EINVAL;
> @@ -1004,6 +1029,11 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>  		return -EINVAL;
>  	}
>  
> +	if (!idev->port_info) {
> +		NL_SET_ERR_MSG_MOD(extack, "port_info not initialized");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	switch (page_data->page) {
>  	case 0:
>  		src = &idev->port_info->status.xcvr.sprom[page_data->offset];

One more question about the failure path the commit message describes,
which the patch does not touch.

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but is the
teardown in the ionic_port_init() error path complete?  The buffer address
is published to the device by ionic_dev_cmd_port_init():

	.port_init.info_pa = cpu_to_le64(idev->port_info_pa),

and on failure the buffer is released without an IONIC_CMD_PORT_RESET:

drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_init() {
	...
	ionic_dev_cmd_port_state(&ionic->idev, IONIC_PORT_ADMIN_STATE_UP);
	ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);

	mutex_unlock(&ionic->dev_cmd_lock);
	if (err) {
		dev_err(ionic->dev, "Failed to init port\n");
		dma_free_coherent(ionic->dev, idev->port_info_sz,
				  idev->port_info, idev->port_info_pa);
	...
}

ionic_port_reset() does the opposite ordering whenever the firmware is
still alive:

	if (ionic_is_fw_running(idev)) {
		mutex_lock(&ionic->dev_cmd_lock);
		ionic_dev_cmd_port_reset(idev);
		err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
		mutex_unlock(&ionic->dev_cmd_lock);
	}

	dma_free_coherent(ionic->dev, idev->port_info_sz,
			  idev->port_info, idev->port_info_pa);

On the -ETIMEDOUT path __ionic_dev_cmd_wait() only calls
ionic_dev_cmd_clean() with no abort handshake, so can a slow-but-alive
firmware still write struct ionic_port_info into pages already returned to
the coherent allocator?  This depends on firmware behaviour, so it may well
be a non-issue.  Separately, the return value of the second devcmd
(PORT_STATE = IONIC_PORT_ADMIN_STATE_UP) is discarded just before the
free; is that deliberate?
-- 
pw-bot: cr
