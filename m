Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717B4119E3;
	Tue,  6 Oct 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290109; cv=none; b=bpRFU5ZSdFn40Q/O66Anobi3nJsyPDDq23TJ0I0egZvASdF8Vn1Dpj4XSjX7NeedYixf2kvm3xzxprsqGScqIeNODvKevJWD6zTTc+H6eWElotrpvlL2+ObNQB06uuHAFkWvX51M77lAQbVzvl4RCqu5mQ+pOebfrDfZX14v2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290109; c=relaxed/simple;
	bh=okO//1OC5q5RSrh6WMC9iDoGxpZ9FQDabGRMzI/Nm70=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+pLtPDllaI3qjZeRACWvZeJZPgCDwTOsCDDY+bGDTDR4IeD8bAXemddQuU9tqQQD850G5xl2K+En3tu5Vs6/Xig0lrUZBylqdU/ohw9WiQFjeXslkdy+zLOGCXZ5Q3Q8BFCu0bVSOh8hUZCFD6mhk+9Mzzq+1hFGoMg3cVr2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YNfR4PgH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YNfR4PgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791290104; x=1822826104;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=okO//1OC5q5RSrh6WMC9iDoGxpZ9FQDabGRMzI/Nm70=;
  b=YNfR4PgHbJno5vJ6T7Hwe1BAD3UfyeQ8v2EfTJf6+fOR4VkexCoKGzAB
   ybEYsdcXcQJydQqscLJTIndQwu82kaJ8EJcqAwMNexgvVpWlvYh5qmYzE
   /8zmRfD5QHo5ffw08zJ9NAXharPq5Y4QuC20qF5F4D5qrNTSTou8ZZxIB
   gNwJQPXG5xgkB2nV5Qy8i1xEb8uvX0nW+4JZTC4PlS+t39t6lzs4/+7/O
   G7CTsKjFrSNN5gtfzqPCMpvp2fUTn+K+oe3+Bw+IHB618uMOz8KsAA+hn
   XqbxY4WCUXJu7C5HuVLv94pkJk1jFVPWhYSZDASAHB6O6/vDBdKxb/3As
   Q==;
X-CSE-ConnectionGUID: hmQu6HW7T3SnUf2azV1Z+Q==
X-CSE-MsgGUID: WlD+0t1IQeSx8p7I1VKAew==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="64640319"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2026 05:35:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 6 Oct 2026 05:34:58 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 05:34:55 -0700
Message-ID: <b882df169d0b56a5d16f97ed44fcdb9baa2f7ed6.camel@microchip.com>
Subject: Re: [PATCH net-next v13 6/9] net: dsa: lan9645x: add mac table
 integration
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
Date: Tue, 6 Oct 2026 14:34:54 +0200
In-Reply-To: <179097566160.434549.9925459819174275044@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-6-827c2d3617f2@microchip.com>
	 <179097566160.434549.9925459819174275044@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] For a non-zero VID, lan9645x_fdb_add() and lan9645x_fdb_del()
