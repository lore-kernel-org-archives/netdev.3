Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014947260D;
	Thu,  8 Oct 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418209; cv=none; b=JDDjy7rJAPyEXg1pToxdCcslPwJtGDoBIRW7cvVGwJXswM++XF1kviw5VkM5Q5yuVzZ8UWMdw2K7xbGgAPxBY9kbOyzavZAQx+RMWYzGaavB+eUbvJTCs/dZFnz+wPWJOIeJTTEK8W/jlljp9527r3fiPX9BerWSzVVVZG9XRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418209; c=relaxed/simple;
	bh=1M4Io5OvvfWWqI91KGvaNvEF8DcR2ITOExA4+8lkDZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIbsIBuPnfeF4CC0Wz1w1repWcVxTVVl4VRPrIiNrclMErj6mG5uV6fe76+q+bAbtPvA5dt1eLsryMpl/Rfz8b68WMN7X+nn2E0HUfYbuBvd4YimEY5B7ArSzT8fZHKXeL9SsaPRqZKQr5mRQDIf60fyGx4D2MEdNmPbTBxLWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3v/KMQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3v/KMQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE71F000FF;
	Thu,  8 Oct 2026 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418208;
	bh=qQOKprKZHKJHoBQDqn164r1hw3u4SOtyV6sZdXn2dJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m3v/KMQJLy7Z7inEc2uHKp1iPryIOnpUGod0Hb7Jl8nhosLL8YJF6VvcJbEX5unGP
	 abVYpNJ0hvSHYr7aJIimyJ3Vbpn3j5ZL9Zkv48BRWg5/q2jHUk5svXqEEMkfxejEy6
	 jViV70cQmMyGfYvaPKC8DJijZhWnjDx5ZBCLSxVgFP42rvc+q6i2Z1gF1U9HlXGqPx
	 baF+JVul5cZTPs5+SrDnFeE/cEavR5BWXxXJjejdQqLdBbb5myyqylYC5KUZWXFSbf
	 +7V5g86fzldaqU26vCYP+dOqgsNP3z4YzyN1aAbqzBapI5YpgsnZg8H+tQUK1o0NP8
	 efkMv8WgySobQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7740E3809A08;
	Thu,  8 Oct 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] eea: Improvements in the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141820700.3743901.18041006109052167931.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 00:10:07 +0000
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: andy.shevchenko@gmail.com, xuanzhuo@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 guwen@linux.alibaba.com, lulie@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 11:59:18 +0200 you wrote:
> My attention was caught by the explicit call of string_escape_str() which is
> not required in this case and saves a lot of memory on the stack (see patch 1).
> But then I noticed more to improve, hence this mini-series.
> 
> In v2:
> - addressed Sashiko conserns
> - added patches 2-5
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] eea: Drop temporary buffer by using %*pEhp directly
    https://git.kernel.org/netdev/net-next/c/f46b52335f76
  - [net-next,v2,2/5] eea: Remove unneeded assignment
    https://git.kernel.org/netdev/net-next/c/c1333be192b0
  - [net-next,v2,3/5] eea: Refactor error handling in eea_adminq_config_host_info()
    https://git.kernel.org/netdev/net-next/c/8724ed6e604c
  - [net-next,v2,4/5] eea: unify return code variable name
    (no matching commit)
  - [net-next,v2,5/5] eea: Use 2-argument strscpy()
    https://git.kernel.org/netdev/net-next/c/ecc57880bbb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


