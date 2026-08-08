Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB641D203;
	Sat,  8 Aug 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218522; cv=none; b=L6W1SG1rVHiAG/Jj+jtc9VfoQFN9k1r60OyyWw3PDWps0jW4VC9z2nBqeSHG7VUNPM1WkgNbBIEgaihyF99Ql594SjRIN7e76U1Ndlv+zO0xdifAJfkZUnqloBPEC3eHyrdVubVR+b0dBBJXd1A+V4aKx1TbZKZ9qul72Q1gLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218522; c=relaxed/simple;
	bh=mUVvRW3FHa2Pv22+VtOX5M8Ff9wtk1c9tYZjSJclItY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBeGH3CfkT6E0lDq2JfEHBYvnRCLLcRw62KiRPN1aUbZHPW+Bbb/QNdR9dBUk75+mtys36T2NFeW0debSjJZ8rBbzTvQaeJCd01bxniF4SC+F3MU92msSuc2B3zSDpF6r30kUFooWZfV/j6GCw7ygu4Hv/qejIVxfj1sI3dsKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6UsMQjl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6UsMQjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D961F00A3A;
	Sat,  8 Aug 2026 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218519;
	bh=Cyxw3LjdsOzEPkfg3cAwIWEsA+6PRzyjyGFVfYuit6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q6UsMQjlKGX5PXRmsZkwuv7u8xoIAKSNjkEz7uWbqtMrDmm1o6iWiwwDIX2EYYI9I
	 x7ZlQ+cjHihdH2d8fIFuBRRraGZoKY9vvBMztKa5Od01SRyZPhEnMEOsJSyEPHfULw
	 w2qbVBB3BOLRLyedy3k6JiD/KSPBYE+twNDKVdm8nK+t0xMbc2RrX3w/DsOpFxgHmn
	 jycapsuQSzEWROavRWNzdn3+BZ6J2zSe2ZeBRzrx1wSxrku2aHxvZipyJHOhvV08QQ
	 +fhxpmT6XY8zCDcsfkpV31qqn38ljrBfWPBWEKHISXxN+YZ7BW51DrJrR+sU38n0Ir
	 HPxNVx1pEoNYA==
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
Subject: Re: [PATCH 19/20] net: dsa: xilinx: offload bridge VLAN filtering to the switch
Date: Sat,  8 Aug 2026 12:48:38 -0700
Message-ID: <20260808194838.133557-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-20-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-20-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: offload bridge VLAN filtering to the switch

This wires bridge VLAN filtering into the switch's per-VID port-membership
table and the per-port native-VID registers, and declares VLAN filtering
switch-wide. It also sets the per-MAC VLAN-enable bits so tagged frames are
not treated as oversize.

A few questions about the new VLAN paths below.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 57558b0e2613..7e5cf77cfa66 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -814,6 +815,297 @@ static int xlnx_tsn_port_fdb_dump(struct dsa_switch *ds, int port,
>  	return ret;
>  }
>  
> +/* The VLAN-membership control enable bit self-clears once the indirect
> + * read or write completes.
> + */
> +static int xlnx_tsn_vlan_wait_done(struct xlnx_tsn *sw)
> +{
> +	u32 reg;
> +
> +	return readl_poll_timeout(sw->sw_base + TSN_VLAN_CTRL_OFFSET, reg,
> +				  !(reg & TSN_VLAN_EN), TSN_SW_POLL_DELAY_US,
> +				  TSN_SW_POLL_TIMEOUT_US);
> +}
> +
> +/* Caller holds indirect_lock. */
> +static int xlnx_tsn_vlan_read(struct xlnx_tsn *sw, u16 vid, u32 *data)
> +{
> +	int ret;
> +
> +	sw_iow(sw, TSN_VLAN_CTRL_OFFSET,
> +	       FIELD_PREP(TSN_VLAN_CTRL_VID_MASK, vid) | TSN_VLAN_ACCESS_READ | TSN_VLAN_EN);
> +	ret = xlnx_tsn_vlan_wait_done(sw);
> +	if (ret)
> +		return ret;
> +
> +	*data = sw_ior(sw, TSN_VLAN_DATA_OFFSET);
> +	return 0;
> +}
> +
> +/* Caller holds indirect_lock. */
> +static int xlnx_tsn_vlan_write(struct xlnx_tsn *sw, u16 vid, u32 data)
> +{
> +	sw_iow(sw, TSN_VLAN_DATA_OFFSET, data);
> +	sw_iow(sw, TSN_VLAN_CTRL_OFFSET,
> +	       FIELD_PREP(TSN_VLAN_CTRL_VID_MASK, vid) | TSN_VLAN_ACCESS_WRITE | TSN_VLAN_EN);
> +
> +	return xlnx_tsn_vlan_wait_done(sw);
> +}

