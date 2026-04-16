Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB33921F8;
	Thu, 16 Apr 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383333; cv=none; b=nWAVvfuGK87HjAK94Zcx1qt2KUH5M90+k3wvcEDrV3wzkOIcGMukPhYAnbluuK1OqrlJwwm/TstElZsA+fGk6Rf7fy1Mlf07UfmI0lwwXZEf/uMk/TdgCdd346hjv6TMBCZLVCetvEMivghp/EeVzL9+wGiAB6RoRLlfJhz3R6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383333; c=relaxed/simple;
	bh=qNBK/oqee9+mmlZCa7+hpHr3gGDZscCoq05JJavGoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzvD0jWU43utDn32tKB4hIAQ8CkP9W4vJVnTmCVXVAUFZJRKSxqJcQcP6AffzrUXspQKxg1hkdaA8l6fxKfp2jBEzIwM8uRU1jvEKVViXfN0PfpHT0WWGhYK8RY5j0TRV1yKEY21SQ8awAiANkoVsgZ/AehV7di+ziWXU+/n+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tApcygfG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tApcygfG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5ZQv3olGBte44Jp1M3VTf3sehsASkNuW6HrltX8AqXY=; b=tApcygfGpskbSEmxVHYXQW9ndU
	LK0qO1TDW3N8vJJG0z0cQQfutD37IFaQRqRTTmGh1OD4oHmNyj4di6UFIvsjI9T2Q5oHcX/BdUoTG
	qnxou6/Kvewct1cnbyMQfCD5x+CVOpLfmLgVeFMsRHXLlDd3CJVEPhYQLedTeiIMWrMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDWRq-00GLW1-O9; Fri, 17 Apr 2026 01:48:38 +0200
Date: Fri, 17 Apr 2026 01:48:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <49138791-0726-4065-a772-56fea43070b7@lunn.ch>
References: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
 <1873b5ba-419f-4247-ab92-1b5e899458e8@lunn.ch>
 <aeFam/KxhZSMl6xq@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeFam/KxhZSMl6xq@devvm29614.prn0.facebook.com>

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index e3ca5fcfabef..2a6a73393732 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -818,7 +818,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>  	netif_tx_stop_all_queues(netdev);
>  
>  	if (fbnic_phylink_create(netdev)) {
> -		fbnic_netdev_free(fbd);
> +		free_netdev(netdev);
> +		fbd->netdev = NULL;

Why set it to NULL? Setting pointers to NULL like this often suggests
you are not confident the code is correct and you are being
defensive. It is better to review the code and be sure it does the
correct thing.

>  		return NULL;
>  	}
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> index 09c5225111be..50240e6c2ee9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
> @@ -237,6 +237,7 @@ int fbnic_phylink_create(struct net_device *netdev)
>  		dev_err(netdev->dev.parent,
>  			"Failed to create Phylink interface, err: %d\n", err);
>  		xpcs_destroy_pcs(pcs);
> +		fbn->pcs = NULL;

Why set it to NULL? If it failed, you are unwinding and about to fail
the probe. Nothing should be using it.

I would also say fbnic_phylink_destroy() is wrong or at least whoever
wrote it is not confident in there own code. It should only be called
if fbnic_phylink_create() was successful, so you know fbn->pcs is
valid, so there is no need to test it. The same for fbn->phylink.

       Andrew
