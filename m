Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216093B71A7;
	Tue,  6 Oct 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289894; cv=none; b=UkKaD3Vm3RRH8H4Cdo/rTR6DnOr//Ah702IcNOu3YVKzp34xuDIFhpR6ybF2ccewdNT0UoQBTwoKiMUsRD3Jh1odws0veE67eNOI3FOO7CH2O+Gqe2cW2NY/mQD6/HEz1G1RFkHFHSMBBaci3uNTGTJESSHl0DF6hBGPHWkmfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289894; c=relaxed/simple;
	bh=jTJv4LN6YeQb4G6P58S4hw/dap7MGFciSdG861ysXr4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcKwbq03/9lonMe89wJ+I4Cq3qLO0ZTeaUcxuUhq5XGEB8ju6XpamhN59rYPOg1Z4qcayGKWYxNnPqJUpfk6lEkWIDmILxZ1tPamKwgy20iu6DjNrT8BEwCLYojKlJcZ6c6/aYyD7oEzUfBzLsFE0V0At/Z09psEFME+PEn+Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ze5Sw48d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ze5Sw48d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791289893; x=1822825893;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jTJv4LN6YeQb4G6P58S4hw/dap7MGFciSdG861ysXr4=;
  b=ze5Sw48dcuVObN8Bq81R35CyswYbkrslCv5YM4mblRUf5K8DFg0kTkRO
   Ev3cA9SnoOcqog++kEcUfEmuuwkob/CNbfFRvcbR8Ek8SAvf5rXqhkI5i
   0i9A7/c/nF9M7DAFl1pVpMwBuy40Y92Aq3jgWkBVh3hr4d5l6Lay8ERpe
   P40OCkRWnfE8Ry8zA0ndVKAGZc3IUpr2gHvq0IKvexOKXpsfo3ey7lmiP
   bUs6EBcYMm26DwqfjZIEHRHSgmiwodGbUVIEurynzL3uDjpJ8ZTkxeqKY
   NkH/KevwzUuzQtm+cQpNDxuGUq6opDh+hQcwQjhqXA10tEcad3BeDg/jc
   g==;
X-CSE-ConnectionGUID: z6W3zX7rStW6KFyEWPS2YQ==
X-CSE-MsgGUID: 16TG9y/xRwWZdFV6pCxZJg==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="74909272"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 05:31:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 6 Oct 2026 05:31:25 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 05:31:21 -0700
Message-ID: <72ceab96dccc7d09a19d773ab0eda05df4382d52.camel@microchip.com>
Subject: Re: [PATCH net-next v13 5/9] net: dsa: lan9645x: add vlan support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <woojung.huh@microchip.com>,
	<linux@armlinux.org.uk>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <geert+renesas@glider.be>,
	<magnus.damm@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Tue, 6 Oct 2026 14:31:21 +0200
In-Reply-To: <179097565993.434549.16648659214046712507@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-5-827c2d3617f2@microchip.com>
	 <179097565993.434549.16648659214046712507@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-02 at 21:14 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] On a VLAN-aware bridged port, frames the host sends without a
