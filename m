Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1A4D598E;
	Mon, 19 Oct 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404532; cv=none; b=h/SGZpeElvQpykInSsIlNgDFGyvzSKYdCTmttlUAHsIcN4amW6iFet1mRtJJ78ue1KJt2g5VoT2n4ETNDL/hxEqxu0a+CIbBO13hfK+mynxVFQomOrcsMuz8m+hNHo9Wq8NAPp0gaZVZ7ALaQsH133rexE/rsmRSBcA8wBWFK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404532; c=relaxed/simple;
	bh=kUMKrgtZduGDbkzmVkEDtYIcrWGemZ7wB2J1B4nON1E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYXZgmL/rG8x0VTioxpGcIcTX7jvoGKBIGtRQzoh/qm3Fft/B5lgNTCT64iLccfKQAIfjl1H2E0M5cnr9wSUv83UEOWuclrycQIkPonNwcUlKBjFuijhkk3YWGrsdN8+cn8ScMUoR8kNfskHrBLNKAaBSavxofDsFKUN4HN4EXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlnaVEQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlnaVEQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7D1F000C5;
	Mon, 19 Oct 2026 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404531;
	bh=mwjpIm83yZZDJikQYkcCqyWisU4p950NOResx2zGuas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YlnaVEQrFNv2yRZpb8dAQCigR9GjRkD1E+QEtmdsD1lfgaaxwIu7+r/xGPiq1cy+Q
	 lVk9lw35+diUK1ZWs9i75zlJaXvIHBQGpoxuVLveo3veCpoDWIH7AbpFkI9Sv+3nnU
	 mj4LBSbhzCBvWt8Ao+nq4k+JCibq4UM08dV188/oDGtFmN6HHc/mV6yUpi/YtxDwZV
	 GGRFHlUN2sGMpl2gSFs9A7tlfPpFjr2UJo+j34S3Y0FZnL7xS+lriMj7UyQIbGcbDy
	 Qe7AQJHe662Vs4OPiOJqEES+g80hR+XNv9e9IjRvBKFFDRnyhNV7FmAsefMKSQE7L0
	 skpBmTMt2G/cg==
Subject: Re: [PATCH net-next v15 7/9] net: dsa: lan9645x: add mdb management
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 19 Oct 2026 10:08:49 +0000
Message-ID: <179240452954.3135.9522637981866659319@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-7-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-7-562f316f78b9@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver tracks only one membership bit per port per (MAC,
  VID).
- [Medium] When a mac table write fails, the code keeps an extra PGID
  reference on purpose so the index cannot be reused while hardware…
- [Medium] The out-of-PGIDs in-place branch of __lan9645x_mdb_del()
  rewrites only ANA_PGID(mdb_entry->pgid->index) and skips the mac table…
- [Low] The comment in lan9645x_setup() above the ANA_FLOODING_IPMC write
  says IP multicast "Control frames are redirected to CPU, and the…
- [Low] Two PGID destination-mask writes in the new mdb code never report
  failure.

--

net: dsa: lan9645x: add mdb management

This adds the DSA port_mdb_add/port_mdb_del callbacks for lan9645x. IP
multicast groups carry their port mask inline in the mac table entry. L2
multicast groups point at a refcounted PGID whose destination mask holds
the port group, and the MAC_CPU_COPY bit carries CPU membership. The patch
also redirects IGMP/MLD frames to the CPU and copies IPv4 multicast
control frames to it.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 058e47e58b9a8..d2e8c52e2a178 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -253,6 +255,17 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  			lan9645x, ANA_CPUQ_8021_CFG(i));
>  	}
>  
> +	/* Use CPU queues to communicate frame classification to the CPU */
> +	lan_rmw(ANA_CPUQ_CFG_CPUQ_MAC_COPY_SET(LAN9645X_CPUQ_DEF) |
> +		ANA_CPUQ_CFG_CPUQ_IGMP_SET(LAN9645X_CPUQ_TRAP) |
> +		ANA_CPUQ_CFG_CPUQ_MLD_SET(LAN9645X_CPUQ_TRAP) |
> +		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_SET(LAN9645X_CPUQ_COPY),
> +		ANA_CPUQ_CFG_CPUQ_MAC_COPY |
> +		ANA_CPUQ_CFG_CPUQ_IGMP |
> +		ANA_CPUQ_CFG_CPUQ_MLD |
> +		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL,
> +		lan9645x, ANA_CPUQ_CFG);

[Severity: Low]
This isn't a bug, but does the comment above the ANA_FLOODING_IPMC write
earlier in lan9645x_setup() still match what this patch configures?

	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
	 * use the same masks. Control frames are redirected to CPU, and
	 * the network stack is responsible for forwarding these.
	 * The dataplane is forwarding according to the offloaded MDB entries.
	 */

