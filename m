Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38D399352;
	Fri,  9 Oct 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517423; cv=none; b=bfddqAX2ZyHqc9sudFctAw9ZFLxQW/IPeIZlYuEQLk2VlJhWuNLgwbCoR4tOzB2+YQdvPFl2FJNAYz83whmfv8+YNaExxsENABIMQS0iHZxNEk80HPBE0duDgyvHgF/SnZqEJXtAwoAN6Ydey+xvdMyAdCdOtpXRIk1/6a1u22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517423; c=relaxed/simple;
	bh=KXgw8a8Pfzu97PvjyS4nxcm6n0ZTMVN7skMRhnxAbuA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3UNwRFNNSmlf+9CY003qZWfpKKUkH0dwHvnQccyjq/0OojOiNkGayOv5+vQUxFQKRKJTJz67UL/kbGsT68DQ8ze3IwaGOk0cyxWOT5EY+fWMC/dx9Z7oBiCG/oCi1tJe1PXRm/rqzO0DV7h1okg4BJiu+jMTZBfPbc1VYJ85pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AthrvJvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AthrvJvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22D21F000FF;
	Fri,  9 Oct 2026 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517413;
	bh=y1gGbxm0FMIHr5xgZMcozDYrOzb1ITiOJ0lncOO/azM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AthrvJvNVQKB15Wdw7ujaz0HsMMVspae8wOKM1Zrv7cjm2k/jdwzTd91nGO3CKv5l
	 loh7T9pv3E+5PTwdiL0xFQ+DC4YGM0IJLLHYEX9YJlx03yMCdp8Fk8WWzhgcadY9uk
	 QxKbHajNlM1eWSK7UCrnuH3meQ1NmygBr4yRI2aSoA+1GpbXWDwfnSAIjzt/77EbnK
	 7FXhGE66JTkR6LK9PcGdfbdq6fzuiuonF866oVERQoPR81zrDWzMeenhzHz3wNVmkk
	 JcXzCmkoMuJKlUre//Vtcik6SBoz0P8ruuQdwfR2+J4XT9kYPWvtQLlDawFE1C8v+7
	 EoRNlmXezarTA==
Subject: Re: [PATCH net-next v5 1/3] net: ti: icssm-prueth: Add HSR and PRP HW
 offload mode support for AM57xx, AM437x and AM335x
From: netdev-bot+sashiko@kernel.org
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, afd@ti.com, vadim.fedorenko@linux.dev, haokexin@gmail.com,
 basharath@couthit.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com
Date: Fri, 09 Oct 2026 03:43:31 +0000
Message-ID: <179151741150.434549.7819199497598747618@kernel.org>
In-Reply-To: <20261005154654.576663-2-parvathi@couthit.com>
References: <20261005154654.576663-2-parvathi@couthit.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 7 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When icssm_prueth_change_mode() fails partway,
  icssm_prueth_hsr_port_link() (free_hsr) and…
- [Medium] icssm_prueth_hsr_port_link()
  (drivers/net/ethernet/ti/icssm/icssm_prueth.c) records an HSR/PRP…
- [Medium] In LRE mode,
  icssm_emac_mc_filter_ctrl/reset/hashmask/bin_update all redirect `ram`…
- [Medium] icssm_prueth_ndev_event() returns NOTIFY_DONE unless
  icssm_prueth_sw_port_dev_check(ndev) passes.
- [Medium] icssm_prueth_lre_protocol_init() always writes
  ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_HIGH (0x4E1501) and _LOW (0x1) to…
- [Medium] icssm_emac_ndo_fix_features() depends on the current
  ndev->features, not just on the requested set.
- [Medium] icssm_prueth_lre_timer() calls hrtimer_forward_now() and
  returns early unless `prueth->emac_configured == BIT(MII0)|BIT(MII1)`.
- [Medium] Mode changes are not synchronised with multicast-filter
  programming.
