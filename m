Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6041D12B;
	Tue, 22 Sep 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068277; cv=none; b=kCRenUCODv3Zo27BNrqKowf5AH4+fB7O8IcNCxpJEcOjPDWUxFFfLjVc9N5ktvHMSSK0VmCuexEGGn3akbsQ4HLkmc0LVkouWWfIBDi5qr2rdQa7gP2HVkLX0HQIhMrUbyI/W3zH7ya93dEekYEo0j4UqTmdao7rxpnwl0hGxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068277; c=relaxed/simple;
	bh=NdAM3lhu4Syrf6HWwOE3CJcFRtcpFL40ccfp5swmHc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cis+ACEMmtHhM6RVPFgPFaugbMHE2SArWRZU2/jLor4u5iZDQPqCzCmVYsXXjnhG+OB5rngdNm7B2ze+InHUG4tiN+noiroXM9sea0uRabfsib2m6BbOBzFKQHjsTtJs0ltRPtRzC3NevQQYk1TG37FNX6k036URG5pTiQfWbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YudHlnb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YudHlnb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F4F1F000FF;
	Tue, 22 Sep 2026 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790068275;
	bh=QDT/80Q3OpMMraM2DIDoctNa0y0Fe8/45rumRNYvbyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YudHlnb6sy6sRY0Wgd5q/6WD8FsrUY8a9XPXzNGzN2XjINtBZVL4kcPdsdDhRVRrh
	 cu/S1lkDMqyJgseItGT/ZDQWtGOKwDYvU8p4QDI+dHukLb9ohkpxnV5RxcDjdWBhp7
	 OY5xryawVJSQdVAAlOBoMZ1saZflg8+OMzkcSUQNegU+yp9lAhEZRqA0OWG+6nuYGI
	 /8umP9QO9T94j5XeXYsP3cLfUAJvy9ZFmgtQilvRzUglzkwvjhInf87uR8ILk4JNXG
	 TdIzz77CKXSz7yrLSiKNcOCblcCSW1KDpIiHFBatdZ1VhTfL2IBTCrWoGUEROh27Ut
	 RujSyhIHkGycQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A043811954;
	Tue, 22 Sep 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] udp: two fixes for the 4-tuple hash table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179006820639.3502956.2214093517596675579.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 09:10:06 +0000
References: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com>
In-Reply-To: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 lulie@linux.alibaba.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com, kuniyu@google.com, willemb@google.com,
 cambda@linux.alibaba.com, janak@mpiric.us, kalpan.jani@mpiricsoftware.com,
 shardulsb08@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Sep 2026 14:55:31 +0530 you wrote:
> Two ways a UDP socket ends up in the wrong place in the 4-tuple hash table.
> The patches are independent, with different Fixes: tags and no dependency
> between them.
> 
> Patch 1: a socket that connects a second time is not relocated, so it stays
> filed under its first peer's hash and packets for it fall back to scoring
> the hash2 chain for its address and port.
> 
> [...]

Here is the summary with links:
  - [net,1/2] udp: relocate a connected socket in the 4-tuple hash table on re-connect
    https://git.kernel.org/netdev/net/c/5fd0783b99d4
  - [net,2/2] udp: remove a disconnected socket from the 4-tuple hash table
    https://git.kernel.org/netdev/net/c/9e95b1a94c9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


