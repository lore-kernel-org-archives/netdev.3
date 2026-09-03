Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD183B6362;
	Thu,  3 Sep 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479076; cv=none; b=gZlFS6J+yWEA/oLljr8paHYWH/bsVef4QDIE/B0VIFAUbfJYmGTe7OgFoV7c5EXGDG3OmfH365j2Bend3i5uV1Iq9qBlGP2rTQxOq6+hmvMZK4KxaoX+MPo4SpzG6ngo3pNKqjGFFSBc1nZDPASwQuFERSA387vUBPlTR17B5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479076; c=relaxed/simple;
	bh=1c3u9lbyrEK3Sipbuw+pzD7gE1dM6Vt3CXqxnRu4Q5w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIXHVAy3fAT2aFfXHBcD7gkuGosZ7Owsv+oous85bju9evAp88gSnxt7WxcngWbTPPsRHT+DNybWt9nb1gzsUmMh0sbPBKbvDpn3/ADyJQjo7vqhUbM8xKQZcgH7Sf3yubp6kxlO89gZTiG0GNGIs+aTZM+YFzacj12jEZS9ZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6FjUim2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6FjUim2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A301F000E9;
	Thu,  3 Sep 2026 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479071;
	bh=A4PzUWSrsOlBl0EXImtelImvI4eWA9wr/zb8Q3KfysA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a6FjUim26h3MEwLkD/B0GoYimsRXx6av/k25aXbCc2jArRVFpveaLg0AGFwqJOTzZ
	 t4XhIYPPXswDdD+AdR0FYe0TqkG2TUqBUXWDR/AQdhbB9F3pqJPuSUs+OWvriNqA7J
	 1dCGgVmUfMiNFzQPpxdZdEZg2Oi5iUDKD17xPG4zhApCh73Xhz+eyQnxuMsM9Ps6o0
	 lKD5aOFSB8UWF/DePIsAJ8hToodRRjOc/EMLQ7Ey+YCFKlEY2CxbuC6hZghD1icH79
	 174wVkOH+nUTMXTtA1EilSwMt0V9yBqIDt/vjOk0Tn3N8czWjMbUOtVNXMQBZndhcn
	 mPsot6Xf041Jw==
Subject: Re: [PATCH v3 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:30 +0000
Message-ID: <178847907053.4131868.14448615471105460167@kernel.org>
In-Reply-To: <20260831025441.635045-14-wei.fang@oss.nxp.com>
References: <20260831025441.635045-14-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] For the default (untrusted) ENETC v4 VF the PF handlers reject
  exactly the messages the new callback sends, and…
- [Medium] enetc_vf_set_rx_mode() narrows the SI's promiscuous
  configuration before the replacement MAC hash filters are installed,…
- [Low] The commit message describes the change as a plain Rx-mode
  offload implementation for ENETC v4 VFs and never mentions that every…
- [Low] The single enetc_ndev_ops table used by all ENETC VFs now
  installs '.ndo_set_rx_mode_async = enetc_vf_set_rx_mode'…

--

net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF

This adds ndo_set_rx_mode_async to the ENETC VF driver so MAC filter
updates can be sent to the PF through the sleepable VSI mailbox path, and
sets IFF_UNICAST_FLT for ENETC v4 VFs. Two helpers are added, one for the
MAC promiscuous mode message and one for the 64-bit hash filter message.

A few questions about the interaction with the PF-side trust checks and
about the ordering of the two mailbox messages.

First, on the commit message itself:

> The ndo_set_rx_mode_async callback selects the appropriate filter
> configuration based on the current netdev flags:
>
>  - IFF_PROMISC: enable full promiscuous mode for both unicast and
>    multicast
>  - IFF_ALLMULTI: enable multicast promiscuous mode, disable unicast
>    promiscuous mode, and apply a unicast hash filter
>  - otherwise: disable all promiscuous modes and apply both
>               unicast and multicast hash filters
>
> Set IFF_UNICAST_FLT in priv_flags for ENETC v4 VFs so the network stack
> does not fall back to full promiscuous mode unnecessarily when unicast
> address filtering is supported by the hardware.
>
> This feature applies to ENETC v4 hardware only. ENETC v1 (LS1028A) does
> not support VF-PF MAC filter messaging and the callback returns early
> for such devices.

