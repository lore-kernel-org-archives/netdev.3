Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A6257452;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002215; cv=none; b=vDU9aZjP2s44KsTb2MyC/ZRAQQDQPzI+1Sgfpi3eqQpkfIQDqk2ompb3QipiAc2FpuEu0eiKd5Pxl88rQ0ayQYHSC7w+iNGIc/Y+A+SQ/OmDk43/D6ud+RP2CBdf+WlToVRrnvWc/dNE0YM/17bI2lSRmgwKRxt2lvYqBjHj9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002215; c=relaxed/simple;
	bh=ZJv5FsgToGlz7t+vSwpZ8JDnQK+8a8CnI0anK0wI3kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KoIRDI1m9xamaqDJgPntIThJto/9ZoNBKrK33WOIv1gwdu3F0E4oVEVit6h260GoBszhYSy6dtpI6dXJwY9Cxl3nKvmx602Zh5k1eWnMklDY6jbK8NbJAzGUMoOOxvQT18GHCoNk22soL1bK/0n/EHTlfp0BkUtHiA0OyfgnEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbRT70xW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbRT70xW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04121F00893;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781002214;
	bh=7X1R5e8eKyVfWu36Pph9gEJfjpEZaY3IyZSHz3qCkm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mbRT70xW9s/BW9jucRvBzQewqb1skjSYx5sUoXx3lVKN/uMIY14BrVrSzz4JEFKYF
	 sx6HCx3j5zqZq+5ilaRJIW+C4fDWn8F3M6kmoIr9LFTfHGOPCmzXXITnc5hSHf/+id
	 p69j2W+iDSCXN+5t0JtESWTw5M3wuUsIyu6nG5qwcYQeLlc3u91dsH6oTg50pquo3F
	 w/sRzGFIxPOo3Zh6Jvte0I+F4wlI9hsuE2RPqJcwG+ige0wJIdwaHK5D7mxvQ3yr2K
	 SwxYIs77rH8IKnHUykYic3OvE1W/DJj+ZuXdCt62gsyruMVl5qsS08afk6ajssY8kw
	 nR04ex6y6nuQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680A3930886;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] netconsole: Fix reported problems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100221314.1952542.11586659643463276886.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:50:13 +0000
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 04 Jun 2026 09:10:09 -0700 you wrote:
> These are some of the issues that LLM reported to netconsole, and they
> are being addressed here before big refactors.
> 
> I was doing some big refactors, and got some "pre-existent-issues"
> during LLM review of the refactor, that make them hard to guarantee that
> refactor is not introducing any bug, so, let's clean these pre-existent
> bugs first, and then submit the refactor.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] netconsole: do not schedule skb pool refill from NMI
    https://git.kernel.org/netdev/net-next/c/212a922bd545
  - [net-next,v3,2/5] netconsole: do not dequeue pooled skbs that cannot satisfy len
    https://git.kernel.org/netdev/net-next/c/6c537b845c99
  - [net-next,v3,3/5] netconsole: take target_cleanup_list_lock in drop_netconsole_target()
    https://git.kernel.org/netdev/net-next/c/91aeb87f0523
  - [net-next,v3,4/5] netconsole: clean up deactivated targets dropped before the cleanup worker
    https://git.kernel.org/netdev/net-next/c/4cfcd6acc295
  - [net-next,v3,5/5] netconsole: close netdevice unregister window during target resume
    https://git.kernel.org/netdev/net-next/c/0360976d7ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


