Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAE3BA237;
	Tue, 11 Aug 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462466; cv=none; b=CrYwLmPhECqfGbJhyyKciuWn2FgXGazizcgzesuyq3i8YBuB7puqgmoVeyzdL60mP80FmwTBVVrrLOk7+uwi10CnxLuaUbSaCwP5wzSpQUmYrIxXs2mei8smdyjmWPoD+IXEPQCvupZcK0aSnrjRZhwJLYjons29GZCSdDSLKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462466; c=relaxed/simple;
	bh=J1GIza2wzG6DNTFzsp4c1ZeD7l76L+NiI0Gs3TSJzeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFUfEXaJIw7JVsdupTgWLCY8UXdcdMqBAgx9KA/99eYkUQIypJVFiwto7Hq+9VHX5S0dh6jKWizGIyr/ue5E2CM5aNFS/+UKwJl1e4vOZHwyEJtX9JO7fKjcwTC1EfqKPy4X2xLJ3X1YOkRbuscWI6GLa3Jld9NUrNi/oNmgr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlEf65KJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlEf65KJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB811F00A3A;
	Tue, 11 Aug 2026 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462464;
	bh=FLLxn78u+8+1L7m4Hy+pK/B2niPXFochyMyqpQUziq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NlEf65KJ4XpLGNurN9j8nn2GOJSSfVMpCO9/jZwiID/Wg3+9PudhSLabjYh7IM5Wv
	 ZKH1aarc901hJSRvdg8kScs57A8w3EUsXtkJaJAVg81NGUjDk7t/Or7LCn8O4GH9sL
	 +Y/AgZCm8WWSvT8KcbGkApZOgJJ+l6ATmR5eqrxacLn4XDSViZp/XDqi3tnjfxvh7C
	 14UsUyYsBFVgauUYpbvTeewa9QS2CaV8zgq9gnS1ANVDEBTkQ4wNcNO7wQf4tF+dTA
	 JBc3kJ88y6JxPnR/mPomJY4K974XGnq9OWPa0RM/f6F3uJg9uEibYexElMM+RxmQBh
	 SMg7C8KrVvHjw==
Message-ID: <351d66fd-d904-4305-814c-0c3bda2361c4@kernel.org>
Date: Tue, 11 Aug 2026 10:34:22 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Content-Language: en-US
To: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716021932.20037-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716-monumental-daring-beagle-28e81d@quoll>
 <e3c2a7c5-35d3-4c40-9adb-39e9c8659af8@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <e3c2a7c5-35d3-4c40-9adb-39e9c8659af8@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/26 21:07, Nazle Asmade, Muhammad Nazim Amirul wrote:
> On 16/7/2026 3:56 pm, Krzysztof Kozlowski wrote:
>> On Wed, Jul 15, 2026 at 07:19:32PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
>>> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
>>>
>>> The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
>>> implemented as FPGA soft IP between gmac1 and its PHY. This converter
>>> provides the RGMII TX/RX clock delays, so the MAC interface selector
>>> must be configured for GMII while the PHY is configured without delays.
>>>
>>> Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
>>> and detect it in probe to force GMII for the MAC interface selector and
>>> strip the delay bits from phy_interface so the PHY is not configured to
>>> add delays already provided by the FPGA converter.
>>>
>>> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>> v4: Add Reviewed-by from Andrew Lunn.
>>>
>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> index 1d7f0a57d288..bf591a68502f 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>>> @@ -69,12 +69,13 @@ struct socfpga_dwmac {
>>>    	void __iomem *tse_pcs_base;
>>>    	void __iomem *sgmii_adapter_base;
>>>    	bool f2h_ptp_ref_clk;
>>> +	phy_interface_t mac_interface;
>>>    	const struct socfpga_dwmac_ops *ops;
>>>    };
>>>    
>>>    static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>>>    {
>>> -	return dwmac->plat_dat->phy_interface;
>>> +	return dwmac->mac_interface;
>>>    }
>>>    
>>>    static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
>>> @@ -650,6 +651,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>>>    	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>>>    	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>>>    
>>> +	dwmac->mac_interface = plat_dat->phy_interface;
>>> +
>>> +	if (of_device_is_compatible(pdev->dev.of_node,
>>> +				    "altr,socfpga-stmmac-agilex5-tsn")) {
>>
>> Don't add compatibles around the code. Does not scale. You have driver
>> match data exactly for that purpose.
>>
>>> +		dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
>>> +		if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
>>> +			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
>>> +	}
>>> +
>>>    	ops->setup_plat_dat(dwmac);
>>>    
>>>    	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>>> @@ -674,6 +684,7 @@ static const struct of_device_id socfpga_dwmac_match[] = {
>>>    	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
>>>    	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
>>>    	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
>>> +	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_ops },
>>
>> Otherwise dvices are compatible? They why would you need this entry in
>> the first place?
> Hi Krzysztof,
> 
> Just to confirm: should we add a separate socfpga_agilex5_tsn_ops and
> use that as .data for the TSN compatible, instead of checking the
> compatible string in probe and reusing socfpga_agilex5_ops?
> 
>
I believe that is right way to do it instead of looking for compatibles 
around code.


Dinh