- [Low] The patch changes behaviour in every mode without saying so in
  the commit message.
- [Low] Two in-tree descriptions of the PCP-to-queue map size disagree.
- [Low] In icssm_prueth_hsr_port_link(), the comment on the hsr_dev
  mismatch check says "Adding the port to a second bridge is not…
- [Low] icssm_prueth_lre_timer() runs in hardirq context and reads
  prueth->emac_configured with a plain load to decide whether to…

Pre-existing issues:
- [High] icssm_prueth_change_mode() calls ndo_stop()/ndo_open() directly
  and never calls dev_close().

--

net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x

This patch extends the ICSSM PRUETH driver to support the HSR and PRP
offload firmware on AM335x, AM437x and AM57xx. The firmware is switched
when both ports join an hsr/prp master with hsr-fwd and hsr-tag-rm
offload enabled. The patch also adds LRE table initialisation, a
periodic duplicate-table check hrtimer, and a shared multicast filter
table for LRE mode.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index b7e94244355a3..453c9b259d77a 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -804,13 +855,12 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
>  			rd_buf_desc = readl(shared_ram + bd_rd_ptr);
>  			icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
>  
> -			if (pkt_info.length <= 0) {
> -				/* a packet length of zero will cause us to
> -				 * never move the read pointer ahead, locking
> -				 * the driver, so we manually have to move it
> -				 * to the write pointer, discarding all
> -				 * remaining packets in this queue. This should
> -				 * never happen.
> +			if (pkt_info.length < EMAC_MIN_PKTLEN) {
> +				/* if the packet is too small we skip it but we
> +				 * still need to move the read pointer ahead
> +				 * and assume something is wrong with the read
> +				 * pointer as the firmware should be filtering
> +				 * these packets
>  				 */
>  				update_rd_ptr = bd_wr_ptr;
>  				emac->stats.rx_length_errors++;

[Severity: Low]
This changes behaviour in every mode, not only HSR/PRP, and the commit
message doesn't mention it. In EMAC and switch mode too, any descriptor
that reports 1 to 59 bytes now takes this branch.

The new comment says "if the packet is too small we skip it". However,
update_rd_ptr = bd_wr_ptr still throws away everything left in the host
queue, which is what the old comment said. Could the comment say that the
remaining packets are dropped?

Also, emac_netdev_ops gains:

	.ndo_set_mac_address = eth_mac_addr,
	.ndo_validate_addr = eth_validate_addr,

This allows MAC address changes in dual-EMAC and switch modes as well.
Should these two changes be mentioned in the commit message, or split
into separate patches?

[ ... ]

> @@ -1122,7 +1184,8 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>  		}
>  	}
>  
> -	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
> +	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH ||
> +	    mode == PRUSS_ETHTYPE_HSR || mode == PRUSS_ETHTYPE_PRP) {
>  		prueth->eth_type = mode;
>  	} else {
>  		dev_err(prueth->dev, "unknown mode\n");

[Severity: High]
This isn't a bug introduced by this patch, but icssm_prueth_change_mode()
calls ndo_stop()/ndo_open() directly instead of dev_close()/dev_open().
The new HSR/PRP notifier callers make its failure path much easier to
reach.

ndo_open() can fail here, for example when ti-pruss/*-pruhsr-fw.elf or
*-pruprp-fw.elf is not installed and icssm_prueth_sw_boot_prus() fails.
change_mode() then just returns:

		ret = ndev->netdev_ops->ndo_open(ndev);
		if (ret < 0) {
			netdev_err(ndev, "failed to start: %d", ret);
			return ret;
		}

The netdev stays IFF_UP and netif_running(), even though the earlier
ndo_stop() already tore down its IRQs, NAPI, rproc and IEP.
icssm_prueth_hsr_port_link() then restores eth_type to EMAC.

A later "ip link set ethX down", or unregister_netdev() from
icssm_prueth_remove(), calls ndo_stop() a second time. Would that call
napi_disable(&emac->napi) on a NAPI that is already disabled, and block
forever with RTNL held?

It also looks like free_irq() would run on an IRQ that was already freed,
and rproc_shutdown()/icss_iep_exit() would run twice.

[ ... ]

> @@ -1289,7 +1357,10 @@ static void icssm_emac_mc_filter_reset(struct prueth_emac *emac)
>  	void __iomem *ram;
>  
>  	ram = prueth->mem[emac->dram].va;
> -	mc_filter_tbl_base = ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
> +	if (prueth_is_lre(prueth))
> +		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
> +
> +	mc_filter_tbl_base = prueth->fw_offsets.mc_filter_tbl;
>  
>  	mc_filter_tbl = ram + mc_filter_tbl_base;
>  	memset_io(mc_filter_tbl, 0, ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES);

[Severity: Medium]
In LRE mode all four mc filter helpers now use the same DRAM1 table, so
both slave ports program one physical filter. However,
icssm_emac_ndo_set_rx_mode() still runs per netdev. It disables the
filter, clears the whole shared table here, and refills it from the mc
list and IFF_ALLMULTI flag of the calling ndev only.

Doesn't that mean the port that ran set_rx_mode last decides the hardware
filter? Some memberships exist on only one slave, for example ptp4l or
lldpd packet-socket memberships, or "ip maddr add dev eth2". Those, and
that slave's allmulti state, would be wiped when the other slave's
rx_mode runs.

Also, icssm_emac_ndo_set_rx_mode() programs promiscuous mode only inside
if (PRUETH_IS_EMAC(prueth)). A promiscuous slave in HSR/PRP mode would
still have the hashed multicast filter enabled in firmware.

The new prueth->addr_lock serialises the writes, but it doesn't merge
the state requested by the two ports.

> @@ -1302,11 +1373,16 @@ static void icssm_emac_mc_filter_hashmask

[ ... ]

> @@ -1371,8 +1454,13 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
>  	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
>  	reg = readl(sram + EMAC_PROMISCUOUS_MODE_OFFSET);
>  
> +	if (prueth_is_lre(prueth))
> +		mc_filter_tbl_lock = &prueth->addr_lock;
> +	else
> +		mc_filter_tbl_lock = &emac->addr_lock;
> +
>  	/* It is a shared table. So lock the access */
> -	spin_lock_irqsave(&emac->addr_lock, flags);
> +	spin_lock_irqsave(mc_filter_tbl_lock, flags);

[Severity: Medium]
Does this lock choice stay valid if the mode changes at the same time?
The lock is chosen from an unlocked read of eth_type. Each mc filter
helper then reads prueth_is_lre() and prueth->fw_offsets again on its
own.

icssm_prueth_change_mode() writes prueth->eth_type, and
icssm_prueth_set_fw_offsets() (called from ndo_open) rewrites the three
offset fields. Neither takes either addr_lock, and the netdevs stay
IFF_UP throughout.

Could a concurrent set_rx_mode program the shared DRAM1 table under a
different lock than its peer? Could it combine the LRE DRAM1 selection
with stale EMAC offsets?

change_mode() also bypasses dev_open(), so it looks like the multicast
filter isn't reprogrammed after the new firmware starts.

[ ... ]

> @@ -1429,15 +1517,109 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)

