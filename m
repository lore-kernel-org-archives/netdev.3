Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AF3806CE
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562321; cv=none; b=ZELPJZEt73CYmqvwpFadBpYzPS2x5dxBYwpPl0JUTio0uoF+S/JehifonP9DlJyeUMZTbabNuuH99sPpd60GC8Q//RkUITLhRrK8ciLuWs6UZdNgh6oP8Jj4KlNdyLqXJAvif8XMo66qItLyPKdpKTsvubOwEekfeuXtayBvkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562321; c=relaxed/simple;
	bh=fLjxkB2eFWRTS+t6UoiaF5tKU1ktdoS850RX3yz9CXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qe+u31r5RfqtPWLfQ7jH/C9TH2OzvmBrNfuJncE9oZd1tIPs0m+1rcyePUrytNczpOUiMmuL1VAc0VD3w60Ezi4QX7UquIC2Nv6KpULYA+G7B8o95OqYrPPjv1DSNzUOYPZ6Rd2s9CSYfyI3xwfV8pk2xOQhSckKa4hy+LHDV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7+x96nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7+x96nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD551F00A3D;
	Fri,  4 Sep 2026 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562320;
	bh=48YAXpM6+cY7H6sQpzfemiGImqwpsxdBm2ZoqTJCilU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E7+x96nXuQ3GmMhoezOtH7UmPwejXhIQaJ2A0mD44WOZbbCpDBJmyifeqHmrtqada
	 N2vo5hXbyHvbhXq5XDyp1RaeKSBVyTjSG/OqF5k4N9PVPnrLDu00dyNsPos+co4ujV
	 319ZYpoQq8BFfIHtHx7WHZrK6/NP4v+kDz243O1t59mwXxx9gTvJ9nT0H6cDDNncEM
	 vRbaY1O87MAAHrT+BT8RNISpKQOcngh4EcV1LmIir9gUzvCv9aOytJ4/bQJiNAiWPg
	 /YHtEQyx6qoLGGP36FtxJi/nDxB4X7DF4HeJJ6wGTOAXcSTyEUECxmrUjJMUnvhzdl
	 mflos4VPtbxLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199393924A7F;
	Fri,  4 Sep 2026 22:51:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown
 4addr
 subtype
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856226064.1003513.4882624192828119251.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:51:00 +0000
References: <20260831135117.574836-2-sw@simonwunderlich.de>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon, 31 Aug 2026 15:51:03 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> If an unknown subtype of an unicast 4addr packets was detected in
> batadv_dbg_arp(), it is printing the (known) packet_type instead of the
> subtype. This must be switched to the subtype to have any kind of use for
> the reader of the debug message.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: dat: fix printing of unknown 4addr subtype
    https://git.kernel.org/netdev/net-next/c/c6c8f1d693ac
  - [net-next,02/15] batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
    https://git.kernel.org/netdev/net-next/c/b963ee1dc32c
  - [net-next,03/15] batman-adv: bat_v: fix bonding candidate selection
    https://git.kernel.org/netdev/net-next/c/77f653e6f722
  - [net-next,04/15] batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
    https://git.kernel.org/netdev/net-next/c/7356a9232d9c
  - [net-next,05/15] batman-adv: use more descriptive var names for is_similar_or_better
    https://git.kernel.org/netdev/net-next/c/776c26254d24
  - [net-next,06/15] batman-adv: ensure u16 aligned mac address arrays on stack
    https://git.kernel.org/netdev/net-next/c/a5f7058bee1e
  - [net-next,07/15] batman-adv: ensure u16 aligned mac address in structs
    https://git.kernel.org/netdev/net-next/c/d9304a90eca5
  - [net-next,08/15] batman-adv: tt: remove only the entry which was looked up from the hash
    https://git.kernel.org/netdev/net-next/c/bbfb0d2cf035
  - [net-next,09/15] batman-adv: tt: extract code handling a roam on add
    https://git.kernel.org/netdev/net-next/c/fd8d892c685a
  - [net-next,10/15] batman-adv: tt: simplify NEW flag transition code
    https://git.kernel.org/netdev/net-next/c/e103fbefa049
  - [net-next,11/15] batman-adv: tt: drop unnecessary cleanup goto in helpers
    https://git.kernel.org/netdev/net-next/c/52d8c713f464
  - [net-next,12/15] batman-adv: tt: use protected flag modifications
    https://git.kernel.org/netdev/net-next/c/976b159b3c12
  - [net-next,13/15] batman-adv: tt: transition NEW local entries only under lock
    https://git.kernel.org/netdev/net-next/c/f59c4c59df10
  - [net-next,14/15] batman-adv: tt: don't uncount never committed clients on pending purge
    https://git.kernel.org/netdev/net-next/c/01ae63ecd1c0
  - [net-next,15/15] batman-adv: tt: decrement count for committed client on local_remove
    https://git.kernel.org/netdev/net-next/c/799152bcf6cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


