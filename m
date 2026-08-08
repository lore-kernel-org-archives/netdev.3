Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7241A564;
	Sat,  8 Aug 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218521; cv=none; b=clGuVcN+q0zUSwENApnRdloV6VVxTROqP4SH9zOT4abIC4dPIyaK7OFgcsfzGfkvRsQz3izjBfo+HP6q4BzOAo9dSvWzcZzlM/HHwzvxiHUCuphAOq2G4We9wUoAuMZnAT0XnJkGO+m5FWf0qL2epBGLe1JdKj+ou/1x2cbyfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218521; c=relaxed/simple;
	bh=YPQrQmTKnB4qsBMzVAL/w5lXjr5PP7cYvXspixoma1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c53X2qf0LXgvO894yBRKaKFvOfVEczubA+AVvMiwmT9Pr+KnjsyI+Iy5qezOo3S2I4KxsrIqTyYuAKGkXPgKjxmVQW8HhLMxBiIbdPIgmNP1ODIAVm0PQwNyZeHggWoUQ06rts0BlzlqkK9bzwwaxpQ6PSwEuMiN3yUtazAgyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBQGfRa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBQGfRa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246341F00A3E;
	Sat,  8 Aug 2026 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218517;
	bh=Y0bnodPxz73AF5O0IYrYe8vDqdfSMKjXXHAIJ8OA5Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RBQGfRa/WkJzDhNJxQaEWk4nUvDhP6W4eBoYbTaUnDSu1K1r1BAXLZqyhfmkMs3GI
	 JirpRxKTki1eZZG07zTLtSRuHo4xbvvoZA7vejqr9p9wXuAiOuA2dEwUXVyHOSTqPK
	 9UyLJ2WpQgB27blXy1eSSmCmkW81HtKr8Zo8/M8KPZZHAVmiOaLFatzFGNNHGOFChr
	 EnHb2zn4ZAlydiMJ8uWuZlrUCxLNmqR1wSjf2BaTkXG0venpdX1X5VqDXiCbddMab5
	 a8hSQy1rCg+JwkWKt0l5wAOS6GnFsL4UuTLbmVL6nCwGDurU2T18rmE5teeAex5lja
	 g/uOSeRJNfI7A==
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
Subject: Re: [PATCH 18/20] net: dsa: xilinx: offload the bridge FDB to the switch CAM
Date: Sat,  8 Aug 2026 12:48:36 -0700
Message-ID: <20260808194836.133516-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-19-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-19-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: offload the bridge FDB to the switch CAM

This backs the bridge FDB with the switch's stream-destination lookup CAM,
adding indirect CAM access helpers plus a mutex, the port_fdb_add /
port_fdb_del / port_fdb_dump / port_fast_age ops, and enabling the hardware
learning engine on bridge join. A few questions below about the global
switch settings, locking and the dump path.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 9a4d4a2fb892..57558b0e2613 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
> @@ -174,6 +174,31 @@ static int xlnx_tsn_set_port_state(struct xlnx_tsn *sw, int port,
>  	return 0;
>  }
>  
> +static enum tsn_port_state xlnx_tsn_get_port_state(struct xlnx_tsn *sw,
> +						   int port)
> +{
> +	u32 mask, chg_bit, reg;
> +
> +	if (xlnx_tsn_port_state_bits(port, &mask, &chg_bit))
> +		return TSN_PORT_STATE_DISABLED;
> +
> +	reg = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
> +	return (reg & mask) >> __ffs(mask);
> +}
> +
> +static int xlnx_tsn_port_state_cycle(struct xlnx_tsn *sw, int port,
> +				     enum tsn_port_state state)
> +{
> +	enum tsn_port_state saved = xlnx_tsn_get_port_state(sw, port);
> +	int err;
> +
> +	err = xlnx_tsn_set_port_state(sw, port, state);
> +	if (err)
> +		return err;
> +
> +	return xlnx_tsn_set_port_state(sw, port, saved);
> +}

[Severity: Medium]
If the restore write here fails, what is left programmed in the port's
field of TSN_PORT_STATE_CTRL?

xlnx_tsn_set_port_state() can fail in three places: the
xlnx_tsn_switch_status_ready() check, the -EBUSY path when the
change-commit bit is still set, and the -ETIMEDOUT ack poll. By the time
the restore leg runs, TSN_PORT_STATE_FLUSH has already been committed, and
the header comment describes it as "Not an STP state".

