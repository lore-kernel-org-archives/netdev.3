Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28C355048;
	Wed, 19 Aug 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145399; cv=none; b=Nfi+t55w72Gtu9HjAN209NcSAMlxkTf9HrMh8V82846zEIymUDhsVU4WiWGU9WoUlvDW0wlIThlduZERLZLujWCyEaLvunr75mkagj7lld6Q8h7fPeca9GefBGWqmGM5yXrHqroFiCB6dnF2iaPqUDxM55J/5ibDla9m0JNRb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145399; c=relaxed/simple;
	bh=kBHPWo97uYwRSQBVWhpYZYcHcJ9umwbJ/0Ds0eO7wXE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJV7kMDocSi38QZRL3gtlBEzQmicO76c0ep5EWkxf0igmwbraqQyGaD6gNPrE/uTkIFcU5hdv/dV79tipyWlWvHAARJPAbwci4YwqHj6fjmg2q1WNf+ejmUddRKnq8tWrVF61X8Vlj/lHvLwZKmKAAr1O0e14bwxvYbq3dQOq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JCqSjDt3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JCqSjDt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787145395; x=1818681395;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kBHPWo97uYwRSQBVWhpYZYcHcJ9umwbJ/0Ds0eO7wXE=;
  b=JCqSjDt3P7n79EUcArkUdjZWsNZh73VYuug21yWIwBX0AU5RsjB7YUPW
   75G+eAjgqXsiNxrO3KPHb5JGDt0ipkHF+8c56cqcjPhQlU92tWCiBgWmf
   LnnUb9EpxVhutz4qp78f6Hv9XNlhfUWTf8WO9/RbrLiDDpA6ODD603Pmi
   H4eII2nfjwX/FPqW8foamQwwQHbWL/dj0mU1inAxnVJdTgA3vO+YJdaWi
   0ZL4Wey8WcZmc/lvWhxiGbTkFk4XYN3GTcF3qOCJKZKkwAX88CQgHbBac
   /IVSkWTwF6vsDnXXpOFdXk9v+/rM4I0xhCD3z/1LGNJn34mTltapciFxh
   A==;
X-CSE-ConnectionGUID: nrrKC829SfW3iRargQSIyg==
X-CSE-MsgGUID: ljfRS7kdTaiT5/L3DCnGRQ==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="62677125"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:16:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 06:16:33 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Aug 2026 06:16:30 -0700
Message-ID: <18fb098e343a49ceb90bcb385f06b14a7c58b736.camel@microchip.com>
Subject: Re: [PATCH net-next v11 7/9] net: dsa: lan9645x: add mac table
 integration
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
Date: Wed, 19 Aug 2026 15:16:29 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-7-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-7-007ebc983a0a@microchip.com>
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
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D7

> --- Patch [7]: [PATCH net-next v11 7/9] net: dsa: lan9645x: add mac table=
 integration ---
