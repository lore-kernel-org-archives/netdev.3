Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A213B83E3
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251429; cv=none; b=c62qSZJ4wXkZ+jmLbVEZvLp3l5gaKqd/afxai+n4b0bSElb7t4zDCaKw1N591bzUcE6HtbCv5ZMHFPx9R23+wsSQeeDLciBq2q17zXfbWTw4BuCTkcHI8ValdnSZkcZ2Cx/1l6aHYgL6AFjwwWxv1qe+sDaANCjRtiS4dTSovxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251429; c=relaxed/simple;
	bh=27mDXKHzwA5jaPNNiruOJY25oHKdh+cATyqTUAy+X+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XoUIfkUclArBSoyeF6PMduXfx8nxj47bxThH6R8y35/CtNwb3Y5+cdQ3qd/M4Ki5mMqlR17YR5hLKC8EWGue8W0s/jbgE4KOBzJz2diUq6Uca9S2a4jufyNMOSHKnbYNTvnDjhtOaSQeFBeKnH/X8omiONQHV2ddukpiD68RAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPXKYyds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPXKYyds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2101F000E9;
	Tue, 23 Jun 2026 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251428;
	bh=4fAKDFStunawYfR+vJ71JAKmRG4aqqliOYj5RDHTR0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bPXKYydsOh1cGeTvECjVQGF5o+3Zn2YsakLb2ITWP9ZoToCfw8LDerovGz8F0zt3x
	 8Xt0ZJIKt06w8RrKXhag8d1X1yMxmza7idZ8ho7a/o2c+t6IYm607U5X5NDGE9jx/C
	 6UKjZO5AwbYZywFHxv/gXNAcCV+3dZI1EVz8OzSeMCigJqNUIZnb6yvlCD+fuiOTyV
	 X6PkQPQ5VLOKL/gxQdzaa0n+W4nOYuWXjecuVMMswAx1z22aajKr/Lyvv4p8ef5v4b
	 pj4eorO3rXOZ3LHrlXn7udPuAZA9fKOu22KpasgtHX+CyXjphorPaQufv8dEvceHDE
	 cOWgByEMNoN7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93918393101D;
	Tue, 23 Jun 2026 21:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: fix NAPI leak in XDP enable error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225141707.2433118.6555336369645285304.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 21:50:17 +0000
References: <20260622111825.88337-1-edumazet@google.com>
In-Reply-To: <20260622111825.88337-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, groeck@google.com,
 bjorn.topel@intel.com, daniel@iogearbox.net, ilias.apalodimas@linaro.org,
 mst@redhat.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 11:18:25 +0000 you wrote:
> During XDP enablement in veth, if xdp_rxq_info_reg() or
> xdp_rxq_info_reg_mem_model() fails, the driver rolls back the changes.
> 
> However, the rollback loop:
> 	for (i--; i >= start; i--) {
> 
> decrements the loop index 'i' before the first iteration. This
> correctly skips unregistering the rxq for the failed index 'i' (as
> registration failed or was already cleaned up), but it also
> erroneously skips calling netif_napi_deli() for rq[i].xdp_napi.
> 
> [...]

Here is the summary with links:
  - [net] veth: fix NAPI leak in XDP enable error path
    https://git.kernel.org/netdev/net/c/6739027cb72d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