[ ... ]

> +static netdev_features_t icssm_emac_ndo_fix_features(struct net_device *ndev,
> +						     netdev_features_t features)
> +{
> +	/* hsr tag removal offload and hsr fwd offload are tightly coupled in
> +	 * firmware implementation. Both these features need to be enabled /
> +	 * disabled together.
> +	 */
> +	if (!(ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES))
> +		if ((features & NETIF_F_HW_HSR_FWD) ||
> +		    (features & NETIF_F_HW_HSR_TAG_RM))
> +			features |= NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
> +
> +	if ((ndev->features & NETIF_F_HW_HSR_FWD) ||
> +	    (ndev->features & NETIF_F_HW_HSR_TAG_RM))
> +		if (!(features & NETIF_F_HW_HSR_FWD) ||
> +		    !(features & NETIF_F_HW_HSR_TAG_RM))
> +			features &= ~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
> +
> +	return features;
> +}

[Severity: Medium]
Can this coupling turn the offload back off on a later feature update?
The result depends on the current ndev->features. ethnl_set_features()
stores only the bits the user requested in wanted_features, and
__netdev_update_features() recomputes from wanted_features every time.

For example, "ethtool -K eth2 hsr-tag-rm-offload on" on its own turns
both bits on, because ndev->features had neither. But wanted_features
holds only TAG_RM. On the next recalculation both bits are active and
FWD is missing from the request, so both get cleared.

