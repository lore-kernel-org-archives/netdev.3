Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75A41E6DB;
	Sat,  8 Aug 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218523; cv=none; b=hqW9d5/BsYzaFu9vjo0oauL4Zc+KlC+4l8blmiekhD6ayymflanw5SYbl56pX1xiz4Ar1G4KvSTEUBW4hEZjB/Tjt1lD25wSducVDqiIGWf4L6lLiSMvyZyhCTUT78RvcDmMg48kMlTfVCKxjVHLnK/QWY137hZVcYyCSoDTuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218523; c=relaxed/simple;
	bh=q4pOwfmFTrzXbmPjoxui5l41xc+Dd+sig9fZrOlNHH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV94wEOWHpTk3tweR0hf3rxfmpXJpP3RR7gEmILw7OSXd0l4nUMT5Hu+e8wKisV0bThKGQ/tRu/EvyvU62CFuPKr8bm+hMaSFYkd1HnYyhGYyFHPS3TaINncOKo05F6xrkFARb6L2ryBZy9ituocpKSls8y/KR6BJ0vmXfMFgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlOxowtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlOxowtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2E91F000E9;
	Sat,  8 Aug 2026 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218520;
	bh=fe+d7V0Gwd5vaQVPo5oPWMSQHgmJs6bKTDmsscoMXcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlOxowtTK5VwxuTFU+KpoTVNn/mpb5uLh5YVFbPtpfw0l/qwLDAe+CW5t2pn+Grdi
	 zL3gBvrO3BNmzpBSNgreEtAu2ApN6TOPzieNyEa7533/iNdpQOrx5DEFZdmBmgqD8Z
	 jrHn8Ttflp0+Ke8WrbQzuzasZt7W/vwZtnqo3EjbB20pR2Mi2i3eCqcNTdKTYNtYVr
	 nyS+NzmzA11KbSPFSuH0jK+k3/NJyJEmHVExKzK3qSnp/w54k/Zs7r8NRz6XViUa74
	 YKO33K6VlRHLyPgInXxHUCcpHm9NLLsk8wR3kqnQb+qxdwEX2nlC1YWTDxEJI2Qanb
	 DvWAemYbiNH0w==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 20/20] net: dsa: xilinx: trap link-local control frames to the CPU port
Date: Sat,  8 Aug 2026 12:48:39 -0700
Message-ID: <20260808194839.133603-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-21-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-21-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: trap link-local control frames to the CPU port

