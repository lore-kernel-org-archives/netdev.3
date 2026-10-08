Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D14DDB48;
	Thu,  8 Oct 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472937; cv=none; b=Bhpf+Sz0ZmYDkivMBBlgGAmtvWjoWlV2wnNlWhxOrG18qRINKpCl8Uq1tKme698LrJ4Tvz0SShFSKX3AC9TbjqUbL4OvmRCF7cjxa7zshNuThKnkNCtwu2wpVvGfEGseRSRjfHT+jaMBSt0CyyFANt7pCHwcHwTYylpfaxrbBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472937; c=relaxed/simple;
	bh=Wdgx+vpQgCeQ1RNoc2rPTpFAQsf6oE6ow3STFCh7Gpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugSZSo8zXaAS67+xttXFBSAp0Pl1yas7C0Fl24xPP+YurZB/D+ys6bEr8HdjRqQtcNr65/3XDw4tnU0zWsJ7eo2qh9PyyVUJilkPzxcppk142Htpba08H2vmPGAQ+1emX3rFdARRexpCFkBMv5e57/d6Zd0saSc7h5h5WY2aP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9ifY304; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5EkYHHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9ifY304";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5EkYHHV"
Message-ID: <4b2a6049a5148b49f056f0d5c79d57e25be56ef0.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791472929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg8S01z/Dmsd8hMBJeySX21kzmeXdtqkUGl4UIooU8A=;
	b=e9ifY304UAulCg6e5l91825yxFvNUNeR1dZZkp+4iLhdY8gy6RjHyRe6Zs9wHCN2B8/puv
	nWYImbptAtGh8GBD7dHSzox7maf0uVtB8PmbKjTltBffu8G0EDVz//YoIyWw/CSJKMzysu
	sHuysEpKDuXohezhcUNIT+s0/cTjLjl9RrjlTI/9abP/tpp0+YAXcmrxeHK+wAJK5IO4Cj
	mIW0rCv1cUyhGer3VqUOBGXQH8CZR4wj/2R8cjRqSly5XmrIhyFJa8FvMHXOCb52jC5sFr
	TA7QCmmSpTGSSFcN1Rpt54PoYQpkItxWR9ZbQBoUBdgCgPLEgcHWKOeJOsHLTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791472929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg8S01z/Dmsd8hMBJeySX21kzmeXdtqkUGl4UIooU8A=;
	b=u5EkYHHVFQ8+/vQlSziGSSNOaFDsEqraaoneIIZETzMrAQp9muqGgMyYWsh77J0m1XTfPV
	Bahm4bBkirIz8TDQ==
Subject: Re: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch,  olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch,  hkallweit1@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Thu, 08 Oct 2026 17:22:08 +0200
In-Reply-To: <179051211234.2160803.14011887621718536778@kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
	 <179051211234.2160803.14011887621718536778@kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 12:28 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 5 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] soce_sw_probe() sets ds->needs_standalone_vlan_filtering =3D tru=
