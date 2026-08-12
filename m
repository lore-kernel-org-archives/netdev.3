Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB2380FCF;
	Wed, 12 Aug 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563908; cv=none; b=WJnljmEf0G0girzXmO14CE+EfdBvkstzXGyKYA/YpYahEm1i7xKX7EIfefzj1wyJjXgO/Gf7fhV7qHkoL61M90wzQvJqumoyq7Ymlk0QLTvST6H2m2c6+46ZenDDCwPQ9L5FweLBvqnLYSE3H+5cofVCvigMiJhpbOcLF4d3SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563908; c=relaxed/simple;
	bh=mdeweLXqrI0aXwdXGgaKi1f3N3ksSVHBN86F8XMZmCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hes8A3Lr0RDblvZ7oSHA6jNaZ3VnB8jTbNPnBOUd6gRppwUclylReoweulC6rrt0f2FlW9f3M91YxMrmTGCKYXbeW2v0NuPThN23fYu5YWtcBAlAugAfk2p+I4Wgqe8HuNyAH9PETQmbSJKczBdU1DAAhe0amuy1jaBa7Tt1HUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q7yHOjSL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q7yHOjSL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LNvaOf3GnEWey6NNYiKVhERhG3tq4Xl9EwpQofN1geU=; b=q7yHOjSLk6J/WZapVZjhwOZCcd
	Y7iqZLJ8hGSKcge2z9zvaTh/J9Y1fcAAHD/UUBLkAmOfHho5QpJ5hAhj5dOdxURtIkTyjX2UBq03P
	uPGTlJ6wUp1DA2A7h2cr5/oKNcB0v1LQ837Rc9qFMppjEMLYPXamqqzTEfOL7r/i1aG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuEsh-00HJte-CQ; Wed, 12 Aug 2026 21:44:55 +0200
Date: Wed, 12 Aug 2026 21:44:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xilinx: axienet: Propagate errors from optional IRQ
 lookup
Message-ID: <017b2a0a-0092-4958-b554-45139db50cfd@lunn.ch>
References: <20260811034715.6034-1-phucduc.bui@gmail.com>
 <81a38486-d4d8-4ca2-8d22-d3d178c17665@lunn.ch>
 <CAABR9nF4q=eyUbzmo6-Co7NfVcg_bufHnffy8Ho4ZehHFZpqJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nF4q=eyUbzmo6-Co7NfVcg_bufHnffy8Ho4ZehHFZpqJg@mail.gmail.com>

On Wed, Aug 12, 2026 at 01:14:38PM +0700, Bui Duc Phuc wrote:
> Hi Andrew,
> 
> Thank you for your review.
> 
> > > platform_get_irq_optional() returns a positive IRQ number on success or
> > > a negative error code on failure.
> ........
> > >       /* Check for Ethernet core IRQ (optional) */
> > > -     if (lp->eth_irq <= 0)
> > > +     if (lp->eth_irq < 0)
> > >               dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
> >
> > What has this change got to do with what is described in the commit
> > message? If you think this is a needed change, please put it in a
> > commit of its own, with a good commit message.
> >
> 
> lp->eth_irq is assigned from platform_get_irq_optional(), which returns a
> positive IRQ number on success or a negative error code on failure.
> Therefore, a value of 0 is not possible here, so changing <= 0  to  < 0
> is directly related to the error handling described in the commit message.

I think this is a separate change. You can then reference the
documentation, and its example:

https://elixir.bootlin.com/linux/v7.1.8/source/drivers/base/platform.c#L270

	Andrew
