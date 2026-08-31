Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C63CA4A0
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163096; cv=none; b=hrXdU+EgCEKnw8S09zxDwfJmocsYiO+eckmwfL5ASBhr+Bx6oDH/OOKQ6N/PrXwDaUBXtD2QCzotTpCD2jW/AZ1by6hkzcp5YG7dEjr062SsXmWHrpWcdY9s6Hum28+P0Hqr7feATcuW0qHTmvbPNRcAL8v+9r+RIL6yFBN+NO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163096; c=relaxed/simple;
	bh=37YmUB7kCLpCQqZ3xhzBSW2BShNha+mVLfWiFHNoP9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUeKAhNQ3Kd6yZtmrKpWFoewBcK7jK7arp9t/MmQwE4uK0tu8onBielTJegTeTOYLcV68AFVuCOZB61eTKy12aQconmq2PQD4u/tkY2UKys1OE25hyYBTQ9Umpcd69ecUlLroGz/yV1b1aC0bFu0kxj3dZlCX7I6AEvZa64lkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ENPj6KeO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ENPj6KeO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D84134E4145B;
	Mon, 31 Aug 2026 07:58:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D64B601E1;
	Mon, 31 Aug 2026 07:58:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1340211C78A30;
	Mon, 31 Aug 2026 09:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788163088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7RAemltuAV1gSJHQNed+UIyNm0UBNUbsZllSmtUWhy4=;
	b=ENPj6KeO6SymV2EO6xJ0xoX0KTbU07fjsB3twLHH0yUT0He5ZLYp5LJ4YONQZZ4zQha5/R
	h7yIntfBkz33nCsyNqZM+HbKQ6b8njiNroW92XDaA8ZJPtgmvdOQkLbAJO4fs7IskIyAMA
	eOqT28cgcri+PK3uEGYs/O6yrdAEKoxbXuoSYPzQqDpwH+9iNpALaCgwBQQGhFuAbnQRVA
	yhHEr/QUu3WnQuZqk+crCMFseNeO+0eJ76QH7YIoPeZyH9q9Jd7WhDy8zVOieFVMNMgMm9
	7wKQelmiSq1O/tkAaB06X6VjQCk83HrUxJ1tjIM3f/As3CnO2OVD5eusq0tEgw==
Message-ID: <9f6b5db7-b791-4a28-8ba8-fb2fd971ae7c@bootlin.com>
Date: Mon, 31 Aug 2026 09:58:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/6] net: phy: split phy_probe() error paths
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 andrew@lunn.ch, kuba@kernel.org
Cc: hkallweit1@gmail.com, chleroy@kernel.org, qingfang.deng@siflower.com.cn,
 hao.guan@siflower.com.cn, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
 <20260823035600.188864-2-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260823035600.188864-2-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/23/26 05:55, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() uses one cleanup path for failures at every initialization
> stage. This runs cleanup for resources that have not been initialized.
> 
> After a successful probe and remove, phy_led_triggers_unregister() can
> leave phy_num_led_triggers non-zero after freeing the trigger array. If a
> subsequent probe fails before LED trigger registration, the common error
> path calls phy_led_triggers_unregister() with a NULL array and stale count,
> causing a NULL dereference.
> 
> Split the cleanup by initialization stage so each failure path unwinds only
> the resources that may have been initialized. Unregister LED triggers
> before releasing the SFP upstream and ports, because the LED triggers are
> initialized after those resources and must be unwound first.
> 
> Fixes: c8dbdc6e380e ("net: phy: register phy led_triggers during probe to avoid AB-BA deadlock")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phy_device.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..2cf70471ae089 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3706,7 +3706,7 @@ static int phy_probe(struct device *dev)
>  	if (phydev->drv->probe) {
>  		err = phydev->drv->probe(phydev);
>  		if (err)
> -			goto out;
> +			goto out_reset;
>  	}
>  
>  	phy_disable_interrupts(phydev);
> @@ -3727,7 +3727,7 @@ static int phy_probe(struct device *dev)
>  		err = genphy_read_abilities(phydev);
>  
>  	if (err)
> -		goto out;
> +		goto out_reset;
>  
>  	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>  			       phydev->supported))
> @@ -3744,7 +3744,7 @@ static int phy_probe(struct device *dev)
>  
>  	err = phy_setup_ports(phydev);
>  	if (err)
> -		goto out;
> +		goto out_sfp_release;
>  
>  	phy_advertise_supported(phydev);
>  
> @@ -3753,7 +3753,7 @@ static int phy_probe(struct device *dev)
>  	 */
>  	err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
>  	if (err)
> -		goto out;
> +		goto out_sfp_release;
>  
>  	/* Get the EEE modes we want to prohibit. */
>  	of_set_phy_eee_broken(phydev);
> @@ -3806,20 +3806,22 @@ static int phy_probe(struct device *dev)
>  	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev)) {
>  		err = of_phy_leds(phydev);
>  		if (err)
> -			goto out;
> +			goto out_unreg_led_triggers;
>  	}
>  
>  	return 0;
>  
> -out:
> +out_unreg_led_triggers:
> +	if (!phydev->is_on_sfp_module)
> +		phy_led_triggers_unregister(phydev);
> +
> +out_sfp_release:
>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;
>  
>  	phy_cleanup_ports(phydev);
>  
> -	if (!phydev->is_on_sfp_module)
> -		phy_led_triggers_unregister(phydev);
> -
> +out_reset:
>  	/* Re-assert the reset signal on error */
>  	phy_device_reset(phydev, 1);
>  