>   tag can leave the switch tagged, sometimes with the wrong VID.
> - [Medium] On VLAN-aware ports, lan9645x_vlan_port_apply_ingress() sets
>   ANA_VLAN_CFG_VLAN_POP_CNT=3D1, so the hardware removes the outer VLAN=
=E2=80=A6
> - [Low] The commit message says the patch adds "VLAN support for VLAN-
>   aware and VLAN-unaware bridges", but none of the bridged code paths=E2=
=80=A6
> - [Low] Errors from VLAN table programming are not passed back to
>   callers.
>=20
> --
>=20
> net: dsa: lan9645x: add vlan support
>=20
> This commit adds VLAN table management to the lan9645x DSA driver. It
> configures ports for VLAN-aware and VLAN-unaware bridges, and reserves
> HOST_PVID (4095) for standalone ports. It also registers the
> port_vlan_filtering, port_vlan_add and port_vlan_del ops, all serialized
> by a new fwd_domain_lock.
>=20
> > Add VLAN support for VLAN-aware and VLAN-unaware bridges.
>=20
> [Severity: Low]
> Does this description match what the commit does on its own?
>=20
> At this point in the series nothing writes lan9645x->bridge_mask, and
> lan9645x_switch_ops has no .port_bridge_join. That means
> lan9645x_port_is_bridged() always returns false:
>=20
> static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
> {
>         return p->lan9645x->bridge_mask & BIT(p->chip_port);
> }
>=20
> It also means DSA never offloads a bridge, so .port_vlan_filtering,
> .port_vlan_add and .port_vlan_del are never called for user ports. The
> only thing that takes effect here is the standalone HOST_PVID setup done
> from .port_setup.
>=20
> Bridge offload, and clearing HOST_PVID membership on bridge join, arrive
> with the later "net: dsa: lan9645x: add bridge support" patch. That
> ordering is only explained in the v12 changelog below the "---", and git
> am drops that part.
>=20
> Could the commit message say that the bridged paths only become
> reachable once the bridge support patch is applied?
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > new file mode 100644
> > index 0000000000000..6d28a7cf1442b
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > @@ -0,0 +1,402 @@
>=20
> [ ... ]
>=20
> > +static void
> > +lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
> > +                             struct lan9645x_vlan_port_info *info)
> > +{
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     enum lan9645x_vlan_port_tag tag_cfg;
> > +     u16 port_vid =3D UNAWARE_PVID;
> > +
> > +     if (!lan9645x_port_is_bridged(p)) {
> > +             tag_cfg =3D LAN9645X_TAG_NO_PVID_NO_UNAWARE;
> > +             port_vid =3D HOST_PVID;
> > +     } else if (p->vlan_aware) {
>=20
> [ ... ]
>=20
> > +             if (info->untagged =3D=3D 1 && info->tagged) {
> > +                     tag_cfg =3D LAN9645X_TAG_NO_PVID_NO_UNAWARE;
> > +                     port_vid =3D info->untagged_vid;
> > +             } else if (info->untagged) {
> > +                     tag_cfg =3D LAN9645X_TAG_DISABLED;
> > +             } else {
> > +                     tag_cfg =3D LAN9645X_TAG_ALL;
> > +             }
>=20
> [Severity: Medium]
> Can untagged frames from the host leave a VLAN-aware bridged port tagged,
> and with the wrong VID?
>=20
> For an untagged host frame on a VLAN-filtering bridge,
> lan9645x_xmit_get_vlan_info() in net/dsa/tag_lan9645x.c puts the bridge
> device's pvid into the IFH:
>=20
>         } else {
>                 rcu_read_lock();
>                 br_vlan_get_pvid_rcu(br, &tci);
>                 rcu_read_unlock();
>                 *vlan_tci =3D tci;
>         }
>=20
> The rewriter mode here, however, is chosen from the port's own untagged
> VID:
>=20
> - With one untagged VLAN X plus tagged VLANs, TAG_NO_PVID_NO_UNAWARE with
>   PORT_VID=3DX leaves only VID X or VID 0 untagged.
> - With no untagged VLANs, TAG_ALL tags every frame, including VID 0.
>=20
> The two sides only agree when br0's pvid equals the port's untagged VID.
> Two examples where they don't:
>=20
> (a) swp0 has "vid 10 pvid untagged" plus tagged vid 20, and br0 self
> pvid is 1. br_handle_vlan() strips host traffic on br0.10 for egress on
> swp0, and the same happens to VLAN 10 traffic forwarded in software from
> a foreign bridge port. The tagger then puts VID 1 in the IFH, so the
> frame goes out tagged with VID 1 instead of untagged in VLAN 10.
>=20
> (b) On a trunk port with no untagged VLANs, untagged frames go out tagged
> with br0's pvid. If br0 has no pvid, they go out priority-tagged with
> VID 0. STP BPDUs from br_send_bpdu() and LLDP sent on swp0 are examples.
>=20
> This depends on the rewriter using IFH.TCI as the classified VID when
> BYPASS=3D1, and on the TAG_CFG semantics described in the
> lan9645x_vlan_port_tag comment. I could not check either against the
> datasheet. ocelot and tag_ocelot use a similar pairing, so this may be a
> known limitation.
>=20
> The code becomes reachable once the bridge support patch lands, and it
> is unchanged at the end of the series. Also, LAN9645X_TAG_NO_UNAWARE is
> defined but never used.
>=20

Correct, this is the same issue as the one raised on the tag driver
patch, and the rewriter does use IFH.TCI as the classified VID with
BYPASS set. v14 fixes both sides: the tag driver no longer uses the
bridge pvid, and ports with only tagged VLANs use TAG_NO_UNAWARE instead
of TAG_ALL.


> > +     } else {
> > +             tag_cfg =3D LAN9645X_TAG_DISABLED;
> > +     }
>=20
> [ ... ]
>=20
> > +static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
> > +{
>=20
> [ ... ]
>=20
> > +     val =3D ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
> > +           ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);
> > +     if (p->vlan_aware)
> > +             val |=3D ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
> > +                    ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
>=20
> [Severity: Medium]
> Does popping the outer tag here conflict with the pvid check in
> lan9645x_rcv()?
>=20
> With VLAN_POP_CNT=3D1 on VLAN-aware ports, the classified VID survives
> only in the IFH. lan9645x_rcv() in net/dsa/tag_lan9645x.c skips
> restoring it when it equals the port pvid:
>=20
>                 if ((vlan_tci & VLAN_VID_MASK) !=3D port_pvid)
>                         __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
>                                                vlan_tci);
>=20
> That is fine for untagged frames. Consider a double-tagged frame
> [0x8100 VID 100][0x8100 VID 200] that arrives on a VLAN-aware port with
> pvid 100 and is sent to the CPU (broadcast, host flood or trap). The
> hardware classifies it to VID 100 and pops the outer tag. IFH TCI is
> 100, which equals the pvid, so no hwaccel tag is set.
>=20
> The software bridge then finds the inner tag 200 in the payload and puts
> the frame in VLAN 200, while the hardware forwarded it in VLAN 100.
>=20
> Could this cause local delivery (for example to br0.200), or software
> forwarding in a different VLAN than the hardware used?
> br_allowed_ingress() still restricts this to VIDs the port is a member
> of.
>=20

