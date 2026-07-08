Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C92BB17;
	Wed,  8 Jul 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505427; cv=none; b=nJZNXJbwWp+AIszDjQmpq1y/vvx3IfyDREDvw1jZvJwOs4+0UIthfJuIxBBc6PIX/PKw/A5FUCBxUk9qpV3NTHgEhsL0uBrzvynYzYwHv9KXtGf+hC6EkmH0xnOd+F3sTS0alEepoFyUj9lbjUa6J+9NBUzCjs7hSWKE9tIyhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505427; c=relaxed/simple;
	bh=f08AC+yNRiUuBV4DJx2I3esPx7GBlrCdqRbNHej8wBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcfeJVHR1cmJoJZukg/HOsKmdxFxtTXVWOs9uO9ihg1kARwh6egVtnG+yePttXQ25O+2ahiv+QneUy6k9f3X2AQWHhFv71dpRpKU8osrJi5C7nff8QbMmbaxNs9rb10SBl+SrW/WUV4mzvxoytd0thpNsuJLPBt6z+grr0iF6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ7sce7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ7sce7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B77C1F000E9;
	Wed,  8 Jul 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505426;
	bh=3yEgUHaM5YPEQt6gJNCTpq3giBcRh5DuqpKaF6jFjbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cQ7sce7o77fMFjsys+aDV1k0K/S7MdJeBX5cKTzrOruB92R6Ypts0Kh3/XIBrK98W
	 QsTrgwLHd4lPxb8UxxQx1fF5Qs/opaP39BaAFcX9WoKmiSCSTfVzoYedpYhYqTM2kv
	 wTwBd5gqL44i2NTlMGGhjzwYHafd9tnzm4KSk65nSUtSLJi4IlKyoiOEO7K6GwbQkl
	 h/U2NNv23crXRN76TpT6CbuoqQpdJmQYYQcTzGXLK1xsMkyi6A3pNwdFgD64c7NGSa
	 PrJZ+jJg/0wFu4q1EdujlyW95MmWUssSNwpgLANeRm6FfioxBL+KWIle0lgDCanVoe
	 jynG+zYqUriSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD4392664B;
	Wed,  8 Jul 2026 10:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] octeontx2-pf: check DMAC extraction support before
 filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350540539.2415816.15321558718099935107.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 10:10:05 +0000
References: <20260702033451.2969880-1-nshettyj@marvell.com>
In-Reply-To: <20260702033451.2969880-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, tduszynski@marvell.com, sumang@marvell.com,
 hramamurthy@google.com, rkannoth@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 09:04:51 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> Currently, configuring a VF MAC address via the PF (e.g., 'ip link
> set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
> hardware filter. However, the hardware parser profile might not
> support DMAC extraction.
> 
> [...]

Here is the summary with links:
  - [net,v4] octeontx2-pf: check DMAC extraction support before filtering
    https://git.kernel.org/netdev/net/c/235acadd3105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


