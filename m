Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A139EB47;
	Wed, 19 Aug 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145759; cv=none; b=JJ5kxhWumfu4Eg3JJRLG/cjc7uEcsnJK9roicWAbw09SXWHQV6eQIB+YhWiJcIeRlU0PKCYfdnRMN1cxhRhzICKH0kgpSVZCV/YXOn3fn4ebg3wbavJ0ok7ybz8QsOh/Z63uBC9fBehX/RiUc2qoriQYcBZ978gJewrzdTHs2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145759; c=relaxed/simple;
	bh=cuyyU0mVcLmQ4KeL5iyFtWiQ/S5771GAvdT4zHF5rK4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZuGyB1CimZY/H/zC4kOB1vBgZLda9+mAsx4vjduFUDCWsjiQkkQO93LQycacgRbemFY1JwfsmVXfURZmCzBI+tEFubgeW8NS5cqENzDYL1ONj5nMx/m6inLn955FI+xeC2hzE8DPCJZhM7QxlmzJdVpEmQ790T4VYbUbKGk0n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lEUPxouI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lEUPxouI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787145756; x=1818681756;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cuyyU0mVcLmQ4KeL5iyFtWiQ/S5771GAvdT4zHF5rK4=;
  b=lEUPxouIgryqJq0bHRv2QafMRL1xNz5OX8jJMNLPiJCFD7ulPaWckf2K
   npUKRzM1nUcDd1ohzwsI0qC7VBTIfE4qrwrDL9gsF04kf6MoTk0A8gtJH
   VGxZqTBaHAyG2zCtZEVcU4C97zRtAJrAQE75o7d0MvCpraZqu+5GZxg6y
   IEyyjxvvGfBHQskJ9Bl8Uzflk689hHWuDftVaHNS/Yraugrxnm7zArWb3
   dkCraV0Xh7TS2rsWv+0En2hlqRTQ9EgqIH41dq2ESq/brFD09N9IYCm2y
   VYcoClFuoIN3Se8NiyuabrcXjayE1Kw8m297qQ1rOg16JO0VfMEt7NBU1
   g==;
X-CSE-ConnectionGUID: hCErBd/eSUqzgLjjhDOFRg==
X-CSE-MsgGUID: VOuDed8VRz6bcIMMgmbesA==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="62677451"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:22:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 06:22:33 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Aug 2026 06:22:30 -0700
Message-ID: <3dddb145791971cfe0d45c873e63edce1ce5cab8.camel@microchip.com>
Subject: Re: [PATCH net-next v11 8/9] net: dsa: lan9645x: add mdb management
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 19 Aug 2026 15:22:29 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-8-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-8-007ebc983a0a@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This is a reply to:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805-dsa_lan9645x_s=
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D8

> --- Patch [8]: [PATCH net-next v11 8/9] net: dsa: lan9645x: add mdb manag=
ement ---
> commit f98510fb218c27ef1092f8176a5d379f8499735c
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add mdb management
>
> This adds the DSA port_mdb_add/port_mdb_del callbacks to the lan9645x
> driver, with a new lan9645x_mdb.c tracking software mdb entries and a poo=
l
> of PGID indices. IP multicast entries encode the port mask into the high
> DMAC bytes, while L2 multicast entries point at an allocated PGID index.
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > new file mode 100644
> > index 0000000000000..ea37bb660273c
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > @@ -0,0 +1,398 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include "lan9645x_main.h"
> > +
> > +/* HW ignores dest_idx for IPv4/IPv6 types, so we use this dummy index=
 */
