Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB3D45EA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087824; cv=none; b=l+lqLA2rrnnsyiFeBsvLgGJP7ZgEpzBraOLibGS3K0GvyGevzG4T3oJXugNdD9ddy4J9nDZQ0BSDpHU2XzjsNBe6b5NxzCpWipWw6c/6De3eTEUOWXlnHOQm3UdtPqTgz/JZ5ok+RUXN+QAn71GP5M49x2tBnZayAk9WTNZA5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087824; c=relaxed/simple;
	bh=ESesChFs0+r6Yzgs8TNi3liAsuiO+QAXmlZj9cyXKtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oyH1esE7AAQ1PvaB1SXg+jj5fDUAdc5wMsk1JKBdO0MrRcVpZtfO8UuvhxSMH2XsUDU6WqFjz384ZzOz6CrCChIqqCPTH+kFL81Fk5hk5I9D8bvpWUvXMoK1yXC1Xz6MYfgFYYrM/oN9cCKQhUL9s5A98N1hivSTW7Lfhl9bCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asmky+5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asmky+5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FE41F000E9;
	Fri,  3 Jul 2026 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087823;
	bh=ShI3Falo4wUukzF3/zGmd5dxZLFd6IswkKgqGLZof64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Asmky+5vy+Lly7jxreQHNoIOuQk9P9SjZFQPZEWP8msG3uxVc0eC38W0oGitk9ECd
	 cuopHKBCnZuDH2nqRdYP/emfuxhkrRTg8XlOP0GuGYejL/lef7I+IEfa4Bm3qWmG4v
	 URSG135cmu6mvXtN6EGB0LmspOTj5C6ne0L4wmeY+wuyqVD9tLpf9EnVf0lwt6y009
	 Zro47sSMvvveZ1DYA3DoVu5Xn+XKULST6cglRT7nhevw0+qKWSRXtq0Zs96f+4WdnS
	 UsKX8C7fMnnkNSIllZgjJvBr9DpF0/x4ZKPzZiTrpsXDOgMnAFOOJ29w0OBHNbq2qZ
	 ese305ELwUVdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993C3938EB9;
	Fri,  3 Jul 2026 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_teql: move rcu_read_lock()/spin_lock()
 from _bh variants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178308780564.2728910.11131487731747143438.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 14:10:05 +0000
References: <20260630150922.238714-1-jhs@mojatatu.com>
In-Reply-To: <20260630150922.238714-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 11:09:22 -0400 you wrote:
> This is a followup based on sashiko comments [1] on commit e5b811fe7931
> ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")
> 
> Use plain rcu_read_lock()/spin_lock() in teql_master_xmit() instead of the
> _bh variants, since ndo_start_xmit is already invoked with BH disabled
> by the core stack and the _bh primitives can warn in_hardirq() when xmit
> is reached through netpoll or a softirq xmit path with hard IRQs disabled.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants
    https://git.kernel.org/netdev/net/c/6301f6a34ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


