Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544017BA2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083410; cv=none; b=XHPC8NWtGRGGlFfUC+fPOBpm+/9vPnrprwCIAj2eNA1Xf5RQ2/Wsmzea1DKb+b9lT/yOXesNJkERcCyHTJzBpkDIfRpJHVlmq5E3E22F0b+Y4MNFGji8IdSiBPpkDv8KForc8RqJv7e15lvDcrRLdgcz+oVW0lWUYV5B49vAy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083410; c=relaxed/simple;
	bh=HKaer171I00u6sUib+I72oOcGjhfhP4gdkPr+Q3wVFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NHX0CIkF16ddeUDvZYLlt5NaxlWVNucTzWqk8C1zpRDlvHHaxK75dkjokMrRl1EBOUv0Ru3gg8IxpGxDzVk+fevLOfqfEDG8TWcR1CYsPjmfwDPZmPmo0uo3UWwCmvYdttmggFiiB4Vw+eAm7K+qGA/e405YlJqjNajtWuQNfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPg6ayN1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPg6ayN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F563C19422;
	Tue,  3 Feb 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083410;
	bh=HKaer171I00u6sUib+I72oOcGjhfhP4gdkPr+Q3wVFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pPg6ayN1a0r6LcMD/kJNiWzlDDfCiyfcaQM4deYf/mtZsxVc/DwjxA3PTDr74Ia2J
	 6BNKSd4xFc2lYWF7KbSGC7H0hnC5FeHoJdGY1F5AQr5/BEBfVN3/nQf7POIPPDICCd
	 eMPVfMeLCShix11XZDuN+AETydMR+hzFMC2my3sXTLQ7/jIGV2MtiG13v9+loWDASu
	 G/l8eQ3oSD7JOgF94qZTDyyjWforBf2CAgANpdGIvu1uHVBZ+EDAM2y0jKiGvhrL+M
	 B3aNx/eWDrsy0v9e0Lree44HGssjVqnmHXuPrhnMrBFkIMyQmUZIdgCzJXQadG1R+J
	 3LP9GGduPH66w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 53EBA3808200;
	Tue,  3 Feb 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add a debug check in __skb_push()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008340713.1270041.12769755810847858576.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:50:07 +0000
References: <20260130160253.2936789-1-edumazet@google.com>
In-Reply-To: <20260130160253.2936789-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 16:02:53 +0000 you wrote:
> Add the following check, to detect bugs sooner for CONFIG_DEBUG_NET=y
> builds.
> 
> 	DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: add a debug check in __skb_push()
    https://git.kernel.org/netdev/net-next/c/dc9fd14bd759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