[Severity: Medium]

Should xlnx_tsn_vlan_read() and xlnx_tsn_vlan_write() confirm the engine is
idle (TSN_VLAN_EN clear) before writing TSN_VLAN_EN again?

If xlnx_tsn_vlan_wait_done() times out, the error is propagated but
TSN_VLAN_EN is left set and nothing clears or re-checks it.  The next
operation then writes EN=1 while EN is already 1.  The driver assumes the
enable is edge-triggered for the sibling blocks, xlnx_tsn_cam_wait_ready()
polls CAM readiness before every CAM access and xlnx_tsn_set_port_state()
carries:

	/* Bit won't re-arm if a previous change never cleared it. */
	val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
	if (val & chg_bit) {
		...
		return -EBUSY;
	}

Can this then report a dropped access as a successful one?
readx_poll_timeout() evaluates its condition before the first sleep, so if
the previously stuck access clears EN just after the CTRL write,
xlnx_tsn_vlan_wait_done() returns 0 immediately and xlnx_tsn_vlan_read()
hands back the TSN_VLAN_DATA contents of the previous VID as the membership
word of the requested VID.  The callers then write that value back:
xlnx_tsn_port_vlan_add() ORs the port bit into the wrong port list,
xlnx_tsn_port_vlan_del() clears a bit from the wrong entry, and
xlnx_tsn_port_vlan_filtering() copies one VID's port list onto another.

[ ... ]

> +/* Write a port's native VID and egress-untag setting to hardware.
> + * While VLAN filtering is off, every port uses the reset-default
> + * native VID and stays tagged, so committed VLANs have no effect
> + * until the bridge goes VLAN-aware. Caller holds indirect_lock.
> + */
> +static void xlnx_tsn_apply_pvid(struct xlnx_tsn *sw, int port)
> +{
> +	u16 vid = sw->vlan_aware ? sw->pvid[port] : TSN_SW_DEFAULT_VID;
> +	bool untag = sw->vlan_aware && sw->pvid_untagged[port];
> +
> +	xlnx_tsn_set_native_vid(sw, port, vid);
> +	xlnx_tsn_set_native_untag(sw, port, untag);
> +}

[ ... ]

