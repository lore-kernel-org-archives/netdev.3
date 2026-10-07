Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013A342CBA;
	Wed,  7 Oct 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336616; cv=none; b=V6KfDs1hdTi2tu2YVkaSo29CIxZF0vSQIc0DCvnLn1/UuMQ+gXlKlbqy6VW/vLm/J5WqszGkLY1Rk8jegrb3M8Gtc9RvJfU3nuxIsSF5UQkNTNlwevfI41+hhXgA9Gj/qozMLXHJLbfI+spwSF0RsGvnYSKPS3WCuDhTRmX096E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336616; c=relaxed/simple;
	bh=qnoj5IfnyPbfjMrSQItkB8X9c2UufMRkiZJDcSIZD2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1DzWaTt1dy/1dIZewNf48lIpTvJCKCV7l9YL/uSGFjG6stH4UpLBfj2rUpwORS13swt/eyPzFAvsT1bx7Ib9Yf0yBD+kXFm1k5c8RmWlYHcgR0Cgcfbqn6uX+eox253+6P+1qsrSnN9tlGuzrN/uxiHvl2NLPQO+Pvp5Qn+Khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7R1FbH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7R1FbH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFC01F0089B;
	Wed,  7 Oct 2026 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336614;
	bh=kAJ/H15ANs5iUgvB0eeu8MO3XhSxvyYpcozQEHmGoV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e7R1FbH5jSGBW/mBFdlk1ZWkorZSfrhjIyugXohGpWGJOkHIQ1jnpH8+wHEuRN9Dp
	 e8EtsmHOFYw8tNw+/1MrMjB2bpFN8twiPXF2e8Poe4K8wfb7M3Ea1mt5FD666Av9fM
	 lQUCbG/keSbWa9RjHO5jt8CbProOHXF/Y3LVEaP6SUUDBFuot8lGjQJUNzWSDAC3em
	 9x4hoOTC97qwHz16SdQ7SQM/kU7snZGhGzDTvuQtd6AiA34QvkOCHYEkm+Ib5EihnE
	 yrI+UonoOVYoWxG0rxnQLr41ftaOPr89BjJALfzNzZY+unIe+36LPYtr5DBugWJTzB
	 dB+JnPOR5jgIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B63806541;
	Wed,  7 Oct 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: Drain eBPF RCU callbacks on module exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133661327.2858290.927536600951640006.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:30:13 +0000
References: <20261003093822.544964-1-yaojiale02@163.com>
In-Reply-To: <20261003093822.544964-1-yaojiale02@163.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Oct 2026 17:38:21 +0800 you wrote:
> Replacing or clearing a TUN eBPF program defers its destruction to
> tun_prog_free(). In the device teardown path, tun_free_netdev() can queue
> this callback as a private destructor. The rcu_barrier() in
> netdev_run_todo() runs before private destructors, so it cannot drain the
> new callback.
> 
> After the last file or persistent-device reference is released, tun can
> therefore unload before the callback runs. Drain outstanding callbacks at
> the end of module cleanup so they cannot execute from freed module text.
> 
> [...]

Here is the summary with links:
  - [net] tun: Drain eBPF RCU callbacks on module exit
    https://git.kernel.org/netdev/net-next/c/28eef87694a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


