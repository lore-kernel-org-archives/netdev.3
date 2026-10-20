Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522811;
	b=J46l7BXgeMBP3dAhl0DlhLgFGY0iZ/FIP5g3li2KTbgr4G58/NXU7UAhzzZD1j1gnZ6i
	 DC3Ge/sX6icIYnpu05GmUvp5BpzGTCoA96Ghi+OHRTun5iKrf+AqyUUroAPjxEUphgOGU
	 UFZMf533suJU+YH5ejnySqiRdLi2V0GdJ1dJJDfvtGNzmZwu1lhujPwrT48NhFBGPTM4S
	 ogHBTGG9hWuaIFplDygtD2UH+bXCWOD/vyQCMWFwArhHR7g4j0UJRLaZkXI5hF4ziUxLY
	 807Zd3YV9Hf0RGIIRmBg438bqSbCQ1SJMG5vU+GnqgTJhi/xzNxltQMS2acVKLyff7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gahkJI85Gi+5l5oewJx1+g3m9PK/JalsXnLpjhLdaVY=;
	b=Oil3E5GHtMRrZdDs6WMoAVz5KUCgxIt1TXO5b9CmKDHQB6qDEk9By9GvY3abm4dpGE4F
	 2LhSzdnehbhiNQO/67xVQoUxvJN5wHlkWhSYtVTJVLGQzjXPOsI2I3cA/Z28tFpJuFUqJ
	 XGBua4YpXETwHb3NnoQLCRJmjyKtOzwwtXiGTGuJyYrHdix6MAn0mNxGhuoDLEd11y25D
	 pwwK5sK7PP94obdnXp/bOACmsnT2L39uWJtz1AIQOx6pEnQGdluq+KuX7NBeoGwT6wp6O
	 jrpaMJ8DMJbX7EXpJ71wteEKbj0+9mHi5ukGVAEx35E62m8lzEogMoWlRAOTS9jQ4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD0sn9on;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF2606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD0sn9on
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816EC1F000C9;
	Tue, 20 Oct 2026 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522810;
	bh=gahkJI85Gi+5l5oewJx1+g3m9PK/JalsXnLpjhLdaVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hD0sn9onh5hMiu5FV+qWOS010YcQVLUH4DuNQb9maze62O+b5GYHV0UxZvPCsyLfb
	 ubmIsFLITk+bOpn4T8hPqwVS2bxBUYKLJ3ag8yq8iGw2fN1dSLuzlPvwdHbH/QTgGB
	 DNuVP0g+W740gvPhZDH+LH47RSFW4N2TlFC7AjBoUcAhbJov3wjAk0/HXhUYHezB7A
	 KNG/9ft3uWUqF7V+FNCQ/Lbph3VA2HBPP/+uO2ON3hL7vjKm8rJvAn/Jf/XWpW7U1b
	 QR6LrckPvIGqW885XEFoKOJODVOrJ/UhNOORhS1zUYrIt5QS9Ah0akgb/XizE+xcre
	 oavT9kEjFLigA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7748F3808209;
	Tue, 20 Oct 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] neighbour: Misc follow-ups on per-netns
 neigh_table series.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252280902.159319.14955125563828408722.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:09 +0000
References: <20261013205816.1642597-1-kuniyu@google.com>
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 20:57:27 +0000 you wrote:
> Patch 1 updates the switchdev doc, s/arp_tbl/arp_table(net)/.
> 
> Patch 2 updates a selftest for per-netns sysctl knobs, though this
> is not an actual issue since the test does not hit gc_thresh by
> default.
> 
> Patches 3 ~ 5 are based on a suggestion by Ido Schimmel to make
> neigh_periodic_work() and neigh_managed_work() CPU-friendly:
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] Documentation: networking: switchdev: Replace arp_tbl with arp_table(net).
    https://git.kernel.org/netdev/net-next/c/3e2ca51e7e35
  - [v2,net-next,2/5] selftests: netfilter: Set gc_thresh[123] for gw netns in nft_nat_zones.sh.
    https://git.kernel.org/netdev/net-next/c/2335e48461f2
  - [v2,net-next,3/5] neighbour: Schedule neigh_managed_work only when needed.
    https://git.kernel.org/netdev/net-next/c/8854b0e247ae
  - [v2,net-next,4/5] neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
    https://git.kernel.org/netdev/net-next/c/7a71343ba1a6
  - [v2,net-next,5/5] neighbour: Floor neigh_periodic_work() interval at 1s.
    https://git.kernel.org/netdev/net-next/c/ccd0742641dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


