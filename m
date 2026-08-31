Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC33DC857;
	Mon, 31 Aug 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197302; cv=none; b=CCPil4PicOWg6d9LduiMA84kjHTGyarI7D6MPEZTKdbZF0HyfNLqKR52QrLvk2TqEgc17hq9pyznbrbgZQzgaDoGluzSb9ffJJqmaFL6pZdFCjKBEw/iiKvwqcZQL4gbh2JJ6OkInXFsSNLkQYryPMd/8QqxV/efidDOocxyDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197302; c=relaxed/simple;
	bh=74pdMq0RozvDUAtEQcEuMu2zmd7+AG51xLnJ13HaV4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoA6gvd2iDRFdEw8X6mujZj9fB+pJyqs2rivR0aRLtQyG6jjqr8EXaGCfZ3hEuMRpoJzcK5UmjXUeQlHUH+sxV5FwgnIyDs35qoFh3NpF1AWGBwGL0d1azzzdJy1afwHUTrEX0mQlIix0/F3+3XWSbAopnSTv9LvCMwb+NmrFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NobnzIPx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=V9Cm4j7D; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NobnzIPx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="V9Cm4j7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788197299;
	bh=74pdMq0RozvDUAtEQcEuMu2zmd7+AG51xLnJ13HaV4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NobnzIPxK1IGCHP/Hof2GALf8dqLd4tjZd+RujYhqnd4qHKWFJiP5O8JozR7ydzgo
	 ZmO6ZU3TDSTsIIwghmNMnVy6vD4dXJzUKfNztltinh7TQoMVbGB/muyTDAaCmkhBg4
	 KibxElVFcC0NCCr+XuQWZR5Dq5ZIRhPn0txebso4bXNxKIFo7MOqXfu8JKvaLUYYO1
	 R8wO4chxRxOitlREgZW8h6dmB/F+k0ryYCR0am1aztPBPs3IACijOw84xXDFJjqfy0
	 fR1EowQ/O1Ozad8PNLv0qznQudNs2cLkadeihUVOSQ1g4vuxCRHGQcwQXo7uK3OBDo
	 O4ab5gGta3eYQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 68DBB3ECAC; Mon, 31 Aug 2026 17:28:19 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788197298;
	bh=74pdMq0RozvDUAtEQcEuMu2zmd7+AG51xLnJ13HaV4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V9Cm4j7DA4bSdgmqqKw93qQhQvbu6pCmtbf42ch7oCJjsUiMwUXEuuaJFFdM6blAH
	 05XLDw8PTMQwOpDCbD62dvluTAXqjxwF14VGWvN+p2jsUzOZknoPgri39UrAGTeIN+
	 1GzortwXuf9WvTCLmatp6+fctvwsIbIDgkl4mQtkFwzWcgrjAsLRHSVlkDbXXeDBmm
	 0t3zdhgv1K+D403psTfjYP/KM5UPZpnvvF+UYkDBlwubKRJnF2W554OTaw8TsGUPpg
	 H9Rto601C42mZ3Bbvjkkv0o6mbHWaafAMk+f6v08+Fa4gfyxT6JrORUW8Vk84UkgTP
	 JB7/O4vcqImcg==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5E92B3EC90;
	Mon, 31 Aug 2026 17:28:18 +0000 (UTC)
Message-ID: <e68251a2-defc-44da-bc30-3461e879c1a4@birger-koblitz.de>
Date: Mon, 31 Aug 2026 19:28:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-15-de905f2ee426@birger-koblitz.de>
 <505bb4bf-b910-4642-b4dd-d4b5fee8309d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <505bb4bf-b910-4642-b4dd-d4b5fee8309d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 4:38 pm, Andrew Lunn wrote:
>> +/* AX88179A-based PHYs cannot access MMD registers via MII_MMD_CTRL/MII_MMD_DATA
>> + * Make sure to use c45 access instead.
>> + */
>> +static int asix_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
>> +{
>> +	struct mii_bus *bus = phydev->mdio.bus;
>> +	int addr = phydev->mdio.addr;
>> +
>> +	return __mdiobus_c45_read(bus, addr, devnum, reg);
>> +}
>> +
>> +static int asix_write_mmd(struct phy_device *phydev, int devnum, u16 reg, u16 val)
>> +{
>> +	struct mii_bus *bus = phydev->mdio.bus;
>> +	int addr = phydev->mdio.addr;
>> +
>> +	return __mdiobus_c45_write(bus, addr, devnum, reg, val);
>> +}
> 
> Please see aa63217916e1818a28b711384a9340d965ad073f
> 
>      net: phy: add generic helpers for direct C45 MMD access
>      
>      Some PHYs support direct C45 register access but not C22 indirect MMD
>      access (registers 0xD and 0xE). When discovered via C22, phylib routes
>      MMD access through the indirect path, which won't work on these
>      devices.
>      
>      Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
>      write_mmd callbacks that bypass the C22 indirect path and use the bus
>      C45 accessors directly.
Thanks for pointing this out, Andrew. Will use that helper function
instead in the next round.

Birger
