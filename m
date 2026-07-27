Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD7377A80
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190850; cv=none; b=nc7KYyaSIN6wTMsybV3AlJ1E03Ld33ZcQZgPxBDfP1F7aYXsrYrm7vBPAbBwy/54KyDs9Eqil1nYqPKf1ZjaXExj59B/tVdVryA78buiyWPnRLdDZiap+tQvef82SYKRH36hBqE+85GtIBruK+N9p2ULKNNd+pJRJcqk13nYVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190850; c=relaxed/simple;
	bh=/b1wyA+c1JYEDPrkWiLd9x7WZOBo74UOhVEX5xTr224=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTX1EmaqbtudLRs4hWuroqKHfajV5tDdXVkvGTdfShYB8S48OHJADdZnG8MZKPhPzU59AlAWqToEIBGTxI8t8AwluS98xay0gWt5dDjVK1SvhEcEKx/fmVjRWyz+BoLCnZRjUopgw1iF2382yQC/sEuUtPBwmfm/hNk2KyMnTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxyduh85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxyduh85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA6A1F000E9;
	Mon, 27 Jul 2026 22:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190849;
	bh=QVtJlehto+7DspYRgEx3SYY8MDRzePCaNkJ+uy/kpeU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oxyduh85IWYlcTid318ty5DT+hdUV6wDG9oUiquO3OptmWSH/T9+mPpBS40o1IAQ+
	 bE/IhBcdPHktpL3j4NFKoCy3iMgtOfH14SvPucq88xwRY5Eia23TQYQiA8HGLkeo9j
	 TBF3BUzqG/VA13+4jnx7ESLqaYHlJi5/OPOYA9ldPsLSfbgpPlEOAFYnIjGnzZQMox
	 wCFTHfYRAPKW6u7HFc3kWharR4DvqQQTOvGnOpjcyVZQcJGkkm6Tvr4TO6Zl11AtmB
	 A3lWv6APepXBHv3Hp7kcE8bA/Ga3xl91ICVePpMi6Xf/ARct1YqTYfa52ULGmHrPKE
	 nY/670xirGQsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EA380CECF;
	Mon, 27 Jul 2026 22:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] vxlan: fixes for skb header pulling, cloning, and
 concurrency in TX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519081439.1438149.9964994403832943446.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:20:14 +0000
References: <20260723144249.759100-1-edumazet@google.com>
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jul 2026 14:42:44 +0000 you wrote:
> While working on RTNL-less fill_info for vxlan, Sashiko found annoying
> pre-existing issues, adding noise to an already complex work.
> 
> This series addresses some of them in VXLAN transmit path,
> primarily within route_shortcircuit(), header validation, and neighbour lookup.
> 
> Patch 1 fixes a potential use-after-free in vxlan_xmit() caused by caching
> the Ethernet header pointer ('eth') before calling route_shortcircuit(), which
> can reallocate skb->head via pskb_may_pull().
> 
> [...]

Here is the summary with links:
  - [net,1/5] vxlan: re-fetch eth header after route_shortcircuit()
    https://git.kernel.org/netdev/net/c/1395a676ec15
  - [net,2/5] vxlan: unclone skb head before modifying eth header in route_shortcircuit()
    https://git.kernel.org/netdev/net/c/760d36e737f2
  - [net,3/5] vxlan: use neigh_ha_snapshot() in route_shortcircuit()
    https://git.kernel.org/netdev/net/c/8eca411347e1
  - [net,4/5] vxlan: use pskb_network_may_pull() in route_shortcircuit()
    https://git.kernel.org/netdev/net/c/26bb2dd0a883
  - [net,5/5] vxlan: use pskb_network_may_pull() for transmit path header pulls
    https://git.kernel.org/netdev/net/c/b9553558b48d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