e
>   unconditionally (drivers/net/dsa/soce/soce_dsa_core.c:654), including=
=E2=80=A6
> - [High] net: dsa: soce: needs_standalone_vlan_filtering drops standalone
>   traffic after bridge leave
> - [Medium] The commit message says the patch adds "VLAN filtering and
>   membership offload" and "configure[s] ports in Hybrid and C-Port modes=
=E2=80=A6
> - [Medium] The commit message says unsupported VLAN operations are
>   rejected "with a netlink extended acknowledgment".
> - [Medium] The driver sets ds->needs_standalone_vlan_filtering, so DSA
>   advertises NETIF_F_HW_VLAN_CTAG_FILTER and sends 8021q-upper VIDs to=E2=
=80=A6
> - [Medium] soce_port_vlan_add() handles only the case where
>   BRIDGE_VLAN_INFO_PVID is set (lines 496-500).
> - [Medium] soce_vlan_write_entry() programs one VID with two independent
>   hardware commands.
> - [Low] soce_vlan_teardown() resets the hardware VLAN table
>   (soce_vlan_reset()) and turns VLAN off, but leaves=E2=80=A6
>=20
> --
>=20
> net: dsa: soce: Add VLAN offload support
>=20
> This patch adds VLAN filtering and membership offload for SoC-e switch
> cores that implement the Port VLAN synthesis option. On cores without tha=
t
> option, VLAN operations are rejected. Per-VID member and untagged masks a=
re
> tracked in software and programmed through a selector interface, which a
> new vlan_lock mutex serializes.
>=20
> > diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soc=
e/soce_dsa_core.c
> > index d391b11b94ad6..f93ce9da8400c 100644
> > --- a/drivers/net/dsa/soce/soce_dsa_core.c
> > +++ b/drivers/net/dsa/soce/soce_dsa_core.c
>=20
> [ ... ]
>=20
> > @@ -162,6 +200,178 @@ static void soce_sw_disable_tagging(struct soce_d=
sa_local *local)
>=20
> [ ... ]
>=20
> > +static int soce_vlan_write_entry(struct soce_priv *priv, u16 vid)
> > +{
> > +	struct soce_dsa_local *local =3D &priv->local;
> > +	void __iomem *base =3D local->base_addr;
> > +	u32 cpu_ports;
> > +	u32 untagged;
> > +	u32 members;
> > +	int ret;
> > +
> > +	/* The CPU port must be a tagged member of every active VLAN so
> > +	 * tagged frames can reach the conduit.
> > +	 */
> > +	cpu_ports =3D dsa_cpu_ports(&priv->ds);
> > +	members =3D priv->vlan_members[vid];
> > +	if (members)
> > +		members |=3D cpu_ports;
> > +	untagged =3D priv->vlan_untagged[vid] & ~cpu_ports;
> > +
> > +	soce_vlan_select_vid(local, vid);
> > +	writel(members, base + SOCE_VLAN_MEMBER_PORTS_OFFSET);
> > +	writel(SOCE_VLAN_MEMBER_CTRL_WRITE,
> > +	       base + SOCE_VLAN_MEMBER_CTRL_OFFSET);
> > +	ret =3D soce_vlan_wait_for_write(local, SOCE_VLAN_MEMBER_CTRL_OFFSET,
> > +				       SOCE_VLAN_MEMBER_CTRL_WRITE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	writel(untagged, base + SOCE_VLAN_UNTAG_PORTS_OFFSET);
> > +	writel(SOCE_VLAN_UNTAG_CTRL_WRITE,
> > +	       base + SOCE_VLAN_UNTAG_CTRL_OFFSET);
> > +
> > +	return soce_vlan_wait_for_write(local, SOCE_VLAN_UNTAG_CTRL_OFFSET,
> > +					SOCE_VLAN_UNTAG_CTRL_WRITE);
> > +}
>=20
> [Severity: Medium]
> What happens if the member command completes but the untag poll times out=
?
>=20
> At that point the hardware member table already holds the new mask. The
> callers, soce_port_vlan_add() and soce_port_vlan_del(), only restore the
> software shadow:
>=20
>     members[vlan->vid] =3D old_members;
>     untagged_ports[vlan->vid] =3D old_untagged;
>     return ret;
>=20
> If an add fails this way, DSA and 8021q treat the VID as not added. The
> port and the CPU ports are still members in hardware.
>=20
> If a delete fails this way, the hardware has already removed the port, bu=
t
> the shadow puts it back. The next soce_vlan_write_entry() for that VID th=
en
> re-adds the port in hardware.
>=20
> There is also the case where the member command itself times out and the
> WRITE bit may still be pending. The next VLAN operation rewrites
> SOCE_VLAN_VID_SEL and the data registers without checking that the comman=
d
> engine is idle. Could a stale command then hit another VID's entry? That
> part depends on the hardware.
>=20

This was already mentioned by kernel bot. It will be addressed by
checking both write bits before changing the VID selector or data
registers and attempting to restore the previous hardware entry on
failure. The rollback will be best-effort. If it also fails, hardware
and software state may remain inconsistent.

> > +
> > +static int soce_vlan_setup(struct dsa_switch *ds)
> > +{
>=20
> [ ... ]
>=20
> > +	/* Default every port to PVID 1, unfiltered, so standalone
> > +	 * forwarding keeps working before any bridge VLAN is configured.
> > +	 */
> > +	scoped_guard(mutex, &priv->vlan_lock) {
> > +		dsa_switch_for_each_available_port(dp, ds) {
> > +			priv->port_pvid[dp->index] =3D 1;
> > +			soce_vlan_config_port(priv, dp->index, false);
> > +		}
> > +		soce_vlan_set_enabled(local, true);
> > +	}
>=20
> [Severity: Medium]
> This leaves every available port, including the CPU port, in
> SOCE_VLAN_PORT_TYPE_UNAWARE with ingress filtering off and
> SOCE_VLAN_PORT_EGR_TAG_UNTAG_PORT. Can any reachable path move a port out
> of that mode?
>=20
> Because ds->needs_standalone_vlan_filtering is set, 8021q upper VIDs reac=
h
> soce_port_vlan_add(). soce_vlan_write_entry() then programs the member ma=
sk
> and a custom untag mask that deliberately leaves out the CPU port.
>=20
> The only path to C_PORT, INGR_FILTER_EN and EGR_TAG_CUSTOM_UNTAG is
> soce_port_vlan_filtering(). That is not called without bridge offload (se=
e
> the comment on soce_switch_ops below).
>=20
> The DSA core doesn't enable standalone filtering on its own. The only
> needs_standalone_vlan_filtering handling in net/dsa/port.c is in
> dsa_port_reset_vlan_filtering(), on bridge leave. hellcreek, the other us=
er
> of this flag, sets up standalone VLAN-aware isolation in the driver.
>=20
> If the register names match the hardware behaviour, this mode ignores the
> member and custom untag tables. Would 8021q upper TX frames then leave th=
e
> user port untagged, with no ingress VID filtering?
>=20
> The exact meaning of EGR_TAG_UNTAG_PORT and PORT_TYPE_UNAWARE is inferred
> from the macro names and should be checked against the SoC-e
> documentation.
>=20

I mixed up VLAN membership programming with bridge VLAN filtering.
Bridge offload will not be included in this series. In the next
revision, I will remove the unreachable bridge-filtering code and update
the commit message accordingly.
Ports will remain VLAN-unaware with ingress filtering disabled. Hardware
testing confirmed that existing in-band VLAN tags are preserved in this
mode. The SDSA-TCI TX path has not been tested on this platform, where
TX VLAN offload is disabled and fixed.

> > +
> > +	return 0;
> > +}
> > +
> > +static void soce_vlan_teardown(struct soce_priv *priv)
> > +{
> > +	struct soce_dsa_local *local =3D &priv->local;
> > +	int ret;
> > +
> > +	if (!priv->features.port_vlan)
> > +		return;
> > +
> > +	scoped_guard(mutex, &priv->vlan_lock) {
> > +		ret =3D soce_vlan_reset(local);
> > +		if (ret)
> > +			dev_warn(priv->ds.dev,
> > +				 "failed to reset VLAN configuration during teardown: %d\n",
> > +				 ret);
> > +		soce_vlan_set_enabled(local, false);
> > +	}
> > +}
>=20
> [Severity: Low]
> Should priv->vlan_members[] and priv->vlan_untagged[] also be cleared her=
e?
>=20
> The hardware VLAN table is reset, but both arrays keep their contents.
> soce_vlan_setup() only re-initialises port_pvid[]. The per-VID arrays are
> zeroed only once, by devm_kcalloc() in soce_sw_probe().
>=20
> DSA can call teardown and then setup again on the same priv without a new
> probe. One example is a multi-switch tree where another member switch is
> removed and re-probed: dsa_tree_teardown() runs, followed by
> dsa_tree_setup().
>=20
> The shadow normally drains through port_vlan_del before teardown. It does
> not drain when soce_port_vlan_del() fails, because that path puts the old
> bits back after the core has already forgotten the VLAN.
>=20
> Can those stale bits survive the reset and be ORed into the next
> soce_port_vlan_add() for that VID, re-adding ports nobody configured?
>=20
> Clearing both arrays under vlan_lock in setup or teardown would keep the
> shadow in step with the hardware reset.
>=20

Good point. I will clear vlan_members during setup. The previously
mentioned cleanup will remove vlan_untagged entirely.

> [ ... ]
>=20
> > @@ -224,6 +443,130 @@ static enum dsa_tag_protocol soce_get_tag_protoco=
l(struct dsa_switch *ds,
> >  	return DSA_TAG_PROTO_SDSA;
> >  }
> > =20
> > +static int soce_port_vlan_add(struct dsa_switch *ds, int port,
> > +			      const struct switchdev_obj_port_vlan *vlan,
> > +			      struct netlink_ext_ack *extack)
> > +{
>=20
> [ ... ]
>=20
> > +	if (!priv->features.port_vlan) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Port VLAN support is not implemented in the switch core");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!vlan->vid)
> > +		return 0;
>=20
> [Severity: Medium]
> The commit message says unsupported VLAN operations are rejected "with a
> netlink extended acknowledgment". Does this extack actually reach
> userspace for 8021q uppers?
>=20
> The call chain vlan_newlink()->register_vlan_dev()->vlan_vid_add()->
> ndo_vlan_rx_add_vid carries no extack. dsa_user_vlan_rx_add_vid() fills i=
n
> a local extack on the stack and only logs it:
>=20
>     ret =3D dsa_port_vlan_add(dp, &vlan, &extack);
>     if (ret) {
>         if (extack._msg)
>             netdev_err(dev, "%s\n", extack._msg);
>         return ret;
>     }
>=20
> As a result, userspace only gets a bare -EOPNOTSUPP.
>=20
> There is a second issue: the feature check runs before the VID 0 early
> return.
>=20
> When the 8021q module is loaded, vlan_vid0_add() calls
> vlan_vid_add(dev, htons(ETH_P_8021Q), 0) on every NETDEV_UP for netdevs
> with NETIF_F_HW_VLAN_CTAG_FILTER. With this patch, that is every soce use=
r
> port.
>=20
> On cores without Port VLAN, won't this log "Port VLAN support is not
> implemented in the switch core" at error level every time an interface
> comes up, even though VID 0 needs no hardware work? Moving the !vlan->vid
> check above the feature check would avoid that.
>=20

True. I will correct the commit message and reject unsupported direct
VLAN uppers through port_prechangeupper, which allows an extack to reach
userspace (and fixes findings mentioned below).
I will also handle VID 0 before the feature check in both VLAN callbacks
and set needs_standalone_vlan_filtering only on VLAN-capable cores.

> [ ... ]
>=20
> > +		if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
> > +			priv->port_pvid[port] =3D vlan->vid;
> > +			soce_vlan_config_port(priv, port,
> > +					      dsa_port_is_vlan_filtering(dp));
> > +		}
> > +	}
>=20
> [Severity: Medium]
> This handles only the case where BRIDGE_VLAN_INFO_PVID is set. What happe=
ns
> when an existing PVID VLAN is notified again without the PVID flag?
>=20
> struct switchdev_obj_port_vlan documents that notifications with
> changed=3Dtrue carry PVID/UNTAGGED flag changes for a VLAN that already
> exists. nbp_vlan_add() sends these, and dsa_port_do_vlan_add() passes the=
m
> straight to the driver for user ports.
>=20
> For example:
>=20
>     bridge vlan add dev swpX vid 10 pvid untagged
>     bridge vlan add dev swpX vid 10
>=20
> The second command arrives as an add with changed=3Dtrue and no PVID flag=
.
> port_pvid[port], the hardware PVID register and ACCEPT_ALL all stay at
> VID 10, and the callback still returns success.
>=20
> At that point the bridge expects untagged ingress to be dropped. Wouldn't
> the hardware still classify it into VID 10?
>=20
> Something like this might be needed:
>=20
>     else if (priv->port_pvid[port] =3D=3D vlan->vid) {
>         priv->port_pvid[port] =3D 0;
>         soce_vlan_config_port(priv, port, dsa_port_is_vlan_filtering(dp))=
;
>     }
>=20
> This can't be reached yet, at this revision or at the end of the series,
> because there is no .port_bridge_join. Any follow-up that adds bridge
> offload would make it reachable.

