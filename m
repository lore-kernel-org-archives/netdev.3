Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BC3BB664;
	Sun,  2 Aug 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684445; cv=none; b=FEEkO4c/Y3ipUmiA1r2jvYBaRV1WBP7AcGN/vXA8Qkjfk1F0a6j9ukVgnWI9pyE1p9PIGG/hMBq1xgfj+FMmhaPRm8igsp63RTn2bgjnl7AI268be2vdwtzl5hqhDWmpD4od9eEoFDyZlwHZCPkvMdCqRnRgyt6wey11y+ZWjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684445; c=relaxed/simple;
	bh=9j5IS/OSv8zSTg2gQuil2TxgvoTmOOP2J7HwKozE5uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYHuaxLiXDySrjCtB0jHLeyPbXd39vBHNvMWz5zTtotG42Sc2y8OASN0m7b6wYGOCpvKgDKQZE7YrGEu/CHYXMkUQDYemh/9o/vnx7fJSNjaDD2IWoqSEm1aiTF+rrvpWKmRU0kdoMGzJrsWSW6rgbcbsTOyKefT5U2BPJh2I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xrW18lfg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xrW18lfg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DdoOaObPODaBaNCu77KDLCqNMvy2AyF60QqhU5i6KnE=; b=xrW18lfg7RSYWrVVDHX1DnrDcm
	J1Y6DV9GVs+yMI74KHsVSYGP+3YabdRlidI60UlVZeCNlmw5pexbp9RbovBgT18i8BEsjpLAgZ9sk
	r8SA03tAViNNgBY3pHhXYBLD6Ht1SJPS9/F37iZl9dhiK/sDNX6PpaPR+eCx1vDD4vHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqY5s-00FaXh-Jk; Sun, 02 Aug 2026 17:27:16 +0200
Date: Sun, 2 Aug 2026 17:27:16 +0200
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
Subject: Re: [PATCH net-next v4 04/12] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Message-ID: <76db0822-4038-446e-ba80-f800e875cf53@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-4-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-4-2cf1f71b1dd2@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:19:04PM +0200, Birger Koblitz wrote:
> The AX88179A uses a simple HW configuration for EEE
> via a single EEE configuration register without LPI timer support
> Add support for this EEE enable/disable register and replace the EEE.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
