Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619E1C862D;
	Thu,  6 Aug 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044956; cv=none; b=tWgTFRCC9800Wq/HK7PXg78Xjo07if/PBRfpJJItynO/09we4ZDU6MFM96oPndbiZx/X9dL/hOdEa1ibbzKV7hqvC9vXbVKartZ7gbHZ+z2gAmPW8Bjj/WQs0cOYOMB/pVgOKxCiehy7vxc0JyCk9bnASz11W7W1AyZsvpLz3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044956; c=relaxed/simple;
	bh=iKxn4qTydrWtZASAZozR09mJPNH+tjUJEHHVeM8GViQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtK//ZDU90X0EsFtWAo0zaO8lDIDEOTNtdA2FoKahlcmsmIZkUPyv8syUVyqbkzFgDdySMsuA/yNyPYakHwack7zwM3LMwe1KK9DaYgjlcjePWOIFG0n4DKg4BOGlarPLmJdvCx+NzPluW1YzWwTOCYcVToeJq1k5wtgVKUUXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bdPoz1/F; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=LogfizhD; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bdPoz1/F";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="LogfizhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044953;
	bh=iKxn4qTydrWtZASAZozR09mJPNH+tjUJEHHVeM8GViQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bdPoz1/F+s7vZwcz88cqQ5PAlGhdxlbtvWRsytIgkDbyvukr3YaEQzrHX1EzKLV8M
	 FCn2L5nvKtKfJoFL/5XkZTb98fq/PqJj3BKaA3ntww6sdT5ECrjuoYnEHAnkWXr7gt
	 ufLBSrhSBq3nom/iV9r+76SZcSmq2QNEZNYMLVW53+XizlUSILU6LrOwawxt7G/1Ch
	 SmYYFVKoX3j9sErOSVanNxSQGvEXxjcwbpyO1DnhOTYZawTI3fbum0fiEAzEgxR1VW
	 kQ39qEvY5NhwxMxPVRgs1eoCvbcN1kvCvu+i/10Sd7qdppbxpwBRsU78ZIrfTGjgYf
	 w/BuUqOBI2WZg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 974E1496F9; Thu,  6 Aug 2026 19:35:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044949;
	bh=iKxn4qTydrWtZASAZozR09mJPNH+tjUJEHHVeM8GViQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LogfizhDkW9tynwfLAZ8rCE+GYHy9NLgHxoi19KMmC4BpSFq1fv8WAVua5lott2pa
	 7GubE8iOcn9ox21TZJ4CM5m9kwALiZ6aiZvZJlI25DenFoSW5WstC5XXdJuy/xSMWr
	 k4iBTWsITPGVL3GeAr4BAyojw6HeRMouK+qUSx7b47lOdu8b4JQK+RuSOdL6EvPbGA
	 sLa+0tp7boMMk1KC0T7DVTjE1//xjTT1ENxA7YLfptxC/L+GCLVogWhbX5T7rdOhID
	 j2s/LlCGp8C9+yR2tQomgvgzxYl8pwejnbQ6NNPAciysjcPnHx5WLGQ/YSo1ppnHHC
	 hU388lFnoDzrg==
Received: from [10.30.1.58] (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 916C6496F2;
	Thu,  6 Aug 2026 19:35:49 +0000 (UTC)
Message-ID: <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
Date: Thu, 6 Aug 2026 21:35:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/08/2026 23:55, Andrew Lunn wrote:
>> +static int asix_ax88279_read_status(struct phy_device *phydev)
>> +{
>> +	int ret, val;
>> +
>> +	ret = genphy_update_link(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
>> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
>> +	phydev->speed = SPEED_UNKNOWN;
>> +	phydev->duplex = DUPLEX_UNKNOWN;
>> +	phydev->pause = 0;
>> +	phydev->asym_pause = 0;
>> +	phydev->rate_matching = RATE_MATCH_PAUSE;
>> +
>> +	if (!phydev->link)
>> +		return 0;
>> +
>> +	ret = genphy_read_master_slave(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = genphy_read_lpa(phydev);
>> +	if (ret < 0)
>> +		return ret;
> 
> This looks pretty similar to genphy_read_status(). Can you call that
> here? And then the rest of the code here can deal with higher speeds.
Changed in v5.

> 
>> +	/* Read actual speed from vendor register */
>> +	val = phy_read(phydev, AX_CTRL_STATUS);
>> +	switch (val & AX_CTRL_STATUS_SPEED_MASK) {
>> +	case AX_CTRL_STATUS_SPEED_2500:
>> +		phydev->speed = SPEED_2500;
>> +		break;
>> +	case AX_CTRL_STATUS_SPEED_1000:
>> +		phydev->speed = SPEED_1000;
>> +		break;
>> +	case AX_CTRL_STATUS_SPEED_100:
>> +		phydev->speed = SPEED_100;
>> +		break;
>> +	case AX_CTRL_STATUS_SPEED_10:
>> +		phydev->speed = SPEED_10;
>> +	}
>> +
>> +	/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
>> +	 * the link-partner advertised 2500M if remotely AN succceded
>> +	 * for link speed > 1000M and we locally have a link speed of
>> +	 * 2500M
>> +	 */
>> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
>> +	if (val >= 0 && val & MDIO_AN_10GBT_STAT_REMOK) {
>> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +				 phydev->lp_advertising,
>> +				 phydev->speed == SPEED_2500);
>> +	}
>> +	/* Only supports full duplex */
>> +	phydev->duplex = DUPLEX_FULL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
>> +{
>> +	bool adv_2500;
>> +	int ret;
>> +
>> +	if (phydev->autoneg == AUTONEG_DISABLE) {
>> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
>> +		return -EINVAL;
>> +	}
> 
> Why is that? Now that phylink is driving the PHY, and reporting
> speeds, duplex etc, you should have everything you need to program the
> MAC when the link mode is forced.
> 
I tried forcing the PHY speed in the past, and it does not work.
This is a limitation which is also acknowledged for the suspected underlying PHY
hardware Airoha EN8811H, see the head of air_en8811h.c

Birger


