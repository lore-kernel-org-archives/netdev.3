Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057040F8D8;
	Mon,  2 Mar 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464998; cv=none; b=K7PDruDOsBcFjSRUcaPN59arHlmTwfn+k2KxqxgsyP6GveTR1Eflyx2p8uFrla/SFJ/q9QmjtNS6fZYBR9nKh3lx0vrpV/ut7UsE9s8CX5rf+cEx/+IhDOmWfl1wp0MUuSbzetqOga5qrnitu91FjRFveXT9FivKoPfK0EubqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464998; c=relaxed/simple;
	bh=EVYwK15dduGoyeZ0r5hvbbMoJyoIUeqNEStYXt32qlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MujfXyx9TxKCDi8UYTn9P230o8lx+jPjX2Q8CA2bYHxuYMJAKPCBklmrrSRbiMMaru3a04yk/Z0fwRZy9GyINK8G5UVUp0S2JuDwqTaYUu2V5SeBqYpSGU+Bj7Fgm8ycKXyTidyO1P4iVHx3SuwBXYtekYoc5xMHBcwGRZdJhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5A4V46mp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5A4V46mp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z/L1RsM3ifNpNZNp4Aw/HlURvPThVG1lk4TYHvWSF78=; b=5A4V46mpge7k4Q/0orHLQoyri9
	blKLRtS4agjMpmaalW+TWwrHoBTOWJaHLult03tudMjFWdWQvfAXS9V+unyuhg2E9GuebFc83lqOO
	54Hx+w4Qa6jy1jvIsmGXdvzKYUlha0ocSzDAtAimxVhLfpHB8lE6nVHnDaNVd1LBqD68=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx56e-009h7F-Ej; Mon, 02 Mar 2026 16:22:48 +0100
Date: Mon, 2 Mar 2026 16:22:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Handle PHY reset during initial PHY
 ID read
Message-ID: <9c29300b-a8f9-4b92-bb38-c75a6b56e793@lunn.ch>
References: <20260302144458.3180702-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302144458.3180702-1-wens@kernel.org>

On Mon, Mar 02, 2026 at 10:44:57PM +0800, Chen-Yu Tsai wrote:
> The mdio device core handles reset GPIOs and controls for PHYs and
> MDIOs after the MDIO or PHY device is created. However this does not
> cover the initial PHY ID read _before_ the PHY device is created, since
> the PHY ID is needed for the PHY device. This causes PHY devices that
> have reset GPIOs or controls to not work after a reboot if the GPIO
> is left in the reset state; neither will it work if the reset GPIO is
> by default (for example, missing a pull-up) in the reset state.
> 
> One possible workaround is to place the reset GPIO or control property
> under the MDIO bus instead of under the PHY. However the common PHY
> device tree bindings already allow a reset for the PHY, so we should
> make some effort to support this.

Please either:

1) Add the ID to the DT

2) Work on driver/base, and add generic power on sequencing code which
can handle reset GPIOs, reset controllers, regulators, clocks etc. A
solution which works for PCIe, USB, SATA, and other enumerable
devices.  And then modify phylib to use this generic code.

    Andrew

---
pw-bot: cr
