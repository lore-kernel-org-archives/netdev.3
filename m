Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB533F8B4;
	Fri,  9 Oct 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511208; cv=none; b=mDAsTyRge2P1Zj9FC7UfCN951fLZ9uv3angq4lOk5cLj3J5qSqypJ7pAN/WgpadQGGMH1DSKDhkXjqXtlCADtA2pl2iM0LcEbvc1/2G060lXn9LtfiGzNRDRLX4yrXKfm1No/1WiYsfWVESr4gA6owDkpBbQOnq+iVWS/7Uf/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511208; c=relaxed/simple;
	bh=XZPc1JM4Qpcu/jFJLeAdRo+xF4T6kyvD8hxdPs3bOME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKYHXpcewnoO+wc6XJl/V2n5qE5o0vD9M3Dh1CPBuLPT20f5EM9CsXJhk3jhkKX3I172y2eGQ4+pDY4oeNgN5fZ2Yhb1ugKY90rhjL6Br0iAdBSTdKctQPmIDgGeLr9+HnPH5pSsLdwx5txaDTzpqIhyzNg9mmIUfQFAx3lymPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiR1gL/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiR1gL/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8416F1F000FF;
	Fri,  9 Oct 2026 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791511207;
	bh=8xdgtLpjzbpWmGNyuK/NwNf8zISqtgETz6cQOW/oSCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hiR1gL/gH4HWrRzY881q+mhh4ba7xpPUTlfRq+zi18oi4mPyL7u3JM+EARwHTkfqJ
	 g2TnpYwoYQtjasL48DR9OJ71AOMCerIqUiT5AQk2yzqkSQCAXteQyXDVgNCq2fq36r
	 TtZcEhmFS/AUshYA4AVyFh1xsyld2Ezo9+ryf4lkM53k85kJQKOTORxuHOoyB570Qe
	 ftI2t7mnO5Y/gihfcdrgWbDRmTAEqi3Rxm3GL0K0E+JVrKHfJMYHRht0DlOFR8P+kY
	 LImXberAbvcepYsCS6roFZKxulKu74zdCdb016RLaihw7/noAIQID2rdkz5JP6HCf/
	 zh5xXQFhKGmwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7735A380AA63;
	Fri,  9 Oct 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: move XPCS lifetime management to
 platform drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179151120601.517180.886475800307456718.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 02:00:06 +0000
References: <20261005221749.1104430-1-coiaprant@gmail.com>
In-Reply-To: <20261005221749.1104430-1-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: kuba@kernel.org, maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, romain.gantois@bootlin.com,
 linux@armlinux.org.uk, heiko@sntech.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 06:17:49 +0800 you wrote:
> The current XPCS creation logic in stmmac_pcs_setup() is problematic
> for several reasons.
> 
> First, if a device tree specifies a "pcs-handle" but no select_pcs()
> callback is provided by the platform driver, the created XPCS cannot be
> used by phylink for PCS operations. The framework requires select_pcs()
> to return the PCS to the core, so the pcs-handle property becomes
> effectively useless for link management without the matching callback.
> The XPCS is still consulted by stmmac_phylink_setup() and
> stmmac_init_phy(), which makes the configuration silently half-working
> rather than clearly broken.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: move XPCS lifetime management to platform drivers
    https://git.kernel.org/netdev/net-next/c/f91afd7f7133

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


