Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC92214204
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454840; cv=none; b=BFSqcTx8bdInbGoJMK2QZBCc9ARn80HFwRWoFNRnJDzmMwk7qqVXRwCPbXsj6DoJ7RyU455q7MszT/ML6YksDAx8bRkzK/9ahUIISonYBjs/6Dc0+4Q0IjajvG4Yq53MZcT8yyoSBpjZlrVNX2abxE06EkX3cz7s1anQYtSXRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454840; c=relaxed/simple;
	bh=hjZEdogFBB+SJ7HN5y/foq8boBULCqCeFPfFTrbq/1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BPMxX39HB9YMNERmZVsPx3/AvNAvgZHOAI95invi5P994DYwpiYbnN1n25kQqbRSxyMz+lRuuhTiCaBcqGPEg2g1xv03fpnsvQIXHgxR/2xnYNQcwqEJOf3osiqjeW9YsKBZiq92hqtDUmSlKriunaaL2hSk40mrQAu813F0D7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esBChfJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esBChfJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3628C19421;
	Sat, 14 Mar 2026 02:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773454840;
	bh=hjZEdogFBB+SJ7HN5y/foq8boBULCqCeFPfFTrbq/1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=esBChfJ7l/taHcN4rcpKcvzZIrfw2sXG8d3jXmxrgf38aUAuvhl1sufP1xUZmMnSV
	 DdYOJavr14SDlbv21xDW5H9RezY8arFulCkhf5lmm7Ko/LUnIBX97fDcz5uB2R7MGa
	 8XoGV56l90rSQbiEX+NwOOC0TnpoPYolF2tZatKJabaX55meLSIeBgiNkNUkfXVXh7
	 DUE646Zn8gXZ9mLMUyKrTcYjChBifkhOXBilxcNJlIEbIxGFrS46wnmUUTzoVY0KTr
	 tVShf5C6PFhrjPcLhQS0qU+5XNQSQyk5ycSs6FMTL/E9YucX2r1T95yTvNT+r65oQG
	 oae9FGcQVKawA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1DC3808200;
	Sat, 14 Mar 2026 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] udp: Retire UDP-Lite.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177345483454.1571585.698024036382080927.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 02:20:34 +0000
References: <20260311052020.1213705-1-kuniyu@google.com>
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: willemdebruijn.kernel@gmail.com, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 05:19:47 +0000 you wrote:
> In 2023, syzbot found a null-ptr-deref bug triggered when UDP-Lite
> attempted to charge an skb after the total memory usage for UDP-Lite
> _and_ UDP exceeded a system-wide threshold, net.ipv4.udp_mem[1].
> 
> Since this threshold is shared with UDP, the bug would have been
> easy to trigger if any real-world applications were using UDP-Lite;
> however, only syzbot ever stumbled upon it.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] udp: Make udp[46]_seq_show() static.
    https://git.kernel.org/netdev/net-next/c/86a41d957ba0
  - [v3,net-next,02/15] ipv6: Retire UDP-Lite.
    https://git.kernel.org/netdev/net-next/c/62554a51c584
  - [v3,net-next,03/15] ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
    https://git.kernel.org/netdev/net-next/c/92586f02f8a5
  - [v3,net-next,04/15] ipv4: Retire UDP-Lite.
    https://git.kernel.org/netdev/net-next/c/56520b398e5e
  - [v3,net-next,05/15] udp: Remove UDP-Lite SNMP stats.
    https://git.kernel.org/netdev/net-next/c/7accba6fd1ab
  - [v3,net-next,06/15] smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
    https://git.kernel.org/netdev/net-next/c/b972cb5d397e
  - [v3,net-next,07/15] udp: Remove partial csum code in RX.
    https://git.kernel.org/netdev/net-next/c/c2539d4f2df7
  - [v3,net-next,08/15] udp: Remove partial csum code in TX.
    https://git.kernel.org/netdev/net-next/c/b2a1d719be4f
  - [v3,net-next,09/15] udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
    https://git.kernel.org/netdev/net-next/c/74f0cca1100b
  - [v3,net-next,10/15] udp: Remove struct proto.h.udp_table.
    https://git.kernel.org/netdev/net-next/c/5c2738588621
  - [v3,net-next,11/15] udp: Remove udp_table in struct udp_seq_afinfo.
    https://git.kernel.org/netdev/net-next/c/c570bd25d88a
  - [v3,net-next,12/15] udp: Remove dead check in __udp[46]_lib_lookup() for BPF.
    https://git.kernel.org/netdev/net-next/c/5a88b2810f26
  - [v3,net-next,13/15] udp: Don't pass udptable to IPv6 socket lookup functions.
    https://git.kernel.org/netdev/net-next/c/deffb85478a4
  - [v3,net-next,14/15] udp: Don't pass udptable to IPv4 socket lookup functions.
    https://git.kernel.org/netdev/net-next/c/68aeb21ef0e1
  - [v3,net-next,15/15] udp: Don't pass proto to __udp4_lib_rcv() and __udp6_lib_rcv().
    https://git.kernel.org/netdev/net-next/c/14ce9a47c5b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


