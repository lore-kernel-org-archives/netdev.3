Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3B3A7597
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388622; cv=none; b=He5HUqef78pSKFH9iDaFNigD8hLpYd+XlD/rmJPdZRGlrwvcH14gYnHZ1Ve40C596tvBN5yVgdl9OQ6YEnjZPQ7c/K7vgORgQzegDY1hrBqCnXxr0uqacD3GUgACr7ir4PBxayMrMc+lJ+iXprp/CuW43P/73nmDvxdadlzq9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388622; c=relaxed/simple;
	bh=JYTLYbckKB71U8e8hv4tAVTmjxcZw7H+MPEg2elJRKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WcsooArx804ZwJ6lIpXJaaWsdUz1FPAMa1NhD+/rfYwHVVtrNpMHO/KqsIPNQ6tjvkGK4dDfRd+CH4Ew5li8VtS23GW4dFth1HOrrHMBAk8Z+P566FtKCNbBKiZmnqNkS/eT366NRg8KcOO9gUM3Co73xne8KPd0IiBPnXMNva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs/4FErn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs/4FErn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2691F000E9;
	Sat, 13 Jun 2026 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388621;
	bh=bgVCS3SJJ5arXhx+G4WvikFQP68N1RBTeC3H3wIslN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gs/4FErnreRzpuL01AFQH+ius9Cn6faAtRLuD5AfErK+ML800f00Cvm+NHbop7sM9
	 oS0X0cxpy223L8PXekBf8vjlxPQrqoeT8zZYzDU6XPgroFfoMNSi1pXSRxDoj245bJ
	 lLqkEfAFtHr823v13TYFwB5Wa4qDm28iLfbxOPvLdI9mNN3nA5VCWRPKgCBb6hV2Pj
	 WmiD/t+oJqAHWPgGEj7wNGxj1PY1NDKY7rEkQw65vTrgoWRfWmiAhJE1xzTI43wKAq
	 paO9WOFuwvDX11xFNx7e/vhI4ByJ2KKbqs8z0fXenBiJ6QkPKlH7y4f6cLGlj7V7v4
	 ZmXVmXhq8BLtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D83A54A32;
	Sat, 13 Jun 2026 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: better handle MIBs for GDM ports
 with multiple devs attached
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138861738.1607522.1344030829934869681.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:17 +0000
References: 
 <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
In-Reply-To: 
 <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 ansuelsmth@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 12:43:00 +0200 you wrote:
> In the context of a GDM port that can have multiple net_devices attached
> (GDM3 and GDM4), the HW counters (MIBs) are global for the GDM port.
> This cause duplicated stats reported to the kernel for the related
> net_device.
> The SoC supports a split MIB feature where each counter is tracked based
> on the relevant HW channel (NBQ) to account for this scenario and
> provide a way to select the related counter on accessing the MIB
> registers.
> Enable this feature for GDM3 and GDM4 and configure the relevant HW
> channel before updating the HW stats to report correct HW counter to the
> kernel for the related interface.
> Move the stats struct from port to dev since HW counter are now specific
> to the network device instead of the GDM port. Refactor
> airoha_update_hw_stats() to take airoha_eth and airoha_gdm_port
> parameters since the function operates on the entire port.
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: better handle MIBs for GDM ports with multiple devs attached
    https://git.kernel.org/netdev/net-next/c/8f4695fb67b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


