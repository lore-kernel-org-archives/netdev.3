Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9456B81
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084022; cv=none; b=n7TUUmfmsIoRqOB7v2d3UGziyzd8Vm4Drjin3IqlAR6+KMRcIj+Gp0B9xD4ceJAaKUYVyhYT0UPn+4FpgkjtCrp+QaV5LFADjeyMpoKqkjzEW+aHa39Oi428ckhFeMC9yJ/ufciHSFXbamL2u3VX9v0Juhd8/3j0/Ki/dkT7Kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084022; c=relaxed/simple;
	bh=PXM9SNYVqqJKlhLk3NcOTmocSzY6oe5CX8CVAXQSNFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZLsk/Z43m5u76p/hJuM63p1JXxnXx0ZMn3oxH0big6/P7LHj7QPDY44OIg8KV8gUcvA2i93dXmdLwG4Bd0tcLy7lLamFABzXRq9CH1X+o04VE+/kVxkp+V1Dkh7V7FhG5e8ekFLE5mL2lycJSzW/q7bZ12YugD3iPG0OWOXH9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4/vTBLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4/vTBLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B88C19425;
	Tue,  3 Feb 2026 02:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084022;
	bh=PXM9SNYVqqJKlhLk3NcOTmocSzY6oe5CX8CVAXQSNFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I4/vTBLdy1Re+jWlWvzdmwEhIbisyFj3dZnju3Bo1NDOjEON/FHKquATfAne5nJ6b
	 n2/iujbJ+NLBllQd7EvyEK3Pr9NP9V+m/PUmEwIq5tuLxJGzuPA8uYank6uixjSuqg
	 P7hjd+1B287DyIngK80+Q3+4yMhk/gwy5QigM9/x3pahAVczSNBSaC4QWSQkM4TtjO
	 ghuxwAaPMfWL/Mbytp7IAJDlek0E31/dGfxFNg6mkAwHmhKVEX1QSFe8QkjwGVbjjH
	 w8KJYAltTr6LBVwawNAXRFmF9/RFDlyudFGCKEHeCMav95WI7cnrZMIyq0dUyi/u+X
	 kgMND6SiuTceA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16CBC3808201;
	Tue,  3 Feb 2026 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] ipv6: misc changes in output path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008401861.1271965.16448910408274760073.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:00:18 +0000
References: <20260130210303.3888261-1-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 21:02:55 +0000 you wrote:
> Small optimizations mostly in ip6_xmit() path.
> 
> TX performance increases by about 3 %.
> 
> Patches 5-7: add dst4_mtu() and dst6_mtu() to save space.
> 
> Last patch colocates inet6_cork in inet_cork_full.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
    https://git.kernel.org/netdev/net-next/c/1bc46dd20966
  - [net-next,2/8] ipv6: add some unlikely()/likely() clauses in ip6_output.c
    https://git.kernel.org/netdev/net-next/c/2855e4925416
  - [net-next,3/8] ipv6: use __skb_push() in ip6_xmit()
    https://git.kernel.org/netdev/net-next/c/b5b1b676a30b
  - [net-next,4/8] ipv6: use SKB_DROP_REASON_PKT_TOO_BIG in ip6_xmit()
    https://git.kernel.org/netdev/net-next/c/94a150bf14af
  - [net-next,5/8] inet: add dst4_mtu() and dst6_mtu() helpers
    https://git.kernel.org/netdev/net-next/c/8776c4ef3ab2
  - [net-next,6/8] ipv6: use dst6_mtu() instead of dst_mtu()
    https://git.kernel.org/netdev/net-next/c/b40f0130a23b
  - [net-next,7/8] ipv4: use dst4_mtu() instead of dst_mtu()
    https://git.kernel.org/netdev/net-next/c/fe8570186f10
  - [net-next,8/8] ipv6: colocate inet6_cork in inet_cork_full
    https://git.kernel.org/netdev/net-next/c/b409a7f7176b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