This adds CAM entries for the two bridge-group destination MACs in active
use (STP at 01:80:c2:00:00:00 and LLDP at 01:80:c2:00:00:0e) with a port
list containing only the CPU port and the endpoint management-queue bit
set. The entries are kept in sync with each wire port's native VID via a
new shadow list in struct xlnx_tsn.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 7e5cf77cfa66..e35dbcdfcbda 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -694,6 +702,28 @@ static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
>  	return xlnx_tsn_cam_wait_done(sw);
>  }
>  
> +/* IEEE 802.1 bridge-group destination MACs. A bridge must consume
> + * these locally rather than relay them between ports. Each address
> + * gets a CAM trap entry pointing to the CPU port only. The CAM
> + * matches the destination MAC exactly, so only the addresses in
> + * active use are listed here.
> + */
> +static const u8 xlnx_tsn_ctrl_das[][ETH_ALEN] = {
> +	{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 }, /* STP / RSTP / MSTP */
> +	{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e }, /* LLDP */
> +};
> +
> +static bool xlnx_tsn_addr_is_ctrl_trap(const unsigned char *addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(xlnx_tsn_ctrl_das); i++)
> +		if (ether_addr_equal(addr, xlnx_tsn_ctrl_das[i]))
> +			return true;
> +
> +	return false;
> +}
> +
>  static void xlnx_tsn_port_fast_age(struct dsa_switch *ds, int port)
>  {
>  	struct xlnx_tsn *sw = ds->priv;
> @@ -712,6 +742,9 @@ static int xlnx_tsn_port_fdb_add(struct dsa_switch *ds, int port,
>  	u8 portlist;
>  	int ret;
>  
> +	if (xlnx_tsn_addr_is_ctrl_trap(addr))
> +		return 0;
> +

[Severity: Medium]
Do the three FDB ops now disagree about these two addresses?

xlnx_tsn_port_fdb_add() and xlnx_tsn_port_fdb_del() return 0 without
touching the CAM, so a request like:

    bridge fdb add 01:80:c2:00:00:00 dev swp1 master static

is accepted by br_fdb_add() (it only rejects the all-zero address),
notified to the driver through dsa_port_do_fdb_add() ->
ds->ops->port_fdb_add(), and reported as successfully offloaded although
nothing was programmed. The corresponding delete likewise returns success
while the trap entry stays in the CAM, so user space has no way to remove
it and gets no error.

xlnx_tsn_port_fdb_dump() has no matching filter - it walks the per-MAC
read-key region and reports every slot with TSN_CAM_FOUND set using
is_static = false:

    ctrl = sw_ior(sw, TSN_CAM_CTRL_OFFSET);
    if (!(ctrl & TSN_CAM_FOUND))
            continue;
    ...
    ret = cb(addr, vid, false, data);

If the trap entries land in a wire port's read-key region (the driver
already relies on that region for its own OP_ADD entries), they would be
dumped back as dynamic entries learnt on swp1/swp2, which contradicts what
add and del report.

Would it be better to either apply the same filter in the dump, or make
add/del return an error for these addresses instead of reporting success?

>  	if (!vid)
>  		vid = TSN_SW_DEFAULT_VID;
>  

[ ... ]

> @@ -733,6 +766,9 @@ static int xlnx_tsn_port_fdb_del(struct dsa_switch *ds, int port,
>  	u8 portlist;
>  	int ret;
>  
> +	if (xlnx_tsn_addr_is_ctrl_trap(addr))
> +		return 0;
> +
>  	if (!vid)
>  		vid = TSN_SW_DEFAULT_VID;
>  

[ ... ]

> @@ -936,12 +973,93 @@ static void xlnx_tsn_set_vlan_only_learning(struct xlnx_tsn *sw, bool on)
>  	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
>  }
>  
> +/* Install or remove link-local control-frame traps for one VID.
> + * Each entry points to the CPU port and marks frames as management
> + * traffic for delivery on the management queue. Caller holds
> + * indirect_lock.
> + */
> +static int xlnx_tsn_set_ctrl_traps(struct xlnx_tsn *sw, u16 vid, bool add)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(xlnx_tsn_ctrl_das); i++) {
> +		ret = xlnx_tsn_cam_write(sw, xlnx_tsn_ctrl_das[i], vid,
> +					 TSN_PORT_BIT(XLNX_TSN_CPU_PORT),
> +					 true, add);

[Severity: Medium]
Can this port list also catch the host's own transmitted control frames?

The host bridge sends BPDUs and LLDPDUs with exactly these destination
MACs. Those frames enter the fabric from the endpoint port and, when
untagged, are looked up under the CPU port's native VID. While the bridge
is VLAN-unaware xlnx_tsn_apply_pvid() keeps that at TSN_SW_DEFAULT_VID,
which is also the trap key installed here, so the frame matches the same
CAM entry - whose port list contains only TSN_PORT_BIT(XLNX_TSN_CPU_PORT)
and therefore neither wire port.

Whether the frame still egresses depends on the SA-egress selection
programmed in xlnx_tsn_setup():

    mgmt = sw_ior(sw, TSN_SW_MGMT_QUEUING_OFFSET);
    mgmt |= TSN_SW_MGMT_QUEUING_EP_SA_EGRESS;
    sw_iow(sw, TSN_SW_MGMT_QUEUING_OFFSET, mgmt);

taking precedence over a CAM hit. Is that precedence guaranteed by the IP?
Nothing in the driver or the register definitions states it. If the CAM
hit governs instead, the host's own BPDUs and LLDPDUs would be forwarded
only back to the ingress (CPU) port and dropped, which would disable STP
transmission entirely. Could this be confirmed against the switch IP
documentation, or the trap port list adjusted for endpoint ingress?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool xlnx_tsn_vid_in(const u16 *vids, int count, u16 vid)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		if (vids[i] == vid)
> +			return true;
> +
> +	return false;
> +}
> +

[ ... ]

