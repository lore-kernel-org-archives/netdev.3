Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D24407597
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373428; cv=none; b=N6kkDySoexeviTaLnO9k4Q47QO6tIHDmfvjGRBGKHp0OzhQ/1q7kJTHoodsi76JeASuaQ0DDcJWkHDplw0bZ+7JBukUjFg6oEczVAOMxRUuJMSv+fHzHg6YAS9WaKD7JfZGdbXLKuHXWLv8al+SyZzfOimrWSjpGFas5fzDknpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373428; c=relaxed/simple;
	bh=bctH114wEKxwQebJf1yZHMWn95PQzNmODgaIEuiBfNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3NmzglsapIApkdcGEZ57VKd+aYNSjpv/Vfp8/su2MZjrBSf4Rz6lmGWnURB9pNNNJJ1YttRa/oGxa37gSf4RDkSvEjOOBcCGtQc1RALkDIk8HCs1QGI2tWQzqaCZTCb60UvQOPHuT5bYxd7+UJb303cN7C38t+4Gu5F4MdlBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j82U+uVu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j82U+uVu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oKENOD0m0kxQUxTHGijhtN7YgbeBAabG2U3+bWPM9vU=; b=j82U+uVuDzp0sl+OX1rgozBvPI
	Q20Tp64KdsBaArKP9GYtrCEVKiecZXksHi8Ca4sBaClttmZiwOKtXTFYgJBTpEJg4Xf2a8XWdxmbF
	j7dPRL/cSNBlFNDLGWo4JMFSvvoGQ+zr/ZsrFfCRqU7rqt+ZKZZ1YggZJt+pOErR56lU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtRKV-00GwSX-Fh; Mon, 10 Aug 2026 16:50:19 +0200
Date: Mon, 10 Aug 2026 16:50:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v5 4/4] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <57719c88-854b-4c92-956e-a673041b8587@lunn.ch>
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
 <20260810141511.73204-5-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810141511.73204-5-xuanqiang.luo@linux.dev>

On Mon, Aug 10, 2026 at 10:15:11PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> 
> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> removal handling") moved per-bus clock cleanup from module exit to the
> remove path. This leaves two lifetime problems.
> 
> dp83640_clock_get_bus() publishes a newly allocated clock before the
> driver allocates its per-PHY data and registers the PTP clock. If either
> operation fails, no PHY is bound and the remove callback cannot release
> the clock, leaking the clock and the MII bus device reference.
> 
> The remove path can also free a clock after dropping clock_lock. A
> concurrent probe may already have found the clock under
> phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
> a freed mutex and access the freed clock.
> 
> Use the PHY package infrastructure for the per-bus clock. PHY packages
> are tracked per MII bus, and the driver uses BROADCAST_ADDR as the
> package key so the DP83640 PHYs on the same bus share the same clock
> storage. Call phy_package_join() during probe and phy_package_leave() on
> probe errors and in remove.

Ah, i missed BROADCAST_ADDR. Looking at ext_write(), either accesses
are broadcast to all devices on the bus, or to the specific PHYs
address. There is no one address which is special. I was expecting to
see calls to __phy_package_write()/__phy_package_read() but those are
not needed.

Overall, using phy_packages has simplified this driver a lot.

Once you fix your email address, feel free to add Reviewed-by: Andrew
Lunn <andrew@lunn.ch>

    Andrew
