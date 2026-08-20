Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9663D7D6C
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258462; cv=none; b=TGpIrg6f7/b9ZVIDlAb+/0cXZS1zvJqxy3GNKn4Qg9DO5tkJCEJY50lPF9GTBH/pK0HNZ69aDH8eprYtJXBztDIa8D5Na+V+fCdTLSRz8g94+dt8AtN8mUGpa1zEi+Xj0IKGDV7kUN7L4xbGuFryTk50iFOqva4Nnyr4iNq/WXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258462; c=relaxed/simple;
	bh=IHlm58VqhE5QmHSQYMx1aadGuyBOpHvxNMTjtUR0ieM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D93ZxjtkOIwkT6enyfpmVE9V3LUQtu/KqDvr6MhUzMCJ2z/xvHoik9g10fRsDf9XyihoO2jkPbfWSsHre0p6s+LwFewziGSfcGsccMxwdNXOhMjCiIeA1GQL6aNKQ8dlcWeNVzkXGGgqubj/mPBQ8ChKsc5dgHYwmgT10+kbqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLG3+hhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLG3+hhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2CF1F00A3A;
	Thu, 20 Aug 2026 20:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258460;
	bh=wyHon6Q7u6StMTgFX0aSphumWQ8CWBTEa1n89mOTzlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nLG3+hhbrIG6AejKbfpJfJ4QD0LDsVc8zB2uozM50bNjHbPjfmI4asY0EpuQ0DVIV
	 nfQrPBhUFtOHro3sxDLtykjromSBN2+kVSnFswy+hN9Ka5hDihgxyO1DJlpg28myfJ
	 9U9jW7IAd8J3iDA1UbIHC6lpfWxF/QB4RydykU0bq1++VIiz8KF2gJyjA6z+w8p4qV
	 czKsmfyCTtEsJ3hu0z11NyllNBriknQSKbZlROzUIe502u1tyFhQBJxZXxrcIC85aD
	 Ssq+LqMSJYG64gfUy13iG1z5n7NPHQnvhkrqMCYb3YQHIWZxSQXrQNWIkcEdlVtqb7
	 VvdbYgtpblY6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1978D392445E;
	Thu, 20 Aug 2026 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: ynl: handle calloc failure in ynl_ntf_parse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725841072.473641.13594656173121682302.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:40:10 +0000
References: <20260818132739.469624-1-triet.hoang.dev@gmail.com>
In-Reply-To: <20260818132739.469624-1-triet.hoang.dev@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 13:27:39 +0000 you wrote:
> Check the return value of calloc() before dereferencing the allocated
> response structure in ynl_ntf_parse().
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - tools: ynl: handle calloc failure in ynl_ntf_parse
    https://git.kernel.org/netdev/net/c/25b863cd6d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


