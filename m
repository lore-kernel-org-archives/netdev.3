Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D903112A5;
	Mon,  6 Apr 2026 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490095; cv=none; b=BSp43e6T7JKW0VTiIer1AT0i+3I6kJCRYtovYvKPNjmfQAYocVaY3cNYIHy3Xghlh8xP1Zr1nlar9/Rmig4nQkDkh4GwnuLwtGQIyiLk4vEKvXaMk6ugNb8VWOEq5hGn5MlAhB7uKD8G5CQiON5hHhPujHrnMyv7eCm8Vp7NoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490095; c=relaxed/simple;
	bh=DhfAxmhe4X7ccKntu4gPwLSRXhIqRVo7WOJQzLdZiNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfwi1cYA/UCEwtQsyjzoEFb1+Kl9kRbEbMSxrfroZtvS2A3ImZeTG6xxPMpOOahTlj3o6DOAWJZLA80OYwUybS66Kb/BJGHcBDvPmfjwfhmj6aSkJkSWAIqQhqNTSbg3C8nRck2AkrNGhJKcRmL+LOcaaCXg/0HxgMkstBroAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0sghEaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0sghEaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1793C4CEF7;
	Mon,  6 Apr 2026 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775490095;
	bh=DhfAxmhe4X7ccKntu4gPwLSRXhIqRVo7WOJQzLdZiNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0sghEaKCNuj7DbPf9strUu2XiO25UoND+klZiyaZK3ihbM8rhuT+M3pZ/M8DIdPN
	 /pkegAfGYzUPzVSfo+0eKmMGf7Oa4yt25JD7AwuHBLIByQ+XqHpGbqg8vEUEU+NP0L
	 98OWnnZdRFgWIVzVw29exqEZ1Z6jytojqcejCvpL8cj3yJubH/oy7Qectp9INYeYph
	 nab6K2PQGGkMF3Rbj9L376tI6cDnfbXI6fUNd519MBIaKfl7xE7RbXUv2CIX7B3mxk
	 JQ7peSueA6uZutc6Fi5sIM1OY1l1YBL7y6j3fuJfE1MD5MGFQ3ZSS1geEJW/y1siPE
	 1oelZP26dNV0g==
Date: Mon, 6 Apr 2026 08:41:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 4/7] net/sched: netem: restructure dequeue to
 avoid re-entrancy with child qdisc
Message-ID: <20260406084133.47bcfc8f@kernel.org>
In-Reply-To: <20260404094946.GU113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
	<20260402202037.176299-5-stephen@networkplumber.org>
	<20260404094946.GU113102@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Apr 2026 10:49:46 +0100 Simon Horman wrote:
> On Thu, Apr 02, 2026 at 01:19:32PM -0700, Stephen Hemminger wrote:
> > netem_dequeue() enqueues packets into its child qdisc while being
> > called from the parent's dequeue path. This causes two problems:
> > 
> > - HFSC tracks class active/inactive state on qlen transitions.
> >   A child enqueue during dequeue causes double-insertion into
> >   the eltree (CVE-2025-37890, CVE-2025-38001).
> > 
> > - Non-work-conserving children like TBF may refuse to dequeue
> >   packets just enqueued, causing netem to return NULL despite
> >   having backlog. Parents like DRR then incorrectly deactivate
> >   the class.
> > 
> > Split the dequeue into helpers:
> > 
> >   netem_pull_tfifo()    - remove head packet from tfifo
> >   netem_slot_account()  - update slot pacing counters
> >   netem_dequeue_child() - batch-transfer ready packets to the
> >                           child, then dequeue from the child
> >   netem_dequeue_direct()- dequeue from tfifo when no child
> > 
> > When a child qdisc is present, all time-ready packets are moved
> > into the child before calling its dequeue. This separates the
> > enqueue and dequeue phases so the parent sees consistent qlen
> > transitions.
> > 
> > Fixes: 50612537e9ab ("netem: fix classful handling")
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
> >  1 file changed, 128 insertions(+), 73 deletions(-)  
> 
> Hi Stephen,
> 
> As a fix this is a large and complex patch.
> Could it be split up somehow to aid review?

+1, FWIW it's perfectly fine to have refactoring patch in a net series
(without a Fixes tag) if it makes the fix a lot easier to review.
