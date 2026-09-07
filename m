Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96350449B12;
	Mon,  7 Sep 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811071; cv=none; b=Du4Qy5J6Yd1zjuobvyVTgwwC4r9JEAU5NXGqJxtUu5SVDja9yKcZdkXqtsUXx/qXLz6Z+g4uNeIbsiIhy9i/cMm9Ma+dH/1YhiCY6wJebuvjcZmgjtLVU7kbCaJGmVKUm9VyrKTuD5hH5QdeHCTbh2QZY8wC46kxCI5XeuxrlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811071; c=relaxed/simple;
	bh=CffAiZAKb0h7XPDvGR0trNCHGGcpO4hbtvq3SWizEp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+nJ0ifld1zvV2YRrxpEH4NQx1pFfKkm/DAeibDULgAwCSAhmHax0I/PrkL66+AfBZcv/9lci1Zcld0m5KR0EvxMvnCYB9T48eir0vpvK81QUUoIOo7LCw2OuI3BxKi1HqopgmAvzPo+lnOlIplEYi2koGXDOU904EkUGP8rl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z8ilHJ8V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z8ilHJ8V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OBcGk7kHuc0pzVIY1D3QztNntBTJTuLmU51n2PFhq+s=; b=Z8ilHJ8VqXUl/0T3Hko/KrdPwr
	gtYJnmg4V5Gi9uL566z9bfydBqgIvbRD4rLcqsgUXt8B2x2B1XzUSbaFj9QaMzdFu4FNi/oCdF9G6
	9XcVt2cQGpLlhqXCFFYXsVv7fnGA2O9kP5OGBbDvg/jrS8LZMrrJenmVy9PkGpj8/co8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3fTL-003caQ-DS; Mon, 07 Sep 2026 21:57:43 +0200
Date: Mon, 7 Sep 2026 21:57:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: dsa: motorcomm: Split MIB buffers
Message-ID: <2d1638f8-6c83-4d0d-91cf-da771f391c01@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-3-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:44AM +0800, David Yang wrote:
> With MIB improvement introduced later, struct yt921x_priv will be over
> 20k which is not very good for a single kmalloc(). Dynamically allocate
> the MIB structures to reduce the size of struct yt921x_priv, and do not
> waste memory on dummy ports.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