> > +#define IP_ENTRY_PGID		0
> > +#define PGID_INDEX(pgid)	((pgid) ? (pgid)->index : IP_ENTRY_PGID)
>
> [ ... ]
>
> > +void lan9645x_mdb_init(struct lan9645x *lan9645x)
> > +{
> > +	INIT_LIST_HEAD(&lan9645x->mdb_entries);
> > +	INIT_LIST_HEAD(&lan9645x->pgid_entries);
> > +	mutex_init(&lan9645x->mdb_lock);
> > +
> > +	/* Use CPU queues to communicate frame classification to the CPU */
> > +	lan_rmw(ANA_CPUQ_CFG_CPUQ_IGMP_SET(LAN9645X_CPUQ_TRAP) |
> > +		ANA_CPUQ_CFG_CPUQ_MLD_SET(LAN9645X_CPUQ_TRAP) |
> > +		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_SET(LAN9645X_CPUQ_COPY),
> > +		ANA_CPUQ_CFG_CPUQ_IGMP |
> > +		ANA_CPUQ_CFG_CPUQ_MLD |
> > +		ANA_CPUQ_CFG_CPUQ_IPMC_CTRL,
> > +		lan9645x, ANA_CPUQ_CFG);
> > +}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Could the commit message mention the forwarding behaviour change that com=
es
> with this patch?  The changelog only says:
>
>     Add support for dsa mdb callbacks. L2 multicast and IP multicast is
>     handled differently.
>
> but besides the callbacks, lan9645x_mdb_init() writes the global
> ANA_CPUQ_CFG register (IGMP and MLD to LAN9645X_CPUQ_TRAP, IPMC_CTRL to
> LAN9645X_CPUQ_COPY), and lan9645x_port_setup() unconditionally sets
> IGMP_REDIR_ENA / MLD_REDIR_ENA / IPMC_CTRL_COPY_ENA on every non-NPI port=
.
>
> After this patch IGMP/MLD frames arriving on a user port are trapped to t=
he
> CPU instead of being forwarded by hardware, and lan9645x_offload_fwd_mark=
()
> in net/dsa/tag_lan9645x.c clears skb->offload_fwd_mark for the trap queue=
:
>
>     if (cpuq & BIT(LAN9645X_CPUQ_TRAP)) {
>             skb->offload_fwd_mark =3D 0;
>             return;
>     }
>
> so the software bridge takes over forwarding for those frames.  This happ=
ens
> for every non-NPI port regardless of whether any mdb entry is ever
> offloaded.
>

I will update the commit message.

> Also, is lan9645x_mdb_init() the right place for a write to a global
> classification register, given the name suggests only software list
> initialisation?
>

I will move the register write to lan9645x_setup().

