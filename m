Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551606;
	b=kCRWS33ng2FN0uf7C0VJIHPBTSmOAqwfWLYiLA1qskoQ6f/L1aczp3QKI/s+uzF/R5tz
	 MoQOh76iSKAt0Ehhb2UAtSBVao5X9O99/ox+C4A61lbYfn9CYOKByZxEMDKgCFx2UHFLe
	 Jsze0M9zTEoi6pdQlG2rzyFiKYwCyyGU5TbW9SwlCkOpJhkUV5iAdteuqpEUyb/rILk/9
	 TmDYP2bmHo06NIrXXWVcT7wXo7n/ugOlZzXL6bg0sABW1VOlfOTe5MZG8XETgBlbx1f/P
	 YkrwOSOPJICmisnNtq1ob439I3pm4vMs016hhupXFakwYvHmJS09kc3t21HasNTvbeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=s4s17HWemP9hWruMtVvX9EdATWKyGYuU/hj8ppk2By8=;
	b=HJzJIzfCfcejNLmbnkekLDuZjUcwORM4ZD58XWjv1dBvkA6nym0QxF0Ld06BAhvEE+4L
	 yk6SoZTfWwB6k0J09y53PlugowgLD5AqcZVVenxX9SMdQU1lMqeR5pDvJrQnAt8zMkALC
	 HiPIOBTvyssELAzMaeLShy/e8QRaMzAMv8EcQzchB+EFYx2Q0P4Wg+iEp3BKQp3NtTCu/
	 vzAPlWpZMkile554y0vuQ5EPbvhY0J1OVgfQNGZO220jjFvebDGb1yS0Z7crcQQuVxJ0L
	 2pfdmt9cr88igxiY4NF+Vrgox3NiSuI3SLfE0LemeSoD1HNysijO4QS3P8b0sRy5JQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbH1AX5N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA8606A320;
	Wed, 21 Oct 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbH1AX5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096001F000C9;
	Wed, 21 Oct 2026 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551606;
	bh=s4s17HWemP9hWruMtVvX9EdATWKyGYuU/hj8ppk2By8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nbH1AX5NWyE7AvPO7A+r8UlbvklLfZubgqvhHX1UgEnAk+JsZOtrpFXQ7mfFC0ETN
	 3Lam08xb6r7HkFL0EtpP/IRTDjSaRx95odZeCDQN/Gw95V6Rpp3tea0vul5VYEjHgW
	 NZBiSkclXMIqYNN2jcY/XoVPdBTorCfPy11IHbgGriIZF4U90az3hTDIvfxY67ALxg
	 9TqVj11QB9XLIIdV3ieOMkSXkWQovcWlf10oFkzRKli9Asmy8+k3/4xDPeD71BIwp3
	 TcFzsw4bGR78XGEDSyMpExqA/M77RGuMS8H0StKDvLNafSJBh//oDFudYQ2GMom+YX
	 1x7ThNotGtEjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F160A3809A18;
	Wed, 21 Oct 2026 03:00:05 +0000 (UTC)
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
Subject: Re: [net,PATCH] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255160477.350120.6545435189269879126.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 03:00:04 +0000
References: <20261016185817.54096-1-marex@nabladev.com>
In-Reply-To: <20261016185817.54096-1-marex@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, imx@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 20:57:38 +0200 you wrote:
> This reverts commit 587acb86d6465efdc03f6d8524461e6e725597b7.
> 
> While the i.MX95 MDIO MDC clock is improved by the commit
> 587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz"),
> other SoCs use different base clock for their MDIO and the
> MDC clock on those SoCs is set out of specification by the
> aforementioned commit. The fix for the i.MX95 MDIO MDC has
> to be done differently, and will be done so in a follow up
> change. Until that is done, revert the commit to fix the
> other SoCs.
> 
> [...]

Here is the summary with links:
  - [net] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
    https://git.kernel.org/netdev/net-next/c/4a929eba247b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


