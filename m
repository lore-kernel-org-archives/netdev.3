Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A97480354;
	Thu,  4 Jun 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581610; cv=none; b=FJBVKVqGuVZLIss+x/Uog07gI1lqUt7jUKR3+ugLD7XTDW/hBa5nT3PRRNyZQ0K09rBcoOxgwAxAoCxC63SKnwMN/+nFMwe11R9Kp43wmBFyL/V7pl1u8l0zu8e0pC72SCEP2X3r4UO34ybjjY1w4wor4vB8HPf/dzndzmuYGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581610; c=relaxed/simple;
	bh=8MMB8bFJ8LNC1D+1B0HLn2eXpH4+sY71iCNWI8FmUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+1NkKXWkHPDaWrTJ1TxbgDYsVSIDwZWiLemqLwnr0bJPmT6DneYOSIdJHJIPwZdX8ggHaw24ww4jI1IAqjtvGKoCQANjkqxFtQao3V7Qnh2paH/S8I+EePoDJbooUNSDkY4ISKa6IoZgfRd8v1fcu4+80+AUxJMQtQ/C72M6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PRDVeNsg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PRDVeNsg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nRBXMkQp51i7rSpx936ZuKTdmIEGW7cKA2P/HWYWFKw=; b=PRDVeNsggkUUq/F72LhcBMaGvL
	JSOS40/4rE0eWpZqQ5IVcWAK/BQ/43IQ9h44uKlqZQxC1LbeCa0CdjSE2/nwIx/FOTvwTZaN+pjgR
	PMIda75u6ERrSw/l52txx7HkXVMqJrw4pAI9+uWXybSfwZgPlU9KOH/8zdo+5uixESfJB1FQDqUB7
	ZktNd2UnIWlL1I6GQsJmMH9DU0U4EaEw/UdxpTkxvT+lfy0F8m66AuZE8pUxwJeAn/IlgRJ1iVJEw
	sXwwpLEkc4s83lmn3a4O6nAnadI9sdPWNJ2YX2CuVy7dhMHQTYg6zkz3utzd4KwK6j0GHTAZFFiBq
	81+GNDDw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV8bs-004Z6A-10;
	Thu, 04 Jun 2026 13:59:49 +0000
Date: Thu, 4 Jun 2026 06:59:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/3] netconsole: Fix reported problems
Message-ID: <aiF-SG6mhZBt2jaF@gmail.com>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
 <20260604130622.GB3920875@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604130622.GB3920875@horms.kernel.org>
X-Debian-User: leitao

On Thu, Jun 04, 2026 at 02:06:22PM +0100, Simon Horman wrote:
> On Tue, Jun 02, 2026 at 07:26:56AM -0700, Breno Leitao wrote:
> > These are some of the issues that LLM reported to netconsole, and they
> > are being addressed here before big refactors.
> >
> > I was doing some big refactors, and got some "pre-existent-issues"
> > during LLM review of the refactor, that make them hard to guarantee that
> > refactor is not introducing any bug, so, let's clean these pre-existent
> > bugs first, and then submit the refactor.
> >
> > The issues fixed in this patchset were reported during the review of
> > https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/
> >
> > Not all of them got fixed, but, those that were easy to reason about.
> >
> > Why net-next and not 'net' tree.
> >
> > Most of the functions that are being fixed here moved from netpoll to
> > netconsole, thus, fixing this on net will cause merge conflicts from
> > 'net' to 'net-next', thus I decided to fix it on 'net-next', given we
> > are on 7.1-rc6 already. Sorry if that is not the right approach.
> >
> > Changed from v1:
> >   * Change it from 'net' to 'net-next'.
>
> Hi Breno,
>
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
>
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly effect this patch-set.

Ack. While most of the reported issues are pre-existing are being fixed,
there is one genuine regression: invoking WARN_ON_ONCE() in a potential
NMI context is problematic since it may trigger panic_on_warn.

I will send a revised version.

Thanks,
--breno

--
pw-bot: cr
