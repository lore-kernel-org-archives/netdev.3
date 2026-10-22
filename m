Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670758;
	b=ufqswgQ/lBcM4Ek7Hkagm3BTQRoWcbo08mXz4A92IbrrYSfWzmJTWnW1s0GjTbJgmVcc
	 i+xglFuCvgK/Wj/1vffCEVG0qKGGH0K0jpXKsAfOdiARgswRGboxwgfZIfKMBtNjre44a
	 9NRZgjLQCKiqfA5THCvnZ9+QhPiAaSVGigUdOBmSlhghXGKQEwEonC6huYSvENdmgRQaW
	 +hJTJkKuiseaorupmZBfwEb3NTGYrwtc/Wev0gA+XVqkUF0m7kTjeE0jT0crMJK15ler1
	 tKOS5k/McMf5TBLAZD5Fa8Ip0afXQ+wmtcpQQ8PevXhZ5BS75bjf4Ee2kJ2XHC3wZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670758;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=I++CL3RxxLgcwqlcF9ZY5uFcuapsgEK8oi6a+41Y9E8=;
	b=03mJoZ2zoe2XqaDzOPaZayMrrv+12Nvi+Y75EckTXQRfBIEaWnEl9jmqFsVK+ESqNBjp
	 dHy1ggPrFC+8Uk9nk1vm5P3kxXBqdheRe5SnSopxjb3AYzaG3P3X9SPpIOcPxLRvExEXj
	 SdPhgc3lYBEdNe3ymi9i3YVmmgaDWCQ4lTOnnwyPSInLdyrihcRc9RX2W80kHbKzLEMFk
	 YpCKQGrNQG+uYD06g0/RtG9gF/12fOUhJDFBMnZWZnnBkqOgrLeh3NNtZNRi5j3upKH+u
	 5bQBSCL0FygXL1GutOh5oWZxtb2gSuNPTrMZ5uMhFJIHSAvK2lg8y7GX0R9pkjTz2+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kt2Vp1Hg;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DF606A31A;
	Thu, 22 Oct 2026 12:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC7DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kt2Vp1Hg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792670757; x=1824206757;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eDaJaFkNG57FPatQjaYQYdp1k3DFMvukvzB0taCDBnM=;
  b=kt2Vp1Hgek8JNlKGh4xoYwhMc67VgvVOOJSqsEaqzJUJcpQXDMwhWSwb
   +G1Pq8vI09dK9YxK1OgDA/gz8PO+SD301iGm+1Ol4x2RxzyZBNOQPP9Wq
   f+hydWGUNxFuowmnhAfvpsuAO0waG3YG/j5UO0R5jxjTaG1R2r1FXD+74
   nHS2Iz0cTEnvFHwoV5PsJLU3uwX9n1auThdR5Nhfd3fPaoJggsXOgYRre
   yo2SqhWktwu1eB2Fp2aq+P0iEik0HSnDPJMaExtZ5sTgOqPdn6dEWUrRP
   Q5BDB7es/WsgQCnCQYrqhQFQyRw7Ul9LackEqWQWLnY2AjgIMN5gHDifH
   w==;
