Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765F30C168;
	Wed,  7 Oct 2026 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334642; cv=none; b=lmCBRTstuKOOgNMQbpDA/aztdIR5ajyZgJUtBn85+swrVqQI/q30lJGtQLcAaoZBbOiq52l8nn0Vfd+aixissJUHg+c7FpnyIeRy8fobqMh1pygoI1UVdkGuBeCYzjWs/2HY6x1Ovhy/IugLyNySBRzipPFTpyNxcu0KGnzUf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334642; c=relaxed/simple;
	bh=umrUJfgBK3j0iSeQgK5NJBdj1QDJnowtukH0+Fi64rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/QpykGw3bIIPAB5v3RtII3w0IidJkM3y4jWP/K0ZaNxQiDLDyhwFdph6bUepf3oYessBw1uoL0QiCJBb/nxMSIlALRVR0rZSTB1dyHrZMqnvFJwrvw6qXcCfj7bGvyn7kWQchiMVkt462YOfFEb6FjWw8RieOpcTpR2Iu2r1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EkwM3ffr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EkwM3ffr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=e6LiwQHe9JStXBgqo8euqJ3iQ3N1ssekSUFRPrSC/aU=; b=Ek
	wM3ffr8MAZY7fcx1NpeRA1p4M5PrHgtGCUTiuD4JPWsc/OThoxXyB/UQoHkWdhltdMiib0vZIiy80
	1w9iW3QOkwZ986gZKJTO2W7gntOcJV7REuqEnTybJ8+DwB11HEjamYoVzD/e54N9zo8JOtRgG6d49
	G4sG6WUP1qYRMKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEFxv-009NLU-DH; Wed, 07 Oct 2026 02:57:03 +0200
Date: Wed, 7 Oct 2026 02:57:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety
 IRQ request failure
Message-ID: <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch>
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org>
 <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org>
 <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>

On Tue, Oct 06, 2026 at 05:17:20PM -0600, James Hilliard wrote:
> On Tue, Oct 6, 2026 at 4:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > > Please do not repost the series just to address the above. Instead,
> > > > reply to this email with the missing information, so that reviewers
> > > > can take it into account. If the series needs another revision for
> > > > other reasons, please include the information in the commit messages
> > > > then.
> >
> > Please make sure you read this paragraph, to the end.
> 
> How much detail should I be including?

We want to decide should the patch go to net, because it is a real
problem which bothers somebody. Or is it a theoretical problem which
will never happen, so we might want net-next, or maybe /dev/null.

Sometimes it is really obvious, things like a:

Reported-by:
Tested-by: 

from the same person, makes it clear it should go to net, and it
probably is correct.

If not, a statement like:

Tested on real hardware, regression solved, no other regressions
found.

or

amd64 Compile tested only, probably broken, RFT.

or

New feature tested on real hardware.

Put yourself in our position. You are the Maintainer, what would you
want to read to know it is going to the correct tree.

     Andrew


