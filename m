Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C3388E6B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219415; cv=none; b=a2gxT0SABED0vwrtAhZnYjn9G8z7YGd4QPqUcRGNAZIJZ94vvdsmgpNfw8w9b9urZRraJ+S4XURrMbWvBdKVh0WSww4dl97qhOumGSc3KJTIXrI3TgrX3n/p+PqbWb47KuERuXPWnrCEhqqAqL43g7ZSFZD7kF5JgYX2CUk3STg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219415; c=relaxed/simple;
	bh=h9JmDogsSn3UFTddTluSRqDbonS0aqFqEUzFH6UoXLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EC12juKtDHtE3jRBrb5nKgO5yR55YTa/nyder3NSyuapbQB4yIdV/Zek1EgzQBbMPhsT7rOZHI7TcwurGPorq171y0uwn7sNI4w90efVbB8abwsmZ/JLBP6oTd+q3KW+Ng3c3ThTh7KabeSqqcE054bB+ioS1b+lbhRQQVFCKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0U1RSyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0U1RSyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C21F000E9;
	Thu, 11 Jun 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219414;
	bh=zbqn6xqCjRKdAH1tAbnTzaXYwF5sfXjGk6OP/nL3raA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X0U1RSyPdAWQIFI6NR7MnYLjdYAoesErboKwXB9rBM5h9J2atU4Uqwx9wmXsN2uy1
	 aA29aVME968FoZN2flHl/9PxnSoUEs7Ujm2Gr1BEDjpPfXKLJJ2SW69Bo+4ZkLzkBH
	 446xTHHpR3XawZ1iecylMZ7X3I2QVnyhqKSJGtPE+SZ6e6zrVBhBQwx00AOD8tTjTv
	 SSZqKEZdiT1wJVKLKAuzgXEWURO36Eza+egQyHU9NkhlgWTpR4AXZ9V59PI5UTGiaN
	 igAeridZ/6eGyv2W0jWFf0TniBWcLTHo843POCpBq3kRREck0Ft4mpUon0FUBShWk2
	 oXA1S152hVIVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567DB3930FB3;
	Thu, 11 Jun 2026 23:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_hfsc: Don't make class passive twice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121941114.401113.716094225489847142.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:10:11 +0000
References: <20260610132824.3027549-1-victor@mojatatu.com>
In-Reply-To: <20260610132824.3027549-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, anirudhrudr@gmail.com, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 10:28:24 -0300 you wrote:
> update_vf() is called from two places for the same class during a single
> dequeue when the class's child qdisc (e.g. codel/fq_codel) drops its last
> packets while dequeuing:
> 
> 1. The child calls qdisc_tree_reduce_backlog(), which, now that the child
>    is empty, invokes hfsc_qlen_notify() -> update_vf(cl, 0, 0) and turns
>    the class passive (cl_nactive is decremented up the hierarchy).
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_hfsc: Don't make class passive twice
    https://git.kernel.org/netdev/net/c/90b662ea25f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


