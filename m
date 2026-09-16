Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41E3F1065;
	Wed, 16 Sep 2026 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541284; cv=none; b=hpGT3i1x8R5nzgPPyHPexOC2yR49svMD1m+gP9dsXSu+06nNQ3QElfWzfbfatkiZQK7Ice7GB2AY8+1K1O5h01lYm/evu26KCljlGZkkN1/EbCBOHFOwbzHt+3lC7Te/bfs4rjtfyAIE1g786PKkcRP9C9AzVpZMsVYrfSXV/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541284; c=relaxed/simple;
	bh=/NuyNdwGAP6B87EGLnfIuEHCUMBTUh8tcjbfbMaSbHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnO7tts4i/wkKbhJv6lNW4NH0V4VgFNhKc5t6LbmttxrRKMO/oDUuNnyb6Ose7QmZDtN/Rle+QmkTh3kuaiuWPbbsGZ/tqeOiId+6HEhNz7+WbfALfq7SY0T+EbQZcgnFj6lohHKqhAa3NUtfQU4p15UJ1VHcbiF6fdEmtCup2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GEp3tSpa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GEp3tSpa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BACC5152B;
	Tue, 15 Sep 2026 23:47:52 -0700 (PDT)
Received: from [172.18.224.124] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195A63F86F;
	Tue, 15 Sep 2026 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789541276; bh=/NuyNdwGAP6B87EGLnfIuEHCUMBTUh8tcjbfbMaSbHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GEp3tSpa8XB8QxBd0oa+aNvXs9Wjp9F5h+mc45cc2tPJ/TQ4PzMB72kjHbIaDBAKT
	 u7WRTBkobBSO/RWXjbM3yh1a6bBVxuCM7aJFUZiL2zN9ic950zfUYQHttfNJ67o1Kl
	 EGgI+2sQatABtrP70AjVtaa89ouzZzY6As3vlon0=
Message-ID: <ad2ca583-1562-4d31-8601-fef6da88f694@arm.com>
Date: Wed, 16 Sep 2026 08:47:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: stmmac: dwmac-sun8i: Add Allwinner H616
 EMAC clock index and internal PHY support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alastair D'Silva <alastair@d-silva.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 richard.genoud@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
 <20260916044119.475666-5-alastair@d-silva.org>
 <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/16/26 08:24, Maxime Chevallier wrote:
> Hi,
> 
> On 9/16/26 06:41, Alastair D'Silva wrote:
>> Support EMAC1 and the internal Fast Ethernet PHY (AC300) on Allwinner
>> H616 and H618 SoCs:
>> - Allow reading a register index from the syscon property to offset the
>>    regmap field for EMAC1's dedicated clock control register.
>> - Add emac_variant_h616_internal with support for internal PHY, MII,
>>    RMII, and RGMII modes.
>> - Delay the MAC software reset until sun8i_dwmac_init() when using the
>>    internal PHY, ensuring the PHY has powered on and begun generating
>>    the receive clock before the MAC attempts to reset.
>> - Skip setting H3_EPHY_SELECT for H616 internal EMAC, which does not
>>    use the H3-style EPHY select bit.
>> - Handle -EPROBE_DEFER cleanly during clock and reset control acquisition
>>    in get_ephy_nodes().
>>
>> Assisted-by: LLM
>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> ---
> 
> Even if this is a duplicate some of the work done by James Hilliard, this
> raises interesting points.

I think the point is that this patch is just wrong, in many parts ;-)
I think much of the code stems from the original Allwinner BSP code, 
which is just, say, misinformed in many respects. The use of compatible 
strings, and shoehorning the PHY clock into the MAC code are just 
examples. More below.

>> Notes:
>>      Tested on Mellow Fly-C5 (Allwinner H618) under Armbian, verifying stable
>>      EMAC1 probe, deferred soft reset with the internal AC300 EPHY, and 100M full
>>      duplex operation under load.
>>
>>   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 65 ++++++++++++++++---
>>   1 file changed, 55 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> index 48c52eb96233..1728893589a6 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> @@ -130,6 +130,16 @@ static const struct emac_variant emac_variant_a64 = {
>>   	.tx_delay_max = 7,
>>   };
>>   
>> +static const struct emac_variant emac_variant_h616_internal = {
>> +	.syscon_field = &sun8i_syscon_reg_field,
>> +	.soc_has_internal_phy = true,

For instance this cannot be true. internal_phy refers to the H3 
generation, which works quite differently. We had this issue already 
with the H6, and there is a comment there mentioning this.

And this becomes obvious in other parts of the code, where this patch 
reverts the has_internal_phy tests, because they don't apply here.

>> +	.support_mii = true,
>> +	.support_rmii = true,
>> +	.support_rgmii = true,


>> +	.rx_delay_max = 31,
>> +	.tx_delay_max = 7,
>> +};
> James's series [1] says this SoC only supports RMII (yet includes RGMII timing
> control), and here for seemingly the same device, there's MII and RGMII
> support listed.
> 
> [1] : https://lore.kernel.org/r/20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com
> 
> Maybe you can coordinate with one another, can we connect that SoC to a non-internal PHY ?
> If so, can we use MII, RMII and RGMII ? or is it just RMII ?

This MAC is *only* connected to the AC200/AC300 PHY, which is a separate 
die, but co-packaged into the SoC. So that's set in stone. And while the 
MAC IP might support more MII modes (because it's maybe the same IP as 
the primary MAC? We don't know), it is irrelevant here, since only RMII 
is usable.

Cheers,
Andre

> 
> Maxime

