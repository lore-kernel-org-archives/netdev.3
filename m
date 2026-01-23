Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C01ADC83;
	Fri, 23 Jan 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181153; cv=none; b=PntqiySpkBxz2XbwXi/PaZnQ8z4i6ukM164SfeaUZ+H7ozbXv/ZaCCGXYXeQbZCyt21BaAoMCkvoCXNjxNkEXWgp1CM95IUce5S7NJZkFxEogDBTdYcOPO5c3RlptMDo9mD931rzITEK5Tm+yZ77jl+81eY1cE2ftT3chNgkO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181153; c=relaxed/simple;
	bh=LlGjFkbpz393Zh2cp8e492GV822pG88X7RMG/tq/iv8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIVCpTOIhYmzDAj/iH3Mq7Keumd9HX/zio/oJBoTV/yGKEGOfU40IOk0EyMUjB8b/x7NRqbx0hRVMW/A4GkFkABpUgDpncpsJHnNtgL8MRE4fz+hehIcLDQhLdnmAmA23HEMQctllzv+SnQl4foReFxxPouGyRyyt4cVNR6OJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o6hBUBkY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o6hBUBkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769181152; x=1800717152;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LlGjFkbpz393Zh2cp8e492GV822pG88X7RMG/tq/iv8=;
  b=o6hBUBkYPyOSAu32aQ47MHT1fYDZGHTsOTGQ88X6C8bzBZVyDx0lzGqg
   lEM3Qn9n5YTfeVHtzg0j7uBlDJMRLvkOqBiPuHJec8mQHqNYmhaHLmDpV
   Dw3JMLWPRu2u8tDdfjOMXGz6MOiUoVqWf9Jn+/d/TO3NykJANCxcQAWZX
   leHUqNNAAEKpeNpbxHDqHWBXnzqJ32lYDaL2YhHHwnKpG39DOuW4iijTa
   SK/jC9O6aoBDU/wOhMzWBd0Do+QF+5tD7t1nDeGPcWYXH8y7rCQX2oupX
   3ORneo1T9LKGjeZbAqzDlhgHktrQPeob7xIptDac/MJj1cV4zyZ8xUpio
   g==;
X-CSE-ConnectionGUID: HoJcv0SgTYebdqU3KinZPg==
X-CSE-MsgGUID: LHE7fFyeSc+PamifPSO3fQ==
X-IronPort-AV: E=Sophos;i="6.21,248,1763449200"; 
   d="scan'208";a="52351502"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 08:12:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 23 Jan 2026 08:12:21 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 23 Jan 2026 08:12:19 -0700
Message-ID: <15accbfe16853a468890944dbf75de46ef560f83.camel@microchip.com>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@pengutronix.de>, <rsc@pengutronix.de>
Date: Fri, 23 Jan 2026 16:12:18 +0100
In-Reply-To: <aXNFrDOdPanZ_cjk@pengutronix.de>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
	 <aXNFrDOdPanZ_cjk@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oleksij,

