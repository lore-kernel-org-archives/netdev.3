Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC6468C15;
	Mon, 12 Oct 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804287; cv=none; b=ULgB1wbxfUwQBkuc0ysQbtLFKItCyphJGf8lVb8QwMDk3xT9GOyYJ6ngl5dMStWjuHmp9quA776RNC6+EIF10TU3QWxm9UGIF84UPOasSUCaTmr3yXkuCJEJNMdqMXztG1RZYpnVQjNFn4NwnaTXhLLoAhTPF4L2d0U4/fYtvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804287; c=relaxed/simple;
	bh=qXCjsSajxYUZt5jb5tBqFNdLNGNE6VrZEUE6rneziFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1KW/G9T1TROEUlQenJfQcOxC9KVCKVLCleoczeWp0kJdTO3XpCRKJdN92GQA602vanLxXU7hOP86uDRv4YcpVPWfCx8YsxAUERc5Sk8YK7c9fvYDLwGJ8NA1BEwmTXrKh135eiihgyBEBiawrgz4KJcSGsUfhfxZqtM9v/nPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzHtgtTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzHtgtTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FED1F0089B;
	Mon, 12 Oct 2026 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804286;
	bh=X30SNXknF9NI/g34Cw2nk704NrABhgP7NkOGB9Vd1rs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SzHtgtTSmNPbxRUOuMPyDJlbKIUzDvb8sa9hOUxOvLcC8mYwVZJtRRtZAwqP3VSkB
	 S4PDVFknA3wanvUxw7gn/dFDr7uGv248CWGkUdK+QchNq8FShtKOsVTUj/mpWRXKsX
	 SK9dJGHXXdNrAXGYgPFxKHfkM0YWPw+jTL4Ljlbqsf0lWVNWLfLzCr36hjmr9hExUO
	 YG6Tm2GRbg1OcPjtwgWa2KHatCkDEBQGrSYWwsqs2IUL+y/BTBs+ILPos6+u/7tiTX
	 c8QwNu5SZ5L0vBCtOfo+PQckDw9POMHVeNalXtvMOxHGrAEt85QWiK4F5xflpSUqi8
	 vMps7DS6WPxjA==
Subject: Re: [PATCH net-next v14 7/9] net: dsa: lan9645x: add mdb management
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
Date: Mon, 12 Oct 2026 11:24:44 +0000
Message-ID: <179180428452.434549.6426245799435607203@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-7-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-7-3d2a72661213@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Separate IP multicast groups that map to the same multicast
  MAC collapse into one per-port bit, so leaving one group removes…
- [Medium] Several error paths deliberately keep a PGID reference, but
  nothing owns it afterwards and it is only freed in…
- [Low] A comment in lan9645x_setup()
  (drivers/net/dsa/microchip/lan9645x/lan9645x_main.c, lines 210-214,…
- [Low] PGID destination-mask writes in lan9645x_pgid_entry_alloc() and
  in the overwrite-in-place branch of __lan9645x_mdb_del() go through…

--

net: dsa: lan9645x: add mdb management

This patch adds .port_mdb_add and .port_mdb_del support to the lan9645x DSA
driver. IP multicast entries store the port mask inline in the mac table
entry. L2 multicast entries point at a refcounted PGID, and CPU membership
is carried by MAC_CPU_COPY. The patch also redirects IGMP and MLD to the
CPU and copies IPv4 multicast control frames to it.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index c55161f8bafff..a0f48f3ad9aff 100644
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
> +

[Severity: Low]

Is the comment above the ANA_FLOODING_IPMC write in lan9645x_setup() still
accurate after this change?

lan9645x_setup() {
    ...
	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
	 * use the same masks. Control frames are redirected to CPU, and
	 * the network stack is responsible for forwarding these.
    ...
}

This patch copies IPv4 multicast control frames to the CPU instead of
redirecting them. lan9645x_port_setup() sets
ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA, and IPMC_CTRL is mapped to
LAN9645X_CPUQ_COPY here.

lan9645x_offload_fwd_mark() in net/dsa/tag_lan9645x.c only clears
skb->offload_fwd_mark for LAN9645X_CPUQ_TRAP:

	if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
		skb->offload_fwd_mark = 0;
		return;
	}

So the hardware forwards these copied frames through
FLD_MC4_CTRL=PGID_MC, and the stack does not. Only IGMP and MLD are
redirected.

The commit message gets this right. Could the code comment be updated to
match?

