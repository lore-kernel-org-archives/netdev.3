Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866431D362;
	Mon, 12 Oct 2026 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774493; cv=none; b=IJprpMbyYgs9sxi9Tlk943uTCzBuTZ2aDLCdIhFyBeNzqKpQ14ScLyyVNUDBb4nwm389QyudazNVIM+LW5tDlqp1Aatv2xfwMjWZR6JBfG1UeXvsYAMhn6HMe3GsRdleuiUcR2JBCioCRCMcbEPjnAN8H3Sdag7rx3QBuuKJ5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774493; c=relaxed/simple;
	bh=D1JYBi+286qRmiTZ8ZXVT6FoF2PCYivHRTwann5m8/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpY3MZXd5efs6cJRZToTPmDd0WQUYaS+k4Au/4FCTBH2ItoOm6zQxqdnpiaZ6NfQEIekyAm568CF9p4Bc9OD7l1GdLo1rl4HgjyXXC7/IpKkFuIseLKx3meY4TUgLALK2HLJMdKOpOepRnLTQTRZ68iwg5he490V+Ps5C2bP69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRlkVcbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRlkVcbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF7C1F0089C;
	Mon, 12 Oct 2026 03:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774491;
	bh=a6lfmSp2EPWUAzHOj2Mk4B6SyT3g8fQjZh8UUbDrQ10=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WRlkVcbLNd+6e1iLRfBqAP3x98R6drD77xMf22n+rB6DYaRJgkDASoHf8tc9VJZ9t
	 uQDqhh5efkPq1z85vplnS6tF3TaPa3qiuklDwbRpOgLW0nTbK5lwYRHG9cH7Fyb+5/
	 aWcVyanaSofrwg/9YeXusoC0WRISoDxk2/DmA9oach+hNWNFiJlusdwiz1nr7zHJwj
	 PYg1CiCUaAW+IjFhgRc6pG/jwTk7Qzwqqkb74P+SdSkqkzrjHl4ZdulsK4+6lHaS+d
	 IxdSylTFHRGOQ7J7hFpmGzbYMlTpsx77jfbD5PEgsihu9urkWk8pdtl40ZVlphoqMA
	 liCEe1b+nsipQ==
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Add BR_FLOOD and
 BR_MCAST_FLOOD support
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 03:08:10 +0000
Message-ID: <179177449050.434549.1173784432741043364@kernel.org>
In-Reply-To: <20261011030228.2761810-1-mmyangfl@gmail.com>
References: <20261011030228.2761810-1-mmyangfl@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When a port leaves a bridge, the
  FILTER_UNK_UCAST/FILTER_UNK_MCAST bits of the ports that stay in the…
- [Medium] yt921x_bridge_flood_set_type() ignores the ingress port's own
  flood flag, but for a hairpin port the ingress port is also a possible…
- [Medium] Clearing YT921X_FILTER_UNK_MCAST on bridge ports in
  yt921x_bridge_flood_set_type() may move reserved/link-local multicast…
- [Medium] The new hardware flooding can send unknown traffic back out of
  an ingress port that has both BR_HAIRPIN_MODE and BR_ISOLATED set.
- [Low] The patch also changes the forwarding path of every standalone
  port and of the CPU port, and the commit message does not say so.
- [Low] The new yt921x_bridge_flood_set() step in yt921x_bridge_join()
  runs after yt921x_userport_bridge() has enabled learning and…

--

net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support

This commit tracks BR_FLOOD and BR_MCAST_FLOOD per port. It clears the
FILTER_UNK_UCAST and FILTER_UNK_MCAST bits on a bridge port when all other
members of that bridge have flooding enabled. The hardware then floods
unknown traffic instead of trapping it to the CPU, and standalone ports
also get their FILTER_UNK bits cleared.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 91cc5647f2b66..e48189f841a06 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -2643,6 +2644,17 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
>  	if (res)
>  		return res;
>  
> +	mask = BIT(port);
> +	res = yt921x_reg_clear_bits(priv, YT921X_FILTER_UNK_UCAST, mask);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_clear_bits(priv, YT921X_FILTER_UNK_MCAST, mask);
> +	if (res)
> +		return res;
> +
> +	pp->flood = true;
> +	pp->mcast_flood = true;
> +
>  	return 0;
>  }

[Severity: Low]
Is this change to standalone ports intended? yt921x_port_setup() calls
yt921x_userport_standalone() for every port, including the CPU port, and
it does so before the dsa_is_cpu_port() branch:

