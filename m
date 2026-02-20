Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19691FCFFC;
	Fri, 20 Feb 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592664; cv=none; b=faOpJXE0lkTZRSGomxHUu44TSDQ0HJxxoakzxARwwze9bPNTvSqsTUqoCiilIDo00YrKg/VFcFzcYUvYmP9yNOw1RdCMJ6pc4UPO9s5UViVGewaSjpksLvG88S9h5wwN4ttnUzoPdyxnMnRjCHqnoQ8+YnBsBnLUoHCUTfA1GsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592664; c=relaxed/simple;
	bh=ylbVJfXBhgxntel6DHRLnTgdxKcD04pQXhfokeNkGt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCSWlEBYsFjJ1ZqSZEqvN0wPkqP44YOusMoho4Npv+d4gCTc5vQCbZ9ZFRWjWv6q88vZ+TxysfLV43DZnDu/Cq7zsUbyXasXKzv2Qq678bCIhy7350mooSIvHkX9pxk0vtP7hxiuE42TAXcYAQt7y6MRTX7dbTxu5XaOk5X53t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uTP8vgMl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uTP8vgMl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/4NzBCvFv04+Vi0snEc7kDWAhLxT5Ew8rA6Mb2Y1t1k=; b=uTP8vgMlKF62Q3M9U6MLaKWIjy
	7I1AGzOJtQSn3cwrPjiy7gczMyhYr59DcXaLkC3pjaBqO607bYnTGZcZydMadqi4GLIFwIfFH5IDe
	LGtGHkHhktZ7czfk3K/wJ8nQnMRsvnQ6DXEmzpaBXS9LlMuznWd4DeYLj1cZLY3EvL1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQB0-0084K4-S1; Fri, 20 Feb 2026 14:04:10 +0100
Date: Fri, 20 Feb 2026 14:04:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: support deferral
Message-ID: <3d0d0727-1bfa-4e43-ae09-2d636b9f7d66@lunn.ch>
References: <20260220021949.40817-1-rosenp@gmail.com>
 <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>

> What I actually most of all want to achieve here is to support loading
> the PHY as module, but I suspect that then the ethernet driver has to
> be a module as well so modprobe can do its job.

I don't think that is true. You should be able to have a built in MAC
and a modular PHY. phylib will call out to modprobe, passing the ID of
the PHY in order to load the driver. There are some interesting race
conditions when interface open() is called while the PHY module is
still loading, so you end up with genphy. But the race exists
independent of built in vs modular MAC.

	    Andrew
