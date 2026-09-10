Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE5473C6D;
	Thu, 10 Sep 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039266; cv=none; b=ShdKcysbanjFXd/jaUbPwl6IxeOAGWqU1Ozs7CqfTWwaiajr9ikNehwDEaZEHnXY5BwboxcJUxAJO+RsQo1Dz8k3slqzWLsdAS+Jr3mRN+hc0PB9xX1eNkaw9b5u+Ij+G9Fh9hcKM5YDh6lP2OTg05TOxQOpjdDYckY6SkHaurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039266; c=relaxed/simple;
	bh=lL8+JGnh5xf7KwBgn2XoCs3ua3cxk+WojJ7XDg0JJ8s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYxPLL4ugOXBwrH6nB+LMeurPU0kBFw7VDcIx/zJ/Whxur0W5G+Amix09IeJS64G67lxq14UASxxppUMP8IidVuat1pppt8qZRwu6zl3hUOYM3YBxoaHSomux3JtTBNreVDRMceBBE1N3YmIXL/XaYjR1OXq3awKbEv8/rZ1Jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYmCaKtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYmCaKtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21EF1F000FF;
	Thu, 10 Sep 2026 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039264;
	bh=QLKOxrsza6FNRWBhKuvFP6S5EVJilbTjFGeurG/vnIc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYmCaKtdad1cKS8xKZ2HMmv+NPAztQ5IvbjnNSpNxkMDRQitOIFEKkIZ37N1G5bX5
	 cbQzjF7NIpwiuECYK9lPwbPi7Hn2SQbpwLDhhWBakp4MMh/2VwCc1UScSv/AATMcyX
	 pOrRNpamqIAD+KN6xkIFJpO7VXSRhLpQKaFx5V4SORkeYf1M7wSc4b7+p/m0jlBa38
	 X21/ygkppe8rL3xjpvjTBRCajKOoUbEKzFJSz2D356xQzH/fbZMc0bVuIaf8Vy2k/T
	 /42b0isTg17abYMxzUPz+dbdSwhNhNbpkxtQ4l0wVZ7vStcRZEDjq4g7L0N5oLRKo8
	 o6ZUUMgELiY/w==
Subject: Re: [PATCH v4 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:21:03 +0000
Message-ID: <178903926334.219967.16804647636083728904@kernel.org>
In-Reply-To: <20260909100733.1139689-14-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-14-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] For the default (untrusted) ENETC v4 VF, the IFF_PROMISC and
  IFF_ALLMULTI branches of the new enetc_vf_set_rx_mode() program no MAC…
- [Medium] enetc_vf_set_rx_mode()
  (drivers/net/ethernet/freescale/enetc/enetc_vf.c:394-398) translates…
- [Medium] enetc_vf_disable_iff_promisc() (enetc_vf.c:323-345) treats a
  documented *partial success* from the PF as fatal and therefore never…

--

net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF

This converts ENETC v4 VFs to ndo_set_rx_mode_async so MAC filter updates
can sleep on the VSI mailbox, adds enetc_vf_set_mac_promisc() and
enetc_vf_set_mac_hash_filter() helpers, and picks promisc/allmulti/hash
filter configuration from the current netdev flags.

A few questions below about the untrusted-VF paths and the error handling.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 322705202d49..8cf38c426dae 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -213,6 +213,193 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  	}
>  }
>  

[ ... ]

> +static int enetc_vf_enable_iff_promisc(struct enetc_si *si)
> +{
> +	int err;
> +
> +	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> +				       true, true);
> +	if (err)
> +		dev_err(&si->pdev->dev,
> +			"Failed to enable promiscuous mode, err: %pe\n",
> +			ERR_PTR(err));
> +
> +	return err;
> +}
> +
> +static int enetc_vf_disable_iff_promisc(struct enetc_si *si,
> +					struct netdev_hw_addr_list *uc,
> +					struct netdev_hw_addr_list *mc)
> +{
> +	int err;
> +
> +	err = enetc_vf_set_mac_hash_filter(si, uc, mc);
> +	if (err) {
> +		dev_err_once(&si->pdev->dev,
> +			     "Failed to set MAC hash filters, err: %pe\n",
> +			     ERR_PTR(err));
> +		return err;
> +	}
> +
> +	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
> +				       false, false);

[Severity: Medium]
Is the early return above correct when the PF only denies the unicast part
of the request?

enetc_vf_disable_iff_promisc() sends the combined hash filter first with
type = UC | MC.  On the PF side, enetc_msg_set_vf_mac_hash_filter() handles
ENETC_MAC_FILTER_TYPE_ALL like this:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:
	if (!trusted &&
	    (hweight64(mc_hash) <= ENETC_VF_MC_HASH_BITS_MAX)) {
		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
		pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
		goto vf_state_unlock;
	}

so the multicast hash was applied and only unicast was refused, yet
enetc_msg_vsi_send() maps UCF_DENY to -EACCES.  For the default untrusted
VF that means the 'return err' path is always taken and the following

	enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL, false, false);

message, the one that actually leaves promiscuous mode, is never sent.
Would it be better to treat UCF_DENY as a partial success and continue, or
to send the promisc-off message before the hash filter?

