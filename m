Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D773E1230;
	Mon,  6 Jul 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335041; cv=none; b=XqNomgIX8BJAfGTCOKzHuUFrW/RleVygmwhDCGFc3sGYoxqpHANllQ+4CasxYpLIh+g5N9qzKMC5smTT56SHPL6eWAK55/GKKKtDJeCFWjT6PkeExy9VTwTneRgSyGIShcUCOCYC+6rs+l5MW8qgjkEy6bNMbRAWEVbAL69nMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335041; c=relaxed/simple;
	bh=Pz4Vg9ETDcPH+6qXDC5UBYDYsZMI3hUWMWSWDLr0ojI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/3U22OEbNRqum8p1qtCsCriN61X8T5FGqhWsghmvzT4zKqLFFZ/AZZShrdRRplfNvvAeQPvwk/pmbKao1IUvVHbIaRNRtkdJDbfF2xUj7G5YMlFdzW8IFY1utkAJCn633inmu1JbH0gvxV6Xo0PVlMAQCK38sSN7tplwX3ZktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuxVYsWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuxVYsWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E4B1F000E9;
	Mon,  6 Jul 2026 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335040;
	bh=7ERXisdQwyXbJE1LjRI+sBOHWRDWWwfPZ/KKwR+/X9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SuxVYsWAcZfAxSJ/9+GhuF/p5Jc/P1j/HxiH12U218JWyF/blawjtcJ/mXIfArLKo
	 39fbJNmYfGAIspSfdDT47p20agIF4hAO/jghZJoTNxo+dAcQjjRBERYSoB3wyXD9//
	 CBTlIotSSq6tm03+/3iQZ+dRvy17HhN1K5v3nDkW04oZiDL6VrqWfyWlExzE/XIEgU
	 cyuVX39fvApzBsiYYDHoSwN6B97dISiZasYs92dAcNAePRiQ3lhHaWE7lPGMRXckXb
	 ugHcK541nPc4z+qwWznDYDbUkSfL9BWsLMEhcVaJO/n3OpvMNF3dKodcmYTkkidcJ3
	 Kl1fW/ry9vAIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1C3ABD2A5;
	Mon,  6 Jul 2026 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: validate MAP frame length
 before
 ingress parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333502038.500093.17838135308357256477.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:50:20 +0000
References: <20260630174110.2003121-1-xmei5@asu.edu>
In-Reply-To: <20260630174110.2003121-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 10:41:09 -0700 you wrote:
> When ingress deaggregation is disabled, rmnet_map_ingress_handler() passes
> the skb straight to __rmnet_map_ingress_handler(), skipping the length
> validation that rmnet_map_deaggregate() performs on the aggregated path.
> The parser then dereferences the MAP header and csum header/trailer based on
> the on-wire pkt_len without checking skb->len, so a short frame is read out
> of bounds:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: qualcomm: rmnet: validate MAP frame length before ingress parsing
    https://git.kernel.org/netdev/net/c/f0f1887a9e30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


