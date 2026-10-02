Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2C4582E1;
	Fri,  2 Oct 2026 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975663; cv=none; b=GQ1cE5yHnWOT+sO3hQo87zt2YLAzqEwEi4NisJ0+ba4maQP7BSqhBx0NNheUuanedd6J1kgAduZV1JMWMLqnA1/geqPXmo1/eyV3LoBoNL8RA964AzVT0lT4IiyNY1fqhU/EEbjRPUImSoijLJWsGkyuddgI0IHdbreREsTIAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975663; c=relaxed/simple;
	bh=Cz+k5oO3vvPZBm9IeNg4Bu+B/VaQt/cFAjlaASp90XE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmOuFfoDHdvKEf/9Mm12/FnMUemJ8Lldi6LIs4qQ7h4AWrCGkQU2CE2rZRkQOZuzuEwL0a8Gy06oqyCyM9QgXjaOwqmqokPxg4oJ+ISBL/8fBS20dwMf402x2OkBjKu3PA0hv0i7uRxM5VVgWZPAGwJsamWu2i69DOaUpFmEgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRoo88VM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRoo88VM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572361F00893;
	Fri,  2 Oct 2026 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975661;
	bh=1gGX5gcRJEzdklS76RxKIK7WFAXZ5KpVShdjLFiAFKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KRoo88VMRQApQ61hpNpAWc05KhUV5JOkr7YUE0WJKFhBHLldo9Zk2wH/p5IsiX5e5
	 8V7/Y3bA3Wxflin74jEBDeKq6BQgB3WqSkDx2B7ViRRGRiZDvUx14QxRdcLUPCESct
	 DKN+PEmxyOqkQzuoKqFpyOjAKXDSfRTcEMQ/2KTDJp0Fiy1HUftEhq+0yLd0NTQDhG
	 M3V8rFzk+OAxiS+BYpJLjIisydptE1D5NTj7Dx9XB7pNSOqZ9CXcoC+f2uaM70Y0gs
	 HeE1z2gADXjVbqF0iqxNvIFC7kZu2B7k3adSR+zEQ4CdrRs4hN1wguwhIMW8Y4S2/f
	 H3hIKOiJHG+TQ==
Subject: Re: [PATCH net-next v13 5/9] net: dsa: lan9645x: add vlan support
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:19 +0000
Message-ID: <179097565993.434549.16648659214046712507@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-5-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-5-827c2d3617f2@microchip.com>
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

- [Medium] On a VLAN-aware bridged port, frames the host sends without a
  tag can leave the switch tagged, sometimes with the wrong VID.
- [Medium] On VLAN-aware ports, lan9645x_vlan_port_apply_ingress() sets
  ANA_VLAN_CFG_VLAN_POP_CNT=1, so the hardware removes the outer VLAN…
- [Low] The commit message says the patch adds "VLAN support for VLAN-
  aware and VLAN-unaware bridges", but none of the bridged code paths…
- [Low] Errors from VLAN table programming are not passed back to
  callers.

--

net: dsa: lan9645x: add vlan support

This commit adds VLAN table management to the lan9645x DSA driver. It
configures ports for VLAN-aware and VLAN-unaware bridges, and reserves
HOST_PVID (4095) for standalone ports. It also registers the
port_vlan_filtering, port_vlan_add and port_vlan_del ops, all serialized
by a new fwd_domain_lock.

> Add VLAN support for VLAN-aware and VLAN-unaware bridges.

[Severity: Low]
Does this description match what the commit does on its own?

At this point in the series nothing writes lan9645x->bridge_mask, and
lan9645x_switch_ops has no .port_bridge_join. That means
lan9645x_port_is_bridged() always returns false:

static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
{
	return p->lan9645x->bridge_mask & BIT(p->chip_port);
}

It also means DSA never offloads a bridge, so .port_vlan_filtering,
.port_vlan_add and .port_vlan_del are never called for user ports. The
only thing that takes effect here is the standalone HOST_PVID setup done
from .port_setup.

Bridge offload, and clearing HOST_PVID membership on bridge join, arrive
with the later "net: dsa: lan9645x: add bridge support" patch. That
ordering is only explained in the v12 changelog below the "---", and git
am drops that part.

Could the commit message say that the bridged paths only become
reachable once the bridge support patch is applied?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 0000000000000..6d28a7cf1442b
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> @@ -0,0 +1,402 @@

[ ... ]

