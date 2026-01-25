Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E830FC20;
	Sun, 25 Jan 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382613; cv=none; b=lEh0+oT0EVzpVbNpzyHEEF5jojiBRvnrLFt/5p9yal56B1Ths5qWXEA8iQl/CoZtx0yPSumZjvr+gHodcjNgmbwpYtUKuzMbwl0Z/xwAmqUEkfSTR2Vv+yn4MigHkbnWMWEhRwCu3l5N0OjQVH6uEFnECnPoNZsYHFq/EgEnuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382613; c=relaxed/simple;
	bh=eauUbp2rwhmoyr6JiRBHBy4ki8w0X8Az2LohBNdQJzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDubSLBW7T+YHNXEElVPkc/sCNUFPfTB0qG2B23ydFLwBO+SP0X7w/ysa57oUfZ25wXwwoOkbSlWg46+zE2vVHg7BJ1MJCClEhtWQ71mhYRTCEuCcwe3BmoXYxH8h3OEJNlHXpT1qZTmsQ1svuw1WEnXETWxIcXCuq7nvN+UwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3t6LltL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3t6LltL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3524C2BC87;
	Sun, 25 Jan 2026 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769382613;
	bh=eauUbp2rwhmoyr6JiRBHBy4ki8w0X8Az2LohBNdQJzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3t6LltLgwEaflAytiJMrhZ+sVQNIPbgg3So931ZgS5nuhv6/DTnKnDwh02cgPaxR
	 siaowQ5uin4ALBPe4IbClDtjw9Vs1iAlEZKF7YaliuobvxoC8ePx8ai9dpYK5kZyCh
	 rnHUD7KvVOT2Y4SDOC5a2YuNjwsgXhceia8XPdMH9wHNtxG7ijqIDQVG0Dz93jJ8E6
	 IVKQA00S5YT1bqCxKQO92E9nIylKl2KEeQrvaOiR5d5Fn8f56Br9Rd2hCqwpuE0NMw
	 s95RIYJtPnxlg7YQHWrA9mCBz1t/Vr89pcp+Ks0lnzwU+GQedO+xzJI/Y7DOOD0bve
	 l1sqhIf3x+5Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119203809A15;
	Sun, 25 Jan 2026 23:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: rename register write commands
 for
 clarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938260785.4008633.6762846189649334397.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:10:07 +0000
References: <20260123080409.64165-1-enelsonmoore@gmail.com>
In-Reply-To: <20260123080409.64165-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peter@korsgaard.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 00:03:58 -0800 you wrote:
> SR_WR_REG and SR_WR_REGS may be confused at a cursory glance. Rename
> them to be more easily differentiated to prevent this.
> 
> Suggested-by: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/usb/sr9700.c | 8 ++++----
>  drivers/net/usb/sr9700.h | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: usb: sr9700: rename register write commands for clarity
    https://git.kernel.org/netdev/net-next/c/4a7bbaa663f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