X-CSE-ConnectionGUID: eINMA0rRS96dVv8PjCNUVQ==
X-CSE-MsgGUID: ExzV9C1VTF6WiY15EM8zGQ==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="65412830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 05:05:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 22 Oct 2026 05:05:55 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 05:05:52 -0700
Message-ID: <5295678e4dc8a8d8d93080e580e7974dedaa7c57.camel@microchip.com>
Subject: Re: [PATCH net-next v15 7/9] net: dsa: lan9645x: add mdb management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Thu, 22 Oct 2026 14:05:51 +0200
In-Reply-To: <179240452954.3135.9522637981866659319@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-7-562f316f78b9@microchip.com>
	 <179240452954.3135.9522637981866659319@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The driver tracks only one membership bit per port per (MAC,
>   VID).
> - [Medium] When a mac table write fails, the code keeps an extra PGID
>   reference on purpose so the index cannot be reused while hardware=E2=80=
=A6
> - [Medium] The out-of-PGIDs in-place branch of __lan9645x_mdb_del()
>   rewrites only ANA_PGID(mdb_entry->pgid->index) and skips the mac table=
=E2=80=A6
> - [Low] The comment in lan9645x_setup() above the ANA_FLOODING_IPMC write
>   says IP multicast "Control frames are redirected to CPU, and the=E2=80=
=A6
> - [Low] Two PGID destination-mask writes in the new mdb code never report
>   failure.
>=20
> --
>=20
> net: dsa: lan9645x: add mdb management
>=20
> This adds the DSA port_mdb_add/port_mdb_del callbacks for lan9645x. IP
> multicast groups carry their port mask inline in the mac table entry. L2
> multicast groups point at a refcounted PGID whose destination mask holds
> the port group, and the MAC_CPU_COPY bit carries CPU membership. The patc=
h
> also redirects IGMP/MLD frames to the CPU and copies IPv4 multicast
> control frames to it.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 058e47e58b9a8..d2e8c52e2a178 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -253,6 +255,17 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >                       lan9645x, ANA_CPUQ_8021_CFG(i));
> >       }
> >=20
> > +     /* Use CPU queues to communicate frame classification to the CPU =
*/
> > +     lan_rmw(ANA_CPUQ_CFG_CPUQ_MAC_COPY_SET(LAN9645X_CPUQ_DEF) |
> > +             ANA_CPUQ_CFG_CPUQ_IGMP_SET(LAN9645X_CPUQ_TRAP) |
> > +             ANA_CPUQ_CFG_CPUQ_MLD_SET(LAN9645X_CPUQ_TRAP) |
> > +             ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_SET(LAN9645X_CPUQ_COPY),
> > +             ANA_CPUQ_CFG_CPUQ_MAC_COPY |
> > +             ANA_CPUQ_CFG_CPUQ_IGMP |
> > +             ANA_CPUQ_CFG_CPUQ_MLD |
> > +             ANA_CPUQ_CFG_CPUQ_IPMC_CTRL,
> > +             lan9645x, ANA_CPUQ_CFG);
>=20
> [Severity: Low]
> This isn't a bug, but does the comment above the ANA_FLOODING_IPMC write
> earlier in lan9645x_setup() still match what this patch configures?
>=20
>         /* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and data=
plane
>          * use the same masks. Control frames are redirected to CPU, and
>          * the network stack is responsible for forwarding these.
>          * The dataplane is forwarding according to the offloaded MDB ent=
ries.
>          */
>=20
> Only IGMP and MLD are redirected, through IGMP_REDIR_ENA/MLD_REDIR_ENA
> and LAN9645X_CPUQ_TRAP. Other IPv4 multicast control frames are only
> copied, through IPMC_CTRL_COPY_ENA and LAN9645X_CPUQ_COPY. The hardware
> still floods them through MC4_CTRL =3D PGID_MC.
>=20
> lan9645x_offload_fwd_mark() in net/dsa/tag_lan9645x.c only clears the
> mark for TRAP frames:
>=20
>         if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
>                 skb->offload_fwd_mark =3D 0;
>                 return;
>         }
>=20
>         dsa_default_offload_fwd_mark(skb);
>=20
> So copied frames keep offload_fwd_mark set on bridged ports, and the
> software bridge does not forward them. IPv6 control frames other than MLD
> are neither redirected nor copied.
>=20
> An earlier patch added the comment, but this patch implements the
> behaviour it describes, and the comment is still unchanged at the end of
> the series. Could it describe the redirect/copy split instead?
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > new file mode 100644
> > index 0000000000000..ca333d43904fd
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > @@ -0,0 +1,582 @@
>=20
> [ ... ]
>=20
> > +static struct lan9645x_pgid_entry *
> > +lan9645x_pgid_entry_alloc(struct lan9645x *lan9645x, int index, u16 po=
rts)
> > +{
>=20
> [ ... ]
>=20
> > +     lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
> > +             ANA_PGID_PGID, lan9645x,
> > +             ANA_PGID(pgid_entry->index));
> > +
> > +     return pgid_entry;
> > +}
>=20
> [Severity: Low]
> What happens if this write fails while an index is being reused?
> lan_rmw() returns void and only does WARN_ON_ONCE() when
> regmap_update_bits() fails.
>=20
> lan9645x_pgid_entry_put() deliberately leaves the old mask in hardware an=
d
> depends on this rewrite:
>=20
>         /* Leave the destination mask programmed in HW. Reusing the index
>          * rewrites the mask in lan9645x_pgid_entry_alloc() before anythi=
ng
>          * points at it.
>          */
>=20
> If the rewrite fails, the next CMD_LEARN points the group at an index
> that still holds the previous group's port mask. Later lookups by the
> software ports value would then share that wrongly programmed PGID.
>=20
> The in-place branch of __lan9645x_mdb_del() has the same problem. It
> updates mdb_entry->pgid->ports and mdb_entry->ports, does an unchecked
> lan_rmw() of ANA_PGID, and returns 0. If that write fails, the departed
> port stays in the hardware mask, and the bridge never retries the delete.
>=20
> This follows the WARN_ON_ONCE convention of lan_wr()/lan_rmw() across the
> driver. The mdb code does treat register bus failures as real elsewhere,
> though: the PGID retention and the CMD_FORGET cleanup. Should these two
> writes report errors as well?
>=20
> [ ... ]
>=20
> > +static int lan9645x_mdb_widen_dest(struct lan9645x *lan9645x,
> > +                                struct lan9645x_mdb_entry *mdb_entry,
> > +                                enum macaccess_entry_type type,
> > +                                struct lan9645x_pgid_entry *new_pgid,
> > +                                int pgid_index, u16 new_ports)
> > +{
> > +     struct lan9645x_pgid_entry *old_pgid =3D mdb_entry->pgid;
> > +     int err;
> > +
> > +     lockdep_assert_held(&lan9645x->mdb_lock);
> > +
> > +     err =3D lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_i=
ndex,
> > +                                   new_ports);
> > +     if (err) {
> > +             dev_err(lan9645x->dev,
> > +                     "Widening %pM vid %u to mask 0x%x returned %pe\n"=
,
> > +                     mdb_entry->mac, mdb_entry->vid, new_ports,
> > +                     ERR_PTR(err));
> > +             /* A failed write leaves the hardware state unknown, the =
mac
> > +              * entry may point at old_pgid or new_pgid. Keep the refe=
rence
> > +              * taken on new_pgid, so its index cannot be handed to an
> > +              * unrelated group. If the entry already holds new_pgid, =
e.g.
> > +              * when the CPU port module joins, drop the extra referen=
ce.
> > +              */
> > +             if (new_pgid =3D=3D old_pgid)
> > +                     lan9645x_pgid_entry_put(lan9645x, new_pgid);
> > +             return err;
> > +     }
>=20
> [Severity: Medium]
> When new_pgid !=3D old_pgid, the reference from
> lan9645x_mdb_pgid_entry_get() is kept, but mdb_entry->pgid still points
> at old_pgid. What drops that reference later?
>=20
> Nothing records it, so refcount_dec_and_test() in
> lan9645x_pgid_entry_put() can never reach zero for it. If a later add
> with the same mask succeeds, lan9645x_mdb_pgid_entry_lookup() adopts the
> orphan with refcount_inc(), and the extra count becomes permanent.
>=20
> The same pattern appears in three other places.
>=20
> lan9645x_mdb_narrow_dest() returns without putting old_pgid, after it has
> already replaced mdb_entry->pgid:
>=20
>                 if (old_pgid !=3D new_pgid)
>                         return;
>=20
> __lan9645x_mdb_add() skips the put when the cleanup CMD_FORGET also
> fails, then frees the entry:
>=20
>                 if (!lan9645x_mact_forget(lan9645x, mdb_entry->mac,
>                                           mdb_entry->vid, type))
>                         lan9645x_pgid_entry_put(lan9645x, new_pgid);
>                 lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
>=20
> __lan9645x_mdb_del() clears the only pointer to the PGID before dealloc
> when CMD_FORGET fails for the last port:
>=20
>                         mdb_entry->pgid =3D NULL;
>=20
> In each case the pgid entry stays on pgid_entries and blocks its index in
> lan9645x_mdb_pgid_entry_create() until lan9645x_mdb_deinit(). That holds
> even after a later successful CMD_LEARN or CMD_FORGET for that (mac, vid)
> shows that hardware no longer uses the index.
>=20
> Can repeated mac table errors use up the PGID_GP_START..PGID_GP_END range
> this way? New L2 groups would then fail with -ENOSPC or fall back to
> flooding. This code is unchanged at the end of the series.
>=20