This will be fixed with previous mentioned bridge cleanup.

>=20
> [ ... ]
>=20
> >  static const struct dsa_switch_ops soce_switch_ops =3D {
> >  	.get_tag_protocol	=3D soce_get_tag_protocol,
> >  	.setup			=3D soce_setup,
> > @@ -231,6 +574,9 @@ static const struct dsa_switch_ops soce_switch_ops =
=3D {
> >  	.phylink_get_caps	=3D soce_phylink_get_caps,
> >  	.port_enable		=3D soce_port_enable,
> >  	.port_disable		=3D soce_port_disable,
> > +	.port_vlan_filtering	=3D soce_port_vlan_filtering,
> > +	.port_vlan_add		=3D soce_port_vlan_add,
> > +	.port_vlan_del		=3D soce_port_vlan_del,
> >  };
>=20
> [Severity: Medium]
> The commit message says the patch adds "VLAN filtering and membership
> offload" and will "configure ports in Hybrid and C-Port modes and manage
> their PVID, ingress filtering and acceptance mode, and custom egress
> untagging".
>=20
> Can any of the filtering, PVID or untagged logic run without a
> .port_bridge_join op?
>=20
> Without that op, dsa_switch_bridge_join() returns -EOPNOTSUPP.
> dsa_user_changeupper() then turns this into a software bridge join, so
> dp->bridge stays NULL:
>=20
>     if (err =3D=3D -EOPNOTSUPP) {
>         NL_SET_ERR_MSG_WEAK_MOD(extack, "Offloading not supported");
>         err =3D 0;
>     }
>=20
> ds->ops->port_vlan_filtering has three callers:
>=20
>   - dsa_port_switchdev_sync_attrs(), after a successful join
>   - dsa_port_reset_vlan_filtering(), on leaving an offloaded bridge
>   - the SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING handler, which requires
>     dsa_port_offloads_bridge_dev()
>=20
> None of these can run, so soce_port_vlan_filtering() looks unreachable.
>=20
> Bridge VLAN objects hit the !dp->bridge check in dsa_user_host_vlan_add()
> and fall back to vlan_vid_add(). That ends up in
> dsa_user_vlan_rx_add_vid(), which has:
>=20
>     /* This API only allows programming tagged, non-PVID VIDs */
>     .flags =3D 0,
>=20
> So soce_port_vlan_add() never sees BRIDGE_VLAN_INFO_PVID or
> BRIDGE_VLAN_INFO_UNTAGGED. Ports never leave the unfiltered PVID 1 state
> set up by soce_vlan_setup().
>=20
> The only live path is tagged, non-PVID membership, for 8021q uppers or
> software bridge VIDs.
>=20
> This is still the case at the end of the series; the last patch, "net: ds=
a:
> soce: Disable unsupported hardware STP", only adds STP disabling. Should
> the commit message be adjusted, or should bridge offload be added?
>=20

Same here. I will remove the unreachable bridging related code and
update commit message.


> [ ... ]
>=20
> > @@ -278,8 +623,35 @@ static int soce_sw_probe(struct platform_device *p=
dev)
> >  		return ret;
> >  	}
> > =20
>=20
> [ ... ]
>=20
> >  	ds->ops =3D &soce_switch_ops;
> > -	ds->num_ports =3D hw_numports;
> > +	ds->num_ports =3D priv->features.num_ports;
> > +
> > +	/* Force VLAN uppers always through the callbacks, so cores without
> > +	 * Port VLAN feature can reject them instead of silently dropping
> > +	 * VLAN frames.
> > +	 */
> > +	ds->needs_standalone_vlan_filtering =3D true;
>=20
> [Severity: High]
> What happens to a port that leaves a bridge while this flag is set?
>=20
> With needs_standalone_vlan_filtering, dsa_port_bridge_leave() calls
> dsa_port_reset_vlan_filtering(). When the bridge being left was
> VLAN-unaware, that function forces vlan_filtering=3Dtrue.
>=20
> The call ends up in soce_port_vlan_filtering(), which calls
> soce_vlan_config_port(). That switches the port to
> SOCE_VLAN_PORT_TYPE_C_PORT with SOCE_VLAN_PORT_INGR_FILTER_EN set.
>=20
> Nothing in the driver gives a standalone port a VLAN to be classified
> into. soce_vlan_setup() sets port_pvid[] to 1. It never adds the port
> to vlan_members[1], and it never programs the VID 1 member entry.
>=20
> By the time the port is standalone again, the bridge has also flushed
> its own VLANs through soce_port_vlan_del(). One of two things then
> happens:
>=20
>   - port_pvid[] is still 1. Untagged frames are classified into
>     VID 1, and the ingress filter drops them because the port is not
>     a member.
>   - VID 1 was deleted as the PVID, so port_pvid[] is 0.
>     SOCE_VLAN_PORT_INGR_ACCEPT_TAGGED_ONLY then drops untagged frames
>     at ingress.
>=20
> In both cases untagged standalone traffic on that port stops after a
> bridge join/leave cycle. This contradicts the comment in
> soce_vlan_setup(), which says standalone forwarding keeps working.
>=20
> hellcreek, the other user of this flag, programs a private per-port
> VLAN so that standalone ports stay reachable with filtering enabled.
> Is something similar planned here?
>=20
> Alternatively, would it be simpler not to set the flag at all? Cores
> without Port VLAN could then reject VLAN uppers from
> .port_prechangeupper instead.
>=20
> This is latent at this revision. Without .port_bridge_join, the join
> is rolled back and dp->bridge stays NULL. dsa_port_bridge_leave()
> then returns early. The problem becomes reachable as soon as bridge
> offload is added.
>=20
> [Severity: High]
> This flag is set even when priv->features.port_vlan is false. Does that
> break plain bridge membership on cores without Port VLAN?
>=20
> With the flag set, dsa_user_setup_tagger() advertises
> NETIF_F_HW_VLAN_CTAG_FILTER on every user netdev.
>=20
> The failure needs CONFIG_VLAN_8021Q and CONFIG_BRIDGE_VLAN_FILTERING and
> the default vlan_default_pvid=3D1. It happens whatever the bridge's
> vlan_filtering setting is:
>=20
> ip link set lanX master br0
>   br_add_if()
>     nbp_vlan_init()
>       nbp_vlan_add(vid 1, PVID | UNTAGGED)
>         __vlan_add()
>           __vlan_vid_add()
>             switchdev returns -EOPNOTSUPP (!dp->bridge)
>             vlan_vid_add(dev, 8021Q, 1)
>               dsa_user_vlan_rx_add_vid()
>                 dsa_port_vlan_add()
>                   soce_port_vlan_add()
>                     returns -EOPNOTSUPP (!features.port_vlan)
>=20
> nbp_vlan_init() then fails, and br_add_if() aborts the enslave:
>=20
>     err =3D nbp_vlan_init(p, extack);
>     if (err) {
>         netdev_err(dev, "failed to initialize vlan filtering on this port=
\n");
>         goto err6;
>     }
>=20
> Software bridging on these cores worked with the previous patch in the
> series.
>=20
> Neither the commit message ("reject VLAN operations") nor the probe
> comment says that bridge membership is now refused. The refusal is also
> inconsistent: a bridge created with vlan_default_pvid 0 still works, and
> standalone ports see the same VLAN-stripping behaviour.
>=20
> Is this refusal intended for cores without Port VLAN?

I see that misusing needs_standalone_vlan_filtering to reject VLAN
configuration wasn't a good idea...
I will fix both findings. Next version will set this flag only when Port
VLAN support is available and use port_prechangeupper to reject direct
VLAN uppers otherwise.

>=20
> > +
> >  	ret =3D devm_of_platform_populate(dev);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret,
>=20
> [ ... ]
>=20

