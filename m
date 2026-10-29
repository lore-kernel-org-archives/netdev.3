Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294639;
	b=ThBoYgDdcwExkwVoaDimegQaXfuc8yKPZvtmNXB0sQ3Ne/irQVA2elrtB1tfA1Y60Iyt
	 Vs0ABbNAmx1P81/J/8bG4pkpWvleTPe78iuhcpxVzdNVtRTc6/zKn11wRok7MO4pd91dW
	 pRwXLyefbmf47xpqb3iSGPAHjhv3h43EiOn0hSeM8m+RHGigQd5aoWHBmhig/oLP/AIJr
	 DAyuLaV6g7CvPuwoJZMxPgwGcq38Yx52k7Kt+APnD1L2uBiIEzwlbbR88yGHHVUduLVk+
	 vdvAYBtcvMR4NVWikUZk0v5jzuPzaS2UiWHNfh2BN3BJUM3iog17CFf5I9YOgkvicEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kDOYEDypZwZQvak6poIdRizAekLUNGBFX3LN2eRVDcU=;
	b=hEkTR3W1jyut4DA9zHRTfTUXXjIQcRsKHNgpu4sb85ftp99aIyJf0gOYKmf0xjskITEV
	 dOthg+wXTas+seHvnjWY4Obe6lQLA/7BCCYyH9uw0UE6Sd91fi+rxLvW+1p7dUXRJWxnk
	 6xUDqUr/zldJU52/2vz11KU2suhWZmcBJIWp9CAKVTs5a4getehswmSRYGpFGg2Fymg2x
	 NXgd5US45flJe7DktYys6/bNMyodyB9ZYy1cClOsNTXECGOm1xlhPOGRUAPWlt53/7lXQ
	 i+25EWnm6v7yK5STSivS/dumywMN9wuUEpL0/JPA0UKhLSxILNz8/yyAL+VUsaFB0kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XUrrV0Xg;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6C606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XUrrV0Xg
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so642792a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294638; x=1793899438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDOYEDypZwZQvak6poIdRizAekLUNGBFX3LN2eRVDcU=;
        b=XUrrV0XgCwb6DIMhoQZ1+DIjsS5tP74/bl3g3LFluCRlh1hmrBW3QmxOjEPrmqEmvP
         RrVkqDp0aixBRtdtQZkGDMTryt5cXGLViw+OC6ckWhBStpeT44up24n0KEyi9W4LXZO4
         lzJBGqSV8MsKcczDJoPmtEJC47YglRWYwt45QXDmfjoDQABQ9ZA96NDwRRvoNF2H4uFs
         oRmJE92Mi3EuRIUFmug1Dppv3plLfRqvCmbrMZaZBeowoD5G0cOpBR6wQBoYmz70AUMk
         CdzhmGfdzROHHtb1Rtr+0LfK2L93TZHwH6Cu8LHimLeIxSheK+KvlBA55029G/3dq0yW
         ct8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294638; x=1793899438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDOYEDypZwZQvak6poIdRizAekLUNGBFX3LN2eRVDcU=;
        b=Y0yeOx3Sem2b1g3X+1KNcFDfTLNnWkYjTCMQBGGYjzNylxgQdKIvsSMFfPfjDSra+6
         FPBzzSXp3hQ4/fah/hngaVVmDVREkFbT2TrBIFEnWYPzEbuTTameuXKWt4yfpPDvWKkX
         lFprdBqauQG0h+M87bgw/r7mqGSdbnC8JoVTuPdSJbxZ2JeFL2Ivpr11HJP2/JFg5LDP
         TVwwMqJ4bYydw6vkBlSVtLpUro9DO3b9jbvEVF0iVHKkbZGMJcUZ8UkI3K8ldmiNSaph
         tpJP1ATHaQZfGwSeHZVOew7mgEuoeWq3z5dUUwub7wXAMF2K0yThK3geERY8nmxmJXWW
         R7EA==
X-Gm-Message-State: AFq9FYLun7/EToXMNJmYxRqsxsXIgog9kG8oXixHiWC2ouPtiIVBrYF/
	DjCGoeIqVSQhMqvDmn8SxX3BZ3HtNZZuFKFjVo3ZQKfPucDt594KmZfj
X-Gm-Gg: AYBFou0aZd/x0i0oqhApZFrUIm4k/MnQVPNjCpEz2uqH/gxrOZCoWrVlTCiIXwcTOD8
	wEZch/a9q7K7ZPijue4dJwtRFwjX751VJCuPfczyaz4URyroYWZXtenAbMk5WPrd+wr0WBysU5w
	fetqtS1F+iwhp7atFXMb8UqNoqaKfPmS+hH8q7b/CS1X6UkR9uXEAehLprG1YE6d2MDuTzhIk30
	NuxtbrbzovWQ5WjzzZ7k5lpic9ezjC70HRALbQFnSLb7E6bBKhtl1liuVfV5u/9Hwf6qyuKPWgM
	QIP5VdwoVrtCfgpReM1hnbdU2z3RyuO002jZno2PF9+Vtu8wuhHGbuGS8bj5IR7FRSwv+1aDACO
	NHuLiHzsXVZ6oHrYFbPEPeMq2FW2xKxUWK0ST4Mwb+oLJi8rG8YjgA8oZhEer+rHKbTpxws/qjU
	bGx2fdgCpLBRdm11l26dwk6OanjjcPtViLea9cJ5OLEC41OakDQvc2LiyNF1TFD5zoqRsCDFQSt
	c/BxF8Oi81hAWRuxB4mhx8Ji5IREh5ng79I1uB60rhnuzRT64N/whyl6/n/SYKPKCfrkbpReSir
	Llqo4ACAe5YvQJCfXeGl5EJoG5708mQ3D2tRr5O5DG0nc4OMB4Ji5SBObA==