> [ ... ]
>
> > +static void lan9645x_mdb_encode_mac(unsigned char *dst, unsigned char =
*mac,
> > +				    u16 ports, enum macaccess_entry_type type)
> > +{
> > +	ether_addr_copy(dst, mac);
> > +
> > +	/* The HW encodes the portmask in the high bits of the mac for ip
> > +	 * multicast entries, to save on the limited PGID resources.
> > +	 *
> > +	 * IPv4 Multicast DMAC: 0x01005Exxxxxx
> > +	 * IPv6 Multicast DMAC: 0x3333xxxxxxxx
> > +	 *
> > +	 * which gives us 24 or 16 bits to encode the portmask.
> > +	 */
> > +	if (type =3D=3D ENTRYTYPE_MACV4) {
> > +		dst[0] =3D 0;
> > +		dst[1] =3D ports >> 8;
> > +		dst[2] =3D ports & 0xff;
> > +	} else if (type =3D=3D ENTRYTYPE_MACV6) {
> > +		dst[0] =3D ports >> 8;
> > +		dst[1] =3D ports & 0xff;
> > +	}
> > +}
>
> [ ... ]
>
> > +static struct lan9645x_pgid_entry *
> > +lan9645x_mdb_pgid_entry_create(struct lan9645x *lan9645x, u16 ports)
> > +{
> > +	struct lan9645x_pgid_entry *pgid_entry =3D NULL;
> > +	int index;
> > +
> > +	for (index =3D PGID_GP_START; index < PGID_GP_END; index++) {
> > +		bool used =3D false;
> > +
> > +		list_for_each_entry(pgid_entry, &lan9645x->pgid_entries, list) {
> > +			if (pgid_entry->index =3D=3D index) {
> > +				used =3D true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!used)
> > +			return lan9645x_pgid_entry_alloc(lan9645x, index,
> > +							 ports);
> > +	}
> > +
> > +	return ERR_PTR(-ENOSPC);
> > +}
>
> [ ... ]
>
> > +static int lan9645x_mdb_update_dest(struct lan9645x *lan9645x,
> > +				    struct lan9645x_mdb_entry *mdb_entry,
> > +				    enum macaccess_entry_type type,
> > +				    struct lan9645x_pgid_entry *new_pgid,
> > +				    u16 new_ports)
> > +{
> > +	unsigned char mac[ETH_ALEN] __aligned(2);
> > +	struct lan9645x_pgid_entry *old_pgid;
> > +	int err, pgid_index;
> > +	bool cpu_copy;
> > +
> > +	old_pgid =3D mdb_entry->pgid;
> > +	lan9645x_mdb_encode_mac(mac, mdb_entry->mac, new_ports, type);
> > +	cpu_copy =3D !!(new_ports & BIT(lan9645x->num_phys_ports));
> > +	pgid_index =3D PGID_INDEX(new_pgid);
> > +
> > +	/* For IP multicast, the hardware lookup uses the DMAC
> > +	 * (01:00:5E:.. / 33:33:..) as the (mac, vid) key, not the encoded ma=
c.
> > +	 * Therefore, this CMD_LEARN will atomically rewrite the existing
> > +	 * hardware entry. We intentionally do not do a forget before learn
> > +	 * sequence, as that would not be atomic, and leave a forwarding gap.
> > +	 */
> > +	err =3D lan9645x_mact_learn_cpu_copy(lan9645x, pgid_index, mac,
> > +					   mdb_entry->vid, type, cpu_copy);
> > +	if (err) {
> > +		lan9645x_pgid_entry_put(lan9645x, new_pgid);
> > +		return err;
> > +	}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is it safe to assume here that a failing lan9645x_mact_learn_cpu_copy()
> means nothing reached the hardware?
>

On a healthy bus I expect no errors at all. An error means the bus
misbehaved, and we can not infer from it whether the command landed.

The mac commands CMD_LEARN/CMD_FORGET complete in a few microseconds, so th=
e
only way to get here with an entry actually written is for the register bus=
 to
fail between the command and the status read. I think that is close to
impossible. But the forget costs nothing here: it is a noop if the entry wa=
s
never written, and it fails harmlessly if the bus is still down. I will add=
 the
forget.

> Looking at __lan9645x_mact_learn_cpu_copy() in lan9645x_mac.c, the
> CMD_LEARN is written before the completion poll, and the only failure
> returned is from the poll itself:
>
>     lan_wr(... ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN), lan9645x, ANA_=
MACACCESS);
>
>     return lan9645x_mac_wait_for_completion(lan9645x, NULL);
>
> If the LEARN did take effect while the poll timed out, this error path ca=
lls
> lan9645x_pgid_entry_put(lan9645x, new_pgid), which for a freshly created
> PGID drops the last reference and returns the index to the free pool used=
 by
> lan9645x_mdb_pgid_entry_create(), and __lan9645x_mdb_add() then destroys =
the
> fresh mdb entry:
>
>     err =3D lan9645x_mdb_update_dest(lan9645x, mdb_entry, type, new_pgid,
>                                    new_ports);
>     if (err && !mdb_entry->ports)
>             lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
>
> Does that leave a hardware MAC table entry whose DEST_IDX points at an in=
dex
> no software entry references any more, so it can never be forgotten?  Whe=
n
> lan9645x_pgid_entry_alloc() later reuses that index and rewrites
> ANA_PGID(index) with a different mask, would the orphaned entry start
> forwarding that group to an unrelated port set?
>
> Would attempting lan9645x_mact_forget() for the (mac, vid) before droppin=
g
> the software state be enough to keep the two views in sync?
>

I will add the forget here and a comment.

> > +	mdb_entry->pgid =3D new_pgid;
> > +	mdb_entry->ports =3D new_ports;
> > +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +	return 0;
> > +}
>
> [ ... ]
>
> > +static int __lan9645x_mdb_del(struct lan9645x *lan9645x, int chip_port=
,
> > +			      const unsigned char addr[ETH_ALEN], u16 vid,
> > +			      enum macaccess_entry_type type)
> > +{
> > +	struct lan9645x_pgid_entry *new_pgid;
> > +	struct lan9645x_mdb_entry *mdb_entry;
> > +	u16 new_ports;
> > +	int err;
> > +
> > +	mdb_entry =3D lan9645x_mdb_entry_lookup(lan9645x, addr, vid);
> > +	if (!mdb_entry)
> > +		return -ENOENT;
> > +
> > +	if (!(mdb_entry->ports & BIT(chip_port)))
> > +		return 0;
> > +
> > +	new_ports =3D mdb_entry->ports & ~BIT(chip_port);
> > +
> > +	if (!new_ports) {
> > +		/* For IP multicast hardware uses DMAC as key (mac,vid) not
> > +		 * encoded mac.
> > +		 */
> > +		err =3D lan9645x_mact_forget(lan9645x, mdb_entry->mac,
> > +					   mdb_entry->vid, type);
> > +		if (err)
> > +			return err;
> > +		lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
> > +		return 0;
> > +	}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> For MACV4/MACV6 entries, the CMD_LEARN in lan9645x_mdb_update_dest() uses
> the mask-encoded address from lan9645x_mdb_encode_mac(), but this
> CMD_FORGET uses the plain mdb_entry->mac.  Can the two commands address t=
he
> same hardware entry?

Yes the two commands address the same hardware entry. The encoded bytes are=
 not
part of the (mac, vid) key used for lookups, for entries of type 2 and 3.
Otherwise the HW could not work, because ingressing frames do not carry the
port mask. The MAC which is used for the key depends on the mac table
entry type.

Type 2 (IPv4 multicast):
KEY_MAC =3D 0x01005E000000 | MACLDATA[23:0]

Type 3 (IPv6 multicast):
KEY_MAC =3D 0x333300000000 | MACLDATA[31:0]

The CPU access path is no different. Encoding the mac before the forget mak=
es no
difference, because it changes bytes which are unused for the lookup.

>
> The comment says the encoded bytes are not part of the (mac, vid) key, bu=
t
> both in-tree drivers for this silicon family re-encode the current mask
> before forgetting.  ocelot_port_mdb_del() in
> drivers/net/ethernet/mscc/ocelot.c does:
>
>     ocelot_encode_ports_to_mdb(addr, mc);
>     ocelot_mact_forget(ocelot, addr, vid);
>
> and lan966x_mdb_ip_del() in
> drivers/net/ethernet/microchip/lan966x/lan966x_mdb.c does the same:
>
>     lan966x_mdb_encode_mac(mac, mdb_entry, type);
>     lan966x_mac_forget(lan966x, mac, mdb_entry->vid, type);
>
> ocelot also does forget-then-learn on every mask change rather than relyi=
ng
> on LEARN rewriting an entry keyed by a different address.

I intentionally do not forget then learn, as that leaves a forwarding gap.
Overwriting an existing entry updates the group mask atomically.

>
> If the encoded bytes do participate in the MAC table key on the CPU acces=
s
> path,

But they do not. The encoding is necessary when learning because you need t=
o
store the mask in the entry for the forwarding engine. But the hash for the
lookup is calculated based on the KEY_MAC.

> then deleting the last member of an IPv4/IPv6 group here frees the
> software mdb_entry while the hardware entry survives and keeps forwarding=
 to
> the old port mask, and every mask change inserts an extra entry instead o=
f
> rewriting the existing one.  Could the encoded address be used for
> CMD_FORGET as the peer drivers do, or the comment be backed by the
> datasheet's MAC table key definition for the MACv4/MACv6 entry types?
>

I will add the mac key derivation above for type 2 and 3 in the comment.

> > +
> > +	/* Update PGID ptr for non-IP entries (L2 multicast) */
> > +	new_pgid =3D lan9645x_mdb_pgid_entry_get(lan9645x, new_ports, type);
> > +	if (IS_ERR(new_pgid))
> > +		/* Continue forwarding to old port group. */
> > +		return PTR_ERR(new_pgid);
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Can this early return leave an mdb entry that can never be reclaimed?
>

Yes this is right. Continuing to forward to the old group is a bad
fallback strategy. We need the mdb_entry->ports to be a subset of the kerne=
l
mdb entry.

Instead I will fallback to forward to the multicast flood mask, when we run=
 out
of PGIDs.

I will change __lan9645x_mdb_del() like so:

If lan9645x_mdb_pgid_entry_get() fails due to exhaustion, then if the pgid =
is
not shared, we can safely overwrite it and update destinations.

If it is not shared, we are exhausted and can not service the mdb_del. We
fallback to using PGID_MC, and keep mdb_entry->ports updated. And in
__lan9645x_mdb_add() handle the entries on the fallback pgid. This should m=
ake
sure entries do not get wedged, we can still configure forwarding to the CP=
U
on a fallback entry and if a fallback entry is later reconfigured while the=
re is
PGID space available, it will become offloaded again.

> For an L2 multicast group (ENTRYTYPE_LOCKED) with more than one member,
> new_ports is non-zero, so lan9645x_mdb_pgid_entry_get() runs and can retu=
rn
> -ENOSPC once all general purpose indices between PGID_GP_START and
> PGID_GP_END are taken, or -ENOMEM from lan9645x_pgid_entry_alloc().  On t=
hat
> path BIT(chip_port) is never cleared from mdb_entry->ports.
>
> The bridge has already removed the port from the group, and for user port=
s
> dsa_port_do_mdb_del() in net/dsa/switch.c just propagates the error with =
no
> refcount bookkeeping and no retry:
>
>     if (!(dsa_port_is_cpu(dp) || dsa_port_is_dsa(dp))) {
>             err =3D ds->ops->port_mdb_del(ds, port, mdb, db);
>             ...
>             return err;
>     }
>
> so the driver is never asked to delete that port again.  Does hardware th=
en
> keep forwarding the group to a port that has left it, including after tha=
t
> port leaves the bridge entirely?
>
> And since mdb_entry->ports can no longer reach zero, is the
>
>     if (!new_ports) {
>
> branch above (the one that calls lan9645x_mact_forget() and
> lan9645x_mdb_entry_dealloc()) unreachable for this (mac, vid), leaking th=
e
> struct lan9645x_mdb_entry, its reference on a PGID index and the hardware
> MAC table entry until lan9645x_mdb_deinit() at teardown?
>
> ocelot_port_mdb_del() orders this differently: it forgets the hardware en=
try
> and updates mc->ports before attempting the PGID allocation, so an -ENOSP=
C
> there cannot leave stale forwarding.  The add path here does clean up on
> failure; would the same be appropriate for the delete path?
>
> > +
> > +	return lan9645x_mdb_update_dest(lan9645x, mdb_entry, type, new_pgid,
> > +					new_ports);
> > +}
>
> [ ... ]
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > index 0548904dc4bd2..407d7eb1d0640 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > @@ -210,8 +210,17 @@ int lan9645x_port_setup(struct dsa_switch *ds, int=
 port)
> >  		ANA_PORT_CFG_PORTID_VAL,
> >  		lan9645x, ANA_PORT_CFG(p->chip_port));
> > =20
> > -	if (p->chip_port !=3D lan9645x->npi)
> > +	if (p->chip_port !=3D lan9645x->npi) {
> >  		lan9645x_vlan_set_hostmode(p);
> > =20
> > +		lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(true) |
> > +			ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(true) |
> > +			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(true),
> > +			ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
> > +			ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
> > +			ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
> > +			lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
> > +	}
> > +
> >  	return 0;
> >  }
>
> This is the per-port half of the forwarding change discussed above at
> lan9645x_mdb_init().
>
> Cross-instance finding from sashiko-gemini
(0d61a27e1fab704dbadd735055165f5f04176e88a680485b744c1f2e2be051cf):
> Duplicate CPU packet delivery on IP multicast MDB matches

