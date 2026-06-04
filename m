Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A4175A87
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539034; cv=none; b=KMisICbe0AmLSo3S7y/AgRJf95ZHeBJD4Fapg1lDvsrfBT2qD/9nTHNQ+gcx+ciecNQt3dDhD9ntEPg5/pIOBps/iq10ziLP6n2/3NAIQZNwbD5aA+cEdOQD5rsrp6YsZjdBzeEUO9hsBq4r+EdlSd09ASfQNTQNhPkbnm4uk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539034; c=relaxed/simple;
	bh=c3hhm7Zqf+gNjf0VvC7IopyGqccIycOmI5JVAUQHry4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HJ/ciqMnvblvOqSul+MWGw+OqAyYt5o4vVcXgbnvz48CbZQax2ZPv74or5MlGqKpPfSl6A88xNFo85KWmN9Hz9pO4ff0q/+m5mamH2QTDpkrh4KZhwU21ycUxBM+xTy16Ed2jvotxooC/fjezGgXjRVfSiktJe+PhDiC6VWkN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLdxB3eU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLdxB3eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90CF1F00893;
	Thu,  4 Jun 2026 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539033;
	bh=SIeh6q10hdMReVmyobjMeRoq7cyTbd5YCj0p5apkFvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iLdxB3eUpvOCz6CoIzDfWauiuA5VtAy4oTjzj8qnJ19LDTxPvywBxW81ceeIHYgK1
	 kq5bcCIG1O+H+ahDqd4hrcnsyReBN9QUT1vi0+AX3RUaD9RZf6xT54QmXQhCsG/+Sl
	 onRWnIHp9juefgigP5mOI8pmcbno/rp9kUtihqkLGHy/Jh/quMp6nLZsvsE2H9lmVb
	 vj3D5vx2GGp+m1y1RduKEOm35aPoqXTk8b+QBAF1i57sRtn0eXWus5JaDncZk5cGBm
	 8gBXt+nG6EpMHVRapK/gLL24ShJNAj3wvYQN4zW4bNg3Bteh22to5sMtnYpm2dS/O0
	 09u7lxMxePZKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FA39308E0;
	Thu,  4 Jun 2026 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] mptcp: change mptcp_established_options() to
 return opt_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053903388.2204548.16208809216757781332.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:10:33 +0000
References: <20260602125138.2317015-1-edumazet@google.com>
In-Reply-To: <20260602125138.2317015-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 12:51:38 +0000 you wrote:
> Instead of passing opt_size address to mptcp_established_options(),
> change this function to return it by value.
> 
> This removes the need for an expensive stack canary in
> tcp_established_options() when CONFIG_STACKPROTECTOR_STRONG=y.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
> Function                                     old     new   delta
> tcp_options_write.isra                      1423    1407     -16
> mptcp_established_options                   2746    2720     -26
> tcp_established_options                      553     503     -50
> Total: Before=22110750, After=22110658, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [v2,net-next] mptcp: change mptcp_established_options() to return opt_size
    https://git.kernel.org/netdev/net-next/c/a02a765bd5c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


