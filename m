Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494D2F7EE9;
	Tue, 29 Sep 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691012; cv=none; b=XHAhVso+YVokUIz/jlplQ3U5Uf1qjjnoUDLgTCAJII7futHTlMTEfDrit8YVM9xHdEoLWEneOYDBb772/EpGjlFiWV1qkBsxft/RMewmuZ/xxdxSKRnH3gji0PneaRwLMr6fhSx/p45ZVFdyXLMbZjbAY6nNw0BcnsZeXbQSg5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691012; c=relaxed/simple;
	bh=zn64/z74HrsgRqX1Znz6DNhUF1h6W0QfsND4r24wyMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7K2InoqWXRWcO8apWZyCGBAxlpWJ8zdoxxmJJ5lUKcI1EpsnB/V92GmV+NKm5C0mlHTfchIHzHs98YlMjJd9bZNkGIio3P0iKjSCJlgU7PC2BowjFgSLQK/63gne9m2JYx1N8hGX+fbFwnwD/GhzXg3L2HfzmRTwgqQp7XNGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdfsvbCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdfsvbCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C51F000FF;
	Tue, 29 Sep 2026 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691011;
	bh=/r0KUDGrdjq78OEu0y9s4SfKp1pHV7dql8E1623aP5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DdfsvbCsNlgh2OemIVy3BVtmKz+yJSFwJUQeuAwtWCiJWGnldqveKFZlBsUs0Cm/I
	 GmmEgPK8vR2YgnnTM79Ezd6Alz3B2LohO1nvY2Pv29d3UuZEI4YZJN+p+PWqS533s3
	 AqYB7zR4LqRN27ZIROWEX+pVk73akX6i+EdrHKpF3qfWsNlY2ZDK3HPKacyEQ+j6m8
	 an68obO/rikZP81bUJoNRtOV6u00i1GH4+yAPFqRpl8EmMmjMOCIfBSXEudC7SZIhI
	 5yYuXTXAVuTrr1IZBq/zT0RbD9t7ySePmLdhQlNVCksG+kFgSHIwIex4LI8XSK8hno
	 1JteJhzgueqIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3BA392666B;
	Tue, 29 Sep 2026 14:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: consolidate devmem net_iov freelist
 and
 DMA handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179069101003.514198.11141004024864379168.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 14:10:10 +0000
References: <20260925201522.254717-1-sdf@fomichev.me>
In-Reply-To: <20260925201522.254717-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, sdf@fomichev.me, bobbyeshleman@meta.com,
 almasrymina@google.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 13:15:19 -0700 you wrote:
> Follow up on the recently merged devmem gen_pool removal by consolidating
> devmem's net_iov freelist and DMA-address handling.
> 
> - move devmem freelist to index-based approach with push/pop helpers
> - switch devmem to public memory-provider helpers and reject DMA
>   addresses that cannot be represented
> - decode stored DMA addresses for TX on 32-bit systems with 64-bit
>   dma_addr_t
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: netmem: move to index based freelist
    https://git.kernel.org/netdev/net-next/c/1cf2f913b3dd
  - [net-next,v2,2/3] net: devmem: use memory provider helpers for net_iovs
    https://git.kernel.org/netdev/net-next/c/5bdeb89ec5b0
  - [net-next,v2,3/3] net: devmem: decode DMA addresses for TX
    https://git.kernel.org/netdev/net-next/c/5c729e6c71f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


