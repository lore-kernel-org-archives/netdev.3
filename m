Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0FE15FA81
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521072; cv=none; b=JqA8T00LwLd4iEHgl+cO/IChJ1QJtxc5NbginyFtn+XEAC/PwjHwqb5Leh9PXfPMvWctFaEYEKXnBBhjawrWs1rQ45OkyBI6L0fHe3QspbQ7299AUeAyakUrHsWI7ol1DF94Ukd64lOCsas5oqkIsNojbQ2Cs8L2SWAtktydoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521072; c=relaxed/simple;
	bh=XqCbQLNwo+Nx2u/vq9FrLn4/6aW554NN3lWz/0csv9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QslW9UWloJfwhVcafTGh/Noqitia8QWSM3M+WHAd+Wa0urD4eUz2JO47cHRpOMQbERYSoG4PQQ6MY/qFe/hzg1E7RnHpSUxcTSacYSzYA+LGTQL2v8bYQbkpjcxUGZ5rrereaC5YV21ggZOkwfdbO7W0bwwleDm0S2A01AHMw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDhcawOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDhcawOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74821F000FF;
	Wed, 16 Sep 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521070;
	bh=C/PI444o0OVnwerZucjg6BKSaWcLGgBg0LjgWYCVDLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fDhcawOCkXTUWP7SpONNTh+WE9Ux/W0t8WCjIQCnogVvOn5y/6x5r/fDybyJPbiax
	 R2hFcnVCd18n8U2BNQIPJxIcNOxnZ3CkFm9zDtiw/CA1QR0ZQ2Ua553d+VVE63hE8v
	 x1bW+4i6VY3HK94eOdjaqCTM3H4o5Tbz01tXc04ECD/i7isGHySwMpdOBfR/vWFWzB
	 IFl+HrrN6M9I33WPqFzZmLE5RFYlB11cEaiBTNeqz1P9M2rrDAvfPHpqFIOufnS/RS
	 0zaKWiZjyY6WcNdknKxS+CbuCXuzhWlv4WSZTA4XgxB37XDAJrWuz3XjO5arYiFmVn
	 BqpgeNwFni7sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691D3927074;
	Wed, 16 Sep 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: drop_monitor: fix concurrency issues,
 preemption
 warning, and buffer overrun
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952100513.2346086.3291685247493878437.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:10:05 +0000
References: <20260910204612.3762015-1-edumazet@google.com>
In-Reply-To: <20260910204612.3762015-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 20:46:08 +0000 you wrote:
> This series addresses several issues discovered in the drop_monitor subsystem:
> 
> Patch 1 adds missing tracepoint unregistration synchronization to the
> net_dm_trace_on_set() error unwind path, preventing in-flight probes
> from scheduling work after the module reference has been dropped.
> 
> Patch 2 resolves a race condition during monitoring teardown where per-CPU
> timers can be re-armed after deletion if a concurrent worker encounters a
> memory allocation failure, switching to timer_shutdown_sync().
> 
> [...]

Here is the summary with links:
  - [net,1/4] drop_monitor: synchronize tracepoint unregistration on error path
    https://git.kernel.org/netdev/net/c/6a038ef2b579
  - [net,2/4] drop_monitor: use timer_shutdown_sync() to prevent timer rearming during teardown
    https://git.kernel.org/netdev/net/c/c391a40f7188
  - [net,3/4] drop_monitor: use raw_cpu_ptr() in tracepoint probes
    https://git.kernel.org/netdev/net/c/c19b7d35086b
  - [net,4/4] drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
    https://git.kernel.org/netdev/net/c/439f392084f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


