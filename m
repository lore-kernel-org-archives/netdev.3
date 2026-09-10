Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11924EC660
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057390; cv=none; b=qVSyMK8QyPujDy5uuTF/0GSC6s2nUSeExQsGP8dlMzKQzyeYqFbAoazii/etBtDyLdodUgH/R8z1gcOfHY/VpnEY0rVUOm/DBlFzMVAR9bceClH3++o4O305q6NvAHOMWBP7IgAAh1hVkIUf9eJiudBp837DL7cO6MVoCmEen4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057390; c=relaxed/simple;
	bh=WE1HmChEfM+Z6touDRj2bSr36PImssrPnewDbgKh+Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9K52qtsm8+u5cZdCxfzAwqV0HeEbeb5KTL2eetWV2cPNIw86TvGsBW7+LS3Jtv95jYx0ha0VjjWta2V5ynFGZbTkNFBcY8RZnZwbVHFUPtnKZ2b8wEN2LuZ9jAInXRuPXbHhIrN3CePMcoSg7lMkXbvIwj+UFmgcItMNUAcQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4xzZwNuV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4xzZwNuV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kNOw+9Z29sE6dUiTRClB+0W7XRuDEW78Yk1IOpyw6fQ=; b=4xzZwNuVGUe90vcRV73XF0y1+8
	51YjbCus1muaxYBg+PCKGIEAVAKFwDp5WrPz9PKskVDPoR9NlXWxk7oGqWoc7C/vlhfi9n+nb0Z99
	CBNiyi2FphpqKTN6bvZIoxuejEomPUjvnSjHhIsLxBsWNJWyIw5d3L9O2TVDa74TvX0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4hYF-004XbR-1g; Thu, 10 Sep 2026 18:23:03 +0200
Date: Thu, 10 Sep 2026 18:23:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] drivers: net: smsc: Remove unused smc9194.h header
Message-ID: <2eefeb0b-a85c-48ed-8841-41a695261911@lunn.ch>
References: <20260910143516.87304-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910143516.87304-1-enelsonmoore@gmail.com>

On Thu, Sep 10, 2026 at 07:35:05AM -0700, Ethan Nelson-Moore wrote:
> The smc9194 driver was removed in commit 9fdf9f61fa6d ("drivers: net:
> smsc: smc9194: Remove this driver"), but smc9194.h was left behind.
> Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