The only caller in this patch is xlnx_tsn_port_fast_age(), a void DSA op
that only dev_err()s, so nothing re-asserts the STP state afterwards while
DSA and the bridge still consider the port forwarding.

Since xlnx_tsn_get_port_state() returns the raw field with no validation,
would a later cycle on that port then read back the flush value as "saved"
and faithfully reprogram that non-STP value?

>  
>  static int xlnx_tsn_mdio_wait_ready(struct xlnx_tsn_mac *m)
>  {
>  	u32 val;
> @@ -495,11 +520,32 @@ static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +/* Enable or disable the hardware address learning engine globally.
> + * Standalone ports do not learn. Enable when a port joins a bridge,
> + * disable when the last one leaves. The sub-qualifier bits below are
> + * inert while learning is disabled. Caller holds indirect_lock.
> + */
> +static void xlnx_tsn_set_global_learning(struct xlnx_tsn *sw, bool on)
> +{
> +	u32 reg = sw_ior(sw, TSN_SW_ADDR_LEARN_OFFSET);
> +
> +	if (on)
> +		reg &= ~TSN_SW_ADDR_LEARN_DISABLE;
> +	else
> +		reg |= TSN_SW_ADDR_LEARN_DISABLE;
> +	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
> +}
> +
>  static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
>  				     struct dsa_bridge bridge,
>  				     bool *tx_fwd_offload,
>  				     struct netlink_ext_ack *extack)
>  {
> +	struct xlnx_tsn *sw = ds->priv;
> +
> +	scoped_guard(mutex, &sw->indirect_lock)
> +		xlnx_tsn_set_global_learning(sw, true);
> +

[Severity: High]
Can this leak frames between a bridged port and a standalone port?

The comment says "Standalone ports do not learn", but
xlnx_tsn_set_global_learning() clears one switch-wide
TSN_SW_ADDR_LEARN_DISABLE bit, and there is no per-port qualifier. Source
MACs seen on a standalone user port are then learnt into the same shared
CAM, and xlnx_tsn_setup() pins the switch-wide unknown-unicast miss action
to TSN_SW_CTRL_UCAST_MISS_FLOOD, so a CAM miss is replicated to ports that
are not bridge members.

DSA leaves standalone user ports at BR_STATE_FORWARDING via
dsa_port_enable() -> dsa_port_set_state(), so both wire ports are
forwarding in the fabric.

With swp0 in br0 and swp1 left standalone (or moved to another netns):

  - unicast from the bridge domain misses the CAM and is flooded out swp1
  - once swp1's neighbour is learnt into the shared CAM, br0 traffic is
    unicast-forwarded to swp1

xlnx_tsn_port_bridge_leave() below only disables learning once the last
user port leaves any bridge, so a port that has already left keeps being
learnt and learning while the other port is bridged, and the entries
already installed in the CAM stay programmed. Is a port-isolation or
port-matrix register available to restrict the flood domain to bridge
members?

>  	/* The switch fabric replicates flooded frames per egress port
>  	 * on its own, so the bridge does not need to clone-and-send.
>  	 */
> @@ -508,6 +554,24 @@ static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static void xlnx_tsn_port_bridge_leave(struct dsa_switch *ds, int port,
> +				       struct dsa_bridge bridge)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->index == port)
> +			continue;
> +
> +		if (dp->bridge)
> +			return;
> +	}
> +
> +	scoped_guard(mutex, &sw->indirect_lock)
> +		xlnx_tsn_set_global_learning(sw, false);
> +}
> +

[ ... ]

> @@ -539,6 +603,217 @@ static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
>  	xlnx_tsn_set_port_state(sw, port, hw_state);
>  }
>  
> +/* The CAM status enable bit reads 1 when the block is ready to accept the
> + * next operation.
> + */
> +static int xlnx_tsn_cam_wait_ready(struct xlnx_tsn *sw)
> +{
> +	u32 reg;
> +
> +	return readl_poll_timeout(sw->sw_base + TSN_CAM_STATUS_OFFSET, reg,
> +				  reg & TSN_CAM_STATUS_READY, TSN_SW_POLL_DELAY_US,
> +				  TSN_SW_POLL_TIMEOUT_US);
> +}
> +
> +/* The CAM control enable bit self-clears when the operation completes. */
> +static int xlnx_tsn_cam_wait_done(struct xlnx_tsn *sw)
> +{
> +	u32 reg;
> +
> +	return readl_poll_timeout(sw->sw_base + TSN_CAM_CTRL_OFFSET, reg,
> +				  !(reg & TSN_CAM_OP_ENABLE),
> +				  TSN_SW_POLL_DELAY_US, TSN_SW_POLL_TIMEOUT_US);
> +}
> +

