Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEE3F105D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859685; cv=none; b=H+LLTMO0YmxYImktP3B5K/dUWh7SgT3GlVgicOnsTQARnX6VlFA2EKq28h9yKiu4Ol1BDQ246X8dFvRIakdNe0U9enM8d4ZQTTtombCvDCjM5O6T41eBK9dUlnboQ7XP4uFwEXBwNC0pfhf9sr1P2krIsJJ9wMyGxfiFRoPNWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859685; c=relaxed/simple;
	bh=jx2deZq15GooeW0oyrtgE43vkmkpJ42Dszi0sR+Zf/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O6bnZ+18Q6bdYNNNvQ90eOPo8LrZf0YseC25KKepHvilN4BVTyggs6+/WjMK55MrWd0vVb/FWlQGrsCbxJ4iqZgj3vl+dDG+KTFRfi1gf0ShSkx6UxYfWQsz8EOB51vdo2fVmxe2xVTHXcw8phREZAX5kQ3qeMCQnS62qLwpinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZIVIuC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZIVIuC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1C01F000E9;
	Thu, 27 Aug 2026 19:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859684;
	bh=KqEsQoEB+8fU7vJblTwby6vgzSs2bvv1OQhLWyP+QNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KZIVIuC/FrGsNhPIIJrdIqKy2c5htetienMypa7/1X+jMMAypklzKO8yFHgIexMBY
	 VqTptL3T40xYDqevShKmm7jC7yDiFRdCGuiFsDjzUCQ1rIR2THe1SAFzZ0GJzUdkgK
	 csA/0yGvWc9a0Sy01GoUjp64FjcDSA6ab7FceY3k+kQB5twAbmiYw8k2WVLMmENCXg
	 8Iv3sQfSDr5dbFrUrpqE1ybABICYMm2ZAQpzjumubRObKcXGrIuO405ptnhajHLlSz
	 O1kn2+lZaiAGIum2x2x9ACTDXWb7/ADVnFitDU6OKBuVmbZoPAMWZ/akhaJRtDBxxB
	 FiBdEb26jQmTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C763809A8D;
	Thu, 27 Aug 2026 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: drop gso_enabled_types and rely on
 netdev features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962939.1816627.13162485413764982392.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:29 +0000
References: 
 <20260824-stmmac-fix-tso6-features-v3-1-c73a7a4a0ec7@oss.qualcomm.com>
In-Reply-To: 
 <20260824-stmmac-fix-tso6-features-v3-1-c73a7a4a0ec7@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 11:59:08 +0200 you wrote:
> The gso_enabled_types field is used by stmmac_xmit() to decide whether a
> GSO skb should be passed to stmmac_tso_xmit(). It is updated in
> stmmac_set_features() based solely on NETIF_F_TSO, so disabling IPv4
> TSO while keeping IPv6 TSO (NETIF_F_TSO6) enabled zeroes the mask. As a
> result IPv6 GSO frames, which the networking stack still generates since
> NETIF_F_TSO6 is enabled, fall through to the non-TSO xmit path where
> they are not handled.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: drop gso_enabled_types and rely on netdev features
    https://git.kernel.org/netdev/net/c/9c24a504a3af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


