Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A741332EBC
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782723; cv=none; b=MO2cuvI+U60FI5LFv0ja0heiEz4wezjcoBm5f5/tKqOJcnDsICT6ZmhzRnXLcH9Mj/yf/v5WYJgYy8iS6nBeQmE6DERdRHYyRY079RGoomztDSWIIvL0c+Q0e5rdfNt3MqL/8B7W9d1OClFvyuwiWtzqBV3sOPigXGcFsHdyMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782723; c=relaxed/simple;
	bh=ZgsJRp0GE+VY7MrNj7z6RnIreFBLdIFtkQ3Nquo0OK8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+wZo7LPM2H9I6ajio+/h1zVm/O/IJJbcwqB9q/BIWgGh9bzAcK5ibc6gYXQ6QqfeLu1onJpDOy6xYwNHZ9CAJ46i5UMxxdOVwYVyWutFBbHapUkEPwSikXMttOVuziIoU8N8SwO8DYWvL5wppxAxgxHzwX27xS20DcO/22unt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfgyOXn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfgyOXn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696581F00898;
	Sat, 19 Sep 2026 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789782721;
	bh=+qc3/DwPtR00rboqU03vrwKgB0VnGlUKORhMMH7S8Qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZfgyOXn0aItHpJmvxJ7D/KZ+parUN7hflAJMpG63tJkqedvOqt5s9OyqRgPFKnQcA
	 6AzbpGPRW7KcIXJz4x/D7apgHkhlX70iumj3nTpluSHfdWr7UScLa+s/TACKmCvDBX
	 F/GsoYdlOQYHJGiSWKIdA7Ds+TlAqVxtIc+cKJR05GVYQ2o0j0Dxzk/l1Zuc/2zs4Q
	 UKBghSXcZza08tOGCgEqyluu6Ya0wVmLn22q5YoJiG3U5518ZxTHXySo4kQCCgoLlC
	 jvhYj0Iyxh/riMdpVZDVTIZaBFu9zAtnN/YtaJ0dgoWF9Ov7wsduJYNFkuw9tdnz70
	 eYfoo4FlmsQIA==
Subject:
 Re: [PATCH net-next] net: libwx: Add ethtool -L support for VF drivers
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, u.kleine-koenig@baylibre.com
Date: Sat, 19 Sep 2026 01:51:59 +0000
Message-ID: <178978271990.22033.379266993167498237@kernel.org>
In-Reply-To: <20260915093714.18815-1-mengyuanlou@net-swift.com>
References: <20260915093714.18815-1-mengyuanlou@net-swift.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 2

- [High] wx_set_channels_vf()
  (drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:582-627) tears the…
- [Medium] The advertised channel maximum and the value the driver will
  actually program disagree, and wx_set_channels_vf() reports success…
- [Medium] The one-line change in wx_setup_vfmrqc_vf()
  (drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:240, '> 3' -> '>= 3')…
- [Low] wx_set_channels_vf() (wx_ethtool.c:605-618) changes
  wx->num_rx_queues/num_tx_queues by re-running…
- [Low] wx_get_channels_vf() (wx_ethtool.c:567-580) unconditionally
  reports ch->combined_count = wx->num_rx_queues and leaves…

--

net: libwx: Add ethtool -L support for VF drivers

This adds get_channels/set_channels to the libwx VF ethtool ops, stores the
requested combined count in wx->ring_feature[RING_F_RSS].limit and re-runs
the VF queue/interrupt setup, and adjusts the VXMRQC RSS hash mask
threshold in wx_setup_vfmrqc_vf().

A few questions on the error handling, the advertised limits, and the
changelog below.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c7..d243707909415 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -564,6 +564,68 @@ int wx_set_channels(struct net_device *dev,
>  }
>  EXPORT_SYMBOL(wx_set_channels);
>  
> +static void wx_get_channels_vf(struct net_device *dev,
> +			       struct ethtool_channels *ch)
> +{
> +	struct wx *wx = netdev_priv(dev);
> +
> +	/* report maximum channels */
> +	ch->max_combined = wx->mac.max_rx_queues;
> +
> +	ch->max_other = 1;
> +	ch->other_count = 1;
> +
> +	/* record current channels */
> +	ch->combined_count = wx->num_rx_queues;
> +}

[Severity: Low]

Reporting combined_count from num_rx_queues alone tells userspace that every
queue is a paired Rx+Tx channel.  Is that always true?

txgbevf_set_num_queues() has a branch that only sets the Rx count:

drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c:txgbevf_set_num_queues() {
	if (num_tcs > 1) {
		wx->num_rx_queues = num_tcs;
	} else {
		rss = min_t(u16, num_online_cpus(), TXGBEVF_MAX_RSS_NUM);
	...
}

num_tx_queues stays at the base value of 1 there, so ethtool -l would report
several combined channels for a VF owning one Tx ring.  The same branch never
looks at ring_feature[RING_F_RSS].limit, since the new clamp lives in the else
branch only, so a set_channels request in that configuration returns success
without changing anything.

With the in-tree PF this branch looks unreachable: wx_get_vf_queues() in
wx_sriov.c only ever answers with msgbuf[WX_VF_TRANS_VLAN] set to 0 or 1, so
this is more of a consistency question about code the VF still carries.

> +
> +static int wx_set_channels_vf(struct net_device *dev,
> +			      struct ethtool_channels *ch)
> +{
> +	struct wx *wx = netdev_priv(dev);
> +	u16 rss_limit;
> +	int ret;
> +
> +	rss_limit = wx->ring_feature[RING_F_RSS].limit;
> +
> +	/* verify other_count has not changed */
> +	if (ch->other_count != 1)
> +		return -EINVAL;
> +
> +	/* verify the number of channels does not exceed hardware limits */
> +	if (ch->combined_count > wx->mac.max_rx_queues)
> +		return -EINVAL;
> +
> +	/* if device is resetting, do nothing */
> +	if (test_bit(WX_STATE_RESETTING, wx->state))
> +		return -EBUSY;
> +
> +	wx->ring_feature[RING_F_RSS].limit = ch->combined_count;
> +
> +	if (netif_running(dev))
> +		wxvf_close(dev);
> +
> +	wx_clear_interrupt_scheme(wx);
> +
> +	ret = wx_init_interrupt_scheme(wx);
> +	if (ret)
> +		goto err_out;
> +
> +	if (netif_running(dev)) {
> +		ret = wxvf_open(dev);
> +		if (ret)
> +			goto err_close;
> +	}

[Severity: Low]

When the interface is administratively down both netif_running() tests are
false, so wxvf_open() is skipped, but wx_init_interrupt_scheme() has already
called wx->set_num_queues() and changed wx->num_rx_queues/num_tx_queues.

The VF driver only publishes the counts to the core from wxvf_open():

drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:wxvf_open() {
	/* Notify the stack of the actual queue counts. */
	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
	...
	err = netif_set_real_num_rx_queues(netdev, wx->num_rx_queues);
}

Does that leave dev->real_num_rx_queues/real_num_tx_queues, the queue sysfs
kobjects and the XPS maps describing the old configuration while ethtool -l
already reports the new one, until the next open?

> +
> +	return 0;
> +
> +err_close:
> +	wx_clear_interrupt_scheme(wx);
> +err_out:
> +	wx->ring_feature[RING_F_RSS].limit = rss_limit;
> +	return ret;
> +}

[Severity: High]

Both labels restore only the software RSS limit.  Can this leave the VF with
no rings and no interrupts while the netdev still looks running?

On the err_out path wx_init_interrupt_scheme() failed after
wx_clear_interrupt_scheme() already tore everything down:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_q_vectors() {
	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

	while (v_idx--)
		wx_free_q_vector(wx, v_idx);
}

so wx->q_vector[], wx->rx_ring[] and wx->tx_ring[] are NULL and
wx_reset_interrupt_capability() has freed wx->msix_entry.  Note also that
wx_init_interrupt_scheme() runs set_num_queues() before the fallible MSI-X
acquisition:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_init_interrupt_scheme() {
	if (wx->pdev->is_virtfn) {
		if (wx->set_num_queues)
			wx->set_num_queues(wx);
	}
	...
	ret = wx_set_interrupt_capability(wx);
	if (ret) {
		wx_err(wx, "Allocate irq vectors for failed.\n");
		return ret;
	}

so num_rx_queues/num_tx_queues come back non-zero while every ring pointer
stays NULL.

Since wxvf_close() is called directly rather than through dev_close(),
__LINK_STATE_START stays set and netif_running() keeps returning true.

Do the follow-up operations then dereference NULL?

ethtool -c ethX -> wx_get_coalesce():

drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:wx_get_coalesce() {
	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
		return 0;

ip link set dev ethX up -> wxvf_open() -> wx_request_msix_irqs_vf():

drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:wx_request_msix_irqs_vf() {
	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
			  0, netdev->name, wx);

ip link set dev ethX down (or the implicit close from unregister_netdev())
-> wxvf_close() -> wx_free_irq(), where MSI-X is already released and
misc_irq_domain is false for VFs:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_irq() {
	if (!(pdev->msix_enabled)) {
		if (!wx->misc_irq_domain)
			free_irq(pdev->irq, wx);
		return;
	}

followed by wx_free_resources() iterating the non-zero counts left by
err_out:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_all_tx_resources() {
	for (i = 0; i < wx->num_tx_queues; i++)
		wx_free_tx_resources(wx->tx_ring[i]);
}

Reaching the labels needs an allocation or request_irq() failure, but after
that the next ethtool or ip link command looks like a guaranteed oops.  Should
the error paths restore the previous limit and re-run
wx_init_interrupt_scheme() (and re-open when the interface was running), the
way the PF path does through wx->setup_tc()?

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> index 7325b475ee10c..6fec3ab5e4e42 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> @@ -237,7 +237,7 @@ void wx_setup_vfmrqc_vf(struct wx *wx)
>  
>  	vfmrqc |= WX_VXMRQC_RSS_EN;
>  
> -	if (wx->num_rx_queues > 3)
> +	if (wx->num_rx_queues >= 3)
>  		vfmrqc |= WX_VXMRQC_RSS_HASH(2);
>  	else if (wx->num_rx_queues > 1)
>  		vfmrqc |= WX_VXMRQC_RSS_HASH(1);

[Severity: Medium]

Is this one-liner a fix for existing behaviour rather than part of the new
feature?  The changelog only says:

    - Adjust VF MRQC RSS hash mask logic in wx_setup_vfmrqc_vf() to correctly
      match queue configuration thresholds.

with no symptom and no Fixes: tag.

WX_VXMRQC_RSS_HASH() programs bits 15:13 of VXMRQC, and the driver uses 1 for
two queues and 2 for four queues, so the field selects how many hash bits
index the redirection table.  Before this change num_rx_queues == 3 fell into
the "else if (wx->num_rx_queues > 1)" branch and programmed a single index
bit, while the RETA loop above it had filled the table with indices 0..2, so
the third Rx queue got no RSS traffic.

That case is already reachable without this patch, since a guest with three
online CPUs produces num_rx_queues == 3:

drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c:txgbevf_set_num_queues() {
		rss = min_t(u16, num_online_cpus(), TXGBEVF_MAX_RSS_NUM);
		queue = min_t(u16, wx->mac.max_rx_queues, wx->mac.max_tx_queues);
		rss = min_t(u16, queue, rss);

git blame points the "> 3" condition at eb4898fde1de8c ("net: libwx: add
wangxun vf common api").  Could this go in as a separate patch describing the
symptom and carrying Fixes: eb4898fde1de8c, so it can be picked up for stable
independently of the new ethtool support?

> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> index 8b16b900820aa..6e8659082051b 100644
> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> @@ -72,6 +72,9 @@ static void txgbevf_set_num_queues(struct wx *wx)
>  		queue = min_t(u16, wx->mac.max_rx_queues, wx->mac.max_tx_queues);
>  		rss = min_t(u16, queue, rss);
>  
> +		if (wx->ring_feature[RING_F_RSS].limit)
> +			rss = min_t(u16, rss, wx->ring_feature[RING_F_RSS].limit);
> +
>  		if (wx->vfinfo->vf_api >= wx_mbox_api_13) {
>  			wx->num_rx_queues = rss;
>  			wx->num_tx_queues = rss;

[Severity: Medium]

The user request is applied as an extra minimum after rss has already been
clamped to num_online_cpus(), so can it only ever lower the count and never
reach what wx_get_channels_vf() advertised?

wx_get_channels_vf() sets ch->max_combined = wx->mac.max_rx_queues (4), and
wx_set_channels_vf() rejects only "ch->combined_count > wx->mac.max_rx_queues".
Both ethtool entry points enforce exactly the maxima returned by get_channels,
so any value up to 4 reaches the driver even on a 2-vCPU guest where rss can
never exceed 2.

There is a second way the request is dropped:

drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c:txgbevf_set_num_queues() {
	wx->num_rx_queues = 1;
	wx->num_tx_queues = 1;
	...
	ret = wx_get_queues_vf(wx, &num_tcs, &def_q);
	...
	if (ret)
		return;

and wx_get_queues_vf() fails unconditionally for older mailbox API levels:

drivers/net/ethernet/wangxun/libwx/wx_vf.c:wx_get_queues_vf() {
	/* do nothing if API doesn't support wx_get_queues */
	if (wx->vfinfo->vf_api < wx_mbox_api_13)
		return -EINVAL;

In both cases wx_set_channels_vf() still returns 0 after bouncing the
interface through wxvf_close()/wxvf_open(), so "ethtool -L ethX combined 4"
succeeds, disrupts traffic, and a following "ethtool -l" reports 2 (or 1) --
and repeating the command flaps the link again each time.

Would it be better to advertise max_combined as the value the driver can
actually program, and to fail the request when the resulting count differs
from what was asked for?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915093714.18815-1-mengyuanlou%40net-swift.com
