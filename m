Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C693EB80E;
	Wed,  7 Oct 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397991; cv=none; b=tLiRXkSWgsxNlBrKxtLZN0UWoPQr2n4EqnoTOaMs4/yr20N5GxbxBWAuA8jIjmMNmhli1M3Y9nY1s313wIKBLKCyRbtFRBkY4JqFcRS5wFArUo/HP7UgWvZwI5y9UQq57AdOpFY42Io8xXJZOwR5u/bsFmAIY72DhdFUGEGY+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397991; c=relaxed/simple;
	bh=IrHem+qcZdg7O3mkd/kbCHY0FVwKgcWMCKdi3X9qIoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLob+1tcvWlG1ugyBEEwUtsB4cRFfPlGBkZDAHbBegqjGPl0tJCtBGHTX/CnyF5TWebrzCV/UBmhk/EI56aAXcFOR5giUDV07yfjskw+hL6DK8AY3DfvDxWLTUZPuBEWknZoftQP3NILS1X/IrWEf2rGyOzV5HAF9d184B8S730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0SuPaxNt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0SuPaxNt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bA1Tyu08pBfCHkqfVoKs1WHfW1LeJHm5dUdedfcw7is=; b=0S
	uPaxNt/vCCuu7MdtJDS+918gtrDICn2cOkDC3jELsQg7udTEo0dJJ1fCy7AKVgx8WTTqVo2MlEAub
	Xi7TvzUGejx/NwLPyWVpGmz7xTJcLW6b9KL0wn/TGLJA4p1l5Cma/Lf1K/C2INK6a1pZXbaTF2/mx
	LLbwUTS3xdszLBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEWRk-009VAD-PW; Wed, 07 Oct 2026 20:32:56 +0200
Date: Wed, 7 Oct 2026 20:32:56 +0200
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
Message-ID: <98a7f952-37cd-4886-acb2-e87743e51fba@lunn.ch>
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
 <179127056620.2231598.8882282421523696709@kernel.org>
 <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org>
 <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
 <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch>
 <CADvTj4pm8fbgGDiyXVHubnM93qOey7o18O+MDU68MSisXVvHtw@mail.gmail.com>
 <f304ee6d-bbc2-4f76-964a-998c3febb8dc@lunn.ch>
 <CADvTj4pniuLUzsHP_kv03rFUkUD87PD9yVZ=HnW0CsZX78OxLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4pniuLUzsHP_kv03rFUkUD87PD9yVZ=HnW0CsZX78OxLQ@mail.gmail.com>

On Wed, Oct 07, 2026 at 11:00:50AM -0600, James Hilliard wrote:
> On Wed, Oct 7, 2026 at 6:46 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Tue, Oct 06, 2026 at 07:27:05PM -0600, James Hilliard wrote:
> > > On Tue, Oct 6, 2026 at 6:57 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > On Tue, Oct 06, 2026 at 05:17:20PM -0600, James Hilliard wrote:
> > > > > On Tue, Oct 6, 2026 at 4:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 6 Oct 2026 01:14:52 -0600 James Hilliard wrote:
> > > > > > > > Please do not repost the series just to address the above. Instead,
> > > > > > > > reply to this email with the missing information, so that reviewers
> > > > > > > > can take it into account. If the series needs another revision for
> > > > > > > > other reasons, please include the information in the commit messages
> > > > > > > > then.
> > > > > >
> > > > > > Please make sure you read this paragraph, to the end.
> > > > >
> > > > > How much detail should I be including?
> > > >
> > > > We want to decide should the patch go to net, because it is a real
> > > > problem which bothers somebody. Or is it a theoretical problem which
> > > > will never happen, so we might want net-next, or maybe /dev/null.
> > >
> > > I mean, it's in an error handling pathway that could be hit if there's
> > > an -ENOMEM error on an IRQ-action allocation.
> >
> > ENOMEM does not happen for small allocations.
> >
> > https://lwn.net/Articles/627419/
> >
> > So at first glance, this seems totally theoretical, it will never
> > happen. So net-next, no need for a Fixes tag, etc.
> 
> It looks like there might be a few other ways to hit this cleanup pathway,
> not sure how plausible this is in practice however.

So lets go for net-next. If anybody hits this for real, we can
backport the change to stable.

	 Andrew
