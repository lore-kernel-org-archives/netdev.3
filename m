Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C42609E3;
	Thu,  5 Feb 2026 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267017; cv=none; b=VTDyMspnRqSe86k6upw9NQkGbGsCeDzCfeZPhOydtfsPdzi00DIHtIzpQMtxPbXd5nqyX/Ad5GROHbYTIo4HMlIM9jJLYN1eQIHQoBOCENj6MTDqAq5lB7lIb95B3CF69NsbJDvDdLj8l9wU7wcQj7TgvO0gDf1tm5a5BBMzzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267017; c=relaxed/simple;
	bh=+MxgROml4NA50LlAIL+DIy3FDVTAxCPgXx7vtYSVpew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Db3HhTvdc6c6LWZT3m7YWtS7n9x9wXW9aZgqqvuCgoLDU1mVMXeI3dhHd+J68E3s5meA/Ad95B5x0MwEuZf7NkCo+KbM4MLL9BkZIC8aSWl6Zz5KKp9hRE5zJj/VogawD4wm4ez/PPl8bM37LzDwRSybS+4SJL+4X1ZyRKPXz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHSvhnfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHSvhnfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EFEC116D0;
	Thu,  5 Feb 2026 04:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267016;
	bh=+MxgROml4NA50LlAIL+DIy3FDVTAxCPgXx7vtYSVpew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hHSvhnfWwFM6cn/2saek/xoJ8qREfZkTW+3vfIO7IhAjeD50e22CSNjEfT5GybwN+
	 7coWWodebslNebdFZJWTnVuh53l+OrHCthCWqnS759768Lj/pDCPgrKcjkcDUTjzEb
	 mp7upjFwZ1mi5pjrHP6qRg3k6QbIYrytgCOcRUUXxeYjUKWv4uGxbuvcwUurMVTXOT
	 OuVCC+byLajTiM92I2y/yM38MrBNdY73RLlAEaNYBJs+p40k4mPtcffrl4CH9BWZ2a
	 aakPQr8Z2TIvq4QcvptyXuOBUrc5UIWm0PoW1LNXSlBV6mLjnAP7BMqIBBuG+z820c
	 uBS2PV+FAv4FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFC33808200;
	Thu,  5 Feb 2026 04:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ovpn: Replace use of system_wq with system_percpu_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701482.165764.5952840764169832538.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:14 +0000
References: <20251224155006.114824-1-marco.crivellari@suse.com>
In-Reply-To: <20251224155006.114824-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, antonio@openvpn.net, sd@queasysnail.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Dec 2025 16:50:06 +0100 you wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> [...]

Here is the summary with links:
  - ovpn: Replace use of system_wq with system_percpu_wq
    https://git.kernel.org/netdev/net-next/c/f8a062b25586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


