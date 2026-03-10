Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2A34C130
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111641; cv=none; b=i5SVTCU//7vo3KDrXqsi3OtThxZY1XKsY1B0lnJe0a1Hksd/tq0cu/fCU4OVIwOK7H/PRtgx3CdyqqJObq1vQ0VDaZa/UokaCiAKFtDgFvvTiEKPUWPinll/VXGW60TKGMCbvKxUwtXfwi/O5XfBvjLQUo85fE5Ur3JcisrrYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111641; c=relaxed/simple;
	bh=N/JiFdSwUaICuL4Zyo1wmFyfpvqXhiLaSHJ9GLSVwtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzGp6aKsHNQ7Tz4h6dpEfDiJ34AwWqrzLKpSfTfiby97tWzQ9vMY0As5eIOtfhMAqPburGDFkaJc4CV3bT6HO9M8rdBICnR48c/36sX04sMsBcYRnky2JKZzBjBgEzXrNkTG0TJl0qkzuWsx4+jUOvkAnf/5B7qHR8bXtMLLB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afNv6VXX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afNv6VXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4836C19423;
	Tue, 10 Mar 2026 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111640;
	bh=N/JiFdSwUaICuL4Zyo1wmFyfpvqXhiLaSHJ9GLSVwtE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afNv6VXXPq4Nx4IHg2ofMk2xfDA2zm16GZeYAAjXlKPlaB4zPomlse+93kc+6mntq
	 182TN0/qMaXJEQHAQyD4hAVjO8bsv8M91p8RoeWITkhUSMvSBFus/RweDj5CSA7jE4
	 Kd/bhLkgi3swjz7+eZjbTm6B0DNqLUo1bNQGZXEw5iyzrTdPy7usuU0LB+X+2zLx2H
	 7ndtmYE5cVDvo2pXd0o47khqJrNBHlFPz95sjRza9Zbkr5/OvEpbW1JOn608MYMpOa
	 BIvj4G7L7stNK+OjgNFJ5YbIDag0uL6dexA+KHc2jBcKQWzKFK4Vnbh+g6xHCqAngN
	 hWVZx5FEEoO6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE073808200;
	Tue, 10 Mar 2026 03:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in
 tc_wrapper.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163779.2039470.9221132616218172490.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:37 +0000
References: <20260307133601.3863071-1-edumazet@google.com>
In-Reply-To: <20260307133601.3863071-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, victor@mojatatu.com, pctammela@mojatatu.ai

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 13:36:01 +0000 you wrote:
> Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> even if a direct call can still be beneficial.
> 
> Even when IBRS is present, an indirect call is more expensive
> than a direct one:
> 
> Direct Calls:
>   Compilers can perform powerful optimizations like inlining,
>   where the function body is directly inserted at the call site,
>   eliminating call overhead entirely.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
    https://git.kernel.org/netdev/net-next/c/f2db7b80b03f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


