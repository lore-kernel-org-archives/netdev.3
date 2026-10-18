Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9D3932DC;
	Sun, 18 Oct 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351338; cv=none; b=vC6YjTa+Hx48SEJ9YIXIJIV/HzoQ96cy8YmlQ5UCdb+sNyvnOx1qZecux0+jWggqrm0npz/ZHF4oPKJkOxPXnPttkS/nEaBMTF+Stze8xSnEHoEYjx9gzbAcWS84Pud+jAu3Z1l7WP9gEsQd59KlG28uE2tdSoJuFkb4Tkvppbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351338; c=relaxed/simple;
	bh=HROzpZDx/9mqgR/5soR1hb0Crk0RLbo/zNA1oFPbphM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIj0vWOtevBlEsZHLvVMJQ0A8XrqU3geO24Vk9Jd4fwy+oh5RZZuOcyUk3AdfN3mmAY7kIjbVd1aE3RBZG8TmcqLD22iGm8e6m26qBqC92USapFgTNgpsDIZ9mvgXQjQUTO2dcgkGqKXZxRSwGzStibMqIKDFScrmQTho1pEqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SB8Ctd/G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SB8Ctd/G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6xyR3TFbtCZTEsIcrD0uhG7nsXMg8JWVx1j3NCjbApU=; b=SB8Ctd/Gzn42zoAwCQw2l0QQUO
	EF3CF5aZ/ymjsFOKXM70oJtkNxhhx0ah+FBZq9alW1YpHFsnFw+7CYKbiKFtE51mUsVPG2+slqDF8
	kYL5UfAGy4CNGbuuIWhGWMovS7u2ZGmOQUs9bnNjjvI1csCMecpMVqlFTywr9hmRct6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIWSQ-00BWMb-Jh; Sun, 18 Oct 2026 21:22:10 +0200
Date: Sun, 18 Oct 2026 21:22:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: pxa168_eth: quiesce the interface before
 releasing resources
Message-ID: <213a4f8d-2473-4973-b203-1c0998256539@lunn.ch>
References: <179229523656.3967907.9986872484125740449.pxa168-eth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179229523656.3967907.9986872484125740449.pxa168-eth@gmail.com>

> @@ -1528,18 +1529,21 @@ static void pxa168_eth_remove(struct platform_device *pdev)
>  	struct net_device *dev = platform_get_drvdata(pdev);
>  	struct pxa168_eth_private *pep = netdev_priv(dev);
>  
> -	cancel_work_sync(&pep->tx_timeout_task);
> +	disable_work_sync(&pep->tx_timeout_task);
> +	rtnl_lock();
> +	dev_close(dev);
> +	if (dev->phydev)
> +		phy_disconnect(dev->phydev);
> +	unregister_netdevice(dev);
> +	rtnl_unlock();
> +

pxa168_eth_remove() should be the opposite of pxa168_eth_probe.

phy_connect_direct() is not called in probe, so phy_diconnect() should
not be called in remove.

Please fix this correctly, not make the code worse. Look at the
architecture, and fix the broken architecture.

    Andrew

---
pw-bot: cr
