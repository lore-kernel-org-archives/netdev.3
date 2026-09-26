Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281028CF5D;
	Sat, 26 Sep 2026 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383279; cv=none; b=GuUZfpHBwWxRHSgRbN2TAzIxet7IM453k5gTkAU7JDcLzHIVJD/QbRFTBW52aDmDUK+UKT6RwYBuYZfPkF3STczYpQKbq58cASoYQ6HYtIzgrJHUn6bQJ1+a+7Fc2KbL6sFfoMn7KDCkmNzps7O+IZeE9wN+ZsFARyZIqkBpKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383279; c=relaxed/simple;
	bh=UnOmKpUyjCwNAYFMEO/ulDCuAXLCwa836GzhplAsn6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=olDBQ0uFuVCRSfOSBQspKIzrT+ENuBz3yxsvROw/MCaXxpHdvwht7vaMsgi+/x/fkKdxqStRcQWDaN0fHL/fY9ZAfFEAL1qd8ZJ8PJBbnetZnkESXYHGwr/sgfCIKP2hvwNpO2aP9KEADnTN0gF8Ajopb0hveG/4OxZzUO8j9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIhrZaVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIhrZaVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585741F000FF;
	Sat, 26 Sep 2026 00:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383277;
	bh=HVdZUf3lyla+VqjgWf2ZPd9SS1sMyxqXLi/vbv8Snsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AIhrZaVDc/szRb+tvspRfkXQShjdOsyXpZi4duwufeoEBj2FYFxeM3/CBaHNQciKl
	 jUbMX/zuEUDwJqAcnXuFfwevmFT7MxtJuY8qyNOVN18YE+KpzDfnDfD6jB3I+b6dxe
	 TVz/1eryXHGlnDeuJONdU9sbZV56RfrLkGetzK8fUyXFVv23v5kR4K2xOAs3EvSwgc
	 TZei9Ft7gLWxtAnYa+SAlDHSZm3PDeGqFogFGi5WLP2yVgpQDhMcJ6JhXfLKXZKFtR
	 rkNz4akvG8BqUettD6ixotJZS1P5pd0VdC8Xx9PfrdpvraqTR4/w3OCgy0u1PGmD31
	 rtF5Pq5iBjuuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A73809A04;
	Sat, 26 Sep 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038320482.3221981.7336486420959700336.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:40:04 +0000
References: <20260924101922.2675127-1-nb@tipi-net.de>
In-Reply-To: <20260924101922.2675127-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, kmehltretter@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 12:19:21 +0200 you wrote:
> Since the page_pool conversion every RX buffer is a whole page and the
> skb truesize is the page, although the hardware writes at most 2 KiB of
> it. On 64 KiB pages a packet therefore counts 65792 bytes against the
> socket buffer where it used to count 2752. As a result a UDP socket
> with the default buffer starts to drop after three packets, and the RX
> rings pin 16 MiB for 512 KiB of buffers.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: allocate RX buffers as page fragments
    https://git.kernel.org/netdev/net/c/0e7fe2b0ca45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


