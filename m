Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E91D6195;
	Tue,  5 May 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984847; cv=none; b=lfCEWCrU21YB0FzNf1Pd53t7Jv5y8CYkquOniU1GEMIDf8Drb9Dvm83l7ZvcZt7l0j0D/QS8ihUPsXwIrGCzlhFfnEDKCw91sN+skVSRjDrtcDed5uKpNlJauVMds/Djldr+lxaB4aJvb0q/j+JzGDHFUHMmtGLv6U0qHEKn2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984847; c=relaxed/simple;
	bh=K8L7WIKpsjJ91+3xOkY5vTa75RDi6FNDiux6p4f79lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiW/HichozNUBD3irCzg7lIZxMvrRR1zUky7j938qiYOwlaM5J1U172j+DcpWcYrLdXjpGZXFTHlAyWrSkAS1HbFlJDNbDh/LerwTcUTuTmkY1kfm4DfzEwT4dBH7cwxGLuJI9cJlRyFHbHkoAA08J5vfthLGc9/x10JrvnEoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZozmNDX8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZozmNDX8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UbyOZg6Hh1OfXJ6bRRxQ9sOlBdTbc4Q/OeSme3KICKU=; b=ZozmNDX8oUxG0AaBbWBuFduXkH
	2DiEJNbZzOrCvyWYna5usa77IPvGl24RksyFYiQJHlyEz6xnQ0ybjLAO6s1v0KXhcoIo32vuH7ixv
	4bChq12vdU2fCKLsD8gwcMRP1ZihzOtuAhdVjW+tbscqOR7bONBSZ4GEqI/Qu61UGQRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKF4o-001SSI-GE; Tue, 05 May 2026 14:40:38 +0200
Date: Tue, 5 May 2026 14:40:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Add support for TX/RX channel interrupt
Message-ID: <c2996d3f-a8b8-4d70-9b2b-c800aac323c0@lunn.ch>
References: <20260505024459.22463-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505024459.22463-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Mon, May 04, 2026 at 07:44:59PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Enable TX/RX channel interrupt registration for MAC that interrupts CPU
> through shared peripheral interrupt (SPI).

Please take a read on https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject line needs to indicate the tree.

>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	char irq_name[9];
> +	int i;
> +	int irq;
>  	int ret;

Reverse Christmas Tree.

    Andrew

---
pw-bot: cr