[ ... ]

> +/* Add (add=true) or delete (add=false) the (MAC, VID) entry carrying the
> + * given port list. Caller holds indirect_lock.
> + */
> +static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
> +			      u16 vid, u8 portlist, bool add)
> +{
> +	int ret;
> +
> +	ret = xlnx_tsn_cam_wait_ready(sw);
> +	if (ret)
> +		return ret;
> +
> +	xlnx_tsn_cam_load_key(sw, addr, vid);
> +	sw_iow(sw, TSN_CAM_TV1_OFFSET, 0);
> +	sw_iow(sw, TSN_CAM_TV2_OFFSET, 0);
> +	sw_iow(sw, TSN_CAM_PORT_ACT_OFFSET,
> +	       FIELD_PREP(TSN_CAM_PORT_LIST, portlist));
> +	sw_iow(sw, TSN_CAM_CTRL_OFFSET,
> +	       FIELD_PREP(TSN_CAM_OP_MASK, add ? TSN_CAM_OP_ADD : TSN_CAM_OP_DELETE) |
> +	       TSN_CAM_OP_ENABLE);
> +
> +	return xlnx_tsn_cam_wait_done(sw);
> +}

[Severity: Medium]
Is the self-clearing of TSN_CAM_OP_ENABLE enough to conclude that
TSN_CAM_OP_ADD stored the entry?

The CAM is a finite resource (the read-key address space alone is 4096
slots), so an add can fail for lack of a free slot. The READ path does
consult TSN_CAM_FOUND in the same control register, but nothing is checked
after an ADD.

xlnx_tsn_port_fdb_add() returns this result unchanged, so DSA calls
dsa_fdb_offload_notify() and the bridge marks the entry offloaded even
though no hardware entry exists. Does the block expose a full or
add-failure indication that could be checked here?

> +
> +static void xlnx_tsn_port_fast_age(struct dsa_switch *ds, int port)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	int err;
> +
> +	err = xlnx_tsn_port_state_cycle(sw, port, TSN_PORT_STATE_FLUSH);
> +	if (err)
> +		dev_err(sw->dev, "port %d: fast age failed (%d)\n", port, err);
> +}

[Severity: Medium]
Should this take sw->indirect_lock?

Writing TSN_PORT_STATE_FLUSH mutates the CAM (per the enum comment it
"flushes the port's dynamic learnt entries"), yet every other new CAM
accessor documents "Caller holds indirect_lock" and this one takes no lock.

The two contexts are not otherwise mutually exclusive: .port_fdb_add and
.port_fdb_del run from dsa_user_switchdev_event_work(), which does not take
rtnl_lock, while .port_fast_age is reached from rtnl-held paths
dsa_port_set_state() -> dsa_port_fast_age() and dsa_port_bridge_flags().

CPU0 in xlnx_tsn_port_fdb_add() holds indirect_lock and has finished
xlnx_tsn_cam_read_portlist() but not yet xlnx_tsn_cam_write(); CPU1 issues
the flush; CPU0 then writes back a port list computed from pre-flush state,
resurrecting a flushed entry. The TSN_CAM_STATUS_READY handshake only
covers the driver's own operations, so an ADD can also be started while the
hardware flush walk is in progress. The same window applies to the 2048
slot scan in xlnx_tsn_port_fdb_dump().

> +
> +static int xlnx_tsn_port_fdb_add(struct dsa_switch *ds, int port,
> +				 const unsigned char *addr, u16 vid,
> +				 struct dsa_db db)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	u8 portlist;
> +	int ret;
> +
> +	if (!vid)
> +		vid = TSN_SW_DEFAULT_VID;

[Severity: Medium]
Can folding vid 0 onto TSN_SW_DEFAULT_VID make two software FDB entries
share one hardware entry?

nbp_vlan_init() adds the bridge's default_pvid (1) to every port's VLAN
group regardless of VLAN filtering, and br_fdb_add() then installs both a
vid 0 entry and one entry per configured VLAN:

net/bridge/br_fdb.c:br_fdb_add() {
	...
	err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb, notified, extack);
	if (err || !vg || !vg->num_vlans)
		goto out;
	list_for_each_entry(v, &vg->vlan_list, vlist) {
	...
}