> +static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					bool vlan_filtering,
> +					struct netlink_ext_ack *extack)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	struct dsa_port *dp;
> +	unsigned long bit;
> +	u32 reg, data;
> +	int ret;
> +
> +	guard(mutex)(&sw->indirect_lock);
> +
> +	/* Flip Port-List-Valid on every configured VID: set it to enforce
> +	 * membership, clear it so VLANs added while filtering was off stay
> +	 * inert.
> +	 */
> +	for_each_set_bit(bit, sw->cfg_vids, VLAN_N_VID) {
> +		ret = xlnx_tsn_vlan_read(sw, bit, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (vlan_filtering)
> +			data |= TSN_VLAN_PORT_LIST_VALID;
> +		else
> +			data &= ~TSN_VLAN_PORT_LIST_VALID;
> +
> +		ret = xlnx_tsn_vlan_write(sw, bit, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	sw->vlan_aware = vlan_filtering;

[Severity: Medium]

What state is the switch left in when this function fails part way through?

A -ETIMEDOUT out of xlnx_tsn_vlan_wait_done() inside this loop returns
immediately, so the VIDs already visited have Port-List-Valid flipped while
the remaining ones keep the old value.  DSA does not update
ds->vlan_filtering when the driver op fails (dsa_port_vlan_filtering()
returns the error before assigning it) and the bridge reverts its own
BROPT_VLAN_ENABLED, so those already-flipped VIDs enforce membership
together with the switch-wide TSN_SW_CTRL_MEMBER_VIOL_DISCARD pinned in
xlnx_tsn_setup(), while the bridge believes it is VLAN-unaware.

The same applies to everything written after sw->vlan_aware is committed
here: the miss policy, the learning qualifier, the native-VID/untag
registers and the port-state cycling.  A failure in
xlnx_tsn_port_state_cycle() (-EBUSY "previous state change still pending"
or -ETIMEDOUT from xlnx_tsn_set_port_state()) leaves the hardware fully
VLAN-aware, with unknown unicast and multicast discarded rather than
flooded, while DSA and the driver shadow both think filtering is off.

Also, xlnx_tsn_port_state_cycle() sets the requested state and then
restores the saved one, so if the restoring write fails the user port stays
in TSN_PORT_STATE_BLOCKING or in TSN_PORT_STATE_FLUSH, which is not an STP
state at all, and nothing puts it back.

The last patch of the series ("net: dsa: xilinx: trap link-local control
frames to the CPU port") adds a restore: label here, but it only assigns
sw->vlan_aware back to its old value; every register written in between
keeps its new value, so this question still stands at the end of the
series.

> +
> +	/* Miss policy for unicast and multicast. It only kicks in when the
> +	 * CAM misses and the VID has no membership entry either. So flood the
> +	 * unregistered ones while VLAN-unaware, and drop them once filtering
> +	 * is on.
> +	 */
> +	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
> +	reg &= ~(TSN_SW_CTRL_UCAST_MISS_MASK | TSN_SW_CTRL_MCAST_MISS_MASK);
> +	if (vlan_filtering) {
> +		reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_MISS_DISCARD) |
> +		       FIELD_PREP(TSN_SW_CTRL_MCAST_MISS_MASK, TSN_SW_CTRL_MISS_DISCARD);
> +	} else {
> +		reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD) |
> +		       FIELD_PREP(TSN_SW_CTRL_MCAST_MISS_MASK, TSN_SW_CTRL_MCAST_MISS_FLOOD);
> +	}
> +	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);

[Severity: Medium]

Is the VLAN-unaware state here the same as the VLAN-unaware state at boot?

TSN_SW_CTRL_MCAST_MISS_MASK is only ever programmed from this function.
xlnx_tsn_setup() masks and programs TSN_SW_CTRL_UCAST_MISS_MASK and
TSN_SW_CTRL_MEMBER_VIOL_MASK only, so at probe the multicast miss field
keeps whatever the register already holds:

	reg &= ~(TSN_SW_CTRL_UCAST_MISS_MASK | TSN_SW_CTRL_MEMBER_VIOL_MASK);
	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD) |
	       FIELD_PREP(TSN_SW_CTRL_MEMBER_VIOL_MASK, TSN_SW_CTRL_MEMBER_VIOL_DISCARD);

The header documents the encoding as flood / to processor / to MAC /
discard, with FLOOD == 0x1, so a reset value of 0x0 is a different action.
Unless the reset value happens to be FLOOD, unknown multicast and broadcast
handling in a VLAN-unaware bridge would depend on whether vlan_filtering
has ever been toggled once.  Could xlnx_tsn_setup() program this field too?

The changelog also does not mention that the patch starts driving this
switch-wide field.

[ ... ]

> +static int xlnx_tsn_port_vlan_add(struct dsa_switch *ds, int port,
> +				  const struct switchdev_obj_port_vlan *vlan,
> +				  struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct xlnx_tsn *sw = ds->priv;
> +	u32 data;
> +	int ret;
> +
> +	guard(mutex)(&sw->indirect_lock);
> +
> +	/* The hardware strips the tag on egress only for a wire port's native
> +	 * VLAN. Reject an untagged request for any other VID. The CPU port is
> +	 * exempt as it always trunks tagged toward the host.
> +	 */
> +	if (port != XLNX_TSN_CPU_PORT && untagged && !pvid &&
> +	    vlan->vid != sw->pvid[port]) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "untagged egress is only supported for the port PVID");
> +		return -EINVAL;
> +	}

[Severity: Medium]

Can this restriction be bypassed by command ordering?  It is validated
against the mutable sw->pvid[] shadow and never re-validated when the PVID
moves:

  bridge vlan add dev swp1 vid 10 pvid untagged
  bridge vlan add dev swp1 vid 20 pvid untagged

The second call has pvid == true, so the check above is skipped and the
if (pvid) branch below overwrites sw->pvid[1] with 20 and reprograms the
single native-VID/untag pair.  The bridge keeps BRIDGE_VLAN_INFO_UNTAGGED
on VLAN 10 (__vlan_add_pvid() only moves vg->pvid, VLAN 10 is not
re-notified), so the bridge still expects VLAN 10 to egress untagged on
swp1 while the hardware now tags it, with no error reported.

Deleting VID 20 afterwards gives the same divergence through
xlnx_tsn_port_vlan_del(), which resets the native VID and untag setting to
the defaults while VLAN 10 is still configured untagged.

