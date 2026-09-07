Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB532D0620;
	Mon,  7 Sep 2026 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813189; cv=none; b=MyNHvVSg+doyg9lrq4ZYR0T0oZUGjwwok+fYZiBd1aX1OLP+5hCGSfktRBpiR2dhlnQLjSFMnxMkIeQxPC1DFZfEKxwvHTMny7nCkFx66tJs9P9wTNOFHJGWuoiQExFZT9aiWjrxhMXqpdyUpfHZdYGGpj4Grj0mn+Byef7DCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813189; c=relaxed/simple;
	bh=ujvBjx8SvJWvJStoTMdnmC9Onf/XnDGKwoMbn3g6mT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOdublyboO1EG6XEjywU6XOllgzKYrsEOBuldlwYIZqBQdfoCYYcuE5I31WQ6wWpfDmgXxlaKCgz9ouQoSfVoZNV4+THbmj11cgx9aBQmbnhNlyyNx4+wbfDSI5cLX5KsEcAISzizJrilae06I79OGsqFpiqlv6BhkgRIc+y1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fX0kyMB9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fX0kyMB9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GpmxYIWzA9qU6/JpqBIheaifkzLhn+7eeCQUlN8Digo=; b=fX0kyMB9YQ43ic9DnCqtgJe19U
	qYPyRqIuHYkRvGbuW6kwNhLp/kD0yWU9mY8JtLdrMV1vmoa07kiQma3u8S4rA3LBjeoL9j6/iy5w1
	XQgMO2DgZlIVf8nuFbe/IOGWYWOdd5if6BTB9S6HVZuYnk4AlRocpzBgy0wz+XgHCgl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3g1V-003dSf-3R; Mon, 07 Sep 2026 22:33:01 +0200
Date: Mon, 7 Sep 2026 22:33:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] net: dsa: motorcomm: Use safe 64-bit
 counter reader
Message-ID: <72b90269-bb4d-4efb-9ddf-51daa1b54fce@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-7-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-7-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:48AM +0800, David Yang wrote:
> 64-bit counter registers are read as two separate 32-bit transactions.
> If the low word wraps from about 0xffffffff to a small value while the
> high word increments between the two transactions, the recombined value
> becomes ((new_high << 32) | old_low), producing a spurious ~4 GiB jump.
> 
> Use a safe counter reader for this.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
