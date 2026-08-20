Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9643BFE33;
	Thu, 20 Aug 2026 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254292; cv=none; b=SdI0BQ0oVDsRts0ou4CMjo+IIhj2ubQz6+gfG9eZhGCrzLkKQycaZ5CL+SRseaJa2c1IBJ4J66FCDB5deeO94V2+WXVnTlfbrZin4oxgstzwPVbVH8rQFypDtstf6Ri47HGTpjI7gBhTwo5GTOD6ZxrJLw12VhZAHQzihW8UeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254292; c=relaxed/simple;
	bh=YMSue+jM5S0nID0hfphljcsWBgtAOpmfWaTZc+o4lz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eU6D6GmisCT5C779s64BV3tBp10DykGNwbitwX4W/kPIpRbpaUhd1SrdDihyewsPZ/rKN/ks4yb8zcXv+ebcYPkTA/6SOyHm7N7Y+IJtPPcqQnf1fk7+FI9f6e87bHgNQP4uxpw42lEQuTeQa1KP67Lqgyc2P1+VDkR55BYV4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFJ/U54Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFJ/U54Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C121F000E9;
	Thu, 20 Aug 2026 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254288;
	bh=FExRagSkP4p2l5PRJY2ipumJEhenV87YY89Y8UolwOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gFJ/U54ZPObjIuvbb/eB/vyzJ7LY+cgoKGcsV+U7mdKr4xVMUHJhCDoua1F90+Nac
	 LV6GbPoWZRNLqXneTb6ILuIx2RohK+G04Oo3hdu/G3PMXBLaTj1ydun+0c6wajbKwB
	 zmm19IL84Qyo15YT0r92SfwWlHcFNd/RMnPJpfBH0Ilj3t7PqlZ+lYREXb4V4REbZq
	 DHkDTOob8ZXG3KBQZhRIz0tALjPyo8aV6zwopCGlWAz4+qHkQBYpmycCwT7ntWgEza
	 soxpTpHUtC0Y9dchH29VDabu4K2bECoYBH4pJ/NEenR0TNI6lWtFmnsoeXQGa0D5P1
	 wAwCXSQfUvEZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AA53924459;
	Thu, 20 Aug 2026 19:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: drop CONFIG_OF #if block
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423813.446762.10183326548358257074.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:38 +0000
References: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
In-Reply-To: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pvalerio@redhat.com,
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 19:08:20 +0200 you wrote:
> Fix -Wimplicit-function-declaration error on CONFIG_OF=n builds:
> 
>    drivers/net/ethernet/cadence/macb_main.c: In function ‘macb_probe’:
>    drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit
>    declaration of function ‘macb_alloc_tieoff’ [...]
>     5951 |         err = macb_alloc_tieoff(bp);
>          |               ^~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit
>    declaration of function ‘macb_free_tieoff’ [...]
>     5973 |         macb_free_tieoff(bp);
>          |         ^~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net] net: macb: drop CONFIG_OF #if block
    https://git.kernel.org/netdev/net/c/ec518a7c4ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


