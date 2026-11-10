Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279325;
	b=ptnuM1wRcEjhC+x9x3ZfTNOtgUedw8URfRXuYjyMTyvFNcRBjKNP3Q2SaiUwVCtVJS9l
	 0k4l/vze3Th/1BOpadTdoV3j6LYIjlsASG71iNL0XVtkDNDolSVVCgeIUHKxKOYWHhlp3
	 M80C19cTEGK80JvDH74rF/yt6G9rWTl5pERgx/5piSHk8jUn5NOfBJeGGeJwjWJ6FrUhO
	 iun5GaXXDTA2PRp9BdJGPjIa2GbRF26dm9zMP54st1FyKcQtyjo4BXMRRAUw5hp1CT3PT
	 HPJQT++vtEhyZhxZj9Ysa4SaoWKGTSuC8gDlGA5PQAVBZBmXai9BTMv14dB7cRpN+Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279325;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5q+GcIFqZ/f31fNpfF3r9rQD5HrcB1QhENzWcMfymKU=;
	b=UmLxdx0y9M//YBdp+3C8SuW7rkTZwuWhbjKI//HVeNpblKzIAYn71hseesSs5LemIU0f
	 rUfAcbEh98v3J6DV39vQ1QwqrYBemISkT9x75FXKbDYonTG4GxZMSyVfDCBHPgnaqD/Vy
	 cpnEJUXQ4oufs5L3qW9Ab9+HkpcoNJoJB+3ccO+zac0HDfg87acI6aXI5pP75o76IZqxJ
	 gBwf9PwPZKuX12x3bQmeo/Eu5AslDteooq4VrdVZmVBWBd3sA72SK5OPqIs+IIOBBJZS2
	 MDg+oqbPe5u/AlMya1wJhjlSoKKsX0K/dDO2EJ+AWFr1rx2aHsqI5K2uyhEyYs112tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhUKpBA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28750606C6F3;
	Tue, 10 Nov 2026 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhUKpBA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77DB1F008BE;
	Tue, 10 Nov 2026 02:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279324;
	bh=5q+GcIFqZ/f31fNpfF3r9rQD5HrcB1QhENzWcMfymKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DhUKpBA8m8Kfac1nhpE6hdpBSfcIHqTfbeHZwUW6NALlzbs/6Yvq4TZ5DSfMwxhDt
	 0HObKzUG02jVIK+d5hxgTljwdM7g6g/l2yR6quzx16D+dF+WnAnM00yOiTRFclxoUZ
	 yYVwSF5iiIeYn/LTdS1D2WJoennabVYAn4oTwZC2cgINZPOeF/sr5ek6/3wYLKp9fy
	 IYunSF46gC4mMQ3HWkmdKHbFpZjID9VyVQ7yF1hPTmU0Ef7a4alPgcmtIEvXFkJUal
	 mRIgX6yzZiqjKnUzGoU68uPX9KVRgORQj/HHM5kfyqRhdABTGZpBfnENoT0zyyIpwk
	 XwznkD8tXLx8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AC936391AFCB;
	Tue, 10 Nov 2026 02:55:24 +0000 (UTC)
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
Subject: Re: [PATCH net v2] octeontx2-af: skip NPC_AF_MATCH_STATX access on
 cn20k
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427932342.3612825.1031866925824324961.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:23 +0000
References: <20261103091831.914393-1-vmukunda@marvell.com>
In-Reply-To: <20261103091831.914393-1-vmukunda@marvell.com>
To: Vadluri Mukunda <vmukunda@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sumang@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Nov 2026 09:18:31 +0000 you wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> NPC_AF_MATCH_STATX is not present on cn20k silicon, and cn20k does
> not set up an RX miss action counter. Two paths still access it:
> the npc_delete_flow mailbox, which reads the counter of the deleted
> rule, and the rx_miss_act_stats debugfs file, which would read
> counter 0. Avoid the access on cn20k. Counter support for cn20k is
> left for later.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: skip NPC_AF_MATCH_STATX access on cn20k
    https://git.kernel.org/netdev/net-next/c/4386ca0bf692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


