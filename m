Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF003101DC
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540198; cv=none; b=O5iSqIH8gfymdiEJFJnmg6IpT/ApiqfcNGrNxuiz6ZsTBE3UHCL6ksCsaMmVTGWDVPKvJnqmhxbVoR6fnbvhhM27EQ8FsPJ5uM3rNT8P/nJHm2h4Kt4KCS1yt8r4J7Iiy4kLKK2yyU6i2Yrr40DRBWf6DqJ0+o7C37f0RmN6w0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540198; c=relaxed/simple;
	bh=2jyB4rdETxe9FnOKJOwn/E24RZo2ECmz7L7QOcw+rIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1Sihcqp0hxv3S6yjuotDsfqG4zqBZkZqhmea3CiBiTVeQ6MxJxdtbkJMP5UNOT+Kunq8vdRepTWgpTKofD9Is/9udzJjmmk2Iiaz2jaR+fs8RFE5ZK1PC0mfHGqLqxNP2VjkkSWgIy0KgCEBB+yBzSMPOn8OzmUicrd+nbd6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/2A2dWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/2A2dWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7771C4CEF7;
	Thu, 19 Feb 2026 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771540197;
	bh=2jyB4rdETxe9FnOKJOwn/E24RZo2ECmz7L7QOcw+rIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s/2A2dWChnbubDqzJMLxS6LBl9f0hA09umeX1Ye+wT3hgYAdNXkXPYSCc8BWNk5aW
	 n+GeeRmr8a5TM4OsgoQg/hTEnfsKtsq0LZuEm3Co7Nij9a+3URRDlzC++jIpkQU++z
	 ZFo5m6E4pUaZw4wScmwmP5dijB0ocjg/axrfT/BYQeM36s1m4oug4/xO9hiMYb42Ci
	 30Mr6WNVjNGJ3dagXBNihmmFIhnwUR1hpiqvbhUw4NcHtQQ43cgjedUNEO1jsN9skc
	 Z/j2rdAwQ7lZdCviI7H0HC3EywrHhdisGVRPuoOfibJHyQoC2NgyVdhOQsHuYm1Ja0
	 El5U1YeBSltpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D00C3809A87;
	Thu, 19 Feb 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] psp: use sk->sk_hash in psp_write_headers()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154020630.115050.11761958680584535124.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 22:30:06 +0000
References: <20260218141337.999945-1-edumazet@google.com>
In-Reply-To: <20260218141337.999945-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, raeds@nvidia.com,
 rrameshbabu@nvidia.com, cratiu@nvidia.com, daniel.zahka@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 14:13:37 +0000 you wrote:
> udp_flow_src_port() is indirectly using sk->sk_txhash as a base,
> because __tcp_transmit_skb() uses skb_set_hash_from_sk().
> 
> This is problematic because this field can change over the
> lifetime of a TCP flow, thanks to calls to sk_rethink_txhash().
> 
> Problem is that some NIC might (ab)use the PSP UDP source port in their
> RSS computation, and PSP packets for a given flow could jump
> from one queue to another.
> 
> [...]

Here is the summary with links:
  - [net] psp: use sk->sk_hash in psp_write_headers()
    https://git.kernel.org/netdev/net/c/f891007ab1c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


