Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB93EC6BE;
	Sun, 27 Sep 2026 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512120; cv=none; b=QD8XzJ/sNBTIHu9sYKgNk4BI0PNu3YbfWvMGD14Mr9FUJH34EZTvM5EaOZDfmYbEOe1+TelkaEypVXsHgOcBgeUejb78AvGIOeNDsD8vpkqoFqGSLSs7lgInh+iur5Cc6S4nzJ0xwt86LEIP/tsO/Us6kHTxoD3P8CwLmteSBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512120; c=relaxed/simple;
	bh=aSBrh2SOlD6gJyUKjGqZ7NrxappcKsxMwVneHSokIxc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGkefG2U5JwbtJc80VFQFenSaiUx5c1viw0+V82gzEwvLRxIg4XldDStcH4WSXn9H+3/fvpLOIxrbbLS/Fjm+CA0pjSWpauecvIrlwbKvr/RIArCKeobKrr9QdK+pT6H/wff97UkYdbNsflS28ZrixGJzOUQxKkcRHNrb75MVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmLAbSp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmLAbSp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B731F00899;
	Sun, 27 Sep 2026 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512113;
	bh=hNLJNHHxoeOVyaBVL3OWEgoIROqdJWUZocg57NdZ1XM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZmLAbSp4xupXzz10nrrQ9ivBlQiFXeuwqw6ildIyHhlfL1ZXs90k9lKR0JT2BeAsR
	 TPGpgwRXcMkHpePh5TwcpqWiAFEaECE5E0rw5kC6CvkcO/+sbsttMD5JSHuj03ZA8K
	 hB6CUu2Jl5oyPDEaVCxjjCLt18BPzquEWbXCHBOxryC9hPxhYd4+AYOPjdvxgLbRDv
	 95SizNGwU0bLBWfTmLwKE4HVqZkHaJIyLEK4lrnsVf5k4zSBpEtKftUUmi2bwptAW1
	 dqtC7kE7UFBNkR7GIw9vJ5NB+86OQ7196Be3/ra7K9y0qywWsUA9wKOPO0hW7FTry3
	 llX0Uzqhy07Ow==
Subject: Re: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:32 +0000
Message-ID: <179051211234.2160803.14011887621718536778@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] soce_sw_probe() sets ds->needs_standalone_vlan_filtering = true
  unconditionally (drivers/net/dsa/soce/soce_dsa_core.c:654), including…
- [High] net: dsa: soce: needs_standalone_vlan_filtering drops standalone
  traffic after bridge leave
- [Medium] The commit message says the patch adds "VLAN filtering and
  membership offload" and "configure[s] ports in Hybrid and C-Port modes…
- [Medium] The commit message says unsupported VLAN operations are
  rejected "with a netlink extended acknowledgment".
- [Medium] The driver sets ds->needs_standalone_vlan_filtering, so DSA
  advertises NETIF_F_HW_VLAN_CTAG_FILTER and sends 8021q-upper VIDs to…
- [Medium] soce_port_vlan_add() handles only the case where
  BRIDGE_VLAN_INFO_PVID is set (lines 496-500).
- [Medium] soce_vlan_write_entry() programs one VID with two independent
  hardware commands.
- [Low] soce_vlan_teardown() resets the hardware VLAN table
  (soce_vlan_reset()) and turns VLAN off, but leaves…

--

net: dsa: soce: Add VLAN offload support

This patch adds VLAN filtering and membership offload for SoC-e switch
cores that implement the Port VLAN synthesis option. On cores without that
option, VLAN operations are rejected. Per-VID member and untagged masks are
tracked in software and programmed through a selector interface, which a
new vlan_lock mutex serializes.

> diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
> index d391b11b94ad6..f93ce9da8400c 100644
> --- a/drivers/net/dsa/soce/soce_dsa_core.c
> +++ b/drivers/net/dsa/soce/soce_dsa_core.c

[ ... ]

