Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912E3FC5C6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564205; cv=none; b=h24Zo4BlQ+tECVGzlK7EU+sT+8q6QYrcJhX7/AWgjKxO+/whu5BCSMM04hjWcN65xB/u2LE9UV7r5E8xdzcMo6Au7knParZIUBgvWzh6JqhO5HvjapEzroCE3rC4Mf0mDBOtNDtwYW1wwsHEsg54g+eUOdIRkAstFT1D8pW2LQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564205; c=relaxed/simple;
	bh=FHoSQk8zmbtddTEAtg+ZvIIe8HPX0LIk7NoaCp0wCXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cROFjNsleta1tfpSe7leuHqUO+eGN1FMQQNK999QfXBqSPYzoRsUN0+PnKa5x6KrO1wOCJFB8bw+L0xuv0OzfTKMnLxDE5vv5LuPkOgkPWLrksQISV6TlzfgsjsGugUDgLWTZldcgigBEo6Mz5ZW2vfV5md+AMDOIVhUK3JBPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/MQLytX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/MQLytX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F088C1F00893;
	Thu,  4 Jun 2026 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564204;
	bh=PJN9q6DDwVvOAubcOHRhVjqaj8uAzQdXY5zMvRSLOrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c/MQLytXeDxoSRx0+KnRFLvBJoqSynIzQiq6NFwWEWwX4wTM6BNZObgbYigQM+bx0
	 W0V66HbQMEboeZKSfV3JddgQuMEq4cblsZt+lfX2LtkyyU5IUDNHBnbDtwerzn1lfj
	 6L7O4mTMtf/oaL1F8gVHFHsQm8Yt0N5TWILZVw3eOHYCBPQ1mwjkWO4tjH1R7hTiRm
	 NTEnj3tXJ36AV/ARe9a4XEdPrW9JRoOeh7cAYZxEKKPXuPYAF9ZKKkfoGKrmHQelnQ
	 k1idavH/PA1AnnlJgwkH9p72QrpcgI9aQlD4OybGBrAaDGivYY7MlqiJcjAUBvXe8x
	 t2z4kP6Rl0wcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 399B739308FF;
	Thu,  4 Jun 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] geneve: fix length used in GRO hint UDP checksum
 adjustment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178056420515.2330682.9637224436257491756.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 09:10:05 +0000
References: <20260529144713.780938-1-atenart@kernel.org>
In-Reply-To: <20260529144713.780938-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 May 2026 16:47:00 +0200 you wrote:
> In geneve_post_decap_hint the length used for adjusting the UDP checksum
> should be 'skb->len - gro_hint->nested_tp_offset' (UDP length) instead
> of 'skb->len - gro_hint->nested_nh_offset' (IP length).
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260521131436.748832-1-jhs%40mojatatu.com
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] geneve: fix length used in GRO hint UDP checksum adjustment
    https://git.kernel.org/netdev/net/c/1231623fd3b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


