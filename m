Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94815386C17;
	Wed,  2 Sep 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382485; cv=none; b=c1THis9RlQQWXE4KIhWoSygOUHWGlVh2pQTg//zFJumVoDzvhLdzd3uGP5mSUMtG9Ir3PlQahxEhKEKwKL3nIpqrdg4wJpebJdIcJw4PjGtE23stuO/REK3xDZHwXUEjQ+PjoZqOORz+VJjg6oCgeozk6xTkYzxZkxJvTp9x+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382485; c=relaxed/simple;
	bh=BBYpN9J8W6yMgmb9DUh64waoSEjtgPtdd7EuP0cLv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN/OqSYGOxI0LuT28wxCZgLKBuwIXAZ5e4F6DggSsOCAWPLMFPSOYYYECOTaeC1xNMNepKWwQAbNpDZUf3O7PTkEzqz5tg6vaSm0+SBrrPDs2pIn13d5hV1tMcYLUtNuNYm4hcNxFlLR98m2tdcWxWkxpSkAN8k7yxd7hsmgifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uY3xRL5z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uY3xRL5z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MOjaESz0mnYJMMUOZh2/l3oVnKV6abTNHSbJN9ywKG4=; b=uY3xRL5z6bVIh1kgJIyATeG+Um
	jTXfRejnPdZhHc0YFJmXqqwDLhFTS5Pf5/DH1B8ClqVLOUOXMMQfpFnMiM6zUAsYGysCrMF9l6/Pt
	p+pjl4HNNSfiJFHSBzmflcUaQXuvoMlRiASob+Eq5CP1RhnxZ6SNWvcM7c4z+q/iUzJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1ryb-002aX6-AM; Wed, 02 Sep 2026 22:54:33 +0200
Date: Wed, 2 Sep 2026 22:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v9 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <b87d751c-f736-4cf9-b3f3-88ae2bc9ade1@lunn.ch>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
 <20260902-ax88179a-v9-6-8e6d7710a2ae@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-ax88179a-v9-6-8e6d7710a2ae@birger-koblitz.de>

On Wed, Sep 02, 2026 at 06:57:20PM +0200, Birger Koblitz wrote:
> This adds bindings and HW support for AX179A-based USB-Ethernet
> controllers. The AX179A-family of chips consists of the
> AX88279 (2.5GBit PHY)
> AX88179A/B (1GBit PHY, B variant has wider temperature range)
> AX772D/E (100Mbit PHY)
> 
> The controllers all have the same vendor and device ID
> (0x0b95, 0x1790) and are distinguished by their BCD device versions,
> which are
> 2.00 AX88179A/B
> 3.00 AX88772D/E
> 4.00 AX88279
> 
> For all chips, the driver calls the same ax88179a_bind() function
> and the chips are then distinguished by the chip version and
> BCD device ID. The AX179A-based chips all provide both a CDC-NCM
> compatible USB interface, and a proprietary vendor interface. By default,
> the proprietary vendor interface is not active and Linux will load the
> CDC-NCM driver to support the devices. If the ax88179_178a module is
> configured by the OS to have precedence over CDC-NCM, then this driver
> will switch the device to use the vendor interface, and the device will
> be controlled by the ax88179_178a driver when the device is probed again
> after an automatic reset by the device.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
