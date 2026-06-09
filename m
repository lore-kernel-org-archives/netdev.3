Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F45175A7E;
	Tue,  9 Jun 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965612; cv=none; b=AWODx3+Zkvz+z0uZUHoT2vTzH9xct/INMYqfXKktDpXdokikvnFRSjSEhABDuJFywUqbur90gYiBu7NBQAzXiRmh89pXMJhKfQPl/wCaoj/Ht+hltcZpoGNh4RSTEWv6mpAdg7BZu8TRzlW2HLhWjq6dIS3OefKi+Jr52KE8vWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965612; c=relaxed/simple;
	bh=76Z09xdB30oGUf5zaTKa7opr6rk9ZWfYx1rkuMU4I70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ug9FM1WIZAkP4Cc3Wqvg1xFh6UW1at/hAnVXa+Jj/lMC2VQpkt9A1npTzYebSEIMVhTBpvkeSM12RgodYdB7limpd8OCxSdJoMVhDQ9mzfm8oC6XWpsHu9GopPWrhWS777Yzn7SzG2ncyybalCH5vQb8Dj3FblSR3YrI8yqIxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP3vRHpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP3vRHpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83AE1F00893;
	Tue,  9 Jun 2026 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965611;
	bh=00DzMoRNnDyWmyN+Mufn5NB0ZexyP0WDQ0ds7LMiR7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FP3vRHpBqCniu/tcy5WGbBnu/jwegFWta2yqLBkIzpVBROfQ5S39ms5DzGrVQv4hw
	 5z0bG6LBOrjAT30blzaIjUAELWn/71d7bxrO9j7m43kiSJyQvNeywuJjLV6Oq/02Dn
	 axfx8w7r8W9DSq5kN6pNb2yNftAkk2hkZkH+orwBIgkI6btdcTZRlGxIowxjHaywPf
	 /audj6UKBsWW9zvJWxBThWeelf2CDYV7Og/Nd+sXhapUbMb9zBN2nGximR14jzajed
	 JbDhS0SJTI39+xMX5ZJS6ko3HEgIUmGauFCOSj2yJJS0pomLUxES0kMJBEmMd9CWV4
	 vRaf6dxXskD8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396C3812FDA;
	Tue,  9 Jun 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096561013.1730160.13610511675755814498.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:40:10 +0000
References: <20260603230821.5619-1-rosenp@gmail.com>
In-Reply-To: <20260603230821.5619-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 rdreier@cisco.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 16:08:21 -0700 you wrote:
> napi_disable() is not idempotent and calling it on an already-disabled
> or unenabled NAPI context will cause the kernel to spin indefinitely
> waiting for the NAPI_STATE_SCHED bit to clear.
> 
> In mal_remove(), napi_disable() is called unconditionally. If no MACs were
> registered, NAPI was never enabled. Also, if they were registered but
> subsequently unregistered, NAPI was already disabled in
> mal_unregister_commac(). In either case, calling napi_disable() causes
> the kernel to hang upon module removal.
> 
> [...]

Here is the summary with links:
  - [net] net: ibm: emac: mal: fix potential system hang in mal_remove()
    https://git.kernel.org/netdev/net-next/c/7c5d41f87f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