> +
> +	ret = xlnx_tsn_vlan_read(sw, vlan->vid, &data);
> +	if (ret)
> +		return ret;
> +
> +	data |= TSN_PORT_BIT(port);
> +	if (sw->vlan_aware)
> +		data |= TSN_VLAN_PORT_LIST_VALID;
> +	else
> +		data &= ~TSN_VLAN_PORT_LIST_VALID;
> +	ret = xlnx_tsn_vlan_write(sw, vlan->vid, data);
> +	if (ret)
> +		return ret;
> +
> +	set_bit(vlan->vid, sw->cfg_vids);
> +
> +	/* The CPU port needs membership only. */
> +	if (port == XLNX_TSN_CPU_PORT)
> +		return 0;
> +
> +	if (pvid) {
> +		sw->pvid[port] = vlan->vid;
> +		sw->pvid_untagged[port] = untagged;
> +		xlnx_tsn_apply_pvid(sw, port);
> +	}
> +
> +	if (vlan->vid == sw->pvid[port] &&
> +	    sw->pvid_untagged[port] != untagged) {
> +		sw->pvid_untagged[port] = untagged;
> +		xlnx_tsn_apply_pvid(sw, port);
> +	}
> +
> +	return 0;
> +}

[Severity: High]

What clears sw->pvid[port] when the bridge withdraws
BRIDGE_VLAN_INFO_PVID from a VLAN that stays configured?

  bridge vlan add dev swp1 vid 10 pvid untagged
  bridge vlan add dev swp1 vid 10 untagged        # pvid flag dropped

nbp_vlan_add() detects the flag change via __vlan_flags_would_change() and
re-notifies switchdev with flags lacking PVID, so this function is called
with pvid == false.  The extack check above is skipped because
vlan->vid == sw->pvid[port], the if (pvid) block is not taken, and the last
block only updates sw->pvid_untagged[].  sw->pvid[1] stays 10, so
xlnx_tsn_apply_pvid() keeps VID 10 in the native-VID register and untagged
frames from the wire are still admitted into VLAN 10 and forwarded to its
other members, although the bridge would drop them.

Other DSA drivers handle this notification explicitly.
mv88e6xxx_port_vlan_add():

	} else if (vlan->vid && p->bridge_pvid.vid == vlan->vid) {
		/* The old pvid was reinstalled as a non-pvid VLAN */
		p->bridge_pvid.valid = false;
		...
	}

and ocelot_vlan_add() calls ocelot_port_set_pvid(ocelot, port, NULL) in the
same situation.

The mirror case is in xlnx_tsn_port_vlan_del() below:

	if (sw->pvid[port] == vlan->vid) {
		sw->pvid[port] = TSN_SW_DEFAULT_VID;

Rather than disabling untagged admission, this re-points untagged ingress
at VID 1.  When VLAN 1 is a configured VLAN whose member list includes the
port (the bridge default_pvid VLAN, kept as a tagged member), does
TSN_SW_CTRL_MEMBER_VIOL_DISCARD still fire, or does untagged traffic leak
into VLAN 1 once the real PVID VLAN is deleted?

[ ... ]

> @@ -941,12 +1232,26 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  	       TSN_SW_ADDR_LEARN_NO_VLAN_EN;
>  	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
>  
> -	/* On a CAM miss flood unknown tagged unicast frames to all ports. */
> +	/* On a CAM miss flood unknown tagged unicast frames to all ports.
> +	 * Also drop tagged frames whose ingress port is not in the VLAN
> +	 * member list. The membership check only bites once VLANs exist.
> +	 */
>  	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
> -	reg &= ~TSN_SW_CTRL_UCAST_MISS_MASK;
> -	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD);
> +	reg &= ~(TSN_SW_CTRL_UCAST_MISS_MASK | TSN_SW_CTRL_MEMBER_VIOL_MASK);
> +	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD) |
> +	       FIELD_PREP(TSN_SW_CTRL_MEMBER_VIOL_MASK, TSN_SW_CTRL_MEMBER_VIOL_DISCARD);
>  	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
>  
> +	/* Every port uses the default native VID until VLAN filtering is
> +	 * enabled. Seed the PVID shadow and program the native VID
> +	 * registers to match.
> +	 */
> +	scoped_guard(mutex, &sw->indirect_lock)
> +		for (port = XLNX_TSN_CPU_PORT; port < XLNX_TSN_NUM_PORTS; port++) {
> +			sw->pvid[port] = TSN_SW_DEFAULT_VID;
> +			xlnx_tsn_apply_pvid(sw, port);
> +		}
> +

[Severity: Medium]

Should the per-VID VLAN-membership memory be flushed here as well?

