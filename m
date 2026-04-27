Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDF25EF9C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333849; cv=none; b=B5OsiwEhK4//5St8XYrzv+gwJByiJqlR0kUhpBh9scdhPmFtwzjBKScTvQKVCZYgfs3uHFhDtQL33eQNX3ZS8P0yL+1QF1EnHSaZFHyrLw+mlp9YVdq7KzyjbthDA8W+wqxUtv6foldvZFpjqYHmDnQIrMU8ZWw3VyGF4vOV8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333849; c=relaxed/simple;
	bh=IdYjohgTVx09f+mjJ1u/bvVoQQIjPnFZABHV6u/XJCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TwMlnij8MretXd1hGGivHldjRjxaLYK9CkOQewwa7K0MgnRtKUBusaJKAcSnjseUCDKprc9kqU+i01moYiBV2hOU0XR15Zud3IletbNyMBAFZlGQuxLSWZbEYHfm2wqfKkYRWjg5T7IOO+8s35Ov44hxO7BcP4JTIgFV6cfRncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYvaW8a/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYvaW8a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C054C19425;
	Mon, 27 Apr 2026 23:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333848;
	bh=IdYjohgTVx09f+mjJ1u/bvVoQQIjPnFZABHV6u/XJCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kYvaW8a/1XN97UzhMxREqwAJHw2y/J/0U9PNWs0+TeW3W6L7AIJhGpD90cMGXxAHP
	 czRgJ1JWHH7YdDLqBrvO/3BOnBK5TtPBBOeTwXWuzFIJ3evJjeMd/lfvn0TaVvdZVF
	 P37wXV5cnXtN8e/PUlvFX9MjWrI+NV2elSo4+ticBjdJAguZ3zX+R61/iPmw1fmtwQ
	 y5AO7ysHmcaE2UtlN4y1x14V6TDaOsNXEMEiZDiJsB0PWBkOZH8moM4jzPHs9jo1de
	 UCK2Svkg+WJx8JkDb9A3gs2Q2yi5648+NG5cPqHbdnhML3UHMPTOElLb8zIRYbF9+0
	 KbVlPjSms3N2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02AF8392FFCA;
	Mon, 27 Apr 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add pcnet_cs to PCMCIA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733380580.156599.8648851846420090909.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 23:50:05 +0000
References: <20260423220857.3490118-1-kuba@kernel.org>
In-Reply-To: <20260423220857.3490118-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux@dominikbrodowski.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 15:08:57 -0700 you wrote:
> Per discussion under the Link make sure Dominik can help
> with the patches to drivers/net/ethernet/8390/pcnet_cs.c
> 
> cc: linux@dominikbrodowski.net
> Link: https://lore.kernel.org/aeomUh5JqFvkLTH7@scops.dominikbrodowski.net
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add pcnet_cs to PCMCIA
    https://git.kernel.org/netdev/net/c/3618442d54f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


