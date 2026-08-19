Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF443C7DF
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134632; cv=none; b=VVvWz7shqMonXvRdVh/WHR/rnJ6QW8VkF8o+2Uq5Q4zedd78SXRrE1bETlm5nPo49Tcx4QqUyv3kNH3ec6i/MgAQpSphZDswosue8ZxKCtpHHOg4B6IkFAIHqa8C7MF2q8bLmw3faiYDMTjRZEuduYuNk9LBg+Y7lDBHfU2/MVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134632; c=relaxed/simple;
	bh=3effZKiDSJIye1lEvXY1P332jobTmMrteuB679fN1Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiXzJT2vEAfI4MeIvFWLAQh2ZynlcuBnTRF31Oie35dwz9SEDPJ52i9EHM90CQI8WTqnc5WyLbwWm5EABfltQa79+fb/8SJtRAjQFs10MxxsMhhilRHg/K0M0hZfU+wA3gCA1Txdvfco8TQdMV78YN39e9OV5C5pYY1jWggDB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+f4sgh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+f4sgh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCD1F000E9;
	Wed, 19 Aug 2026 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787134630;
	bh=2itk0bMMncgupsT/Ykv5J/VkOZtqbzkCYOdhHyOIlYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+f4sgh/XqJvdz1a+kM4GyOYTtD8gUEvKqxdHRLNIVtDoK9FUD/i2D+XTsUM2ITSk
	 5WYmsC30eyS7KjbaC30fpV7tNQtB8hx8BuD1yu/xdDJ9f+9BJPpLGHVHeGENC3FVDF
	 gBEumhYtjD59UjYDpqc2FBGZ22Z/71inqGGEaakzKK85XYO9sQj3MYE/vizB62BwLU
	 drvUQMeB7udF6tvnROpbfbrw+AwHk94kef/wSv6UYxUYONDLE6xPXHoG5XijdLahbE
	 AMM26mMS+Uft22cR/8GB8EbSl2DU0f6bjDTVyHBqw77ePFki8vJ6YlKwgCCJpnNpmV
	 rwDctCrWJ/0SQ==
Date: Wed, 19 Aug 2026 11:17:06 +0100
From: Simon Horman <horms@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20260819101706.GP265046@horms.kernel.org>
References: <20260815063148.2952-3-maciek@machnikowski.net>
 <20260818135800.629288-1-horms@kernel.org>
 <9b17f19d-9d6f-4301-b6a5-871cec042211@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b17f19d-9d6f-4301-b6a5-871cec042211@machnikowski.net>

