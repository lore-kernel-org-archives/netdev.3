Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B74B922B;
	Sun, 18 Oct 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329766; cv=none; b=tSX173ry4c2H5EA25hij4PiEqJr7JFaP1SL7fOfidi5CV5i8IWJ+dfa9ogwSaK+VCkKYBJyAeuzh858gLApB8ENhC2TiQLNH2345Y/2VfeLEGJVIpEgc+Uc/Zv+qIGYJYemcDvbT1Ii7tr8DxA1bK0TxgP8xI6SsQSjRf1Esg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329766; c=relaxed/simple;
	bh=gunYXhMgXi7MLNMHlFRFz2mnouvhmJrc0MgovruqE1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZumpXmaTJYz+Nna/HSml1gBUWEsZ8kphnf456U7i3+Yvl5FQrFgSynSxiDdAxJYk9hy5XOvuClievOqu0rb4oyUDpgvTce5Q+MtZJjYYo7z6PaGK9jKtWk8YdgutKTK0GmiMb/zGWpNVFDg6pt9tpTCxjus6rAhanjtDOEaBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlT9KRSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlT9KRSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8A1F000C5;
	Sun, 18 Oct 2026 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792329765;
	bh=bIhmGgP6JX0siOj43IOXZbqUl5ehqxSn567CsQnQ89k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YlT9KRSo9Zg5akI9fzhj4zleDgVq7S0MOwhufb1dzp73NPwsqGoZmJsP/wyrMyIrL
	 CUAYI2UvF/gqA9szQqp3cCTwfJz/CZypkQuHH4vbx/0TxNFkKO3MQrmQCh/av11ldU
	 YNKVG874alDAbp9CMkZ6kqNI2B8EeOOd0QDAumBKyRPwJrogfxW4C8D82hszABDzRp
	 8T3+awUuMwXvVPscQA3XvBvM0wi5JXKWMM6Dih7gQSjt3QrJ5lKqrUWZR7EBrjXtYD
	 vd36KwwBPpuXkR3KM/yOjUHfGJHb+dN0eHvnIlp1EdP/SaDDkBO608qENtr/yaCD2Y
	 OfBqQyIsjdmlQ==
Subject: Re: [PATCH net 1/2] net: ti: icssg-prueth: fix missing port config on
 second interface open
From: netdev-bot+sashiko@kernel.org
To: r-kumar12@ti.com
Cc: netdev@vger.kernel.org, danishanwar@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 m-malladi@ti.com, vadim.fedorenko@linux.dev, haokexin@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 j-rameshbabu@ti.com, aaron.richard@ti.com, l-chinnannavar@ti.com,
 m-santhoshkadavan@ti.com, k-tiwari1@ti.com, a-dev@ti.com, pratheesh@ti.com
Date: Sun, 18 Oct 2026 13:22:43 +0000
Message-ID: <179232976393.3135.17319859444858468389@kernel.org>
In-Reply-To: <20261014125948.230571-2-r-kumar12@ti.com>
References: <20261014125948.230571-2-r-kumar12@ti.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Reopening one port while its sibling stays up now resets that
  port's live VLAN configuration to the driver defaults.

Pre-existing issues:
- [Low] The two join paths set emac->port_vlan differently.

--

net: ti: icssg-prueth: fix missing port config on second interface open

This commit moves the per-port FDB, VLAN table, PVID and VLAN-aware setup
out of icssg_enable_fw_offload() into a new icssg_enable_fw_offload_emac().
It also moves the HSR Rx offload setup into icssg_update_hsr_rx_offload().
emac_ndo_open() now calls both helpers unconditionally for the opening
port, and icssg_enable_fw_offload() is kept for icssg_change_mode().

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..cd4c918fe2b89 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -206,6 +206,44 @@ static void prueth_emac_stop(struct prueth *prueth)

[ ... ]

> +static void icssg_enable_fw_offload_emac(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode) {
> +		icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
> +				  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
> +				  ICSSG_FDB_ENTRY_BLOCK,
> +				  true);
> +		icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
> +				  BIT(emac->port_id) | DEFAULT_PORT_MASK,
> +				  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
> +				  true);
> +		if (prueth->is_hsr_offload_mode)
> +			icssg_vtbl_modify(emac, DEFAULT_VID,
> +					  DEFAULT_PORT_MASK,
> +					  DEFAULT_UNTAG_MASK, true);
> +		icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);

[Severity: Low]
This isn't a bug introduced by this patch, but is emac->port_vlan set
for both ports in switch mode?

