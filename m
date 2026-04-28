Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0944429812;
	Tue, 28 Apr 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380009; cv=none; b=N48Z3sq3ohWn6qrz21GaRRPysc/08P+oRIu7o9W6WIps8WksFOyjspCd+386qRVWAlETk9oSwhBpjUY5Ei4DJfcs0YrnD82QAU+8du7NkN1L01G61a82vCLJdIOPq3I4hOkR54amsp6BBJIXqcBL6Xfi66X5Z27fngnL/uTv2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380009; c=relaxed/simple;
	bh=VkJCNXld27ViSk1GksVTuVWmIxaHWW/Vkk8rGBOs4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH5QxyENhAN+UMPwnuETjGwYCGTy65sxsbf6iE0lN70S4e1zUJUBpmheIDWsEgOmP7xB3XJKgXi6R0nETGd9mbH4KdOkt3MNwjKWys/eZt6pIcSQCIO4hidK6a19PanhvU9+fzE22xczXBvbH8byd8iH10Yd9hjpBZZEw56pZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TDIxPIbb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TDIxPIbb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pvn8z6UXcaffCR4fdIvZyFHgKnwPxuriIYucWjCpEUI=; b=TDIxPIbbwvecqNPDEvrALLKohJ
	2MIkNLxxs1XnkCHypSgQ6lUjAkAdjKGEFtC4KqBCSq3Aij5zAtvUPmy0KRayUtEPMcwGiwLoskJq3
	UDntK9eq0Xxy0apPGAbmJTDqN19Bm+HdRoNKTJGmCnJWYjcNwyXnnE7v9ypKAh3CWMAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHhj1-000KhY-Dy; Tue, 28 Apr 2026 14:39:39 +0200
Date: Tue, 28 Apr 2026 14:39:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: bcmasp: handle EPROBE_DEFER for MAC
 retrieval
Message-ID: <6046a450-8db5-45b4-aca3-b84b0826af38@lunn.ch>
References: <20260428014329.779779-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428014329.779779-1-rosenp@gmail.com>

> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -1254,7 +1254,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
>  	struct device *dev = &priv->pdev->dev;
>  	struct bcmasp_intf *intf;
>  	struct net_device *ndev;
> -	int ch, port, ret;
> +	int ch, port, ret = -EINVAL;

That breaks the reverse christmas tree. Otherwise this looks O.K.

    Andrew

---
pw-bot: cr
     
