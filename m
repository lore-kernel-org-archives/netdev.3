Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4B233704;
	Mon, 13 Apr 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120637; cv=none; b=Tq1ZgtL7g6lw5YE/23egYrqn5uxj8WcpxWxPKidfnbjfjfSkJkga0NfK8g+rGR0gt3TY8FM9Iz9t9bKJLCB3C2v7jH1yfXPZB0n+lgZZosKMtudevNXs/pojzUcQf1Vfc4TGkNctmNj+y5mzaBcw9WQ5NY2r/pQ4kCIoOTAJ9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120637; c=relaxed/simple;
	bh=pHxYSm48GvZu9OgL63Naj9A5UM5duMr7/LPEHuVexGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPglaAJ3p+Ruru0BvEtmSXNAcTU5nYCDYyJCntB/gHD4BevQxj5QqNysKr93JcHCgxtavAlwUZbaN5bbTfvrQT46lzfrQvdaBPbkgd5bpUqYn9U4E/tW4Wd9otzbShE6UwhcAI4VMP7RkP0NI5/k/2kXzJK+yaRSPnojd2oNgyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q89oAXhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q89oAXhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3BEC2BCAF;
	Mon, 13 Apr 2026 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120637;
	bh=pHxYSm48GvZu9OgL63Naj9A5UM5duMr7/LPEHuVexGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q89oAXhm5ke0dUSczizJniadAlcSBvrFUnXmUlKCrDIGcTSPfm8zuxnYF2iTqZH+F
	 3sDqMQm7+E/cLs17Avgp3HY7k4GjOfFrJXzsf7HPQMTjeblN2x9jdDQfUrZBiA+MK/
	 WHYAdig2UNOFkBBTBU87cpMbZWzm7jpjDDufUBas/XpwEtWYTZMD9LbIwiv9cHCTgW
	 AdBnZBlfYc2yRhgkwr0qZqHjIPH4ef40K9pGQoqFQZrfgxTTMtJHnmKhT5DBuiVqkj
	 Ztesdhz8X3fW0Jsaxpzji4Fho8JCHxgiHeE5DqV4l3c9E8Y2pScezObmav5g7w1S/L
	 lN2NEykpC9oKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE843809A0B;
	Mon, 13 Apr 2026 22:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] octeon_ep_vf: fix napi_build_skb() NULL
 dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612060882.586394.18281739297986943310.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 22:50:08 +0000
References: <20260409184009.930359-1-devnexen@gmail.com>
In-Reply-To: <20260409184009.930359-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com,
 srasheed@marvell.com, sburla@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 19:40:07 +0100 you wrote:
> napi_build_skb() can return NULL on allocation failure. In
> __octep_vf_oq_process_rx(), the result is used directly without a
> NULL check in both the single-buffer and multi-fragment paths,
> leading to a NULL pointer dereference.
> 
> Patch 1 introduces a helper to deduplicate the ring index advance
> pattern, patch 2 adds the actual NULL checks.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
    https://git.kernel.org/netdev/net/c/4e5bc3ff060e
  - [net,v2,2/2] octeon_ep_vf: add NULL check for napi_build_skb()
    https://git.kernel.org/netdev/net/c/dd66b4285470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


