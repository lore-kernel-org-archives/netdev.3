Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0091E520A;
	Wed,  2 Sep 2026 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308263; cv=none; b=ea/4yF8CEMYErtB64qansUTf/ocfMTPf9aqK58jms+OsxQrqqwnL8YJ2ctmzJcC4ihwqv/YhNTr4T/gre/2cuCrfsgasT2xLoSCVzS5ZkNzKmYKECj3gPZnLEG0adrvNq9MivhIEdEezmZl6aUdU5NjRYXEXnOyQZsVTbK1uAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308263; c=relaxed/simple;
	bh=sXculyBvakF5uabNwFS+ezCMrcrpg5fV/+KkLALFtng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scX7L+crPvAkfm7MEzGDUTk+v0HXz75Djpk/hIWCluesMZa0DBUXTRJulz0AnA3zyMxHnlKPA4vtmJ+/TAwaPQHZpqjUMfqrwND9zJDcTrzxECZzQFDRqIuNPmmtI+1DiWLRFxb7BjeZO+poSYgodU5Aq2pNxZTfP/+TrXefP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uV6DWNFL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uV6DWNFL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EecqM72El7aeM2lrCvmMJNP1RPzSiJ+l7lAt3ltQakk=; b=uV6DWNFLCiJWLDnuivhS6bYen7
	+7j6zzzhbsiPy8lLgtnm7DnnpmuSMbJROJXfXRKmv5XQ87mslj8EtBWxeASKJM7YL6lz0YdI1wUfb
	ZOANz54mx7fPFfGG/5zsul+jsKfV6p2z9fmmDxacSH+/y3iyU3ZVWIFdZk87vvqErSXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YfR-002RdT-0Y; Wed, 02 Sep 2026 02:17:29 +0200
Date: Wed, 2 Sep 2026 02:17:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 11/13] net: mdio: realtek-rtl9300: Add
 support for RTL838x
Message-ID: <75a8e6db-6b31-4e72-924f-4f53d46bdfe9@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-12-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-12-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:37PM +0200, Markus Stockhausen wrote:
> The MDIO driver has been prepared for multiple device support. Add all
> required bits for the RTL838x (aka maple) series. This is straightforward
> but some things are worth mentioning.
> 
> - The device has a lot in common with the RTL930x series. It has 28 ports,
>   4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
>   existing RTL9300 defines could be reused. But to avoid confusion and
>   for better readability duplicate the defines with a proper prefix.
> - The MDIO engine has no fail bit. Thus the mask is set to zero.
> - There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
> - The setup_controller() function needs no C45 configuration as polling
>   only works in C22 mode
> - The PHY access must be activated by a special register flag.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
