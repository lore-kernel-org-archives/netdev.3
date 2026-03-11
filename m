Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98132BEC2C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195611; cv=none; b=ezSGdt+17xx/CvAvw4cQ96YAVtG2CzCQjCddzybAeX+AfKS1tlwi/NYQAgU808SMKOFSyFrCeNxoipHvaeEBfh3ggZ70hh9cpKDregiX+OkpkrbIHlnYYEIIAYmKbbqJ8k4Rl8E6FFdjfQXSmPaIi9uD2LoxoCz1UIBNHPAbudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195611; c=relaxed/simple;
	bh=BAIOdkBJjfC0yTwi4+zVaHKpP+QpR/s/fABq0mGYghE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYqyhA6oVksiOO1o5Cr9Qark690OfP3eBen2xzATbmh0u5cuPZHV0qtPJbdYVkICcrVzT6JYC40sqzDwhKUgTA6XsDyN69Chysg8nJsB0iPwkknmQj4i5F86QPFIffvnpbHx8anEIUuqqg98y3D8m1M+NvwP65wSyKB/l1T53N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaullzh5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaullzh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CF3C2BCB5;
	Wed, 11 Mar 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773195611;
	bh=BAIOdkBJjfC0yTwi4+zVaHKpP+QpR/s/fABq0mGYghE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uaullzh5smmzgtvBje5/HUYx2KnPMyDGLQwOTNNw/8FBb4CdAZXIS/6/inyn44KoF
	 qODF2tGDTUuj5aDSO7aYbv91qZS2Mok5qLwIaEK+IHVUcq+8cIHYerQF0H+Zb4h82j
	 L14/XIhh+KdRtgX9n4LTesE6cogQ12Mfc7kTDP1gMZBf2UYu4YdoZq0YvsqFwV1d6N
	 8+78qMLQXZ13vW5ieD6olfI/Fkyi3koOyhsW5E39ck7KYJRCXgk4ZCvdv4WNgH4wZN
	 /1s15HXrpw7I5LMete1dVU6R1evZ/pVMoOekjof65aZ+Xx6zuUJ+vi2UiDS0XFLOW+
	 dY72Aori0IyRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC4C3808200;
	Wed, 11 Mar 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] page_pool: store detach_time as ktime_t to avoid
 false-negatives
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319560779.3008927.7755887513230863063.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:20:07 +0000
References: <20260310003907.3540019-1-kuba@kernel.org>
In-Reply-To: <20260310003907.3540019-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 17:39:07 -0700 you wrote:
> While testing other changes in vng I noticed that
> nl_netdev.page_pool_check flakes. This never happens in real CI.
> 
> Turns out vng may boot and get to that test in less than a second.
> page_pool_detached() records the detach time in seconds, so if
> vng is fast enough detach time is set to 0. Other code treats
> 0 as "not detached". detach_time is only used to report the state
> to the user, so it's not a huge deal in practice but let's fix it.
> Store the raw ktime_t (nanoseconds) instead. A nanosecond value
> of 0 is practically impossible.
> 
> [...]

Here is the summary with links:
  - [net,v2] page_pool: store detach_time as ktime_t to avoid false-negatives
    https://git.kernel.org/netdev/net/c/28b225282d44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


