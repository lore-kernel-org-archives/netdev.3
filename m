Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DE29B781;
	Fri, 19 Jun 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832023; cv=none; b=UA/ktKNZBdF5YZTkJrDVYTpc70ZBFqQDlqvGyOkMNhCfE8771A12/92murMpZGurfqKYMwXLq0oqG4AUXyq1B7aXDPfBWqVMvA2Vb2MfRQeTEHvCIGXyFTnmq1tmHJ0FOec7edB8i1EaLiW0hG53BR31f3oOu2FItW4VLTy9dZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832023; c=relaxed/simple;
	bh=AXDp0hte4mIH3Z0lK87WeLKyTIfPrXPEUSmdoIUvIw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qol6vg0GlREw+bKNMk0nhlfd1lvxNdNumdiTsl1x6CbEM+Sz4yvRoPWgSbU40/BZcXpFXpUibuTj15pnSFJV2o8RlCQLeYJOXhaP1UJg+ambSfv47r79ZNAdIJZCbmryq/F4OwniGEYYATVrFZy+aZoR4zxtULHmjhUuX0HC0gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+EcR2Vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+EcR2Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5D1F000E9;
	Fri, 19 Jun 2026 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832021;
	bh=ygg3GDdLHLLwrZPS+Uyqmft3vzEKyChkPs6vfBY/QVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+EcR2VvZcnXAYv59XKSsZ7HwYbe9d+X8oi8oskxnhVfQb9txRukJ05TIxbWL5L6d
	 o1nqcoD9hENcvN9mz0/OV5bwPwkHnOrBb/zX1JOJ9zYxi8T2Mpt1RQRfVLq8AaeXjQ
	 aCMllzSUdsD0Aop2Cj+BHeMr5EjCO2iBHUxuPkJmaWswrucd2AYX2Q6Yw2uwsmvtL6
	 OanolixmpnZj1kob0wxcUozMf1UBJgNRf/i6aJvLvRFAe7VAy7R3qooUSsVqp7BZCV
	 Gz83WU6lvWm/epZsLQ1Y+LGkjSNxu3iC/q4wbPxV9GNcU4+PiIqNwPZWmg89E5KSkI
	 SwsAlfSHedXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AAB3A78A7C;
	Fri, 19 Jun 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: macb: add TX stall timeout callback to recover
 from
 lost TSTART write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183201489.3150917.15246467988851878585.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:14 +0000
References: 
 <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
In-Reply-To: 
 <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, nb@tipi-net.de, lukasz@raczylo.com,
 sjaeckel@suse.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 15:23:03 +0200 you wrote:
> From: Lukasz Raczylo <lukasz@raczylo.com>
> 
> The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
> the TX queue.
> While the exact root cause is not yet fully understood, it is likely
> related to a hardware issue where a TSTART write to the NCR register
> is missed, preventing the transmission from being kicked off.
> 
> [...]

Here is the summary with links:
  - [v2] net: macb: add TX stall timeout callback to recover from lost TSTART write
    https://git.kernel.org/netdev/net/c/e438ec3e9e95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


