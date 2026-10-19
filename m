Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8894D7D5E;
	Mon, 19 Oct 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404534; cv=none; b=Te7aQMUsq2ob1gVaFNdcaxQWuouvC6PduVNDZJxLc5EBChuasTHjwPDX1/Y6QC5y9t07fmrjAfatVe6i+saNDkZyXUeGE4liD1OzlJkj/FhOo8rlAQKP8L0iMeG+yJtD/dcUU0HO2dUXXeSyf67RcFEr+nu9b9POJ3ZqWNkVtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404534; c=relaxed/simple;
	bh=/uWp582f+ldpsvdy4fm7swPZbqcNhxWaNp1L6ftY/rc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+xZv4ycqSuue3FyWvDVriHbsM2s9n7D98hEyvIDUCoXY4IkMZZOmYaND6RllaC3Gqhagr0VMnxiveOXHfEB5RzepNTrjxMhAM+vhnnEuDd2RY9diO0By2aeQsbqQRhwN1cqwnMIW8E+6cItNpoDPTx8TMvnMFb/It0SRAv4nm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONDL/pxl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONDL/pxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA72B1F000C4;
	Mon, 19 Oct 2026 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404532;
	bh=y0nubFCxnCOLOvPV9BUK73w27Jqvlztfy1Qf6IkT+H0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ONDL/pxlS590MKOcn9JBW4O3cw63KrDuvPkLtZau2HjRce6i+JwY4sSqLbLgAZTib
	 kesxZSFVblPryH28kLUgHjwSuKVsrHCS9+Bx5klZCw0IY9PhXawmYEGRDfG6a1JQtR
	 v7rL6qLvBE+JtlaKO783YTfNYnbrFRREuQv3+Js1GY9rV7SCajGF37NSXZpMQtv9ms
	 e3Jr5tDpO02PjXE6AKeTThLNNNFilsG8edifiGEtXo+HO5y8XL0Yk+qDsu3QCi5Rtn
	 L/E0rXp1PpWikM8G5y3s+D7PY6qmqKzWaJvyylnHUqaOxluekGq1h5i+qt1Klb6SsF
	 qibPkJqiOgHFw==
Subject: Re: [PATCH net-next v15 8/9] net: dsa: lan9645x: add bridge support
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
Date: Mon, 19 Oct 2026 10:08:51 +0000
Message-ID: <179240453125.3135.11938999224472029303@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-8-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-8-562f316f78b9@microchip.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The 802.1Q-only restriction can be bypassed by changing the
  bridge's vlan_protocol after the port has joined.

--

net: dsa: lan9645x: add bridge support

This adds hardware offload of a single bridge to the lan9645x DSA
driver. It covers ageing time, bridge port flags, STP state handling and
host flooding. Joining a VLAN-aware bridge whose vlan_protocol is not
802.1Q is refused at join time.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index d2e8c52e2a178..c6371a7b9a52a 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +
> +	if (!lan9645x_bridge_vlan_proto_ok(bridge.dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only 802.1Q VLAN-aware bridges are supported");
> +		return -EINVAL;
> +	}

[Severity: High]
Can the 802.1Q-only restriction be bypassed by changing vlan_protocol
after the port has joined?

lan9645x_bridge_vlan_proto_ok() is only checked in two places. One is
here, at join time. The other is lan9645x_port_vlan_filtering(). DSA
only calls lan9645x_port_vlan_filtering() when the filtering state
changes, because dsa_port_vlan_filtering() returns early when
dsa_port_is_vlan_filtering(dp) already matches.

A protocol change goes through __br_vlan_set_proto():

net/bridge/br_vlan.c:__br_vlan_set_proto() {
	struct switchdev_attr attr = {
		.orig_dev = br->dev,
		.id = SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
		.flags = SWITCHDEV_F_SKIP_EOPNOTSUPP,
    ...
	err = switchdev_port_attr_set(br->dev, &attr, extack);
	if (err && err != -EOPNOTSUPP)
		return err;
    ...
	br->vlan_proto = proto;
    ...
}

Only mlxsw and mlx5 handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL. DSA
has no case for it and returns -EOPNOTSUPP. The bridge then commits the
new protocol, and lan9645x never sees the change.

br_changelink() also handles IFLA_BR_VLAN_FILTERING before
IFLA_BR_VLAN_PROTOCOL. So both of these sequences look like they end up
with an offloaded VLAN-aware 802.1ad bridge:

  ip link set br0 type bridge vlan_filtering 1 vlan_protocol 802.1ad

  ip link set br0 type bridge vlan_protocol 802.1ad
  (on a bridge that already has vlan_filtering 1)

In the first case, lan9645x_port_vlan_filtering() runs while
br->vlan_proto is still 802.1Q, so the check passes.

The hardware then keeps its 802.1Q setup in ANA_VLAN_CFG: VLAN aware,
C-tag type, pop count 1. Would it then classify customer 0x8100-tagged
frames by the C-VID the sender chose, and forward them in hardware to
members of that VID?

Under 802.1ad, the software bridge treats that tag as payload and puts
the frame in the port PVID (the S-VLAN). If the hardware classifies by
the C-VID instead, S-VLAN isolation breaks for traffic arriving from
the wire.

The v15 changelog says VLAN-aware bridges whose vlan_protocol is not
802.1Q are refused. Does this need handling for protocol changes, rather
than only the join-time check? Two options would be a veto from a
switchdev or netdev notifier, or a DSA hook for
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.

The later patch in the series, "net: dsa: lan9645x: add port
statistics", only adds statistics and does not change this logic.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