Only IGMP and MLD are redirected, through IGMP_REDIR_ENA/MLD_REDIR_ENA
and LAN9645X_CPUQ_TRAP. Other IPv4 multicast control frames are only
copied, through IPMC_CTRL_COPY_ENA and LAN9645X_CPUQ_COPY. The hardware
still floods them through MC4_CTRL = PGID_MC.

lan9645x_offload_fwd_mark() in net/dsa/tag_lan9645x.c only clears the
mark for TRAP frames:

	if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
		skb->offload_fwd_mark = 0;
		return;
	}

	dsa_default_offload_fwd_mark(skb);

So copied frames keep offload_fwd_mark set on bridged ports, and the
software bridge does not forward them. IPv6 control frames other than MLD
are neither redirected nor copied.

An earlier patch added the comment, but this patch implements the
behaviour it describes, and the comment is still unchanged at the end of
the series. Could it describe the redirect/copy split instead?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> new file mode 100644
> index 0000000000000..ca333d43904fd
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> @@ -0,0 +1,582 @@

[ ... ]

> +static struct lan9645x_pgid_entry *
> +lan9645x_pgid_entry_alloc(struct lan9645x *lan9645x, int index, u16 ports)
> +{

[ ... ]

> +	lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
> +		ANA_PGID_PGID, lan9645x,
> +		ANA_PGID(pgid_entry->index));
> +
> +	return pgid_entry;
> +}

[Severity: Low]
What happens if this write fails while an index is being reused?
lan_rmw() returns void and only does WARN_ON_ONCE() when
regmap_update_bits() fails.

lan9645x_pgid_entry_put() deliberately leaves the old mask in hardware and
depends on this rewrite:

	/* Leave the destination mask programmed in HW. Reusing the index
	 * rewrites the mask in lan9645x_pgid_entry_alloc() before anything
	 * points at it.
	 */

If the rewrite fails, the next CMD_LEARN points the group at an index
that still holds the previous group's port mask. Later lookups by the
software ports value would then share that wrongly programmed PGID.

The in-place branch of __lan9645x_mdb_del() has the same problem. It
updates mdb_entry->pgid->ports and mdb_entry->ports, does an unchecked
lan_rmw() of ANA_PGID, and returns 0. If that write fails, the departed
port stays in the hardware mask, and the bridge never retries the delete.

This follows the WARN_ON_ONCE convention of lan_wr()/lan_rmw() across the
driver. The mdb code does treat register bus failures as real elsewhere,
though: the PGID retention and the CMD_FORGET cleanup. Should these two
writes report errors as well?

[ ... ]

> +static int lan9645x_mdb_widen_dest(struct lan9645x *lan9645x,
> +				   struct lan9645x_mdb_entry *mdb_entry,
> +				   enum macaccess_entry_type type,
> +				   struct lan9645x_pgid_entry *new_pgid,
> +				   int pgid_index, u16 new_ports)
> +{
> +	struct lan9645x_pgid_entry *old_pgid = mdb_entry->pgid;
> +	int err;
> +
> +	lockdep_assert_held(&lan9645x->mdb_lock);
> +
> +	err = lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_index,
> +				      new_ports);
> +	if (err) {
> +		dev_err(lan9645x->dev,
> +			"Widening %pM vid %u to mask 0x%x returned %pe\n",
> +			mdb_entry->mac, mdb_entry->vid, new_ports,
> +			ERR_PTR(err));
> +		/* A failed write leaves the hardware state unknown, the mac
> +		 * entry may point at old_pgid or new_pgid. Keep the reference
> +		 * taken on new_pgid, so its index cannot be handed to an
> +		 * unrelated group. If the entry already holds new_pgid, e.g.
> +		 * when the CPU port module joins, drop the extra reference.
> +		 */
> +		if (new_pgid == old_pgid)
> +			lan9645x_pgid_entry_put(lan9645x, new_pgid);
> +		return err;
> +	}

[Severity: Medium]
When new_pgid != old_pgid, the reference from
lan9645x_mdb_pgid_entry_get() is kept, but mdb_entry->pgid still points
at old_pgid. What drops that reference later?

Nothing records it, so refcount_dec_and_test() in
lan9645x_pgid_entry_put() can never reach zero for it. If a later add
with the same mask succeeds, lan9645x_mdb_pgid_entry_lookup() adopts the
orphan with refcount_inc(), and the extra count becomes permanent.

The same pattern appears in three other places.

lan9645x_mdb_narrow_dest() returns without putting old_pgid, after it has
already replaced mdb_entry->pgid:

		if (old_pgid != new_pgid)
			return;

