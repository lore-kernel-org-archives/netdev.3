Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816943624C8;
	Sat, 22 Aug 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432462; cv=none; b=m6WaBVEhx49VU/hTcWezCJFNxe7N8Xd4pTJfFYwV9pa+noTbj9/L2sIQHBJAx8mFfxNsVDv7HfX7C1lYLx9RJBgwnmEIQyFhOjTTWMaF/7KQZdHy/oVvMpQJbM0T6yyDeKNf/TMvG3293+mprcVAKFBFr2Q9itxomhOUoacHzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432462; c=relaxed/simple;
	bh=jya/UxGSU6N9V0uRs/vggE4iMo0P+Jl4nOb80Oef4ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uEDMLBP3GBnETPT6egzKE4ZHsDK5bGZ60E3UbSQCDe2SQ/8iJu+B81b7izGGZJvYFag5JQCL9k+fxG0SK7j+uImqtrA69xvc0eT5avINYXx+t+Hx7QynPYvtZ2zj/53Rl5Tkw3q/nAhbwCbnZK0UFyxu7bINfetXbmG8JzBux3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd4pimVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd4pimVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9501F00A3A;
	Sat, 22 Aug 2026 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787432461;
	bh=oOpNkOm+Xlohq34j/Z2D4xaT+zHIxpVyHczvt4SUeRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qd4pimVDAvssCtPFNK0EsPzNk0LitorQt9iL9EkV+VkDUSGYVYpIXslnDTZTKQ+yh
	 s4iQalES70L8eA2ZHJLK6SM1o9YYoQVErwM7q6mEVjSM1rQ8PQ9Z8epVN73bpf0MJu
	 5UCPMlKpiuBlAgTrXzojxi4+F8wiacJLEAtFRQh2IhbDvD9nz4kG6WP/T9v8TdbUj+
	 pZGwmDBGhzFuObzdikpvrE7sxioIUqju9FPnP0GrL61kUzQgOiBIX8/48cbD7cqO4W
	 rwron4zs0huUq955V2iu6Pt8CfRJrQyu2C38Rdr9wyJk2xe1yMdpS3e6frxM8cetlO
	 dX4nlyNzURxdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1992D380CEF9;
	Sat, 22 Aug 2026 21:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hibmcge: fix page_pool DMA direction mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743240988.1826211.7757239597300892281.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 21:00:09 +0000
References: <20260820124346.4097115-1-shaojijie@huawei.com>
In-Reply-To: <20260820124346.4097115-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 20:43:46 +0800 you wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> The driver memsets the RX buffer page head to zero before
> submitting it to hardware, then calls dma_sync_single_for_device()
> with DMA_TO_DEVICE.  This sync direction does not match the pool
> dma_dir which is DMA_FROM_DEVICE, violating the DMA API contract
> that the sync direction must match the mapping direction.
> 
> [...]

Here is the summary with links:
  - [net] net: hibmcge: fix page_pool DMA direction mismatch
    https://git.kernel.org/netdev/net/c/11efd7963dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


