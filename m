Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623342D746
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282478; cv=none; b=kXVchtwO/6FmzHGX4VF/3kl02X7xYGai+MGT3i/hB8Yj8JaQcnAiKgv701sHKjONFDz7BHf0b3vGbntDArmqjyBcuEYoVxr4Hu6h78vOjmIfzq0H0MN0imK/nT3V1k0oFilHufqGJfD4H1MrexRyLyPBgyEI2Pz/EZYUjOul3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282478; c=relaxed/simple;
	bh=CwIcb14m3lWhUbv9JNRWF8mjt4sw9Sh+JF4s5ugYjiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URINu/mbiq8jNJGwC4s94L+yOS596+axa7Tj0GTDeaa8H1STOVq/KTyeEC0zbGlggck6Q3GpnTGild2W5K12r//YeN+qPym/QCFiaUpzvvbOPVzpbsQr2LWQ83x2AN/JW/AXN6sFlmiGKd042XxEPY5hwt02NHpa1LTeA+4/3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4zuqhYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4zuqhYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1E1F00893;
	Thu, 24 Sep 2026 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790282477;
	bh=BenbRKnWi6MewxReRZAIxUDzh+wpQDfhH5tL4XGrEzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d4zuqhYPdbFnwCy7KNw9/S3y2RO172KSk5JB3Jhmaoctpwh0qZadZid5F5fEk32HP
	 iaZCeu0SKGjPE2rT1tZJbGGgUDy09T2eTM4p4JkCkvZpQfBmfJQz1UYvFzbcU8YiMB
	 Jxs/BeVg4HVyVvOKmuXm2TZDaK/LIGKgH9tqO7o3LuaEm2AMWostwBq/o2eaQq3WbX
	 ra1gIp3TNjlQyo7sPfmgLLcYrjvVMHmFpGVGqzR87xeChWhM6A5GVttrnNdmgSe60/
	 HFWpOcsczXIdgOFXtRuBwCt8R/p7BXOlsmRO7dywR68a/+mN/Oz1HS/OZNyEBHb92y
	 9KptacDPHJk+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199223A566E4;
	Thu, 24 Sep 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update Eric Dumazet's email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028240590.2191179.10831740104419107305.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 20:40:05 +0000
References: <20260923083203.383923-1-edumazet@google.com>
In-Reply-To: <20260923083203.383923-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, edumazet@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 08:32:03 +0000 you wrote:
> My @google.com address is going away soon, let's switch to @kernel.org.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .mailmap    | 2 ++
>  MAINTAINERS | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: update Eric Dumazet's email address
    https://git.kernel.org/netdev/net/c/11536ee3d3e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