> +static int xlnx_tsn_sync_ctrl_traps(struct xlnx_tsn *sw)
> +{
> +	u16 want[XLNX_TSN_NUM_PORTS - 1], vid;
> +	struct dsa_port *dp;
> +	int i, n, ret;
> +
> +	n = 0;
> +	dsa_switch_for_each_user_port(dp, &sw->ds) {
> +		vid = sw->vlan_aware ? sw->pvid[dp->index] : TSN_SW_DEFAULT_VID;
> +		if (!xlnx_tsn_vid_in(want, n, vid))
> +			want[n++] = vid;
> +	}
> +
> +	/* Remove traps at VIDs no longer used as any wire port's native VID. */
> +	i = 0;
> +	while (i < sw->ctrl_trap_count) {
> +		vid = sw->ctrl_trap_vid[i];
> +		if (xlnx_tsn_vid_in(want, n, vid)) {
> +			i++;
> +			continue;
> +		}
> +		ret = xlnx_tsn_set_ctrl_traps(sw, vid, false);
> +		if (ret)
> +			return ret;
> +
> +		sw->ctrl_trap_vid[i] = sw->ctrl_trap_vid[--sw->ctrl_trap_count];
> +	}
> +
> +	/* Add traps at native VIDs not yet installed. */
> +	for (i = 0; i < n; i++) {
> +		if (xlnx_tsn_vid_in(sw->ctrl_trap_vid, sw->ctrl_trap_count,
> +				    want[i]))
> +			continue;
> +		ret = xlnx_tsn_set_ctrl_traps(sw, want[i], true);
> +		if (ret)
> +			return ret;
> +
> +		sw->ctrl_trap_vid[sw->ctrl_trap_count++] = want[i];
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can the shadow list get permanently out of step with the CAM here?

xlnx_tsn_set_ctrl_traps() writes two entries and returns on the first
xlnx_tsn_cam_write() failure without unwinding the one it already
programmed, but this function treats it as all-or-nothing.

Removal direction: if the STP delete succeeds and the LLDP delete returns
-ETIMEDOUT from xlnx_tsn_cam_wait_ready()/xlnx_tsn_cam_wait_done(), the
early return happens before:

    sw->ctrl_trap_vid[i] = sw->ctrl_trap_vid[--sw->ctrl_trap_count];

so the VID stays recorded as installed although one of its entries is
gone. If that VID becomes a wanted native VID again, the removal loop
keeps it and the add loop skips it, because
xlnx_tsn_vid_in(sw->ctrl_trap_vid, ...) is true - the deleted STP trap is
never reinstalled and BPDUs at that VID are relayed to the peer wire port
again, with no error reported anywhere.

Add direction: if the STP add succeeds and the LLDP add fails, the return
happens before:

    sw->ctrl_trap_vid[sw->ctrl_trap_count++] = want[i];

so the installed entry is untracked, and xlnx_tsn_remove_ctrl_traps()
iterates only ctrl_trap_vid[0..ctrl_trap_count), so it can never delete
it.

Should xlnx_tsn_set_ctrl_traps() roll back the entries it already
programmed, or should the bookkeeping be updated per entry rather than per
VID?

>  static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
>  					bool vlan_filtering,
>  					struct netlink_ext_ack *extack)
>  {
>  	struct xlnx_tsn *sw = ds->priv;
>  	struct dsa_port *dp;
> +	bool old_vlan_aware;
>  	unsigned long bit;
>  	u32 reg, data;
>  	int ret;
> @@ -967,6 +1085,7 @@ static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
>  			return ret;
>  	}
>  
> +	old_vlan_aware = sw->vlan_aware;
>  	sw->vlan_aware = vlan_filtering;
>  

[ ... ]

> @@ -1004,15 +1123,23 @@ static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
>  		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
>  						TSN_PORT_STATE_BLOCKING);
>  		if (ret)
> -			return ret;
> +			goto restore;
>  
>  		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
>  						TSN_PORT_STATE_FLUSH);
>  		if (ret)
> -			return ret;
> +			goto restore;
>  	}
>  
> +	ret = xlnx_tsn_sync_ctrl_traps(sw);
> +	if (ret)
> +		goto restore;
> +
>  	return 0;
> +
> +restore:
> +	sw->vlan_aware = old_vlan_aware;
> +	return ret;
>  }

[Severity: Medium]
Does this rollback leave the shadow flag disagreeing with the hardware?

Only sw->vlan_aware is reverted, while every register write already made
for the new setting stays in place:

  - TSN_VLAN_PORT_LIST_VALID flipped on each VID in sw->cfg_vids
  - the unicast/multicast CAM-miss policy in TSN_SW_CTRL
  - the VLAN-only-learning bit via xlnx_tsn_set_vlan_only_learning()
  - the per-port native VID and untag bits via xlnx_tsn_apply_pvid()

xlnx_tsn_port_state_cycle() can return -EBUSY (previous state-change bit
still pending) or -ETIMEDOUT (ack timeout), and xlnx_tsn_sync_ctrl_traps()
can return -ETIMEDOUT from the CAM polling.

When enabling filtering fails that way, the hardware keeps discarding
unknown unicast/multicast and enforcing VLAN membership while
sw->vlan_aware is false and DSA and the bridge both believe filtering is
off, so traffic is dropped with no indication of why.

It also affects later operations: xlnx_tsn_port_vlan_add() takes the
data &= ~TSN_VLAN_PORT_LIST_VALID branch, xlnx_tsn_apply_pvid() reprograms
the native VID to TSN_SW_DEFAULT_VID, and xlnx_tsn_sync_ctrl_traps()
recomputes wanted trap VIDs from the reverted flag:

    vid = sw->vlan_aware ? sw->pvid[dp->index] : TSN_SW_DEFAULT_VID;

