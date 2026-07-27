Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5A3F5BD6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145430; cv=none; b=ddUXawOtJvjiy61gVrhemXz9XEnLe4VnTtxR6XkyT8DFLF+ulid8zTlJtA4IrfZxpdklzczx0oGXRBcqUv7cI6OMj8GQV9YYCvHNg+WeLUKoIKVLV84PmEsNJ06NK7TmqcGeo1O1LuZPz3gfMjRoz+pdRVU/dg+ziHO7Ucjy9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145430; c=relaxed/simple;
	bh=r7m5U/SjnCTKInl38gniCDb4WxBfa1b5uBHwKwKnnlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl6sATR+WmI1AfedvNHSHtaZlB9FMGCgVwA/Q2s9NhsKTd/BHrSTpvrQKeVwL3URWH+zrv3DEkn9rqUZ0/hdPwsvuT0uXG5kXgy/Zyu0L/ITEJrgs6fN9vLxqnDtLNz16GOU6kuCw0pijv+Lb0y633m/CV5V5Tiya5dWhMzdzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmd+m8Rs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmd+m8Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2421F000E9;
	Mon, 27 Jul 2026 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785145428;
	bh=7eWFhnBwz+WLNI3BQpCVuNiZR4waikiopqgd9ePffBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hmd+m8RsGxNygiNyFObh5f2ryV7M6Rwps56ITWRI6XjslC2aViIgsyApQ70T/qa+n
	 jNP6KZZJKHGtyUygrx9o/g7l5eot7yzEQW7Hc8vDjm9hOTptObgisUQEzRcBaKPW5Q
	 4GL6uYzMG8d0rKjIbtG8qD7+sy3wkNDetdDhllO6NgiT9aXSypHrQq/6+EVsXrFCPS
	 dnw2Lb6uu0JnBklRC3wuX0sHj5urGuWX3E2laD3RujFzA5JnOhmlabVKmbggim85Xq
	 WhE7/fcwujrxx4pofB5KsJ/QzNkQl1j1TqzSOsqabFaSG0FzRP4vp0DiO3GUVtS7uw
	 cxBNfrNi/kUsA==
Date: Mon, 27 Jul 2026 10:43:44 +0100
From: Simon Horman <horms@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v7 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20260727094344.GM418547@horms.kernel.org>
References: <20260720181113.3293-1-maciek@machnikowski.net>
 <20260720181113.3293-3-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720181113.3293-3-maciek@machnikowski.net>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260720181113.3293-2-maciek@machnikowski.net?part=2
---
netdevsim: Implement basic ptp support

This change adds virtual TX/RX hardware timestamping to netdevsim using
two attached ptp_mock clocks, wires up ndo_hwtstamp_get / ndo_hwtstamp_set,
and updates ethtool ts_info to advertise HW timestamping capabilities.

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 4e9d7e10b527..2e31c04adf78 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -164,6 +171,36 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_linearize(skb);
>  
>  	skb_tx_timestamp(skb);
> +
> +	if (peer_ns->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
> +		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> +
> +	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
> +	    ns->tstamp_config.tx_type == HWTSTAMP_TX_ON)
> +		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);

[Medium]
The tstamp_config fields consulted here (peer_ns->tstamp_config.rx_filter
and ns->tstamp_config.tx_type) are read from the xmit path under only
rcu_read_lock().

The writer side, nsim_set_ts_config(), runs from the ndo_hwtstamp_set
path under rtnl_lock and modifies these fields as plain stores with no
matching READ_ONCE()/WRITE_ONCE() and no shared lock or RCU protection:

	ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
	...
	ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;

Is this pairing intentional?  KCSAN would flag this as a data race, and
because tx_type and rx_filter are updated in two separate unlocked
stores, a concurrent xmit can observe a new tx_type combined with the
old rx_filter (or vice versa) for a single packet.

Would READ_ONCE()/WRITE_ONCE() on these fields, or making tstamp_config
RCU-managed, be more appropriate here?

