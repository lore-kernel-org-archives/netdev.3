Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B425A2A2;
	Thu, 19 Feb 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771464026; cv=none; b=EFLaiSvD6GFfwpu3OeszR9BIhknSH16qiNp+UNjyb8QyskR4H1wCEb57d2eukrSeCcv3/Hs6++Rh0WII9GlmTkT5goLWcNrlf3KlvE1fN6MnyRz6TXnMIKDyvEFaJ1zUBPPGZhyubMZUHB8ISfYLiy3upaWJdapAmOgDuzijmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771464026; c=relaxed/simple;
	bh=VmtAjIZOutr3x3Q6CAFvx3ilseHXFaCKzuUZ5iSr1dU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z7WNSYQhhZs0ujvWAbNbRRMaWuJNpc69kOF7ojcRv/GCxI2Zlhng5sIXE5flgWx7WTaQqhdPwycoaRFW+wDqrYcE7qvoYxuWuv3FqMU5CQ2FCjGPd9NKvXGbjfZg2MGwgetailfxYaz5Q5+JFeZWddSFFojkNFkbeyEX+LJSZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksxT/CpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksxT/CpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94359C116D0;
	Thu, 19 Feb 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771464026;
	bh=VmtAjIZOutr3x3Q6CAFvx3ilseHXFaCKzuUZ5iSr1dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ksxT/CpB58sf/tzl6XR3iw7wwuXozZ3y/Cm0kBvm9QbPrj5fdEVGjhPKBqHwbpE4V
	 U3mHs2EVgcWqdWSiAo9bW2ej6GBXZ2uq9UIyeCFlverQmaUeBY7KCVBNH96S3yXED2
	 Xh6PERhlCOgNufppCP4Hxz2yqyVM7qOu+vpz7jUCLOZuB91yRct20cvTC0Z7yCUAQE
	 eLyDXvXRACwG+9TufDH9+QphIqZOGIJL7K7XvbMH8LIYuzbBDbes5JzW2x1vFyMICt
	 LLjWb0yvk8KnTAr+sx/MRbSChD6ogSbieEwihOPryfNVW/2BssJzLj1ApihOdc3UGx
	 TmaYvg4VG+7bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFC8380CEE0;
	Thu, 19 Feb 2026 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-af: Fix default entries mcam entry action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177146401782.1625981.7221483538428502621.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 01:20:17 +0000
References: <20260216090338.1318976-1-hkelam@marvell.com>
In-Reply-To: <20260216090338.1318976-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 14:33:38 +0530 you wrote:
> As per design, AF should update the default MCAM action only when
> mcam_index is -1. A bug in the previous patch caused default entries
> to be changed even when the request was not for them.
> 
> Fixes: 570ba37898ec ("octeontx2-af: Update RSS algorithm index")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix default entries mcam entry action
    https://git.kernel.org/netdev/net/c/45be47bf5d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