so the CAM trap keys can end up permanently mismatched against the native
VIDs actually programmed. Before this patch the function returned the
error with the flag matching the writes already made. Would undoing the
hardware writes too, or dropping the flag revert, be more consistent?

[ ... ]

> @@ -1204,6 +1333,21 @@ static const struct phylink_mac_ops xlnx_tsn_phylink_mac_ops = {
>  	.mac_link_down	= xlnx_tsn_mac_link_down,
>  };
>  
> +static void xlnx_tsn_remove_ctrl_traps(struct xlnx_tsn *sw)
> +{
> +	int i;
> +
> +	guard(mutex)(&sw->indirect_lock);
> +
> +	for (i = 0; i < sw->ctrl_trap_count; i++)
> +		if (xlnx_tsn_set_ctrl_traps(sw, sw->ctrl_trap_vid[i], false))
> +			dev_warn(sw->dev,
> +				 "failed to remove control trap vid %u\n",
> +				 sw->ctrl_trap_vid[i]);
> +
> +	sw->ctrl_trap_count = 0;
> +}
> +
>  static int xlnx_tsn_setup(struct dsa_switch *ds)
>  {
>  	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);

[ ... ]

> @@ -1276,9 +1420,19 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  			return ret;
>  	}
>  
> +	/* Trap link-local control frames (STP, LLDP) to the CPU port.
> +	 * Without this, a frame arriving on one wire port would be
> +	 * flooded out the other instead of reaching the host bridge.
> +	 */

[Severity: Medium]
Can trapped frames actually reach the host bridge in this tree?

The tag protocol receive hook for this switch drops everything coming from
the conduit:

net/dsa/tag_xlnx_tsn.c:xlnx_tsn_rcv() {
	kfree_skb(skb);
	return NULL;
}

That is the only rcv path in the tagger, so no frame the switch delivers on
the CPU port ever reaches a DSA user netdev or the software bridge, and
this patch adds no management-queue consumer. With the CAM port list set to
TSN_PORT_BIT(XLNX_TSN_CPU_PORT) only, the observable change today looks
like 01:80:c2:00:00:00 and 01:80:c2:00:00:0e are dropped rather than
consumed locally.

The commit message says the switch "then delivers trapped frames on the
management queue" - is there a receive path for that queue, or does that
part depend on a follow-up patch?

Separately, this comment says the frame "would be flooded out the other
instead of reaching the host bridge", while the commit message says a CAM
miss is "flooded to all ports except the ingress port", which includes the
CPU port. Could the two descriptions be reconciled?

> +	scoped_guard(mutex, &sw->indirect_lock) {
> +		ret = xlnx_tsn_sync_ctrl_traps(sw);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Medium]
Should this error path use the err_traps label added below instead of
returning directly?

xlnx_tsn_sync_ctrl_traps() installs entries incrementally and records each
wanted VID as it goes, so a failure on the second VID - or on the second
destination MAC of the first VID - leaves CAM entries programmed and
ctrl_trap_count possibly non-zero.

Nothing removes them afterwards: DSA does not call ds->ops->teardown() when
ds->ops->setup() fails,

net/dsa/dsa.c:dsa_switch_setup() {
	err = ds->ops->setup(ds);
	if (err < 0)
		goto unregister_notifier;
}

and the shadow state goes away with the failed probe, so a re-probe starts
with ctrl_trap_count = 0 and never accounts for the stale entries. The
mutex itself is released correctly by the scoped_guard cleanup; it is only
the xlnx_tsn_remove_ctrl_traps() call that is skipped.

> +
>  	ret = xlnx_tsn_mdio_register_all(sw);
>  	if (ret)
> -		return ret;
> +		goto err_traps;
>  
>  	sw->nb.notifier_call = xlnx_tsn_netdev_event;
>  	ret = register_netdevice_notifier(&sw->nb);
> @@ -1312,6 +1466,8 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  	unregister_netdevice_notifier(&sw->nb);
>  err_mdio:
>  	xlnx_tsn_mdio_unregister_all(sw);
> +err_traps:
> +	xlnx_tsn_remove_ctrl_traps(sw);
>  	return ret;
>  }

[ ... ]

Cross-instance finding from sashiko-gemini (f0bf43e93137481b1a742a87803d2ec1a8a9f5833a1ae7688d64415f986a1ea2):
[Severity: Medium]
Mixing goto-based error handling with scoped guard cleanups in the same function.