On Fri, 2026-01-23 at 10:55 +0100, Oleksij Rempel wrote:
>=20
> Hi Jens,
>=20
> On Fri, Jan 23, 2026 at 08:50:55AM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > LAN9645X is a family of switch chips with 5 internal copper phys. The
> > internal PHY is based on parts of LAN8832. This is a low-power, single
> > port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
> > layer transceiver (PHY) that supports transmission and reception of dat=
a
> > on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
> > Pair (UTP) cables.
> >=20
> > Add support for the internal PHY of the lan9645x chip family.
>=20
> Looks like interesting switch for our use cases :)
>=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> > =C2=A0drivers/net/phy/micrel.c=C2=A0=C2=A0 | 142 ++++++++++++++++++++++=
+++++++++++++++++++++++
> > =C2=A0include/linux/micrel_phy.h |=C2=A0=C2=A0 1 +
> > =C2=A02 files changed, 143 insertions(+)
> >=20
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 225d4adf28be..7f47f7987067 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -6502,6 +6502,132 @@ static void lan8842_get_phy_stats(struct phy_de=
vice *phydev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stats->tx_errors =3D priv->phy_stats.tx_=
errors;
> > =C2=A0}
> >=20
> > +#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN=C2=A0=C2=A0=C2=A0=C2=A0 0x47
> > +#define LAN9645X_BTRX_QBIAS_POWER_DOWN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x46
> > +#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT=C2=A0=C2=A0 0x45
> > +#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT=C2=A0=C2=A0=C2=A0 0x44
> > +#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT=C2=A0=C2=A0=C2=A0 0x43
>=20
> > +static const struct lanphy_reg_data force_dac_tx_errata[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Force channel A/B/C/D TX on */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { LAN8814_PAGE_POWER_REGS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 },
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Force channel A/B/C/D QBias on */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { LAN8814_PAGE_POWER_REGS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LAN9645X_BTRX_QBIAS_POWER_DOWN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xaa },
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* tx low I on channel C/D overwrite */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { LAN8814_PAGE_POWER_REGS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LAN9645X_TX_LOW_I_CH_CD_POWER_MGM=
T,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xbfff },
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* channel B low I overwrite */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { LAN8814_PAGE_POWER_REGS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LAN9645X_TX_LOW_I_CH_B_POWER_MGMT=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xabbf },
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* channel A low I overwrite */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { LAN8814_PAGE_POWER_REGS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LAN9645X_TX_LOW_I_CH_A_POWER_MGMT=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xbd3f },
> > +};
>=20
> It looks like this erratum not publicly documented. At least not here:
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDoc=
uments/Errata/LAN9645xS-
> LAN9645xF-Errata-DS80001187.pdf
>=20
> re there more information about it? Can it be described in the comment?
>=20

You are right, I think they ought to be documented in the official erratas
list with a more thorough description. I will get a hold of the right
people and ask them to add it.

> > +
> > +static int lan9645x_config_init(struct phy_device *phydev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Apply erratas. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D lan8842_erratas(phydev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return lanphy_write_reg_data(phydev, force_da=
c_tx_errata,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(force_dac=
_tx_errata));
> > +}
> > +
> > +static int lan9645x_suspend(struct phy_device *phydev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int aneg_en_state, ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Software workaround from design to handle =
SPD. SPD will stop AFE
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * clock from AFE port, which makes the =
system MAC fifo unable to flush.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The workaround is to restart ANEG and=
 wait for flush, before issuing
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * software power down.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 aneg_en_state =3D phy_read(phydev, MII_BMCR) =
& BMCR_ANENABLE;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D phy_restart_aneg(phydev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Allow time for system FIFO flush data */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 usleep_range(8 * USEC_PER_MSEC, 12 * USEC_PER=
_MSEC);
>=20
> MAC and PHY power management are not always fully coupled (implementation
> specific), are there other ways to sync them with each other, except of
> unconditional sleep in the PHY driver. I expect that someone making
> changes on the MAC driver may miss this nuance.
>=20

The MAC side will be handled in a yet-to-be-sent DSA driver, which is also
authored by my team.

During development I was seeing issues where SPD sometimes causing
interference on neighbouring PHYs. The PHY team came up with the tx dac
errata and the aneg restart workaround as a solution.

To my knowledge there was no alternative workaround, but I have reached out
to the PHY team to make sure. If there is a better way to fix these issues,
I will add it in the next version.

> Best Regards,
> Oleksij
> --
> Pengutronix e.K.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> Steuerwalder Str. 21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | http://www.pengutronix.de/=C2=A0 |
> 31137 Hildesheim, Germany=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Phone: +49-5121-20=
6917-0=C2=A0=C2=A0=C2=A0 |
> Amtsgericht Hildesheim, HRA 2686=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | Fax:=C2=A0=C2=A0 +49-5121-206917-5555 |

Thank you for the comments,

Emil

