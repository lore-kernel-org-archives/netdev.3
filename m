Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4A3126CA;
	Fri,  1 May 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639015; cv=none; b=iueRk2KNN5WNhKrIOzKs0b1UM+sOCeet4Myt15nuBCUis4+C9uNvzc+54CG20mkE04kLKboLXwQqQhCdpBb22IfEI0KyWccehTb98+Bt140xbaQg2Y4dRWWMKWdZU1nFKjsuEGn0/HIuo1ONf7XfaLpui1NdiyzgOhJCbVwWQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639015; c=relaxed/simple;
	bh=J/V8MLXTFXXRZxVCly9uXT69TJCU8ZRcR3cFQV41D34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivf3e8POC45kvHiJqwymwRXhh7lXot3dHuar7D9jW5XedsDg27HMGORWD1W4BW1KQxDLYPtI29zA0TXZ09kTD65VHmsx07RUzSLRlIahAgeOPfU0Gxqm1ThqnvS6eUQm/dWzPp19MNVgKLOtNoo7qhijRiYCHd9rStICkvNtUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sZL99jIF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sZL99jIF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dx9sVAAw1DRpP9W9u+5vuchyWvdEYlPp6eaNbU1rU58=; b=sZL99jIF9yjHUhg1E/yCM5LqJT
	9Jwz2tiqZ3ny1g2P7L5E/oGlZlCnSI/aGHJxMsss0dRb7n+6nVlm3IeI52AFssFBZlJAWoAM2i6NK
	sEe6p9rpnv1R/YiloA7HWdq0MeTxUgoyO7ScHinu4O9q0WGam7J7pkBkKYG2FqwjfaEo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIn6j-000oiq-9w; Fri, 01 May 2026 14:36:37 +0200
Date: Fri, 1 May 2026 14:36:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/1] net: phy: realtek: Add support for PHY LEDs on
 RTL8221B
Message-ID: <25e53079-1f77-45f5-9031-f66452b8249c@lunn.ch>
References: <20260501100002.755672-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501100002.755672-1-amadeus@jmu.edu.cn>

On Fri, May 01, 2026 at 06:00:02PM +0800, Chukun Pan wrote:
> Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
> indicate link status and activity. Add netdev trigger support for them.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
