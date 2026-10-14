Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940454FC8CF;
	Wed, 14 Oct 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975762; cv=none; b=G69CEA2EFdNp35W3siq0U9UyHLXH8Otkt4GGp9Tp5jXgxZLMju6R8GSzA2Qt32ou+P+uFI+p84ALjaxRxBVVVo6vV1kFv0HmlEOskAGP+8nYY8t0PQnAph2ShwzB9pOS+bTWoXjrHW+OKkr2Iwty6AJH2wuJ/QGUguSVzSeN6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975762; c=relaxed/simple;
	bh=a/1d13j38qdjLmPhleRH3aLB+8CDo1Dg/dqgmEnNS34=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NeM264DF8sExjvUtU1WYT9lusAlhiJ/rYa6viqhnrr+W6A953CqIVLNd1LuxxEGeY/fEkj3lCCWOL2Ngi98ff8//4EtYqDZmjcN0ahpCVlICBTwrt5T8eRR9lPUZ/vS8O9d0yuu2u1X1GtAS7LaIgvWcwv3p1Rp1Jj4f9NbmhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lmcVufrV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lmcVufrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791975753; x=1823511753;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a/1d13j38qdjLmPhleRH3aLB+8CDo1Dg/dqgmEnNS34=;
  b=lmcVufrVsfgRuFJ8h8eHMK8n4sMT+5njFqIVszPFzC32XtTct3RJJ4uS
   6BwzEN8lrXOvWfNAeL1qGTlzlN2owDcIwRPzufkDzpqncXu4UejS1OJ/w
   jq/1PF3P2m2FHrAByL474gzWwUDUfC16cka/gFD49fCuJYmy1cx4B8jrT
   AIk79neG6lZI9QcqQ/KUjRjezJSfItXvT2c4bwai54sX23KOuOt2ad1/2
   m5q2NHb+Okc47YSAUQFPHh30wl/Ewku4fZuTgYLAcl2hgcMVpOZ1NRqOX
   /5THVj4rHi2uyhBaXNVDjvT8lGOA5nQGfrJ6bArykERYmnOUJ7cbjxJ7N
   w==;
X-CSE-ConnectionGUID: hD4QFTbfRO+6c9s0ftVqRA==
X-CSE-MsgGUID: udzJSR/hSDeCvB9yIewtCw==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="64078057"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:02:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 04:02:31 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 04:02:27 -0700
Message-ID: <882d83511caeb8555d94944d41148cdd69e8065d.camel@microchip.com>
Subject: Re: [PATCH net-next v14 7/9] net: dsa: lan9645x: add mdb management
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
Date: Wed, 14 Oct 2026 13:02:26 +0200
In-Reply-To: <179180428452.434549.6426245799435607203@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-7-3d2a72661213@microchip.com>
	 <179180428452.434549.6426245799435607203@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-12 at 11:24 +0000, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] Separate IP multicast groups that map to the same multicast