On Wed, Aug 19, 2026 at 12:03:33AM +0200, Maciek Machnikowski wrote:
> 
> 
> On 18/08/2026 15:58, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815063148.2952-1-maciek@machnikowski.net?part=2
> > ---
> > --- Patch [2]: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support ---
> > commit ef2b7171af287d8c3a8f5064008830a7dd8f4db3
> > Author: Maciek Machnikowski <maciek@machnikowski.net>
> > 
> > netdevsim: Implement basic ptp support
> > 
> > Adds virtual hardware timestamping to netdevsim by reading the mock PHC
> > attached to the transmitting netdevsim and to its peer, reporting a TX
> > timestamp to the socket and stamping the forwarded skb for the RX side.
> > Also wires up ndo_hwtstamp_get / ndo_hwtstamp_set and extends
> > nsim_get_ts_info().
> > 
> > A few questions on the timestamping path below.
> > 
> >> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> >> index 025ea79879f3a..24e7d5592e799 100644
> >> --- a/drivers/net/netdevsim/ethtool.c
> >> +++ b/drivers/net/netdevsim/ethtool.c
> >> @@ -200,7 +200,22 @@ static int nsim_get_ts_info(struct net_device *dev,
> >>  {
> >>  	struct netdevsim *ns = netdev_priv(dev);
> >>  
> >> +	ethtool_op_get_ts_info(dev, info);
> >> +	if (!ns->phc) {
> >> +		info->phc_index = -1;
> >> +		return 0;
> >> +	}
> >> +
> > 
> > [Severity: High]
> > [Finding: main-1-1]
> > [Sources: opus-5]
> > This isn't a bug introduced by this patch, but the new !ns->phc guard looks
> > like it silently fixes a NULL pointer dereference that exists today, without
> > a mention in the changelog or a Fixes: tag.
> > 
> > Before this patch nsim_get_ts_info() did:
> > 
> > 	info->phc_index = mock_phc_index(ns->phc);
> > 
> > and nsim_ethtool_init() installs the shared nsim_ethtool_ops (including
> > .get_ts_info = nsim_get_ts_info) on every netdevsim netdev, while only
> > nsim_init_netdevsim() calls mock_phc_create().  nsim_init_netdevsim_vf()
> > just assigns nsim_vf_netdev_ops and registers the netdev, so ns->phc stays
> > NULL for VF netdevs.
> > 
> > With CONFIG_PTP_1588_CLOCK_MOCK=y, mock_phc_index() is the real function:
> > 
> > drivers/ptp/ptp_mock.c:mock_phc_index() {
> > 	return ptp_clock_index(phc->clock);
> > }
> > 
> > so ethtool -T on a netdevsim VF netdev dereferences NULL.  Would it make
> > sense to split this guard into its own patch with a Fixes: tag so that
> > stable tooling can pick it up?
> > 
> > Also, adding ethtool_op_get_ts_info() here changes ethtool -T output for all
> > netdevsim devices by advertising SOF_TIMESTAMPING_TX_SOFTWARE,
> > SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE.  Could the
> > changelog mention that behaviour change?
> This patchset introduces this connection - not sure what would it fix?

Thanks, I agree that seems to be a false positive.
Sorry for not noticing that earlier.

> >>  	info->phc_index = mock_phc_index(ns->phc);
> >> +	if (info->phc_index < 0)
> >> +		return 0;
> >> +
> >> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> >> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> >> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
> >> +
> >> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> >> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> >> index 4e9d7e10b527e..e586fd8f3bc37 100644
> >> --- a/drivers/net/netdevsim/netdev.c
> >> +++ b/drivers/net/netdevsim/netdev.c
> > 
> > [ ... ]
> > 
> >> @@ -164,6 +171,44 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  		skb_linearize(skb);
> >>  
> >>  	skb_tx_timestamp(skb);
> >> +
> >> +	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
> >> +		     HWTSTAMP_FILTER_NONE))
> >> +		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> >> +
> >> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> >> +	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON)
> >> +		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
> >> +
> >> +	if (unlikely(ptp_info_tx || ptp_info_rx)) {
> >> +		/* Capture both timestamps closely */
> >> +		if (ptp_info_tx)
> >> +			ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
> >> +		if (ptp_info_rx)
> >> +			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
> >> +
> >> +		/* If TX hardware timestamping is enabled report TX timestamp */
> >> +		if (ptp_info_tx) {
> >> +			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> >> +			skb_tstamp_tx(skb_orig, &shhwtstamps);
> >> +		}
> > 
> > [Severity: Medium]
> > [Finding: gpt-5-6-sol-3-10]
> > [Sources: gpt-5-6-sol, opus-5]
> > Can a socket receive two SCM_TSTAMP_SND reports for the same packet here?
> > 
> > The hardware report is emitted after skb_tx_timestamp(), which already
> > delivered the software one:
> > 
> > include/linux/skbuff.h:skb_tx_timestamp() {
> > 	skb_clone_tx_timestamp(skb);
> > 	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
> > 		skb_tstamp_tx(skb, NULL);
> > }
> > 
> > The only suppression of the software report lives in __skb_tstamp_tx():
> > 
> > net/core/skbuff.c:__skb_tstamp_tx() {
> > 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
> > 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> > 		return;
> > 
> > netdevsim never sets SKBTX_IN_PROGRESS anywhere - the new code only tests
> > SKBTX_HW_TSTAMP - so for a socket that enabled both
> > SOF_TIMESTAMPING_TX_SOFTWARE and SOF_TIMESTAMPING_TX_HARDWARE without
> > SOF_TIMESTAMPING_OPT_TX_SWHW both reports are delivered.
> > 
> > Would following the usual driver sequence work here, i.e. test
> > SKBTX_HW_TSTAMP and set SKBTX_IN_PROGRESS before calling
> > skb_tx_timestamp()?
> > 
> That protection is needed for the code that delays tstamp completion
> into some "worker" that handles the timestamp returned by HW once the
> packet was transmitted out. For a netdevsim we return the tx tstamp
> immediately.

Thanks, I think we cal let this one rest.

> >> +
> >> +		/* Unshare the skb, stamping it must not corrupt cloned copies
> >> +		 * and prevents returning single tstamp for Tx and Rx
> >> +		 */
> >> +		skb = skb_unshare(skb_orig, GFP_ATOMIC);
> >> +		if (unlikely(!skb)) {
> >> +			if (psp_ext)
> >> +				__skb_ext_put(psp_ext);
> >> +			goto out_drop_cnt;
> >> +		}
> > 
> > [Severity: Low]
> > [Finding: main-3-8]
> > [Sources: opus-5]
> > Should this skb_unshare() be gated on ptp_info_rx?
> > 
> > The enclosing condition is ptp_info_tx || ptp_info_rx, but the only write
> > into the skb below is guarded by if (ptp_info_rx).  On the TX-only path
> > (peer rx_filter == HWTSTAMP_FILTER_NONE) every timestamped frame gets copied
> > by skb_copy() for nothing, which also linearizes the buffer that the
> > hds_config logic just above deliberately left non-linear, and does not carry
> > queue_mapping.
> > 
> > If the GFP_ATOMIC copy then fails, the frame is dropped via out_drop_cnt
> > even though nothing needed to be written into it, and after the TX
> > timestamp was already handed to the socket by skb_tstamp_tx(skb_orig, ...).
> > 
> No - both paths requires skb_unshare. TX one needs it to unshare from
> the stack for example - for TCP retransmittion and PSP

Likewise, thanks. I see your point.

> > [Severity: Low]
> > [Finding: main-5-12]
> > [Sources: opus-5]
> > Does skb_unshare() cover the case this comment describes?
> > 
d
> > 	might_sleep_if(gfpflags_allow_blocking(pri));
> > 	if (skb_cloned(skb)) {
> > 	...
> > }
> > 
> > The copy is made only for clones, so an skb with skb->users > 1 and
> > cloned == 0 is returned unchanged.  pktgen does
> > refcount_add(burst, &pkt_dev->skb->users) and resubmits the same skb, so the
> > skb_hwtstamps(skb) write below touches skb_shared_info that the other
> > reference holder still owns, and that the peer's NAPI path may read
> > concurrently after nsim_forward_skb() -> nsim_napi_rx() queues it on
> > rq->skb_queue.  Should the driver check skb_shared() as well, or stamp a
> > private copy?
> > 
> ??

My understanding here is that it is possible for skbs to be shared without
being clones. E.g. pktgen.

And that as a software driver that simulates hardware timestamps
(unique in the Kernel?) this needs to be taken into account by
copying skbs that are either shared or cloned.

> 
> >> +
> >> +		/* If RX hardware timestamping is enabled report RX timestamp */
> >> +		if (ptp_info_rx)
> >> +			skb_hwtstamps(skb)->hwtstamp =
> >> +				timespec64_to_ktime(rx_ts);
> >> +	}
> >> +
> > 
> > [Severity: Critical]
> > [Finding: main-6-13]
> > [Sources: opus-5]
> > Can this write corrupt kernel memory for AF_XDP TX skbs?
> > 
> > skb_hwtstamps() returns a pointer into a union in skb_shared_info:
> > 
> > include/linux/skbuff.h:struct skb_shared_info {
> > 	union {
> > 		struct skb_shared_hwtstamps hwtstamps;
> > 		struct xsk_tx_metadata_compl xsk_meta;
> > 	};
> > 
> > struct xsk_tx_metadata_compl has a single member, u64 *tx_timestamp, and the
> > AF_XDP destructor dereferences it with only a NULL check:
> > 
> > net/xdp/xsk.c:xsk_destruct_skb() {
> > 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > 
> > 	if (compl->tx_timestamp) {
> > 		/* sw completion timestamp, not a real one */
> > 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> > 	}
> > 
> > Every generic-xmit AF_XDP skb carries that destructor
> > (xsk_skb_init_misc() sets skb->destructor = xsk_destruct_skb), and it is
> > freshly allocated and not cloned, so skb_unshare() above returns the same
> > skb with the destructor and the overwritten shinfo intact.
> > __dev_forward_skb() -> skb_scrub_packet() does not orphan the skb or reset
> > skb_shinfo(), so the value survives to the destructor.
> > 
> > The RX branch is gated only on the peer's setting:
> > 
> > 	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
> > 		     HWTSTAMP_FILTER_NONE))
> > 		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> > 
> > so any AF_XDP frame forwarded while the peer has RX timestamping enabled
> > gets a non-NULL, PHC-derived value in xsk_meta.tx_timestamp, and the
> > destructor performs an 8-byte write to that address.  The mock PHC value is
> > settable from userspace through clock_settime() on /dev/ptpN via
> > mock_phc_settime64().
> > 
> > Real NICs avoid this because they only stamp skbs they allocated for RX.
> > Since netdevsim reuses the TX skb as the RX skb, should it orphan the skb
> > (clearing skb->destructor) or stamp a private copy before touching
> > skb_shinfo()->hwtstamps?
> > 
> Sounds like this should be addressed in the generic skb_scrub_packet in
> the __dev_forward_skb path?

My understanding is that would be outside the scope of skb_scrub_packet.
And doing so would would break socket memory accounting and the AF_XDP
completion signal.

I think that this problem occurs because netdev sim both uses the same skbs
for both RX and TX, and now modifies shared metadata. As this is an unusual
(unique?) scenario, it seems reasonable to me for the driver to address the
issue.

> 
> >>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
> >>  				      skb, rq, psp_ext) == NET_RX_DROP))
> >>  		goto out_drop_cnt;
> >> @@ -185,6 +230,63 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  	return NETDEV_TX_OK;
> >>  }
> >>  
> >> +static int nsim_set_ts_config(struct net_device *netdev,
> >> +			      struct kernel_hwtstamp_config *config,
> >> +			      struct netlink_ext_ack *extack)
> >> +{
> >> +	struct netdevsim *ns = netdev_priv(netdev);
> >> +	int rx_filter;
> >> +
> >> +	if (!ns->phc)
> >> +		return -EOPNOTSUPP;
> >> +
> > 
> > [ ... ]
> > 
> >> +static int nsim_get_ts_config(struct net_device *netdev,
> >> +			      struct kernel_hwtstamp_config *config)
> >> +{
> >> +	struct netdevsim *ns = netdev_priv(netdev);
> >> +
> >> +	*config = ns->tstamp_config;
> >> +	return 0;
> >> +}
> > 
> > [Severity: Low]
> > [Finding: gpt-5-6-sol-2-6]
> > [Sources: gpt-5-6-sol, opus-5]
> > Should nsim_get_ts_config() carry the same !ns->phc check as
> > nsim_set_ts_config()?
> > 
> > drivers/net/Kconfig allows netdevsim without the mock clock:
> > 
> > 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
> > 
> > and with CONFIG_PTP_1588_CLOCK_MOCK=n the stub is used:
> > 
> > include/linux/ptp_mock.h {
> > static inline struct mock_phc *mock_phc_create(struct device *dev)
> > {
> > 	return NULL;
> > }
> > 
> > nsim_init_netdevsim() only rejects IS_ERR(), so ns->phc stays NULL.  In that
> > configuration SIOCGHWTSTAMP succeeds and reports tx_type =
> > HWTSTAMP_TX_OFF / rx_filter = HWTSTAMP_FILTER_NONE, i.e. "hardware
> > timestamping present but disabled", while nsim_get_ts_info() reports
> > phc_index = -1 with no hardware so_timestamping and every set attempt is
> > rejected with -EOPNOTSUPP.  Other converted drivers keep the get/set pair
> > symmetric here.
> > 
> > [ ... ]
> We don't support setting, getting is always available - not sure what's
> the hypothetical bug there

I don't think there is a bug here.
Rather, I think it's a question about API symmetry.

It seems that drivers have some leeway on this one,
so I think you can use your own best judgement.
