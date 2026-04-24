Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975614AD0D;
	Fri, 24 Apr 2026 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000230; cv=none; b=uA2vP3EEdd0uJewDLuwEYP34bTKPEuF+cjJM3OkK7IoYSi/u6XgHy8oXqlPS4eJJG5XVtrcB7Psb4ppWoCTFrirxCmBJIqHsjK30aR85DPmjugz9qHKBoGkhQdw1kYQ8VbBELQ2bIMCO/r43ndPZ3nfkggcruPdh/BgfkPHFUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000230; c=relaxed/simple;
	bh=rmyUHrOfGLiTpK21CLG4JBnvaelp0lEtqim+y++Yb4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvo3vDOBUHeFIhjZ4Z0sLTxVOIRF+LRluDvbdaOvIGPt5qL0ye2BT2hrsAYTPwnaRbtEomG++aECHZKlRVE94i9v/79sdGs9W0ztn7l9MiuNTDjJP8Gzuq1rnldLBFWqQrDNiyRJWFoJC9vk0JbKrjXPkisDrZUIKkrs9kuSs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfJxfhf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfJxfhf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10631C2BCAF;
	Fri, 24 Apr 2026 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777000230;
	bh=rmyUHrOfGLiTpK21CLG4JBnvaelp0lEtqim+y++Yb4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfJxfhf9egcGKeRPLtvip/b5NYTSFUy1iiAi/As3souWfBNoQmA6xSEOp/JAOku8K
	 dkhOMMfo10if4DB+WTtVnl89FsPGs+I3YRDMai7CXL5P0ltREUW3c1NnDp4LEmL+6j
	 el7Bc6a7bYLw9kHFaTK7lShJY6be1JumW57AT3MYSTVafed1P5hfsTtECvn4xv9asI
	 yUTRDshUnGp6x7spvxo677UjWMHcMaCBtey8Mk/DXEWg1vzo1UUCC3e5PoZuH67RZf
	 59wfECgXBorpVw7s9I5kqjWhBTXkuphyQp6l+NphrkgjopF7AFYauH4w9HJR66mUm/
	 0UfpfhlOyyzxQ==
Date: Thu, 23 Apr 2026 20:10:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Networking deletions for 7.1
Message-ID: <20260423201029.64927aba@kernel.org>
In-Reply-To: <7ia4se8lb0vf.fsf@castle.c.googlers.com>
References: <20260423235422.1541768-1-kuba@kernel.org>
	<7ia4se8lb0vf.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 01:31:00 +0000 Roman Gushchin wrote:
> 2c on Sashiko:

Did I say Sashiko 3 times? ;)
FTR - thanks a lot for the awesome work on that project!

> 1) I'm working on an infrastructure to separate pre-existing issues from
> new issues. My current thinking is to stop reporting these issues with
> reviews of new patches and instead put them into some database and give
> maintainers access to it. Sashiko will automatically deduplicate issues
> and index them by the source file/subsystem. Hopefully it will mean that
> maintainers will see only a limited number of issues in source files
> they support. But I have yet to see how it works in practice.
> 
> But I'm somewhat concerned that this way many of these issues will
> remain there forever and by reporting them with new material we actually
> have better chances to get them fixes. Maybe it should be configurable
> per-subsystem. I'm very open for ideas here.

After a couple of hours of glasswing-inspired hacking today I wonder
if we can close the loop on patch generation without blowing the budget.
Or maybe a better question would be - how many of the issues are simple
enough for the LLM to pop out a patch for, once it has all the context
from the review.

> 2) Re false positives vs finding more bugs I had the same experience.
> It's easy to tweak it to be more conservative or creative, but it comes
> at a price. It seems like the real answer is simple a better model. We
> saw a big improvement internally switching from Gemini Pro 3.0 to 3.1.

Makes sense. What didn't really land for me until now is that at least
for now different models are better at catching different types of bugs.
Off the top of my head, Gemini does short work of misuses of DMA API
without much context. Claude/codex/whatever the Meta one is called
externally - none of them catch those.
