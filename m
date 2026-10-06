Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93987439F9C;
	Tue,  6 Oct 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291180; cv=none; b=f3BC5vydu5LJIGpMHD2OLd1jJV4nYClNfQb/7PFgrThe0WXeMozdsYj1dVd5MSixExoh4p3rzzugEZbE+HoZxvcCAowCgSAdWRfL6dC3tJrlmGG1uatAWPtW368cINDRrInQfHNt9QLcOyvnvNgSlYHtiOiCpkjs/S7fbmQwiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291180; c=relaxed/simple;
	bh=QmTIxIQL8o4BcQSdRnhk0bo/WvdU0ljdDcoztFJr4Hs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxxoggujmGMwx18d0i66FjnGNeU8q11t8XInIYInXbN1+NeSrIYxYNko3FoS7tk4O+VrRN9EQh1v/nl1vEhnlvEvPQDd5+6HNn9cjCg1P2wKMdL3pbA7zH27X26xAyK86wcG3bLwo48330blajMFU5IOGNP82PfpwAZsB+SQLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/w3iaaa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCwMD8rC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/w3iaaa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCwMD8rC"
Message-ID: <36ab80c8501f7327351095c02e19362f30cd91cd.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791291167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XMENZB12qYAD3YmRq0Nu0A4LMi8A5xnfJKWoKWqOIQ=;
	b=w/w3iaaaEeG6IhsHb1ItbvzqqNABlL0Zcf5kc2pLDcG60BGj/nn7lAbDC9NyzSFUmVlqlO
	aajXSAyWJQW9Wls7yDve68V9UJdAxJ0DBSxrcWlUn/3V6Fvxbst+rtVs64532/MFKy/0Ej
	Elqn8vJQ2UOkP2xar8ecwDgkQhuBG23K101zNkxuQed9xzucJiU4UEcHJWgrwXyM9JbwqA
	AES7AlQqyqumNsnH1y2354gEKmUoslMOAw90B0J4cIfoc64eNeizckc3EnXNnJSu9Gjg9U
	oZ3pgQwd89U6n68bUJMS9vDd4ViyGDbL1mBTVGpIEb0I2mhS1aCYghoL20t5zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791291167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XMENZB12qYAD3YmRq0Nu0A4LMi8A5xnfJKWoKWqOIQ=;
	b=wCwMD8rCTCCCd4F2Qm/UC1C5XZlciScUdtJrSYsQygTv3N7XYW5lN7e77G12W/AHpIb+U5
	qM7zgG9LfnC91uAQ==
Subject: Re: [PATCH net-next v3 7/8] net: dsa: soce: Add VLAN offload support
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>, Benedikt Spranger <b.spranger@linutronix.de>
Date: Tue, 06 Oct 2026 14:52:47 +0200
In-Reply-To: <20260924104005.597041F00898@smtp.kernel.org>
References: 
	<20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
	 <20260923-devel-vstrassheim-soce-dsa-ml-v3-7-ddebafcb9ba7@linutronix.de>
	 <20260924104005.597041F00898@smtp.kernel.org>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 10:40 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] net: dsa: soce: needs_standalone_vlan_filtering drops standalone=
 traffic after bridge leave
