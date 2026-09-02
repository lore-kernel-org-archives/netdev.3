Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0F37B003;
	Wed,  2 Sep 2026 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327399; cv=none; b=p+xZAw9pX3B9WfYYgWECWJttYnYihHDWuvlRyFrEEwxqoSvcn17mDv/36EVwZwroeeECHjHJD7DCuJoDcIo6elQCdks89M01uCDTkkce2z7NSrjrFwrz0CwmVxUQsLMfJEeT+6nTPt17Jxq8ePTFWKieI5hI1rqBl0wZDkeCXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327399; c=relaxed/simple;
	bh=54IUuX2LgPfyeF7qW/3DbfTQb8po+6pSn/gM6d2d9cg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+qrq+Fvn9VW3I6foOsfw3bUD0h8zrkisYs1Tdhm6VppRbyFRc9FHvMJX3aeAkIAuU2Klxb6sVpncW67APXChQQvPfKW2Nbu6RFAhLasvY0CUXPCxsCQyvVuUJB14ypR1Bm6ojvqCQ+9scNxi5FcBmzH3vFBKc+A1+CU1hpU65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4L54Wa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4L54Wa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC50A1F000E9;
	Wed,  2 Sep 2026 05:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327397;
	bh=uhbRECPPQO0my9o6O3ryBUniRBemM/p1E3u24h68PMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E4L54Wa23lFW+1090Fvseg3MKGqV7qRj4vV/JfI9ODaVLhkHgwI1gVlpZT62K2QvI
	 /AMirorhScLalhURz4a4BZvCxtW7UAzDPGMT5XbWE+6QjAx3ZXdn7cNZizO5kzvbD4
	 P+pwXnlud0vsPYKV9pysPF9NSqudGikFcrLPVixGP5gWFxjcN53TVMTKTMP3ZUO2jq
	 /mVRajxBEkXRCz9v4gp/vA05rwdsQOGco68HX7NQWQqWn83F23etXXU6BiMC17b7ZM
	 6icX/fvNd+dLEY5lS0qrb0/C2iJ+/eheEDDUXuGWrK4/ijK+u9PIBM6ZVqIWIV3Opc
	 lKEKNxSbfTKQA==
Subject:
 Re: [net-next,v15,03/13] net: mdio: realtek-rtl9300: deny C45 over C22 access
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:36 +0000
Message-ID: <178832739640.3394541.1568384920310155418@kernel.org>
In-Reply-To: <20260831143439.2404484-4-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-4-markus.stockhausen@gmx.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new guard is keyed purely on the register number, so it
  rejects every C22 access to registers 13/14, not only the C45-over-C22…
- [Low] The patch fixes a defect that exists in released kernels — the
  commit message itself states that C45-over-C22 access "is accepted by…

--

net: mdio: realtek-rtl9300: deny C45 over C22 access

This adds a register number check to the C22 read and write accessors of
the RTL9300 MDIO driver so that accesses to MII_MMD_CTRL and MII_MMD_DATA
return -EOPNOTSUPP and emit a one-time warning. The stated reason is that
hardware polling breaks C45 over C22 PHY access.

No Link: tags are present in the commit header.

> net: mdio: realtek-rtl9300: deny C45 over C22 access
>
>     Hardware polling breaks C45 over C22 PHY access. Currently this
>     is accepted by the driver but it silently fails with undefined
>     results.

[Severity: Low]
The changelog describes behaviour that "is accepted by the driver but it
silently fails with undefined results", which reads like a defect present in
released kernels, but there is no Fixes: tag and no note about stable
routing or about this being deliberately net-next only.

The broken accessors are the pre-existing otto_emdio_read_c22() and
otto_emdio_write_c22() installed as bus->read/bus->write in
otto_emdio_probe_one(), which came in with commit 24e31e4747698 ("net:
mdio: Add RTL9300 MDIO driver"). Another patch of this same series ("net:
mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes") already
carries exactly that tag.

Should this one carry a Fixes: tag as well, so backporters can tell which
kernels are affected and whether the new -EOPNOTSUPP behaviour is intended
for stable?

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 73ac5fdcd2674..69565a87f99db 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -453,6 +454,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  	int ret, port;
>  	u32 value;
>  
> +	if (regnum == MII_MMD_CTRL || regnum == MII_MMD_DATA) {
> +		dev_warn_once(&bus->dev,
> +			      "C45 over C22 read access broken due to polling\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	port = otto_emdio_phy_to_port(bus, phy_id);
>  	if (port < 0)
>  		return port;

[ ... ]

> @@ -463,11 +470,18 @@ static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
>  	int ret, port;
>  
> +	if (regnum == MII_MMD_CTRL || regnum == MII_MMD_DATA) {
> +		dev_warn_once(&bus->dev,
> +			      "C45 over C22 write access broken due to polling\n");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: Medium]
Does this filter reject more than the C45 over C22 indirection?

The mii_bus ->read/->write ABI in include/linux/phy.h only passes
(addr, regnum), so otto_emdio_read_c22() and otto_emdio_write_c22() have no
way to tell an MMD indirection sequence from a plain access to C22 register
13/14. The check keys purely on the register number, so every access to
0x0d/0x0e is denied.

Two Clause 22 Realtek PHYs use register 14 as an ordinary vendor register,
and both entries in realtek_drvs explicitly declare no MMD support:

drivers/net/phy/realtek/realtek_main.c:
	static int rtl8211b_suspend(struct phy_device *phydev)
	{
		phy_write(phydev, MII_MMD_DATA, BIT(9));

		return genphy_suspend(phydev);
	}

	static int rtl8211b_resume(struct phy_device *phydev)
	{
		phy_write(phydev, MII_MMD_DATA, 0);

		return genphy_resume(phydev);
	}

	PHY_ID_MATCH_EXACT(0x001cc910),
	.name		= "RTL8211 Gigabit Ethernet",
	.config_aneg	= rtl8211_config_aneg,
	.read_mmd	= &genphy_read_mmd_unsupported,
	.write_mmd	= &genphy_write_mmd_unsupported,

and rtl8211_config_aneg() does the same for its forced-100Mbit quirk:

		phy_write(phydev, 0x17, 0x2138);
		phy_write(phydev, 0x0e, 0x0260);

Both callers discard the phy_write() return value. On a bus that is not
classified as native C45, otto_emdio_probe_one() installs these accessors:

	} else {
		bus->read = otto_emdio_read_c22;
		bus->write = otto_emdio_write_c22;
	}

so rtl8211b_suspend() -> phy_write() -> mdiobus_write() ->
otto_emdio_write_c22() now returns -EOPNOTSUPP before touching hardware,
the RTL8211B power-down bit is never programmed, suspend still reports
success through genphy_suspend(), and the bus prints "C45 over C22 write
access broken due to polling" even though no MMD access took place.

The C22 bus filter added later in the series by "net: mdio:
realtek-rtl9300: Add page tracking" only checks
phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID), which RTL8211
(0x001cc910) and RTL8211B (0x001cc912) both match, so these PHYs are not
excluded.

Does this also break direct register access to 0x0d/0x0e from userspace via
SIOCGMIIREG/SIOCSMIIREG, which reaches phy_mii_ioctl() ->
mdiobus_read()/mdiobus_write() with no MMD emulation involved?

Would it work to scope the rejection to the actual C22 MMD emulation path,
or to express it as a bus level "no MMD over C22" capability that phylib can
consult, instead of filtering two register numbers in the bus accessors?

>  	port = otto_emdio_phy_to_port(bus, phy_id);
>  	if (port < 0)
>  		return port;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
