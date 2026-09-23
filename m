Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06F35FF58;
	Wed, 23 Sep 2026 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188732; cv=none; b=YpEzIGV9L/9jBQBbGLY6uW5lqy/6AUZChZ0JYPQIaP49NYVliGcbbm3f08knNNY9ZJ0i1hCt7/znU+hWsBqAYlRRH6RUQ8VhwpkV0nWP6Q6VABlzDonYUM6ZG0DGh7FMN2GqDB+mglWeSIIUi/C8N/q6JBKjfLWPKzEfQSpku1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188732; c=relaxed/simple;
	bh=pPETHbQ/lhiw9YJVrCR0o0cduRxhHeuCxdRpLXlYN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3LljjI9oUdCOuxghvSUDYbq6Lsvl1BLKJeCJGYNH2wQlcIOFCi52m7kRkOoYu1axFNksMsBgrlENjN+sJahBpJlPfmIqu2kAk3xYkB6PMBipQdklqy7xp1i7TLRNFwF1qr0wgEFl6gJzM10UKBC812HdmSWaMx+oAv+Up957Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ux10jPK/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ux10jPK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LUoQDWHb/l+6k19FrArKmt1pfReWHaZCAaEIs75K+TA=; b=Ux
	10jPK/Jr2kaGr5zP5pmxeJ9F5DC1v2qDGJnC3X5sZiMz15wOrvsdzigv88YtSfPk/J7YH5Di4Le/5
	IFCyhnFkTBQ0A7F75M8IP61B9YJnFm1Dy2dNwbtKcPHEg8ZC6fHm7u89c9yqcYky2vQo8GpJifxF2
	cqsvWLT+oUfqMi0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Rrb-006rCZ-36; Wed, 23 Sep 2026 20:38:39 +0200
Date: Wed, 23 Sep 2026 20:38:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak
 when the PHY clock fails
Message-ID: <b6d534b0-8ccc-4cbd-8d13-cd0c887a3260@lunn.ch>
References: <20260919174223.2356964-1-coiaprant@gmail.com>
 <20260922191758.2730da7a@kernel.org>
 <CALj3r0gPjraK9wy_WbTkeYD1OK_HhSeMi8bDmk03gOVJUb825g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALj3r0gPjraK9wy_WbTkeYD1OK_HhSeMi8bDmk03gOVJUb825g@mail.gmail.com>

On Wed, Sep 23, 2026 at 08:31:08PM +0800, Coia Prant wrote:
> Jakub Kicinski <kuba@kernel.org> 于2026年9月23日周三 10:18写道：
> >
> > On Sun, 20 Sep 2026 01:42:23 +0800 Coia Prant wrote:
> > >                       if (ret)
> > > +                             clk_bulk_disable_unprepare(bsp_priv->num_clks,
> > > +                                                        bsp_priv->clks);
> > >                               return ret;
> > > +                     }
> >
> > Missing a bracket, EBUILD. I almost appreciate seeing a human error like
> > this these days :)
> > --
> > pw-bot: cr
> 
> That's what I get for hitting send while my brain was EBUSY. Will fix
> and repost shortly.

I almost appreciate a human brain being involved this these days :-)

  Andrew
