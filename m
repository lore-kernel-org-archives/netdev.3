Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118B200110;
	Wed, 19 Aug 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146546; cv=none; b=ISAaApsW4aZnAVUELGo+6XtOIeSSJ5xMdEkbgSOD+OvUy1pOZ2rvb0ir3r+8dHsAc7ogtkdJsgr69slXdkwtccsycbyLEFFiEwCHuXZY6AqZvGGUODdmXlQdm4O7vekGWEP7Y1nEeexMDTxXKAySleuimSarzGEMHnYXl+9Ye7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146546; c=relaxed/simple;
	bh=NtvARxzy/PFYvwtwmouoCSKLYqIkW/jdV6CvBR22/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpnQEf4Lb8p8ACYpmoU+Q5P3cetgLfAfiow9izNjHe7uM3GlBwDG0SHF58SRMaUhYHDKmYAwrMEpDSi//vbwrpoUKZ49t5FUyIucEGfnUq3TCctBkcYpAA6osxb2F6C8NwiusmKjIEDeaHlgkXb4ieBhnmUgY+e5ywelLSPPynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4lU+ipUt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4lU+ipUt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m+iKqbGyiwywG74M6O4TubtxPmzGH9/bw9N45GKvSqw=; b=4lU+ipUtEEnuKb8EZNf4cVSKH7
	8uNSJICAFejf+67N3hXOmJ8wb5CsN8raZKVqhGv3nsDwFXkCb187fECIbIv2NDByQBNbrJ37Ryrz8
	m8SITx95j/eXF1M4Otw9OXm033tA3YSBHnb6ztTwa+/rMgr/rr18fyNJZ7WnNxfvyK80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwgS6-000c3b-NK; Wed, 19 Aug 2026 15:35:34 +0200
Date: Wed, 19 Aug 2026 15:35:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 1/5] net: phy: split phy_probe() error paths
Message-ID: <f1fb446a-eb3f-40c7-baaa-62ae961cd28a@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819060236.24665-2-xuanqiang.luo@linux.dev>

On Wed, Aug 19, 2026 at 02:02:32PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() uses one cleanup path for failures at every initialization
> stage. This runs cleanup for resources that have not been initialized.
> 
> Split the cleanup by initialization stage so each failure path unwinds
> only the resources that may have been initialized.


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

It would be nice to mention this reorder in the commit message. The
commit message is about "Why?". Explain why the order has been
changed.
	
    Andrew

---
pw-bot: cr