So a plain "bridge fdb add <mac> dev swp1 master" reaches the driver twice
and both calls program key (mac, 1); DSA does not refcount FDB entries for
user ports. A later "bridge fdb del <mac> dev swp1 master vlan 1" then
makes xlnx_tsn_port_fdb_del() clear the port bit and issue
TSN_CAM_OP_DELETE, destroying hardware state that the surviving vid 0
software entry still needs, while the bridge keeps it flagged offloaded.

The reverse mapping in xlnx_tsn_port_fdb_dump() also reports a genuine
vid 1 entry as vid 0, which hides the alias from the operator.

> +
> +	guard(mutex)(&sw->indirect_lock);
> +	ret = xlnx_tsn_cam_read_portlist(sw, addr, vid, &portlist);
> +	if (!ret) {
> +		portlist |= TSN_PORT_BIT(port);
> +		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, true);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
Can this read-modify-write lose an update made by the learning engine?

After xlnx_tsn_port_bridge_join() clears TSN_SW_ADDR_LEARN_DISABLE, the
fabric writes the same (MAC, VID) entries autonomously, and
sw->indirect_lock only serialises the software writers:

  xlnx_tsn_cam_read_portlist()   /* snapshot */
  <hardware learns the same key on the other port, sets its bit>
  portlist |= TSN_PORT_BIT(port);
  xlnx_tsn_cam_write()           /* writes back the stale snapshot */

The bit set by hardware is then cleared, so the entry no longer forwards to
the port where the address is actually reachable. In xlnx_tsn_port_fdb_del()
the mirror case makes a port list that hardware repopulated after the read
look empty, so TSN_CAM_OP_DELETE is issued on a live entry.

No lock can order software against the learning engine. Is there an atomic
set/clear opcode, or could learning be masked around the sequence, or the
entry re-read and validated after the write?

