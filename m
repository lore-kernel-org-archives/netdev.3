Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D83D332C;
	Mon, 30 Mar 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875830; cv=none; b=Q0qHI7/RsiMdwKxIUnexkZmevA+uZaDt17+0/nnnYm3rskzQ5PFnVNQsts8jFavQMN7nUjeCuBm/vjXbMmkmgT7d+y+f/0cMSHfG8mWGSJ5JkQCUolWmrgV6YgT4F/U76cbc9pnyRtrvds4/23EHqIBqgGYscq/TxXUhxZGFg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875830; c=relaxed/simple;
	bh=rlIALot4FV8I3Dx11iR0n/ZuwFVfXPNiFMj4N+fBIHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X08YBbf2gXTI3oohjDZ76vImtxbbD7M2kr77YPROj5m3ZgOwydg0xpAJ0LedrFVjW1sIh5YxrxsPe6kyBza2QopmGwbAIAX7cUGtdpw+z0FjPbBDyvYPHa40AWO9LBqVk1OKmEdyBwTNVDP4FuKxbOF4HWW/koapdcJ1q09GQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QXGSOnsu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QXGSOnsu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b5FRnzK6ZO9xNWMuxsR0nQdMaQmMU3NTtQAvW5N3aw4=; b=QXGSOnsuiDelAZWCjUKP6GRrjG
	+Zxg+ymX6KrcsRCnWWSd5foiexH14loxMuq7cjl32T0TWX1PBzNyuFuINkjVqwCXZryGMTtnDY9Oo
	5uLkHvBrSNEjm6MqTys4soEd0rMGiljlciFqiBHC6m9Fx9F5Au+WqZ/98pr01ezp/IVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7CHL-00E2DD-VH; Mon, 30 Mar 2026 15:03:39 +0200
Date: Mon, 30 Mar 2026 15:03:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: microchip: enable downshift by default on
 LAN88xx
Message-ID: <4e1f47a5-b448-4bb8-9239-1792b549c361@lunn.ch>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260329224202.500229-3-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329224202.500229-3-nb@tipi-net.de>

On Mon, Mar 30, 2026 at 12:42:00AM +0200, Nicolai Buchwitz wrote:
> Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
> auto-negotiation attempts by default. This ensures that links with
> faulty or missing cable pairs (C and D) fall back to 100Mbps without
> requiring userspace configuration.
> 
> Users can override or disable downshift at runtime:
> 
>   ethtool --set-phy-tunable eth0 downshift off
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
