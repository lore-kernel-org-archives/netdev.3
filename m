Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95D2BE630;
	Fri, 31 Jul 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519590; cv=none; b=PjIVjy5TJMCZdmKVSbVSIsBkgxzH42ReaBb8gGFWzZQFbpl/tSsnHk8r4xdZVn2ztMQERizgZqAqrwFLWCJU9GN3Ycgc9PmtxZf3i1USJG+DssY86NbywQzvXc3JO0pFo/vyLAL2dR8J7lWgxoXiPZiEXaQExQeG5zg0mEx82+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519590; c=relaxed/simple;
	bh=O1PkPGXQpsjL0epDUf+ZkE+58/P4S+AVLCKLs04IQGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nR5S2zaElllQ1q+jq/pfam2Wb0B7LiquM3DpDmmewIO5bGU0QZ4VJyJ57vEo6fNFIUrhaFqhZc2aIkYU6hANiJl2ZBJw7p7dWRK5hA83MzIWsxzMxtPJ6SU8GuRYFAzK0RWwhA4kfI6JDMRe5Okt41/nxBnZ7ori+pvtw3mCR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=F/sQ8X18; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vqJPWZ50; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="F/sQ8X18";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vqJPWZ50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785519584;
	bh=O1PkPGXQpsjL0epDUf+ZkE+58/P4S+AVLCKLs04IQGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/sQ8X18r6oM+Mu275zy1HRqe7sZau+CAzyZcqSdDluRXTe/ozqG10AM3DJRVOqhW
	 tLQOWudtZm/hsP27Yu5tORveFPe0Kgl91IdAR5rwF+5nqwxDUmZjG0mVp0KKV9hme3
	 BJuYm7o1x/d/023fi85x5D8ElsQo8Hlbm4sOPKdpQwBKtMz2KSMhPjaeSmSz9bFe0K
	 z/hWbei9YrXiW5RxE2GVmWOt+ZsrLh238Iw6oWgNC65Pc6r0ssMG5AUBL8DzAZdPSB
	 2juw4WrF1vDhOmJc6DTYm8pC70awcIKlaIZ/AHFplJdScknOG6z10RMGinY+aThHzw
	 bC3MvAIX87GCA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 393A0494F7; Fri, 31 Jul 2026 17:39:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785519583;
	bh=O1PkPGXQpsjL0epDUf+ZkE+58/P4S+AVLCKLs04IQGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vqJPWZ50YJJvJ0Ba+g+040QcTWO4Vp3AjR4DXcFh/4v5b2bUDiXVxXdtESYGWyrUi
	 BJEjg5ppj2XFCAjFjy1A+nFe69p99Rd/bVu9PAQ1pMaIpOXk72B80f9tZEVeIPRWZa
	 0eELXK4/2+yppuI67SOgDLTpwjUh+k7rtjIa30AeNKUGSsN1B9XkWnHUIzoShH5m3a
	 Cl9KkX3ZQfVYfMPjFGgAdgDxxdA/dr3FdQ4z+UTZrTPZ0ylEub6PE6E+X3x7SqqKf3
	 OGWVl+fB93DpZNtLINAm4CDNbp+aS99jlkfPRb36Jmz3dXmvPERqMMYGSvC9/W66W0
	 7QPEziYB8WFfg==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C61FB494ED;
	Fri, 31 Jul 2026 17:39:42 +0000 (UTC)
Message-ID: <774f3866-28f0-4b9d-b127-f53c53fb2dac@birger-koblitz.de>
Date: Fri, 31 Jul 2026 19:39:41 +0200
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
 <7d40cce5-6f82-4c40-8c94-ee674b5d0cfa@birger-koblitz.de>
 <251845b9-e477-4d00-b162-097b92c583a2@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <251845b9-e477-4d00-b162-097b92c583a2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 18:40, Andrew Lunn wrote:
> On Fri, Jul 31, 2026 at 06:14:50PM +0200, Birger Koblitz wrote:
>> On 24/07/2026 19:18, Andrew Lunn wrote:
>>>> +static int asix_ax88279_read_status(struct phy_device *phydev)
>>>> +{
>>>
>>>> +	val = phy_read(phydev, MII_ADVERTISE);
>>>> +	if (val < 0)
>>>> +		return val;
>>>> +
>>>> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>> +			 phydev->advertising, val & AX_ADVERTISE_2500);
>>>
>>> This looks wrong. A PHY driver should configure the hardware to
>>> advertise what is in phydev->advertising. The PHY driver itself should
>>> never change this value, especially in _read_status(). It is up to
>>> user space to decide on what is advertised, and the phylib core will
>>> sanitise the value to ensure it is within the PHYs capabilities.
>>>
>> This looks wrong, because the PHY uses the wrong bit for configuring
>> advertising 2500_FD. Since phylink does not know about this behaviour
>> the PHY driver needs to decipher this additional bit and then set it
>> in advertising based on the value in the PHY register. But maybe
>> I miss something?
> 
> We have two bitmaps.
> 
> phydev->supported lists all the modes the device supports. Generally,
> that is filled out during probe, when genphy_read_abilities() or
> genphy_c45_pma_read_abilities() is called, which looks at register
> values which indicate what the PHY actually supports. If those
> registers are wrong, because it breaks the standard, you can provide a
> .get_features() callback in the PHY driver. That typically calls
> genphy_read_abilities() and/or genphy_c45_pma_read_abilities(), and
> them fixes up what they have discovered to fit what the device really
> does.
> 
> phylink will also mask phydev->supported with what the MAC actually
> supports. So the PHY might indicate it supported 1G Half, but the MAC
> does not, and so it will be removed.
> 
> phydev->supported is then copied into phydev->advertised. The user can
> modify phydev->advertised, but phydev->supported is fixed.
> 
> When the link is configured up, the .config_aneg() driver method is
> called. It needs to push the bits in phydev->advertised into the
> hardware, so it actually advertises those link modes.
> 
> If the hardware is broken and puts the bits in the wrong place, you
> cannot use the helper. So the drive needs to do the interpretation and
> write the correct bits in the registers. Depending on how it is
> broken, you might be able to call genphy_config_aneg() to do
> 10/100/1G, and then do 2.5G manually in the driver.
> 
> The PHY driver should consider phydev->advertised read only.
Thanks for the explanation, Andrew! I think I finally got it.
I was basically doing a short-circuit between read_status() and
config_aneg() using .advertising in order to get the correct
result with the broken use of the 2.5GBit advertising bit.
I will fix both config_aneg() and read_status() in the next
set of patches and stop writing to .advertising in the PHY driver.

Birger