Dismissed, intended.

As discussed for v14, these references are kept on purpose. After a
failed MAC table command the hardware entry may still point at the
PGID, so its index stays reserved until the driver is unbound. It
costs one of the 48 general purpose PGIDs per failure. When the pool
runs out, a new group gets -ENOSPC and is not offloaded, and a group
already on the flood mask stays on PGID_MC, so nothing is forwarded to
the wrong ports.

A later group with the same port mask may share the PGID, which is
fine since the mask is the same. The extra reference also keeps the
refcount above one, so the PGID is never rewritten in place while an
unknown hardware entry may use it.

Releasing it after a later successful command would need per entry
state for the stale PGID, and would not cover the delete and failed
add paths, where the entry is freed and no additional command for it
arrives after that point.




> [ ... ]
>=20
> > +static int __lan9645x_mdb_add(struct lan9645x *lan9645x, int chip_port=
,
> > +                           const unsigned char addr[ETH_ALEN], u16 vid=
,
> > +                           enum macaccess_entry_type type)
> > +{
>=20
> [ ... ]
>=20
> > +     if (mdb_entry->ports & BIT(chip_port))
> > +             return 0;
>=20
> [Severity: Medium]
> Can a port lose membership here when two IP groups map to the same MAC?
>=20
> br_switchdev_mdb_populate() turns IP groups into MACs with
> ip_eth_mc_map()/ipv6_eth_mc_map(). For example, 239.1.1.1 and
> 239.129.1.1 both become 01:00:5e:01:01:01. For user ports,
> dsa_port_do_mdb_add()/dsa_port_do_mdb_del() pass every notification
> straight to the driver, with no refcounting.
>=20
> If port P joins both groups on the same VID, the second add returns here
> and nothing records it. A later delete of either group then runs this in
> __lan9645x_mdb_del():
>=20
>         new_ports =3D mdb_entry->ports & ~BIT(chip_port);
>=20
> That removes P. If another port Q is still a member, the MACV4/MACV6
> entry is rewritten with only Q, and P stops receiving a group it still
> belongs to. offload_fwd_mark is set, so the software bridge does not
> forward these frames either.
>=20
> At this commit the path cannot be reached: there is no bridge offload
> yet, and DSA refcounts CPU-port host entries. It becomes reachable with
> "net: dsa: lan9645x: add bridge support", and lan9645x_mdb.c is unchanged
> at the end of the series. mscc/ocelot has the same limitation.
>=20
> Should the entry keep a per-port count instead of a single bit?
>=20

Dismissed, preexisting.

This is the same limitation as in ocelot/felix, mv88e6xxx, lan966x and
sparx5, which also keep one bit per port, and it can only be fixed in
the bridge core. A per port count is not correct either. The bridge
sends SWITCHDEV_OBJ_ID_PORT_MDB adds for port groups that already exist
without a matching delete, e.g. on mdb replace, on IGMPv3/MLDv2 source
list changes:

  bridge mdb add dev br0 port swp1 grp 01:02:03:04:05:06 permanent vid 10
  bridge mdb replace dev br0 port swp1 grp 01:02:03:04:05:06 permanent vid =
10
  bridge mdb del dev br0 port swp1 grp 01:02:03:04:05:06 vid 10

reaches the driver as add, add, del. Counting adds would leave the port
in the group after the bridge removed it. Since switchdev_obj_port_mdb
only carries (MAC, VID), the driver cannot tell an aliasing group from
a renotification.


> [ ... ]
>=20
> > +static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port=
,
> > +                           const unsigned char addr[ETH_ALEN], u16 vid=
,
> > +                           enum macaccess_entry_type type)
> > +{
>=20
> [ ... ]
>=20
> > +      * PGID this entry already points at. So the departing port is a =
front
> > +      * port, and the mac table entry, which only carries the PGID ind=
ex and
> > +      * MAC_CPU_COPY, does not need rewriting.
> > +      *
> > +      * refcount_read is safe because mdb_lock serializes every get an=
d put
> > +      * of a PGID entry.
> > +      */
> > +     if (mdb_entry->pgid && refcount_read(&mdb_entry->pgid->refcount) =
=3D=3D 1) {
> > +             mdb_entry->pgid->ports =3D new_ports &
> > +                                      ~BIT(lan9645x->num_phys_ports);
> > +             mdb_entry->ports =3D new_ports;
> > +
> > +             lan_rmw(ANA_PGID_PGID_SET(mdb_entry->pgid->ports),
> > +                     ANA_PGID_PGID,
> > +                     lan9645x, ANA_PGID(mdb_entry->pgid->index));
> > +
> > +             return 0;
> > +     }
>=20
> [Severity: Medium]
> This branch rewrites only ANA_PGID(mdb_entry->pgid->index). It assumes
> that the hardware DEST_IDX matches mdb_entry->pgid. Does that still hold
> after a failed widen? The comment in lan9645x_mdb_widen_dest() says it
> might not:
>=20
>                 /* A failed write leaves the hardware state unknown, the =
mac
>                  * entry may point at old_pgid or new_pgid. Keep the refe=
rence
>                  * taken on new_pgid, ...
>=20
> Consider this sequence:
>=20
> 1. A widen fails after the CMD_LEARN has reached the analyzer. Hardware
>    now uses new_pgid (the old ports plus the joining port), while
>    software keeps old_pgid.
>=20
> 2. A front port leaves while the PGID pool is exhausted, and old_pgid has
>    refcount 1. Exhaustion is more likely here because the reference kept
>    on new_pgid holds a slot.
>=20
> 3. This branch narrows only old_pgid's mask.
>=20
> Hardware still forwards through new_pgid's mask, while this function
> returns 0. So the departed port and the port whose join was refused both
> keep receiving the group.
>=20
> lan9645x_mdb_narrow_dest() would recover by reissuing CMD_LEARN with a
> known index, but this path never does. Should this branch rewrite the mac
> table entry as well?

Dismissed, intended.

This needs a MAC table command to fail, and after that the driver does
not know which PGID the hardware entry uses. The failed widen is
reported to the bridge, which refuses the join, and the driver does not
try to resolve the hardware state at runtime, the same as for the other
MAC table failure paths. The next widen or narrow through
lan9645x_mdb_write_dest() rewrites the entry with a known index.


>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

