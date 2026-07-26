Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4461BE63;
	Sun, 26 Jul 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785084644; cv=none; b=lR7Fi3r9ig8wcSxh8mQhNZ7hcuRrJBoJbFWWAalPQYBWk/owgt5LoDtGcDclOr1fIlJzWG4TRf5quC7ROSIl5jE4TdDFfVUG5C4JJgHZFkIl3vuHuOzpWlWwadLgOA9PsO1Ka+i8GArH7nyMl6qZ4mqnGBV8+WYJIcJ1P7tlUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785084644; c=relaxed/simple;
	bh=V5Bi/1cexuJdl6zJ3MwZANjrZ2sIkTeRwUFaygi1RBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc7SIc35O8j15ObWapHekAdIUX+8EndNbJ3CVBVVzIqHZLzNQzMyYVYNchFFfYYGFcl4KZd9gF0F5GxetcB8jIZMfcHtmSj+At5ulHYekrS7rmZFo+hfE+D2i2It4ideXNvU2EpLUa4RBKxayDXR4COvPl2jD6Qvq5eCRQCD5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CRg7stS6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CRg7stS6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SQ2wb00MkS2uG7QsCD3YVtpLs9rCbiAjFkat4xDwsSc=; b=CRg7stS648JhPobvturjX/MP8u
	sVaf5j0Wgd446LHQW5UQX7+Pm/e4obpKysdckgCncTS2NQxe8rwF4LAznmw82+Cnn8AprKqoUxGC/
	s5FFs9Z56vqgFvbBo2CDfj1cZYDNCU7IY7aUknO97bi4OmLMl/NC3Ea34Act12z43rQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wo23U-00EJQc-I1; Sun, 26 Jul 2026 18:50:24 +0200
Date: Sun, 26 Jul 2026 18:50:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>, \\@lunn.ch
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: put link_gpio if phylink_create fails
Message-ID: <3647630a-cc89-42cd-9f15-31cc69b921a5@lunn.ch>
References: <20260726150806.2437-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726150806.2437-1-ansuelsmth@gmail.com>

On Sun, Jul 26, 2026 at 05:08:05PM +0200, Christian Marangi wrote:
> In phylink_create() if phylink_register_sfp() returns an error, link_gpio
> obtained by phylink_parse_fixedlink() is never released. While this is a
> very unlikely scenario, it's worth to fix/handle this.
> 
> This was present from the very first implementation of phylink but got
> relevant only with the introduction of ce0aa27ff3f6 ("sfp: add sfp-bus to
> bridge between network devices and sfp cages") where additional function
> were added after phylink_parse_fixedlink() making the release of link_gpio
> needed if such additional function errored out.
> 
> While at it, restructure the exit condition of phylink_create() with the
> goto pattern to reduce code duplication on handling error conditions.
> 
> Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
