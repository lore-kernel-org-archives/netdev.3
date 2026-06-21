Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF661B4223;
	Sun, 21 Jun 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782032817; cv=none; b=gndkO5lKwaUam/3KmUhDhUt4wu6jBrqyQplkFnT8ep7/mLPfqHexVR7Omdng/Yg2m5lKh+F3rsQc6zVIZheJL8XHt0IHhBgWTM7XjrS1utkd+YSqZKjj8QVhThcNLwIVN6k2AlvqAp/6JfZcSdY9+LZVWE8qpUIUz20Kp+IP5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782032817; c=relaxed/simple;
	bh=0AewxCFRSegd7ryf+wz82ddvw858vBDpyavYDaRYrQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anVLQ8x6h5jSLhIf/OKv4Up+dZ0RHt2IQ8QjdIw9Llw5Bcjm+0GKWx+dkQ83lmYaY8T9J8vC27Jgx4rO6csYaExxw+ufMVtDC01cxLIVNKEgIfT31EXRxC6tNcGB9lqqUJcEKVeRg6NCfViaJXKnNcTvBjdtCWvFWg+b+AgOC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2MIkFVVy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2MIkFVVy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RHTs2qhmKgB/dcAeST4GcyB/ifdhS+KGKIDLSwLNxKc=; b=2MIkFVVyR/vmBLqz/o7eg3J6vt
	h2pZv6IvgAlk9vMhEEfN1hQBN+edz0tWX5HwTGyAIxrCYwkCOFN71JwG5CibJsFkesTroJOHewd6l
	jA5ndK3YRAF9HEf2wvvBqDLV0Vb8p2Kl3fWD3VjecTzmP3XuqIja9WxHeGU9/K70LKfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbE84-008hBU-D7; Sun, 21 Jun 2026 11:06:12 +0200
Date: Sun, 21 Jun 2026 11:06:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate
 port structures
Message-ID: <2cc56e03-c58e-442d-bed1-489c34e5687d@lunn.ch>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
 <20260618202716.2166450-4-mmyangfl@gmail.com>
 <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
 <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
 <fc82aaa6-ff6b-4d17-beb2-e6f156e64059@lunn.ch>
 <CAAXyoMNOwiQCta9CKVtoBUwmX5JL-1MaDjxLrbWyviADyfs=sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMNOwiQCta9CKVtoBUwmX5JL-1MaDjxLrbWyviADyfs=sQ@mail.gmail.com>

> > This seems pretty error prone. A missing check will result in an
> > opps. At least it will be obvious. How big is each port structure? Is
> > the memory saving worth it?
> >
> >     Andrew
> 
> It's about 1.4k per port for 5 dummy ports.

That adds up, so not allocating them makes sense.

Maybe check if the functions you are adding tests to can actually be
called for dummy ports. They should not have a netdev, so that often
means there is no path to call these functions.

      Andrew
