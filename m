Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C433B058F;
	Tue, 15 Sep 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477024; cv=none; b=T+PjWAxBexyKzRgXmKVjcSpI+jfWocGkvZrLJQArZuwqfzbnQjCH53cuPeVQAoSwD89L/u8OaJ7UUt1+SnDgzrWP0iJ2l3QNyXWa3oc7fx2q5xYyPGszCO5qbaEaq6OdTHDHR/AaK+xVMg7udxS4iXEnfYdxWr2EgXxLWWPy1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477024; c=relaxed/simple;
	bh=7wjl3beFE0ag4/GztOeAwhS16cGOkNFLpFICNCBKd7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrC1wGVXKKhmmrqqkovUe8+V5/bZ+eZ1uTnkVbpiJ+NUYy8hhxr6LP5B07bILbgiZS0jgJKh9oOpg8T4xoDoByaDUj0nJ/pT4Ds3VJj+9QmqxdPgfBEgsNC4TFbkoCcxzXyMYRqaZNTPUHAE/Ks45Tk1UAWmN7VkVIaHVhCcfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v4DFEoSt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v4DFEoSt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fHpNrpkj3IYCmCFirrlWjA8a1KggVsWVioL+y5z+jJ0=; b=v4DFEoStxp8BZDDjsXDUtGjGxJ
	5QDmagmBG7Qqp6QXUcR2T8KgB85ErH2ce4qLw6BYQepjk4Vg4Z4GzhrNJtp6FROIzlakjHw6wtaM9
	u9JOmsv9HBtpu3e32AFWHDaghuTPoBAbSV2YP7JBfMJZ0sbPzOVdD1yeCgMLyhp/LSwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6SiX-005HHX-2c; Tue, 15 Sep 2026 14:56:57 +0200
Date: Tue, 15 Sep 2026 14:56:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: netdev-bot+sashiko@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	martin.kaistra@linutronix.de, b.spranger@linutronix.de
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <4dbeb7cd-d9b6-4e95-a586-800ea133c2a8@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
 <178895594761.219967.4769482322073838475@kernel.org>
 <c863e105257ae512d32e94b56ac081c41c4284f6.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c863e105257ae512d32e94b56ac081c41c4284f6.camel@linutronix.de>

> > After an unbind or rmmod, does the core keep inserting SDSA source-port
> > tags into every frame delivered to the CPU port, with the tagger that
> > would strip them gone?  As described in the commit message, the same bits
> > also keep the user ports in CPU-directed operation:
> > 
> >     "Enabling this tagging feature of the switch, places all user ports
> >     into CPU-directed operation"
> > 
> > so the switch would also stay locked out of normal port-to-port
> > forwarding after the driver is removed.
> 
> Yes, I had not considered this use case. The tagging state currently
> remains enabled after unbind or shutdown. In v3, I will add a .teardown
> callback that clears both SOCE_TAG_ALL_FRAMES_ENABLE and
> SOCE_CUSTOM_RULES_TAGGING_ENABLE, returning the switch to an unmanaged
> state.

I would say the AI is wrong here. If you put the switch into unmanaged
mode, and don't have anything performing spanning tree, your network
could experience a broadcast storm and stop working. The .teardown
should disable all the ports, leaving the network in a safe
configuration.

	Andrew