>   MAC collapse into one per-port bit, so leaving one group removes=E2=80=
=A6
> - [Medium] Several error paths deliberately keep a PGID reference, but
>   nothing owns it afterwards and it is only freed in=E2=80=A6
> - [Low] A comment in lan9645x_setup()
>   (drivers/net/dsa/microchip/lan9645x/lan9645x_main.c, lines 210-214,=E2=
=80=A6
> - [Low] PGID destination-mask writes in lan9645x_pgid_entry_alloc() and
>   in the overwrite-in-place branch of __lan9645x_mdb_del() go through=E2=
=80=A6
>=20
> --
>=20
> net: dsa: lan9645x: add mdb management
>=20
> This patch adds .port_mdb_add and .port_mdb_del support to the lan9645x D=
SA
> driver. IP multicast entries store the port mask inline in the mac table
> entry. L2 multicast entries point at a refcounted PGID, and CPU membershi=
p
> is carried by MAC_CPU_COPY. The patch also redirects IGMP and MLD to the
> CPU and copies IPv4 multicast control frames to it.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index c55161f8bafff..a0f48f3ad9aff 100644
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
> > +
>=20
> [Severity: Low]
>=20
> Is the comment above the ANA_FLOODING_IPMC write in lan9645x_setup() stil=
l
> accurate after this change?
>=20
> lan9645x_setup() {
>     ...
>         /* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and data=
plane
>          * use the same masks. Control frames are redirected to CPU, and
>          * the network stack is responsible for forwarding these.
>     ...
> }
>=20
> This patch copies IPv4 multicast control frames to the CPU instead of
> redirecting them. lan9645x_port_setup() sets
> ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA, and IPMC_CTRL is mapped to
> LAN9645X_CPUQ_COPY here.
>=20
> lan9645x_offload_fwd_mark() in net/dsa/tag_lan9645x.c only clears
> skb->offload_fwd_mark for LAN9645X_CPUQ_TRAP:
>=20
>         if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
>                 skb->offload_fwd_mark =3D 0;
>                 return;
>         }
>=20
> So the hardware forwards these copied frames through
> FLD_MC4_CTRL=3DPGID_MC, and the stack does not. Only IGMP and MLD are
> redirected.
>=20
> The commit message gets this right. Could the code comment be updated to
> match?
>=20
> >       /* Reserve 1664 bytes, 26 buffer cells, per (port, prio) for sour=
ce
> >        * tracking (resource 0, indices 0..95) and destination tracking
> >        * (resource 2, indices 512..607). These are access watermarks, n=
ot
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
> > +     dev_dbg(lan9645x->dev, "index=3D%d ports=3D0x%x\n", pgid_entry->i=
ndex,
> > +             pgid_entry->ports);
> > +
> > +     lan_rmw(ANA_PGID_PGID_SET(pgid_entry->ports),
> > +             ANA_PGID_PGID, lan9645x,
> > +             ANA_PGID(pgid_entry->index));
> > +
> > +     return pgid_entry;
> > +}
>=20
> [Severity: Low]
>=20
> lan9645x_pgid_entry_put() leaves the old destination mask in hardware on
> purpose and relies on this write to replace it when the index is reused.
> lan_rmw() only does WARN_ON_ONCE() when regmap_update_bits() fails, and
> lan9645x_pgid_entry_alloc() returns success either way.
>=20
> If this write is lost, would the new group forward to the previous group'=
s
> ports?
>=20
> The overwrite in place branch in __lan9645x_mdb_del() has the same shape.
> It updates mdb_entry->pgid->ports before an unchecked lan_rmw(), so the
> departing port would keep receiving traffic.
>=20
> This follows the lan_wr()/lan_rmw() convention used across the driver, an=
d
> in lan966x and ocelot too. It is also not clear that this regmap can fail
> at all. So this is more of a hardening question than a defect in the mdb
> logic.
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
>=20
> [ ... ]
>=20
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
> > +     mdb_entry->pgid =3D new_pgid;
> > +     mdb_entry->ports =3D new_ports;
> > +     lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +     return 0;
> > +}
>=20
> [Severity: Medium]
>=20
> If lan9645x_mdb_write_dest() fails and new_pgid !=3D old_pgid, the refere=
nce
> on new_pgid is kept but never stored in mdb_entry->pgid. What drops it
> later?
>=20
> Later successful updates only put mdb_entry->pgid, so this reference seem=
s
> to be released only in lan9645x_mdb_deinit().
>=20
> A few other error paths do the same.
>=20
> lan9645x_mdb_narrow_dest() switches mdb_entry->pgid to new_pgid before th=
e
> write. On failure it returns without putting old_pgid:
>=20
>                 if (old_pgid !=3D new_pgid)
>                         return;
>=20
> In __lan9645x_mdb_del(), when CMD_FORGET fails for the last port:
>=20
>                         mdb_entry->pgid =3D NULL;
>                 }
>                 lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
>=20
> In __lan9645x_mdb_add(), when both the learn and the cleanup forget fail
> for a fresh entry, the new_pgid reference is kept and the mdb entry is
> freed.
>=20
> Each transient ANA_MACACCESS poll timeout or regmap read error would then
> use up one index from the PGID_GP_START..PGID_GP_END pool for good. A
> shared PGID that holds an orphaned reference can also never get back to
> refcount 1, which disables the overwrite in place branch in
> __lan9645x_mdb_del().
>=20
> The v14 changelog explains why the reference is held while the hardware
> state is uncertain. Is there anything that releases it once a later
> successful CMD_LEARN or CMD_FORGET for the same (mac, vid) makes the stat=
e
> known again? Without that, could L2 multicast adds eventually fail with
> -ENOSPC?
>=20

Dismissed, intended.

Correct, and intended. These paths are only reached when a MAC table
command fails, i.e. a register bus error or a command that never
completes. The hardware may then still reference the PGID, and handing
its index to another group could forward that group to the wrong ports.
Keeping the index reserved until the driver is unbound is the safe
outcome, and it costs one of the 48 general purpose PGIDs per failure.
When the pool runs out, a new group gets -ENOSPC and is not offloaded,
and a group already on the flood mask stays on PGID_MC, so nothing is
forwarded incorrectly.


Releasing the reference after a later successful command would need
per entry state for a stale PGID, and would still not cover the delete
and fresh add paths, where the entry is freed and no later command for
it follows. As for the VLAN table, the driver does not attempt runtime
recovery after a register bus failure.



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
> > +     mdb_entry =3D lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> > +     if (!mdb_entry) {
> > +             mdb_entry =3D lan9645x_mdb_entry_alloc(lan9645x, addr, vi=
d);
> > +             if (IS_ERR(mdb_entry))
> > +                     return PTR_ERR(mdb_entry);
> > +     }
> > +
> > +     if (mdb_entry->ports & BIT(chip_port))
> > +             return 0;
>=20
> [Severity: Medium]
>=20
> What happens when two IP groups on the same port map to the same multicas=
t
> MAC?
>=20
> br_switchdev_mdb_populate() converts each group with ip_eth_mc_map() or
> ipv6_eth_mc_map(). For example, 239.1.1.1 and 239.129.1.1 both become
> 01:00:5e:01:01:01.
>=20
> For user ports, DSA passes the call straight to the driver without
> refcounting:
>=20
> net/dsa/switch.c:dsa_port_do_mdb_add() {
>     ...
>         /* No need to bother with refcounting for user ports */
>         if (!(dsa_port_is_cpu(dp) || dsa_port_is_dsa(dp))) {
>                 err =3D ds->ops->port_mdb_add(ds, port, mdb, db);
>     ...
> }
>=20
> The second join returns 0 here and nothing records it. When the first
> group leaves or expires, __lan9645x_mdb_del() runs:
>=20
>         new_ports =3D mdb_entry->ports & ~BIT(chip_port);
>=20
> It then either narrows the destination or forgets the entry. Does the por=
t
> then stop receiving traffic for the group it is still a member of?
>=20
> The bridge does not send another add while the remaining group keeps bein=
g
> refreshed. The loss would last until that group expires and is created
> again. With the bridge support patch later in the series, ordinary
> IGMP/MLD snooping looks like enough to trigger this.
>=20
> Does the mdb entry need a per-port membership count here?
>=20

Dismissed, preexisting.

This is an existing issue that can only be fixed in the bridge core.
The limitations is shared with ocelot/felix, mv88e6xxx, lan966x
and sparx5, which also keep one bit per port. A per port count is not
correct either. The bridge sends SWITCHDEV_OBJ_ID_PORT_MDB adds for port
groups that already exist without a matching delete, e.g. on mdb
replace, on IGMPv3/MLDv2 source list changes, on source timer expiry and
on (S, G) blocked flag changes:

  bridge mdb add dev br0 port swp1 grp 01:02:03:04:05:06 permanent vid 10
  bridge mdb replace dev br0 port swp1 grp 01:02:03:04:05:06 permanent vid =
10
  bridge mdb del dev br0 port swp1 grp 01:02:03:04:05:06 vid 10

reaches the driver as add, add, del. Counting adds would leave the port
in the group after the bridge removed it. Since switchdev_obj_port_mdb
only carries (MAC, VID), the driver cannot tell an aliasing group from a
re-notification, so neither scheme is right in the driver.


> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