yt921x_port_setup() {
	res = yt921x_userport_standalone(priv, port);
	...
	if (dsa_is_cpu_port(ds, port)) {
	...
}

Port setup runs after yt921x_chip_setup_dsa() has written GENMASK(10, 0)
to both FILTER_UNK registers. So at probe time that value is overwritten
on every port.

The yt921x_chip_setup_dsa() comment describes UNK_ACT as fixed to TRAP
with FILTER_UNK toggled per port. Under that model, unknown traffic on
standalone ports is now flooded by the hardware (isolation limits it to
the CPU port) instead of being trapped. That makes the comment just above
in this function stale:

	/* Unrelated since learning is off and all packets are trapped;
	 * set it anyway
	 */
	res = yt921x_port_set_pvid(priv, port, YT921X_VID_UNWARE);

On the CPU port, clearing the FILTER bit also seems to undo the
ACT_UNK=DROP that yt921x_chip_setup_dsa() programs for CPU ports. Its
comment says "if any packets are sent via CPU ports without tag, they
should be dropped". After this change, only PORTn_ISOLATION(cpu) still
blocks such frames.

yt921x_bridge_flood_set_type() masks CPU ports out with
ports_mask &= ~priv->cpu_ports_mask, which suggests they were meant to
stay filtered.

Learning is off on standalone ports and no host addresses are installed.
So host-directed unicast is always unknown there, and standalone RX now
depends on the hardware flood reaching the CPU on VID 4095 rather than on
the trap.

Should the CPU port be skipped here? Could the commit message also
describe the change in behavior for standalone ports?

[ ... ]

> @@ -2721,6 +2733,62 @@ static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
>  	return 0;
>  }
>  
> +static int
> +yt921x_bridge_flood_set_type(struct yt921x_priv *priv, u16 ports_mask, int type)
> +{
> +	unsigned long targets_mask;
> +	u16 flood_ports_xor;
> +	u32 filter_ctrl;
> +	u16 flood_mask;
> +	u32 addr;
> +	int port;
> +	int res;
> +
> +	ports_mask &= ~priv->cpu_ports_mask;
> +
> +	flood_mask = 0;
> +	targets_mask = ports_mask;
> +	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
> +		struct yt921x_port *pp = &priv->ports[port];
> +
> +		if (!type ? pp->flood : pp->mcast_flood)
> +			flood_mask |= BIT(port);
> +	}
> +
> +	flood_ports_xor = flood_mask ^ ports_mask;
> +	filter_ctrl = 0;
> +	targets_mask = ports_mask;
> +	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
> +		if (!(flood_ports_xor & ~BIT(port)))
> +			continue;

[Severity: Medium]
Can the hardware flood back out of a hairpin port that has flooding
disabled?

flood_ports_xor is the set of bridge ports with flooding disabled. This
check drops the ingress port itself, so its own pp->flood or
pp->mcast_flood is never considered.

When hairpin is enabled, yt921x_bridge() clears the self bit in
PORTn_ISOLATION:

		if (!pp->hairpin)
			ctrl |= BIT(port);
		else
			ctrl &= ~BIT(port);

Take a port X with hairpin on and flood off, while every other member
floods. FILTER_UNK(X) stays clear, so unknown unicast arriving on X can be
flooded by the hardware back out of X.

The software bridge would not do this. br_flood_port() checks the
destination's flag before should_deliver() allows hairpin:

	case BR_PKT_UNICAST:
		if (!test_bit(BR_FLOOD_BIT, &p->flags))
			return 0;

yt921x_bridge_flags() only calls yt921x_bridge_flood_set() when BR_FLOOD
or BR_MCAST_FLOOD changes. If hairpin were taken into account here, would
a hairpin-only change also need to recompute FILTER_UNK?

[Severity: Medium]
A related case is a port with both BR_HAIRPIN_MODE and BR_ISOLATED set.
In yt921x_bridge(), the isolated port first gets isolated_mask, which
includes its own bit. The hairpin branch then clears that bit:

		if (pp->isolated)
			ctrl |= isolated_mask;
		/* to itself when non-hairpin */
		if (!pp->hairpin)
			ctrl |= BIT(port);
		else
			ctrl &= ~BIT(port);

If the other members flood, FILTER_UNK(X) stays clear here. Unknown
unicast and multicast received on X can then be flooded back out of X.

In software, should_deliver() rejects that case through
br_skb_isolated():

	return BR_INPUT_SKB_CB(skb)->src_port_isolated &&
	       (to->flags & BR_ISOLATED);

Before this patch, all unknown traffic was trapped and handled by the
software bridge. Does the offload now bypass the isolation policy for
unknown traffic on such a port?