> @@ -162,6 +200,178 @@ static void soce_sw_disable_tagging(struct soce_dsa_local *local)

[ ... ]

> +static int soce_vlan_write_entry(struct soce_priv *priv, u16 vid)
> +{
> +	struct soce_dsa_local *local = &priv->local;
> +	void __iomem *base = local->base_addr;
> +	u32 cpu_ports;
> +	u32 untagged;
> +	u32 members;
> +	int ret;
> +
> +	/* The CPU port must be a tagged member of every active VLAN so
> +	 * tagged frames can reach the conduit.
> +	 */
> +	cpu_ports = dsa_cpu_ports(&priv->ds);
> +	members = priv->vlan_members[vid];
> +	if (members)
> +		members |= cpu_ports;
> +	untagged = priv->vlan_untagged[vid] & ~cpu_ports;
> +
> +	soce_vlan_select_vid(local, vid);
> +	writel(members, base + SOCE_VLAN_MEMBER_PORTS_OFFSET);
> +	writel(SOCE_VLAN_MEMBER_CTRL_WRITE,
> +	       base + SOCE_VLAN_MEMBER_CTRL_OFFSET);
> +	ret = soce_vlan_wait_for_write(local, SOCE_VLAN_MEMBER_CTRL_OFFSET,
> +				       SOCE_VLAN_MEMBER_CTRL_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	writel(untagged, base + SOCE_VLAN_UNTAG_PORTS_OFFSET);
> +	writel(SOCE_VLAN_UNTAG_CTRL_WRITE,
> +	       base + SOCE_VLAN_UNTAG_CTRL_OFFSET);
> +
> +	return soce_vlan_wait_for_write(local, SOCE_VLAN_UNTAG_CTRL_OFFSET,
> +					SOCE_VLAN_UNTAG_CTRL_WRITE);
> +}

[Severity: Medium]
What happens if the member command completes but the untag poll times out?

At that point the hardware member table already holds the new mask. The
callers, soce_port_vlan_add() and soce_port_vlan_del(), only restore the
software shadow:

    members[vlan->vid] = old_members;
    untagged_ports[vlan->vid] = old_untagged;
    return ret;

If an add fails this way, DSA and 8021q treat the VID as not added. The
port and the CPU ports are still members in hardware.

If a delete fails this way, the hardware has already removed the port, but
the shadow puts it back. The next soce_vlan_write_entry() for that VID then
re-adds the port in hardware.

There is also the case where the member command itself times out and the
WRITE bit may still be pending. The next VLAN operation rewrites
SOCE_VLAN_VID_SEL and the data registers without checking that the command
engine is idle. Could a stale command then hit another VID's entry? That
part depends on the hardware.

> +
> +static int soce_vlan_setup(struct dsa_switch *ds)
> +{

[ ... ]

> +	/* Default every port to PVID 1, unfiltered, so standalone
> +	 * forwarding keeps working before any bridge VLAN is configured.
> +	 */
> +	scoped_guard(mutex, &priv->vlan_lock) {
> +		dsa_switch_for_each_available_port(dp, ds) {
> +			priv->port_pvid[dp->index] = 1;
> +			soce_vlan_config_port(priv, dp->index, false);
> +		}
> +		soce_vlan_set_enabled(local, true);
> +	}

[Severity: Medium]
This leaves every available port, including the CPU port, in
SOCE_VLAN_PORT_TYPE_UNAWARE with ingress filtering off and
SOCE_VLAN_PORT_EGR_TAG_UNTAG_PORT. Can any reachable path move a port out
of that mode?

Because ds->needs_standalone_vlan_filtering is set, 8021q upper VIDs reach
soce_port_vlan_add(). soce_vlan_write_entry() then programs the member mask
and a custom untag mask that deliberately leaves out the CPU port.

The only path to C_PORT, INGR_FILTER_EN and EGR_TAG_CUSTOM_UNTAG is
soce_port_vlan_filtering(). That is not called without bridge offload (see
the comment on soce_switch_ops below).

The DSA core doesn't enable standalone filtering on its own. The only
needs_standalone_vlan_filtering handling in net/dsa/port.c is in
dsa_port_reset_vlan_filtering(), on bridge leave. hellcreek, the other user
of this flag, sets up standalone VLAN-aware isolation in the driver.

If the register names match the hardware behaviour, this mode ignores the
member and custom untag tables. Would 8021q upper TX frames then leave the
user port untagged, with no ingress VID filtering?

The exact meaning of EGR_TAG_UNTAG_PORT and PORT_TYPE_UNAWARE is inferred
from the macro names and should be checked against the SoC-e
documentation.

> +
> +	return 0;
> +}
> +
> +static void soce_vlan_teardown(struct soce_priv *priv)
> +{
> +	struct soce_dsa_local *local = &priv->local;
> +	int ret;
> +
> +	if (!priv->features.port_vlan)
> +		return;
> +
> +	scoped_guard(mutex, &priv->vlan_lock) {
> +		ret = soce_vlan_reset(local);
> +		if (ret)
> +			dev_warn(priv->ds.dev,
> +				 "failed to reset VLAN configuration during teardown: %d\n",
> +				 ret);
> +		soce_vlan_set_enabled(local, false);
> +	}
> +}

[Severity: Low]
Should priv->vlan_members[] and priv->vlan_untagged[] also be cleared here?

The hardware VLAN table is reset, but both arrays keep their contents.
soce_vlan_setup() only re-initialises port_pvid[]. The per-VID arrays are
zeroed only once, by devm_kcalloc() in soce_sw_probe().

DSA can call teardown and then setup again on the same priv without a new
probe. One example is a multi-switch tree where another member switch is
removed and re-probed: dsa_tree_teardown() runs, followed by
dsa_tree_setup().

The shadow normally drains through port_vlan_del before teardown. It does
not drain when soce_port_vlan_del() fails, because that path puts the old
bits back after the core has already forgotten the VLAN.

Can those stale bits survive the reset and be ORed into the next
soce_port_vlan_add() for that VID, re-adding ports nobody configured?

Clearing both arrays under vlan_lock in setup or teardown would keep the
shadow in step with the hardware reset.

[ ... ]

> @@ -224,6 +443,130 @@ static enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds,
>  	return DSA_TAG_PROTO_SDSA;
>  }
>  
> +static int soce_port_vlan_add(struct dsa_switch *ds, int port,
> +			      const struct switchdev_obj_port_vlan *vlan,
> +			      struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (!priv->features.port_vlan) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port VLAN support is not implemented in the switch core");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!vlan->vid)
> +		return 0;

[Severity: Medium]
The commit message says unsupported VLAN operations are rejected "with a
netlink extended acknowledgment". Does this extack actually reach
userspace for 8021q uppers?

The call chain vlan_newlink()->register_vlan_dev()->vlan_vid_add()->
ndo_vlan_rx_add_vid carries no extack. dsa_user_vlan_rx_add_vid() fills in
a local extack on the stack and only logs it:

    ret = dsa_port_vlan_add(dp, &vlan, &extack);
    if (ret) {
        if (extack._msg)
            netdev_err(dev, "%s\n", extack._msg);
        return ret;
    }

As a result, userspace only gets a bare -EOPNOTSUPP.

There is a second issue: the feature check runs before the VID 0 early
return.

When the 8021q module is loaded, vlan_vid0_add() calls
vlan_vid_add(dev, htons(ETH_P_8021Q), 0) on every NETDEV_UP for netdevs
with NETIF_F_HW_VLAN_CTAG_FILTER. With this patch, that is every soce user
port.

On cores without Port VLAN, won't this log "Port VLAN support is not
implemented in the switch core" at error level every time an interface
comes up, even though VID 0 needs no hardware work? Moving the !vlan->vid
check above the feature check would avoid that.

[ ... ]

> +		if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
> +			priv->port_pvid[port] = vlan->vid;
> +			soce_vlan_config_port(priv, port,
> +					      dsa_port_is_vlan_filtering(dp));
> +		}
> +	}