In prueth_netdevice_port_link(), only the port whose join completes
br_members gets port_vlan set:

	if (!prueth->is_switch_mode) {
		if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
			prueth->is_switch_mode = true;
			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
			emac->port_vlan = prueth->default_vlan;
			icssg_change_mode(prueth);
		}
	}

prueth_hsr_port_link() sets it on both emac0 and emac1.

This means the port that joined the bridge first keeps port_vlan == 0.
icssg_set_pvid() here then programs PVID 0 for that port and PVID 1 for
the other one. Both ports still get VID 1 table membership, because
0 | DEFAULT_VID == 1.

The unlink paths have the same asymmetry. The switch unlink path resets
port_vlan on one emac, while the HSR unlink path resets both.

icssg_change_mode()->icssg_enable_fw_offload() already behaved this way
before this patch. This patch adds another call site that applies the
value.

A concrete forwarding failure from this hasn't been shown. With 8021q
loaded, NETDEV_UP already sets PVID 0 via ndo_vlan_rx_add_vid(0). How the
firmware handles PVID 0 is not known.

Should prueth_netdevice_port_link() set port_vlan on both ports, the
same way the HSR path does?

> +		if (prueth->is_switch_mode)
> +			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
> +	}
> +}

[ ... ]

> @@ -1067,8 +1082,9 @@ static int emac_ndo_open(struct net_device *ndev)
>  		ret = prueth_emac_common_start(prueth);
>  		if (ret)
>  			goto free_rx_irq;
> -		icssg_enable_fw_offload(prueth);
>  	}
> +	icssg_update_hsr_rx_offload(emac);
> +	icssg_enable_fw_offload_emac(emac);

[Severity: Medium]
Can this reset a port's live VLAN configuration when the port is
reopened while its sibling stays up?

When the sibling is up, emac_ndo_stop() does not stop the firmware and
does not remove any FDB, VLAN or PVID state:

	/* stop PRUs */
	if (prueth->emacs_initialized == 1)
		prueth_emac_common_stop(prueth);

The next open also skips prueth_emac_common_start(). So the shared-RAM
VLAN table and the per-port PVID word still hold whatever the bridge or
8021q programmed. icssg_enable_fw_offload_emac() then runs:

	icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
			  BIT(emac->port_id) | DEFAULT_PORT_MASK,
			  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
			  true);
	...
	icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);

This adds the port back to VID 1 with untagged egress, and overwrites the
PVID with emac->port_vlan.

emac->port_vlan is only ever 0 or the mode default. The runtime VLAN
paths write the hardware directly and never update it:

prueth_switchdev_vlan_add()
	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
	icssg_set_pvid(emac->prueth, vid, emac->port_id);

prueth_switchdev_vlan_del()
	icssg_vtbl_modify(emac, vid, port_mask, 0, false);

emac_ndo_vlan_rx_add_vid()
	icssg_set_pvid(emac->prueth, vid, emac->port_id);

For example, on an offloaded bridge, the admin runs "bridge vlan del dev
eth1 vid 1" or makes VID 1 tagged on eth1. Then "ip link set eth1 down;
ip link set eth1 up" runs while eth2 is still up. In hardware, eth1 ends
up as an untagged member of VID 1 again. The software bridge still shows
the old configuration, and nothing replays the switchdev VLAN objects on
NETDEV_UP.

Without 8021q, a bridge-configured PVID such as "bridge vlan add dev eth1
vid 10 pvid untagged" is also replaced, with 1 or with 0 for the port
that joined the bridge first. With 8021q loaded, its NETDEV_UP handler
already sets PVID 0 through ndo_vlan_rx_add_vid(0) on every up, both
before and after this patch.

Before this patch, none of this ran on a single-port reopen, so VLAN
membership and tagging survived it. The later commit in the series, "net:
ti: icssg-prueth: re-apply rx_mode state after firmware reboot", only
adds rx_mode_work scheduling in prueth_emac_common_start(). It does not
change icssg_enable_fw_offload_emac() or the open path.

The commit message also says:

    If one port is later brought down and up while the sibling stays up,
    emacs_initialized is still non-zero, so the function never runs again
    and the port is left unconfigured, depending on bring-up order.

Is that accurate? emac_ndo_stop() never removes the port's FDB, VLAN or
PVID state, so a port configured at first open stays configured. Only
the port opened second seems to have been missing its configuration.

Should the open path avoid overwriting state that the firmware still
holds while the sibling port is running?

>  
>  	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
>  	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014125948.230571-1-r-kumar12%40ti.com
