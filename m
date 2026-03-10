Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477024679F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108614; cv=none; b=HvEddeHHRY2oUeKm6YznGJpXO75nCUPK8I1tf1gK/5+JafawZI5Xgndt2P1SnyP4bAmKTlm7zVPv+Cvrpg0Xh9TsqXTSD2ggSvdH/JKik2woSOZUtbDWTw9jdpkj5gOcNUkVPfnQ0KVtN2GlzEh9tKEyAC5Tud5zU+diMAmV97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108614; c=relaxed/simple;
	bh=rJw6sqQuPfl4/HKpt1GjtAflN3xCMaeMwUVywf+7iTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xy9vjf/irK+xKZG1Mg7QvasHUjkv07Eak/s6mREjYzymWUgdx/jXpkhHtdkGZZvivlBTtRWeQCio3nC2Yrm9w3YwwcBzMEuuTu9DLVMzNULFjRD9TTIAzB67pPMWSWCLZLQSwlk1kXcVkru3TaVjZ5sOtYQ8+GkE7qHbD79R2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upm1HMfa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upm1HMfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EEC4CEF7;
	Tue, 10 Mar 2026 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108613;
	bh=rJw6sqQuPfl4/HKpt1GjtAflN3xCMaeMwUVywf+7iTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=upm1HMfamo6aWmAMo6mHWNSIb/QA3Aea+FzJ8SzLuM3j1PdrpEmfvVV4PF11BwAGN
	 f+eaSSWrPD2pMOjL8rsWTbRhB2O/X5/tctFDSo31C/mv+Hpe7lUTt4MmOWj7neZbAR
	 MExA6K82dIJztnz+IYNN6kthoEvJLOaQRHR2nTnMnr9KUkLDyfBScamozPi4XhwdCf
	 l9J3Q6yHp65yTdORL69BbjMVwtq9t1XNoCPpBCTD2kgIqmbq7SYOkW1BoRw6fEqFXG
	 Xfp/OsNgmZ6erYQyiXDf0zAnwIQYkXMApf5pr0BCKgxMQqQyC0hfU+67DN8kMkFybe
	 JrpOHw6vZSaBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC923808200;
	Tue, 10 Mar 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: use rtnl_kfree_skbs() in
 pfifo_fast_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310861079.2026004.192921873657873689.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:10:10 +0000
References: <20260306133154.678730-1-edumazet@google.com>
In-Reply-To: <20260306133154.678730-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 13:31:54 +0000 you wrote:
> rtnl_kfree_skbs() reduces RTNL and qdisc spinlock hold time.
> 
> skbs are freed later after RTNL has been released.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: use rtnl_kfree_skbs() in pfifo_fast_reset()
    https://git.kernel.org/netdev/net-next/c/58e4d35ae7b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


