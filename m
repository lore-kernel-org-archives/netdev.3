Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5540099A;
	Thu,  3 Sep 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420205; cv=none; b=C5WX9nb/1jK1yPxJ/90Gam+tvGvvPVYwxqhHMIcBUh761phwWh7SJt7CO0Fg3jBVrr/2cONhbG5beNwiL0SZVTGGIhGnxMh6PvgCpv1p8klXy3Mixhc47ac2owcF0kxLb9OMXZCr7coYoHsryT7fECIxmzt05Fyp3AQnSsPrY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420205; c=relaxed/simple;
	bh=PmLrccq8IhxPWRywUDxGxtMghIX+/bItCDm/z6h7mL4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BORtE7dqp7CS8exVhEt5ncCrETt1I0CkZdD0Mq5otyFP+DIODytEGnctbr0nm0Sss6Vw7K8AGEnraunt3/vbt2Y+PzsPVMBZ2s12MXtFiI+FWjVJPMxqYenYuts1NmQENpWHMUt6SMvVGUBuE2i/DwoOyGSCGQG4jv9SfBc0P80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ouzCEmtQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ouzCEmtQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7DFAA0060;
	Thu,  3 Sep 2026 09:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788420188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rrfWfrf5SPhny2X5+HufihjWGML4cOhOCBn6YsbnO+0=;
	b=ouzCEmtQIqTtcI/9fhvu+8TBLCsJyxojPtjQ5bmig2z4haDu2ToOSX0biF52NFFPuzZA/Y
	5IHyfuYrKi9+8XZfYI5dRTpriSwp7aKjMgJFTU0otePNGyHQM1eOTMsLKnD5c5ubsu0l0k
	Su/he0LKmfSvimd56Pa2nEsZVfVOCvdyWvg7jt2+C2KVA3zgoxuxfEcVDNRkkLD1mLgi+Y
	NaTMfcx5tn/qAh4/+sqq70/5+/U3RaERW9W5ZByXEg99bHAazWGJ/auyIGUUzj2C0UUYGZ
	axaxcsxOY8zXKLk1DbY+SzUqr8Ns82cyUcEFv5bdAGUt4zClsEw2+7mtkaxwbg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 09:23:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with fixed-link
In-Reply-To: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
Message-ID: <febc4b0932422a2e67f64599dd520e0d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vineeth

On 2.9.2026 12:28, Vineeth Karumanchi wrote:
> When the device tree describes a fixed-link and has no "mdio" child
> node, macb_mii_init() returns early without allocating the MDIO bus,
> leaving bp->mii_bus as NULL.
> 
> Two cleanup paths then dereference this NULL bus:
> 
> 1. On driver unbind, macb_remove() unconditionally calls
>    mdiobus_unregister(bp->mii_bus), which oopses:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000000004a8
>   pc : mdiobus_unregister+0x14/0xa4
>   lr : macb_remove+0x38/0xa4
>   Call trace:
>    mdiobus_unregister+0x14/0xa4 (P)
>    macb_remove+0x38/0xa4
>    platform_remove+0x20/0x30
>    device_release_driver_internal+0x1c8/0x224
>    unbind_store+0xb4/0xbc
> 
> 2. On the probe error path in macb_probe(), reached when
>    macb_mii_init() has succeeded but a subsequent step fails, the
>    err_out_unregister_mdio label runs the same unconditional cleanup.
> 
> mdiobus_unregister() and mdiobus_free() do not guard against a NULL
> bus, so guard the calls in both macb_remove() and the probe error
> path.
> 
> Fixes: d0c3601f2c4e ("net: macb: Avoid 20s boot delay by skipping MDIO 
> bus registration for fixed-link PHY")
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 76ee4f506033..88eebe187eac 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5971,8 +5971,10 @@ static int macb_probe(struct platform_device 
> *pdev)
>  	macb_free_tieoff(bp);
> 
>  err_out_unregister_mdio:
> -	mdiobus_unregister(bp->mii_bus);
> -	mdiobus_free(bp->mii_bus);
> +	if (bp->mii_bus) {
> +		mdiobus_unregister(bp->mii_bus);
> +		mdiobus_free(bp->mii_bus);
> +	}
> 
>  err_out_phy_exit:
>  	phy_exit(bp->phy);
> @@ -6001,8 +6003,10 @@ static void macb_remove(struct platform_device 
> *pdev)
>  		unregister_netdev(netdev);
>  		macb_free_tieoff(bp);
>  		phy_exit(bp->phy);
> -		mdiobus_unregister(bp->mii_bus);
> -		mdiobus_free(bp->mii_bus);
> +		if (bp->mii_bus) {
> +			mdiobus_unregister(bp->mii_bus);
> +			mdiobus_free(bp->mii_bus);
> +		}

nit: replica of the code from above, but also not really worth a helper?

> 
>  		device_set_wakeup_enable(&bp->pdev->dev, 0);
>  		cancel_delayed_work_sync(&bp->tx_lpi_work);

Anyway:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
