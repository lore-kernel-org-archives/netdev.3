Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66BD47AF75;
	Thu, 23 Jul 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817600; cv=none; b=fyOEbzVcohFFIr+GapuXa2LsYZLu78WVtneyxf0kbGKK7VM6Yauu3Zdu8uXvlweeK7VJ3QSzBaHirA6Ejaj5j3fDs+mZLH2GpIpMzmI8nL2ulRq+A73BPWVgTtsMVdSFMiK2jSFTL1oleJUcN+6ftHFbww3orN1m4nkTvUSLVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817600; c=relaxed/simple;
	bh=eXklQQcmLvSy3C2TnnxJbvDeHIgfSFmHJROwOnaoslI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoAANPdv3A7/n9ndssCYQrBlVT0pr5D5hDK5EHtnXYH9HzabeOVJfj5FQ4HvKicSW1Q2FUscYVmzClPxctQ+ZbUWln38n4zvVFIu2LWuTlJo7YKvnsYXcxJXC3QJmgZfTw+ybVwLsxc6hnOuMPoJRbX+BVYTFFD9s+q77RkyauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hDPrOLUj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hDPrOLUj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FjnstXvC+OWCIDKzDewI2uwDKIqkbbY4SuJzCmZTGqA=; b=hD
	PrOLUjBWjFgTs5ArFJaRnC+3e/8a651awHOS1FrKZ9J00BZ3hLGokS3MVCA78ftjoa2HXb6X5t+iH
	iL96FfEHbU4TRNzlpeVW31aWvacDk5y9LWUsJ9BRbmhJcG6B3LoiDJrh7txgjXsBOxDQuWyIicfzw
	tD/K/URtEpzYuHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmuaO-00DpmI-Le; Thu, 23 Jul 2026 16:39:44 +0200
Date: Thu, 23 Jul 2026 16:39:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias =?iso-8859-1?Q?G=FCntner?= <Guentner@schleissheimer.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: Keep PHY timing role
Message-ID: <60774ceb-196b-4422-a5da-d4b8faa9cda7@lunn.ch>
References: <FRVP281MB5880362CC7F6E70359B4582FC7C02@FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FRVP281MB5880362CC7F6E70359B4582FC7C02@FRVP281MB5880.DEUP281.PROD.OUTLOOK.COM>

On Thu, Jul 23, 2026 at 11:19:33AM +0000, Tobias Güntner wrote:
> Some tools leave master_slave_cfg at its default value (0 or
> MASTER_SLAVE_CFG_UNSUPPORTED). Depending on the PHY and its driver,
> a PHY may fall back to its default (bootstrap) timing role, which
> can prevent it from establishing a link.
> 
> For example, consider a system with an Automotive Ethernet PHY DP83TG720.
> Let's assume that the PHY timing role is bootstrapped to "slave" mode,
> but was changed to "master" mode via ethtool or device tree overlay.
> Assume further that the timing role of the other peer is "slave" mode.
> 
> When trying to (re-)establish a link (e.g., after unplugging the cable),
> management services (such as NetworkManager) may change auto-negotiation
> settings and inadvertently reset the timing role if this setting is
> unsupported. Now both peers have the same "slave" timing role and cannot
> establish a link again until the timing role is changed back to "master"
> on one side.

Automotive Ethernet is special, because it often does not use
autoneg. If you are not using autoneg, you have to take special care
to correctly set these parameters on both ends.

My opinion on this is, if user space sets it to master, it should keep
as master, until user space changes it to something else.

You say, "inadvertently reset the timing role". That sounds like a
user space issue. The kernel should not be working around broken
user space.

Please could you give more details. Show us how this is a kernel
problem, and so needs a kernel fix.

	Andrew
