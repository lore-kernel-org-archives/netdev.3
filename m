Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF35329E7E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280102; cv=none; b=eiwWPg7rmJVCFxZvBKrmC7EwXePZX9CiwCbh+emHgc1CRrxKIhdQ35yD/ThsowWGNvJsj4pExP0ndnB2aBkNA0VPTKsD0jc5UzBDuiLYbtLwGyfflZH/7mH2mtjIJvgBN09+4HjIaX/92MUFmkXjjgwaNrfXc3MvGSIusxD5F4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280102; c=relaxed/simple;
	bh=ohz8Gxs233ZdSQcMn6bjrp3dH4P1/xS5cNBTyZUvQFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8N+4yRUCaKRLptZ8e1kY5OGSbL6+rJba+yZ5Ds/O3WoXKEXzeiPWpFmIjmCGngjNeY8WiTuAaPVLPCp4NP3HVHlM8bU4u/t2qsa2y69im+kNT+IxO3uEuV+C1GzYRoXhc58Q4mHy5FuV7FzijMo4+wI/yhIbpKCMlR3sdXzel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRK3GLCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRK3GLCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA701F000E9;
	Tue, 28 Jul 2026 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280100;
	bh=kBBHdQykkYoYfxT63VOF9CStakFSG38+W//sF1aV1uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SRK3GLCkVBxAtU/w16m/3Q53L1wj3UI5O+JK9gsTO6wrOM8kC5ToAmdnI/7pN9FpR
	 pPIDJbBXauOTFu6VTTzZlx1fmPKjLrjXn/h3sKZi3J7lbfHP19hDE5D1PNp0Iedre/
	 gNbqLV+cjkbwOenLQSN4ZLt1hfab152FtZ71n2GqfIFlMGnEWj+9p4Uy29xI5Rfa3A
	 7PmFCUe0FivcY981Do2hqniB4hoIuPsTnx8DJg9pDlasDob3XUfs/Yr9VdJ0kajmHx
	 upn10xlzQ0gwsO6osrQuFq32LfYKfBTuRtb+VwtBjEolwAHAukIoMLeQzlpuwEtJeI
	 PX8jR//2oXnNQ==
Date: Tue, 28 Jul 2026 16:08:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <20260728160820.3860b3de@kernel.org>
In-Reply-To: <amkzn_79gJWAjGEV@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
	<20260727152517.312895f3@kernel.org>
	<amgBCpqbkrEIiCuh@krikkit>
	<b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
	<amkzn_79gJWAjGEV@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 00:56:31 +0200 Sabrina Dubroca wrote:
> 2026-07-28, 18:17:27 +0200, Matthieu Baerts wrote:
> > > I see what you're trying to do, but making regular contributors append
> > > 2 paragraphs to their commit messages (or ask their LLM to generate
> > > them, and also fight for an hour to get a reproducer that actually
> > > does something) just to check the box seems painful. Reading the git
> > > log with all this stuff mixed in will be worse.
> > > 
> > > As someone who's probably never sent a compliant patch, and who has a
> > > tendency to forget new rules (especially those that are inconvenient):
> > > meh. I don't think the commit messages we've been writing all this
> > > time have been so bad.  
> > 
> > Are these rules mostly for new contributors using AI to generate
> > patches?  
> 
> Based on the commit message, I guess yes. Based on Jakub's reply, I
> would say no.

Regular contributors sometimes also act on AI reports with no hard
proof. That said, it's always entirely okay to say "Found by code
analysis, and fix is untested." For regular contributors the reputation
will outweigh the testing. For everyone else we will ask them to test.

> > I guess regular contributors are already applying these rules,
> > either by using a Reported-by tag, pasting a call trace, or describing
> > how the bug was discovered, no?  
> 
> Reported-by doesn't describe how the bug was discovered, just that it
> was discovered by someone else than the author of the commit. It can
> just as well be an AI report, CI testing, someone else's manual code
> inspection, or a "real life" bug.
> 
> The call trace could have been produced by adding delays to help
> trigger a race found by code inspection, or seen in real life but not
> reproduced by the patch author.
> 
> I'm not sure code inspection vs some tool (AI or not) makes much
> difference, at least when the patch submitter has enough experience to
> check the output of the tool before writing/sending the patch.

Fair, I couldn't think of an intuitive category which would cover both.

> Without checking git history, I suspect there's been a bunch of fixes
> for issues found via code inspection or sparse that were not actually
> triggered/reproduced. The code was obviously wrong, it gets fixed. AI
> makes reproducers cheap(er), but not free (in both tokens and
> prompting time).
> 
> "Impact to the user" is probably missing in most fixes I've sent (or
> severely lacking, ie nothing more than UAF/memleak).
> [a few examples: 52501989c762 cbada1048847 5502bc4746e8]
> 
> But I could see an argument for "well we should have started
> mentioning testing and impact to user ages ago".
> 
> > I find this important to understand how the bug was discovered, and ask
> > for a reproducer or another sort of proof when this is a "potential
> > issue found by an AI code review agent". Otherwise, that means the
> > reviewers have to do the validation, which will certainly take them
> > longer than the author to generate the patch.  
> 
> Sure.
> 
> > I don't think regular contributors have to change their commit messages, no?  

Not tomorrow, but I'd hope the ask is not too onerous?

> If that's the case, good. But "quote this text at people until they
> comply" and "get an AI bot looking at all patches coming in" doesn't
> sound like that to me.

IMO it's really very useful for reviewers to know if the author
triggered the issue. Also, for downstream backporters it's useful 
to know in case of conflict whether to invest time in resolving
or the patch is mostly theoretical and waiting until next major is fine.

I'm also guilty of not adding "impact to the user" info, but that
requires thinking and theorizing. The ask here is to purely state
the facts.

FWIW the immediate trigger for me is the people who started sending
sloppy fixes to drivers that nobody uses. I ask them about the
discovery process and half of the time they don't even respond.
