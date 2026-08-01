Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66133262A;
	Sat,  1 Aug 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548449; cv=none; b=CMoc3hEN4QzhTVt3sZ+IATHa04iaM7eP9j7tpTQpKjJgr7fD1D4ssBntOMOnt+uThTYr6FszOVU9wzaNWDzdTCA1cZ5frMzjuVkNRCUeW4Nw0ZlnLLzGwdK87ylB93G2/MPhdsdYhVC3PrLBUar+7XIFGrefNJtXUlTz+OJEO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548449; c=relaxed/simple;
	bh=Aod2OsFzP12W7N7ls5rZ0qdkDsB5ymjT/Xa9GgEpwqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BvDGEXVJ7aaj2iNSBL3Sfx9BMNdJ4bXMJ8ZLNx6F2qtkuQD0UBZzwvVrfTPHo3YIgSzAw2PEs9vjUtGAe8hQb2kzSRGGBicySoSl1NMIv4Kc2oJxSq8bLkTKzueekQvOIOMvS1JIDju1gONy4qHQKaNnrBFsWmt/d2az7MmXpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBosmx1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBosmx1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16521F00AC4;
	Sat,  1 Aug 2026 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548447;
	bh=eZNWrNcUl5fkUzOtyZsmfgV51CgQQsh4Zjdgytj1ioQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TBosmx1v+q4OheoHLY6zJuPUxy3vyh/q8h/Plp/2hpu31tXmhbubQ8e83T89Lj7HB
	 /b9YfRHipvUmDJdWuA7izTdiWzM8htoaL9//5ywaWr3L6TCPkam2eqHDsQAp/EuVBS
	 9fVY6sDBHM5mQsRj7Ule18EAB/qB8PjfQTMtm8MLs1OSxNMfpV2SWef8M+duMH2D7R
	 4MWjZnQPoqABy8LkC/IJzuh3+mhDO31vF8dnGZQt0RamRQqDnHUBoOoM9fyAu/AfJI
	 JrJfRcPBgV/ixIV4TE9WSCN/TiZakgyK0uj+A1B0la5CYcRRlB/cCyQTA1+xkTcHah
	 eKjsD7fUz8tKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938CE392665F;
	Sat,  1 Aug 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: fix net namespace reference leak in reload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554841014.979996.830118290060515862.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 01:40:10 +0000
References: <20260729080600.2427721-1-tariqt@nvidia.com>
In-Reply-To: <20260729080600.2427721-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, gal@nvidia.com,
 jiri@nvidia.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
 ohartoov@nvidia.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 11:06:00 +0300 you wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> devlink_nl_reload_doit() calls devlink_netns_get(), which returns a net
> with a held reference. When the requested namespace differs from the
> current one and the reload action is not DRIVER_REINIT, the function
> returns -EOPNOTSUPP without releasing the reference. Add the missing
> put_net() on this error path.
> 
> [...]

Here is the summary with links:
  - [net] devlink: fix net namespace reference leak in reload
    https://git.kernel.org/netdev/net/c/1c4dac9bf1d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


