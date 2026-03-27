Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CE35C1AE
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581626; cv=none; b=M/z0l2KgGtSY2+402XvSFzXQ4icDz7Dvdk7vQzlyxvIAdgOeyXF6ZVp9B176rnMpVqS0pQ25mSSjXxCRhX1uEMJfxxy3Bs6rqoU+4C+DunM5OvlC5C9KAWQkKxLykk5iiXBQvZhpMDviiZINY5AXsEo+OFX9yFmO5nilGTnzHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581626; c=relaxed/simple;
	bh=4IDCWz01mYB3Zz7W98sn0xCh4vAfU3vB9ljQ4jWgIZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WnEgOfKMSbL0WH+9fIoTVkNE0bLEVZQNq6pcQWJ2XvnXAd23KpRufkiwXXk/khCO6SAtgpW/gMsC0KeRjoQv+GOxAp6w3AVlNlXf9ijDtG1BydMl7PwbQVRcjVfH45/a3uBQMD754KwsGaqaZvBQ9H0S/pKrrH4MYWyF7xtKCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGIuRCG1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGIuRCG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27DCC116C6;
	Fri, 27 Mar 2026 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581626;
	bh=4IDCWz01mYB3Zz7W98sn0xCh4vAfU3vB9ljQ4jWgIZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pGIuRCG1IrAmIywUBSu6n3nWNXE72Hx9HXq0s3+c1AEwG1ljvjM+CeJRNE+/7GnMH
	 sL3gk3kS9rDb+yg4iIkrFP5eQ7PCs6d6jmpFhQ/3n/Ny6KRsJ2SPMo8o3+4hkKXQWM
	 Qdsy3BolJSq2yAXHGJkrnsoHM3hXqfJxCePb3FdxAdWplgVo9QeHcH/zE0d+GD6DCo
	 uuE8MXEx4UcBuWUSCQLDFLDN7wEbb3zwzL1FP8FTrJNvA3XYVTmN91npiHFcgOLbE6
	 FbI4OOWRtDxMK8G4gC9EMAz9iOvNuNA7XYmcJdQVMjeHBMxQS6lBzWKFnv3M+FsV4Y
	 aFcHc/fGKn+9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC7A3809A0B;
	Fri, 27 Mar 2026 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: tcp_vegas: use
 tcp_vegas_cwnd_event_tx_start()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458161278.3283168.11616642049962050541.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:20:12 +0000
References: <20260325212440.4146579-1-edumazet@google.com>
In-Reply-To: <20260325212440.4146579-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 21:24:39 +0000 you wrote:
> While net/ipv4/tcp_yeah.c is correctly setting .cwnd_event_tx_start
> to tcp_vegas_cwnd_event_tx_start(), I forgot to do the same in tcp_vegas.c
> 
> Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_vegas.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] tcp: tcp_vegas: use tcp_vegas_cwnd_event_tx_start()
    https://git.kernel.org/netdev/net-next/c/6a539eee855c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