[Severity: Low]
Could the commit message mention that all of these messages are subject to
the PF-side ENETC_VF_FLAG_TRUSTED check in enetc_msg.c?

For an untrusted VF (the default), enetc_msg_set_vf_mac_promisc_mode()
denies any promisc-enable and enetc_msg_set_vf_mac_hash_filter() denies
unicast hash programming, so the described IFF_PROMISC and IFF_ALLMULTI
behaviour does not take effect, and the justification for IFF_UNICAST_FLT
("unicast address filtering is supported by the hardware") only holds for
trusted VFs.

The message also documents only the ENETC v1 early return, not the new
policy at the out: label that maps -EOPNOTSUPP, -EACCES and -EPERM to 0.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 322705202d49..4e717afba7f7 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -213,6 +213,142 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  	}
>  }
>  
> +static int enetc_vf_set_mac_promisc(struct enetc_si *si, int type, bool en)
> +{
> +	struct enetc_msg_mac_promisc_mode *msg;
> +	struct device *dev = &si->pdev->dev;
> +	struct enetc_msg_swbd msg_swbd;
> +
> +	if (!(type & ENETC_MAC_FILTER_TYPE_ALL))
> +		return -EINVAL;
> +
> +	msg_swbd.size = ALIGN(sizeof(*msg), ENETC_MSG_ALIGN);
> +	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
> +					    &msg_swbd.dma, GFP_KERNEL);
> +	if (!msg_swbd.vaddr)
> +		return -ENOMEM;
> +
> +	msg = (struct enetc_msg_mac_promisc_mode *)msg_swbd.vaddr;
> +	msg->config = FIELD_PREP(ENETC_MSG_MAC_TYPE,
> +				 type & ENETC_MAC_FILTER_TYPE_ALL);
> +	msg->config |= FIELD_PREP(ENETC_MSG_MAC_PROMISC_MODE, en);
> +	msg->config |= FIELD_PREP(ENETC_MSG_MAC_FLUSH_MACS, en);
> +	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
> +				  ENETC_MSG_SET_MAC_PROMISC_MODE, 0, 0);
> +
> +	return enetc_msg_vsi_send(si, &msg_swbd);
> +}
> +
> +static int enetc_vf_set_mac_hash_filter(struct enetc_si *si,
> +					struct netdev_hw_addr_list *uc,
> +					struct netdev_hw_addr_list *mc)
> +{
> +	struct enetc_msg_mac_hash_filter *msg;
> +	struct enetc_mac_filter *mac_filter;
> +	struct device *dev = &si->pdev->dev;
> +	struct net_device *ndev = si->ndev;
> +	struct enetc_msg_swbd msg_swbd;
> +	struct netdev_hw_addr *ha;
> +	u32 msg_size, tbl_cnt;
> +	int mac_filter_type;
> +	int i = 0;
> +
> +	if (ndev->flags & IFF_PROMISC)
> +		return 0;
> +
> +	if (ndev->flags & IFF_ALLMULTI) {
> +		tbl_cnt = 2;
> +		mac_filter_type = ENETC_MAC_FILTER_TYPE_UC;
> +	} else {
> +		tbl_cnt = 4;
> +		mac_filter_type = ENETC_MAC_FILTER_TYPE_ALL;
> +	}
> +

[ ... ]

> +	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_UC) {
> +		mac_filter = &si->mac_filter[UC];
> +		enetc_reset_mac_addr_filter(mac_filter);
> +		netdev_hw_addr_list_for_each(ha, uc)
> +			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
> +
> +		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
> +				ENETC_MADDR_HASH_TBL_SZ);
> +		i += 2;
> +	}
> +
> +	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_MC) {
> +		mac_filter = &si->mac_filter[MC];
> +		enetc_reset_mac_addr_filter(mac_filter);
> +		netdev_hw_addr_list_for_each(ha, mc)
> +			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
> +
> +		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
> +				ENETC_MADDR_HASH_TBL_SZ);
> +	}
> +
> +	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
> +				  ENETC_MSG_SET_MAC_HASH_TABLE, 0, 0);
> +
> +	return enetc_msg_vsi_send(si, &msg_swbd);
> +}
> +
> +static int enetc_vf_set_rx_mode(struct net_device *ndev,
> +				struct netdev_hw_addr_list *uc,
> +				struct netdev_hw_addr_list *mc)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_si *si = priv->si;
> +	int err;
> +
> +	/* For ENETC v1, we cannot return -EOPNOTSUPP or any other error,
> +	 * otherwise ndev->rx_mode_retry_timer will try to set rx_mode
> +	 * multiple times, which is pointless.
> +	 */
> +	if (is_enetc_rev1(si))
> +		return 0;
> +
> +	if (ndev->flags & IFF_PROMISC) {
> +		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> +					       true);
> +	} else if (ndev->flags & IFF_ALLMULTI) {
> +		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
> +					       false);
> +		if (err)
> +			goto out;
> +
> +		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
> +					       true);
> +	} else {
> +		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> +					       false);
> +	}
> +
> +	if (err)
> +		goto out;
> +
> +	err = enetc_vf_set_mac_hash_filter(si, uc, mc);
> +