__lan9645x_mdb_add() skips the put when the cleanup CMD_FORGET also
fails, then frees the entry:

		if (!lan9645x_mact_forget(lan9645x, mdb_entry->mac,
					  mdb_entry->vid, type))
			lan9645x_pgid_entry_put(lan9645x, new_pgid);
		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);

__lan9645x_mdb_del() clears the only pointer to the PGID before dealloc
when CMD_FORGET fails for the last port:

			mdb_entry->pgid = NULL;

In each case the pgid entry stays on pgid_entries and blocks its index in
lan9645x_mdb_pgid_entry_create() until lan9645x_mdb_deinit(). That holds
even after a later successful CMD_LEARN or CMD_FORGET for that (mac, vid)
shows that hardware no longer uses the index.

Can repeated mac table errors use up the PGID_GP_START..PGID_GP_END range
this way? New L2 groups would then fail with -ENOSPC or fall back to
flooding. This code is unchanged at the end of the series.

[ ... ]

> +static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
> +			      const unsigned char addr[ETH_ALEN], u16 vid,
> +			      enum macaccess_entry_type type)
> +{

[ ... ]

> +	if (mdb_entry->ports & BIT(chip_port))
> +		return 0;

[Severity: Medium]
Can a port lose membership here when two IP groups map to the same MAC?

br_switchdev_mdb_populate() turns IP groups into MACs with
ip_eth_mc_map()/ipv6_eth_mc_map(). For example, 239.1.1.1 and
239.129.1.1 both become 01:00:5e:01:01:01. For user ports,
dsa_port_do_mdb_add()/dsa_port_do_mdb_del() pass every notification
straight to the driver, with no refcounting.

If port P joins both groups on the same VID, the second add returns here
and nothing records it. A later delete of either group then runs this in
__lan9645x_mdb_del():

	new_ports = mdb_entry->ports & ~BIT(chip_port);

That removes P. If another port Q is still a member, the MACV4/MACV6
entry is rewritten with only Q, and P stops receiving a group it still
belongs to. offload_fwd_mark is set, so the software bridge does not
forward these frames either.

At this commit the path cannot be reached: there is no bridge offload
yet, and DSA refcounts CPU-port host entries. It becomes reachable with
"net: dsa: lan9645x: add bridge support", and lan9645x_mdb.c is unchanged
at the end of the series. mscc/ocelot has the same limitation.

Should the entry keep a per-port count instead of a single bit?

[ ... ]

> +static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port,
> +			      const unsigned char addr[ETH_ALEN], u16 vid,
> +			      enum macaccess_entry_type type)
> +{

[ ... ]

> +	 * PGID this entry already points at. So the departing port is a front
> +	 * port, and the mac table entry, which only carries the PGID index and
> +	 * MAC_CPU_COPY, does not need rewriting.
> +	 *
> +	 * refcount_read is safe because mdb_lock serializes every get and put
> +	 * of a PGID entry.
> +	 */
> +	if (mdb_entry->pgid && refcount_read(&mdb_entry->pgid->refcount) == 1) {
> +		mdb_entry->pgid->ports = new_ports &
> +					 ~BIT(lan9645x->num_phys_ports);
> +		mdb_entry->ports = new_ports;
> +
> +		lan_rmw(ANA_PGID_PGID_SET(mdb_entry->pgid->ports),
> +			ANA_PGID_PGID,
> +			lan9645x, ANA_PGID(mdb_entry->pgid->index));
> +
> +		return 0;
> +	}

[Severity: Medium]
This branch rewrites only ANA_PGID(mdb_entry->pgid->index). It assumes
that the hardware DEST_IDX matches mdb_entry->pgid. Does that still hold
after a failed widen? The comment in lan9645x_mdb_widen_dest() says it
might not:

		/* A failed write leaves the hardware state unknown, the mac
		 * entry may point at old_pgid or new_pgid. Keep the reference
		 * taken on new_pgid, ...

Consider this sequence:

1. A widen fails after the CMD_LEARN has reached the analyzer. Hardware
   now uses new_pgid (the old ports plus the joining port), while
   software keeps old_pgid.

2. A front port leaves while the PGID pool is exhausted, and old_pgid has
   refcount 1. Exhaustion is more likely here because the reference kept
   on new_pgid holds a slot.

3. This branch narrows only old_pgid's mask.

Hardware still forwards through new_pgid's mask, while this function
returns 0. So the departed port and the port whose join was refused both
keep receiving the group.

lan9645x_mdb_narrow_dest() would recover by reissuing CMD_LEARN with a
known index, but this path never does. Should this branch rewrite the mac
table entry as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
