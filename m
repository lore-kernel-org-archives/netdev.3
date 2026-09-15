Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0848033F;
	Tue, 15 Sep 2026 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470227; cv=none; b=jLrZRs2787oJvfCS4FMZzWFjh80izLfT4pKXaKXEmG571s9WwxwHwNnU5gFVA4ssx9S7Ll+KzZ30VqTQve6Ht5l7mG+8AaezEM/1J3a3joxwIgz5OeIJgPb0DPoKfuRZcMVmEqf6NvpHTJfonm7GM19MxzUYc06eqx2GWBCyztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470227; c=relaxed/simple;
	bh=kp3aOz2uaT55aw10BBKmos2jKIkgPSfnGB35meM+4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOe73KlQ//hgeUHk0YrxRZIV6MTx79XkZkvqUni4uSkSs2+fb3cXU8uC895hfLlQ+0EFxF32I8hle2fo+Iw6c0E/VjM0z2muWAlP+0VDlAUWYzFoFCWLh07bgR9omVULQNiVFaDZ0ilOCk5Rs48C2XZPZa34WnQ+jJqrPCWIFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=eP8h4pFn; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="eP8h4pFn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1B0B47BBCA;
	Tue, 15 Sep 2026 13:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789470221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Rnkxr64g+I2fSWzS6Bo7IoB17S09s16i9qGmZBObXS0=;
	b=eP8h4pFnk5dbf0sYuxS+ADkZ8G9V7ecD8zIcJSD2NQQKtKMD97pIJWjMRB9IP3uK+NyTDd
	Mv9RoSpzS1tLlbxyvNf8eZ+w2q7dn4/RmoFrbbUuTE1ZqQ+oLot2Mib7Fp4etj60yuRX2m
	UYXaGH/UQt4wSvQ7524dDbPQ/KFo8djG0OiKf3U+VLaRC0FCiKI2vpgZ8yRtOQtl8GxsP/
	IfHT/3NC4o+ZKffgZa8vGROZJXoHCjwOZowewD5XJIGUG08gchETNUj9uBjgEnZQzD09qp
	HMoItiLIrFYLAU/Y98sKlRsPp7C7RFrj86HfoN5U3PSqOsBMdQ8EK26gD82PYA==
Message-ID: <63125030-a3b5-432b-b62d-9264946a1a3a@cjdns.fr>
Date: Tue, 15 Sep 2026 13:03:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260915103550.79957-1-cjd@cjdns.fr>
 <aqkilcQAs-GERF3x@makrotopia.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <aqkilcQAs-GERF3x@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 15/09/2026 12:48, Daniel Golle wrote:
> On Tue, Sep 15, 2026 at 10:35:50AM +0000, Caleb James DeLisle wrote:
>> The EcoNet EN751221 multi-chip module implementation of the MT7530
>> requires some additional configuration of the PHYs on startup.
>> The reason for this is not known, but it is possible that it has
>> to do with the fact that the EN751221 MCM implementation of the
>> MT7530 runs at an abnormal PLL frequency (362.5Mhz).
>>
>> Detect whether the MT7530 PHY is attached to the MDIO bus of an
>> EcoNet EN751221 switch and if so, apply the necessary register
>> updates. Additionally, never attempt to configure an MT7530
>> identified PHY which does not have gigabit support because the same
>> ID is used for another (FE) PHY.
>>
>> Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>> Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> [...]
>> +static bool en751221_is_mcm_phy(struct phy_device *phydev)
>> +{
>> +	struct device *parent = phydev->mdio.bus->parent;
>> +
>> +	return parent && parent->of_node &&
>> +	       of_device_is_compatible(parent->of_node, "econet,en751221");
> I thought you had found better options than using the parent of_node...?


I documented my findings re registers that are different, but I don't 
have any documentation of those registers so to me they might as well be 
reading outside air temperature, so there is nothing I could safely do 
except the parent of_node.


>
>> +}
>> +
>> +/*
>> + * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
>> + * does not advertise ESTATUS_1000_TFULL.
>> + */
>> +static int mt7530_phy_match(struct phy_device *phydev,
>> +			    const struct phy_driver *phydrv)
>> +{
> You miss the check for the PHY ID, see also below.
>
> I'd suggest something like
> 	int ret;
>
> 	ret = genphy_match_phy_device(phydev, phydrv);
> 	if (!ret)
> 		return 0;
>
>> +	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&
> The above should be helper function used by both .match_phy_device ops.


Sounds good.


>
>> +		!en751221_is_mcm_phy(phydev);
>> +}
>> +
>> +static int en751221_phy_match(struct phy_device *phydev,
>> +			      const struct phy_driver *phydrv)
>> +{
>> +	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&
>> +		en751221_is_mcm_phy(phydev);
>> +}
>> +
>>   static int mt7531_phy_config_init(struct phy_device *phydev)
>>   {
>>   	mtk_gephy_config_init(phydev);
>> @@ -135,6 +195,23 @@ static struct phy_driver mtk_gephy_driver[] = {
>>   		 */
>>   		.config_intr	= genphy_no_config_intr,
>>   		.handle_interrupt = genphy_handle_interrupt_no_ack,
>> +		.match_phy_device = mt7530_phy_match,
>> +		.suspend	= genphy_suspend,
>> +		.resume		= genphy_resume,
>> +		.read_page	= mtk_phy_read_page,
>> +		.write_page	= mtk_phy_write_page,
>> +	},
>> +	{
>> +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
> This assigns phy_id and phy_id_mask, which are used by
> genphy_match_phy_device(). However, you are setting a .match_phy_device
> op which doesn't call genphy_match_phy_device(), so this is ignored.


I see, I should have checked that more closely. Thanks, will fix.


Caleb

>
>> +		.name		= "EcoNet EN751221 MCM PHY",
>> +		.probe		= mt7530_phy_probe,
>> +		.config_init	= en751221_mcm_phy_config_init,
>> +		/* Interrupts are handled by the switch, not the PHY
>> +		 * itself.
>> +		 */
>> +		.config_intr	= genphy_no_config_intr,
>> +		.handle_interrupt = genphy_handle_interrupt_no_ack,
>> +		.match_phy_device = en751221_phy_match,
>>   		.suspend	= genphy_suspend,
>>   		.resume		= genphy_resume,
>>   		.read_page	= mtk_phy_read_page,
>> -- 
>> 2.39.5
>>
