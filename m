Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771F194C96
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171276; cv=none; b=tW9JIzTcV8aKNPCsDuAJGfwCqQulDJZVxPenTrEpwSW1cqoWaW+1jav28b8wZRAcng+Gv4BRP9igJzuJiILhdifaipAEfFZrcGFeDPhxbzmMR94ZOQDSKaDId8mBHz1jKDDeAqKaBBhHZV4BS5CbyIaKr7gdSlfbZhkz1ERDYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171276; c=relaxed/simple;
	bh=5qdHW7+NSFZmWdZGuuUei2RKvemAKe4K8YCqxEEYctY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDLLIGOJlvWN68wuFOkJzdjl8f4UPY769uCfk6majc8zdnwaZ3e5hJvKJMYI9QJ0x6HK4rs8VzU+bbT+U8AN4nbaaj9REmH7znFZZHEDuh+n5I3wdcXJzkljtOaheHzEfOS8fJoDTrkVIrtFh6zaJ1eLRO9xXUXjGSI3poG1R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcMnTixL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcMnTixL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC69E1F000FF;
	Sat, 12 Sep 2026 00:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171274;
	bh=FcAZneA+2eNn+fbr9nIOGt//+s3UyrNTTOejLbzkA3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gcMnTixLb6ofzZCTjXWZ2AfQOlIDQT7eSpSrx2PJ/j4YjaPu/dOwSzY/z73C2rO3j
	 ciIaX9SQxcCBgJec7bPNm2odp4mgzcNumZxZ+Bl/VeEiGfwO+9Wv/nVeWI6kEjvx0V
	 FrmbLOO4GvrplQJCanIf9mOLQs4+nV0Ll+vV4pf1ZGqpHrqsUODrE7VHnoiMK2qz5m
	 nOXWJFRZFnsAs3uSMqsSsTnF2Yr5gnUng9QN7TTaDFNMPBts0nbmqy1rVgLxClmlL4
	 /G9m51tnSwW9EauLlfptDpwNsRmjZFB2cQs7ljlt/HL2dZoOmgqgw9BLRK16jsTVr6
	 R6fGqBAW+cOLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BE3392445B;
	Sat, 12 Sep 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: net: smsc: Remove unused smc9194.h header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178917121038.3168051.1637440830517793035.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 00:00:10 +0000
References: <20260910143516.87304-1-enelsonmoore@gmail.com>
In-Reply-To: <20260910143516.87304-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 07:35:05 -0700 you wrote:
> The smc9194 driver was removed in commit 9fdf9f61fa6d ("drivers: net:
> smsc: smc9194: Remove this driver"), but smc9194.h was left behind.
> Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/smsc/smc9194.h | 241 ----------------------------
>  1 file changed, 241 deletions(-)
>  delete mode 100644 drivers/net/ethernet/smsc/smc9194.h

Here is the summary with links:
  - drivers: net: smsc: Remove unused smc9194.h header
    https://git.kernel.org/netdev/net-next/c/57ca800cd3f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