> +
> +static int xlnx_tsn_port_fdb_del(struct dsa_switch *ds, int port,
> +				 const unsigned char *addr, u16 vid,
> +				 struct dsa_db db)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	u8 portlist;
> +	int ret;
> +
> +	if (!vid)
> +		vid = TSN_SW_DEFAULT_VID;
> +
> +	guard(mutex)(&sw->indirect_lock);
> +	ret = xlnx_tsn_cam_read_portlist(sw, addr, vid, &portlist);
> +	if (!ret) {
> +		if (!portlist)
> +			return 0;
> +
> +		/* Drop the entry once no port references it. Otherwise
> +		 * rewrite it with the updated port list.
> +		 */
> +		portlist &= ~TSN_PORT_BIT(port);
> +		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, portlist != 0);
> +	}
> +
> +	return ret;
> +}
> +
> +static int xlnx_tsn_port_fdb_dump(struct dsa_switch *ds, int port,
> +				  dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	unsigned char addr[ETH_ALEN];
> +	u32 base, ctrl, key1, key2;
> +	int ret = 0;
> +	u16 vid;
> +	u32 i;
> +
> +	/* Learnt entries live in a per-MAC-port read-key region. The CPU
> +	 * port has no such region.
> +	 */
> +	if (port == XLNX_TSN_CPU_PORT)
> +		return 0;
> +
> +	guard(mutex)(&sw->indirect_lock);
> +
> +	if (port == XLNX_TSN_PORT_MAC2)
> +		base = TSN_CAM_MAC2_READ_KEY_BASE;
> +	else
> +		base = 0;
> +
> +	/* Learnt entries occupy non-consecutive slots, so scan the whole
> +	 * region and report each slot marked found.
> +	 */
> +	for (i = 0; i < TSN_CAM_READ_KEY_COUNT; i++) {
> +		ret = xlnx_tsn_cam_wait_ready(sw);
> +		if (ret)
> +			return ret;
> +
> +		sw_iow(sw, TSN_CAM_CTRL_OFFSET,
> +		       FIELD_PREP(TSN_CAM_READ_KEY_ADDR, base + i) |
> +		       FIELD_PREP(TSN_CAM_OP_MASK, TSN_CAM_OP_READ_KEY) |
> +		       TSN_CAM_OP_ENABLE);
> +
> +		ret = xlnx_tsn_cam_wait_done(sw);
> +		if (ret)
> +			return ret;

[Severity: Medium]
How long does this hold rtnl_lock?

PF_BRIDGE / RTM_GETNEIGH is registered without RTNL_FLAG_DUMP_UNLOCKED:

net/core/rtnetlink.c:
	{.protocol = PF_BRIDGE, .msgtype = RTM_GETNEIGH, .doit = rtnl_fdb_get,
	 .dumpit = rtnl_fdb_dump},

so rtnl_lock is held across the whole callback, and a netlink dump needs no
capability. Each of the TSN_CAM_READ_KEY_COUNT (2048) iterations runs two
sleeping readl_poll_timeout() loops with a 10 us delay and a 5000 us
timeout, so a healthy pass sleeps at least once per slot and a slow CAM can
stretch the pass towards seconds. A netlink dump also re-invokes the
callback per skb, repeating the full hardware scan for each chunk.

Would it be reasonable to cache the scan result, or bound the region
scanned, so that "bridge fdb show" cannot block the networking
configuration path for that long?

> +
> +		ctrl = sw_ior(sw, TSN_CAM_CTRL_OFFSET);
> +		if (!(ctrl & TSN_CAM_FOUND))
> +			continue;
> +
> +		key1 = sw_ior(sw, TSN_CAM_KEY1_OFFSET);
> +		key2 = sw_ior(sw, TSN_CAM_KEY2_OFFSET);
> +		addr[0] = key1 >> 24;
> +		addr[1] = key1 >> 16;
> +		addr[2] = key1 >> 8;
> +		addr[3] = key1;
> +		addr[4] = key2 >> 8;
> +		addr[5] = key2;
> +		vid = FIELD_GET(TSN_CAM_VLAN, key2);
> +		if (vid == TSN_SW_DEFAULT_VID)
> +			vid = 0;
> +
> +		ret = cb(addr, vid, false, data);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}

[Severity: Medium]
Should this filter on the entry's port list?

The only filter in the loop is the TSN_CAM_FOUND test; TSN_CAM_PORT_ACT_OFFSET
and TSN_CAM_PORT_LIST, the bitmap that xlnx_tsn_port_fdb_add() and
xlnx_tsn_port_fdb_del() maintain, are never read here.

xlnx_tsn_cam_write() selects a slot purely from the (MAC, VID) key, with no
port index, so can a slot range encode ownership by port at all? Two
consequences follow:

  - host entries written through .port_fdb_add for the CPU port (DSA calls
    it from dsa_switch_host_fdb_add() -> dsa_port_do_fdb_add(cpu_dp), and
    the driver programs TSN_PORT_BIT(0)) must land inside one of the two
    windows, and get reported as learnt on that user port
  - a (MAC, VID) reachable on both ports occupies a single slot, since the
    read-modify-write logic assumes one entry per key, so it can appear in
    at most one port's dump and is missing from the other's

The commit message says:

    A (MAC, VID) reachable on several
    ports then carries a correct multi-port list.

which holds for the port list in hardware, but the dump does not express
it.

Separately, every entry is passed to cb() with is_static = false, so
entries installed through .port_fdb_add come back as dynamic
(net/dsa/user.c maps is_static to ndm_state, NUD_REACHABLE versus
NUD_NOARP). Since "bridge fdb show" is an unprivileged dump, addresses
belonging to the other port's domain are also visible there.

> +
>  static void xlnx_tsn_phylink_get_caps(struct dsa_switch *ds, int port,
>  				      struct phylink_config *config)
>  {
> @@ -643,7 +918,7 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);
>  	struct xlnx_tsn *sw = ds->priv;
>  	struct dsa_port *dp;
> -	u32 mgmt;
> +	u32 mgmt, reg;
>  	int ret;
>  
>  	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
> @@ -656,6 +931,22 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  
>  	sw->conduit = cpu_dp->conduit;
>  
> +	/* Pre-arm the learning sub-qualifiers for when a port joins a bridge:
> +	 * learn untagged frames under their ingress native VID, and allow
> +	 * learning on VIDs with no membership entry while the bridge is
> +	 * VLAN-unaware. Both bits are inert while global learning is disabled.
> +	 */
> +	reg = sw_ior(sw, TSN_SW_ADDR_LEARN_OFFSET);
> +	reg |= TSN_SW_ADDR_LEARN_DISABLE | TSN_SW_ADDR_LEARN_UNTAGGED_EN |
> +	       TSN_SW_ADDR_LEARN_NO_VLAN_EN;
> +	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
> +
> +	/* On a CAM miss flood unknown tagged unicast frames to all ports. */
> +	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
> +	reg &= ~TSN_SW_CTRL_UCAST_MISS_MASK;
> +	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD);
> +	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
> +

[Severity: Medium]
This overrides the hardware reset default for unknown-unicast forwarding
unconditionally at probe time. TSN_SW_CTRL_UCAST_MISS_MASK is GENMASK(1, 0)
of the switch-wide Switch Control Register, no per-port flood domain is
programmed anywhere in the driver, and neither port_bridge_join nor
port_bridge_leave revisits it, so the policy also applies to frames
ingressing standalone user ports. The commit message describes the CAM
offload, the learning engine and the new ops, but not this global
forwarding change.