X-Received: by 2002:a17:90b:2585:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3ae6ed455e9mr2153404a91.22.1793294638096;
        Thu, 29 Oct 2026 10:23:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm5003173a91.13.2026.10.29.10.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:23:56 -0700 (PDT)
Message-ID: <b15c85ea-85b4-4900-b422-07fd629c0b6e@gmail.com>
Date: Thu, 29 Oct 2026 10:23:52 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/11] net: au1000: disconnect the PHY before freeing
 the MDIO bus
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-4-f.fainelli@gmail.com>
 <179329051062.3134.8683202411485629333@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329051062.3134.8683202411485629333@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In drivers/net/ethernet/amd/au1000_eth.c, au1000_remove() now
>    calls phy_disconnect() after unregister_netdev().
> 
> Pre-existing issues:
> - [Low] The two new phy_disconnect() calls (au1000_remove() after
>    unregister_netdev(), and the au1000_probe() err_out path) run without…
> 
> --
> 
> net: au1000: disconnect the PHY before freeing the MDIO bus
> 
> This patch adds phy_disconnect() calls to the au1000_probe() error path
> and to au1000_remove(). This balances the phy_connect() done in
> au1000_mii_probe(). In both paths the disconnect runs before the MDIO bus
> is unregistered.
> 
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index 58bc8e1b539d5..70319b432182f 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
>> @@ -1287,6 +1287,8 @@ static int au1000_probe(struct platform_device *pdev)
>>   	return 0;
>>   
>>   err_out:
>> +	if (dev->phydev)
>> +		phy_disconnect(dev->phydev);
>>   	if (aup->mii_bus)
>>   		mdiobus_unregister(aup->mii_bus);
>>   
> 
> [ ... ]
> 
>> @@ -1334,6 +1336,8 @@ static void au1000_remove(struct platform_device *pdev)
>>   	struct resource *base, *macen;
>>   
>>   	unregister_netdev(dev);
>> +	if (dev->phydev)
>> +		phy_disconnect(dev->phydev);
> 
> [Severity: Medium]
> Can this leave the MAC clocked and out of reset after the driver unbinds?
> 
> By the time au1000_remove() reaches this point, the MAC is already in
> reset with its clock gated, and aup->mac_enabled is 0. If the interface
> was never opened, au1000_probe() did this by calling au1000_reset_mac()
> just before register_netdev(). If the interface was opened,
> au1000_close() did it.
> 
> If the interface was never opened, phydev->suspended is still false,
> because phy_attach_direct() resumed the PHY. In that case phy_disconnect()
> does MDIO accesses:
> 
> phy_disconnect()
>    phy_detach()
>      phy_detach_internal()
>        phy_suspend()
>          genphy_suspend()
>            phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)
> 
> Each of these accesses goes through au1000_mdiobus_read() or
> au1000_mdiobus_write(). Both call au1000_enable_mac(dev, 0) first:
> 
> 	if (force_reset || (!aup->mac_enabled)) {
> 		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
> 		...
> 		writel((MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2
> 				| MAC_EN_CLOCK_ENABLE), aup->enable);
> 		...
> 		aup->mac_enabled = 1;
> 	}
> 
> Nothing later in au1000_remove() calls au1000_reset_mac() again before
> the registers are unmapped and the netdev is freed. Before this patch,
> remove left the MAC in reset with its clock gated.
> 
> The err_out path in au1000_probe() does call au1000_reset_mac(dev) after
> phy_disconnect() and mdiobus_unregister(). Should au1000_remove() also
> call au1000_reset_mac(dev) after phy_disconnect(), to match it?
> 
> [Severity: Low]
> This is a pre-existing issue, not one introduced by this patch, but both
> new phy_disconnect() calls run without RTNL held. In au1000_remove(),
> unregister_netdev() has already dropped RTNL. au1000_probe() never takes
> it.
> 
> phy_disconnect()->phy_detach()->phy_detach_internal() does:
> 
> 		hwprov = rtnl_dereference(dev->hwprov);
> 
> With CONFIG_PROVE_RCU enabled, could this emit a one-time "suspicious
> rcu_dereference_protected() usage" warning? The read itself looks
> harmless, since au1000 never installs a hwtstamp provider.
> 
> Other drivers already call phy_disconnect() after unregister_netdev()
> without RTNL, for example r6040_remove_one(), et131x_pci_remove(),
> bgmac_enet_remove(), mlxbf_gige_remove(), hisi_femac_drv_remove() and
> ixp4xx_eth_remove(). So this looks like a problem with the phylib
> annotation, not with this driver.
> 
>>   	mdiobus_unregister(aup->mii_bus);
>>   	mdiobus_free(aup->mii_bus);
>>
> 

Agreed. PHY teardown can re-enable the MAC through MDIO accesses. I’ll 
update patch #3 to call au1000_reset_mac() after MDIO bus teardown, 
matching the probe error path.

The RTNL annotation concern appears to be a separate phylib issue shared 
by other drivers.

pw-bot: cr
-- 
Florian
