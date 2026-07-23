Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4239DBD7
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830257; cv=none; b=Q9O0QV949bNiKoUOueGVv4PrYnFiv3WvuXnAadvdiaTNPBBzEbWK5chGIGYOeHCcUMro+PeYqGlOezyHL1z3XiIDCxpKU6ZVVI0OZF1X9zlTWVf08LSz6bqhJironCm5/myNwQIrFDb3GyIHsxaFhS0Dduq6R1kqAVb9wjfUzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830257; c=relaxed/simple;
	bh=ZEZtV2KKBnRmJnnBDbzF84oTF5GUX8B8tQig99/XIKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dpp6KmAq9vGZNWNy7ElCujzwZZrEDHIWrt612JLa3UfOShQr0GH60bNBtYC7KsbBHv/0L5xiyb2KCeGDKvntoTnYsxlWJqXdayl2Q13zPrPEvhaeIdxktSzUVRA1e2UpuZZ+XjzA0O6NJbsJt/hQ3B1yS00L0oog6xjM3tJqEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D6D1F00A3D;
	Thu, 23 Jul 2026 18:10:56 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5684C39244D9;
	Thu, 23 Jul 2026 18:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] drop_monitor: take care of 32bit kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178483022188.2811828.635720735981502576.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 18:10:21 +0000
References: <20260722141743.3266924-1-edumazet@google.com>
In-Reply-To: <20260722141743.3266924-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 14:17:41 +0000 you wrote:
> This series fixes two drop_monitor issues on 32-bit architectures:
> 
> - Patch 1 uses nla_total_size_64bit() for PC and TIMESTAMP attributes to
>   account for alignment padding added by nla_put_u64_64bit(), avoiding
>   potential skb_over_panic() crashes.
> 
> - Patch 2 moves u64_stats updates before spin_unlock_irqrestore(), ensuring
>   local interrupts are disabled to prevent seqcount corruption from nested
>   interrupts in probe context.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] drop_monitor: fix size calculations for 64-bit attributes
    https://git.kernel.org/netdev/net/c/7089f7ab99c8
  - [v2,net,2/2] drop_monitor: perform u64_stats updates under IRQ-disabled section
    https://git.kernel.org/netdev/net/c/fd098a23bf8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


