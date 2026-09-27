Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663438D6BD;
	Sun, 27 Sep 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530283; cv=none; b=nXK1u+ojbEFuUzvRa4JVMEyOUqYK0bhshjthZD9ShxERtD0l1f2FRzMfKTJMC5uTng/ohbgoUgOQ3HoiwpreDbTRCM1na1uLv0FKvYZu9gCYu1hLLZXpEW6SgOio8kudCAZAcw7N6d4QQCN+/xpZKRIrV9QbKQqhxN9/Qiyvo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530283; c=relaxed/simple;
	bh=Kk8kpo1PqgPHDPhWRsfVyIWcZXjVUN0m5ly2wtPGNTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT43RW3L3hbfz4/FCHg1m3GFP+PaAOTDpQxPbjilJtOMfz+CvFSkjv2EBrTsW1l5llD1rchv5WsqGQ3lut0D3fqmlgYSDNrpGL8XYYreOxD6+fiVUOrLXcjAxVTCR3CwE/nP+4blU161Yr1SORaR+iu5BeW7V4LM9yBT5WHHw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4A1VqMvs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4A1VqMvs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c5zU6W8VrHa3l4R+nP0T1w8sBnr7AVif8fZhvos4Zc0=; b=4A1VqMvsLTga0uB2MUe5Lw6+Vi
	suOVX7Vm6pYXUqpdm0Jyj+P9YsiPrBCbWwJJo5Xzfhs6Yfa8WybQatnnFLsFDtQqKwsJCw+c6d9xT
	Nwysu4lW2fkm6bpyO4FxPkOM9GJE5Ao+l4KJDtVnZi66jG6B1Aow5hOXULjPDa2EXg+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsiU-007XuM-23; Sun, 27 Sep 2026 19:31:10 +0200
Date: Sun, 27 Sep 2026 19:31:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] net: phy: maxio: add support for -Q2C
 variant
Message-ID: <58b0ce4a-d1c8-4840-a1b1-f8c31438d86d@lunn.ch>
References: <20260926225625.25969-1-andre.przywara@arm.com>
 <20260926225625.25969-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926225625.25969-6-andre.przywara@arm.com>

On Sun, Sep 27, 2026 at 12:56:25AM +0200, Andre Przywara wrote:
> Currently the maxio Ethernet PHY driver expects a Maxio MAE0621A-Q3C PHY
> matching exactly the one ID provided: 0x7b744412. There exist an earlier
> variant of the PHY, still used on some devices, its label differs by using
> the -Q2C suffix, and its PHY ID is 0x7b744411.
> 
> Some vendor drivers floating around in the web suggest they are somewhat
> different, although for now this driver does not deal with any of those
> registers, and the 125M clock switch is identical between the two.
> Nevertheless prepare for future driver divergence by describing two
> drivers, although using the same functions for now.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
