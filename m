Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B310391E49;
	Tue, 16 Jun 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575811; cv=none; b=becoZwR51twE0bHjbfam1/6VAY91XkKn9hR7zRalM1bTzNNPLv5XNZK1Os8lvIG96SYxlDGm4xRo/Yc2vmyzRTHxHGELTGOQLtH0vmcpk/LsArM3bt6D/BIeJALZQGfE0jpWTOO9lYNI44dEMNcqn2tZu+6NbZd9yfZJUKxdf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575811; c=relaxed/simple;
	bh=of34fRKBYUZvDxAyR6UMEDMCu20pX0y5iC5TZScvzL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/1As3xGgRLu1VcZlMfGRE6vPW+ThwAuWgIFdnF+nNJYRZ6AjgD27CrbhXF5GhGpGeb0oTJ3vZPHSqRdMU7COe/p0gvAjelPI4o+/91HlnLQ+dSuoisjKvNlAnT6biU8fKEP0sNMWv0/QgDTl+cdW289cxneuqs5Wo85YgHFv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8CNRlWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8CNRlWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BF1F000E9;
	Tue, 16 Jun 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575810;
	bh=NYfWWcl8Vaz5dyQoFNOwiQBYjsJN4KQ+mYA8kF+EyLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N8CNRlWBeEBYVaVEUrbi4TznVZaamfaX1lYr4WeCV/HNvfbLBm8ChXYkeF+KjfWSy
	 TIWtRVYXPM1HaIcQ0HomTQ5A2Ri+5lYa5SjBRaYY/TVXJLEtUtmlZYk/xRrYktHve3
	 RTccuSC1t5I9gE6evXyKKkVJrQo57b4G75AuWCxLIkQ8B0PuQS6xN4C+Rj3Ikak/2K
	 AjIz+lHq/eLhwVopF4avT2AtuLgDsm2wK5Q5ln9HasOvw2Dw6u+bRtEtWxkDvD7mE8
	 9sbDqNibM9Ofs0WjHMCTX4STjlMN0fKTKVA1QQNoiE3dzL9VHmLcdKWjqqVhG+2xms
	 ZSDNb9OE65n3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA93839A26;
	Tue, 16 Jun 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: sja1105: fix lastused timestamp in
 flower
 stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178157580564.388586.11606897833464458044.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:10:05 +0000
References: <20260614141320.1133321-1-mmyangfl@gmail.com>
In-Reply-To: <20260614141320.1133321-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 22:13:16 +0800 you wrote:
> flow_stats_update() takes an absolute timestamp for lastused, not delta.
> Fix that.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_vl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: sja1105: fix lastused timestamp in flower stats
    https://git.kernel.org/netdev/net-next/c/72dfa4700f78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


