Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4137EFE2
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214076; cv=none; b=fU8Fnd7BEsTuk1XYOVU8OvG2C3Wt2vXDiBvPG4ypXieBS4ovXKOnxVdd7coDRFGwLOLdtThS44hJtnpkSRMknK3n1pIWH6kt4My/EePuGDzIzV4T9uRbytFgi78BFi5Hpg8rmUPNuzOg3vvQ66nTrdorgeaJnACrwkEdsLR6XoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214076; c=relaxed/simple;
	bh=ggDi1XWMR5fQpE4G9qNNhP9tY02/59evVxaMORX7Ztw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RuB86N2Ry2jQmP0Ec6OtOLOBwmNv6ZA23xrzHypqP3Ml9cQxevEjP3Mi97D45z+nbOIi6w7G5ekeJ1uRNbo5v5grhAY2hb/CutdNWg8KDJA7OGAHdOaofa59Yx7dPG6bzQRbKmLJWhWBxwOyfFYeDnt05HnGim2HUjcQKx25sKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k391Oz/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k391Oz/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E841F000FF;
	Thu, 24 Sep 2026 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214075;
	bh=niKPoH1KW6Rlvh1eb38EE1OtlmgV23y532xTbnulMRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k391Oz/iqamk+n4ybfUeFyjYESzs27vCCh/gzqxa+Tlr3l6lfy4muomPs8vY+1S8w
	 ipS7aKrllNmKS8etaJF32YRv3KwGqbN9q3sh/au2JSWOL/+ne8V5D66l2SlnwZa25v
	 WbjkgHdseSJdVJtVfpNDSNS0A96IGkMFzE+HPyFWLDMseVtMIgmx6a0a6L3NN3i6Lz
	 1KJzScDXZDLe2XEF3cTKjbO3VkIYKf1s8TRxuN85ENDSYuZsoHXV+bGsTjTeiHLv63
	 Wg46pc59HsMHA+omePa4ZtVK4SVjG01LNa/7zoWfBxamJQfOx+ouNrRC+XAnKdN7Nw
	 FYSPzZ0nR+m4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1739E9611;
	Thu, 24 Sep 2026 01:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vrf: Stop corrupting skb->csum when capturing
 CHECKSUM_COMPLETE packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021400465.1269562.11476396450623363857.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 01:40:04 +0000
References: <20260922131239.2509494-1-idosch@nvidia.com>
In-Reply-To: <20260922131239.2509494-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 andrew+netdev@lunn.ch, andrea.mayer@uniroma2.it, stesasso@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 16:12:39 +0300 you wrote:
> The VRF device is an Ethernet device but it can have non-Ethernet ports
> such as IP tunnels. Before the cited commit, capturing packets from such
> ports on the VRF device resulted in these packets being detected as
> malformed since they lack an Ethernet header.
> 
> The cited commit fixed it by pushing a dummy Ethernet header to such
> packets before the capture and pulling it afterwards. In the case of
> CHECKSUM_COMPLETE packets it also updated skb->csum with the checksum of
> the dummy Ethernet header. This is wrong as skb->csum should not include
> the checksum of the Ethernet header ("checksum of the _whole_ packet as
> seen by netif_rx()").
> 
> [...]

Here is the summary with links:
  - [net] vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets
    https://git.kernel.org/netdev/net/c/ab7aa05c06ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


