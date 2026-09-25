Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5B39E6FD;
	Fri, 25 Sep 2026 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362922; cv=none; b=KSxElCn2tV6NRM/HVeB2uMIx6r3ao75c/RNuz5NmJ/hL5zKqIDnNJtQvw3ap3CkYoT8MbR9qnNBTSR/bvvbnBhRkMJCMBDwrzvalqann7DYqAudqGHX6MobYzFmsopH7PJu1wwmod9X9H942q5CLomPJeXrOct5ar00UoS5U4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362922; c=relaxed/simple;
	bh=kTRqA4x8h+EttCW4HQTHJumhIe63XCCzl3rviK+px0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKnMXzOOJxQfWYyrUBnhjIqWAVRVs6A9duD9QBIAQDS5huO0YBPATPQQmg1R9CJcXPzR4XqyCx7exN+WWkWsre7Gy2SIw109C6gjnsqnl8JK75vm5Nzb5Mt1o8osUWaHa85FTwrkwIFrfOSx6DYyk/l/6GlP6I40qw7rcD6RvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eizWHBVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eizWHBVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043371F00893;
	Fri, 25 Sep 2026 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362913;
	bh=L7jBqRuVow1pTK1QW3KvYR+feGMWG5tCnOJP2zqQ6WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eizWHBVfzMRnMM2VahOUDum7IK+oWd4Io8ruN8OXqLzIhwZuP+iU2j7dNW604F6zy
	 x1G+7UhBjUh2G8v1M9//fDme4bGcJ+FLU2oQaVmSYGFKJx1N5H2AcuGfVvYsRvEle6
	 l4lzijo8NfjJA43vIrRCEj+DNhm0PimW1P59lSpUu3JsOGyDAN3etbjWyN/ic6/DMh
	 w8jU3j2q74bT5H4u2OGNf468wHHr/9zmDkLMEdr0URrkJF79rBN0r8tu6t08ke1Fin
	 ZdiKZPUpP8yK50Sw6YOHxYWbMLsB0XiIyykmmdPCiE8ev+/EWy7vvJEJW3k/FuPlcn
	 3rxVauvHCc/kw==
Date: Fri, 25 Sep 2026 12:01:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, Karl Mehltretter
 <kmehltretter@gmail.com>, corbet@lwn.net
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mchehab@kernel.org, skhan@linuxfoundation.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net_shaper: fix kernel-doc rendering
Message-ID: <20260925120152.09ef180c@kernel.org>
In-Reply-To: <d461b048-b08a-4bbe-b5e7-60ed6686ab52@infradead.org>
References: <cover.1786751700.git.kmehltretter@gmail.com>
	<178700041013.1735578.3422132046076853057.git-patchwork-notify@kernel.org>
	<d461b048-b08a-4bbe-b5e7-60ed6686ab52@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 16:13:05 -0700 Randy Dunlap wrote:
> > Here is the summary with links:
> >   - [net-next,v2,1/2] net_shaper: fix kernel-doc list indentation
> >     https://git.kernel.org/netdev/net-next/c/09b7c00d55a8
> >   - [net-next,v2,2/2] docs: kerneldoc.py: preserve headings in kernel-doc output
> >     (no matching commit)
> > 
> > You are awesome, thank you!  
> 
> so these 2 patches are merged into net-next, which should be merged
> into mainline Linux at the next merge window (in the 2 weeks after
> Linux v7.3 is released).
> 
> Patch 1/2 is in the current linux-next daily releases.
> However, patch 2/2 is not merged anywhere in linux-next AFAICT.
> 
> I also would like to see patch 2/2 merged...

Sorry, maybe I should have called it out more explicitly instead of
expecting people to read the pw-bot reply. Yes, I only took the
networking change. I think it's easiest if Karl reposts the other one
for Jon to apply? (without tagging it for net-next of course)
