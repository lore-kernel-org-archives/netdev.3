Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6A339719;
	Wed, 22 Jul 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746522; cv=none; b=itqGV/PzI7JAuA8O/2FrpezvjBqnPQZuX+VKBZQ5jqZ9uBRsHdnPypoqrc3Qjl6AB0P3w88MFDrwpM3UaGgcyaYjce2/qPpdVnv23MhECPchkxf8prEMDzgEFQCj+utWmlq89WgsNgDYp6/klF310GB6gVOLoCB5SuM+qEvAt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746522; c=relaxed/simple;
	bh=wBPR01weQAKYgxAQ6hyM6O+jrseXqzNcFbMjfoAfUwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyDQWNG4p7IPCGdx/u7XWQp7O/2rtOsF12Bit+ETmYkIHBkMyPUb1LGNCnCe0P1755TZYTiNsDSK1SskjtqVBru5hUQCzgmnAM943t9nU5VqidI0RP/gzAn9U2zzeDHXea6RwTXx98FJfQcss5/+AqExXdVBQvssehkJfStylRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=07Ifc+Lz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="07Ifc+Lz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IRRf4RjqprLBFyO/CvewMlu3Q3CmE1RtwRPVTHJwe0c=; b=07Ifc+Lza9CeFNxbP7V/ipqP++
	vq/U44sADFSncZIYU1vC7nEVjs4NCoUeNz+KC+874i9yFqLTrol+gv+vajYOl8soiwZwUZ4iFD/Nn
	WAXwYqAk+mrx1Z5RwtRI0YErxntozcLKzJRfJz6qZh/e1bYPnVe9aljgSUgG6DR/QLSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmc5z-00DgBF-4V; Wed, 22 Jul 2026 20:55:07 +0200
Date: Wed, 22 Jul 2026 20:55:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/8] net: mdio: realtek-rtl9300: Add page
 tracking
Message-ID: <71452233-8325-4db1-9c32-cb85d3396217@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722062356.12291-6-markus.stockhausen@gmx.de>

On Wed, Jul 22, 2026 at 08:23:53AM +0200, Markus Stockhausen wrote:
> The hardware polling unit of the Realtek switches has a very special
> handling for PHY register 31 (aka Realtek page register) in place.
> 
> - On the RTL838x it is permanently reset to zero.
> - On other devices there is some magic saving/restoring (aka parking)
>   in the background in place.
> 
> This makes access to PHYs a gamble.
> 
> As of now all known existing hardware designs have Realtek PHYs for 1G
> connectivity. Otherwise the polling engine and the MAC status update
> will not work at all and the vendor SDK would fail totally.
> 
> This driver differentiates clearly between C22 and C45 buses. During
> probing it enables only one of the protocols for a bus. So it is safe
> to assume that any C22 access will only target a Realtek based 1G PHY.
> For safety reasons block any non-Realtek PHY on a C22 bus.
> 
> Intercept access to register 31 and handle it internally. Store the
> desired value for each port in the driver. When issuing hardware access
> to other registers add the page to the command towards the controller.
> This given, the hardware will run two consecutive c22 commands that are
> not interrupted by polling.
> 
>   ... hardware poll ...
>   phy_write(phy, 31, page)
>   phy_write(phy, reg, value)
>   ... hardware poll ...
> 
> Remark! To keep this simple, writes to register 31 are only accepted if
> they are lower than the device specific raw page - 0..4094/8190.
> Otherwise -EINVAL is returned. Under the above assumption (Only 1G
> Realtek PHYs on c22 bus) this is no limitation.

I still think this is the wrong fix, and it is very specific to
Realtek PHYs. There have been comments from other about boards using
Non Realtek PHYs, and they can have their page registers somewhere
else.

I still think you should be disabling polling when the mdio bus lock
is taken, and re-enabled when the lock is released. That should also
fix C45 over C22.

    Andrew
