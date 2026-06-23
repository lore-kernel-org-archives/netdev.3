Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EC2FE56F
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232329; cv=none; b=s6a2QPQWSUFN/9pP3U+lUnom8bXC6NiWFE31MA6UsjIOKEbW5PN9LfxxL3QXa+0msyFMTULYFFVa6jJ8mDIUQbsJT9vFJSici1jnX/y53JVDgnLSgH8KYNPZl2+R6TONyp+G3SIFKULNgHtQIZf5Wd8+nQ4tIj5qFT0woUSFtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232329; c=relaxed/simple;
	bh=2hoOTGjT0iOQEx/Exz7wfNTSkopKbeI5LcaOoft3HlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q76XT+NpoYhKzrPxrFKVNYd9G9ubn1SgCxRi+JudfGLfTHaV+FnEkcq28PyNo3L09bM8Rmf9zWkfFQjAhOwyakKCujvmD3m/gD73izXjCZS+ne2+r19N7jp+yDutWwkC04zjFfFXjcEjYDTpq9TfUfrdEIhU+Ea02ASi64rgtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/xrgy4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/xrgy4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71DC1F000E9;
	Tue, 23 Jun 2026 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782232327;
	bh=i7bK2o123A8aeZ5xml42QPCcD4YBHCD5Xw0/ew1PkOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/xrgy4tI1a22XJ+TlGBTIqFxiKR+51mQM4paIBRUM/nkTuqX/oUxFG2UPwi1lX88
	 es28PTGVYLC6Iw0o2qVnlKpfFiydOPcTt2p9kHJXw9cLjq/3Q0KyAsHYXG9iwwwZ5b
	 2sGC9arf/1oAHRdsXnCbX3oESK+XvKZMQGt9RqtHsU4uM1Klz3RUkAS7y8kuqV40dq
	 awjCLPxDtQ0jK7N0aUtSGXOEezAvI+55Gx2CJnqUC5wlcf6ZYUz4dm+eWVPK/95MYR
	 /2fF5V0jzMIh6Gz7p5Uz73E67//NWDeXJNnKe+UsGHdIAL7B8AVWvNOT4TqEF7vmQ/
	 6+3kG66sUISVw==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net v2 2/2] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Tue, 23 Jun 2026 17:25:56 +0100
Message-ID: <20260623162556.1100516-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622113428.2565255-3-poros@redhat.com>
References: <20260622113428.2565255-3-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: preserve uplink DFLT Rx rule on switchdev release

This commit preserves the default Rx rule on the uplink VSI when releasing
the switchdev environment if the interface is in promiscuous mode. This
prevents the catch-all rule from being removed while the netdev flags still
request promiscuity.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f7..48273ef9f69dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
[ ... ]
> @@ -278,8 +280,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
>  	vlan_ops->ena_rx_filtering(uplink_vsi);

[Severity: High]
Could this lockless read of netdev->flags cause a regression due to a TOCTOU
race?

The ena_rx_filtering() call eventually reaches ice_cfg_vlan_pruning(),
which reads uplink_vsi->netdev->flags & IFF_PROMISC locklessly to decide
whether to enable VLAN pruning.

>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +
> +	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
> +	 * the session. Test the live netdev->flags, the same value
> +	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
> +	 * on, so the preserved DFLT rule and the pruning state stay consistent.
> +	 */
> +	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))

... and then the exact same flags are read locklessly again right here.

Because setup/teardown paths are protected by devl_lock rather than
rtnl_lock, could a concurrent dev_change_flags() holding rtnl_lock toggle
IFF_PROMISC between the two checks?

If IFF_PROMISC changes from 0 to 1 in this window, the code would incorrectly
enable VLAN pruning (seeing 0) and then incorrectly retain the DFLT_RX rule
(seeing 1), leaving the hardware with VLAN pruning enabled during promiscuous
mode.

[Severity: High]
Does preserving the Rx DFLT rule here cause a regression by permanently
breaking multicast promiscuity configuration if IFF_PROMISC was set?

During the switchdev session, ice_remove_vsi_fltr() removes the
ICE_SW_LKUP_PROMISC rules. By manually preserving the DFLT rule here, any
future synchronization via ice_vsi_sync_fltr() will evaluate
!ice_is_dflt_vsi_in_use(vsi->port_info) as false:

ice_main.c:ice_vsi_sync_fltr() {
    ...
    if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
        err = ice_set_dflt_vsi(vsi);
        ...
        err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
    }
    ...
}

Because it is skipped, ICE_MCAST_PROMISC_BITS is never configured, leaving
the VSI in unicast promiscuous mode but silently dropping multicast traffic
destined for other MAC addresses.

> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
> +
>  	ice_fltr_add_mac_and_broadcast(uplink_vsi,
>  				       uplink_vsi->port_info->mac.perm_addr,
>  				       ICE_FWD_TO_VSI);

[Severity: High]
This is a pre-existing issue, but does this teardown function fail to
synchronize hardware state for previously joined multicast groups and
secondary unicast addresses?

When entering switchdev mode, __dev_uc_unsync() and __dev_mc_unsync() clear
the synchronization state of OS-level MAC addresses, and
ice_remove_vsi_fltr() removes the actual hardware filters. While switchdev
runs, calls to ndo_set_rx_mode return early and do not update hardware.

When returning to legacy mode, this function restores only the primary MAC
and broadcast addresses, but doesn't seem to invoke netif_set_rx_mode() or
equivalent to resynchronize the deferred Rx filters from the netdev to the
hardware. Could this cause the hardware to silently drop packets for
previously joined groups until the interface is bounced?
