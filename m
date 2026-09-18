Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8239CD0B;
	Fri, 18 Sep 2026 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698347; cv=none; b=qGM+zpEXDo9GLNJjWAVFpYO6DHzsZN8wv7k/NXQWXydelhbhEOwNBnHzJ+AthQoRlXQcoQ5m1XFRf3c3/gMMKuwpZGm/hLfIsQcXPsz18uzZvoLCrqzAd/OuLelElwKVljj521VXhWw6O9HnYMvAWtRtD0Au5BxbrRm9Rrcmnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698347; c=relaxed/simple;
	bh=rnBDPcGlj+LrAnuJz05A7DBaULFm86bRQJ8vu89HduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnAFeaDlU3aYRMytKcDYQXsv02eozReEClY0fqi5hKvlkilTdoqRAmneLwL+s3aIpSL4o0cLJiXyhABeZRcF6ZEfbk1PsIKCqokl4TLgkPdFlgruvOrlhxiLg5Rp/WQIzDA9rZT85GMFAihBSwZ+UR3NVXmnIiAWHwq4NJ52Azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0I4Od2P7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0I4Od2P7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x8K01hB9IqojhMRbfuKM/v1NjQHIp8XOxCYzKeUDVEY=; b=0I4Od2P71Pb5TnrRdr40GJaEgQ
	TAgGQRxwXvSWBVB5Xoch+LXg5QPggOi0cDcuaaYnS8npdLv8DitZIpqjkRzLrzqOOwR2FyePsqC7K
	mLVxQUn6rGk4svREL2jJZkjdJB+o+2nXWum2iVsP9wl4FTIRyLXBkStFiOb8FwGaSMEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7OIA-005mqx-SV; Fri, 18 Sep 2026 04:25:34 +0200
Date: Fri, 18 Sep 2026 04:25:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] net: gemini: Free the shared queue after removing the
 ports
Message-ID: <e544a2bc-79ed-4067-9be8-59453d25acb3@lunn.ch>
References: <20260917192835.58126-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917192835.58126-1-mhun512@gmail.com>

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/ethernet/cortina/gemini.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 4c762229ce42..e493d495f2ef 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2364,7 +2364,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
>  		unregister_netdev(port->netdev);
>  	}
>  	clk_disable_unprepare(port->pclk);
> -	geth_cleanup_freeq(port->geth);
>  }
>  
>  static void gemini_ethernet_init(struct gemini_ethernet *geth)
> @@ -2656,7 +2655,10 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> -	geth_cleanup_freeq(geth);
> +	devm_of_platform_depopulate(&pdev->dev);

This seems wrong. If you have to call devm_of_platform_depopulate()
why are you using devm?

> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> +	if (geth->freeq_ring)
> +		geth_cleanup_freeq(geth);

gemini_ethernet_remove() is supposed to do the opposite of
gemini_ethernet_probe(). What is the opposite of geth_cleanup_freeq()?
Where is it called in gemini_ethernet_probe()?

	Andrew
