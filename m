Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4D3BE155;
	Thu, 20 Aug 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257878; cv=none; b=A/6ieGBlPJelc3s/Zx9ChW6urmcua0f9ouoHN6ph7+y8t9QVSHIwy0IwVr31otS0G2kBRa2abU2RqbBTdcgu7qzEGTX1/9bifF2FmUuCKSFJ0Rjv5gUPxoYb5y3oEYsG1Jm/XCm+rFzLT+BGa0o4LyFtwA3NdkLprbPiKAHJdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257878; c=relaxed/simple;
	bh=lMpdUcmklJD5rehoeZvUqCDUCZb5Iw0Mw010Kp7XA9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UaPDE0waShbjKotxqkT3fvzajw6jL8+LSjmxkyM4Z02rxngY3L885HXn9iWHOSEbuvr+ayAAyinkDMhVsAW80vnibGI3+BQoUuE0RTyNLtpxzbG3I70/ziDdWkMgK3PTIO1F8z+yIc6ml7UcchzDz47G1aJKeDi6A8SUpaUGZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnKykgpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnKykgpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B481F000E9;
	Thu, 20 Aug 2026 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257873;
	bh=lNRxTtzOs38+Kfgu6LElbLYbKGvnn20NVah6noomyJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lnKykgpJTq8ZBKZCfc1qLGhOq8NcoQJoNNlAzlbZtGcBWH+vm9OaAMOgpJowo5Fhy
	 FGr/smhTJge8WY3ONa4+ptOUAnceVUHYWisWbOY1OYw64T6NDuSPz58CZjZlWrDjtt
	 Tm3Y9Ij2AfoHaD9x68hI7TiUr8Z+BZLzj4yZgdBMUlmB8hswGHzopj8zEStMBMvhAr
	 jQVH/NhNN53ANDpRgvxgozELkIUQSROKO8IciFRgLsHRyhrTxFbOlhFC3LAHUpb6ad
	 OudnK67RAezNG+OKeNOQeil0t8GhMaAjsCQ6UboITzq0Y+Tl7Qk8RZ3psY6xK48xUn
	 K27wRNyN9Csow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56943392445B;
	Thu, 20 Aug 2026 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethtool: remove unused __ETHTOOL_LINK_MODE_MASK_NWORDS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782388.470503.10780813049827502225.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:23 +0000
References: <20260818023704.125721-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260818023704.125721-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mkubecek@suse.cz, zhanxusheng@xiaomi.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 10:37:04 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Added by commit f625aa9be8c1 ("ethtool: provide link mode information with
> LINKMODES_GET request") and never used.  The same count is computed as
> __ETHTOOL_LINK_MODE_MASK_NU32 in net/ethtool/ioctl.c.
> 
> [...]

Here is the summary with links:
  - ethtool: remove unused __ETHTOOL_LINK_MODE_MASK_NWORDS
    https://git.kernel.org/netdev/net/c/d302d7109fb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


