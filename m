Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332333C1412;
	Thu, 10 Sep 2026 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020796; cv=none; b=Cdbbn/N81Zr2ksBt41qoFwm7PUb+ZMJP6ZLFvFp4uMaiHWcNH5jovLk0blzlxGU35cE1A6UWVQVOloREKY2tybI0NBy/xdapnRyk9uU97p6wHfi77Q5kmMFxMNpYyEju/M0khFgSxlNmEDU5NJXdpg0YEU7nshMJ6U8SnyQ1xyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020796; c=relaxed/simple;
	bh=AvynD0BnRA8yFU7izqYnWJydCBcM4nkfFxErdVeNSi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb4K/x1CbBZImrHba/dGedQdvPBpBmt8i3xEU7hCFTm2cKkuL0dcAMcmY9yY/4hidAx0llaIRe65oZj/jCjEON/I6816C9bFLuP8yDRcXA1lwTmXxErNww++o252vYNHJ/wiRGlm8wcghLCyB10e7hEpT19aTW9SqjFlJsgM8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=AXjx859f; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="AXjx859f"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87A5B3FD91A;
	Thu, 10 Sep 2026 08:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789020777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=L4wB1QYwi0iuakONjjW3MYAY6XW1sNub4WuonJ/8I3E=;
	b=AXjx859fYzPXthIfMssQwNFMKK2QBvjDlX7RstLkZivfKuuyKQYsvAzQdCDHm+pIx2wOIK
	vd3yHuXAJfQIftacSw5No4K4DGL3iHlVawNh3oNl9IUJ6ufyUMkFqUXEcFav9LJE0CS8df
	GH1h7Qmm9a4FoVe+cTakY1NvBRaMsNevhyHXCROaPkQ/dLdyuxJfGbspEJas+TuOOonvqn
	+NAXS35BzNH7KJr32GSdJNwvXYiAQQOsfDtoGgM4FgwfuGfO01FckfvUwJ0+3h39m3hOqX
	USGFyFoaNlpPM44D/1h9w8+AJ0x1Mxf2U/YjTvFXpSkdjTVM7ig5G7wiNadQFQ==
Message-ID: <f1c898c4-2a84-41e8-ad8d-8c79df3feb47@cjdns.fr>
Date: Thu, 10 Sep 2026 08:12:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <aqHlfmYa249e3HRM@makrotopia.org>
 <7a3479c8-45cc-4b88-b111-c35d59f370e1@cjdns.fr>
 <aqIOGgVujIKT7H2H@makrotopia.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <aqIOGgVujIKT7H2H@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 10/09/2026 03:55, Daniel Golle wrote:
> On Thu, Sep 10, 2026 at 01:26:14AM +0200, Caleb James DeLisle wrote:
>> On 10/09/2026 01:02, Daniel Golle wrote:
>>> On Wed, Sep 09, 2026 at 09:32:50PM +0000, Caleb James DeLisle wrote:
>>>> The EcoNet EN751221 multi-chip module implementation of the MT7530
>>>> requires some additional configuration of the PHYs on startup.
>>>> The reason for this is not known, but it is possible that it has
>>>> to do with the fact that the EN751221 MCM implementation of the
>>>> MT7530 runs at an abnormal PLL frequency (362.5Mhz).
>>>>
>>>> Detect whether the MT7530 PHY is attached to the MDIO bus of an
>>>> EcoNet EN751221 switch and if so, apply the necessary register
>>>> updates.
>>>>
>>>> Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>>>> Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
>>>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>>>> ---
>>>>    drivers/net/phy/mediatek/mtk-ge.c | 61 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
>>>> index 73d9b72f9d9e..42b06c40d703 100644
>>>> --- a/drivers/net/phy/mediatek/mtk-ge.c
>>>> +++ b/drivers/net/phy/mediatek/mtk-ge.c
>>>> [...]
>>>>    static int mt7530_phy_config_init(struct phy_device *phydev)
>>>>    {
>>>> +	int ret;
>>>> +
>>>> +	if (mt7530_phy_is_en751221_companion(phydev)) {
>>> Please introduce a `.match_phy_device` operation for both, actual
>>> MT7530 and EN751221, similar eg. to `ksz8051_match_phy_device` in
>>> micrel.c.
>> Sounds good, since this will certainly collide with
>> https://lore.kernel.org/netdev/20260827065930.2618729-2-cjd@cjdns.fr/ would
>> you prefer them in the same patch, or as a patch set? If you'd like I can do
>> this and the FE phy as a common patch set. Let me know what you prefer.
> I'd do it one driver at a time, starting with mtk-ge.c, already adding
> the .match_phy_device logic so it would also avoid binding the MT7530
> driver to an ECONET_FEPHY.
>
> The econet-fe-soc.c driver is much larger and may require more rounds
> to make all bots and humans happy, so I'd not have the independently
> useful mtk-ge.c changes depend on that.
Good point, so I can make mtk-ge so it won't interfere with "any future 
FE PHY with the same ID" with the understanding that this PHY is moving 
along at it's own pace.
>
> Dumping the PHY register space and comparing it with MT7530 could also
> help to indentify any better way than relying on the parent DT
> compatible which *is* a bit of a stretch (but could well be
> unavoidable, of course).

I'll give it a shot but I have low confidence in it because AFAIK this 
is actually a real MT7530 MCM just like MT7621 but it just happens to be 
clocked to a weird PLL frequency.


Thanks,

Caleb

>
