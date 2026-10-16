Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C126299
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111819; cv=none; b=ra2n9Vh/Q6yMKVE/MDfAlPWQ4QIx2H3LvMsPuaZolR5Un4yAgyjffSbgEqk+mFSepxwu6Zvg6IZppvNY4++bbmyrvX+ITWMN6t9h+sluPb3SmpoJlsRrEnWu0Xu1DAPYS6yQjh+IwPwkIbkSCHAmyIv4zXWk/v+T+wEnJ8iYnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111819; c=relaxed/simple;
	bh=obFEQ6Xe228bT3BXH6hiB6rSktYfd2a9ItqaHzHBpb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrrWBo4I+lX3KMWBnPaFqeVFwQcHXnztCjYgHr/blyX4LWE0/4tMhHu+oqEH7Ss/lQ6Ej5pKJwxPxwyf8KEJzysQ3j1x9flxtcY+BtybAPR3NXefitqMWHM8BNyQ8Et6e0sBa0X16E+vEVXttF0fRDp8opjBkXzRwcMIZmJ8k64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6nIBbAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6nIBbAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4547D1F000C4;
	Fri, 16 Oct 2026 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111818;
	bh=pTnBbdYpV19JW1XFXI1vSnmkasbZsEdzOZthGaRGpz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m6nIBbAwa9lCfVfx+cglcxI/QWYCfaUqpfCLh9vq2VyMzzvJAFXRWHSdVIzj6i7gE
	 sDa+QEJBWf4vLH2Y/zjFSIFmwsK2vMHoDyMB+SqK/YsN4Kvr6Jy5rI9XePWztsMPQd
	 WYjZdsYsQ6Jz+Lr7pl5eIg531x+oPu601YxaTItpSeNBjsYoXFDw1v1M2EanNWcoUd
	 JefqLYlMU9+w2U9Le0vAVPXl8hCVKxIrkjFUh92owUDYp0iv7Y44AUjSlUgTmLN9De
	 7gtuzCcT/Xtk0Uab8AKFpimEZvhwiMkw12XZPPBAazsglzefSJ0VvLM9k+F5HgghI8
	 5wIzKvZlAkXAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A42F3808209;
	Fri, 16 Oct 2026 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: act_api: take tcfa_lock for hardware
 stats
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211181676.4179746.5434197653809561832.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:50:16 +0000
References: <20261010152227.401987-1-acassen@corp.free.fr>
In-Reply-To: <20261010152227.401987-1-acassen@corp.free.fr>
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladbu@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 17:22:25 +0200 you wrote:
> Actions without per CPU stats update their counters under tcfa_lock in
> the software path but tcf_action_update_stats() adds hardware stats to
> the same counters without it. A dump of a filter without skip_hw does
> this even when nothing is offloaded, so such an action loses counter
> updates. On 32-bit, readers holding tcfa_lock can also observe torn
> 64-bit values.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: act_api: take tcfa_lock for hardware stats updates
    https://git.kernel.org/netdev/net-next/c/1800f27a5ef8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