>  	/* Reserve 1664 bytes, 26 buffer cells, per (port, prio) for source
>  	 * tracking (resource 0, indices 0..95) and destination tracking
>  	 * (resource 2, indices 512..607). These are access watermarks, not

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

> +	dev_dbg(lan9645x->dev, "index=%d ports=0x%x\n", pgid_entry->index,
> +		pgid_entry->ports);
> +
> +	lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
> +		ANA_PGID_PGID, lan9645x,
> +		ANA_PGID(pgid_entry->index));
> +
> +	return pgid_entry;
> +}

[Severity: Low]

lan9645x_pgid_entry_put() leaves the old destination mask in hardware on
purpose and relies on this write to replace it when the index is reused.
lan_rmw() only does WARN_ON_ONCE() when regmap_update_bits() fails, and
lan9645x_pgid_entry_alloc() returns success either way.

If this write is lost, would the new group forward to the previous group's
ports?

The overwrite in place branch in __lan9645x_mdb_del() has the same shape.
It updates mdb_entry->pgid->ports before an unchecked lan_rmw(), so the
departing port would keep receiving traffic.

This follows the lan_wr()/lan_rmw() convention used across the driver, and
in lan966x and ocelot too. It is also not clear that this regmap can fail
at all. So this is more of a hardening question than a defect in the mdb
logic.

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

[ ... ]

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
> +	mdb_entry->pgid = new_pgid;
> +	mdb_entry->ports = new_ports;
> +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +	return 0;
> +}

[Severity: Medium]

If lan9645x_mdb_write_dest() fails and new_pgid != old_pgid, the reference
on new_pgid is kept but never stored in mdb_entry->pgid. What drops it
later?

Later successful updates only put mdb_entry->pgid, so this reference seems
to be released only in lan9645x_mdb_deinit().

A few other error paths do the same.

lan9645x_mdb_narrow_dest() switches mdb_entry->pgid to new_pgid before the
write. On failure it returns without putting old_pgid:

		if (old_pgid != new_pgid)
			return;

In __lan9645x_mdb_del(), when CMD_FORGET fails for the last port:

			mdb_entry->pgid = NULL;
		}
		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);

In __lan9645x_mdb_add(), when both the learn and the cleanup forget fail
for a fresh entry, the new_pgid reference is kept and the mdb entry is
freed.

Each transient ANA_MACACCESS poll timeout or regmap read error would then
use up one index from the PGID_GP_START..PGID_GP_END pool for good. A
shared PGID that holds an orphaned reference can also never get back to
refcount 1, which disables the overwrite in place branch in
__lan9645x_mdb_del().

The v14 changelog explains why the reference is held while the hardware
state is uncertain. Is there anything that releases it once a later
successful CMD_LEARN or CMD_FORGET for the same (mac, vid) makes the state
known again? Without that, could L2 multicast adds eventually fail with
-ENOSPC?

[ ... ]

> +static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port,
> +			      const unsigned char addr[ETH_ALEN], u16 vid,
> +			      enum macaccess_entry_type type)
> +{

[ ... ]

> +	mdb_entry = lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> +	if (!mdb_entry) {
> +		mdb_entry = lan9645x_mdb_entry_alloc(lan9645x, addr, vid);
> +		if (IS_ERR(mdb_entry))
> +			return PTR_ERR(mdb_entry);
> +	}
> +
> +	if (mdb_entry->ports & BIT(chip_port))
> +		return 0;

[Severity: Medium]

What happens when two IP groups on the same port map to the same multicast
MAC?

br_switchdev_mdb_populate() converts each group with ip_eth_mc_map() or
ipv6_eth_mc_map(). For example, 239.1.1.1 and 239.129.1.1 both become
01:00:5e:01:01:01.

For user ports, DSA passes the call straight to the driver without
refcounting:

net/dsa/switch.c:dsa_port_do_mdb_add() {
    ...
	/* No need to bother with refcounting for user ports */
	if (!(dsa_port_is_cpu(dp) || dsa_port_is_dsa(dp))) {
		err = ds->ops->port_mdb_add(ds, port, mdb, db);
    ...
}

The second join returns 0 here and nothing records it. When the first
group leaves or expires, __lan9645x_mdb_del() runs:

	new_ports = mdb_entry->ports & ~BIT(chip_port);

It then either narrows the destination or forgets the entry. Does the port
then stop receiving traffic for the group it is still a member of?

The bridge does not send another add while the remaining group keeps being
refreshed. The loss would last until that group expires and is created
again. With the bridge support patch later in the series, ordinary
IGMP/MLD snooping looks like enough to trigger this.

Does the mdb entry need a per-port membership count here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
