Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA537882A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283634; cv=none; b=RX9ZVD7fifNTJJRhMnUC0AwzkFuNt87hVX0BvyaiyXaY5zj2+VAdhocn5iXzfMnD0qbbyiy47O7dv8P2FdoseUodD3was1iwdQGxH3eFzu6cBms3EOMxXiZJ5w1anYVNJ0DP5zMuJR7CnHwXqPyfFW+CmgR7k2Alzh2VODDxVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283634; c=relaxed/simple;
	bh=roDTle7VmQXagtKa0uZItHWsTTkBgMdhKluKEsQAcSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=orqYDlPUPHK/vob4X0sx5/7LX9XXmVPjeU0gkXdyBXDnqnuXRU/pwYTR/uc42D/NiFwfB34EFCrDDOtr09Irctwr9xqeyQLSJMw0bJwVaqjV/RnJy83KJO7AdxkT51tc2YpHmY/c5RwU9ROJK4H2uXs+QF+/McNpaQDx40+elG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opUtYEuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opUtYEuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F71F000E9;
	Fri, 17 Jul 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784283633;
	bh=7e7kvTk7nfcIvdQgNEHEslZL4WTuQMLL4whH56Mhr9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=opUtYEufYcrzLmAu0BUv24Nlq7s3mPgMKNpIjhG4MV1PafujlH6ljikUgqlP0u2IT
	 678jnGgklHQTXQCDEVyLqBjhGbs+W+aJLnvIWGE1Y9iIAXbH+rWcUNKAZN0O+mwV5G
	 9aTrC5FK/zhdKivR5fwqSevD1O6OuZCDrcxQnmP+UmUB3UU5QiUquY5KjQLWhPXtSf
	 U2upNdmoor+cvspi7hNtCIetse2fNSfcA4rc2lN5YChcDKde2PmdXeXNVlZUM62/9c
	 nDz3c/94MkPkTWQ/RyD6nJ/mkEP23bZ1jufxm85oBARBnHNTjdcefuGg7WkQM3fM4n
	 qQNkOczPrVzHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19822380CED2;
	Fri, 17 Jul 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: act_tunnel_key: Defer dst_release to RCU
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428360565.1651046.11817147008384641104.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 10:20:05 +0000
References: <20260711150537.7946-1-jhs@mojatatu.com>
In-Reply-To: <20260711150537.7946-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dcaratti@redhat.com,
 zdi-disclosures@trendmicro.com, security@kernel.org, victor@mojatatu.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Jul 2026 11:05:37 -0400 you wrote:
> Fix a race-condition use-after-free in tunnel_key_release_params().
> 
> The function releases the metadata_dst of the old params synchronously
> via dst_release() while deferring the params struct free with
> kfree_rcu(). A concurrent tunnel_key_act() reader on the datapath may
> still hold the old params pointer (under rcu_read_lock_bh) and proceed
> to call dst_clone(&params->tcft_enc_metadata->dst) after the writer's
> dst_release has already pushed the dst's rcuref to RCUREF_DEAD.
> 
> [...]

Here is the summary with links:
  - net/sched: act_tunnel_key: Defer dst_release to RCU callback
    https://git.kernel.org/netdev/net/c/f1f5c8a3955f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


