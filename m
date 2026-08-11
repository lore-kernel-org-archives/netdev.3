Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B145412BEB;
	Tue, 11 Aug 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467654; cv=none; b=shWZajcU+hugYzDPxao4XO404n9Q90HP5E2fgj165uaujl17aN9FWKDMDgW2aViXJY4jPjbYNAlqPb1mK1qm/cH39kQLItsRRKXa7KEmfaM0lqXaOhqndMbQfdrhiQMxJQ0DSSQpMkKQnXO/ZsVgmeNLptgK0EmNc0WZ13LQD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467654; c=relaxed/simple;
	bh=VWe5e35+3iya4Ome5baAxdPlz3J4KZHUSSRnBuN00QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWwCLDW0zx5RPGMOQBltgPuFffz9VGLHpJaAejllSnq/AkehMMBDU9ZDzL8wFRp7MnioiSeX3JBkQ0KOx5w3eY2+pPaVukgB3flTTVQeaQ1escJPRus0kHbsuk5+FwzyvHKMuKbXdrhyAtWT9v3MHQfGFSizsp7a8THtCLQN7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g2BeTUvi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g2BeTUvi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KO+GQvTpU4Dc3+Qb0U26Z5L427UcMiAqmtgW7rmBTdc=; b=g2BeTUvik9NjlHPterAuR2rOUg
	egfqQJPDxuvzH/9QEOFqEtCqi7zfx+0Mr4nEq7o7uAYfDH6MeoDDctIvbAigkRTTK87j/Z/GbZiQI
	HYbwFkacDo0f93SMBoZLxhfIWs8i6bLNnDJyahrwknChr8kZews9SFEZn/iPJT8Wfcz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtpqC-00H82l-Aq; Tue, 11 Aug 2026 19:00:40 +0200
Date: Tue, 11 Aug 2026 19:00:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: phucduc.bui@gmail.com
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xilinx: axienet: Propagate errors from optional IRQ
 lookup
Message-ID: <81a38486-d4d8-4ca2-8d22-d3d178c17665@lunn.ch>
References: <20260811034715.6034-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811034715.6034-1-phucduc.bui@gmail.com>

On Tue, Aug 11, 2026 at 10:47:15AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available, while other errors should be propagated.
> 
> Propagate all error codes returned by platform_get_irq_optional() other
> than -ENXIO.
> 
> Another call to platform_get_irq_optional() in the same function already
> handles the return value this way. Apply the same error handling to this
> call site for consistency.

> @@ -3047,7 +3051,7 @@ static int axienet_probe(struct platform_device *pdev)
>  		ndev->ethtool_ops = &axienet_ethtool_ops;
>  	}
>  	/* Check for Ethernet core IRQ (optional) */
> -	if (lp->eth_irq <= 0)
> +	if (lp->eth_irq < 0)
>  		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");

What has this change got to do with what is described in the commit
message? If you think this is a needed change, please put it in a
commit of its own, with a good commit message.

	Andrew