When the port is enslaved, dev_disable_lro() in hsr_portdev_setup()
calls netdev_update_features(). That would run into this case, get
-EBUSY from icssm_emac_ndo_set_features(), and log "set_features()
failed". After the hsr device is removed, any unrelated feature update
would silently turn the offload off.

The same applies once hsr-dup-offload is added to
NETIF_PRUETH_LRE_OFFLOAD_FEATURES later in the series. The documented
sequence (tag-rm on, then fwd on) never requests dup, so the offload
would end up off.

[ ... ]

> @@ -1741,6 +1926,109 @@ static int icssm_prueth_ndev_port_unlink(struct net_device *ndev)
>  	return ret;
>  }
>  
> +static int icssm_prueth_hsr_port_link(struct net_device *ndev,
> +				      struct net_device *hsr_ndev)
> +{

[ ... ]

> +	spin_lock_irqsave(&prueth->addr_lock, flags);
> +
> +	if (!prueth->hsr_members) {
> +		prueth->hsr_dev = hsr_ndev;
> +	} else {
> +		/* Adding the port to a second bridge is not supported */

[Severity: Low]
This isn't a bug, but the comment says "bridge" while the check compares
HSR/PRP master devices. It looks copied from
icssm_prueth_ndev_port_link().

> +		if (prueth->hsr_dev != hsr_ndev) {
> +			spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	prueth->hsr_members |= BIT(emac->port_id);
> +
> +	spin_unlock_irqrestore(&prueth->addr_lock, flags);
> +
> +	if (!prueth_is_lre(prueth) && prueth->hsr_members == all_slaves) {
> +		prev_mode = prueth->eth_type;
> +		ret = icssm_prueth_change_mode(prueth, mode);

[Severity: Medium]
What happens when only one port of this prueth instance becomes an
offloaded hsr slave? The firmware is switched only when both local
ports are members. Otherwise this returns 0 and dual-EMAC firmware keeps
running.

Two cases seem to lead there.

In the first case, only one port has hsr-fwd/tag-rm offload enabled.
icssm_emac_ndo_fix_features() and icssm_emac_ndo_set_features() don't
require the sibling to match. icssm_prueth_ndev_event() records
membership only for the offloaded port. The hsr core still stops
software forwarding towards that port, based on that port's own feature
bit:

net/hsr/hsr_forward.c:hsr_drop_frame() {
    ...
	if (port->dev->features & NETIF_F_HW_HSR_FWD)
		return prp_is_lan_dup(frame->port_rcv->type, port);
    ...
}

Once hsr-dup-offload is advertised, hsr_forward_do() would also skip the
second copy for that port.

In the second case, the two hsr slaves come from different ICSS
instances (AM57xx has two PRU-ICSS with two ports each). Each prueth
records one membership bit and stays in EMAC mode. hsr_dev_finalize()
still sets fwd_offloaded:

net/hsr/hsr_device.c:hsr_dev_finalize() {
    ...
	if ((slave[0]->features & NETIF_F_HW_HSR_FWD) &&
	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
		hsr->fwd_offloaded = true;
    ...
}

As a result, promiscuous mode is skipped and software forwarding is
suppressed.

In both cases, wouldn't neither software nor firmware forward (or
duplicate) transit frames, while the link reports success?

> +		if (ret < 0) {
> +			dev_err(prueth->dev, "Failed to enable %s mode\n",
> +				(mode == PRUSS_ETHTYPE_HSR) ?
> +				"HSR" : "PRP");
> +			goto free_hsr;
> +		} else {

[ ... ]

> +	return 0;
> +
> +free_hsr:
> +	prueth->eth_type = prev_mode;

[Severity: High]
Is restoring only eth_type enough here? icssm_prueth_change_mode()
returns on the first failed ndo_open() and doesn't unwind the ports it
already reopened.

Take this sequence:

- Port 0 reopens in LRE mode.
- icssm_prueth_lre_config() calls hrtimer_setup()/hrtimer_start() on
  tbl_check_timer.
- Both PRUs boot the LRE firmware and the shared hpq/lpq NAPIs are
  enabled.
- Port 1's ndo_open() fails, and eth_type goes back to EMAC.

A later ndo_stop() on port 0 chooses its teardown from the current
eth_type, so it would take the EMAC path:

- napi_disable(&emac->napi) on a NAPI that was never enabled in LRE
  mode, which waits forever on NAPI_STATE_SCHED.
- free_irq() on an rx_irq that was never requested.
- rproc_shutdown() of PRU0 only.

It would also skip this cleanup in icssm_emac_ndo_stop():

	if (prueth_is_lre(prueth) && !prueth->emac_configured)
		icssm_prueth_lre_cleanup(prueth);

so the 10 ms tbl_check_timer keeps re-arming. icssm_prueth_remove()
doesn't call hrtimer_cancel(&prueth->tbl_check_timer) unconditionally.
Can the callback then run after the devm-allocated prueth is freed?

Re-entering LRE mode would also call hrtimer_setup() on a timer that is
still queued. icssm_prueth_lre_config() calls it before the
hrtimer_active() check in icssm_prueth_lre_start_timer().

icssm_prueth_hsr_port_unlink() does the same enum-only rollback in the
other direction.

[ ... ]

> @@ -1754,6 +2042,17 @@ static int icssm_prueth_ndev_event(struct notifier_block *unused,
>  	switch (event) {
>  	case NETDEV_CHANGEUPPER:
>  		info = ptr;
> +		if (is_hsr_master(info->upper_dev)) {
> +			if (info->linking) {
> +				if (ndev->features &
> +				    NETIF_PRUETH_LRE_OFFLOAD_FEATURES)
> +					ret = icssm_prueth_hsr_port_link
> +						(ndev, info->upper_dev);
> +			} else {
> +				ret = icssm_prueth_hsr_port_unlink(ndev);
> +			}
> +		}

[Severity: Medium]
Can these HSR events be missed? Earlier in this function there is:

	if (!icssm_prueth_sw_port_dev_check(ndev))
		return NOTIFY_DONE;

icssm_prueth_sw_port_dev_check() requires NETIF_F_HW_L2FW_DOFFLOAD. That
bit is in hw_features on all three platforms, and "ethtool -K ethX
l2-fwd-offload off" clears it. icssm_emac_ndo_set_features() rejects
changes to the LRE bits only, so clearing it is allowed even while the
port is an hsr slave.

Suppose l2-fwd-offload is off and hsr-fwd/tag-rm are on for both ports.
hsr_dev_finalize() sets fwd_offloaded, but icssm_prueth_hsr_port_link()
is never called, so the PRUs keep running dual-EMAC firmware.

Now suppose l2-fwd-offload is cleared on one slave while HSR is active.
When hsr0 is deleted, that slave's unlink event is dropped. hsr_members
keeps its bit, the firmware stays in HSR/PRP mode with no hsr master, and
prueth->hsr_dev keeps a stale pointer. Every later hsr link would then
fail with -EOPNOTSUPP.

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
> new file mode 100644
> index 0000000000000..6276dd1e8bb1b
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c

[ ... ]

> +/* A group of PCPs are mapped to a Queue. This is the size of firmware
> + * array in shared memory
> + */
> +#define PCP_GROUP_TO_QUEUE_MAP_SIZE	4

[Severity: Low]
This doesn't match the description in icssm_lre_firmware.h:

/* 8 bytes of VLAN PCP to RX QUEUE MAPPING */
#define ICSS_LRE_QUEUE_2_PCP_MAP_OFFSET		0x124

icssm_prueth_lre_pcp_queue_map_config() copies only 4 bytes. Is the
header comment wrong, or do the other 4 bytes keep whatever the previous
firmware left there?

[ ... ]

> +static void icssm_prueth_lre_protocol_init(struct prueth *prueth)
> +{
> +	void __iomem *dram0 = prueth->mem[PRUETH_MEM_DRAM0].va;
> +	void __iomem *dram1 = prueth->mem[PRUETH_MEM_DRAM1].va;
> +
> +	if (PRUETH_IS_HSR(prueth))
> +		writew(ICSS_LRE_MODEH, dram0 + ICSS_LRE_HSR_MODE_OFFSET);
> +
> +	writel(ICSS_LRE_DUPLICATE_FORGET_TIME_400_MS,
> +	       dram1 + ICSS_LRE_DUPLI_FORGET_TIME);
> +	writel(ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_HIGH,
> +	       dram1 + ICSS_LRE_SUP_ADDR);
> +	writel(ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_LOW,
> +	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
> +}

[Severity: Medium]
Does this supervision address match the one the hsr device uses? These
fixed constants program 01:15:4E:00:01:00. The hsr core sets the last
byte from the user's configuration:

net/hsr/hsr_device.c:hsr_dev_finalize() {
    ...
	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
    ...
}

With "supervision 45" from the commit message example, the address on
the wire is 01:15:4E:00:01:2D. icssm_prueth_hsr_port_link() reads only
the protocol version from hsr_ndev and never reprograms
ICSS_LRE_SUP_ADDR.

With fwd offload enabled:

- the slaves aren't put in promiscuous mode,
- the hsr core doesn't dev_mc_add() the supervision address on them,
- the hashed multicast filter is enabled in LRE mode.

Would supervision frames sent to the configured address then be neither
recognised by the firmware nor accepted by the filter?

> +static enum hrtimer_restart icssm_prueth_lre_timer(struct hrtimer *timer)
> +{

[ ... ]

> +	hrtimer_forward_now(timer, ms_to_ktime(timeout));
> +	if (prueth->emac_configured !=
> +	    (BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1)))
> +		return HRTIMER_RESTART;

[Severity: Medium]
Should the table check stop when only one port is down?
icssm_prueth_lre_config_check_flags() writes
ICSS_LRE_HOST_TIMER_CHECK_FLAGS only once, when the first port opens.
icssm_prueth_sw_shutdown_prus() keeps both PRUs running while any port is
configured.

So while one slave is administratively down, the firmware keeps handling
frames on the other port but no longer gets the periodic duplicate/port
table check requests.

If the firmware clears these flags after each check, as the 10 ms
refresh suggests, wouldn't duplicate-table aging
(ICSS_LRE_DUPLI_FORGET_TIME) stop in the single-link state that HSR/PRP
is designed to survive?

[Severity: Low]
This reads prueth->emac_configured in hardirq context with a plain load.
icssm_emac_ndo_open() and icssm_emac_ndo_stop() update the same field
with non-atomic |= and &= under RTNL. There is no lock and no
READ_ONCE()/WRITE_ONCE().

The timer can therefore see both ports as configured just before
ndo_stop() clears a bit, and write DRAM1 while the PRUs are being shut
down. Is that intended?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005154654.576663-1-parvathi%40couthit.com
