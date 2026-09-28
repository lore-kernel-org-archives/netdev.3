Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53944D599C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604343; cv=none; b=K1GYIxC/LLKArMTtqbOzsOL/ZUTmnC4iXju256a7FfMChhV4su7X6pk80j8bZqVatSmI7DSdytxm9pPSczh+5WKln09IQf3E1dBO16IVgrwQwUDW61K6PFz+UDZsBqS8b2a4IwTaro7eXtD/u+GC7S9M3z0Y/JGT5s/wDhx9IYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604343; c=relaxed/simple;
	bh=r6seS7jVImK72vJfpjHpNo3FW3gGGfW3c7hRtvxgzYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMtiCytBP9lQXA6+q+FVXX2VFFwDNJUtq+yO222HM0kxluaBe/pxqDtVsMaDi1cqkrR33LeC8dZqElMy9tHoE7RyufI4OumQBoTeVkQLDr44XkHkEg07ZpGjWRxKZp5kFSdDYYd82Kxcln6DOMN3IViq55T8/GeBo7uKfLFup+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vxU7e28O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vxU7e28O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9pYFOfcN7IjcgMj739vHwY1+VN179q+8KlH+LuriJxA=; b=vxU7e28OL3kcmjax1oL3ombV2J
	myBT6gugaoisuFImPpJGbwCItqE5soq6MoUpI4zmL1OcgVgrvxoLlGXA1BgXO6mVWwGjZobiogrlt
	BgM3hpC4uV3x0dlsBmZ/jNCdCiEG6idUEwWpjJnLwwqZYogNaOoDR2i2LpRWK1o2jRCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBBz3-007j0o-4t; Mon, 28 Sep 2026 16:05:33 +0200
Date: Mon, 28 Sep 2026 16:05:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Crispin <john@phrozen.org>
Cc: Ziyou Xu <xuziyougm@gmail.com>, netdev@vger.kernel.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Gaoyang Wei <yhyxwgy@gmail.com>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <43747c0e-53bd-434a-a2ce-2c02d79326d8@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
 <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>

On Mon, Sep 28, 2026 at 10:37:48AM +0200, John Crispin wrote:
> Hi all,
> 
> Christian Marangi has been working on the design of a PON subsystem
> together with Airoha for almost a year. I started implementing it on
> the AN7581 two months ago. Reading this thread was a bit of a
> surprise, because the design you are converging on is very close to
> what we already have running

That is good to hear. We are probably not all wrong :-)

	Andrew
