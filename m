Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65528400961;
	Mon, 10 Aug 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374506; cv=none; b=CXJb4u2lrGR6WRUCcN18QgnIsZKdwjYfyOnhPwQ8zrdEzjxnIx9cmeUymkFhiZUeWXfVG31SH04WvuT8coZIYhMSSb6Mw9U4uhrSWW2DzKizGqgdQbDNHzQLZwEdeGTaw3jCY9U2LeB6tS8XdGK0bFPhVtFp0mGUJMHdJcZk7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374506; c=relaxed/simple;
	bh=NpJGpJ00BWLrn0dO4o7RAfuJPoWiNKMbjnrI3XsmKvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPo/9TQWgk6pI+XHyoX05IMIlx1y3flqNFHE97JLyd4MaXiBBLEo29hUQXYsSaSUlrGe/YzJQksch0ivMnWBGEI2eTtzW7D7wnGsWoBim+QvL/QJIl4Tc5/yq6Dgk0FnfrN3WmVS9gB/xGiirDa32d62nn7Eu1dTeDEnB4bs6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uCxXe4/K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uCxXe4/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sbp8o7Qar96QwrIbmpwFvMRCnGsM71jVV6192fVEWpM=; b=uCxXe4/K9BXYCMmDS34kjK/zvp
	Qk0ojvOri2aapv5BzF4/1waUFPgIVb/yroWZIRxIXC1N0gSRMdYSDlmIdiljF1MWub8ByaZ+ebUV3
	XOEe2tSAIP39TsYl8zBhdVgboXSWBJS5zNSWEsO3y2p1cw65fDzOAlIKhjKnPnwhPN30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtRby-00GwaG-J2; Mon, 10 Aug 2026 17:08:22 +0200
Date: Mon, 10 Aug 2026 17:08:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
Message-ID: <451f2df8-9e6e-4303-a9b5-811af2254c88@lunn.ch>
References: <20260810143740.652804-1-ansuelsmth@gmail.com>
 <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
 <6a79e645.cdc69361.35b412.6c89@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a79e645.cdc69361.35b412.6c89@mx.google.com>

On Mon, Aug 10, 2026 at 04:54:58PM +0200, Christian Marangi wrote:
> On Mon, Aug 10, 2026 at 04:53:33PM +0200, Andrew Lunn wrote:
> > On Mon, Aug 10, 2026 at 04:37:05PM +0200, Christian Marangi wrote:
> > > List all the files of the QCA8K DSA Switch driver and add myself as
> > > maintainer.
> > 
> > Hi Christian
> > 
> > We normally target net for such patches, since users wanting to
> > contact Maintainers are often using older kernels.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> 
> Should I resend to net with the tag?

I suggest waiting. This sort of patch does not require CI testing. So
it is safe to apply to any tree. Jakub will probably accept it to the
correct tree.

	Andrew
