Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37C3E8C56
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807652; cv=none; b=O43NXlNWEAygBprMcBUhdiVT0BC2EsKKlJjyHbvoCzmGmAu4JD47IJW6N/AFHDAsKJlISE2pM/G2rFd0dg5hE3JhAEOj67v/b/Ufz9G2wFF0EULxoy25rUQwyQwEKeRveo+tRBmbys5w8gTMaXfKB1arpYzBDaKonBzeWPvMkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807652; c=relaxed/simple;
	bh=dZiQn2FVZxJyk5/gY0qfIWAsMjyK9aHzhcpg2NRMgTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IuBwIIZqTsEgoG/zl8VfDm9V951cRJbwdsXFOhalstUEZaMh80HlxmMWU4HVjA4CwexXZVi+kMKqWfKc3QWJQcAl/xvSyD6Va0tdHp+8Yab6FusaJe5aRYOXYtBPG0U+A7SwS7HHNWZpF8E0qC2WwavacelQwkX2rIf87zHd6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG8wAIcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG8wAIcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809BB1F00A3D;
	Tue,  4 Aug 2026 01:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807651;
	bh=6rsD6L8u4tEudDekgd55RFGi5mWf88Z5Os4kDhVxTXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CG8wAIcvY9XwSvQO/GoykaWGzhrGu4TJX9FrHK9b00/VcPRmw7a6S6J6UJwmS5o/i
	 Wl4SJy+kkxrO9jIfCT8Zaoe3Hz+IbXoas8RSJ9ZHwz/OwA8rFQuLVPhr0ZQJu7d4Pq
	 /Y3achZ4sXikjGV3oM9irQC4S3/jgGq4Pwszmuy4/IlisbuIqEFVma9ekJGZX2XWPg
	 FU648ZNpiEucmU7KBi7Q8Lrd9BSLhyhV3DPlG62Guk5z7S+DhuIEf/BVcbIlQg2/4t
	 s5e977e+ioJXbekBCprsEEd6hfoGVGbC6EM9F4352CUKzGq9rsQepNnNHmmwA6lRkR
	 qMt2cmLFGmafw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A93924467;
	Tue,  4 Aug 2026 01:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA
 nexthops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580761213.2910544.15294990224593863445.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:40:12 +0000
References: <cover.1785411219.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1785411219.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 12:59:25 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv4/fib_semantics.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
    https://git.kernel.org/netdev/net/c/4ff9548d8494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