[Severity: Medium]
Is the order of these two mailbox transactions the right way round?

enetc_vf_set_mac_promisc() sends FLUSH_MACS together with en, and the PF
handler zeroes both hash filter registers when FLUSH_MACS is set:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_promisc_mode() {
	...
	if ((type & ENETC_MAC_FILTER_TYPE_UC) && flush_macs)
		enetc_set_si_uc_hash_filter(si, si_id, 0);

	if ((type & ENETC_MAC_FILTER_TYPE_MC) && flush_macs)
		enetc_set_si_mc_hash_filter(si, si_id, 0);
	...
}

So while promiscuous mode is active the SI hash filters are known to be
empty (enetc_vf_set_mac_hash_filter() also returns early for IFF_PROMISC).
On the way out of promiscuous mode this function completes the
promisc-disable round trip first and only then installs the replacement
hash filters.

Each enetc_msg_vsi_send() is a blocking round trip polled with
read_poll_timeout(..., 1000, 200000, ...). Between the two sends the SI has
promiscuity cleared and empty hash filters - can that drop all multicast
and secondary unicast frames for the duration, two round trips in the
IFF_ALLMULTI branch?

And if the hash filter send then fails (-EIO "VSI mailbox is busy", -ETIME
on mailbox timeout, -EBUSY for a busy PSI), the promisc-off write is
already committed and is not undone; netif_rx_mode_schedule_retry() gives
up after NETIF_RX_MODE_RETRY_MAX attempts:

net/core/dev_addr_lists.c:netif_rx_mode_schedule_retry() {
	if (dev->rx_mode_retry_count >= NETIF_RX_MODE_RETRY_MAX) {
		netdev_err(dev, "rx_mode retry limit reached, giving up\n");
		return;
	}
	...
}

Would programming the new (superset) filters before narrowing the
promiscuous bits avoid both the window and the stuck state? The PF side
already does something similar in enetc4_pf_set_uc_exact_filter() with its
temporary unicast hash filter.

> +out:
> +	/* If the error code is -EOPNOTSUPP or -EACCES or -EPERM, return 0
> +	 * directly to avoid meaningless retries.
> +	 */
> +	if (err == -EOPNOTSUPP || err == -EACCES || err == -EPERM)
> +		return 0;
> +
> +	return err;
> +}
> +

[Severity: High]
For an untrusted VF - the default, since pf->vf_state is allocated with
devm_kcalloc() and ENETC_VF_FLAG_TRUSTED is only set by
enetc_pf_set_vf_trust() - the PF handlers reject exactly the messages this
callback sends.

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_promisc_mode() {
	...
	promisc = !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
		pf_msg = ENETC_PF_MSG_PERM_DENY;
		goto vf_state_unlock;
	}
	...
}

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_set_vf_mac_hash_filter() {
	...
	case ENETC_MAC_FILTER_TYPE_UC:
		if (!trusted) {
			pf_msg = ENETC_PF_MSG_PERM_DENY;
			goto vf_state_unlock;
		}
	...
	case ENETC_MAC_FILTER_TYPE_ALL:
		...
		if (!trusted &&
		    (hweight64(mc_hash) <= ENETC_VF_MC_HASH_BITS_MAX)) {
			enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
			pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
			goto vf_state_unlock;
		}

		if (!trusted) {
			pf_msg = ENETC_PF_MSG_PERM_DENY;
			goto vf_state_unlock;
		}
	...
}

