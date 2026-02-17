Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8033E377
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331413; cv=none; b=o9Akr/2BHgq6hVP6ieghrKjMm5vNzaaTkyCwNf5yXInkSFL0puyK75LUKhAUzkyV8zvtzwGQh5OoAlvxlsJN+LsumK8uF6x3v/0ugB4gYx8H2VYDepZx49IsEzCnKeO1/1BpdU+hE4AW1myxOyB6MgIvAq8z6xGSqTUw+QjteHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331413; c=relaxed/simple;
	bh=pbey38T5TNjZrUxzrp6Wy2UlDMFrWWMrZy8k6sWWalM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUCJA9k2hj7Go14APv1miO5hjtdJy4Gjg5ml/BZNapjmaPKoxurJtk1F6b2d2R8zvavJtgieDx5PlGjex0p4++I8uXB4bNDRr1yepEHL1Fd2W7TG9kWDe5CPI/0kiKgOOVqe9UVpj7UksxKlSAsWPqJIL+Ms25ebLM56ecuxmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7Piz+7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Piz+7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD44CC4CEF7;
	Tue, 17 Feb 2026 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771331412;
	bh=pbey38T5TNjZrUxzrp6Wy2UlDMFrWWMrZy8k6sWWalM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W7Piz+7VTXdtcw2RnvI60+GgAUTUoaaDv7y35ZBmtDBp0Tc5fxGnh1bPZSHma9wtN
	 0K8UR9tVPbcX51otZXryiS52VZvr+bt9TEu4uVfVM0zU51KtwrQ0dBtwMYV9rc9dSi
	 gf8KUrVv/syIMeQplvR6AghFdLON2n/j8heCPWDEnOxHfKrbPjVlW2gsTcARvL2hXd
	 WSQRa/Mwmg+6vqpJNc+yo5bhpb90zzfJKiTJC+Hx5AFD79TLr1I0ZUSmO5dT90ISR+
	 GYiQOhkuXDw+mp6qkS8cwaPNJS4dlk5VjL7FvdVFsGrgLO7OVTz0wEziY2ILSKO7cB
	 HOBWZYUt0Ky2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0D9380AAD0;
	Tue, 17 Feb 2026 12:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix backlog_unlock_irq_restore() vs
 CONFIG_PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177133140483.55311.3255529638957203785.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 12:30:04 +0000
References: <20260213120427.2914544-1-edumazet@google.com>
In-Reply-To: <20260213120427.2914544-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Feb 2026 12:04:27 +0000 you wrote:
> CONFIG_PREEMPT_RT is special, make this clear in backlog_lock_irq_save()
> and backlog_unlock_irq_restore().
> 
> The issue shows up with CONFIG_DEBUG_IRQFLAGS=y
> 
> raw_local_irq_restore() called with IRQs enabled
>  WARNING: kernel/locking/irqflag-debug.c:10 at warn_bogus_irq_restore+0xc/0x20 kernel/locking/irqflag-debug.c:10, CPU#1: aoe_tx0/1321
> Modules linked in:
> CPU: 1 UID: 0 PID: 1321 Comm: aoe_tx0 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
>  RIP: 0010:warn_bogus_irq_restore+0xc/0x20 kernel/locking/irqflag-debug.c:10
> Call Trace:
>  <TASK>
>   backlog_unlock_irq_restore net/core/dev.c:253 [inline]
>   enqueue_to_backlog+0x525/0xcf0 net/core/dev.c:5347
>   netif_rx_internal+0x120/0x550 net/core/dev.c:5659
>   __netif_rx+0xa9/0x110 net/core/dev.c:5679
>   loopback_xmit+0x43a/0x660 drivers/net/loopback.c:90
>   __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5284 [inline]
>   xmit_one net/core/dev.c:3864 [inline]
>   dev_hard_start_xmit+0x2df/0x830 net/core/dev.c:3880
>   __dev_queue_xmit+0x16f4/0x3990 net/core/dev.c:4829
>   dev_queue_xmit include/linux/netdevice.h:3384 [inline]
> 
> [...]

Here is the summary with links:
  - [net] net: fix backlog_unlock_irq_restore() vs CONFIG_PREEMPT_RT
    https://git.kernel.org/netdev/net/c/26f29b149169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


