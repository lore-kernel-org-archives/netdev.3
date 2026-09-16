Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A43812DA;
	Wed, 16 Sep 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563522; cv=none; b=MT+CTqUnVWvXLgzyzl5ASC2B8ZYiRamMUH5yTbrnI2Z6yOp5GRNzH5QkvsL4mrxJ3Xr3kas6NAww7b4UTjvgxHem5kjOEP8oPiROKfP4CF27328X1Kgt6xA3FWOpzQwn92V3ge7HYcGmBm3qXODCm7TbK/TT9mZJ8qKwffaewys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563522; c=relaxed/simple;
	bh=MVDwrdRoGs7U1+TI5rmeNPhvfPkVPX1VtkpZjTciIV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXf6yQXptBMXLKfjUUgwXeXgt2w2MeFvr+SjtUMxmIy3pS0WxxCzTymBNuZyZwAai0NEkU2BPFCeuklAezrY4GOZ2Q9XTHeLxsYSfFwp7pj5OfkUR14l2mjyLGfZomQsnwW46FDLj5FLJ30T9EcDuklL4qjcRz0df2BKN7xf1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mg0pcc7B; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mg0pcc7B"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7444B4E40718;
	Wed, 16 Sep 2026 12:58:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2BA9160337;
	Wed, 16 Sep 2026 12:58:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA4C311C7B026;
	Wed, 16 Sep 2026 14:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789563512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ACT1BcK2mKgNZY0JsO79zzKWzTVjsJHY3lvjP8nZdTE=;
	b=mg0pcc7ByLpO4n0yIIzGsYslxzp3CzZxijRHgtRU9iQ/zr675u+8g2DIyGBO1DZDKpmYmO
	OEcGjZUEK3dhD2llZZhjh6/DLQaOiNdKNJLYzNXe+Ts7tdeXVjD7LfeBhHPDozqn42Dvbq
	VPFeAbR1qDmPfU1Gzgc/UQGD5MWIq/ixcH2yA9Edz4CHxb3hDqHRcTAqmNcm2eYCkye4if
	2bRCtUZ1An7Vk3LlsaxmQXk9PSXYoAnTNwBw49urNnpdyL57ySVOhjYpzU5ghm/MP+PrJk
	74kxz5tUxeQXBNE3U9+RJeBOBhxSd5Gik5LYItYRujgnbbL9c9INU7TpQpWURg==
Message-ID: <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
Date: Wed, 16 Sep 2026 14:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Thomas Karpiniec <tom.karpiniec@outlook.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqI9wOnradk9d7K@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aqqI9wOnradk9d7K@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/16/26 14:17, Mohd Ayaan Anwar wrote:
> On Wed, Sep 16, 2026 at 08:39:50PM +1000, Thomas Karpiniec wrote:
>> From: Thomas Karpiniec <tom@wendy.sh>
>>
>> With a QCA8081 PHY and phy-mode = "2500base-x", stmmac reports only
>> 2500BASE-X in phylink's supported_interfaces. Phylink consequently removes
>> 10/100/1000BASE-T modes from the PHY's advertisement, preventing a link
>> with a gigabit switch.
>>
>> The QCA8081 uses SGMII for lower copper speeds and 2500BASE-X for 2.5Gbps.
>> ETHQOS already reconfigures the SerDes in ethqos_mac_finish_serdes() when
>> the PHY changes interface, but does not advertise this capability.
>>
>> Provide a get_interfaces() callback for serial interfaces. Add SGMII and
>> 2500BASE-X when the SerDes validates them, allowing phylink to retain the
>> corresponding copper link modes. Leave the existing stmmac fallback to
>> the firmware interface in place when no interfaces are reported. RGMII
>> configurations are unchanged.
>>
>> Fixes: 61e9be0efbe8 ("net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode")
>> Cc: stable@vger.kernel.org # 7.1+
>> Assisted-by: LLM sparse
>> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
>> ---
>>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 22 +++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> index ac7d6d3e205a..3493e090f1a8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  // Copyright (c) 2018-19, Linaro Limited
>>  
>> +#include <linux/bitops.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_net.h>
>> @@ -564,6 +565,26 @@ static void ethqos_pcs_set_inband(struct qcom_ethqos *ethqos, bool enable)
>>  	stmmac_pcs_ctrl_ane(priv, enable, 0);
>>  }
>>  
>> +static void ethqos_get_interfaces_serdes(struct stmmac_priv *priv, void *bsp_priv,
>> +					 unsigned long *interfaces)
>> +{
>> +	struct qcom_ethqos *ethqos = bsp_priv;
>> +
>> +	if (!ethqos->serdes_phy)
>> +		return;
>> +
>> +	/* PHYs such as QCA8081 switch between SGMII and 2500BASE-X with
>> +	 * the negotiated copper speed. mac_finish reconfigures the SerDes
>> +	 * accordingly; let phylink validate all modes that path supports.
>> +	 */
>> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
>> +			  PHY_INTERFACE_MODE_SGMII, NULL))
>> +		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
>> +	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
>> +			  PHY_INTERFACE_MODE_2500BASEX, NULL))
>> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
>> +}
>> +
> 
> So, I had proposed this exact change a while back:
> https://lore.kernel.org/netdev/aMgootkPQ%2FGcdiXX@oss.qualcomm.com/
> 
> As Russell noted, this behaviour is due to the messed-up integrated
> PCS support in STMMAC/QCOM-ETHQOS.
> 
> I would defer to him for this if he's around.

Indeed, but we haven't heard from him in a while, let's see if we can
figure this out. 

Does this IP have an integrated PCS ? (i.e. dma_cap.pcs is set)
you can check that in debugfs :

mount -t debugfs none /sys/kernel/debug
cat /sys/kernel/debug/stmmaceth/eth0/dma_cap | grep PCS

if it's Y, then you have the integrated one.

Russell worked hard on that, it looks like a lot of the plumbing went
through.

I think the right approach here is to have the PCS itself report the
list of supported interfaces, instead of relying on the glue. looking
at stmmac_pcs.c :

220 int stmmac_integrated_pcs_init(struct stmmac_priv *priv,                                
221                                const struct stmmac_pcs_info *pcs_info)                  
222 {                                                                                       
223         struct stmmac_pcs *spcs;                                                        
224                                                                                         
225         spcs = devm_kzalloc(priv->device, sizeof(*spcs), GFP_KERNEL);                   
226         if (!spcs)                                                                      
227                 return -ENOMEM;                                                         

[...]
                                                             
246         /* Only allow 2500BASE-X if the SerDes has support. */                          
247         if (priv->plat->flags & STMMAC_FLAG_SERDES_SUPPORTS_2500M)                      
248                 __set_bit(PHY_INTERFACE_MODE_2500BASEX,                                 
249                           spcs->pcs.supported_interfaces);                              
250                                                                                         
251         priv->integrated_pcs = spcs;                                                    
252                                                                                         
253         return 0;                                                                       
254 }        

Can you test settung the STMMAC_FLAG_SERDES_SUPPORTS_2500M flag in
dwmac-qcom-ethqos ?

Maxime

