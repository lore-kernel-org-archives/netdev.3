Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359412;
	b=uq1M57g+rYpdK7eTaUMAbEylt3MnjcS2LKObj/9ofdprnn41LpTOOiZiGWbVFpaWZTbe
	 9j3Sr2rTwT4S94zUL7N1eHc6gz4BF9tIyz8I8Pi/rtjArPfF/xg9fkfpgUdFUjJmBpu76
	 R55y/tLcMffZcVjGQcqQVtrXFb2z61RwMonZpf0JUb3RDfclZHnT4M8Ayt516rx8ymDTs
	 2X/iAfY7diCvqCy1fCwzLObHMy5R7UORgccFZkSzmAluF6wi1FMl31BIS/2lTg1iw0z+4
	 pXTeSUAdz03YSH6TzgMhI9oU8hdLPXHfqQChBOdRVxdoP0OdaEPCFE1R63Mm7Va4/eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=y5U+3BdFRS613cFNSPQ5XyLDNgEiHnZFIQoDUCMMiL8=;
	b=pzPeyU+cUJ39P56ikeHhlOrva9RvZTe+6555L5diDjOR2vKvSRAkTntPk86Hoi52adWu
	 Ztcy9xlziQeQ8CpqKY7bkGrV3LTQ4J3hXyBWq/G+Lx52lsZS2bZJ/kGkzilFYLqWIMV1W
	 Ziu25hXLhp2YjWtT4fxCjeUBlHk+xuSUxuA3qOM6IZ81yMA3zwpdAUu9nWH6ourA3Q1ht
	 OQjxghbUG2MJ+JAshu7KcSWDqGHPO0r3S4A9WnpGtF7WPk5ZsyNJJIFgY3nOwLlry555q
	 x0oSsOsiTrgUIkamZKnhfQe8e8WUPast3XTPRs9wsUc5gJYFouHvszYT9so87kUpgUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxTkVZnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA1606A339;
	Wed, 11 Nov 2026 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxTkVZnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA8F1F00A04;
	Wed, 11 Nov 2026 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359412;
	bh=y5U+3BdFRS613cFNSPQ5XyLDNgEiHnZFIQoDUCMMiL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SxTkVZnf8mATdeqig6IF2Ni09YI1vDO6Q3MPl3cZB9hD+aSePhWK533y4lR7JUAxz
	 OrQ2Zyoj0Xb818Ivsn92Nxr2U+h+LHjbo2NU2Xq5piKx7iEBqmFbEy7qBjZfRa8jUj
	 Eecfb07FK+2R9rcCi6pHCfQYWYStQyV+TONFNE5smcDXKFt/L3VGmA0tyPcPwiR+Eo
	 HpsLklLlXhdAsnIks+Mym4blb1Q+YqXeOJDD8bY8UzLaVxDXNDLPNxVQCYU+WFn4T8
	 FwTbjQuN6MsIwHTFr5eWAq2K+9i/YGC70rp4W5ib903rVLVwLR+qTdF1nPfTh4v/Vh
	 vF3c3VXTLJy/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F95380CFE6;
	Wed, 11 Nov 2026 01:10:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] veth: set the real number of queues before
 registering the devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435941067.149955.5846747164826420289.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:10:10 +0000
References: 
 <20261109-bug-veth-init-queues-before-register-v2-1-d7dea61811da@gmail.com>
In-Reply-To: 
 <20261109-bug-veth-init-queues-before-register-v2-1-d7dea61811da@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, wang.zhan@smartx.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 00:38:37 -0500 you wrote:
> Since commit 9d3684c24a52 ("veth: create by default nr_possible_cpus
> queues"), each veth device is allocated with one rx and one tx queue
> per possible CPU, and veth_newlink() reduces the real number of queues
> to one unless the user asked for a number.
> 
> Both devices are already registered at that point, so
> netif_set_real_num_tx_queues() and netif_set_real_num_rx_queues()
> remove the sysfs objects of every extra queue that register_netdevice()
> has just created, each one emitting an add and a remove uevent, and the
> tx side also waits for an expedited RCU grace period. This happens with
> RTNL held, twice per pair, and grows with the number of possible CPUs:
> with 240 of them a veth pair emits about 1900 uevents, and udev takes
> minutes to work through those of a few hundred pairs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] veth: set the real number of queues before registering the devices
    https://git.kernel.org/netdev/net-next/c/099e433a8bf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


