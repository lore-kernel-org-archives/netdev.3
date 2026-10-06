Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7FC43F4A7;
	Tue,  6 Oct 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291139; cv=none; b=Sk7goo8ltcTlvSUbQXmE7rN0MC7kAbHgf33VvTIOjxFcuWkCaJWlSs9guqd77Oq0kEW9ZxemRJ5uPIHkGjZIzEEBMUl/drGAwq4ll4bJ5OAVnnmCgQOV1AevFc/sU0DRvB8wPS37+UcO6EMOwOzSUxVcBwDNyxU/iItgvhwW0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291139; c=relaxed/simple;
	bh=FL6XHPuPMvhVSQHv15tPkB5Abk6onukAB9fohPnclnU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaDTY2vMOcaTTietjti2xbVmVke+vO0LYfuFu+ZrwPKflTUwecGFISZ+JqmY8EQiwmvRKH4x2aRT9AYG42tCt+iEjqIYDKvh7xIxgxsnJYM0kLG+CPPABb/9TnJLAZp/k0FlDKI60eDcQR/GA6Jw3kWEj/dzYUjKFN39BZzBtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kIlnQNIR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kIlnQNIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791291135; x=1822827135;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FL6XHPuPMvhVSQHv15tPkB5Abk6onukAB9fohPnclnU=;
  b=kIlnQNIRYBDQCJ2Tb2cJrPWKqVsxM2ma/auV4bdik51mF9f7VI9i07ZV
   MAECeB0kXGSuZDRkFrXaM87gR/7Ut+IwIOwoAlZ4m0x6/uAxxMtiZAmo4
   /S/fHrcgcrqEpausw7aPDet1Rs/g0zVlFOKkbiMTHM/RZLeBDVj+cgHjt
   90vnGpHRDASVepG/kbaLVii+/qH8l+P/zr6FLkzfNn42Kz0veiAdof0aA
   orNWvJkrJe+9sK7pRU2CuOUucU/xw8d/KnMwm6X3okBGcFn9zqL7AWvZD
   v8faVXbMw1c1PL4smxhloS96X9CbpuqhS56MSKFtDCEg4Hnw+u3SyU/ux
   A==;
X-CSE-ConnectionGUID: qmz+3RNeT6C/7C918+zNuw==
X-CSE-MsgGUID: EArNHnYcSsCzufowadr4Eg==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="231739168"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2026 05:51:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 6 Oct 2026 05:51:58 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 05:51:54 -0700
Message-ID: <4a1fe0e98d7d593900d8d4b68afaf569fa8160fd.camel@microchip.com>
Subject: Re: [PATCH net-next v13 7/9] net: dsa: lan9645x: add mdb management
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
Date: Tue, 6 Oct 2026 14:51:54 +0200
In-Reply-To: <179097566330.434549.248865005553005719@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-7-827c2d3617f2@microchip.com>
	 <179097566330.434549.248865005553005719@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] On a failed MAC table write, lan9645x_mdb_widen_dest() drops
>   the reference on new_pgid right away=E2=80=A6
> - [Low] lan9645x_mdb_narrow_dest() commits mdb_entry->pgid =3D new_pgid a=
nd
>   mdb_entry->ports =3D new_ports before calling lan9645x_mdb_write_dest()=
.
> - [Low] A failed CPU-only membership delete leaks a PGID reference
>   because old_pgid and new_pgid are the same object.
>=20
> --
>=20
> net: dsa: lan9645x: add mdb management
>=20
> This adds the DSA mdb callbacks to the lan9645x driver. IP multicast
> stores the port group mask inline in the mac table entry. L2 multicast
> points at a refcounted PGID whose destination mask is the port group.
> CPU membership is carried by the MAC_CPU_COPY bit, and when the PGIDs
> run out, add and delete handle it differently.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > new file mode 100644
> > index 0000000000000..92ab5f55f7913
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> > @@ -0,0 +1,569 @@
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
> > +             lan9645x_pgid_entry_put(lan9645x, new_pgid);
> > +             return err;
> > +     }
>=20
> [Severity: Medium]
> Can this hand a PGID index to an unrelated group while hardware still
> points at it?
>=20
> __lan9645x_mact_learn() issues the command before it polls for
> completion:
>=20
>     lan_wr(ANA_MACACCESS_VALID_SET(1) |
>            ANA_MACACCESS_DEST_IDX_SET(port) |
>            ...
>            ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
>            lan9645x, ANA_MACACCESS);
>=20
>     return lan9645x_mac_wait_for_completion(lan9645x, NULL);
>=20
> That means an error from lan9645x_mdb_write_dest() only tells us the
> outcome is unknown, for example after a failed poll read or a timeout.
> The entry may already point at pgid_index.
>=20
> If new_pgid was just created, this put frees its index. A later add
> with a different port mask can get the same index back from
> lan9645x_mdb_pgid_entry_create(). lan9645x_pgid_entry_alloc() then
> rewrites ANA_PGID for that group, so an entry that may have been
> written would forward this group to the other group's ports.
>=20
> When the entry already existed (ports !=3D 0), __lan9645x_mdb_add() does
> no further cleanup. For a fresh entry it issues the forget only after
> the PGID has been released, and it ignores the result:
>=20
>     lan9645x_mact_forget(lan9645x, mdb_entry->mac,
>                          mdb_entry->vid, type);
>     lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);
>=20
> The comment there says the forget "fails harmlessly if the bus is still
> down". Isn't that the case where an entry pointing at a freed PGID is
> left in hardware?
>=20
> The delete side handles the same uncertainty by keeping the reference.
> lan9645x_mdb_narrow_dest() keeps old_pgid on failure, and
> __lan9645x_mdb_del() sets mdb_entry->pgid =3D NULL when CMD_FORGET fails.
> The v12 changelog gives the reason: "so the index cannot be handed to an
> unrelated group while hardware may still point at it".
>=20
> Should the add path also keep the new_pgid reference when the write
> fails?
>=20

