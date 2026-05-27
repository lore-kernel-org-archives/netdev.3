Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A4305698
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845414; cv=none; b=b+Aj9HOpzQukLLvksDY6gYIsP4oprayRd7JQQemNodD0WCSFTodYyfnXC80PI91mFOE86QKnzLxvv7t6Xbswim/Wj/gmSH3GbSbS7S1NaxWp2OlCdSUjmFPvqYVNMuASp6ajjfFvVe2+9CnKbujYhY+LNqyUd13JmhS2k8+7/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845414; c=relaxed/simple;
	bh=N5eNtkNTQzRb7p+jtKIBtvOTEH3TqBpZIJybblIP2EY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJWP3eRnHdLvlPQtO7jyYDS8zAMIRmsMMhoZajBpjUTML3QfWkN4VLM2Ck2U9R+rk1OFWH3XaFY2YJe4QLV3GK0lmcWobaMnYcLR5pVCLAt/nyJy/WmjOalqgTgMwca9wA1dlrL9lahUt/8yjIQXQU0lVUkTwl4EOQz15FVz/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGFlEFmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGFlEFmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673381F000E9;
	Wed, 27 May 2026 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845412;
	bh=DMN+vY0rWS4BwsDUt8R7zj5eFv1UmhMfbCWzdhk8PQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UGFlEFmL6MbLy2IHJ40xAx0EGzezEfZes6h2RVIPJOzoRRs5/lvRGcq+7S8wgIKQs
	 2wGTQmEuE/nLBIoV9H/jo1SlHatGoeieQudr/e3kXpTd1ED9ci+R1sXPhrWB4dmnrY
	 CZAptBsJPwPOC30rcMeLGz06lWOiSIydnngpSCAdrROGuFqyiP2pGZwof49TogUYBs
	 2VeYnBa5YnIbddgEOaTqI5xd/4yujKAY1N7OZwVixc1LpIKzu1Rik/RiKs7e5s9qz/
	 aHnwiAUdQ2IyxNK7m9a6q+B/3HxS53gzUNWUvFHAZQqQ+LZABu1C1BvJ9zptFgAkZo
	 dG5C4xYTtw3Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A0380CEED;
	Wed, 27 May 2026 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: load network headers after skb_cow() in
 iptunnel_pmtud_build_icmp[v6]()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541789.4041297.15578320493887338050.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:17 +0000
References: <20260525201335.2361845-1-edumazet@google.com>
In-Reply-To: <20260525201335.2361845-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 20:13:35 +0000 you wrote:
> Sashiko found that iptunnel_pmtud_build_icmp() and
> iptunnel_pmtud_build_icmpv6() were caching ip_hdr() and ipv6_hdr()
> before an skb_cow() call which can reallocate skb->head.
> 
> Fix this possible UAF by initializing the local variables
> after the skb_cow() call.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
    https://git.kernel.org/netdev/net/c/b4bc94353050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


