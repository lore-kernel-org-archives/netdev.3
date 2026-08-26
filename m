Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962547127C;
	Wed, 26 Aug 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762307; cv=none; b=RqIEZbIAg/JSb7TxEmHE1NvGT7+p51IWUjZ2VmNbcTAzatt6k0OOchTrv+KO4jitrVK+CwStti4Eo9n6IjNvmH4T9vkNjIs4A5Tf1dpeMCOpaVunjmuJwu7UmLrOacGPRm6JDj4nze4nd1sxiLqR7ezvZ4n0JcO2kpqfvzHEH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762307; c=relaxed/simple;
	bh=k1dcHYKsEab09wozqZN5BR/ltPN5cma1VRF0Rw9C7sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0NgdTQB4KyopiMOM5FhU9ByWHMDHvfsdfWnpCWCihAhN7knzzHZIwmLa5emVzwqLkK9be+TUY8IMM2GXWGjvn1vkJ/GU0RPwTplOkCrnoiankMBB7HmThpU83nxgsTpC6pO281T9DmT/3kJXOhhluwo6fj9sPpbUzZ8HTV+q5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=fMZ9KW/g; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="fMZ9KW/g"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26C3B1DF2C6;
	Wed, 26 Aug 2026 18:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787762283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=M+7SgzsZ1Y/K6TQ/aEsfofbJUDWnBL25FhcOxsOV1E8=;
	b=fMZ9KW/gnShK5/dxniHckjV8LE+yT7flsBZYhJEr4A3advuFY/ISy6puIFFIxicqzwg9hO
	Mq3IP2Fq5FmqRlUG7fLM2o14sNVHoiznwqg/LgfbnjEIEixvNtgLllNQIHTtPFLIoMQFPv
	VqFQRKb+eKJcdtrJ1tTPMqeKKvs2yT6kaYBSM/HZBgmjnyjy7awj0D1LWdS9vX+t8eu1Hn
	cvU70qZ9/8obpYNFgVcHhc0vuPX7aAfKaMpkxZbdfB0Rv4jNq8EGPCxs4NH9GrzH0G+nzZ
	1AfrTubP4RYdGM5OEtap0NA6546cYQBFv0M9L5bEuFzwsABmpcai9sKzmq1nDw==
Message-ID: <cd7e6b13-a712-43ce-aae6-f45da2f77ba9@cjdns.fr>
Date: Wed, 26 Aug 2026 18:37:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: ansuelsmth@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
 <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
 <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>
 <4d594c62-2ceb-43c1-a3d2-731b80493787@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <4d594c62-2ceb-43c1-a3d2-731b80493787@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 26/08/2026 04:21, Andrew Lunn wrote:
>>> Does this need a change to the binding document?
>>
>> Not as far as I know. econet,en751221-chip-scu is defined in mfd/syscon.yaml
>> because it's a catch-all for configuration that the engineers didn't know
>> what to do with.
> Do you need a property in the PHY node to make this work?


No it's not requiring anything in the PHY node, instead it fishes for 
econet,en751221-chip-scu in the DT. I'm not much a fan of this pattern 
because of the magic, but this way of accessing is fairly common and in 
this case it is how Airoha likes to access the chip-scu thingy when they 
need it. 
https://lore.kernel.org/all/20241112-clk-en7581-syscon-v2-4-8ada5e394ae4@kernel.org/


>
>>>> +static int en751221_gphy_config_init(struct phy_device *phydev)
>>>> +{
>>>> +	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
>>> Why is the EEE register being cleared?
>>
>>  From reading the reference implementation, I get the impression that this
>> hardware is something of a basket case. There was a certain amount of "write
>> three times and then read back" type magic that I just omitted because it
>> really looks like they were actively debugging and as soon as it started
>> working they shipped the code exactly as it was.
>>
>>
>> In the case of disabling EEE, I thought it more prudent to follow them
>> because I don't have every SoC that this PHY ever appeared on and I would
>> rather not diverge too greatly and risk it being unreliable on some devices.
> Is EEE broken? If it is, this is not the correct way to disable
> it. You should call phy_disable_eee(phydev); This will also prevent
> user space enabling it again.


I tested my board removing the EEE disable and the MASTER line, and it 
seems to work. I can't get any CRC errors flooding the link, and 
MII_STAT1000 reads LPA_1000LOCALRXOK | LPA_1000REMRXOK | LPA_1000FULL 
which suggests to me that it's able to operate happily in slave mode.


So unless you or someone else thinks it's inadvisable, I'm inclined to 
just enable these things and then wait to see if anybody finds a board 
that has problems.


Thanks,

Caleb


>
>>>> +	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
>>>> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x00, 0x00002b);
>>>> +	__mtk_tr_write(phydev, 0x1, 0xf, 0x03, 0x082422);
>>>> +	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
>>>> +
>>>> +	ret = phy_write(phydev, MII_CTRL1000,
>>>> +			ADVERTISE_1000FULL | CTL1000_PREFER_MASTER |
>>>> +			CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER);
>>> What does this default to?
>> It starts with only ADVERTISE_1000FULL. I don't know why the engineers
>> wanted to set it to master, but its definitely intentional.
> Generally, switches take the master role, and client take the slave
> role. So this does make sense for a PHY used in a switch.
>
> 	Andrew
>
