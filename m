Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448809;
	b=aERFa3bAoPKu+OYFGislQzMnoM5Nf2MOf/vjpVZzqSKwjWXnIuMyJK6QfTPFiBbnib3A
	 kCr5KHFUllXkRxWEfcD4bDepFGeyOxs7zeT0Wuus9DIKB4KsEhzoM/CVOAZa5s/Vl6jNk
	 XN0Lml/Yfk/uACkTqim6dOEE4BZy+rRmpQdHRJ97rUp3JKl0I5GFwQV0o4XSTzdx8FY9s
	 Zgyi8mhpyyEi7jNKnHlQLJlP1B9RNms6N5m78jhi/kIRgjlaX+pqU8ZwN4LkDzBdfsxvH
	 A1EvnGGyHnXuTgphGuGVq70wSsRCw/TjEB9Xcu0JV6hvtBzYeTB/8BSfME1orhiaYqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NMBat/pFanEnNDgF3qAG7ruGMiHtrfnPC6CNiAjj9ss=;
	b=YXbV9DCI6dIV3WXBWfaJg6plvqACERudBNawDU7sYjljzu3xOKUEubX71n8sk2OUbmPt
	 GlF1bseQljHmcrAtficizc/roGFFBYkEFulrGEMo8vyd1B5Pe6ecO95Ln3LMccMRkv6fc
	 KfNFkWapRIS+briJ8I/YeTcOU5JXbIl8EOeKtwYTnu8mubkbhChgtI2OKyQm5rv72vtSg
	 pvG6loIpyplgVw1oVxUqfy5mtw+4T8kc3IJIwVPZVqf9lpWBhPClEFkypI1WPE6iJgRFm
	 sHRL1bpT9PdDcoOb7DEdzPe/p53nzy4pxDL8fS8xaOqRPtZusMKijAXpiRUj2SczCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhKY9+8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2ED606A882;
	Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhKY9+8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD2A1F00A05;
	Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448809;
	bh=NMBat/pFanEnNDgF3qAG7ruGMiHtrfnPC6CNiAjj9ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XhKY9+8njz7I8a5O74cosZ+6jSBZTsyZncAkGzdpdriJAlxP8Z/ntvxw1KGUrDzXt
	 NodLNMNY5YpVH79rIE5JmRZ/aVfeeHjJsXX92xFTikPCoicdDiifkl8UuczIapsqFh
	 zXYpi5P4JKcYzIpif23qKxz5UaqqJi3SFJKbodc1R/f5ibzw67V8RaGcril9hOZeEg
	 jkhVVH2Yl3CYqRNol35cyhRwezUg2y8FGpooh+doFdLZ2yo2YqYPM+cJJvcngM55nP
	 y0SZnLmhJGNIdsPPxgb6dpMYP/WAeE/0h/ggZbxAApx55QYM8uzqsAf47CC6XQtpQ/
	 i51UkgOKDVQMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0B8391AFD2;
	Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
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
Subject: Re: [PATCH v3] net/sched: sch_cake: skip redundant cake_mq rate
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444880792.1768068.17540215738518916214.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 02:00:07 +0000
References: <20261109-cake-sch-cake-v3-v3-1-249ced20a1d4@gentwo.org>
In-Reply-To: <20261109-cake-sch-cake-v3-v3-1-249ced20a1d4@gentwo.org>
To: Shubhang <sh@gentwo.org>
Cc: toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 j.koeppeler@tu-berlin.de, shubhang@os.amperecomputing.com, cl@gentwo.org,
 toke@redhat.com, cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 11:56:03 -0800 you wrote:
> cake_mq periodically counts active child qdiscs in cake_dequeue() and
> derives an effective per-child shaper rate. cake_dequeue() currently
> reconfigures every tin after each scan, even when that effective rate
> is unchanged.
> 
> The dequeue-time call chain is:
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: sch_cake: skip redundant cake_mq rate updates
    https://git.kernel.org/netdev/net-next/c/eb7b07439cd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