The membership words at TSN_VLAN_CTRL_OFFSET / TSN_VLAN_DATA_OFFSET now
gate forwarding, and MEMBER_VIOL is pinned to DISCARD just above, but the
driver never initializes that memory at setup and never clears it at
teardown.  The software shadows (sw->cfg_vids, sw->pvid[], sw->vlan_aware)
always start zeroed from devm_kzalloc(), so anything left in the table
takes part in forwarding without the driver knowing about it.  This is
reachable after unbind/rebind or module reload where the entries were not
torn down, for example a failing xlnx_tsn_vlan_write() during bridge
teardown, a shutdown/kexec path (dsa_switch_shutdown() does no VLAN
cleanup), or a pre-programmed fabric.

Three consequences to consider:

A stale entry with Port-List-Valid set makes the pinned MEMBER_VIOL=DISCARD
action fire for tagged frames arriving on a port absent from the stale port
list, so traffic a VLAN-unaware bridge must forward is dropped.  The new
comment "The membership check only bites once VLANs exist" would then not
hold.

xlnx_tsn_port_vlan_add() does a read-modify-write:

	ret = xlnx_tsn_vlan_read(sw, vlan->vid, &data);
	...
	data |= TSN_PORT_BIT(port);

so a newly added VLAN inherits stale member ports and forwards that VID to
ports the bridge never added.

The Port-List-Valid flip in xlnx_tsn_port_vlan_filtering() walks only
sw->cfg_vids, so untracked VIDs are never made inert or repaired, and
last_member in xlnx_tsn_port_vlan_del() is computed from a port list that
can contain bits the driver never set.

For reference, mv88e6xxx flushes the whole VTU at setup via
mv88e6xxx_vtu_setup() -> mv88e6xxx_g1_vtu_flush().

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
> index a94f5124a33d..955041cde564 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.h
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.h

[ ... ]

> @@ -304,6 +333,15 @@ struct xlnx_tsn_mac {
>   * @nb: netdev notifier that handles NETDEV_REGISTER on each swpN
>   *	to set its final MAC, and NETDEV_CHANGEADDR on the conduit
>   *	to refresh the shared prefix
> + * @vlan_aware: true once bridge VLAN filtering is on. Until then the
> + *		native VID, egress untag, and membership enforcement are
> + *		all held back.
> + * @pvid: per-port bridge PVID shadow, written to the native VID register
> + *	  while @vlan_aware; defaults to TSN_SW_DEFAULT_VID

[Severity: Low]

This isn't a bug, but does the @pvid description match what the code does
for the CPU port?

pvid[XLNX_TSN_CPU_PORT] can never change: xlnx_tsn_port_vlan_add() returns
early at

	/* The CPU port needs membership only. */
	if (port == XLNX_TSN_CPU_PORT)
		return 0;

before any pvid bookkeeping, and xlnx_tsn_port_vlan_del() only ever writes
TSN_SW_DEFAULT_VID back into it.  So the endpoint native VID stays at VID 1
for the lifetime of the driver even though TSN_EP_NATIVE_VLAN_OFFSET and
xlnx_tsn_set_native_vid() handle XLNX_TSN_CPU_PORT.

The two apply loops also disagree on coverage: xlnx_tsn_setup() uses
for (port = XLNX_TSN_CPU_PORT; port < XLNX_TSN_NUM_PORTS; port++) while
xlnx_tsn_port_vlan_filtering() re-applies with
dsa_switch_for_each_user_port(), which excludes the CPU port.  Could the
documentation say the CPU-port slots are unused, or the loops be made
consistent?

> + * @pvid_untagged: per-port flag tracking whether the PVID egresses
> + *		   untagged; drives the native-VLAN untag enable
> + * @cfg_vids: VIDs with a membership entry in the VLAN-membership memory,
> + *	      used to walk and update Port-List-Valid when @vlan_aware changes
>   * @indirect_lock: serialises the CAM and VLAN-membership indirect
>   *		   register sequences

[ ... ]

Cross-instance finding from sashiko-gemini (4f56bb35ca00c92afa83ce956f0bfab329dc0d5a7ae6d461bc954faf0f898d34):
[Severity: Medium]
Mixing goto-based error handling with scope-based cleanup helpers (`guard()`, `scoped_guard()`) in the same function.

Cross-instance finding from sashiko-gemini (e8525d575b62bcd573cc21461acce156f144090732b49f8b9225c62ef9d9e0ba):
[Severity: High]
Leaking internal default VLAN tags to wire ports when VLAN filtering is disabled.