> - [High] net: dsa: soce: VLAN isolation bypass due to missing hardware ro=
llback on write failure
> - [Medium] net: dsa: soce: -EOPNOTSUPP fails to reject unsupported VLAN c=
onfigurations
> --
>=20
> commit b9f4e8ae119f137ae188040da4ddc3fbc9794221
> Author: Vasilij Strassheim <v.strassheim@linutronix.de>
>=20
> net: dsa: soce: Add VLAN offload support
>    =20
> Add VLAN filtering and membership offload for switch configurations that
> implement the Port VLAN synthesis option.
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
> [ ... ]
>=20
> > +static int soce_vlan_setup(struct dsa_switch *ds)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +	struct soce_dsa_local *local;
> > +	struct dsa_port *dp;
> > +	int ret;
> > +
> > +	local =3D &priv->local;
> > +
> > +	if (!priv->features.port_vlan)
> > +		return 0;
> > +
> > +	ret =3D soce_vlan_reset(local);
> > +	if (ret) {
> > +		dev_err(ds->dev, "failed to reset VLAN configuration: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
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
> > +
> > +	return 0;
> > +}
>=20
> [ ... ]
>=20
> > @@ -224,6 +443,130 @@ static enum dsa_tag_protocol soce_get_tag_protoco=
l(struct dsa_switch *ds,
>=20
> [ ... ]
>=20
> > +static int soce_port_vlan_add(struct dsa_switch *ds, int port,
> > +			      const struct switchdev_obj_port_vlan *vlan,
> > +			      struct netlink_ext_ack *extack)
> > +{
> > +	struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +	struct soce_priv *priv =3D ds->priv;
> > +	u32 port_mask =3D BIT(port);
> > +	u32 *untagged_ports;
> > +	u32 old_untagged;
> > +	u32 old_members;
> > +	bool untagged;
> > +	u32 *members;
> > +	int ret;
> > +
> > +	untagged_ports =3D priv->vlan_untagged;
> > +	members =3D priv->vlan_members;
> > +
> > +	if (!priv->features.port_vlan) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Port VLAN support is not implemented in the switch core");
> > +		return -EOPNOTSUPP;
> > +	}
>=20
> [Severity: Medium]
> Since -EOPNOTSUPP is explicitly masked by the switchdev and DSA cores, wi=
ll
> this return value be ignored instead of rejecting the configuration? It
> looks like this would allow the operation to succeed in the network stack=
,
> causing hardware to silently strip VLAN tags on CPU ingress without
> including them in the DSA tag, which could break the network configuratio=
n.
>=20

The error is propagated through dsa_port_vlan_add(). In my tests VLAN
upper configuration was rejected in this path. Anyway, I will use
-EINVAL instead to avoid exceptions.

> > +
> > +	if (!vlan->vid)
> > +		return 0;
> > +
> > +	untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> > +
> > +	scoped_guard(mutex, &priv->vlan_lock) {
> > +		old_members =3D members[vlan->vid];
> > +		old_untagged =3D untagged_ports[vlan->vid];
> > +
> > +		members[vlan->vid] |=3D port_mask;
> > +		if (untagged)
> > +			untagged_ports[vlan->vid] |=3D port_mask;
> > +		else
> > +			untagged_ports[vlan->vid] &=3D ~port_mask;
> > +
> > +		ret =3D soce_vlan_write_entry(priv, vlan->vid);
> > +		if (ret) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "failed to update VLAN hardware tables");
> > +			dev_err(ds->dev,
> > +				"failed to add VLAN %u on port %d: %d\n",
> > +				vlan->vid, port, ret);
> > +			members[vlan->vid] =3D old_members;
> > +			untagged_ports[vlan->vid] =3D old_untagged;
> > +			return ret;
> > +		}
>=20
> [Severity: High]
> If the second write for the untagged mask in soce_vlan_write_entry() fail=
s
> and returns an error, the first write for the member mask has already bee=
n
> committed to the hardware.=20
>=20
> Is it safe to only rollback the software state here? By leaving the hardw=
are
> member mask modified, the switch might forward frames for this VLAN to th=
e
> port, leading to a VLAN isolation bypass while the OS believes the port i=
s
> isolated.
>=20

Yes, this might become a problem.
I will fix this with best-effort rollback to the previous configuration
(like mxl862xx), and also check that both table commands have completed
before modifying the selector or data registers.

> [ ... ]
>=20
> > +static int soce_port_vlan_filtering(struct dsa_switch *ds, int port,
> > +				    bool vlan_filtering,
> > +				    struct netlink_ext_ack *extack)
> > +{
> > +	struct soce_priv *priv =3D ds->priv;
> > +
> > +	if (!priv->features.port_vlan) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Port VLAN support is not implemented in the switch core");
> > +		return -EOPNOTSUPP;
> > +	}
>=20
> [Severity: Medium]
> Similarly to soce_port_vlan_add(), will returning -EOPNOTSUPP here fail t=
o
> reject unsupported VLAN configurations since it gets masked by the DSA co=
re?

Same as above, I will change it to -EINVAL.

>=20
> [ ... ]
>=20
> > @@ -278,8 +623,35 @@ static int soce_sw_probe(struct platform_device *p=
dev)
>=20
> [ ... ]
>=20
> > +	/* Force VLAN uppers always through the callbacks, so cores without
> > +	 * Port VLAN feature can reject them instead of silently dropping
> > +	 * VLAN frames.
> > +	 */
> > +	ds->needs_standalone_vlan_filtering =3D true;
>=20
> [Severity: High]
> Does enabling needs_standalone_vlan_filtering cause complete loss of stan=
dalone
> network traffic when a port leaves a bridge?
>=20
> When a port is removed from a VLAN-unaware bridge, the DSA core will call
> dsa_port_vlan_filtering(dp, true), forcing the hardware into ingress filt=
ering
> mode.
>=20
> Since the bridge flushes VLANs on leave, the port is removed from the har=
dware
> member mask for VLAN 1. However, earlier in soce_vlan_setup(), the driver
> assigns PVID 1 but never adds the port to the hardware member mask for VL=
AN 1.
> Will all subsequent untagged standalone traffic be classified to PVID 1 a=
nd
> dropped by the ingress filter because the port is no longer a member?
>=20

Yes, I will fix this by preserving standalone VLAN membership and
restoring the default PVID when the port leaves the bridge.


