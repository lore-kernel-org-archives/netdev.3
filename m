Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CF3D25D2;
	Sat,  8 Aug 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218514; cv=none; b=oLw9WnQsZR2gtXDw1zjdsBTvtpVCzgq83VLbEeKEyzqsWR5b8TIYHNaBqepNTQBpPJ3kEDZAYhPmfbFXafvD6gkk2+fQvHKxzb/iTaZlhBR+1Au5xiVANcFrjBQaKSON2u19y9cFAUIuliC1V3EcGtRW4krPWzEaPo8e4jxUgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218514; c=relaxed/simple;
	bh=fOfVVIVP2v2LVs/ONTPnyrocBIGkkV1N7AAn8UoD0sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC2h7b7wsczQn6g9eE5WMowSdp39OUoZlWbU+SFKPwoTnhXRSkztuzQ7gKM9qb0oFq59IRRGRDEa4Uy68HkM1Zyrxc9JXuGdidAhjQyJprYkjJUe+40+msQsaT/h29ryUD+aZ0KYkdjU7Y/n9vpY4V/h5cDL6VHUaCbpp62Pn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alZwxsPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alZwxsPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C11F00A3D;
	Sat,  8 Aug 2026 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218509;
	bh=XdcCkdysrurg5oBY0U5tAsXjwtp6rFLGO2vEQyv/bgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alZwxsPjhCmjrRNhMPE0cqoNz6QEgXXB6DHW0Ddu0UTaKaF+K5280xuwtaP59PaiW
	 nYZN1qPOvFsxZ2rxXCxjvRoLnvcqVr5rsFnMDNcYeGJJICMsspHO+SlNwYfoOBz4Pt
	 N9XgAkOPamuPOY99pMAJTpxL37veO9L43PjmKM7Zptzo34xAFUFISFg3uaTxQOvVl+
	 buICrGT9i28hdWAPethZOaU/+8DwFd6mD2ATCUbG/6+G80rcZWq8kfPBvH4EGRDNWE
	 xjTEyAYz0KfP6oVya4w8td+QJPVNIRdIXLppxowN4HROkLEMKfRm6/LCxYs5XjrZpa
	 Sh+p3hKJdZYmg==
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
Subject: Re: [PATCH 11/20] net: dsa: xilinx: implement port_stp_state_set
Date: Sat,  8 Aug 2026 12:48:27 -0700
Message-ID: <20260808194827.133042-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-12-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-12-nagadheeraj.rottela@amd.com>
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
net: dsa: xilinx: implement port_stp_state_set

This adds a .port_stp_state_set callback that maps the five bridge STP
states onto the 3-bit per-port fields of the Switch Port State Control
register at +0x004C, using a self-clearing commit bit plus
readl_poll_timeout() for the acknowledge. setup() puts the CPU port in
FORWARDING and the user ports in DISABLED, and teardown() puts the ports
back to DISABLED.

A few questions on the new code below.

First, on the commit message itself:

> The bridge STP machine does not manage the CPU port. Its forwarding
> state does not change after setup().

[Severity: Low]
Is this accurate?  The teardown() added by this same patch writes DISABLED
to the CPU port:

	xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT, TSN_PORT_STATE_DISABLED);

And because the driver now provides .port_stp_state_set, the DSA core also
drives the CPU port state on its own:

  dsa_port_setup()   [DSA_PORT_TYPE_CPU] -> dsa_port_enable(dp, NULL)
    -> dsa_port_enable_rt() -> dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false)

  dsa_port_teardown() [DSA_PORT_TYPE_CPU] -> dsa_port_disable(dp)
    -> dsa_port_disable_rt() -> dsa_port_set_state_now(dp, BR_STATE_DISABLED, false)

So the CPU port is written FORWARDING twice at bring-up (making the
explicit write in setup() redundant) and DISABLED from two paths at
unbind.  Could the changelog be reworded to say the core drives the CPU
port state too, and that teardown disables it?

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index 6b285c528724..020b1622670c 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c

[ ... ]

