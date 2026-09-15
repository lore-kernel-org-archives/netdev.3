Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888223B05AB;
	Tue, 15 Sep 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466145; cv=none; b=HtNoSVFAzwJ6vBQYv3PBcrQieKOBxb6LzwvZzWw9Q9/y+UOO1JyLXE3LIM4RXmG8m7aRlDv5TpvOwdkqd/A7VkkOF16Vv/x22HdVa+OVKBL78X8EqU8N0vX6k0ERVDjRlfBmCPlhdd6AEasLrwH7yP4jl1OQlEWSJKkwGREttwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466145; c=relaxed/simple;
	bh=L79TMq96hJzDyDNBjc94HUUSTaOHkWkP81NwGDtzHGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMT7x7kR4QHc+v20XfC46vmx2S13YXHopIMqhKMNsi/UY3hFa70nscymV1L6RtAhbhOJDTGugzDDg69i/RjWdtkNPYonXyNHDqB/awaKIyUZBiddy0UK5KgYifQlDgVls3VbG4MX7+vPCGIGTvC0Bd2cl5mPQeSfIen5BliveA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=E56no6bX; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="E56no6bX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8132D476D79;
	Tue, 15 Sep 2026 11:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789466133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Fi/dRVXiXBIot4v5nHDQZH3qjk6CazAUgLOp7/ZEMyo=;
	b=E56no6bXvfvfWeTMftV4PVj1DAjuMK7Xn6M1Q0ejyA1aBMsTX7kyxZyUIf60GgdKtarDIr
	Lvq35rb+5Ux3RhtOABB5GVzoihOvmMoAe5VoKVQ/lVJ+xmVxOEjOtAYKeMb5/ZSgkFjwWf
	jWrrXxjJGKdwO2WlLfVoVdeR6w0yKV3NLC4DC+3rd6jLYLxOXnm9HvV3DXqUkA7550gqNK
	Hnrxopx2C0jqER04Ykkof8osavGCNW2vuBd8jgIsb1iRV4a4d7V4KdjS7RO7t+eLZt0nTe
	cG1eFDCyEUs0td27/oGO17hkHL8LOP8gydXTivMlxy6lZvbAVxFZez0KJDBfdQ==
Message-ID: <c560a70b-8ccf-415a-ba8f-0c061a9f6b03@cjdns.fr>
Date: Tue, 15 Sep 2026 11:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260911120646.4123877-1-cjd@cjdns.fr>
 <a6e1bb7f-e395-434e-8e9b-992141969d74@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <a6e1bb7f-e395-434e-8e9b-992141969d74@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 14/09/2026 14:01, Andrew Lunn wrote:
>> + * The EcoNet EN751221 "G" multi-chip module MT7530 requires additional PHY
>> + * configuration.
>> + */
>> +static int en751221_mcm_phy_config_init(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = genphy_soft_reset(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Master/Slave negotiation does not work reliably */
>> +	ret = phy_write(phydev, MII_CTRL1000, ADVERTISE_1000FULL |
>> +			CTL1000_ENABLE_MASTER | CTL1000_PREFER_MASTER |
>> +			CTL1000_AS_MASTER);
> Is it sufficiently broken that we should stop the user changing it?


Well I must be going crazy because I tested this a second time and now 
it's working without forcing master at all. I guess when I was 
previously testing, I must have had some un-resetted state leftover from 
trying with EEE enabled. I will re-send without this command because it 
seems to work.


Thanks,

Caleb


>
>       ethtool     -s     devname    [speed N]    [lanes N]    [duplex half|full]
>              [port tp|aui|bnc|mii] [mdix auto|on|off]  [autoneg on|off]  [adver‐
>              tise N[/M]  |  advertise mode  on|off  ...]  [phyad N] [xcvr inter‐
>              nal|external]        [wol N[/M]         | wol p|u|m|b|a|g|s|f|d...]
>              [sopass xx:yy:zz:aa:bb:cc]      [master-slave preferred-master|pre‐
>              ferred-slave|forced-master|forced-slave]   [msglvl   N[/M] |    ms‐
>              glvl type on|off ...]
>
> You don't appear to have a config_aneg, so genphy_config_aneg() will
> be used, which calls genphy_setup_master_slave.
>
>     Andrew
>