[Severity: Medium]
This handles only the case where BRIDGE_VLAN_INFO_PVID is set. What happens
when an existing PVID VLAN is notified again without the PVID flag?

struct switchdev_obj_port_vlan documents that notifications with
changed=true carry PVID/UNTAGGED flag changes for a VLAN that already
exists. nbp_vlan_add() sends these, and dsa_port_do_vlan_add() passes them
straight to the driver for user ports.

For example:

    bridge vlan add dev swpX vid 10 pvid untagged
    bridge vlan add dev swpX vid 10

The second command arrives as an add with changed=true and no PVID flag.
port_pvid[port], the hardware PVID register and ACCEPT_ALL all stay at
VID 10, and the callback still returns success.

At that point the bridge expects untagged ingress to be dropped. Wouldn't
the hardware still classify it into VID 10?

Something like this might be needed:

    else if (priv->port_pvid[port] == vlan->vid) {
        priv->port_pvid[port] = 0;
        soce_vlan_config_port(priv, port, dsa_port_is_vlan_filtering(dp));
    }

This can't be reached yet, at this revision or at the end of the series,
because there is no .port_bridge_join. Any follow-up that adds bridge
offload would make it reachable.

[ ... ]

>  static const struct dsa_switch_ops soce_switch_ops = {
>  	.get_tag_protocol	= soce_get_tag_protocol,
>  	.setup			= soce_setup,
> @@ -231,6 +574,9 @@ static const struct dsa_switch_ops soce_switch_ops = {
>  	.phylink_get_caps	= soce_phylink_get_caps,
>  	.port_enable		= soce_port_enable,
>  	.port_disable		= soce_port_disable,
> +	.port_vlan_filtering	= soce_port_vlan_filtering,
> +	.port_vlan_add		= soce_port_vlan_add,
> +	.port_vlan_del		= soce_port_vlan_del,
>  };

[Severity: Medium]
The commit message says the patch adds "VLAN filtering and membership
offload" and will "configure ports in Hybrid and C-Port modes and manage
their PVID, ingress filtering and acceptance mode, and custom egress
untagging".

Can any of the filtering, PVID or untagged logic run without a
.port_bridge_join op?

Without that op, dsa_switch_bridge_join() returns -EOPNOTSUPP.
dsa_user_changeupper() then turns this into a software bridge join, so
dp->bridge stays NULL:

    if (err == -EOPNOTSUPP) {
        NL_SET_ERR_MSG_WEAK_MOD(extack, "Offloading not supported");
        err = 0;
    }

ds->ops->port_vlan_filtering has three callers:

  - dsa_port_switchdev_sync_attrs(), after a successful join
  - dsa_port_reset_vlan_filtering(), on leaving an offloaded bridge
  - the SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING handler, which requires
    dsa_port_offloads_bridge_dev()

None of these can run, so soce_port_vlan_filtering() looks unreachable.

Bridge VLAN objects hit the !dp->bridge check in dsa_user_host_vlan_add()
and fall back to vlan_vid_add(). That ends up in
dsa_user_vlan_rx_add_vid(), which has:

    /* This API only allows programming tagged, non-PVID VIDs */
    .flags = 0,

So soce_port_vlan_add() never sees BRIDGE_VLAN_INFO_PVID or
BRIDGE_VLAN_INFO_UNTAGGED. Ports never leave the unfiltered PVID 1 state
set up by soce_vlan_setup().

The only live path is tagged, non-PVID membership, for 8021q uppers or
software bridge VIDs.

This is still the case at the end of the series; the last patch, "net: dsa:
soce: Disable unsupported hardware STP", only adds STP disabling. Should
the commit message be adjusted, or should bridge offload be added?

[ ... ]

> @@ -278,8 +623,35 @@ static int soce_sw_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  

[ ... ]

>  	ds->ops = &soce_switch_ops;
> -	ds->num_ports = hw_numports;
> +	ds->num_ports = priv->features.num_ports;
> +
> +	/* Force VLAN uppers always through the callbacks, so cores without
> +	 * Port VLAN feature can reject them instead of silently dropping
> +	 * VLAN frames.
> +	 */
> +	ds->needs_standalone_vlan_filtering = true;

[Severity: High]
What happens to a port that leaves a bridge while this flag is set?

With needs_standalone_vlan_filtering, dsa_port_bridge_leave() calls
dsa_port_reset_vlan_filtering(). When the bridge being left was
VLAN-unaware, that function forces vlan_filtering=true.

The call ends up in soce_port_vlan_filtering(), which calls
soce_vlan_config_port(). That switches the port to
SOCE_VLAN_PORT_TYPE_C_PORT with SOCE_VLAN_PORT_INGR_FILTER_EN set.

Nothing in the driver gives a standalone port a VLAN to be classified
into. soce_vlan_setup() sets port_pvid[] to 1. It never adds the port
to vlan_members[1], and it never programs the VID 1 member entry.

By the time the port is standalone again, the bridge has also flushed
its own VLANs through soce_port_vlan_del(). One of two things then
happens:

  - port_pvid[] is still 1. Untagged frames are classified into
    VID 1, and the ingress filter drops them because the port is not
    a member.
  - VID 1 was deleted as the PVID, so port_pvid[] is 0.
    SOCE_VLAN_PORT_INGR_ACCEPT_TAGGED_ONLY then drops untagged frames
    at ingress.

In both cases untagged standalone traffic on that port stops after a
bridge join/leave cycle. This contradicts the comment in
soce_vlan_setup(), which says standalone forwarding keeps working.

hellcreek, the other user of this flag, programs a private per-port
VLAN so that standalone ports stay reachable with filtering enabled.
Is something similar planned here?

Alternatively, would it be simpler not to set the flag at all? Cores
without Port VLAN could then reject VLAN uppers from
.port_prechangeupper instead.

This is latent at this revision. Without .port_bridge_join, the join
is rolled back and dp->bridge stays NULL. dsa_port_bridge_leave()
then returns early. The problem becomes reachable as soon as bridge
offload is added.

[Severity: High]
This flag is set even when priv->features.port_vlan is false. Does that
break plain bridge membership on cores without Port VLAN?

With the flag set, dsa_user_setup_tagger() advertises
NETIF_F_HW_VLAN_CTAG_FILTER on every user netdev.

The failure needs CONFIG_VLAN_8021Q and CONFIG_BRIDGE_VLAN_FILTERING and
the default vlan_default_pvid=1. It happens whatever the bridge's
vlan_filtering setting is:

ip link set lanX master br0
  br_add_if()
    nbp_vlan_init()
      nbp_vlan_add(vid 1, PVID | UNTAGGED)
        __vlan_add()
          __vlan_vid_add()
            switchdev returns -EOPNOTSUPP (!dp->bridge)
            vlan_vid_add(dev, 8021Q, 1)
              dsa_user_vlan_rx_add_vid()
                dsa_port_vlan_add()
                  soce_port_vlan_add()
                    returns -EOPNOTSUPP (!features.port_vlan)

nbp_vlan_init() then fails, and br_add_if() aborts the enslave:

    err = nbp_vlan_init(p, extack);
    if (err) {
        netdev_err(dev, "failed to initialize vlan filtering on this port\n");
        goto err6;
    }

Software bridging on these cores worked with the previous patch in the
series.

Neither the commit message ("reject VLAN operations") nor the probe
comment says that bridge membership is now refused. The refusal is also
inconsistent: a bridge created with vlan_default_pvid 0 still works, and
standalone ports see the same VLAN-stripping behaviour.

Is this refusal intended for cores without Port VLAN?

> +
>  	ret = devm_of_platform_populate(dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
