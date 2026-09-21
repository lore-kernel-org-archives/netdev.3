Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B95221CD;
	Mon, 21 Sep 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030220; cv=none; b=JLW/ySlDUv/lE3r5zcWr0WRo29oeo1FCdleTmhlQWk4t+k3LRWw8ybIATmKLN0ayoaXpCthP1dJ/Kf4wiSJE42sLPhRUFDTseaVWF4nnahGZ5xUjRxWeou/LxzU2Pewqr11zM8me+pr7ltAbzqAARfbEIXwanXn9j3JLiJ6mqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030220; c=relaxed/simple;
	bh=Naeql9OiEzfqOyE6u/id9baZ/RGQBY/I7mxrxdbWQXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pNe/8RZfq4xt0YUACkXFcRK7nz2qL7fLzXwueLscgJqTGG1Pw19Vnf0oqqS5iMlcbzul8U0hsN9woX8oUd4jNv5oJOm/lu0lctFQ2Ra0yWRYj1ff+QhdoS9dYgEELMGutJnTe5wfDCjIt2W8jcFVshULGc3lcD7x0kJnRNGzlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXqSjRz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXqSjRz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED21F000FF;
	Mon, 21 Sep 2026 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790030216;
	bh=+35S3DBRfXxqbpMMTigxV7Vy0IUXsYs+bPxcBUjGDYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SXqSjRz+0eqDg69e9CJJ1aukC4m7sEgtrGFnxq0kyYV42SRcwi2bowSLjSLMAgZH2
	 8ZCPK+f/FXqPgRx4POSXIaAS1ReSnu1Nln/eRd4iTmqfN3Ol0nEIAZxJnz+i/oHmRe
	 AOkGyn4Ml3G/6KTbk9foaRJ/0FXk1UlzkV7079K0qivUvUFKsEpJWHwdU/Tdl3wx7d
	 rFqBZbVomIplLp2uterCYHIo94mjfV84KwmF+SYt+4Yyxbejd+w/b4/LPQSBL20FPi
	 eJah1Ok02bjqRxT20v7SEbmU0wNNgo0gn0eq2L9yHGeLMChlZiyGxAU7m0v7Mo0LO3
	 4hZ0ui13/06ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198513930203;
	Mon, 21 Sep 2026 21:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: motorcomm: fix unused-function warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179002561264.3241479.8039796755333448352.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 21:20:12 +0000
References: <20260916082707.3973287-1-arnd@kernel.org>
In-Reply-To: <20260916082707.3973287-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: mmyangfl@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 10:26:54 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about an unused function here because the __maybe_unused
> attribute is in the wrong part of the prototype:
> 
> drivers/net/dsa/motorcomm/leds.c:352:1: error: 'yt921x_cled_hw_control_get_device' defined but not used [-Werror=unused-function]
>   352 | yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net: dsa: motorcomm: fix unused-function warning
    https://git.kernel.org/netdev/net-next/c/cc2d273893db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


