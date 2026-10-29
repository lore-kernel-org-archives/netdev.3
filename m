Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234408;
	b=X2bN6DJIDJVTKiFdMPqOy/ivl04o1QbQTOJ503+Ev5/HtVl2Rgbb88ShyyQOPLGvYVoz
	 itT/ow84T4jhQIsb8/ObwBOhu7hNo1/1VuRjVLpYn2AHIvwFp3Bc+f7hZyQjdjpC9ByvA
	 pv+lMSy+Y1ywvbwGu1FtyahnnLyVjCGHpN0mspx/xitb4+el6Ubw04pw65iRSZMvAtEv0
	 gAUKudzgJt9hjdhF1x55w05oEW+N8RHkZIl31Z+CTEZKEeTx3D/S6+lE/ID3wbq3vSf6L
	 Sl0Ot3HJ6gBAb/NwFb7O+wOlYefPpckbxIXWnJRm8j9z2jgO/Wum3ibLb8z0cE74Cfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sIMaCih5WbMjIRBxJkMFuHw8dXwDEekTQy6XcIdsZew=;
	b=VswXYV9gH6eeDRD+ozjWLi4wQZycyYZRDOllWq+t8mwWugS93Q4ryiWMMJIowCpp5QAy
	 UvzGkGLhNjbglUjBLnH5nA2l+W9I7QWvr00nIrHeeMaWHaGXaV3D8F+/OcLeRftmCGr/a
	 PqUjggmXQiwb/gdfuyaSFdsA1lVrbQDxSnP5xQU6Jk2rAOnEpXEYk4bGfA6lYQcD1rO+f
	 IikjARNQJToTM2DYB4PNr9VdE5ivAIYDOT0K3gxNcTBDkDBDdWlRe4WvYEzktM+A9esg2
	 QNtATzroPgEbsraV4lsq72AtEQAK2kSe4DRGduhS33NWr+bUeXq0hcNQQoQHp2hFVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5CcoCQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96049606A31A;
	Thu, 29 Oct 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5CcoCQE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C721F01825;
	Thu, 29 Oct 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234408;
	bh=sIMaCih5WbMjIRBxJkMFuHw8dXwDEekTQy6XcIdsZew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C5CcoCQE6aCh9KUijWnl/0t1EDUoArz2O1JCw1RhvspvYJ8VAScyHujyzxEiLtkmh
	 QWKa4yOhXqfToWUfKEyJpxgFFnZSgQTI2RWSPV5y3Nw6eu/17+9BFP/ahsIhCKZJHa
	 G3uWnh8r09b1CbyC9hqxxqexKkOFIzk/dexYD7TYrWk6jq0pkCQ7lKje6ZouTUiaOM
	 eegajWukua36O8UQJVHkfOzNjBT1IqjFK/+SBoPFvhr3GrlT5aDuMQyene4Ojn83kE
	 U4jXvPLSWCkA+ptKcQM/eXPOh3Gui6gGU23idznYfy4ErqCZnhXILk0R2sHYjS2KYM
	 LfWjpcFQ3z3zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0752D3AAFC4C;
	Thu, 29 Oct 2026 00:40:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: usb: cdc_ncm: add Apple Silicon MacBook Air
 (05ac:1903) device ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323440682.1500896.2425926317481165612.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 00:40:06 +0000
References: <20261024122051.14427-1-divyanshuj2006@gmail.com>
In-Reply-To: <20261024122051.14427-1-divyanshuj2006@gmail.com>
To: Divyanshu Jha <divyanshuj2006@gmail.com>
Cc: oliver@neukum.org, netdev@vger.kernel.org, nb@tipi-net.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Oct 2026 17:50:51 +0530 you wrote:
> The Apple Silicon MacBook Air exposes a CDC-NCM interface (05ac:1903)
> when connected host-to-host over USB-C.
> 
> The device tested is an Apple MacBook Air (13-inch, M1, 2020), Model A2337
> (MacBookAir10,1) with an Apple M1 chip. Unlike
> commit a5148bc2fa27 ("net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk")
> which hypothesized all Apple Silicon Macs share PID 0x1905 ("Mac"), this
> M1 MacBook Air exposes PID 0x1903 with iProduct string "MacBook Air".
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: cdc_ncm: add Apple Silicon MacBook Air (05ac:1903) device ID
    https://git.kernel.org/netdev/net/c/a8d0451967fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