> @@ -11,6 +15,86 @@
> +static int xlnx_tsn_set_port_state(struct xlnx_tsn *sw, int port,
> +				   enum tsn_port_state state)
> +{
> +	u32 chg_bit, mask, val, reg;
> +	int err;
> +
> +	err = xlnx_tsn_port_state_bits(port, &mask, &chg_bit);
> +	if (err)
> +		return err;
> +
> +	err = xlnx_tsn_switch_status_ready(sw);
> +	if (err) {
> +		dev_err(sw->dev, "port %d: switch not ready for state change\n",
> +			port);
> +		return err;
> +	}
> +
> +	/* Bit won't re-arm if a previous change never cleared it. */
> +	val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
> +	if (val & chg_bit) {
> +		dev_err(sw->dev, "port %d: previous state change still pending\n",
> +			port);
> +		return -EBUSY;
> +	}
> +
> +	val &= ~mask;
> +	val |= (state << __ffs(mask)) & mask;
> +	val |= chg_bit;
> +	sw_iow(sw, TSN_PORT_STATE_CTRL_OFFSET, val);
> +
> +	err = readl_poll_timeout(sw->sw_base + TSN_PORT_STATE_CTRL_OFFSET, reg,
> +				 !(reg & chg_bit), TSN_SW_POLL_DELAY_US,
> +				 TSN_SW_POLL_TIMEOUT_US);
> +	if (err) {
> +		dev_err(sw->dev, "port %d: state change ack timed out\n", port);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can this timeout path wedge the port permanently?  When the 5 ms ack poll
expires, xlnx_tsn_set_port_state() returns -ETIMEDOUT with chg_bit still
set in TSN_PORT_STATE_CTRL, and it neither clears the bit nor re-drives
the transfer.  Per the comment right above the precondition check, the bit
will not re-arm, so every later call for that port hits:

	val = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
	if (val & chg_bit) {
		dev_err(sw->dev, "port %d: previous state change still pending\n",
			port);
		return -EBUSY;
	}

That includes a subsequent probe attempt, since xlnx_tsn_setup()
propagates the error and aborts registration.  Meanwhile the state field
and the 0->1 commit edge have already been written, so the hardware may
still latch the new encoding.

Would it make sense to write the commit bit back to 0 (or otherwise
re-drive it) on the timeout path, and to clear a stale commit bit once
before the first programming attempt in setup()?

The exact behaviour of the commit bit is not visible from the tree, so
this rests on the assumption stated in the comment.

> @@ -18,19 +102,83 @@ static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
> +static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
> +					u8 state)
> +{
> +	struct xlnx_tsn *sw = ds->priv;
> +	enum tsn_port_state hw_state;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +		hw_state = TSN_PORT_STATE_DISABLED;
> +		break;
> +	case BR_STATE_BLOCKING:
> +		hw_state = TSN_PORT_STATE_BLOCKING;
> +		break;
> +	case BR_STATE_LISTENING:
> +		hw_state = TSN_PORT_STATE_LISTENING;
> +		break;
> +	case BR_STATE_LEARNING:
> +		hw_state = TSN_PORT_STATE_LEARNING;
> +		break;
> +	case BR_STATE_FORWARDING:
> +		hw_state = TSN_PORT_STATE_FORWARDING;
> +		break;
> +	default:
> +		dev_warn(sw->dev, "port %d: unsupported STP state %u\n",
> +			 port, state);
> +		return;
> +	}
> +
> +	xlnx_tsn_set_port_state(sw, port, hw_state);
> +}

[Severity: High]
Does this bridge MAC1 and MAC2 in hardware even when the two netdevs are
not bridged?  The DSA core requests FORWARDING for any user port that is
not bridge-offloaded, on every ndo_open:

net/dsa/port.c:dsa_port_enable_rt() {
	...
	if (!dp->bridge)
		dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false);
	...
}

That reaches the BR_STATE_FORWARDING case above and programs
TSN_PORT_STATE_FORWARDING on the MAC port.  The ops table below adds no
port_bridge_join/leave and the driver programs no forwarding vector,
port-based VLAN, or any other isolation register (the only registers
touched are TSN_SW_STATUS_OFFSET and TSN_PORT_STATE_CTRL_OFFSET).

