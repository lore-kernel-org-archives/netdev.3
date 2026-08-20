Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0C3B7B97
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254284; cv=none; b=pdOJH1fkbZBySMVDP3lzzUCl2T32nHwEcvY44tXCypEkHJdzG0SQpXBZoPNJ7ljHMTKB+VRkrSmL9N4JopBZ7faeu90lhmXmbSaTgSQrRNzb9WP1+GwYEweSp2DXZfCRInX80nP15ivvL8o3h8iwqxJeU3BjV+DHYshXGVql72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254284; c=relaxed/simple;
	bh=nWT5FeVT0x1sk2i212SiQ0LlskbENMXsQKI08pXBRIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tmms5e2LCjm26anra5lwdrpeNdi5IF0mdqvQMaIq+Y9g+zzr5I5lS02OdhZVGbD/F+stwEWViexq6lSqEOOJ9Vkt6+iXkWNAsVLvBGbZMpjJDiHhSWzTkfQyyF6N0FOTc5n8tjR4oqkztRgF+A7QhC9KJ01a97FrY98Pj1OEBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/oeOf7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/oeOf7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFE21F00A3D;
	Thu, 20 Aug 2026 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254280;
	bh=v/Gj00JC5/4z+2R5ZEpsU8qkaa0qV2maiVytp0RhXzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q/oeOf7aLIAPDb0seFr+tXqJFiWlhzjoPuhc3iAFvBG8rkken4T0Zk4utBfrTUTzb
	 paQ/w4Z/Zed8s+82dbNTL5O/txNpkHeYDkb7rZ7S+sB2k8wIIhYINc2w5aqpn5bYCb
	 MNFoTDuLQdGWaoxDuD/nC3gX1/BrlgwS8TbajnpFSU7I5C8GHG5fTwJn2YqA5LkDKJ
	 aVfMTBgCAEKksOsVtNESHRSEa0PgiNFSHVxhmygtAEeBxkzYKrUiZH1JOhHiFlToq3
	 xJJ7WmPP4PQISQPIxtsuC2Ua1ATw4mKlf9tz6W2e06SHAhDqhkpmgTFC/OHeze9gCW
	 rp6p5FVbmueZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197963924459;
	Thu, 20 Aug 2026 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp-ao: fix use-after-free of current_key on
 reconnect to another peer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423063.446762.3835321188674867387.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:30 +0000
References: <aoIriv3pHDgII2YR@v4bel>
In-Reply-To: <aoIriv3pHDgII2YR@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, 0x7f454c46@gmail.com, fruggeri@arista.com,
 noureddine@arista.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 06:28:42 +0900 you wrote:
> tcp_inbound_ao_hash() is called before bh_lock_sock_nested() is taken,
> with only rcu_read_lock() held. On the fast path for established
> sockets, if the rnext_keyid sent by the peer differs from
> current_key->sndid, the key the peer asked for is looked up and stored
> in current_key. The lookup is inside the RCU read side, but current_key
> outlives it.
> 
> [...]

Here is the summary with links:
  - [net] net/tcp-ao: fix use-after-free of current_key on reconnect to another peer
    https://git.kernel.org/netdev/net/c/da4471557f27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


