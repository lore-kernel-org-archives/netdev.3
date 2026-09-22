Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EA211466;
	Tue, 22 Sep 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108418; cv=none; b=kgi4XP24fgkHCJj33c3iwvHAcnLWFyFXvauMBAJHvU6n5qBfIihWCwmCvliEw7JMHr4O9FWhzNUnyzeRfIAqMdpMpOU48T+fyT9WDl5TcRyFj7SocSBITk9qjJO6XHzl0/8j647j6xHOT7fMDOEPg8eYMJO1f8ZkGIpJnxxy2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108418; c=relaxed/simple;
	bh=dSTxe0P2RFcrntDBINonI5bRhj5di+X+eiadrSk8Rb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srMOuIwII464B7/sheuR+ikZjgQ/uhLWD3ANh8yIfMBR5BkybDvfKaGRn7SegtBZrSMc3Z1LAqQVcDbfu3R8VEAQbqg8olbNNh6Bw2g3Q6OOhyX8aF5Dyn5LRjNAvhDLUzi+VSYaH4Ucgc5eJVQWu02pF5rsuZolZ3ek47E/uuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2TFLe/IS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2TFLe/IS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uqKfszrxLM+TbLTPaUPKkfX5s0W4Y6GnxNMoUScpMa4=; b=2TFLe/ISMZWxiSdSezgecCfyMH
	WFLV2+PEG06sypfcsHAfJePlmF3Hwh0ogu6ENy+Er3GAUw+SToeLtIbJxs3Z64Fq0hQr2Uqobsg0y
	WuB5BCLD97qNeXumyUGUKjDLxS2yu6d4DsM7iFbOL6fLYKlyFuF1K0LOxcyXnwEjLx9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x96xb-006fKs-RH; Tue, 22 Sep 2026 22:19:27 +0200
Date: Tue, 22 Sep 2026 22:19:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
Message-ID: <640a7c34-38d2-48a9-a647-9298318f7c8e@lunn.ch>
References: <20260920192632.72729-2-jan@3e8.eu>
 <b4a42595-295e-456b-82a0-91076f72407d@lunn.ch>
 <64e712bb-4c2a-4738-9f99-7c8496e2d4d9@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e712bb-4c2a-4738-9f99-7c8496e2d4d9@3e8.eu>

> If bit 0 of register 0x75f3 on MMD 30 is set, reading any register on MMD 30
> except for the actual SerDes registers (and also registers 5/6) breaks the
> PHY.

[Goes and looks at 802.3, clause 45]

> I would really like to have a general fix for cases where neither of these
> two workarounds happen to already be in place. But I'm not sure how this
> could be done cleanly, as it requires special handling for these PHYs in the
> function that reads the PHY ID (or even before that).

I assume this PHY does have a valid ID in MMD 1-29?

> Downstream in OpenWrt, I added a patch for "get_phy_c45_ids" to avoid
> reading MMD 30 from RTL8221B PHYs based on the PHY ID in MMD 1:

This suggests it does.

I wounder if we can make use of:

	if ((devs_in_pkg & 0x1fffffff) == 0x1fffffff) {
		/* If mostly Fs, there is no device there, then let's probe
		 * MMD 0, as some 10G PHYs have zero Devices In package,
		 * e.g. Cortina CS4315/CS4340 PHY.
		 */
		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, &devs_in_pkg);
		if (phy_reg < 0)
			return -EIO;

		/* no device there, let's get out of here */
		if ((devs_in_pkg & 0x1fffffff) == 0x1fffffff)
			return -ENODEV;
	}

I assume this is not hit for this device?

I _guess_ there are ~0 PHYs which probe based on ID values in
MDIO_MMD_VEND1 or MDIO_MMD_VEND2. So maybe move the code looking for
device present in MDIO_MMD_VEND1 or MDIO_MMD_VEND2 inside this clause?
Then in the normal case we never look in these registers.

If we don't look to see if the MDIO_MMD_VEND1 or MDIO_MMD_VEND2
devices are present, i assume the next loop:

	/* Now probe Device Identifiers for each device present. */
	for (i = 1; i < num_ids; i++) {
		if (!(devs_in_pkg & (1 << i)))
			continue;

will also leave them alone?

But if there is an oddball PHY around which relies on MDIO_MMD_VEND1
or MDIO_MMD_VEND2 IDs, we still look there, if we failed to find
anything anywhere else, and so hopefully it does not cause a
regression?

	Andrew