So after:

	ip link set <mac1port> up
	ip link set <mac2port> up

both switch ports sit in FORWARDING in the same flooding domain, and
frames received on one wire port are forwarded out the other in hardware
without reaching the host stack.

Documentation/networking/dsa/dsa.rst says of setup():

  "This function is also expected to properly configure the switch to
   separate all network interfaces from each other, that is, they should be
   isolated by the switch hardware itself"

Should setup() program a per-port forwarding domain (for example a
port-based VLAN allowing only the CPU port and that port) so standalone
ports stay isolated?

[Severity: Medium]
The return value of xlnx_tsn_set_port_state() is discarded here.  Since
.port_stp_state_set is a void callback, an -EBUSY or -ETIMEDOUT failure is
invisible to the bridge, which then records e.g. BLOCKING while the
hardware can still be FORWARDING.  Would at least a dev_err() on failure
here help make that divergence visible?

>  static int xlnx_tsn_setup(struct dsa_switch *ds)
>  {
> +	struct xlnx_tsn *sw = ds->priv;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
> +	    !dsa_is_user_port(ds, XLNX_TSN_PORT_MAC2))
> +		return dev_err_probe(sw->dev, -EINVAL,
> +				     "both MAC1 and MAC2 must be enabled as switch ports\n");

[Severity: Low]
This adds a probe-time topology requirement that isn't mentioned in the
changelog and isn't expressed in the binding.  In
Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
the wire ports are described only as:

	patternProperties:
	  "^port@[1-2]$":

with no "required" entry, so a device tree describing only port@0 and
port@1 validates against the schema but fails dsa_register_switch() with
-EINVAL, taking down the whole DSA tree for that conduit.

Should the binding mark port@1 and port@2 as required, or should the
driver tolerate a single wire port?

> +
> +	/* CPU port stays in FORWARDING so host traffic always flows.
> +	 * User ports start in DISABLED and transition from there under
> +	 * bridge STP control.
> +	 */

[Severity: Low]
Is the second half of this comment correct?  The DSA core replaces the
DISABLED encoding on the first ifup, with no bridge STP event involved:

net/dsa/port.c:dsa_port_enable_rt() {
	if (!dp->bridge)
		dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false);
}

net/dsa/port.c:dsa_port_disable_rt() {
	if (!dp->bridge)
		dsa_port_set_state_now(dp, BR_STATE_DISABLED, false);
}

> +	ret = xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT,
> +				      TSN_PORT_STATE_FORWARDING);
> +	if (ret)
> +		return ret;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		ret = xlnx_tsn_set_port_state(sw, dp->index,
> +					      TSN_PORT_STATE_DISABLED);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }

[Severity: Low]
Should these error returns undo the CPU port write?  The endpoint port has
already been committed to FORWARDING when the user-port loop runs, and if
xlnx_tsn_set_port_state() returns -EBUSY or -ETIMEDOUT for a user port the
fabric is left half-programmed.

The core does not call teardown() when setup() fails:

net/dsa/dsa.c:dsa_switch_setup() {
	...
	err = ds->ops->setup(ds);
	if (err < 0)
		goto unregister_notifier;
	...
}

so probe fails, devm releases the register windows and frees struct
xlnx_tsn, but the endpoint port stays in FORWARDING with no driver bound.
Mirroring xlnx_tsn_teardown() on setup()'s error paths would keep this
symmetric.

>  static void xlnx_tsn_teardown(struct dsa_switch *ds)
>  {
> +	struct xlnx_tsn *sw = ds->priv;
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, ds)
> +		xlnx_tsn_set_port_state(sw, dp->index, TSN_PORT_STATE_DISABLED);
> +
> +	xlnx_tsn_set_port_state(sw, XLNX_TSN_CPU_PORT, TSN_PORT_STATE_DISABLED);
>  }
>  
>  static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
>  	.get_tag_protocol	= xlnx_tsn_get_tag_protocol,
>  	.setup			= xlnx_tsn_setup,
>  	.teardown		= xlnx_tsn_teardown,
> +	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
>  };

[ ... ]
