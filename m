Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABC331221;
	Sat,  7 Mar 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848207; cv=none; b=VKkorVRihLhekpHWNg3Mw+4CYLptHdBZRT/R6L+qKXNF+4wn7S8CtIvqMsZWQDJKxOhvLUzYWEtvKNNcxRY0w5HPxcGFaVrQGokFlP9oZ7tdckCLXmBrinip9iZo6mhjCt+zCNwEJK+sz4xiZwgC86n6Fc9EALLpbHHTC+sF0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848207; c=relaxed/simple;
	bh=1ZABRamW31pQt/jXUGfYJz4dnUPI3Zy+7mm/WNHMNIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BPvez6klEtbx3++4Inlbes1MC2kO2XN6nHHxoos2VHOAWuiXfPPIDeiM5eFTcEt89oKoDVswhZHrRoxHU75BXM2u+Ni5RDM6qrkVJ47xGmtPikDnfVW1saP4hsJFECdvlfTmXUb//ChDe1UCDk1rwDtqnVKBnLbFWIbzUcLwAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNWSWxFD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNWSWxFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69497C4CEF7;
	Sat,  7 Mar 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848206;
	bh=1ZABRamW31pQt/jXUGfYJz4dnUPI3Zy+7mm/WNHMNIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNWSWxFD+cuIgjzfovygktsfnDcn+XKMFSTQ+rtcnQepOZbN/559W7CKCD0zWPxmP
	 XHSaHfI/cydoYQH+r6EHA2GA1OEXMvdZcmlk8IMBtquImotASpn6uVefULV9ceW4Nv
	 MtDprxGxwng9MKhija42bnOW+5OAvWSg3hIlIO+L4QwOl7NBpl6+UUnKyhKXIVv8r+
	 IJJssZLiiOucywfJEOOfF3S9AY54PD3uyFDetnejDSDYX3W6Mq2pkJ6c1732pBRssa
	 q9TGJYAG12HpEZCEpI84Enn0ovgvOMtVn2W7+dBL5gTDKcyY2cVwS5/5xz1FHif6pA
	 RXEgnWsD0Jbdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FEB3808200;
	Sat,  7 Mar 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: teql: fix NULL pointer dereference in
 iptunnel_xmit on TEQL slave xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284820555.121768.767933765005897381.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:50:05 +0000
References: <20260304044216.3517851-3-bestswngs@gmail.com>
In-Reply-To: <20260304044216.3517851-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 12:42:18 +0800 you wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> teql_master_xmit() calls netdev_start_xmit(skb, slave) to transmit
> through slave devices, but does not update skb->dev to the slave device
> beforehand.
> 
> When a gretap tunnel is a TEQL slave, the transmit path reaches
> iptunnel_xmit() which saves dev = skb->dev (still pointing to teql0
> master) and later calls iptunnel_xmit_stats(dev, pkt_len). This
> function does:
> 
> [...]

Here is the summary with links:
  - net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
    https://git.kernel.org/netdev/net/c/0cc0c2e661af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