Correct, same issue as on the tag driver patch. v14 restores the classified=
 VID
as a hwaccel tag whenever a tag was popped, so in the example the
inner tag 200 stays in the payload and the bridge classifies the frame
to VLAN 100, as the hardware did. This also preserves the PCP of
priority tagged frames and of frames tagged with the pvid.

> [ ... ]
>=20
> > +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool=
 pvid,
> > +                             bool untagged, struct netlink_ext_ack *ex=
tack)
> > +{
>=20
> [ ... ]
>=20
> > +     lan9645x_vlan_hw_wr(lan9645x, vid);
> > +     lan9645x_vlan_port_apply_ingress(p);
> > +     lan9645x_vlan_port_apply_egress(p, &info);
> > +
> > +     return 0;
> > +}
>=20
> [Severity: Low]
> Should the return value of lan9645x_vlan_hw_wr() be checked here, before
> the software state is committed?
>=20
> This path updates lan9645x->vlans[] and p->pvid, reprograms the port
> ingress and egress configuration, and returns 0 even when the table
> write failed. lan9645x_vlan_port_del_vlan(), lan9645x_vlan_cpu_add(),
> lan9645x_vlan_cpu_del() and lan9645x_vlan_set_hostmode() do the same.
>=20
> Inside lan9645x_vlan_hw_wr(), the ANA_VLANTIDX, ANA_VLAN_PORT_MASK and
> ANA_VLANACCESS writes go through lan_wr(), which only does WARN_ON_ONCE()
> on a regmap error. The engine is also not checked for IDLE before a new
> command is issued.
>=20
> When this fails, the shadow table and the hardware can diverge while
> switchdev believes the change succeeded. For the CPU port, DSA caches the
> VID as installed, so later adds of the same VID only bump a refcount and
> never restore the missing membership.
>=20
> The comment in lan9645x_vlan_hw_wr() says a timeout most likely means
> the register bus is dead, which limits the practical impact. lan_wr()
> swallowing errors also predates this patch.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

