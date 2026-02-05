Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803219E968
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313808; cv=none; b=XJexTbpl/clpleBKtfZqGkQeKzUjH8OAuqaeP1HBx/TLcmNVNTAbL/smE4ZzskePU7kJBvYvoRlJnh3rFr4u7vwW6nCXatMkn4bqUp4rfieBceYYDz5Y99jrmTQ1t7dUCA1szQ1WABL0QCpNgUWfXqEM/7Rc9AkPXCIjeXUgEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313808; c=relaxed/simple;
	bh=vcxaYP/ueEiyAdsuYc55Oz6qocVq4mnUutnLmoSSZvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2zGc136jhIlIHUeNcTAOP5L0Lu4Sbfmv69swJBlU5MGMN+9wY1cxW3iIhcFPetFwNMfuMCBRjTTgkA5UnhR4XdwUrWwALKB0InLhCr3Oh9USUQol51tV8+jwg2xfvRsrbnMZwtxIRwmv71D602qaPu+XQ9e3D1Td2BJfAUiEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyimNbn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyimNbn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11776C19421;
	Thu,  5 Feb 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313808;
	bh=vcxaYP/ueEiyAdsuYc55Oz6qocVq4mnUutnLmoSSZvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyimNbn5mXgbkVPTkIo9HOO69krNRE9yGL4H/8zw8TwvdRFbvWIyesDJueBig50Hb
	 LFXQGxbF4uR6TUkNick14bPwJSkKI1FqIW5LyKOHuw8tkqLAmvPOsgdQqIbWVejmd1
	 wSxzVoCsrVPu6DoEtINDambXMlYsP4GdN9IJ0/P8nrnEoeu5FzM5lDUF3wYpqXCHrf
	 bHJr/xHXTcsEI1cU6dKYSu5yTPorycQdPaaEYJMF84wkeqUY/1cxlc1UAF5TYc6UPZ
	 AvP3tqw0PGMKRw0fAA3GhfU0DJaDoKhNtEZb1lMCxRaCrAhUUJaYaUR1X5o2tlzv0B
	 dDyVJRtqoBeig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B3253808200;
	Thu,  5 Feb 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: don't use dynamic lockdep keys
 with
 clsact/ingress/noqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031380558.510957.10572633042146921098.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:50:05 +0000
References: 
 <94448f7fa7c4f52d2ce416a4895ec87d456d7417.1770220576.git.dcaratti@redhat.com>
In-Reply-To: 
 <94448f7fa7c4f52d2ce416a4895ec87d456d7417.1770220576.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 17:02:31 +0100 you wrote:
> Currently we are registering one dynamic lockdep key for each allocated
> qdisc, to avoid false deadlock reports when mirred (or TC eBPF) redirects
> packets to another device while the root lock is acquired [1].
> Since dynamic keys are a limited resource, we can save them at least for
> qdiscs that are not meant to acquire the root lock in the traffic path,
> or to carry traffic at all, like:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: don't use dynamic lockdep keys with clsact/ingress/noqueue
    https://git.kernel.org/netdev/net-next/c/a90f6dcefca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


