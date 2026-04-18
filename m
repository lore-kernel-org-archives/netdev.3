Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4730E85C
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540048; cv=none; b=jDDysaK+nR8EUaWw3qwBqTYjKJLWlOVjDM2qdBEPgFs1uuBmEjxmYc3eLJ+L0vJuv3x8xApn4xrIiIBu1Yp4wDrj98z8GRt63Ugs2pyT/5z9p7EOcdt4Dc9epU04Y98uCltRtxVOxDVBf+fTSRfARs/lQpsa3fACEyPvEIN7ZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540048; c=relaxed/simple;
	bh=7qGx5S4EJFS0Vi4DbvvgTWpzGVGc6zPeZW7AYl5tsgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imTFK8R2e38US2vaUkGn63tpg2G9g671xRRVxwQz1MZ1Nmpr74W/PtrXzoccekxhsFphZ98erY0/NzsRrUFTamkFS3SatLDuAJg6LzxrN+6AUwJVCWBQDtE0LIbjrjOdivUijBw3GH0x/NqeRs13QDRoFiTBvbbS0BuZBYMka28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCXHsTZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCXHsTZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B60AC2BCB3;
	Sat, 18 Apr 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540048;
	bh=7qGx5S4EJFS0Vi4DbvvgTWpzGVGc6zPeZW7AYl5tsgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iCXHsTZXjLjfmmESMEzSLM+4otd4M0rmcdvTjEJsPL4Au/bd6Qj7b/vR5HvMVMmkx
	 u6AYsT0yjVzJIZ9j7r6ETo8VsCiG5vgW/5rfgIX3G7WfBykUX1Kg7FAcqgRnebctSY
	 zKvzViUNubeqcHohyVSOBm0u4/hyxOQ5zwfd9m3wDQcjStvmhPPrrkZc9H2IMzr47S
	 FtSTZhCupDNpBHHIJ18NWrRC2Xy5t6RhlKvEPVvpsa0O4YVeg5J/7BeyozrGu9zxG1
	 41Oq05V8kMZY9QMbMV9Q+g35RQ99N+LbRSGtEBRNeXC+nCxB1ZprmR8SZALGYAku/e
	 1jnY39Sto47eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FCB380CEDD;
	Sat, 18 Apr 2026 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Drop all SCM attributes for SOCKMAP.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654001429.508728.3001689497878258768.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:20:14 +0000
References: <20260415184830.3988432-1-kuniyu@google.com>
In-Reply-To: <20260415184830.3988432-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cong.wang@bytedance.com,
 jiang.wang@bytedance.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 xingyuj@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 18:48:29 +0000 you wrote:
> SOCKMAP can hide inflight fd from AF_UNIX GC.
> 
> When a socket in SOCKMAP receives skb with inflight fd,
> sk_psock_verdict_data_ready() looks up the mapped socket and
> enqueue skb to its psock->ingress_skb.
> 
> Since neither the old nor the new GC can inspect the psock
> queue, the hidden skb leaks the inflight sockets.  Note that
> this cannot be detected via kmemleak because inflight sockets
> are linked to a global list.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Drop all SCM attributes for SOCKMAP.
    https://git.kernel.org/netdev/net/c/965dc93481d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


