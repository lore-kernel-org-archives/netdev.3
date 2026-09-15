Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E184A2A58;
	Tue, 15 Sep 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485950; cv=none; b=Rk9WX10ICJWDuSQtCaiO1ZMwyv2i5E9mgWdoN/0/NfQI9RDI5IkBISfycZ5BxaSkKeBbFArEFzfEHPugJZO34+BdWWAxgb1sH6NgBdBF23/obTgzfFA8A/4LVtGvk7+ZeWWaIveooY43pr/ThjwGyQfKApyGj2KukPQZJB/Oclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485950; c=relaxed/simple;
	bh=FuToI0mt4S7XVelabQTPbZH7JdG1ZxRZXmBhTsFiHMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN3Gz+Mbn6GBp/2s2OBW/vbTSfAAWu/Pe+Y3T9OTdRGIJkUKU72oKc9hWTW73MzwbuScgsPhmH6xsiD5iNXoFSICc90qzXcakTe6Q2s2TD4IdGmtoVoCxtP0nAmmw0641+5kjD4l5zQZh6PcPy0fF08QGgmD8QrwC0apgE4NvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wbDYYFpI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wbDYYFpI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I2BPlxiFqZcHkC3wym6EF0TCMEVfqT5Xi9fplzsH+Ic=; b=wbDYYFpIlu9WE1RgjLrcWlb4Bd
	1OUTAAUPyz7XY7+Hqxgg7RZGBQ00yWJRRqele92eXZ51s5fLiBA5a0uQXptPic7nFxGNr2mB900pt
	wkjPc9Axc0dTsIrGhulBkDBp5qE8pvijdKZv2sudH7CRUPj/mgq/lXH274IGC0OFa3l4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6V2P-005IfU-M4; Tue, 15 Sep 2026 17:25:37 +0200
Date: Tue, 15 Sep 2026 17:25:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ch9200: return error on failed register writes in
 ch9200_bind()
Message-ID: <a7877aed-9454-44a1-a0fa-e4d691a389b8@lunn.ch>
References: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914202503.52920-1-s.shtylyov@auroraos.dev>

On Mon, Sep 14, 2026 at 11:25:02PM +0300, Sergey Shtylyov wrote:
> The successful register writes, done via the USB control requests in
> control_write(), seem vital for the normal functioning of the device,
> however the driver's bind() method ignores error codes returned from
> control_write().  Do bail out of ch9200_bind() on failed writes...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
