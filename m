Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476F34CFD0
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524812; cv=none; b=eth8+ITBtcD/xt49nUWqgXipGF/q7R0CmURHhIKzy08INqnkIWxtgJudcYfcsBJJYD/8/YqC/eRjaVztqYTcH7jhhvfwVqflC61z/fK1U3OaDmuTJgYe5+st7cnLsUxWnbyNa7DF4P7etDp9/KaAFDJgZcj0HbPWTR3uaE5wb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524812; c=relaxed/simple;
	bh=hWn4FxSycsXzCCPFKuOdNw9Jz7Uks6REq+c8eQL8yb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ibjj25SdhGQZIB0Se3qMIZA5gAxqbho9RADmE/+QaaaMfKC7/wBZPSsok8zXKWthlX+aCGkcqcZrC6UgYsS3y/oPQfaGCq7+sdl2kvFc1mLu6+qKepjpKvU/tiAWGVUM/Gj/YQrA5//uWwO95tV2cn83xYXyjKVtvcdSZQc9H6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ5MAmc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ5MAmc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1EC16AAE;
	Tue, 27 Jan 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524812;
	bh=hWn4FxSycsXzCCPFKuOdNw9Jz7Uks6REq+c8eQL8yb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZ5MAmc3ziKU7JTYlfldHb7RTJHhDQbT98q7zk9snxOtMifd2NnGxLZ7r28cTasFQ
	 bwrMlP2gXzYfGbvjik53fXVADwvwNF4jlwl1LIPNATfc15BeMNMFy8NNZwLMftpYsg
	 EVbPfjpFWhXVCrCQJlY4fUMiXet9p4R5BPrIMAv4iO+nClOYh5KCfXcpzzPqWn8/pR
	 b5WrqjFYJgIQ66EfSfEVjzIQu8v6GuEJP7Tto8l1RHiexXGWTQM72rRKfAbi5GCF82
	 sHyPI226YioVz/v7EWQKPcdHjLV8Yhc5O4Kig1+7Dtve+ew2wz9GEiPMaSe5h2w9BK
	 U8krzsHSYjpYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EADD380A97F;
	Tue, 27 Jan 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix use-after-free due to enslave fail after
 slave array update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176952480586.870756.4657769115692092491.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 14:40:05 +0000
References: <20260123120659.571187-1-razor@blackwall.org>
In-Reply-To: <20260123120659.571187-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chenzhen126@huawei.com, joamaki@gmail.com, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Jan 2026 14:06:59 +0200 you wrote:
> Fix a use-after-free which happens due to enslave failure after the new
> slave has been added to the array. Since the new slave can be used for Tx
> immediately, we can use it after it has been freed by the enslave error
> cleanup path which frees the allocated slave memory. Slave update array is
> supposed to be called last when further enslave failures are not expected.
> Move it after xdp setup to avoid any problems.
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix use-after-free due to enslave fail after slave array update
    https://git.kernel.org/netdev/net/c/e9acda52fd2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


