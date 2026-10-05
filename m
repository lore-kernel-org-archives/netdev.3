Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63A455633;
	Mon,  5 Oct 2026 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243020; cv=none; b=QoFbdQj1lH36moxac1RUycz4cMIvpWRp11uznX3pMfUME/ljWwSYFSyTcINqPhHPpfVSfJJB2hCQk4XNDUr7k+7PvulEehX7ApgClxMgESKvOlhYkUAXwJahSH2n9VCwqOar9B6dooIZhANw2E/lAnTDGqJ+yr66+tiTOHvYQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243020; c=relaxed/simple;
	bh=TuErjOQxU/xGi9+knRePG8J3MZLzsno6xEtEMrIFGeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDt8EhZmkh2pWGjwM0y2LKni3AGOuhYosaNQ7xX2gNRJPNnnnpVE0peY37e1LUvvM047ZehdPXO39wdhwIfBbGW1xNOryMbEZNadPVZ8v4bB0FG3g8UZWY3KmbXS02zZFqUxY+nHu/hsGvd5E4R7gcET7GuPbPvlJ7MevBaOgiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT69k3c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT69k3c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B61F000FF;
	Mon,  5 Oct 2026 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243016;
	bh=cGDblRaOu2bvA4g0O2ggswBxqHpgYqDBEKzu3LYLMPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DT69k3c5MvjsgV6EOnq6pDY6AYGFxKz1uzJfVE+Z8SkcFsZSQJ1e/9QPhP5wDcxch
	 5QjTSGc0hWl7OGZSSi7vYoRWuk3oO3qKwzT4L15QKfAV07sXzAMu0FO0El1Gdi4WnV
	 hqHxgmEWLUn4AVTjt0uehGv5JRqsTwF8au3/hvFs2nP4aeukVGkEBFpwF4XYNoMkVC
	 De2a3iqeTt3di3n0yEv1FL1SB6Hz/pP3llRB50r0KpWTEPJxM+KkH5wq1VIypMadVA
	 6p71XTpf+40sfFIXOgGIJjAi/1JuuPyfVVGFE+x56ZbB4rx9iwPBkcpgAhDBn2x+Nt
	 QkTOFsd74J3vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773AF392667F;
	Mon,  5 Oct 2026 23:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124301502.1937173.6589668234241813148.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:30:15 +0000
References: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
In-Reply-To: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 20:35:36 +0200 you wrote:
> printk() call while bp->lock is acquired might be a bad idea:
> 
>  - It grows the spinlock atomic section.
> 
>  - If netconsole is active on the same interface (and we run on the
>    queue's CPU), we risk a deadlock because macb_poll_controller()
>    calls macb_interrupt() which grab bp->lock if an IRQ is pending.
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: move printk() calls out of bp->lock critical section
    https://git.kernel.org/netdev/net-next/c/3c9d88b04e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


