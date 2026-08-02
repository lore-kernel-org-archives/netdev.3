Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C6363C50;
	Sun,  2 Aug 2026 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705090; cv=none; b=PAyX7NSoOuypz9bVh6c/rxOTJFfGMDXRM/eJYHTh8Zd9ibmfLMBFBjXQo6rG73cal5n9UTvJsoGPuxiYnGvQPUC90zkQ57TaLaaYQnAwZtPnEnjYlFQbNZRDjegUAKf+rLujNKUdppyKxxWpMwkEFml4Enn8mhY93aJXrNRCa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705090; c=relaxed/simple;
	bh=NchiXIrDFhoqTJKjahtVQ5kQg39AAGkgbWMd1+E5cuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfrH0sbdBSPOKd8CpFJDMmDghqG7zIk4c3lJZCx/t+sL6Mp9zZ8gXW3JrvyiEiUiqbbVmr1h0KamLATAlWyydylZ5Y4s6YQwO3LO7Rh+VlvPB/gnT5c3FPYTByoyTmMhsB9z8koNDBKf8G4mrGPjOJAd5Hg5JvkrXvUmecgxsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rfhMLwRe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rfhMLwRe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wYLlNp1JOU4HeytwIaMB6PQNnf3NDTYX8Q+Ak0ohmRA=; b=rfhMLwReSy5FHhy7NdzIcshkPY
	lqyqrgdHd9PTJCZECNL1L7aeirRaZ/GsiJc/STbbIiENNQNQOIpr7gzXkCpdsOo0Wc5y5Q6HrpHLO
	ykMTld0H/ocSHIhFQnCNoqE2G9lyyT3ocgiVPil1+mOVpNit8StS8HTeugJMc/ajnAK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqdSH-00FcAg-95; Sun, 02 Aug 2026 23:10:45 +0200
Date: Sun, 2 Aug 2026 23:10:45 +0200
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
Subject: Re: [PATCH net-next v5 03/13] ax88179_178a: Add netdev2data()
 convenience function
Message-ID: <632d6101-fb2f-41f5-9cfa-7d0617a1801b@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-3-dcb9fea4acd4@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802-ax88179a-v5-3-dcb9fea4acd4@birger-koblitz.de>

On Sun, Aug 02, 2026 at 06:32:01PM +0200, Birger Koblitz wrote:
> Add a convenience function for the ethtool ops that use
> phylink and need to retrieve the ax88179_data structure from
> net_device.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