>   map DSA_DB_PORT and DSA_DB_BRIDGE host entries to the same hardware=E2=
=80=A6
> - [Low] Each new MAC table sequence writes the key, the filter and the
>   command through lan_wr().
>=20
> --
>=20
> net: dsa: lan9645x: add mac table integration
>=20
> This commit adds MAC table support to the lan9645x DSA driver. It adds
> learn, forget, flush and GET_NEXT based dump helpers keyed on (vid, mac).
> These are wired into the port_fast_age, port_fdb_dump, port_fdb_add and
> port_fdb_del DSA callbacks.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > new file mode 100644
> > index 0000000000000..50ce1378b9dae
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > @@ -0,0 +1,268 @@
>=20
> [ ... ]
>=20
> > +static void lan9645x_mac_select(struct lan9645x *lan9645x,
> > +                             const unsigned char mac[ETH_ALEN],
> > +                             unsigned int vid)
> > +{
> > +     u64 maddr =3D ether_addr_to_u64(mac);
> > +
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     lan_wr(ANA_MACHDATA_VID_SET(vid) |
> > +            ANA_MACHDATA_MACHDATA_SET(upper_32_bits(maddr)),
> > +            lan9645x,
> > +            ANA_MACHDATA);
> > +
> > +     lan_wr(lower_32_bits(maddr),
> > +            lan9645x,
> > +            ANA_MACLDATA);
> > +}
>=20
> [ ... ]
>=20
> > +static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> > +                              const unsigned char mac[ETH_ALEN],
> > +                              unsigned int vid,
> > +                              enum macaccess_entry_type type,
> > +                              bool cpu_copy)
> > +{
> > +     lockdep_assert_held(&lan9645x->mact_lock);
> > +
> > +     lan9645x_mac_select(lan9645x, mac, vid);
> > +
> > +     lan_wr(ANA_MACACCESS_VALID_SET(1) |
> > +            ANA_MACACCESS_DEST_IDX_SET(port) |
> > +            ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
> > +            ANA_MACACCESS_ENTRYTYPE_SET(type) |
> > +            ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
> > +            lan9645x, ANA_MACACCESS);
> > +
> > +     return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +}
>=20
> [Severity: Low]
> Can a failed register write here be reported to DSA as a successful learn=
?
>=20
> lan_wr() returns void and only calls WARN_ON_ONCE() when regmap_write()
> fails. Suppose the ANA_MACACCESS command write is lost but the reads that
> follow still work. Then lan9645x_mac_wait_for_completion() sees CMD_IDLE
> immediately and returns 0:
>=20
>         err =3D lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
>                                        ANA_MACACCESS_MAC_TABLE_CMD_GET(va=
l) =3D=3D
>                                        CMD_IDLE);
>=20
> In that case lan9645x_fdb_add() returns success and the bridge marks the
> entry as offloaded, but the table was never changed. The same applies to
> CMD_FORGET in __lan9645x_mact_forget().
>=20
> What happens if only the ANA_MACHDATA or ANA_MACLDATA write in
> lan9645x_mac_select() fails? Would CMD_LEARN or CMD_FORGET then act on a
> stale key? That could be the previous operation's key, or whatever the
> last GET_NEXT walk in lan9645x_mact_dsa_dump() left in the registers.
>=20
> lan9645x_mact_flush() has the same problem with its ANA_ANAGEFIL write:
>=20
>         lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
>                ANA_ANAGEFIL_PID_VAL_SET(port),
>                lan9645x, ANA_ANAGEFIL);
>=20
> If that write fails, both CMD_AGE scans would run without the port
> filter. Would that flush dynamic entries from every port instead of only
> the requested one?
>=20
> This only happens if the parent MFD bus can fail a write while later
> reads succeed. The parent driver is not in the tree, so that could not be
> confirmed. The ocelot-family drivers follow the same lan_wr() convention.
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 6818b91f4bed2..5cb4f5fe13740 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -360,6 +364,81 @@ static int lan9645x_port_vlan_del(struct dsa_switc=
h *ds, int port,
>=20
> [ ... ]
>=20
> > +static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
> > +                         const unsigned char *addr, u16 vid,
> > +                         struct dsa_db db)
> > +{
>=20
> [ ... ]
>=20
> > +     if (dsa_port_is_cpu(dp) && !br &&
> > +         dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> > +             return 0;
> > +
> > +     if (!vid)
> > +             vid =3D lan9645x_vlan_unaware_pvid(!!br);
> > +
> > +     dest =3D dsa_port_is_cpu(dp) ? PGID_CPU : port;
> > +
> > +     return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_L=
OCKED,
> > +                                false);
> > +}
> > +
> > +static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
> > +                         const unsigned char *addr, u16 vid,
> > +                         struct dsa_db db)
> > +{
> > +     struct net_device *br =3D lan9645x_db2bridge(db);
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     if (IS_ERR(br))
> > +             return PTR_ERR(br);
> > +
> > +     if (dsa_port_is_cpu(dp) && !br &&
> > +         dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> > +             return 0;
> > +
> > +     if (!vid)
> > +             vid =3D lan9645x_vlan_unaware_pvid(!!br);
> > +
> > +     return lan9645x_mact_forget(lan9645x, addr, vid, ENTRYTYPE_LOCKED=
);
> > +}
>=20
> [Severity: Medium]
> Could this forget a CPU port entry that another database still needs?
>=20
> For a non-zero vid, lan9645x_fdb_add() and lan9645x_fdb_del() map two
> host entries with the same (vid, mac) to one hardware key pointing at
> PGID_CPU: the DSA_DB_PORT one and the DSA_DB_BRIDGE one. Only vid 0 is
> split, into HOST_PVID and UNAWARE_PVID by lan9645x_vlan_unaware_pvid().
>=20
> DSA refcounts the two entries separately on the CPU port, because
> dsa_mac_addr_find() includes the db in its key. The shared-key guard only
> matches entries of the same db type:
>=20
> net/dsa/dsa.c:dsa_fdb_present_in_other_db() {
>     ...
>         if (a->db.type =3D=3D db.type && !dsa_db_equal(&a->db, &db))
>                 return true;
>     ...
> }
>=20
> So when a DSA_DB_PORT entry is deleted, the guard never sees a
> DSA_DB_BRIDGE entry with the same key. For DSA_DB_BRIDGE deletions, the
> !br check skips the guard entirely.
>=20
> One way to hit this:
>=20
> - swp1 is in a VLAN-aware bridge.
> - swp1.100 is a VLAN upper whose MAC M differs from swp1's.
> - dsa_user_vlan_rx_add_vid()->dsa_user_schedule_standalone_work(DSA_UC_AD=
D)
>   installs a DSA_DB_PORT host entry (M, 100).
> - M is also a bridge host address in VID 100, which adds a DSA_DB_BRIDGE
>   host entry (M, 100). This happens, for example, with br0 using vid 100
>   self and the same MAC, or with a local entry of another port in VID 100=
.
>=20
> Removing either entry, for example by taking swp1.100 down or deleting
> the bridge VLAN, goes through:
>=20
> dsa_switch_host_fdb_del()
>   dsa_port_do_fdb_del()
>     lan9645x_fdb_del()
>       dsa_fdb_present_in_other_db()   /* false, db types differ */
>       lan9645x_mact_forget()          /* CMD_FORGET on (M, 100) */
>=20
> Wouldn't the hardware then lose the entry for the host address that is
> still wanted?
>=20
> __lan9645x_port_set_host_flood() leaves the CPU out of PGID_UC when only
> bridged ports request host flooding. Unicast to M in VID 100 could then
> be dropped instead of reaching the host. The felix driver uses the same
> pattern.
>=20

Correct, a DSA_DB_PORT and a DSA_DB_BRIDGE host entry with the same
address and a non-zero VID map to one MAC table entry, and
dsa_fdb_present_in_other_db() only considers databases of the same type.
v14 replaces the check with one that walks the CPU port address list and
compares the MAC table key each entry maps to, so the entry is only
learned or forgotten when no other database uses that key.


> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

