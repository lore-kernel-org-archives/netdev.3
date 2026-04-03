Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B5388E73
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257861; cv=none; b=OrFeUjNvlMOIrkKXdJ3CQs9onvNd6knGxu8tM8R1ICjpCsP4Kp6HKneI4i0MHcsFFBpoR2GAY6KkRU6b2loQC9h6YNYbKPk79/Jl9B23JzUOuenEIiq3XCILAW7Bxl37UgvwBU2QNlvaGB/323lD+qr/1l6O8H9d7Kr08HCg/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257861; c=relaxed/simple;
	bh=p/jTlfNCs+/luZ9Mk406r7bskYTlCeoQVVIsHGRy2BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YJ+Ceuows2zO3ULBQBmBPK6zkr/8Hjqd71rbcaOynu70yzjoHnrpU4sH/T14Pwn57UWme9Gjz1BZ9vjh1SHxQ9d2x8s9KetFm+tacn7cyPGXDvgToA1OcmVcSuArEd/viHtGKTk0OHbX9r4qP0BZVC9fg/GP8rQJAQSdEjyjWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuLEr3d2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuLEr3d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054AAC19423;
	Fri,  3 Apr 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257861;
	bh=p/jTlfNCs+/luZ9Mk406r7bskYTlCeoQVVIsHGRy2BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UuLEr3d2aCZmCrJ8yyw9ogHKHyDjH008uzlSKI0bA+fVqnxXToxeZ7C1WNBS9WErO
	 l8/GwjxiTMTDsVc8kyvAY6xQCl++x+8tw27DZPvS7hP8yGVpt9FEt5t6O3tDhS2fk0
	 Y5c3m7PSa/7NZRaaGDkAvFrpYokpcDj8wdUqOfhwiBjQZIVdyrR29KgSHpeCEDiFZm
	 fNr/l/1HxsQpxzciVtLBM2bzp2kGGvBFbBWRX3aSAEWFMMvS0uks0fdUva/gachnj4
	 rUJYZtOzHja26hUOg/Ql2RIOvfZp5UtxIvda2XNhrA4fz6uJDexwJwUtdK0CKV9/0F
	 3Ts5gW0FvsBmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3243809A14;
	Fri,  3 Apr 2026 23:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: macb: Remove dedicated IRQ handler
 for WoL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525784228.1484550.17207546456531120252.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:42 +0000
References: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
In-Reply-To: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 02 Apr 2026 21:41:21 +0800 you wrote:
> During debugging of a suspend/resume issue, I observed that the macb driver
> employs a dedicated IRQ handler for Wake-on-LAN (WoL) support. To my knowledge,
> no other Ethernet driver adopts this approach. This implementation unnecessarily
> complicates the suspend/resume process without providing any clear benefit.
> Instead, we can easily modify the existing IRQ handler to manage WoL events,
> avoiding any overhead in the TX/RX hot path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: macb: Replace open-coded implementation with napi_schedule()
    https://git.kernel.org/netdev/net-next/c/dc3bd465ea36
  - [net-next,v2,2/4] net: macb: Introduce macb_queue_isr_clear() helper function
    https://git.kernel.org/netdev/net-next/c/5986ff6e4136
  - [net-next,v2,3/4] net: macb: Factor out the handling of non-hot IRQ events into a separate function
    https://git.kernel.org/netdev/net-next/c/6d55ce805b26
  - [net-next,v2,4/4] net: macb: Remove dedicated IRQ handler for WoL
    https://git.kernel.org/netdev/net-next/c/6637c03f35fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