enetc_msg_vsi_send() maps PERMISSION_DENY and UCF_DENY to -EACCES and
returns before the dev_err(), so there is not even a log line.

In the IFF_ALLMULTI branch, does the MC promisc-enable message therefore
always fail on an untrusted VF, making "if (err) goto out;" skip
enetc_vf_set_mac_hash_filter() completely?

Even when it is reached, enetc_vf_set_mac_hash_filter() selects
mac_filter_type = ENETC_MAC_FILTER_TYPE_UC under IFF_ALLMULTI, so the mc
snapshot handed in by the core is never converted into an MC hash table.
With MC promiscuous mode denied as well, does the multicast hash filter
stay frozen at its previous contents - so groups joined after the VF is
enslaved to a bridge or gets a macvlan on top (both call
dev_set_allmulti()), such as IPv6 solicited-node addresses or mDNS, are
silently dropped by hardware?

In the default branch the TYPE_ALL message is refused outright once more
than ENETC_VF_MC_HASH_BITS_MAX (8) multicast hash bits are set, so
PSIMMHFR0/1 keeps its stale value. Would it be worth falling back to the
MC-only message, which the PF does accept from an untrusted VF?

The out: block then turns -EACCES, -EPERM and -EOPNOTSUPP into 0, and the
core treats that as "installed":

net/core/dev_addr_lists.c:netif_rx_mode_run() {
	...
		if (err)
			netif_rx_mode_schedule_retry(dev);
		else
			dev->rx_mode_retry_count = 0;
	...
}

Can this leave the SI hash filters permanently out of sync with the address
list the stack believes is programmed, with no retry and no message? Since
this patch also sets IFF_UNICAST_FLT, the core's unicast promiscuous
fallback is suppressed too.

Two related points: the promisc-disable message carries FLUSH_MACS = en =
false, so a denied hash filter update can also leave hardware more
permissive than requested (removed multicast groups keep being received).
And when trust is granted later, enetc_pf_set_vf_trust() only flips the
PF-side flag - nothing replays or re-requests the receive mode
configuration that the VF already reported as successfully installed, so
does a configuration denied while untrusted stay unapplied indefinitely?

>  /* Probing/ Init */
>  static const struct net_device_ops enetc_ndev_ops = {
>  	.ndo_open		= enetc_open,
> @@ -225,6 +361,7 @@ static const struct net_device_ops enetc_ndev_ops = {
>  	.ndo_setup_tc		= enetc_vf_setup_tc,
>  	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
>  	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
> +	.ndo_set_rx_mode_async	= enetc_vf_set_rx_mode,
>  };

[Severity: Low]
This ops table is shared by ENETC v1 and v4 VFs, but the callback returns 0
immediately for v1 without programming anything. Core code uses callback
presence as the rx-filtering capability test:

net/core/dev_ioctl.c:dev_ifsioc() {
	...
	case SIOCADDMULTI:
		if ((!ops->ndo_set_rx_mode && !ops->ndo_set_rx_mode_async) ||
		    ifr->ifr_hwaddr.sa_family != AF_UNSPEC)
			return -EINVAL;
	...
}

Does SIOCADDMULTI/SIOCDELMULTI on an ENETC v1 VF now return success instead
of -EINVAL while no hardware filter is touched, and __dev_set_rx_mode()
queue rx-mode work that can never do anything? Could the revision test be
applied where the ops are selected, as the probe path already does for
si->ops, so the capability is only advertised where it is implemented?

>  
>  static void enetc_vf_get_revision(struct enetc_si *si)
> @@ -280,6 +417,9 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>  
> +	if (!is_enetc_rev1(si))
> +		ndev->priv_flags |= IFF_UNICAST_FLT;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
