Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35719468C1D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061493; cv=none; b=pGDGityD5vCUUrf1PsjQCrIMGt6OePaeVEij97w/W8SbsXPiFl668Gb63rvscz4scQuL220zeQAUHg3jK4sgWJTfcbOAzln115YRJOc+e3kjPFbDXDI99yq69nzjL/esmnYQ6KXUUvzsJbZrYLbm0Fis3t56FyOP6wF5+EpUWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061493; c=relaxed/simple;
	bh=evyJk1End9SX7ibV+5YefPMP2/WiagTqINlx2DjncMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ+ksXq6d4rU16X3brAjxR32wzzisZYdB17K8iOkdAKzpl4N1HHJQGA7MCAJjPockloI0mHFg4vetX5E1iiLVsmgFN4KfskEJurR1l5ylY0576qL4f1OxU+660H3Yqgjc3qNdE3bgl6GUJMfmrzgjui/gQXSyYyjBGVoiaShepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvOn9zit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvOn9zit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436931F00A3A;
	Tue, 18 Aug 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787061491;
	bh=PEtaMo/MYWYR+IS2NHTvcmnyuL2tOMoZKqYi/BxaHhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HvOn9zitruTVBBDjDFlCWnkSyoWzMTo2bIHjYmC6KOlsQv1bdHMoI7mamdLVUSLQ3
	 hOKbvQ5lpHadZwep5SO6UBZymMxfc33jseNwxJhccleWSSU0iEl/MAb3UHuEiIPniQ
	 PEAx9CMsKF1oDSBcEUFzZ07pBb9AAO+jKsCVWj/GIM6+VuGL8/gCa0wWnEoAm6gUqY
	 McnCdGDje0lSMMSX4WZitMlHh8dgq6uOEOxLOcE0UlTANE/F4gvf/yx1Gu+ao/YCKj
	 gYn4MDiH81kdo5WQVZ/MmfF4HpM3ae8Iy8GSkJLRd5QSqCNdH90n3MrdedZ3Ddxivd
	 hL9SVYYzS4szQ==
From: Simon Horman <horms@kernel.org>
To: maciek@machnikowski.net
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support
Date: Tue, 18 Aug 2026 14:58:00 +0100
Message-ID: <20260818135800.629288-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815063148.2952-3-maciek@machnikowski.net>
References: <20260815063148.2952-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815063148.2952-1-maciek@machnikowski.net?part=2
---
--- Patch [2]: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support ---
commit ef2b7171af287d8c3a8f5064008830a7dd8f4db3
Author: Maciek Machnikowski <maciek@machnikowski.net>

netdevsim: Implement basic ptp support

Adds virtual hardware timestamping to netdevsim by reading the mock PHC
attached to the transmitting netdevsim and to its peer, reporting a TX
timestamp to the socket and stamping the forwarded skb for the RX side.
Also wires up ndo_hwtstamp_get / ndo_hwtstamp_set and extends
nsim_get_ts_info().

A few questions on the timestamping path below.

> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 025ea79879f3a..24e7d5592e799 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -200,7 +200,22 @@ static int nsim_get_ts_info(struct net_device *dev,
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
>  
> +	ethtool_op_get_ts_info(dev, info);
> +	if (!ns->phc) {
> +		info->phc_index = -1;
> +		return 0;
> +	}
> +

[Severity: High]
[Finding: main-1-1]
[Sources: opus-5]
This isn't a bug introduced by this patch, but the new !ns->phc guard looks
like it silently fixes a NULL pointer dereference that exists today, without
a mention in the changelog or a Fixes: tag.

Before this patch nsim_get_ts_info() did:

	info->phc_index = mock_phc_index(ns->phc);

and nsim_ethtool_init() installs the shared nsim_ethtool_ops (including
.get_ts_info = nsim_get_ts_info) on every netdevsim netdev, while only
nsim_init_netdevsim() calls mock_phc_create().  nsim_init_netdevsim_vf()
just assigns nsim_vf_netdev_ops and registers the netdev, so ns->phc stays
NULL for VF netdevs.

With CONFIG_PTP_1588_CLOCK_MOCK=y, mock_phc_index() is the real function:

drivers/ptp/ptp_mock.c:mock_phc_index() {
	return ptp_clock_index(phc->clock);
}

so ethtool -T on a netdevsim VF netdev dereferences NULL.  Would it make
sense to split this guard into its own patch with a Fixes: tag so that
stable tooling can pick it up?

Also, adding ethtool_op_get_ts_info() here changes ethtool -T output for all
netdevsim devices by advertising SOF_TIMESTAMPING_TX_SOFTWARE,
SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE.  Could the
changelog mention that behaviour change?

>  	info->phc_index = mock_phc_index(ns->phc);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 4e9d7e10b527e..e586fd8f3bc37 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -164,6 +171,44 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_linearize(skb);
>  
>  	skb_tx_timestamp(skb);
> +
> +	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
> +		     HWTSTAMP_FILTER_NONE))
> +		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> +
> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> +	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON)
> +		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
> +
> +	if (unlikely(ptp_info_tx || ptp_info_rx)) {
> +		/* Capture both timestamps closely */
> +		if (ptp_info_tx)
> +			ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
> +		if (ptp_info_rx)
> +			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
> +
> +		/* If TX hardware timestamping is enabled report TX timestamp */
> +		if (ptp_info_tx) {
> +			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> +			skb_tstamp_tx(skb_orig, &shhwtstamps);
> +		}

[Severity: Medium]
[Finding: gpt-5-6-sol-3-10]
[Sources: gpt-5-6-sol, opus-5]
Can a socket receive two SCM_TSTAMP_SND reports for the same packet here?

The hardware report is emitted after skb_tx_timestamp(), which already
delivered the software one:

include/linux/skbuff.h:skb_tx_timestamp() {
	skb_clone_tx_timestamp(skb);
	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
		skb_tstamp_tx(skb, NULL);
}

The only suppression of the software report lives in __skb_tstamp_tx():

net/core/skbuff.c:__skb_tstamp_tx() {
	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
		return;

netdevsim never sets SKBTX_IN_PROGRESS anywhere - the new code only tests
SKBTX_HW_TSTAMP - so for a socket that enabled both
SOF_TIMESTAMPING_TX_SOFTWARE and SOF_TIMESTAMPING_TX_HARDWARE without
SOF_TIMESTAMPING_OPT_TX_SWHW both reports are delivered.

Would following the usual driver sequence work here, i.e. test
SKBTX_HW_TSTAMP and set SKBTX_IN_PROGRESS before calling
skb_tx_timestamp()?

> +
> +		/* Unshare the skb, stamping it must not corrupt cloned copies
> +		 * and prevents returning single tstamp for Tx and Rx
> +		 */
> +		skb = skb_unshare(skb_orig, GFP_ATOMIC);
> +		if (unlikely(!skb)) {
> +			if (psp_ext)
> +				__skb_ext_put(psp_ext);
> +			goto out_drop_cnt;
> +		}

[Severity: Low]
[Finding: main-3-8]
[Sources: opus-5]
Should this skb_unshare() be gated on ptp_info_rx?

The enclosing condition is ptp_info_tx || ptp_info_rx, but the only write
into the skb below is guarded by if (ptp_info_rx).  On the TX-only path
(peer rx_filter == HWTSTAMP_FILTER_NONE) every timestamped frame gets copied
by skb_copy() for nothing, which also linearizes the buffer that the
hds_config logic just above deliberately left non-linear, and does not carry
queue_mapping.

If the GFP_ATOMIC copy then fails, the frame is dropped via out_drop_cnt
even though nothing needed to be written into it, and after the TX
timestamp was already handed to the socket by skb_tstamp_tx(skb_orig, ...).

[Severity: Low]
[Finding: main-5-12]
[Sources: opus-5]
Does skb_unshare() cover the case this comment describes?

include/linux/skbuff.h:skb_unshare() {
	might_sleep_if(gfpflags_allow_blocking(pri));
	if (skb_cloned(skb)) {
	...
}

The copy is made only for clones, so an skb with skb->users > 1 and
cloned == 0 is returned unchanged.  pktgen does
refcount_add(burst, &pkt_dev->skb->users) and resubmits the same skb, so the
skb_hwtstamps(skb) write below touches skb_shared_info that the other
reference holder still owns, and that the peer's NAPI path may read
concurrently after nsim_forward_skb() -> nsim_napi_rx() queues it on
rq->skb_queue.  Should the driver check skb_shared() as well, or stamp a
private copy?

> +
> +		/* If RX hardware timestamping is enabled report RX timestamp */
> +		if (ptp_info_rx)
> +			skb_hwtstamps(skb)->hwtstamp =
> +				timespec64_to_ktime(rx_ts);
> +	}
> +

[Severity: Critical]
[Finding: main-6-13]
[Sources: opus-5]
Can this write corrupt kernel memory for AF_XDP TX skbs?

skb_hwtstamps() returns a pointer into a union in skb_shared_info:

include/linux/skbuff.h:struct skb_shared_info {
	union {
		struct skb_shared_hwtstamps hwtstamps;
		struct xsk_tx_metadata_compl xsk_meta;
	};

struct xsk_tx_metadata_compl has a single member, u64 *tx_timestamp, and the
AF_XDP destructor dereferences it with only a NULL check:

net/xdp/xsk.c:xsk_destruct_skb() {
	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;

	if (compl->tx_timestamp) {
		/* sw completion timestamp, not a real one */
		*compl->tx_timestamp = ktime_get_tai_fast_ns();
	}

Every generic-xmit AF_XDP skb carries that destructor
(xsk_skb_init_misc() sets skb->destructor = xsk_destruct_skb), and it is
freshly allocated and not cloned, so skb_unshare() above returns the same
skb with the destructor and the overwritten shinfo intact.
__dev_forward_skb() -> skb_scrub_packet() does not orphan the skb or reset
skb_shinfo(), so the value survives to the destructor.

The RX branch is gated only on the peer's setting:

	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
		     HWTSTAMP_FILTER_NONE))
		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);

so any AF_XDP frame forwarded while the peer has RX timestamping enabled
gets a non-NULL, PHC-derived value in xsk_meta.tx_timestamp, and the
destructor performs an 8-byte write to that address.  The mock PHC value is
settable from userspace through clock_settime() on /dev/ptpN via
mock_phc_settime64().

Real NICs avoid this because they only stamp skbs they allocated for RX.
Since netdevsim reuses the TX skb as the RX skb, should it orphan the skb
(clearing skb->destructor) or stamp a private copy before touching
skb_shinfo()->hwtstamps?

>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;
> @@ -185,6 +230,63 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +	int rx_filter;
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +

[ ... ]

> +static int nsim_get_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +
> +	*config = ns->tstamp_config;
> +	return 0;
> +}

[Severity: Low]
[Finding: gpt-5-6-sol-2-6]
[Sources: gpt-5-6-sol, opus-5]
Should nsim_get_ts_config() carry the same !ns->phc check as
nsim_set_ts_config()?

drivers/net/Kconfig allows netdevsim without the mock clock:

	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n

and with CONFIG_PTP_1588_CLOCK_MOCK=n the stub is used:

include/linux/ptp_mock.h {
static inline struct mock_phc *mock_phc_create(struct device *dev)
{
	return NULL;
}

nsim_init_netdevsim() only rejects IS_ERR(), so ns->phc stays NULL.  In that
configuration SIOCGHWTSTAMP succeeds and reports tx_type =
HWTSTAMP_TX_OFF / rx_filter = HWTSTAMP_FILTER_NONE, i.e. "hardware
timestamping present but disabled", while nsim_get_ts_info() reports
phc_index = -1 with no hardware so_timestamping and every set attempt is
rejected with -EOPNOTSUPP.  Other converted drivers keep the get/set pair
symmetric here.

[ ... ]
