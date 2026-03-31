Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D13E314D;
	Tue, 31 Mar 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961494; cv=none; b=YvMKf5IKh8OJ3eprgQfJh6JX6sbYcbSl7B3Kqt09WDVJ8VpXYS8ZtsDXX50oFCyZF6Zz/sqUE10tnABIp1cvdh+Gl7sTeoJ19pHLdf6EFXMndYuTgLV2Mc/6KIHRzggZDbIxBpI+a8ySDFeSXtwUrXpnnglkTjFyDfUrVGf0wJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961494; c=relaxed/simple;
	bh=GoX8CG2jBYCY1OCV/r/yfJN1mHIM6rmFOS00CRpQOCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6r5eu1EaG0S36cqC0E5F6DVEqYQdRjOp02R3/2PNKjRdCXMsRdQQTzMsd6eD/k689H3VyCSK2I06tT5JF9u1y7vOc6CSRGCO5dlXhQ9YjOO0qVCPBRYjM7yALFOZfTyj8GfoYvGqOBZxG4hflTFlqFZ8H1g4+DDsNwU46RpMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1zldnEAp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zldnEAp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eA6n/Nw1gYH/8tkZMkbcqirHGsRDbHRm0Q0WvF8Uoj4=; b=1zldnEApwIvRfxavO8upHO28F+
	DLPf2fykkwxr0GNDxllHtyDPZr6e2/HLRnYH3rnIbrAlyzc3KzaEXchMqntzBom8uxfRw/cH3GHZ/
	7IxDpFs5nSh0cjY1py8XoM+CzUywUoOqjOEqgkOgSmYUvTeAiplKcTZzHCefoU7Xytpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7YYz-00ECFV-Kt; Tue, 31 Mar 2026 14:51:21 +0200
Date: Tue, 31 Mar 2026 14:51:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: mdio: add a driver for
 PIC64-HPSC/HX MDIO controller
Message-ID: <71217bc6-5fe4-433c-acee-71d199fa3db2@lunn.ch>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
 <20260331123858.1912449-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331123858.1912449-3-charles.perry@microchip.com>

On Tue, Mar 31, 2026 at 05:38:54AM -0700, Charles Perry wrote:
> This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
> and C45 but only C22 is implemented in this commit.
> 
> This MDIO hardware is based on a Microsemi design supported in Linux by
> mdio-mscc-miim.c. However, The register interface is completely
> different with pic64hpsc, hence the need for a separate driver.
> 
> The documentation recommends an input clock of 156.25MHz and a prescaler
> of 39, which yields an MDIO clock of 1.95MHz.
> 
> The hardware supports an interrupt pin or a "TRIGGER" bit that can be
> polled to signal transaction completion. This commit uses polling.
> 
> This was tested on Microchip HB1301 evalkit with a VSC8574 and a
> VSC8541.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
