Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304ED3B636C
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401661; cv=none; b=dgWZqffgx1ruHvbJUZBD/CsZIwh4u6YuGfbBjZSD0WDtX98S2pB6TYm2aVpO6aJdr6qSst7RbMW+63oEowHwbYEk9ftQWKESpf1Tm0mgidEL9hZlNYU1FYxnV3jHyLAAQ+ilJVJrQk48wXQzhAMKtEKFAfU3gtnLLMOq6gIX/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401661; c=relaxed/simple;
	bh=irzc2LMCjizVItdXIwlnqSB1aqTHBvO9rVby6XFQriY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZVhWp26pGMh6sQVfOREhIDnkuf8BAj+wzf6zPC1KbnTbkL5xbX7YctaahYhqQl4foyWbMhnFSkY2dktMQmZV+qycoyw1NRmwnbRdjJnB+XLfd8rj5Q/CCzLMn1i+AKuasADneXVPfe981aIt0SrEg8bC5Tc/akUDMRLyJgrm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkEGndsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkEGndsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73731F00A3A;
	Mon, 10 Aug 2026 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786401659;
	bh=zISDMFZq6uwjYl2+wOOjAsjp4TwNdjkL6UJzGB9mLWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PkEGndswlyd4zvHIhoZZMBPpzqYaOr8FJmo4RuxP/l9o3Z0jHmwEJ32u3cnvKQVi0
	 pc/MkMp/byIgm7gWVBGVGMzfBy+5eCXUCeGfGsxUea+8/KD29VwhwWDpQ2UftZuLik
	 qkNWlf6s7uWYCM92Jr9Z7Ny6yBymDai8yHm8yMOc7qFrhOZqO3nLTVzjBg5wigFqc7
	 HuP47D1R12NtYEt2NTdh5q5v3ds8tw0lIg0dSu6BeEvhAYDQ622+c+zRsy1xFnc02m
	 PpFS3MikAfS2ht9G1i6AZKExbwkPOZsFeSkfinFic4rQ1lnJ2c2Lf56SKP5Wu14DvQ
	 PNeBHIcvhIpXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939693926265;
	Mon, 10 Aug 2026 22:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] eth: bnxt: fix IRQ notifier bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640161629.238814.15246807781397907873.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 22:40:16 +0000
References: <20260803193135.2030368-1-kuba@kernel.org>
In-Reply-To: <20260803193135.2030368-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 manoj.panicker2@amd.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, wei.huang2@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 12:31:31 -0700 you wrote:
> I was trying to make bnxt preserve IRQ mappings across reconfiguration.
> While hacking on that I noticed 2 bugs in the notifiers that should
> probably be fixed before development work.
> 
> First one is simple - TPH recofig makes aARFs not work. There can only
> be one notifier per IRQ and TPH "steals" the callback from the rmap
> updates. Fix by patches 1 and 2.
> 
> [...]

Here is the summary with links:
  - [net,1/4] eth: bnxt: cancel IRQ notifier before freeing affinity mask
    https://git.kernel.org/netdev/net/c/c703f62c30f2
  - [net,2/4] eth: bnxt: keep the aRFS rmap updated when TPH is enabled
    https://git.kernel.org/netdev/net/c/4b5cb58a4443
  - [net,3/4] eth: bnxt: decrease indent in bnxt_request_irq()
    https://git.kernel.org/netdev/net/c/0fd562c7b9e4
  - [net,4/4] eth: bnxt: avoid deadlock when canceling IRQ affinity notifier
    https://git.kernel.org/netdev/net/c/51e96fa31f7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