The same ordering concern applies to enetc_vf_enable_iff_allmulti() below:
the hardware-changing step (enable MC promisc with flush_macs = true) runs
first and the restricting step (disable UC promisc) runs last, with no
rollback if a later mailbox transaction returns -EIO ("VSI mailbox is
busy"), -ETIME ("VSI mailbox timeout") or -EBUSY from the PSI.  Can that
leave a trusted VF with UC/MC promiscuity armed in the SI while the netdev
has already left promiscuous mode?

Since the SI promiscuity bits live in PF register space indexed by si_id and
are re-applied after FLR by enetc4_pf_vf_flr_handler(), a skipped
promisc-off message appears to persist until the VF issues another one or
the PF revokes trust.

> +	if (err)
> +		dev_err_once(&si->pdev->dev,
> +			     "Failed to disable promiscuous mode, err: %pe\n",
> +			     ERR_PTR(err));
> +
> +	return err;
> +}
> +
> +static int enetc_vf_enable_iff_allmulti(struct enetc_si *si,
> +					struct netdev_hw_addr_list *uc)
> +{
> +	int err;
> +
> +	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
> +				       true, true);
> +	if (err) {
> +		dev_err(&si->pdev->dev,
> +			"Failed to enable multicast promiscuous mode, err: %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	}

[Severity: High]
For an untrusted VF, does this leave the IFF_ALLMULTI and IFF_PROMISC cases
with no MAC filter programmed at all?

Both enetc_vf_enable_iff_allmulti() and enetc_vf_enable_iff_promisc() start
by requesting promiscuous mode, and the PF rejects that unconditionally
before touching any register:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:
enetc_msg_set_vf_mac_promisc_mode() {
	promisc = !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
		pf_msg = ENETC_PF_MSG_PERM_DENY;
		goto vf_state_unlock;
	}

That becomes -EACCES and both helpers return immediately, so the unicast
hash filter, the unicast-promisc-off message and any multicast hash filter
are never sent.

Note also that the multicast snapshot is not passed into either of these two
branches, and enetc_vf_set_mac_hash_filter(si, NULL, mc) has no caller in
the patch.  The PF does permit a bounded multicast-only hash filter for an
untrusted VF:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:
enetc_msg_set_vf_mac_hash_filter() {
	case ENETC_MAC_FILTER_TYPE_MC:
		mc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
		if (!trusted &&
		    hweight64(mc_hash) > ENETC_VF_MC_HASH_BITS_MAX) {
			pf_msg = ENETC_PF_MSG_PERM_DENY;
			goto vf_state_unlock;
		}

		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);

so multicast groups joined while the interface is in allmulti or promisc
mode appear to be silently dropped, with the SI keeping whatever hash filter
the last non-allmulti update left behind.  IFF_ALLMULTI and IFF_PROMISC are
entered by ordinary operations (bridge/bond/macvlan enslavement, 'ip link
set ... allmulticast on', tcpdump), including from a guest owning the VF.

This also seems to contradict the commit message:

	For an untrusted VF (the default) the PF denies promiscuous mode and
	unicast hash filtering, so only the multicast hash filter is
	applied, limited to ENETC_VF_MC_HASH_BITS_MAX buckets.

That only holds for the third (non-promisc, non-allmulti) branch, not for
these two.

One more thing: unlike enetc_vf_disable_iff_promisc(), which uses
dev_err_once(), these two helpers use plain dev_err().  Since the denial is
guaranteed for an untrusted VF, wouldn't that print an error line on every
rx_mode update, i.e. on every multicast join/leave and every bridge or bond
membership change?

> +
> +	err = enetc_vf_set_mac_hash_filter(si, uc, NULL);
> +	if (err) {
> +		dev_err(&si->pdev->dev,
> +			"Failed to set unicast filter, err: %pe\n",
> +		ERR_PTR(err));
> +		return err;
> +	}
> +
> +	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
> +				       false, false);
> +	if (err)
> +		dev_err(&si->pdev->dev,
> +			"Failed to disable unicast promiscuous mode, err: %pe\n",
> +		ERR_PTR(err));
> +
> +	return err;
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
> +	if (ndev->flags & IFF_PROMISC)
> +		err = enetc_vf_enable_iff_promisc(si);
> +	else if (ndev->flags & IFF_ALLMULTI)
> +		err = enetc_vf_enable_iff_allmulti(si, uc);
> +	else
> +		err = enetc_vf_disable_iff_promisc(si, uc, mc);
> +
> +	/* If the error code is -EOPNOTSUPP or -EACCES or -EPERM, return 0
> +	 * directly to avoid meaningless retries.
> +	 */
> +	if (err == -EOPNOTSUPP || err == -EACCES || err == -EPERM)
> +		return 0;
> +
> +	return err;
> +}

[Severity: Medium]
Is the premise behind this mapping accurate?  The comment, and the commit
message wording

	Since a denied request always fails, map -EOPNOTSUPP, -EACCES and
	-EPERM to 0 so the core does not retry an operation that can never
	succeed.

assume the denial is permanent, but PF trust is runtime-mutable:

drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:
enetc_pf_set_vf_trust() {
	if (setting) {
		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
	} else {

That path only flips the flag; it neither notifies the VF nor replays the
previously rejected configuration.  So does

	ip link set <pf> vf N trust on

as suggested in the commit message actually take effect before some
unrelated flag or address-list change happens to re-trigger the callback?

Also, ndo_set_rx_mode_async is documented in include/linux/netdevice.h as
returning 0 on success and a negative errno to request a core retry, and
netif_rx_mode_run() in net/core/dev_addr_lists.c treats 0 as installed:

	if (err)
		netif_rx_mode_schedule_retry(dev);
	else
		dev->rx_mode_retry_count = 0;

Reporting 0 for a rejected or partially applied configuration means the core
and userspace believe the filter is in hardware with no diagnostic emitted.
The -EOPNOTSUPP case looks similar: a PF or firmware that does not implement
the MAC filter message class returns it, and the VF would then report
success with nothing programmed.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
