Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF383AFD15
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314444; cv=none; b=SJRRL8XWsYL+NxOPIsRvW6pS7/NVhYko4hPfxnMlhmF1t312f+ddfWlqDSSE8UI6j5JrG9ayH3F+pg3iKupcw8gfKvO8DCo944kGxVnZlCHUl4mmIVWgRj4CFabndq9Xfp+CtbC6Q6ppYk6bBe6QYyzELTrrEVH3TtFERjE3MRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314444; c=relaxed/simple;
	bh=D6LrDOlIBNAvHcdn2QH5dwc5+JfMBSXsaPIiLQca/GM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K4oJDHPMFZPd+bqZW8VxOl+fqCngwSbiuQbb8IX/Zdq3Lt+KmSVO0r2GIjbgSduLtYojVf+w41ri7Lux9Cn430OBWjaftETXGWSvxU1JxOs4J8DlvYkk1fPu8VketRXU6xdtM0wn4/OguRozPQxMCnxPuaWejGwb4IC57AF8efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjTC4kTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjTC4kTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C91F000E9;
	Wed, 29 Jul 2026 08:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314442;
	bh=dt8pjjQxDWVZoQHRH9KbpH58W3IsF8eNy7G7yFlW1as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FjTC4kTsPLbBqq9O7V+242dVBAhElmZl4XsIgbUmffhBm+GXf/k5hN5KIlyyG07a1
	 HULI+O6zDnNextt4rvBZO9tyiJ2IfRmbiOvRJixf9VTUap9TZcnzzqvzvptoWsLefT
	 UwupH0JNdL3ZQv1chiZYnmwAD2m7GVQ8NVOXHI+yZAmBEBavlbK5B7xKx8U1xwZBXS
	 Xxkusbeqzy4NH7VaAFAdWeU4mmAleRcEw+frF4BbDrYPOW3lHrxydVAlOxW34gUowl
	 K/lnaIfoUhya61LLY752qKgZxYw4Yfs3y8qhjpxDLwxGS6KOjPgSOl/oasSF2O1w6Y
	 hhG6B/BLLxHgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5EFB53924FC0;
	Wed, 29 Jul 2026 08:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: sxgbe: fix descriptor ring allocation
 failure
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178531440719.2521418.13788561990285994467.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 08:40:07 +0000
References: <20260723021820.203960-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260723021820.203960-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaochenguang@kylinos.cn

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Jul 2026 10:18:18 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> init_dma_desc_rings() leaks already-allocated TX rings
> when RX allocation fails, and sxgbe_open() ignores its
> return value and continues with invalid DMA rings. Fix
> the cleanup path and check the error.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: sxgbe: free TX rings on RX allocation failure
    https://git.kernel.org/netdev/net/c/c870f7e2890b
  - [net,v3,2/2] net: sxgbe: check descriptor ring allocation failures
    https://git.kernel.org/netdev/net/c/51b093a7ba27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


