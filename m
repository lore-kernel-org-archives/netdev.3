Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE6468C14;
	Fri, 11 Sep 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116069; cv=none; b=qpQJu06k7/lJXcHW6/um0gCyaddTF6OGXBD4bZf5YsGMTAGp0tt4bQ3gQ3heY74dEX05xdzgJ8rCfN1nFLXsyhJbE1PHl5BcRfuEI4vrxR6A/h0WtrvT4wg/h+yiKo4Vhf05kIpLV5AWzfUFkDqAksDl2FfrfWklA5uNYgm2vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116069; c=relaxed/simple;
	bh=rDD5WdJ6FwIvJQ/rdD6h0LbgUyo4SNwab9Ow6DBkBr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAS9eW17ajyoNKtLg/wmP2bVal3+KeFxYdSQAegKpr4SmfYcteOhydKvcmR+HcQBr+8q8r3Wj3TQ4DT22kHyiA+8TxKlk7HjHAFRv+/aD0VB6KaP06Yabs1YvCjPhTZpOT8naJUr+bTQQdPi+CcyALSP0bU4TKb2hysh6NArr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJm7bY5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJm7bY5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB01F00893;
	Fri, 11 Sep 2026 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789116067;
	bh=icLjni0YZ4pG764hXKj3kZcdRW9BBp5jcpTb2gvrg8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bJm7bY5n7KnC6VV8hw6to+jDnsX1WrMZd8cKmWg3xxukSmlrSLDuNAzJwOQtEhqot
	 Ax+eco1hmw+JOWG8CN0OFTsUT36Dh6RYEswNKc8Ua//PAzsgkUvTbxHd9SgUzGfKpW
	 tL0/qAKEgAs6sk9wbw0z85fkI1iXWpVX23LgFu/uDfPx+Pj6H/+N63iv05Pzw3enhL
	 950iVobTRz592hQL4xO96hY51ZdkR1TVkuhTrWucPG+BviZoLFesVzCk+Vc9g4t1dc
	 KZAGQ5U5M6TrY/XOnv79CE5hewY4FoUhONkyLSZDAF2lUs8sMoji0mHb2TvWQfXOrc
	 ZDiPZ3rrPkJ2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF23811957;
	Fri, 11 Sep 2026 08:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2: collapse consecutive blank lines in
 source files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178911600463.2314117.11103940478198681712.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 08:40:04 +0000
References: <20260908061113.246837-1-rkannoth@marvell.com>
In-Reply-To: <20260908061113.246837-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 8 Sep 2026 11:41:13 +0530 you wrote:
> Remove extra blank lines across the octeontx2 driver source.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 2 --
>  drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h | 2 --
>  drivers/net/ethernet/marvell/octeontx2/nic/qos.h    | 2 --
>  3 files changed, 6 deletions(-)

Here is the summary with links:
  - [net-next] octeontx2: collapse consecutive blank lines in source files
    https://git.kernel.org/netdev/net-next/c/17d3afadf539

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


