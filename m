Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12722206A7
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337464; cv=none; b=B8gB7de7kvgDDk4+vS1gauwDPFviLbZGqtS8tb9F8/GdkrX6rFKAKTsFgMdOT+uZsr9O4IByVixbR8/M2sYChXPaPN5mt3mMB32YtF+MrGfBYdlDOPy6o5SueJDTw0GTRhtKcN6PiD9JQsun6z8P48qSjYcvKOYqpyxd2Eary8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337464; c=relaxed/simple;
	bh=nT2fXU5V588e8PuFB1HzM5ZgdAQ5m25W76Jl2UloGSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDrmndugf+FeSXvBdtJzmyOc4Y1FDsGS056ian6Iy8DmnqqTc/K/f21a21TR4POIIY4go5ZKUC6KcTGQL8JYC52WXPqiIrVy2HHpEKuBWmhx/VClo+06A8lIUKWb/t3PeXXhcgbXCcNFW0+d0czFuGrZhDLPtHDR/ocGFzJX97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3wdXUh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3wdXUh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D31AC2BCB8;
	Tue, 28 Apr 2026 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337464;
	bh=nT2fXU5V588e8PuFB1HzM5ZgdAQ5m25W76Jl2UloGSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S3wdXUh8gdQpkmHwtKjTA95ynht+TnZGqjoj130/bS9ag8h0HoFm0S3xiyqjO3l96
	 44zA9x67xLKKcYe8ChAkLxiJsuJm0Haw3lcZZAevV2Ha3e0cSHyVdosBpeNNU17cml
	 WUGek1A188dNuE+0gFcHQikNSllRPTTXsivDC/TDXdeTN/uaHx3SgtE+sMELkZIg7O
	 4AnMb2j5dXBF3IaH6e3G4hHFQlPoSxXidRrcj1pBoznn1yMBYmXLwPqLxv6Ubwvdcz
	 9eyPhJ7EeIRVUlXg5ecqRb/AdHVJIuSDsPkjVaHMM442cbPUfChalcY9XjwBEck8GP
	 cHZLs/IR6LDwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5438119DB;
	Tue, 28 Apr 2026 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_choke: annotate data-races in
 choke_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733742130.177472.4102345239012474776.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:21 +0000
References: <20260423062839.2524324-1-edumazet@google.com>
In-Reply-To: <20260423062839.2524324-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 06:28:39 +0000 you wrote:
> choke_dump_stats() only runs with RTNL held.
> It reads fields that can be changed in qdisc fast path.
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_choke: annotate data-races in choke_dump_stats()
    https://git.kernel.org/netdev/net/c/d3aeb889dcbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


