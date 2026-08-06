Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B031352D;
	Thu,  6 Aug 2026 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785975650; cv=none; b=HbGmp1ek8CU2BkDIPsQuSqNdWRBgkkqYD7qYU68qJC/AetlnsUnZNCqdQBTbpKIafWBXsAKT0KhJh23SPrjV+1edNYoyreSlMKERXaSwQ3vwk3HmptEOdBX6s/Rc30wGAKhCICK8pI2P1TygUKJ9Pj4YaBlmKuaFYcijoFSRJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785975650; c=relaxed/simple;
	bh=D7bdKJibXyK9HWUIjCmCZpVqPfqZoY+xWK6PPTT4xnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kR76Uw2oS6RcORI3HMt9RIWbIWtXCCVZbPEWC0Lag++RT8I8tMGsFUPvjONom3BwPJAY95hLm4Z/YVycwPSH42+VudEfzc3MzP2Y12UUB2//zzTZZlCR8ojQKVZ+0+rjKQ44ZFu+detTqVsn9No3TXX+DpXDc6Atm4Bv/foaEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFoQCshy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFoQCshy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC661F000E9;
	Thu,  6 Aug 2026 00:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785975647;
	bh=XYHzWSE8SJ+7K3/9abHAiv97y9wdituw7R0lo01shjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BFoQCshyS58ZkFG6QcMk3zhMtaKK9eEl+VjNUtK5C3mVAVwh4faP+6OZ6pU62h6hk
	 rBxVQTuXpOeaWO9cTFO7AFasAqkvYKQ0jsN5l2t/ZWW+wMrgoGwbwTvgw/tOEg3i59
	 YzQerq/FSWV+RbYzT3qAcOPBfIwrqhQjbXD/k2MG60VDn9/1yPg+bNR1vvbIVQVewv
	 eA9vlb0UZby1WVCv68futbwRzEIwiNWZ6UGMq3t/tHyVYQt1lvv0mybTRfWNo4DEKk
	 bNzf5NXwTrlPo9xSfR1/P3A5ryursL/ey7Nrb9nJlzoSawWFx0oEOHjM/n5cVij5hg
	 lQakg20mZkl/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA7392FFD8;
	Thu,  6 Aug 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix TFO max_qlen accounting across reuseport
 migration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597560690.575509.1624669268833520335.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:20:06 +0000
References: <20260803061739.134737-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260803061739.134737-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kafai@fb.com, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 14:17:38 +0800 you wrote:
> A listener's TCP_FASTOPEN max_qlen stops being accurate and lets through
> far more pending Fast Open requests than it was configured for.
> 
> This only shows up with SO_REUSEPORT listener migration, where closing a
> listener hands its still-pending TFO children over to a surviving one.
> 
> fastopenq.qlen is charged in tcp_fastopen_create_child() when the child
> is created and uncharged in reqsk_fastopen_remove() when the handshake
> completes.  The uncharge follows rsk_listener of the request the child
> points at, and inet_reqsk_clone() has repointed the child at a new
> request owned by the new listener, so the ++ and the -- land on two
> different sockets.  The new listener's qlen drifts negative and its
> limit no longer binds.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix TFO max_qlen accounting across reuseport migration
    https://git.kernel.org/netdev/net/c/a0ab2ba83e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