Correct, an error from the learn command leaves the hardware state
unknown, and the add path dropped the PGID reference anyway. v14 keeps
the reference on a failed write, as the delete path does, so the index
cannot be reused while hardware may point at it.


> > +     mdb_entry->pgid =3D new_pgid;
> > +     mdb_entry->ports =3D new_ports;
> > +     lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +     return 0;
> > +}
>=20
> [ ... ]
>=20
> > +static void lan9645x_mdb_narrow_dest(struct lan9645x *lan9645x,
> > +                                  struct lan9645x_mdb_entry *mdb_entry=
,
> > +                                  enum macaccess_entry_type type,
> > +                                  struct lan9645x_pgid_entry *new_pgid=
,
> > +                                  int pgid_index, u16 new_ports)
> > +{
> > +     struct lan9645x_pgid_entry *old_pgid =3D mdb_entry->pgid;
> > +     int err;
> > +
> > +     lockdep_assert_held(&lan9645x->mdb_lock);
> > +
> > +     mdb_entry->pgid =3D new_pgid;
> > +     mdb_entry->ports =3D new_ports;
>=20
> [Severity: Low]
> mdb_entry->pgid is switched to new_pgid before the hardware write. If
> that write fails, which PGID does the entry use afterwards? Hardware
> would still use old_pgid, while software records new_pgid.
>=20
> The in-place branch in __lan9645x_mdb_del() assumes hardware points at
> mdb_entry->pgid, so it only rewrites ANA_PGID:
>=20
>     if (mdb_entry->pgid && refcount_read(&mdb_entry->pgid->refcount) =3D=
=3D 1) {
>         mdb_entry->pgid->ports =3D new_ports &
>                                  ~BIT(lan9645x->num_phys_ports);
>         ...
>         lan_rmw(ANA_PGID_PGID_SET(mdb_entry->pgid->ports), ...);
>         return 0;
>     }
>=20
> For example, take a group {A,B,C} on PGID P:
>=20
> 1. Deleting C creates Q=3D{A,B} with the last free index, and the MAC
>    write fails.
>=20
> 2. Deleting B finds no PGID for {A}, so creation returns -ENOSPC.
>=20
> 3. Q has refcount 1, so it is narrowed in place.
>=20
> Hardware still forwards through P, so B and C keep receiving the group,
> and nothing further is logged.
>=20
> Should the in-place branch, or a later narrowing, rewrite the MAC entry
> after an earlier failed write?
>=20
> > +
> > +     err =3D lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_i=
ndex,
> > +                                   new_ports);
> > +     if (err) {
> > +             dev_err(lan9645x->dev,
> > +                     "Narrowing %pM vid %u to mask 0x%x returned %pe\n=
",
> > +                     mdb_entry->mac, mdb_entry->vid, new_ports,
> > +                     ERR_PTR(err));
> > +             return;
> > +     }
>=20
> [Severity: Low]
> Does this early return leak a PGID reference when old_pgid and new_pgid
> are the same object?
>=20
> Take a group {A, CPU} on PGID P, whose ports are {A}. When only the CPU
> port module leaves, lan9645x_mdb_pgid_entry_get() strips the CPU bit.
> lan9645x_mdb_pgid_entry_lookup() then returns P after refcount_inc().
> Now new_pgid =3D=3D old_pgid =3D=3D P, and P holds two references for a s=
ingle
> mdb entry.
>=20
> If lan9645x_mdb_write_dest() fails here, the put below is skipped. When
> the group is removed later, lan9645x_mdb_entry_dealloc() drops only one
> reference. P and its index then stay reserved until
> lan9645x_mdb_deinit().
>=20
> Keeping old_pgid makes sense when it differs from new_pgid. Here,
> though, mdb_entry->pgid already holds P. Should the put still run when
> old_pgid =3D=3D new_pgid?
>=20
> > +
> > +     lan9645x_pgid_entry_put(lan9645x, old_pgid);
> > +}
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

