Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05931D362;
	Sat, 12 Sep 2026 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171274; cv=none; b=en7jfnHUPZHxYKEGawl/xZ5bbXluhz4y0+zntchXeJcfCKRN9t0iJSXF6Wi+6ROht8vlQlZgR6ittV43LdWd7Q6iOKLUxQzSC3E2iZOVeiHDheONwISxNYwQtgZIUCKxa32gudXyzglGqC3JuIjaiy0Fn5xw1g80EaYZ8SWnAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171274; c=relaxed/simple;
	bh=eKI+gI+JKGdVOkJu5X7JeHWpiGuoWuu7uo/Sb1pkctc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S2+Nk3gY9a5M9OQyZUNf9TKmgQ6H7pVN14S8eAwbHKUdNXiMcPmeEAAGSB1XG0bh7GqxTFQAgNA6yww6v/aVz0e9t7UMpCz9hxWM8kpbAr9QAgXRLJpCpBTT96XwS+EV1DSFqpB36ibM96X/p5hBd1Mfd/hKAOSA51jTPr/4hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYi8jYwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYi8jYwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4F1F00893;
	Sat, 12 Sep 2026 00:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171271;
	bh=J3dP6TQ01nerFYbQUPmYoRE/18ptxGTy8+QhUv+PZFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jYi8jYwt+DUsfPMZdr2mcWWlFdyAGfP03MoX4fkL5Sh3zbPIHy3VMiZJQuW/SQm/F
	 KzunQ/m297CLzNUYxHPr2F0AsQAzdvhE0OewwYHNg1Ob2Fg+3euL/8N3kPsCflRXQC
	 oAnIVlTGYseRQyuaFIkKdujMaMu0shCL8wTJkhuUMgSV8cyJBiWrFkISpW/SAOXznJ
	 Ug7hjNkhDGg8y+HW5rMcD1erxCL7aHf/oVl5VVQDTISKDsq9fBSEsPc2c3vKUn8B6j
	 bSM6jKvReaU1yPd7d9ULf2mbjTkCp9e/hHj0QS5hfQbYGPEwwDilCpY2D08klSCkeQ
	 IN2xwCGfA5Yfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BB4392445B;
	Sat, 12 Sep 2026 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178917120738.3168051.8796678700758467343.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 00:00:07 +0000
References: <20260910094937.536150-1-junjie.cao@intel.com>
In-Reply-To: <20260910094937.536150-1-junjie.cao@intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, idosch@nvidia.com,
 fmancera@suse.de, jiayuan.chen@linux.dev, hangbin.liu@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 17:49:37 +0800 you wrote:
> The forwarding paths report an expired TTL or hop limit as
> SKB_DROP_REASON_IP_INHDR, the reason otherwise used for a header that is
> malformed (ip_input.c, exthdrs.c, br_netfilter). Nothing else in the drop
> path separates the two: IPSTATS_MIB_INHDRERRORS covers both, and the TTL
> check runs before NF_INET_FORWARD, so netfilter tracing stops at
> PREROUTING and never sees the drop.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
    https://git.kernel.org/netdev/net-next/c/219c6b768ec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


