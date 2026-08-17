Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91E3BBFA0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998058; cv=none; b=eugs64YqThWsDvYhfjAUNzHYb9AxMCHVxcuSGQ80wg7hqPxMs1yKnd01HgUmzQYJPCFGau5SSliy49f99lkdh8gpie+88OeqOVEfbo176xQU83pRCb0B4ByC4X5lPfCcB5TkM6M+qyGdLHGT7hOXNQIUAOF7Hau9H6d4e2XLBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998058; c=relaxed/simple;
	bh=1WyjMUdFL/IF0LGOFtb77NMUNBfKm77hvubtXADjHts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DgQzmvSooLcSN7Mu6mg+ZxPl3iJaNHJVaYhDTvaesxl5vmb186RXPOQaZ6DNhk2Q49wNwRtO/Y8rT9Nr4lK0YCI7Nf3qPlLcKOmVnxyCCy5wHAut1vQ4bKQALL732Rwy/W9Wkfhr5/x0zshmCPbkEA/Cc+Cski7HaPCqyuoDMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtpN9LR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtpN9LR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C931F000E9;
	Mon, 17 Aug 2026 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998056;
	bh=n7JAVPzYgAJOX0qDiJAzLhL827b2oH7pZHv1r011mug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KtpN9LR+NtNhRlvFuqczsWa340I/QK5IFUEszpGC/SXk/2Mn7Wpiuik4Fntagd3Yg
	 UUdJEkICRHTkpjKpSeZ421d4JNaMt2t2t8DpOGfrj5lXvURk7jqTDX9iTzs3/Fgvce
	 T6H+GOTCmz2mVSSDN0EkMimrGhev5YiPPOOrMdEb5Bs18krK2LkBHwIzb9JjRHinwD
	 S15+Q22M/YovI79U05y+9YMShAoy/hzhEx3HjzylHncAqUesA4iw6sgtD1aAGa9OTN
	 aPEVLWKh8kldkkUtGPO45binjO9R8uwR55SWTrSKKLbhIEj+91pLqDw7aIFZJPqRt/
	 L911VYcltrUUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197303926263;
	Mon, 17 Aug 2026 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] ip6_tunnel: use skb_cow_head() in
 ip6_tnl_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699800863.1721413.1936042750550645983.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:20:08 +0000
References: <cover.1786452593.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1786452593.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, tom@herbertland.com, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 21:31:10 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv6/ip6_tunnel.c. The bug is
> reachable by a non-root user via user and network namespaces.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
    https://git.kernel.org/netdev/net/c/87f21b59ddc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


