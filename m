Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F43BBA04
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444631; cv=none; b=EDd0qCxv0Eo8tfSL0VJcdtTLL4N1C6sOB4cu2YB8p1s/bITpP5oMPAqYVtesT15MDCSv9yGOSeorthyj/gFAhcoeP3vgHqnm76+qpuunSmwn0I3KeQwmLe4ESNYRIVCPqutGb1aKbTcNuSzUlU8tmUd5fpjkJEJ6OW359GYhpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444631; c=relaxed/simple;
	bh=LJX2nCqARKuPOp+0AXCPLowxKogPqOqrxjJCDjWMdFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkPfaMLNCbQHhdnSfj0w0xwGGnt9SCgD0O4QmJ2GmQKf1vjIiUN0270BvMs2vGWnMUfc7yIHaaqMxaDLt46XGTvkr0Ti0/UWDUsrrVuH9CY439VrvLLLqmNwKCYVFeOs+hMxpVSZD5cHawZlaumBa1Y8ty4C9RNNO7d0gbXPF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKSQIfi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKSQIfi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F641F000E9;
	Thu, 30 Jul 2026 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785444628;
	bh=9QCKuwrtyd7I9iR3Ou1IzlQBa2Lv3qDqs2xqynH12DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EKSQIfi7NVvXPiybw43bKG3PA4CRZlSHpisVtHo6xrLnywRmNKv8ABnTIlgBVSi3K
	 ZVirC+jlDclpja05mWUk7Vo0kL7kNnkKvAcTkuiF/BQnKTCR/85HheJaCyFlcpuWjC
	 lgci2sJxdc+f+DOHqVocmYufsXaF6lFSNaMRfLux8cl8Z83j6u+PV/NSwg3Vxiwvr1
	 H0QXWkXz4xxIpsQKXYajnmoyp6f2crJ7gepmTOfyvwmLVvzt6fbbRaSSYOw9igrQ+l
	 6KL3ulhJtmszvrBYYlBIoUO4DeS4eWGRyT4wkjidvvcqnSBumekxtTWieCof+Ro3b6
	 rXFkmAXjbc8BA==
Date: Thu, 30 Jul 2026 13:50:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <20260730135027.6252ed70@kernel.org>
In-Reply-To: <amtb096CVcSxaXeX@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
	<20260727152517.312895f3@kernel.org>
	<amgBCpqbkrEIiCuh@krikkit>
	<b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
	<amkzn_79gJWAjGEV@krikkit>
	<20260728160820.3860b3de@kernel.org>
	<amtb096CVcSxaXeX@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 16:12:35 +0200 Sabrina Dubroca wrote:
> 2026-07-28, 16:08:20 -0700, Jakub Kicinski wrote:
> > On Wed, 29 Jul 2026 00:56:31 +0200 Sabrina Dubroca wrote:  
> > > If that's the case, good. But "quote this text at people until they
> > > comply" and "get an AI bot looking at all patches coming in" doesn't
> > > sound like that to me.  
> > 
> > IMO it's really very useful for reviewers to know if the author
> > triggered the issue.  
> 
> People usually add that information if they did. If it's not present,
> we should assume they didn't, and treat it as belonging to the "AI
> report/other-tool report/code analysis" bucket?

The ask is for info about discovery, repro, test.
The sentence you quoted is about repro, you seem to be talking
about tool.

I think all 3 pieces of info (discovery, repro, test env) are valuable.

> > Also, for downstream backporters it's useful 
> > to know in case of conflict whether to invest time in resolving
> > or the patch is mostly theoretical and waiting until next major is fine.  
> 
> For downstream backports, there can be a number of differences that
> make an issue either easier or harder/impossible to trigger. But sure,
> that's a useful baseline.
> 
> 
> If we could reword the statement to include something like (with a
> formulation/presentation similar to your patch, this is a short/ugly
> version):
> 
> Fixes should describe if and how the issue was triggered/reproduced.
> This information should describe how likely it is to happen in real
> life [stuff about delays/fault injection/etc].

Here we'd ask the author to judge likelihood. Which is hard and takes
effort. My goal was to ask for pure information, no thinking effort.

> If this information is
> missing, we WILL assume the bug was found through code analysis
> (whether by human or tool/AI) and not actually triggered on a live
> system.
> [something about such patches being penalized in the reviews/queue?
> I don't know]
> 
> 
> my concern about having to add a bunch of uninformative text would go
> away.

I feel bad enough accusing people of using LLMs (even when they
_obviously_ do). I don't want to accuse people of not testing their
fixes based on information missing :( I'd rather first ask them
to add such info explicitly and then shout at them :)

> > I'm also guilty of not adding "impact to the user" info, but that
> > requires thinking and theorizing. The ask here is to purely state
> > the facts.  
> 
> So just something like "possible UAF/memleak/deadlock/some unwanted
> behavior" is what you expect here? That's totally reasonable. I
> thought you meant something more abstract.

Right, my patch doesn't ask for impact specifically.
But the direction is right - ask for info the author already has rather
than require the author to theorize about likelihood and impact, or
do extra experiments.

> > FWIW the immediate trigger for me is the people who started sending
> > sloppy fixes to drivers that nobody uses. I ask them about the
> > discovery process and half of the time they don't even respond.  
> 
> Sure, I get that, you're drowning in pointless slop.
> 
> An alternative could be an AI bot that looks at "fixes" and checks if
> they're likely to ever happen (or have a measurable impact. a tiny
> memleak when a device is initialized/module is loaded, even with great
> reproduction steps in the commit message, still falls in the "don't
> care" category IMO). My experiments with "find a way to trigger this
> code path" have been pretty good, so I guess if the bot comes up with
> "basically can't happen", that would be fairly reliable.

Yes, definitely planning to do that too (once I figure out how 
to squeeze some free tokens out of the current pipeline :/)

Still, I'd also like to ask the author.
