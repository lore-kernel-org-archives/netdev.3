Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F493A254B;
	Sat,  8 Aug 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218517; cv=none; b=mkWxmSZJsEWUTxOng/lbiL1bHOZVQuzxq2JUJdg5JrR65mg70Ht9twttPYXz0ZxT6gAhZpM7aJaNcyMSZ8UbfHLXzV60xk0LGtpbNPzxvR42nRaDPmlcc/jvWY4sx/mckNWQuvr8rkbkLGHFgTdCwSxZ/xRzwsG85iXk1bgOvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218517; c=relaxed/simple;
	bh=4rHuWb9A76u//6G5LXF/8l1h8IX8jSnAVJaR3WTS4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvWP8EO2i7g/9+KjvGm+N3ppBwETAhe6JPFHvHGFq3FX6lsAOH0lJycetGzlHbe6SeoGVeojecBVG10/5Z26vexpnQr3+IYnhfn60tNbGdXxAwb/IAE0bAOUZv4XjCCvQgThIy7crNn7BbKiMyzFE62OZm/uWn7jjiPwHmZHNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn+IX1W8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn+IX1W8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C2A1F00A3F;
	Sat,  8 Aug 2026 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218512;
	bh=LCY+o32WZN7MPKYBzkzoFaoG1fdZW6fSOoVxY2N9hPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wn+IX1W8N/HBdGlAzrCLQVJdA8/H7xQFrbeiPr2p7SFfPCvshGRp1DD2v15FmzFCI
	 GaL4E2e7BDZsHBD2wzGGSRMrZ113hop17DYhtboMIN9H9zfu3Dd5D7OIiUirutq83p
	 +Ro+nu1itA64xUCE6gGn8PAb6wP3LiNQCPwjZLuj3+ESOXgXYUxyp6zb1s0aCJJN63
	 APufyGgSQXxtjJP8w3gUWlsTd6imFpn216zVCpT0Edpx7ZVIaxqNy1bCdwNq5Xd8Eq
	 Xmw5dIVUJhAVPXjT7FuOH9dmcbQHxJcoNdZJSUsmqhArLpYq6o1EA4fC9WJKQOfk5H
	 O/iVkSqc7QnBw==
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
Subject: Re: [PATCH 14/20] net: dsa: xilinx: program MAC frame filter and per-port nibbles
Date: Sat,  8 Aug 2026 12:48:31 -0700
Message-ID: <20260808194831.133226-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-15-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-15-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: program MAC frame filter and per-port nibbles

This programs the switch fabric's 48-bit unicast frame filter from the DSA
conduit MAC, wildcarding the low nibble of byte 5, and fills that nibble in
per-port fields of the Switch Port State Control register. A netdev notifier
drives the programming on NETDEV_REGISTER/NETDEV_CHANGEADDR, and
port_set_mac_address rejects addresses that break the prefix or nibble rules.

A few questions below on the notifier lifetime, the nibble uniqueness rule and
the register access protocol.

> Drive all of this from a netdev notifier. On the conduit's
> NETDEV_REGISTER, derive the prefix, program the frame filter, and
> set the CPU port nibbles for all ports. Handle NETDEV_REGISTER for
> each swpN to set its nibble.

[Severity: Low]

Is "to set its nibble" the whole story for the swpN NETDEV_REGISTER path?

xlnx_tsn_handle_user_register() also rewrites the user netdev's MAC with
dev_addr_mod() in two of its three branches (prefix mismatch, and address
equal to the conduit MAC).

The commit message also does not mention NETDEV_CHANGEADDR handling, yet
xlnx_tsn_netdev_event() handles it for both the conduit and the user ports,
and the conduit case unconditionally overwrites every user port's MAC with a
synthesized address - including an address that xlnx_tsn_port_set_mac_address()
previously validated and accepted from an administrator.