> +
> +	/* If TX hardware timestamping is enabled, sample our PHC and report
> +	 * the TX timestamp back.
> +	 */
> +	if (ptp_info_tx) {
> +		ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
> +		if (likely(ptp_info_rx))
> +			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);

[Low]
Is the likely() here justified?  ptp_info_rx being non-NULL means the
peer port has an rx_filter other than HWTSTAMP_FILTER_NONE, and
ptp_info_tx being non-NULL means the local port has tx_type ==
HWTSTAMP_TX_ON.

These are two independent user configurations on two independent
netdevsim ports; one does not imply the other, so the branch hint does
not seem to reflect an actual statistical bias.

> +		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> +		skb_tstamp_tx(skb_orig, &shhwtstamps);
> +
> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> +		if (skb)
> +			consume_skb(skb_orig);
> +		else
> +			skb = skb_orig;
> +	} else if (ptp_info_rx) {
> +		ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
> +	}
> +
> +	if (ptp_info_rx)
> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);

[High]
When skb_copy() fails under memory pressure and the code falls back to
skb = skb_orig, does the following skb_hwtstamps(skb)->hwtstamp write
corrupt the TX timestamp already reported to userspace?

skb_tstamp_tx() -> __skb_tstamp_tx() clones skb_orig via skb_clone(),
which shares the underlying skb_shared_info with the original.  In the
common non-TSONLY path __skb_tstamp_tx() writes the tx timestamp into
that shared shinfo before queueing the clone on the socket error queue:

	*skb_hwtstamps(clone) = *hwtstamps;
	__skb_complete_tx_timestamp(clone, sk, tstype, opt_stats);

If skb_copy(skb_orig, GFP_ATOMIC) then fails and skb is set back to
skb_orig, the subsequent

	skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);

overwrites the same shinfo that the queued TX-timestamp clone points
at.  Userspace reading SCM_TSTAMP_SND via MSG_ERRQUEUE would then see
rx_ts instead of tx_ts.

Would it be safer to skip the shinfo write on skb_copy() failure, or to
drop the packet on that path, rather than silently corrupting the
reported TX timestamp?

Simon says: I believe the issue raised below has already been discussed.

[Low]
Relatedly, could the skb_copy(GFP_ATOMIC) approach be avoided
altogether?  The copy exists purely so the later rx_ts store lands on a
private shinfo that is not shared with the TX-report clone, but this
dependency on __skb_tstamp_tx() cloning semantics is not documented at
the call site.

Writing rx_ts into skb_hwtstamps(skb) before invoking skb_tstamp_tx()
(and passing only the local shhwtstamps to skb_tstamp_tx()) would avoid
the atomic allocation in the hot path and would also make the previous
fallback question moot.  If the copy stays, would a comment explaining
why it is necessary help future readers?

> +
>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;
> @@ -185,6 +222,61 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}

[Low, Low]
Two questions about this switch.

First, is it intentional that ns->tstamp_config.tx_type has already
been committed here before config->rx_filter has been validated?  If
the caller passes a valid tx_type paired with an unsupported rx_filter,
the function returns -ERANGE via the second switch's default, but
ns->tstamp_config.tx_type has silently been updated to the new value.
Userspace sees an error while the device is left in a partially-applied
state.

Would validating both fields up front (or using a scratch
kernel_hwtstamp_config that is copied into ns->tstamp_config only on
success) match the pattern used by most in-tree drivers?

Second, on the default: return -ERANGE, would -EOPNOTSUPP be more in
line with kernel convention here?  Drivers such as igb, i40e, and mlx5
reserve -ERANGE for values that are outside the enum's numeric range
and return -EOPNOTSUPP for values that are within range but unsupported
by the driver.  Since netdevsim is often used as a reference target for
ptp4l, hwstamp_ctl, and ethtool selftests, the errno value tends to
propagate into test expectations.

> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	config->rx_filter = ns->tstamp_config.rx_filter;
> +
> +	return 0;
> +}
