Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693373BA239
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888008; cv=none; b=k84dJFxIa1IdHXvRO3cOTng16kqr0GW8oTh7nWkrWoR1n7prxgoKLZM4BxGebZOHws9Xecj2k3Cz73BD7D1Sy07E+mIZhyB6+SYotaMDLxBt8RibBztMpSvRgL+ECFbLuk6aA+MvHGvjxyeubUIYaGgbYu7kZBtSUGULBjWXqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888008; c=relaxed/simple;
	bh=DLvHcBTi4+mMxvRW3t9CT3LZDZbqztzv4gzxVNa6JgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mm26zGIbkQpjLkLQuITDIfKW2SVf4D25zPe0ahNgU+aTZg3Eo/luIgUtACB0+E13m6iVoYD0Lq6R7xjl7eNCM/t3zH3zK6g3PKleU9Mmiozl4z5fOskdAMn5RQrOTIKStcmoE8R+B27wy4Ci/ZOhCmab9FGAsFD+qUyVDNBLIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kun5SHEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kun5SHEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0941B1F000FF;
	Tue, 13 Oct 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888007;
	bh=H6s5PoQH63cXrqCg6FQPLS+VDIFhuJE/OUjMFp7p70I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kun5SHEuUi7gAwjTdEUSZJM0fHvYE1M3Q66wqOmSIAovKgruBKVk9bxW8ADlt14wf
	 e1/a8aC9cbbwIsW/ClGSnK9VGTnusS9hH3shRTCzv3jCxXgR5y1rnM1ypX0lTIIMKR
	 Nat8UXxDh3+GwWXAtMn/L4LMiz7GUN8Arz9aZmJ3LUltwcK7EZTftRB2qNYfv5t4wO
	 j1BmWABfmGUoIBCaNBGwjvTvZe9V/G/EP0pZV4GLqdCclXNra/+Oztibjs+ECscqXK
	 kA9Nab1ST/PNCQgbMjWTj1XwaSF8q9wAuAtwV5zkPOywoQ90QkqHIP2faAshH9EFjd
	 ffawnU5LzBUYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F144A3927046;
	Tue, 13 Oct 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Report netns cookie in FIB lookup
 tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188800577.210833.13706895255027341041.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 10:40:05 +0000
References: <20261008133158.1438907-1-idosch@nvidia.com>
In-Reply-To: <20261008133158.1438907-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 daniel@iogearbox.net, petrm@nvidia.com, ferenc@fejes.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 16:31:55 +0300 you wrote:
> The fib:fib_table_lookup and fib6:fib6_table_lookup tracepoints do not
> report the network namespace in which the lookup was performed, so
> lookups performed in different namespaces cannot be told apart. The
> recorded PID does not help either, as lookups in the receive path are
> performed in softIRQ context.
> 
> This is a problem, for example, for netns-aware tracers [1] and
> multi-ASIC systems where each ASIC and its ports reside in a separate
> network namespace.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] ipv6: Report netns cookie in fib6_table_lookup tracepoint
    https://git.kernel.org/netdev/net-next/c/ffe378c06c10
  - [net-next,v2,2/3] ipv4: Pass netns to fib_table_lookup()
    https://git.kernel.org/netdev/net-next/c/c436a624f89e
  - [net-next,v2,3/3] ipv4: Report netns cookie in fib_table_lookup tracepoint
    https://git.kernel.org/netdev/net-next/c/a780f51d5bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