> commit c7af50889a34728dc6c99946b25b62bfb26fc31e
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add mac table integration
>
> This adds a new lan9645x_mac.c unit that drives the ANA MAC table through
> the ANA_MACACCESS/ANA_MACHDATA/ANA_MACLDATA registers, and wires it up to
> the DSA .port_fdb_add, .port_fdb_del, .port_fdb_dump and .port_fast_age
> callbacks. A new mact_lock mutex serializes all MAC table register access=
,
> including the aging period updates.
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > new file mode 100644
> > index 0000000000000..9d5282754b7a0
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> > @@ -0,0 +1,293 @@
>
> [ ... ]
>
> > +int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
> > +{
> > +	int err;
> > +
> > +	mutex_lock(&lan9645x->mact_lock);
> > +	/* MAC table entries with dst index matching port are aged on scan. *=
/
> > +	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
> > +	       ANA_ANAGEFIL_PID_VAL_SET(port),
> > +	       lan9645x, ANA_ANAGEFIL);
> > +
> > +	/* Flushing requires two scans. First sets AGE_FLAG=3D1, second remov=
es
> > +	 * entries with AGE_FLAG=3D1.
> > +	 */
> > +	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> > +	       lan9645x,
> > +	       ANA_MACACCESS);
> > +
> > +	err =3D lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +	if (err)
> > +		goto mact_unlock;
> > +
> > +	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
> > +	       lan9645x,
> > +	       ANA_MACACCESS);
> > +
> > +	err =3D lan9645x_mac_wait_for_completion(lan9645x, NULL);
> > +
> > +mact_unlock:
> > +	lan_wr(0, lan9645x, ANA_ANAGEFIL);
> > +	mutex_unlock(&lan9645x->mact_lock);
> > +	return err;
> > +}
>
> [ ... ]
>
> > +		/* Only dynamic entries are surfaced through the user port dump.
> > +		 * ENTRYTYPE_LOCKED entries are already reported by the bridge
> > +		 * master's ndo_fdb_dump as NTF_MASTER, so we avoid duplicating
> > +		 * them as NTF_SELF.
> > +		 * Entries toward the host (NTF_SELF) have DEST_IDX =3D=3D the CPU
> > +		 * port module and are filtered out by the DEST_IDX check.
> > +		 */
> > +		if (ANA_MACACCESS_DEST_IDX_GET(maca) =3D=3D port &&
> > +		    type =3D=3D ENTRYTYPE_NORMAL) {
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is the comment in lan9645x_mact_dsa_dump() accurate about what DEST_IDX
> holds for host entries?
>
> lan9645x_fdb_add() programs the destination as PGID_CPU:
>
> 	dest =3D dsa_port_is_cpu(dp) ? PGID_CPU : port;
>
> 	return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_LOCKED);
>
> and lan9645x_main.h defines PGID_CPU as (PGID_AGGR - 6), i.e. 58. The CPU
> port module itself is denoted by lan9645x->num_phys_ports elsewhere in th=
e
> driver, for instance ANA_VLAN_CFG(num_phys_ports) in lan9645x_vlan_init()
> and BIT(num_phys_ports) in the PGID_BC/PGID_CPU masks written by
> lan9645x_port_cpu_init():
>
> 	lan_wr(BIT(lan9645x->num_phys_ports), lan9645x, ANA_PGID(PGID_CPU));
>
> So the value stored in DEST_IDX for host entries is the reserved PGID ind=
ex
> 58, not the CPU port module index. Nothing misbehaves today, since both 5=
8
> and num_phys_ports fail the comparison against a user port index, but wou=
ld
> it be clearer to say the entries carry DEST_IDX =3D=3D PGID_CPU? A later =
change
> that adds an explicit host-entry test against num_phys_ports based on thi=
s
> comment would not match any entry.

Yes, I will update this comment.

>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 3281726284dc2..af158d4461aee 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>
> [ ... ]
>
> > @@ -626,6 +636,75 @@ static int lan9645x_port_vlan_del(struct dsa_switc=
h *ds, int port,
> >  	return lan9645x_vlan_port_del_vlan(p, vlan->vid);
> >  }
> > =20
> > +static void lan9645x_port_fast_age(struct dsa_switch *ds, int port)
> > +{
> > +	lan9645x_mact_flush(ds->priv, port);
> > +}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Should lan9645x_port_fast_age() log the dropped error here?
>
> lan9645x_mact_flush() returns the result of both
> lan9645x_mac_wait_for_completion() calls, which yield -ETIMEDOUT when
> ANA_MACACCESS.MAC_TABLE_CMD does not return to CMD_IDLE within the poll
> timeout. Since the DSA .port_fast_age op returns void, this callback is t=
he
> only place the failure can be observed, and the value is discarded.
>
> On a failed flush the ANA_ANAGEFIL filter is cleared and CMD_AGE is not
> retried, so the port's dynamic entries stay in the MAC table after an STP
> topology change or bridge leave, with no kernel message. If aging was
> disabled with a zero ageing time in lan9645x_set_ageing_time()
> (ANA_AUTOAGE_AGE_PERIOD =3D=3D 0), the stale entries are not aged out lat=
er
> either.
>
> felix_port_fast_age() handles the same situation for the related IP by
> reporting it:
>
> 	err =3D ocelot_mact_flush(ocelot, port);
> 	if (err)
> 		dev_err(ds->dev, "Flushing MAC table on port %d returned %pe\n",
> 			port, ERR_PTR(err));
>

Sure, I will add an error log here.

> > +
> > +static int lan9645x_fdb_dump(struct dsa_switch *ds, int port,
> > +			     dsa_fdb_dump_cb_t *cb, void *data)
> > +{
> > +	return lan9645x_mact_dsa_dump(ds->priv, port, cb, data);
> > +}
>
> [ ... ]

