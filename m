Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBA3557F3
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860872; cv=none; b=BM5Rb6x3g4LnCOM0PC3Zufq1Hehk2E96M1jJRBrzs9MLur7X1j7H8va3mAponjsScpqyYMYOWbg7Rdk9cCZR6bENK8qC+wP1ppJyYU6PFTfWRJMOWsDLA+3+iFdmtphFnhsatGsltUXjrmEirAasDs8d+HqC7apw05y0f61xUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860872; c=relaxed/simple;
	bh=98wv2XGUPOtX1pi/WAJKXnjPHeZSxMvCukotK15zMgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqFUgRA2YQIl8qdktN15dZaPioH08HGnzWYBRW6tUEm5LyVdZSYHYa88J/BoBNg3kziYdpP1AMbhUPsSiJC4sdwqzM9FYRVXPewSZ91slQe1q2bcnVoIeT6AZ6IjL+MCPfAhfuQ1qVBkAtMuQVBDEHJjKT6eRtw3gt3H/eiHLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZBa6fMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZBa6fMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D45B1F00A3A;
	Thu, 27 Aug 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860870;
	bh=/7hELmL5t7LrB78MZIE5pMFqP/goVOwVqUQAbzpW/oQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eZBa6fMCw22/EDysshPkcYiQo01H1RA5VYgzx3CA/K+iOp6KkObDFc6zHD/I1dgKY
	 kn3h1TOOaY/z7vhGcIkeBszdzgCa4R2XrHJ8V4GB66aqhjaLpdG1HB3tkyYoeWPkEB
	 D6YVw1tlAFfVNUnsQCncMbWR+xniCewVEBU1zM/ENVytPX2vBveRRIwsnif1aPWkxN
	 OByAfzX3GYJr2Hm9YEXSwi0u5EmVmOWofdII7q2F0JWjVoZ3DpEP+N5qD0FXfVg7+Y
	 itFDaET3Hni4YhMYUHtKLhrHmMk9JNhv/PzqKjc/sS8NYCxvQ+ghw7PrJ0wXnqRj5H
	 CLPDmBBqPOr0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EE3809A8D;
	Thu, 27 Aug 2026 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: frags: strip GSO state from fragments before
 reassembly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178786081564.1822702.16249918450041768118.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 20:00:15 +0000
References: 
 <937926e509f2acd8e0e66520dc2b30fd6b4d1687.1787839506.git.pabeni@redhat.com>
In-Reply-To: 
 <937926e509f2acd8e0e66520dc2b30fd6b4d1687.1787839506.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 maxk@qualcomm.com, rusty@rustcorp.com.au

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 16:07:07 +0200 you wrote:
> From: Xinyang Ge <xinyang@anthropic.com>
> 
> A virtio_net_hdr (tun/tap, or AF_PACKET with PACKET_VNET_HDR) can mark
> an IPv4 or IPv6 fragment as GSO; nothing relates gso_type to frag_off.
> inet_frag_reasm_prepare()/inet_frag_reasm_finish() keep the first
> fragment's skb as the head of the reassembled datagram, including its
> shinfo->gso_size/gso_type/gso_segs, and chain the remaining fragments
> on frag_list with whatever linear/paged layout they arrived with.
> 
> [...]

Here is the summary with links:
  - [net] inet: frags: strip GSO state from fragments before reassembly
    https://git.kernel.org/netdev/net/c/d5dc1e69fd72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


