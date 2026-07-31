Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A843B2D0F;
	Fri, 31 Jul 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514498; cv=none; b=oYUG0C070GbCs39AHSXEKyouB0UQrLMmFcRSTC0hB2oOVek5wHIaBzCvUSQEc7VWh1YGo8nNSHD4QW8O1hMDFIJVLGD2+Gijs4XCKWUlv7PAccHbQX6nGk9PyXaMwsOJH6vkOLfVMSYj//xsMKMBXJx9SOXng6SMeRKBd6p3VVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514498; c=relaxed/simple;
	bh=JAkRTaTRx/kErhr5i5QJ0ZVMOx9oGWgVOYx7W/K5M3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcPyCMz0jU+8d+Zvo1ApCfdSrhIXgP0qSrqvTA8NCqgWZ/Ryz+FVvBop+ZHU5QVvU/h/Fbzem4y7mGiXdcGvQKFd3Fk12tyIerR9gGRqT2pRDuQW701/GMJ+A3p/05NJaJ+jQQy6XaF5SzQwfh6n/RR150SCVeLhkY3+7UVcysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=P/nK5zq5; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JabXCq8C; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="P/nK5zq5";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JabXCq8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514492;
	bh=JAkRTaTRx/kErhr5i5QJ0ZVMOx9oGWgVOYx7W/K5M3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/nK5zq5632bX+p2379bE+ZmqB/TWwyasBHYPP0I2bWOBsJ/2IsdaDCnYwO8HPBEm
	 ddWoxHc/ceuXyThjETrMadUtzO7i+vvzBpMiGWZom6doqbtq2gvX/NqY5N6R37Hhl/
	 wRTAJolfRrFLVZ8YHLR0g1Nks6YcP13pwKVDHL/b8GNezOqRBuqq81PFxC+CnhaSip
	 5JyyxIbhyaqM+WDv0Y7U0MCDus6U66be4pNM7nrjfierfEEHdQ66Gc+4T0AdK1QRE1
	 +CNIMcKYdemFowjXGH9HhZjyQfYDWqDW9BPhvVw7rGFYbxBczmfLbUAjIuSZIWCjk7
	 xDDrWBTPviqOw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5F383494F6; Fri, 31 Jul 2026 16:14:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514491;
	bh=JAkRTaTRx/kErhr5i5QJ0ZVMOx9oGWgVOYx7W/K5M3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JabXCq8CUMXf7hkrLqAh7l9qfru/gy7MI3aVGZSZyA11IY8iNTCHV9Ogl6h/4EFOS
	 OL6dcvNGZNQwzvuduUW/KLAZl7dLU0j/1ddgNuJEzMtSmgLsjtP/A+B6nUiLgsbd4A
	 byrqdrqQtSxELmrxbLLrQ/nV9938WcJBc3/aea/HwBX+FjnH5l0cpnqLAJdxPbTgpj
	 z286EDF8eVGXVDV8GV9nvTYTQm4OS2oTqvbda66vZy91btWYWwSxtU+5P4LNCfVHa6
	 JlxwruAMk5DEtOX0C5si0D7nVg0f7+XA8bx8rbSN3bWLbR3I2DQpKxPGI/zwbL3T1l
	 zk3+bvb+AGoiQ==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 49708494ED;
	Fri, 31 Jul 2026 16:14:51 +0000 (UTC)
Message-ID: <7d40cce5-6f82-4c40-8c94-ee674b5d0cfa@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:14:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>
 <d4f745df-715a-45c9-88a7-337b1dffd2ac@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <d4f745df-715a-45c9-88a7-337b1dffd2ac@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 19:18, Andrew Lunn wrote:
>> +static int asix_ax88279_read_status(struct phy_device *phydev)
>> +{
> 
>> +	val = phy_read(phydev, MII_ADVERTISE);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +			 phydev->advertising, val & AX_ADVERTISE_2500);
> 
> This looks wrong. A PHY driver should configure the hardware to
> advertise what is in phydev->advertising. The PHY driver itself should
> never change this value, especially in _read_status(). It is up to
> user space to decide on what is advertised, and the phylib core will
> sanitise the value to ensure it is within the PHYs capabilities.
> 
This looks wrong, because the PHY uses the wrong bit for configuring
advertising 2500_FD. Since phylink does not know about this behaviour
the PHY driver needs to decipher this additional bit and then set it
in advertising based on the value in the PHY register. But maybe
I miss something?

>> +
>> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
>> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);
> 
> Can genphy_c45_an_config_aneg() be used here?
I tried and it did not work. 2500MBit was always advertised. The
same code is also used in en8811h_config_aneg(), which has some
of the same quirks as the AX88279-PHY.

> 
>> +static int asix_ax88279_get_features(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
>> +
>> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
>> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> 
> I would do this in probe. If you do this early, phylib might be able
> to call genphy_c45_pma_read_abilities() on its own. Maybe, i don't
> know.
  left it there. Putting it into probe did not make phylib do anything
magically on its own. When left by itself in probe() there is
an additional function needed and here it is where one understands what
it is needed for.

> 
>> +	/* AX88279 does not support reported 100baseT-half duplex mode */
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, mask);
>> +	linkmode_andnot(phydev->supported, phydev->supported, mask);
> 
> If you are only changing one bit, it is simpler to use
> linkmode_set_bit()/linkmode_clear_bit()
Fixed in v4.

Birger
