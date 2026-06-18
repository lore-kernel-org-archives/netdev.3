Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E233D75D3;
	Thu, 18 Jun 2026 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769738; cv=none; b=fb80ta8AuoOMUaorvl3CgCaqpQGQR2xKdM+or+02KsfhaRVh53ac2PiXOQdD4wvMzp6TxkwMj1vac6OCwN+sfEDV9SWIeDpT97SieGaJDfaNDkXtYKO43feXVY5f45kZm0ulnA6klhKHMegry2Ye4/J9Us0SAnpYZwKXMA0gQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769738; c=relaxed/simple;
	bh=xp4tTI3hQOkNRqkPW4jgw3L5Am7roxd8iEf0HQQr+Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+lVXfrM/xU0xy/eDzpn21PLba0buWqa6dRubcZDsh7aAEkX0MTUN4qaF54xhH6iQ4UmiwjZXM0TVscr4bLN0ztwwvNtkgqgTQaT4OivwMSMwUmD88u0ZDJ/wafiHMi50VGhv72h7n9uZCaHeb380KEa8xmxY4mlSVNrN6NcASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LW+ddLGK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LW+ddLGK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2voqrgEApl3hIFJ06xFwhIwE/g8LBCEOl7qjySZCqms=; b=LW+ddLGKxdV1h2RvPd/Xsci0X0
	rcoxdFyymM9ZM1FayKR1jQVo+V93Jdyx7IX/LxXuNlk5xaZ3M6IJnRXqF1OzYrrZoT4ZBuml2kxv6
	InlbBdp22qDbCQEH3Lr7fff2Gl6N0CnqpIoEIBhNtfAwUFFQFV/a4ZAXlSQPGqAbQoUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wa7gx-008J4F-Gs; Thu, 18 Jun 2026 10:01:39 +0200
Date: Thu, 18 Jun 2026 10:01:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Carsten Strotmann <carsten@strotmann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Carsten Strotmann <cas@strotmann.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
	mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
References: <20260616084901.3319d82e@kernel.org>
 <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>

On Thu, Jun 18, 2026 at 10:55:54AM +1000, Finn Thain wrote:
> 
> On Wed, 17 Jun 2026, Carsten Strotmann wrote:
> 
> > > _Someone_ has to handle the reports and patches. And since nobody is 
> > > doing that the code is going to GitHub, where it can continue to "just 
> > > be left" or whatever, without racking up CVEs for the Linux kernel and 
> > > leading to maintainer burn out :/
> > > 
> > 
> > That's a good point. The large influx of reports is a problem, and burn 
> > out of maintainers is a too high cost.
> > 
> 
> Carsten, if, as a maintainer, you want to avoid burnout then

It is not necessarily Carsten who is heading towards burnout.
appletalk is just one of many many drivers where the listed
Maintainers does not respond to patches, or there is no Maintainer at
all. So a lot of work falls on the top level netdev Maintainers. In
fact, a lot of the AI driven bug fixes tend to fall into this category
of old drivers with no active Maintainers, since that tends to be
where the poorer quality code is. So top level netdev Maintainers are
having to do a lot more work, on old drivers which very few people
care about. That is a poor use of their talent, when we actually want
them working on drivers for modern hardware with a lot of users.

If the appletalk community can take the workload off the top level
maintainers, respond to all patches within 2 to 3 days, give
Reviewed-by, or make change requests, it can probably stay in the
Mainline kernel. Otherwise it will move out of tree.

     Andrew

