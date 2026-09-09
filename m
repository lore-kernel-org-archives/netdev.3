Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501113B442F
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987670; cv=none; b=bA9E9c3x3gfsQAA/gYqG5JVpTc4LVx0DJTcfldlHzkVT9F/BjH6nxzaxRacdFB6IJwsGsaZhqgR07eRX9R3xpjk/x8HjOJRhyiNr3+pWJ6luf3e7h2h8Gxaf9dcycimgflCdg3rgdU3jsbA204nxNZYh2szDyHprTTfCZlwWyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987670; c=relaxed/simple;
	bh=I7+OodPC2B97kADqhQ8jGzSN7WI6cSxQq3Ijtenp+N4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUuMQpj38i/XSih53RaoilXOZ7X2YIiitCrgVn0wbtTvSUxK6Hrcvg0E/O7aDXy+WqaedRl+XQ2kDqYFB8HHFa33lI1Wu5S2A3NefVEBOAJDdGAT+CYAH1HBhO1YDG6ksdKJ16Jy4gwzRlcxbUt+hm30i2vWDbWk2l0dyuD78KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK+GOBA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK+GOBA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4071F000FF;
	Wed,  9 Sep 2026 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987669;
	bh=IrB3XQ1lzrJsBm3RhBh3L9pwMNNnswzjABX1NEHmrFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KK+GOBA0VYdUle30+xTAmEQaHBjvd6XE/6aVzapDGqCUM2/ZpZkmCBW97BJpzBuE8
	 Hc3RFs3tU9wLvUIGyPjWx6+Bhcr2itRRPqn2UX+fT1GPvT4JG++JJ5EGkY0jaZPe1L
	 COTL4b958UAyGMQowgdpbHCxtuJHCyBktY58PzxY15YVtGgruOiwpFLfutKQ12ZjWF
	 vvWuKZWQyYpJkX0Bcn2r3TgzNHohpyRD7dRGt1jl7xuLgRGni0YwDlDJ6uBXZHaNAH
	 5iDe7al3RlYtVinMRUAd/YPHoERiK7qMZM4JYexIrIMVHaMUi1iUR6Ivc82BKBG3hZ
	 k9b8Gs+5sSQJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AB380AAFF;
	Wed,  9 Sep 2026 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] dpll: fix lies in the Netlink spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898760666.1057294.16835072883112832781.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 21:00:06 +0000
References: <20260904191023.3869690-1-kuba@kernel.org>
In-Reply-To: <20260904191023.3869690-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 ivecera@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 12:10:19 -0700 you wrote:
> Clashiko started accumulating pre-existing issues in specs so I did
> a scan of the families. This set fixes issues discovered in dpll.
> 
> Jakub Kicinski (4):
>   netlink: specs: dpll: add clock-quality-level to the device-get reply
>   netlink: specs: dpll: drop the pin-set attributes nothing implements
>   netlink: specs: dpll: pin-get has no dump filter
>   MAINTAINERS: dpll: add the netlink spec
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] netlink: specs: dpll: add clock-quality-level to the device-get reply
    https://git.kernel.org/netdev/net-next/c/0274de8b9fdc
  - [net-next,2/4] netlink: specs: dpll: drop the pin-set attributes nothing implements
    https://git.kernel.org/netdev/net-next/c/28f363015aea
  - [net-next,3/4] netlink: specs: dpll: pin-get has no dump filter
    https://git.kernel.org/netdev/net-next/c/f4ac7c7a846d
  - [net-next,4/4] MAINTAINERS: dpll: add the netlink spec
    https://git.kernel.org/netdev/net-next/c/356635525f5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