The peer field TSN_SW_CTRL_MCAST_MISS_MASK and TSN_SW_CTRL_MCAST_MISS_FLOOD
are added in the same header block but never written here, so unknown
unicast and unknown multicast end up under different policies, one
programmed and one left at the reset default. Was the multicast write meant
to be here too?

>  	/* Route CPU-originated bridge-group control frames (STP, LLDP) to
>  	 * the single wire port whose MAC-nibble field matches the frame's
>  	 * source-MAC low nibble, instead of flooding to both.
> @@ -743,7 +1034,12 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
>  	.teardown		= xlnx_tsn_teardown,
>  	.port_set_mac_address	= xlnx_tsn_port_set_mac_address,
>  	.port_bridge_join	= xlnx_tsn_port_bridge_join,
> +	.port_bridge_leave	= xlnx_tsn_port_bridge_leave,
>  	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
> +	.port_fdb_add		= xlnx_tsn_port_fdb_add,
> +	.port_fdb_del		= xlnx_tsn_port_fdb_del,
> +	.port_fdb_dump		= xlnx_tsn_port_fdb_dump,
> +	.port_fast_age		= xlnx_tsn_port_fast_age,

[Severity: Medium]
Since hardware learning is now switched on, should .port_pre_bridge_flags
and .port_bridge_flags be implemented as well?

That path is the only way the bridge port's BR_LEARNING, BR_FLOOD,
BR_MCAST_FLOOD and BR_PORT_LOCKED settings reach a driver:

net/dsa/port.c:dsa_port_bridge_flags() {
	if (!ds->ops->port_bridge_flags)
		return -EOPNOTSUPP;
	...
}

and dsa_port_inherit_brport_flags() swallows -EOPNOTSUPP. So
"bridge link set dev swpN learning off" is accepted while the CAM learning
engine enabled in xlnx_tsn_port_bridge_join() keeps installing entries, and
dsa_port_can_configure_learning() keeps dp->learning at 0 although hardware
is learning.

>  	.port_hwtstamp_get	= xlnx_tsn_port_hwtstamp_get,
>  	.port_hwtstamp_set	= xlnx_tsn_port_hwtstamp_set,
>  	.get_ts_info		= xlnx_tsn_get_ts_info,

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
> index d46150535775..a94f5124a33d 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.h
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
> @@ -63,18 +63,104 @@

[ ... ]

>  enum tsn_port_state {
>  	TSN_PORT_STATE_DISABLED = 0,
>  	TSN_PORT_STATE_BLOCKING,
>  	TSN_PORT_STATE_LISTENING,
>  	TSN_PORT_STATE_LEARNING,
>  	TSN_PORT_STATE_FORWARDING,
> +	/* Not an STP state. Writing it flushes the port's dynamic learnt
> +	 * entries and leaves static FDB entries in place.
> +	 */
> +	TSN_PORT_STATE_FLUSH,
>  };

[Severity: Medium]
What makes an entry static from the hardware's point of view here?

xlnx_tsn_cam_write() writes TSN_CAM_TV1_OFFSET and TSN_CAM_TV2_OFFSET as 0
and uses the plain TSN_CAM_OP_ADD opcode, i.e. the same record format the
now-enabled learning engine produces, so nothing distinguishes a
bridge-programmed entry from a learnt one. Can this comment's guarantee be
relied on?

Two consequences follow if it cannot:

  - xlnx_tsn_port_fast_age(), which DSA invokes on FORWARDING/LEARNING to
    DISABLED/BLOCKING/LISTENING transitions via dsa_port_set_state() ->
    dsa_port_fast_age(), can purge entries installed through
    .port_fdb_add
  - a spoofed source MAC can make the learning engine overwrite a
    bridge-programmed (MAC, VID) port list with the port the frame arrived
    on

Because xlnx_tsn_port_fdb_dump() reports every entry with is_static =
false, the bridge cannot observe either the loss or the override, so it
still believes its entries are offloaded and never reprograms them.

[ ... ]

Cross-instance finding from sashiko-gemini (96445ad11157158b46d97d25327595ed58d8d6812a15918739e8e9b5f82cb3e3):
[Severity: Medium]
Moving a static unicast FDB entry causes traffic duplication and information leak due to bitwise-ORing the port list.