> +
> +		filter_ctrl |= BIT(port);
> +	}
> +
> +	addr = !type ? YT921X_FILTER_UNK_UCAST : YT921X_FILTER_UNK_MCAST;
> +	res = yt921x_reg_update_bits(priv, addr, ports_mask, filter_ctrl);

[Severity: Medium]
Could clearing FILTER_UNK_MCAST here also take reserved multicast off the
trap path?

BR_MCAST_FLOOD is on by default, and yt921x_userport_standalone() sets
pp->mcast_flood = true. So this applies to every default bridge.

The driver does not appear to program any RMA or management-frame trap.
chip.h defines YT921X_ACT_UNK_MCAST_BYPASS_DROP_RMA and
YT921X_ACT_UNK_MCAST_BYPASS_DROP_IGMP, but nothing ever sets them. Their
place in the unknown multicast action register suggests that RMA and IGMP
frames are handled by the unknown multicast action.

If that is the case, the hardware would relay BPDUs (01:80:c2:00:00:00),
LLDP and EAPOL between bridge ports, which the software bridge never
does. The hardware STP state might also treat a BPDU on a BLOCKING or
LEARNING port as an ordinary data frame. IGMP/MLD reports would be
flooded regardless of snooping.

Unless the chip's reset defaults already trap these frames, does the
mcast flood offload need an RMA/IGMP trap? Or should FILTER_UNK_MCAST
stay set?

[ ... ]

> @@ -2733,6 +2801,12 @@ static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
>  	if (res)
>  		return res;
>  
> +	/* By the time port_bridge_leave() is called, the port is already
> +	 * unbridged, thus we cannot recompute flood flags for the affected
> +	 * bridge. This leaves some sub-optimality, but the flood will still
> +	 * be handled (by the CPU).
> +	 */
> +

[Severity: Medium]
Is this comment accurate? dsa_port_bridge_leave() in net/dsa/port.c
unbridges the port first precisely so that drivers can reprogram the
remaining members:

	info.bridge = *dp->bridge;

	/* Here the port is already unbridged. Reflect the current configuration
	 * so that drivers can program their chips accordingly.
	 */
	dsa_port_bridge_destroy(dp, br);

	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);

yt921x_dsa_port_bridge_leave() receives struct dsa_bridge bridge but does
not pass it down to yt921x_bridge_leave(). The expression
dsa_bridge_ports(ds, bridge.dev) | priv->cpu_ports_mask would give the
remaining members. yt921x_dsa_port_bridge_join() already builds its mask
the same way.

For example, take a bridge {A, B, C} where only C has BR_FLOOD off. A and
B get FILTER set. When C leaves, A and B keep FILTER set until an
unrelated join or flag change recomputes it. Until then, unknown traffic
between A and B is still trapped to the CPU, even though every remaining
member floods.

dsa_port_clear_brport_flags() on the leaving port does not fix this
either. yt921x_bridge_flags() returns early because
dsa_port_bridge_dev_get(dp) is already NULL.

Could this path call yt921x_bridge_flood_set() for the remaining members?
If not, could the commit message mention the limitation?

>  	return 0;
>  }
>  
> @@ -2749,6 +2823,10 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
>  	if (res)
>  		return res;
>  
> +	res = yt921x_bridge_flood_set(priv, ports_mask);
> +	if (res)
> +		return res;
> +

[Severity: Low]
What happens to the hardware state if yt921x_bridge_flood_set() fails
here because of a register I/O error? At this point yt921x_userport_bridge()
has already enabled learning, and yt921x_bridge() has opened
PORTn_ISOLATION for all members. Neither is undone.

When the DSA_NOTIFIER_BRIDGE_JOIN broadcast fails, dsa_port_bridge_join()
jumps to out_rollback. That only calls dsa_port_bridge_destroy() and does
not broadcast DSA_NOTIFIER_BRIDGE_LEAVE. So yt921x_bridge_leave() never
runs, and a later leave returns early because dp->bridge is NULL.

The port would then stay in the bridge's hardware forwarding domain with
learning enabled, while software treats it as standalone.

The same gap already existed for a yt921x_bridge() failure. This patch
adds a new failure point after isolation has been opened.

Separately, yt921x_bridge_flood_set() goes on to the MCAST register after
the UCAST update fails, and returns only the last error:

	for (int type = 0; type < 2; type++) {
		res = yt921x_bridge_flood_set_type(priv, ports_mask, type);
		if (res)
			ret = res;
	}

Can that leave the two FILTER_UNK registers out of sync with each other?

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011030228.2761810-1-mmyangfl%40gmail.com
