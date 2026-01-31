Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49A328B56
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823617; cv=none; b=TEudWU677DujZB2xbio63x61VrBVeV6lCb4U7eD/dsvQNTxIz7p7UO4cr990eJ+HNx705TuyDNEBqs/50fxkT7DgNxhrH6kV6WaD5e/2TuomstAIYWcjX5AwthPlVG2sFLWuRTmZNwuo7MoEHkq2xfov69SkMHdqrX3xaTjiNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823617; c=relaxed/simple;
	bh=uiN0dsoJgB6TonjiBFze4/PVWt/HA4v97Vg2tct+5uM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkhGQx+2pyNp1gpUwSok6Xg5tMXQ/DagDyJ8odA3EZWxfLlTWj2gtA+bOGq4olBbS1XytU4xpcWyUbqhjY9H7r2ulPtHq6Xc/e/aSLzHhqzxO97Z2yaetbMjeJbyEz5F+Vx/R6ceopbdh/NDsJrbhPIpmr3/SO+/0XQhcGyowPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN4KEdvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN4KEdvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C8CC4CEF7;
	Sat, 31 Jan 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823616;
	bh=uiN0dsoJgB6TonjiBFze4/PVWt/HA4v97Vg2tct+5uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IN4KEdvt0o5keEa5PWmh5IKuoCVyMQSMoTH8njFhtGverlSpGjY4GhfL1JUdMS2UC
	 0gAwpue1tsK15Sj6l+HlmaaT3CkBHxOh3XoF2y5uGIcoUUQtkdlQwFpE4JA0gNJI0w
	 uloTsksNdgTakLO7nknzxKqLLdKEk71erWBlyS69OLSeUQtNTueE74urXPhuDJLI1b
	 9i7/RFA6Wt2NFkCoHCmGUc0qpjNOAAl+cGQJXKvFtURIjcOqLc2mUT8FwlFhsAlnPe
	 kWVH0lre6Hrxgfy7Evek40QKlyIKQM6YpN/KdYmee+zE63D9y0F2TlqnYZVfKpXMWl
	 jRrETbGz+E3Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E998380CFFB;
	Sat, 31 Jan 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macvlan: fix error recovery in
 macvlan_common_newlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982360885.3959411.11448443195001037024.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:40:08 +0000
References: <20260129204359.632556-1-edumazet@google.com>
In-Reply-To: <20260129204359.632556-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, sec@valis.email,
 syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com,
 boudewijn@delta-utec.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 20:43:59 +0000 you wrote:
> valis provided a nice repro to crash the kernel:
> 
> ip link add p1 type veth peer p2
> ip link set address 00:00:00:00:00:20 dev p1
> ip link set up dev p1
> ip link set up dev p2
> 
> [...]

Here is the summary with links:
  - [net] macvlan: fix error recovery in macvlan_common_newlink()
    https://git.kernel.org/netdev/net/c/f8db6475a836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