Could the message describe the MAC overriding and the CHANGEADDR handling?

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 86aba2e8b6e9..9826f006b078 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -33,6 +35,74 @@ static u32 sw_ior(struct xlnx_tsn *sw, u32 off)
>  	return ioread32(sw->sw_base + off);
>  }
>  
> +/* Cache the conduit MAC with byte 5's low nibble zeroed out. The
> + * frame-filter mask covers those 4 bits. The per-port MAC-nibble
> + * fields in +0x004C supply the actual values.
> + */
> +static void xlnx_tsn_derive_prefix(struct xlnx_tsn *sw)
> +{
> +	memcpy(sw->mac_prefix, sw->conduit->dev_addr, ETH_ALEN);
> +	sw->mac_prefix[5] &= ~TSN_SW_MAC_NIBBLE_WILDCARD;
> +}
> +
> +static void xlnx_tsn_program_frame_filter(struct xlnx_tsn *sw)
> +{
> +	const u8 *p = sw->mac_prefix;
> +	u32 lsb, msb;
> +
> +	lsb = ((u32)p[2] << 24) | ((u32)p[3] << 16) |
> +	      ((u32)p[4] << 8) | p[5];
> +	msb = FIELD_PREP(TSN_SW_MAC_MSB_MASK_MASK, TSN_SW_MAC_NIBBLE_WILDCARD) |
> +	      FIELD_PREP(TSN_SW_MAC_MSB_ADDR_MASK,
> +			 ((u32)p[0] << 8) | p[1]);
> +
> +	sw_iow(sw, TSN_SW_MAC_LSB_OFFSET, lsb);
> +	sw_iow(sw, TSN_SW_MAC_MSB_OFFSET, msb);
> +}
> +
> +/* True when addr's upper 44 bits match the cached prefix. The
> + * prefix has byte 5's low nibble already cleared, so byte 5 of addr
> + * is masked the same way before comparison.
> + */
> +static bool xlnx_tsn_prefix_matches(struct xlnx_tsn *sw, const u8 *addr)
> +{
> +	if (memcmp(addr, sw->mac_prefix, ETH_ALEN - 1) != 0)
> +		return false;
> +
> +	return (addr[5] & ~TSN_SW_MAC_NIBBLE_WILDCARD) == sw->mac_prefix[5];
> +}
> +
> +static int xlnx_tsn_set_port_mac_nibble(struct xlnx_tsn *sw, int port,
> +					u8 nibble)
> +{
> +	u32 mask, new_field, reg;
> +
> +	nibble &= TSN_SW_MAC_NIBBLE_WILDCARD;
> +
> +	switch (port) {
> +	case XLNX_TSN_CPU_PORT:
> +		mask = EP_PORT_MAC_NIBBLE_MASK;
> +		new_field = FIELD_PREP(EP_PORT_MAC_NIBBLE_MASK, nibble);
> +		break;
> +	case XLNX_TSN_PORT_MAC1:
> +		mask = MAC1_PORT_MAC_NIBBLE_MASK;
> +		new_field = FIELD_PREP(MAC1_PORT_MAC_NIBBLE_MASK, nibble);
> +		break;
> +	case XLNX_TSN_PORT_MAC2:
> +		mask = MAC2_PORT_MAC_NIBBLE_MASK;
> +		new_field = FIELD_PREP(MAC2_PORT_MAC_NIBBLE_MASK, nibble);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
> +	reg = (reg & ~mask) | new_field;
> +	sw_iow(sw, TSN_PORT_STATE_CTRL_OFFSET, reg);

[Severity: Medium]

Should this read-modify-write of the Switch Port State Control register follow
the same protocol as the other accessor of the same address?

xlnx_tsn_set_port_state() gates every access on the readiness bit and refuses
to touch the word while a change-commit bit is still pending:

  err = xlnx_tsn_switch_status_ready(sw);
  if (err) { ... return err; }

  /* Bit won't re-arm if a previous change never cleared it. */
  val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
  if (val & chg_bit) { ... return -EBUSY; }

and the header itself says of TSN_SW_STATUS_READY: "Poll this before changing
port state."

xlnx_tsn_set_port_mac_nibble() does neither, and it writes the word back with
the EP/MAC1/MAC2 change-commit bits and STP status fields unmasked.

If an earlier xlnx_tsn_set_port_state() returned -ETIMEDOUT with a chg bit
still set, does this write-back re-assert that write-1-to-commit bit and
re-commit whatever STP state happens to be in the word?

Both callers, xlnx_tsn_handle_conduit_changeaddr() and the NETDEV_CHANGEADDR
branch of xlnx_tsn_netdev_event(), discard the return value, so if the write
is dropped the nibble field stays at its reset value while dev_addr claims a
different nibble. Would it be worth propagating the error here?

>  static int xlnx_tsn_switch_status_ready(struct xlnx_tsn *sw)
>  {
>  	u32 reg;
> @@ -287,6 +357,112 @@ static int xlnx_tsn_mdio_register_all(struct xlnx_tsn *sw)
>  	return ret;
>  }
>  
> +/* Build a per-port MAC from the shared prefix. */
> +static void xlnx_tsn_synth_port_mac(struct xlnx_tsn *sw, int port,
> +				    u8 *out)
> +{
> +	u8 ep_nibble = sw->conduit->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
> +
> +	memcpy(out, sw->mac_prefix, ETH_ALEN);
> +	out[5] |= (ep_nibble + port) & TSN_SW_MAC_NIBBLE_WILDCARD;
> +}
> +
> +static int xlnx_tsn_user_port_index(struct xlnx_tsn *sw,
> +				    const struct net_device *dev)
> +{
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, &sw->ds)
> +		if (dp->user == dev)
> +			return dp->index;
> +
> +	return -1;
> +}
> +
> +static int xlnx_tsn_handle_user_register(struct xlnx_tsn *sw,
> +					 struct net_device *dev, int port)
> +{
> +	u8 want[ETH_ALEN];
> +	u8 nibble;
> +
> +	if (!xlnx_tsn_prefix_matches(sw, dev->dev_addr)) {
> +		xlnx_tsn_synth_port_mac(sw, port, want);
> +		dev_warn(sw->dev,
> +			 "port %d: MAC %pM does not match conduit prefix; overriding to %pM\n",
> +			 port, dev->dev_addr, want);
> +		dev_addr_mod(dev, 0, want, ETH_ALEN);

[Severity: Low]

Does this discard a MAC address that the binding says is valid device tree?

In Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml,
"^switch@" is declared as:

  $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports

and both port@0 and "^port@[1-2]$" are declared with
"additionalProperties: true", so the inherited dsa-port properties, including
local-mac-address and mac-address, are accepted on those nodes. DSA core reads
and applies them:

  net/dsa/dsa.c:dsa_port_setup()
      of_get_mac_address(dp->dn, dp->mac);
  net/dsa/user.c:dsa_user_create()
      eth_hw_addr_set(user_dev, port->mac);

A DT-supplied port address is then honoured only if it happens to share the
conduit's 44-bit prefix. Should the binding document that constraint, or should
the driver reject the DT instead of overriding it?

Also, dev_addr_mod() does not touch dev->perm_addr, so does ethtool -P swpN
(and IFLA_PERM_ADDRESS) keep reporting the discarded address while dev_addr
holds the synthesized one?

> +		nibble = want[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
> +	} else if (ether_addr_equal(dev->dev_addr, sw->conduit->dev_addr)) {
> +		/* Either DSA inherited the conduit MAC, or DT gave port@N
> +		 * the same address explicitly. Either way, assign a unique
> +		 * per-port nibble.
> +		 */
> +		xlnx_tsn_synth_port_mac(sw, port, want);
> +		dev_addr_mod(dev, 0, want, ETH_ALEN);
> +		nibble = want[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
> +	} else {
> +		nibble = dev->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
> +	}
> +
> +	return xlnx_tsn_set_port_mac_nibble(sw, port, nibble);
> +}

[Severity: High]

Can the two ports end up with the same nibble here?

The commit message says "The nibble is the only thing that tells ports apart
once the top 44 bits are shared", but the uniqueness check only exists in
xlnx_tsn_port_set_mac_address(). Neither of the paths that actually program the
hardware fields checks it:

- the final else branch above takes dev->dev_addr[5] & 0xf verbatim
- xlnx_tsn_synth_port_mac() computes (ep_nibble + port) & 0xf without looking
  at nibbles already claimed by the other port

Consider a device tree where port@1 has a local-mac-address sharing the
conduit prefix with low nibble (ep_nibble + 2) & 0xf, and port@2 has no DT
address. dsa_user_create() gives port@2 the conduit address:

  net/dsa/user.c:dsa_user_create()
      if (!is_zero_ether_addr(port->mac))
              eth_hw_addr_set(user_dev, port->mac);
      else
              eth_hw_addr_inherit(user_dev, conduit);

On NETDEV_REGISTER, port@1 takes the else branch and keeps
(ep_nibble + 2) & 0xf; port@2 takes the ether_addr_equal() branch and
xlnx_tsn_synth_port_mac() produces (ep_nibble + 2) & 0xf as well. Two
prefix-matching DT addresses with the same low nibble collide the same way.

MAC1_PORT_MAC_NIBBLE_MASK and MAC2_PORT_MAC_NIBBLE_MASK then hold the same
value, with no warning, and both callers discard the helper's return value.
With TSN_SW_MGMT_QUEUING_EP_SA_EGRESS now enabled, does the fabric still have
any way to tell the two wire ports apart?

Userspace attempting to reach this state through ip link would be refused with
-EADDRINUSE, so should the register and changeaddr paths enforce the same rule
that xlnx_tsn_port_set_mac_address() does?

> +
> +static void xlnx_tsn_handle_conduit_changeaddr(struct xlnx_tsn *sw)
> +{
> +	struct dsa_port *dp;
> +
> +	xlnx_tsn_derive_prefix(sw);
> +	xlnx_tsn_program_frame_filter(sw);
> +	xlnx_tsn_set_port_mac_nibble(sw, XLNX_TSN_CPU_PORT,
> +				     sw->conduit->dev_addr[5]);
> +
> +	dsa_switch_for_each_user_port(dp, &sw->ds) {
> +		u8 want[ETH_ALEN];
> +
> +		if (!dp->user)
> +			continue;
> +
> +		xlnx_tsn_synth_port_mac(sw, dp->index, want);
> +		dev_addr_mod(dp->user, 0, want, ETH_ALEN);

[Severity: Medium]

Does changing the user port's address out of band leak an entry from the
conduit's unicast address list?

DSA keys the conduit uc entry and the standalone host FDB entry on the user
port's dev_addr:

  net/dsa/user.c:dsa_user_open()
      err = dsa_user_host_uc_install(dev, dev->dev_addr);

and the sanctioned way to change it installs the new address before removing
the old one:

  net/dsa/user.c:dsa_user_set_mac_address()
      err = dsa_user_host_uc_install(dev, addr->sa_data);
      if (err)
              return err;

      dsa_user_host_uc_uninstall(dev);
      ...
      eth_hw_addr_set(dev, addr->sa_data);

git grep NETDEV_CHANGEADDR net/dsa/ finds no handler, so nothing in DSA
re-syncs the conduit uc list from the notifier this driver emits. After
ip link set <conduit> address ... with swp1 up, the conduit list still holds
the old address and never learns the new one. On port close:

  net/dsa/user.c:dsa_user_host_uc_uninstall()
      if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
              dev_uc_del(conduit, dev->dev_addr);

dev_uc_del() is then called with the new address, which was never added, so
does the netdev_hw_addr entry for the old address leak and leave the conduit's
promiscuity/uc_promisc count unbalanced?

Would going through dsa_user_set_mac_address() (or at least calling
dsa_user_host_uc_install()/dsa_user_host_uc_uninstall() around this) be
preferable to dev_addr_mod()?

> +		call_netdevice_notifiers(NETDEV_CHANGEADDR, dp->user);

[Severity: Low]

The two sites in this patch that rewrite a user port's dev_addr disagree on
whether the stack has to be told. This one follows dev_addr_mod(dp->user, ...)
with call_netdevice_notifiers(NETDEV_CHANGEADDR, dp->user), while
xlnx_tsn_handle_user_register() performs the identical mutation with no
notification at all.

Is one of the two wrong? Neither site updates dev->perm_addr or
dev->addr_assign_type, and neither goes through the driver's own
xlnx_tsn_port_set_mac_address() validation.

The register-time site also runs mid-walk of netdev_chain, from the
NETDEV_REGISTER replay inside register_netdevice_notifier(), so notifier blocks
already invoked for that device have recorded the pre-override address.

> +	}
> +}
> +
> +static int xlnx_tsn_netdev_event(struct notifier_block *nb,
> +				 unsigned long event, void *ptr)
> +{
> +	struct xlnx_tsn *sw = container_of(nb, struct xlnx_tsn, nb);
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	int port;

[ ... ]

> +	return NOTIFY_DONE;
> +}
> +
>  static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
>  						       int port,
>  						       enum dsa_tag_protocol mp)
> @@ -294,6 +470,30 @@ static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
>  	return DSA_TAG_PROTO_XLNX_TSN;
>  }
>  
> +static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
> +					 const unsigned char *addr)
> +{
> +	u8 nibble = addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
> +	struct xlnx_tsn *sw = ds->priv;
> +	struct dsa_port *dp;
> +
> +	if (!xlnx_tsn_prefix_matches(sw, addr))
> +		return -EINVAL;
> +
> +	if (nibble == (sw->conduit->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD))
> +		return -EADDRINUSE;

[Severity: Medium]

dsa_user_set_mac_address() propagates this error verbatim:

  net/dsa/user.c:dsa_user_set_mac_address()
      if (ds->ops->port_set_mac_address) {
              ...
              if (err)
                      return err;
      }

so does that make some standard operations fail on swpN?

- ip link set swp1 address <externally assigned MAC> returns -EINVAL
- ip link set swp1 master bond0 fails, because bond_enslave() programs the
  slave MAC to the bond MAC via dev_set_mac_address() and the bond address
  does not share the conduit prefix
- ip link set swp1 address <conduit MAC>, i.e. the default that
  dsa_user_create() installs itself, can never be restored once the driver has
  overridden it, because of the -EADDRINUSE above

If this is an unavoidable property of the fabric (ports differ only in the low
nibble), could the commit message and the binding say so explicitly? No other
DSA driver imposes this restriction today.

> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->index == port || !dp->user)
> +			continue;
> +
> +		if ((dp->user->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD) == nibble)
> +			return -EADDRINUSE;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -426,8 +626,10 @@ static const struct phylink_mac_ops xlnx_tsn_phylink_mac_ops = {
>  
>  static int xlnx_tsn_setup(struct dsa_switch *ds)
>  {
> +	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);
>  	struct xlnx_tsn *sw = ds->priv;
>  	struct dsa_port *dp;
> +	u32 mgmt;
>  	int ret;
>  
>  	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
> @@ -435,6 +637,19 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  		return dev_err_probe(sw->dev, -EINVAL,
>  				     "both MAC1 and MAC2 must be enabled as switch ports\n");
>  
> +	if (!cpu_dp || !cpu_dp->conduit)
> +		return -ENODEV;
> +
> +	sw->conduit = cpu_dp->conduit;
> +
> +	/* Route CPU-originated bridge-group control frames (STP, LLDP) to
> +	 * the single wire port whose MAC-nibble field matches the frame's
> +	 * source-MAC low nibble, instead of flooding to both.
> +	 */
> +	mgmt = sw_ior(sw, TSN_SW_MGMT_QUEUING_OFFSET);
> +	mgmt |= TSN_SW_MGMT_QUEUING_EP_SA_EGRESS;
> +	sw_iow(sw, TSN_SW_MGMT_QUEUING_OFFSET, mgmt);

[Severity: Low]

Is TSN_SW_MGMT_QUEUING_EP_SA_EGRESS ever cleared again?

xlnx_tsn_teardown() unregisters the notifier, unregisters MDIO and moves the
ports to DISABLED, but leaves this bit set, leaves the 48-bit DA filter written
by xlnx_tsn_program_frame_filter() in place, and leaves the per-port
MAC-nibble fields programmed. The setup error paths below (port-state
programming, MDIO registration, notifier registration) also return with the bit
set.

After teardown the fabric is left with SA-nibble egress steering armed and a
stale 44-bit DA prefix filter that nobody updates any more, since the notifier
that tracked conduit NETDEV_CHANGEADDR is gone. Should teardown and the setup
unwind clear these?

>  	/* CPU port stays in FORWARDING so host traffic always flows.
>  	 * User ports start in DISABLED and transition from there under
>  	 * bridge STP control.
> @@ -451,7 +666,20 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
>  			return ret;
>  	}
>  
> -	return xlnx_tsn_mdio_register_all(sw);
> +	ret = xlnx_tsn_mdio_register_all(sw);
> +	if (ret)
> +		return ret;
> +
> +	sw->nb.notifier_call = xlnx_tsn_netdev_event;
> +	ret = register_netdevice_notifier(&sw->nb);

[Severity: High]

Can this notifier outlive the memory it lives in?

sw->nb is unregistered only from xlnx_tsn_teardown(), and
net/dsa/dsa.c:dsa_switch_shutdown() - reached from xlnx_tsn_shutdown() - never
calls ds->ops->teardown(), while it does drop DSA's conduit reference:

  dsa_switch_for_each_cpu_port(dp, ds) {
          dp->conduit->dsa_ptr = NULL;
          netdev_put(dp->conduit, &dp->conduit_tracker);
  }

so after shutdown the notifier is still on netdev_chain with sw->conduit
pointing at a netdev whose only reference was just released. The comment above
dsa_switch_shutdown() notes the conduit driver may unregister its own
net_device from its .shutdown. If the memory is reused, can
dev == sw->conduit match a foreign netdev and send
xlnx_tsn_handle_conduit_changeaddr() off to dereference it?

xlnx_tsn_shutdown() also does platform_set_drvdata(pdev, NULL), so a later
unbind takes the early return in xlnx_tsn_remove():

  static void xlnx_tsn_remove(struct platform_device *pdev)
  {
          struct xlnx_tsn *sw = platform_get_drvdata(pdev);

          if (!sw)
                  return;

          dsa_unregister_switch(&sw->ds);
  }

dsa_unregister_switch() and hence xlnx_tsn_teardown() never run, so devres
frees the devm_kzalloc'd struct xlnx_tsn with its embedded notifier_block still
linked into netdev_chain. Would a devm action for the unregistration (and a
netdev_hold() on the conduit) close both cases?

> +	if (ret)
> +		goto err_mdio;
> +
> +	return 0;
> +
> +err_mdio:
> +	xlnx_tsn_mdio_unregister_all(sw);
> +	return ret;
>  }
>  
>  static void xlnx_tsn_teardown(struct dsa_switch *ds)
> @@ -459,6 +687,7 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
>  	struct xlnx_tsn *sw = ds->priv;
>  	struct dsa_port *dp;
>  
> +	unregister_netdevice_notifier(&sw->nb);

[Severity: High]

Is this too late to protect the dp->user dereferences in
xlnx_tsn_handle_conduit_changeaddr()?

DSA destroys the user netdevs before it calls the driver's teardown:

  net/dsa/dsa.c:dsa_tree_teardown()
      dsa_tree_teardown_ports(dst);      /* frees the swpN netdevs */
      dsa_tree_teardown_switches(dst);   /* calls ds->ops->teardown */

  net/dsa/dsa.c:dsa_port_teardown()
      case DSA_PORT_TYPE_USER:
              if (dp->user) {
                      dsa_user_destroy(dp->user);
                      dp->user = NULL;
              }

and dsa_user_destroy() frees the netdev with rtnl already dropped, before
dp->user is cleared:

  net/dsa/user.c:dsa_user_destroy()
      rtnl_lock();
      netdev_upper_dev_unlink(conduit, user_dev);
      unregister_netdevice(user_dev);
      phylink_disconnect_phy(dp->pl);
      rtnl_unlock();
      ...
      free_netdev(user_dev);

For that whole window the notifier is still registered. If an
ip link set <conduit> address ... races driver unbind, does
xlnx_tsn_handle_conduit_changeaddr() then call
dev_addr_mod(dp->user, 0, want, ETH_ALEN) and
call_netdevice_notifiers(NETDEV_CHANGEADDR, dp->user) on a freed netdev? The
"if (!dp->user) continue;" check does not seem to help, since free_netdev()
happens before dp->user = NULL and neither is ordered against the rtnl-held
notifier read.

The same window appears to exist on the setup side: dsa_user_create() assigns
port->user before register_netdev() (its out_free path does
free_netdev(user_dev); port->user = NULL;), so a concurrent conduit
CHANGEADDR can rewrite the address of a not-yet-registered netdev.

>  	xlnx_tsn_mdio_unregister_all(sw);
>  
>  	dsa_switch_for_each_user_port(dp, ds)

[ ... ]

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
> index 6286caff7a1c..a228a7bebd53 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.h
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.h

[ ... ]

> @@ -100,6 +125,13 @@ struct xlnx_tsn_mac {
>   * @ds: DSA switch
>   * @dev: backing device
>   * @sw_base: switch fabric register window
> + * @conduit: DSA conduit netdev (EP MAC), used as the source of the
> + *	     shared 44-bit frame-filter prefix
> + * @mac_prefix: conduit MAC with byte 5's low nibble cleared to zero,
> + *		forming the 44-bit prefix common to all switch-port MACs
> + * @nb: netdev notifier that handles NETDEV_REGISTER on each swpN
> + *	to set its final MAC, and NETDEV_CHANGEADDR on the conduit
> + *	to refresh the shared prefix

[Severity: Low]

Could this kernel-doc list all four cases the notifier implements?
xlnx_tsn_netdev_event() handles conduit NETDEV_REGISTER, user NETDEV_REGISTER,
conduit NETDEV_CHANGEADDR and user NETDEV_CHANGEADDR.

The undocumented conduit NETDEV_REGISTER case is the only site that calls
xlnx_tsn_derive_prefix() and xlnx_tsn_program_frame_filter(), i.e. the frame
filter this patch is about, and it is served by a helper named
xlnx_tsn_handle_conduit_changeaddr() - the name says changeaddr while it also
services REGISTER. Would renaming it help?

The user-port NETDEV_CHANGEADDR path, which programs the nibble from an
address that has not been validated, is undocumented as well.

>   * @mac: per-MAC state, indexed by user-port number (index 0 unused;
>   *	 MAC1 at [1], MAC2 at [2])
>   */
