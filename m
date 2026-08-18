Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6E47FB09
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071861; cv=none; b=GWN/lv7PeM1QXAHKSC04qaXiDHswDogMPgrh5mbXUiCu+NYqrHjjuqPu0rN4pdPtLBu/xHEfp1xCcxnCD3NwwJChoASs9tt98NW6DVmd4MtJFc8zcWsYdPeD723bt77znCKpH9Ck/nFZbU1YYYS3tNvv/Q5ISRRFfmorsdDF5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071861; c=relaxed/simple;
	bh=pTZ8B2EETuYv9JJV3GVTUaqP8Z1FZ7zc2vYnJ7+mQlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kpKvVBHlc4vswEM/ZSv3ZNoW6nfEM1ddJs6rr5BK6a/49/eNE8CsrX9mLLsAl2AG0gZfts5ryAqxptZesRzV1RNfqTkw3LrvMnPwn8wwUOWFZZlnRL8N4RVd4wakwznazKrSBIkcX11ngFYPzOhJ+UGE/J+RvhDdGKY9g8SK9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX7qJmsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX7qJmsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3348B1F000E9;
	Tue, 18 Aug 2026 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071860;
	bh=fR7EnghN4Y/8YKqH5yNI4DtSZCQAjxFWIAWksoL+88Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TX7qJmsVqyCElEGLHHgOCYvfMf0Xbz+LgC+FFHgYzthBRbgRJ5Uy7Ok2sWDmTkW5y
	 bD7en3y8ZQQzJ6iEEJ+CYgHW7RLwvQP2Qd7PHywGe/tQbRzqYfEW0vme4uVofTYPOh
	 QLJ3d9siY+9qQDE/cKRUORQxEs518jo2IjM3Iq6Dmjb+SlGdx5ZtJFcO8b98uZfvM1
	 pM2fy1NToF8SIsYc6b86D0K5oplOrVg+o3ZZfJaRv/uN8ygy7ppzF5peQEilJrHyYf
	 g9xiVo0t8XSniJE8FmaPfsz8mGoDFKe+ih2a+J8n/kc8sGK6o7m3g8E6My0kNJz+oz
	 d90efsP6ziEPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09003927043;
	Tue, 18 Aug 2026 16:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] ipv4: fix a non-progressing fragmentation loop
 from undersized effective MTUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707181138.2177226.3831594086427504955.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 16:50:11 +0000
References: <cover.1786599079.git.edragain@163.com>
In-Reply-To: <cover.1786599079.git.edragain@163.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, edragain@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 01:35:25 +0800 you wrote:
> From: Yong Wang <edragain@163.com>
> 
> Hi Linux kernel maintainers,
> 
> This series fixes a non-progressing IPv4 fragmentation loop in
> net/ipv4/ip_output.c. The bug is reachable by a non-root user with
> CAP_NET_ADMIN in a user-created user and network namespace.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] ipv4: reject undersized MTUs in ip_do_fragment()
    https://git.kernel.org/netdev/net/c/c0726f0caf8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


