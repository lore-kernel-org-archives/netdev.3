Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7244582FD;
	Thu, 23 Jul 2026 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805039; cv=none; b=BHxv+wfPyJv0pj+R/uMASghNIH48Szz4mau+AYkqTbNlqlswNO9Y5WwqS3ckTR7bR2YpPHkFFUz1lKnOTgi2NJO+8PsPPaEeKYFxNQ67IUYY3vsrXUcS0fxfIA9HgCJKpBf58zTEmz6WzNDb+Hki42vVp4iDbBiWuzoLHw2YfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805039; c=relaxed/simple;
	bh=V/WC1v16vELi82OVken3eVTF0gRS2h3EgaFltF3NuNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBlAkOscSxjODhxEp70X3y9wGWRc5qaEBgrhkA7nDVP42WpjmL/dFOiS5hSLuHnLtxqzeQDUhn1QnvN5xCDDiSry716s+EchjancAK6HzBwXkWq9cFfetnU+jmiHsf65bAJGMcx9zktDciFf/MYyTJ6InK2n3GoxDDZNWGlIntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1E1F000E9;
	Thu, 23 Jul 2026 11:10:38 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC2380DBFA;
	Thu, 23 Jul 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: gre: fix lltx regression for GRE tunnels with
 SEQ/CSUM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480500615.2228970.16340057533399078416.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 11:10:06 +0000
References: <20260713150945.1779628-1-yun.zhou@windriver.com>
In-Reply-To: <20260713150945.1779628-1-yun.zhou@windriver.com>
To: Zhou@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Yun <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Jul 2026 23:09:45 +0800 you wrote:
> Before commit 00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to
> dev->lltx"), NETIF_F_LLTX was set unconditionally in both
> __gre_tunnel_init() and ip6gre_tnl_init_features() alongside
> GRE_FEATURES:
> 
>     dev->features |= GRE_FEATURES | NETIF_F_LLTX;
> 
> [...]

Here is the summary with links:
  - [net,v2] net: gre: fix lltx regression for GRE tunnels with SEQ/CSUM
    https://git.kernel.org/netdev/net/c/675ed582c1aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


