Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C643A0E8A;
	Wed, 19 Aug 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146690; cv=none; b=hR61UX8B9bUUVFY6/V06aQdywXK1sJu7MXVY/yuk7cCfcnkdGECobMovJFEugUUPIqf8lnvAukwgl4qO29+3TB5vBZykBNhqkAfoP1TTnAta8Sx6WtbaYZNa8LcguqZLVEATeC9VyPPed9svjHtaEVUuO1O4y86OKCFJKNPdmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146690; c=relaxed/simple;
	bh=PxEiiUAUUa7JdqIXI8TEl3h2BObeOV0IB2h/+hE5dHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl8BmtFrgfRt/TJ1R9FwHKYcn7tfDTX/lXAF0vWoZijSjvRGyY/emKofsBNJLTJAU/jv0QVYZh6pNtFSQNTR2AnVkEhFtUZ/Fj1KhfdYcdd9jDdiNvaj1zBkOzYWp6bMQBtKH4/tSbhantaCaRTUcXif9GRoLkGioKz1Izu/Xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UQ2f2BRN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UQ2f2BRN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u8CDghssa0enyEFgZ1PLWUeez22bss1cMicZfSciuFw=; b=UQ2f2BRNPk39dkZm4pe0c1yBE6
	j8IpThnI/on68lxoZjTKD0kwG5bFTCp4WfKq/A+IO7fdBJGSDTugumfhvqB5QFV00y3GDC9Vd1mxZ
	1dvgHqBxTAMYNwt1IVojPhnfIz56bsImP9FafQn2W+cIUAEKadLqXT8TQoMUWHMLfWII=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwgUR-000c5z-OR; Wed, 19 Aug 2026 15:37:59 +0200
Date: Wed, 19 Aug 2026 15:37:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 4/5] net: phy: call driver remove when core
 initialization fails
Message-ID: <135952b1-2cac-4aa3-88c8-6bedff6a0525@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-5-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819060236.24665-5-xuanqiang.luo@linux.dev>

On Wed, Aug 19, 2026 at 02:02:35PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() may fail while querying features or completing other core
> initialization after the PHY driver probe callback has succeeded. The
> driver core does not run the remove path after a probe error, so
> resources that the PHY driver releases in its remove callback are
> leaked.
> 
> Call the PHY driver remove callback on these failures.
> 
> Fixes: efbdfdc29bdd ("net: phy: Add support for asking the PHY its abilities")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