> +static void
> +lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
> +				struct lan9645x_vlan_port_info *info)
> +{
> +	struct lan9645x *lan9645x = p->lan9645x;
> +	enum lan9645x_vlan_port_tag tag_cfg;
> +	u16 port_vid = UNAWARE_PVID;
> +
> +	if (!lan9645x_port_is_bridged(p)) {
> +		tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
> +		port_vid = HOST_PVID;
> +	} else if (p->vlan_aware) {

[ ... ]

> +		if (info->untagged == 1 && info->tagged) {
> +			tag_cfg = LAN9645X_TAG_NO_PVID_NO_UNAWARE;
> +			port_vid = info->untagged_vid;
> +		} else if (info->untagged) {
> +			tag_cfg = LAN9645X_TAG_DISABLED;
> +		} else {
> +			tag_cfg = LAN9645X_TAG_ALL;
> +		}

[Severity: Medium]
Can untagged frames from the host leave a VLAN-aware bridged port tagged,
and with the wrong VID?

For an untagged host frame on a VLAN-filtering bridge,
lan9645x_xmit_get_vlan_info() in net/dsa/tag_lan9645x.c puts the bridge
device's pvid into the IFH:

	} else {
		rcu_read_lock();
		br_vlan_get_pvid_rcu(br, &tci);
		rcu_read_unlock();
		*vlan_tci = tci;
	}

The rewriter mode here, however, is chosen from the port's own untagged
VID:

- With one untagged VLAN X plus tagged VLANs, TAG_NO_PVID_NO_UNAWARE with
  PORT_VID=X leaves only VID X or VID 0 untagged.
- With no untagged VLANs, TAG_ALL tags every frame, including VID 0.

The two sides only agree when br0's pvid equals the port's untagged VID.
Two examples where they don't:

(a) swp0 has "vid 10 pvid untagged" plus tagged vid 20, and br0 self
pvid is 1. br_handle_vlan() strips host traffic on br0.10 for egress on
swp0, and the same happens to VLAN 10 traffic forwarded in software from
a foreign bridge port. The tagger then puts VID 1 in the IFH, so the
frame goes out tagged with VID 1 instead of untagged in VLAN 10.

(b) On a trunk port with no untagged VLANs, untagged frames go out tagged
with br0's pvid. If br0 has no pvid, they go out priority-tagged with
VID 0. STP BPDUs from br_send_bpdu() and LLDP sent on swp0 are examples.

This depends on the rewriter using IFH.TCI as the classified VID when
BYPASS=1, and on the TAG_CFG semantics described in the
lan9645x_vlan_port_tag comment. I could not check either against the
datasheet. ocelot and tag_ocelot use a similar pairing, so this may be a
known limitation.

The code becomes reachable once the bridge support patch lands, and it
is unchanged at the end of the series. Also, LAN9645X_TAG_NO_UNAWARE is
defined but never used.

> +	} else {
> +		tag_cfg = LAN9645X_TAG_DISABLED;
> +	}

[ ... ]

> +static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
> +{

[ ... ]

> +	val = ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
> +	      ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);
> +	if (p->vlan_aware)
> +		val |= ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
> +		       ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);

[Severity: Medium]
Does popping the outer tag here conflict with the pvid check in
lan9645x_rcv()?

With VLAN_POP_CNT=1 on VLAN-aware ports, the classified VID survives
only in the IFH. lan9645x_rcv() in net/dsa/tag_lan9645x.c skips
restoring it when it equals the port pvid:

		if ((vlan_tci & VLAN_VID_MASK) != port_pvid)
			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
					       vlan_tci);

That is fine for untagged frames. Consider a double-tagged frame
[0x8100 VID 100][0x8100 VID 200] that arrives on a VLAN-aware port with
pvid 100 and is sent to the CPU (broadcast, host flood or trap). The
hardware classifies it to VID 100 and pops the outer tag. IFH TCI is
100, which equals the pvid, so no hwaccel tag is set.

The software bridge then finds the inner tag 200 in the payload and puts
the frame in VLAN 200, while the hardware forwarded it in VLAN 100.

Could this cause local delivery (for example to br0.200), or software
forwarding in a different VLAN than the hardware used?
br_allowed_ingress() still restricts this to VIDs the port is a member
of.

[ ... ]

> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	lan9645x_vlan_hw_wr(lan9645x, vid);
> +	lan9645x_vlan_port_apply_ingress(p);
> +	lan9645x_vlan_port_apply_egress(p, &info);
> +
> +	return 0;
> +}

[Severity: Low]
Should the return value of lan9645x_vlan_hw_wr() be checked here, before
the software state is committed?

This path updates lan9645x->vlans[] and p->pvid, reprograms the port
ingress and egress configuration, and returns 0 even when the table
write failed. lan9645x_vlan_port_del_vlan(), lan9645x_vlan_cpu_add(),
lan9645x_vlan_cpu_del() and lan9645x_vlan_set_hostmode() do the same.

Inside lan9645x_vlan_hw_wr(), the ANA_VLANTIDX, ANA_VLAN_PORT_MASK and
ANA_VLANACCESS writes go through lan_wr(), which only does WARN_ON_ONCE()
on a regmap error. The engine is also not checked for IDLE before a new
command is issued.

When this fails, the shadow table and the hardware can diverge while
switchdev believes the change succeeded. For the CPU port, DSA caches the
VID as installed, so later adds of the same VID only bump a refcount and
never restore the missing membership.

The comment in lan9645x_vlan_hw_wr() says a timeout most likely means
the register bus is dead, which limits the practical impact. lan_wr()
swallowing errors also predates this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
