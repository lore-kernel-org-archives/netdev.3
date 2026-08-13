Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825A2EEE79;
	Thu, 13 Aug 2026 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581063; cv=none; b=P/EwOOoWR8yPQ7hSWgOojudld+EWQ9/UB2xwIwAEe2V85MeYB+3Mmr4HiG6eEehgS4DDzDGH70qSTgm1WApbTInDwQwXZJlMklFEHpfIG9t3MgzLOBy6h4f8h5N9I3dhfn/p0U7DBbymUuGG+96tsI7sW7kwDz0XqDlyHL3E9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581063; c=relaxed/simple;
	bh=I7yhrULtIM0r1GrGCO3ERozlQzcK98nGb/pbFz9pAGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWrARlkWCbkqYLfWVrAy69okBXEXTCYc1qO9tCyFqA2Ns7xPE2qJaCNgyZ+OgCu818fz3rhrShLy6XvwYwa/NSlqet8AZZ4kh/frtwWuc8U7W0m0yd4dDppCrCpi/XgtiKreRle1Aq2YJOlJwbB6wmgVsRI1T32f7KpIxB6yZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAHgR4YF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAHgR4YF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AE31F000E9;
	Thu, 13 Aug 2026 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581061;
	bh=4GfMyZ66Fmu7No58rpg97VciLcZTABfOt9a9ojQHeRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dAHgR4YFym57+4RJlyE1QNs8to5QMndzsziYHEx3jEF7F2wFaH1kZzFKxFcxRjlIi
	 zlZ1isko6j1J26C5iqpGvmRLvZGuIgsUy96mM8u1SCsL5QE2ZMRU2VjxHzpcLLClWf
	 VFD7veW9Dc6LtzVW9Fuk7omHf+NYqzfw6q3hHz/8NooIAA4qIXPyJ3tax4WThj8G5e
	 w2ql5UMi0WN0yFJ2GSWxBjtCJmVeAQY76Dt9NSy79YvZ8R9oSeBnKzFKz+3SmWqk4E
	 5NvhPw6HNpumc6WGzprjmtWvs/N5n3GbzQJdl2b4uV2cdeP0y0Cgixq0Ty9h8RtdqZ
	 2EC6FPRTajkwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56894380CED0;
	Thu, 13 Aug 2026 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: annotate lockless queue empty check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658101588.2163205.3438866615251096333.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:30:15 +0000
References: <20260811060236.322284-1-qingfang.deng@linux.dev>
In-Reply-To: <20260811060236.322284-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, norbert@doyensec.com,
 hataegu0826@gmail.com, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 14:02:29 +0800 you wrote:
> ppp_poll() checks whether pf->rq contains a packet without holding the
> queue lock. skb_peek() requires appropriate locking or a private queue,
> neither of which applies because ppp_input() can enqueue concurrently.
> 
> Only queue emptiness is needed, so use skb_queue_empty_lockless()
> instead.
> 
> [...]

Here is the summary with links:
  - [net] ppp: annotate lockless queue empty check
    https://git.kernel.org/netdev/net-next/c/095887cb96a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


