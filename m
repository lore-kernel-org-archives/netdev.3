Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549219;
	b=P5tV9ONM4T7c2jcbAocodtIeEeWg+tFEusqnPvOyIfjrVh/DNrdVa6nxq1IM9lnSWDKP
	 sN35Nm7Mye4F1TPQ2iaHYLgYpF+Fk2A+4u3UHUmHHL+/F+ml5ZOepa5cdUMrTXdhi8jL4
	 aVCTYRORgsZMHQo2scexUmjh5OeOBKyARneKdR+uOVcAvc4BK1J7WrhBAZ8u9Cyakiefu
	 B/1+aQU9gE9DMsUAgufVWB22OFZz8dRD7mWGaNL13RJYbQdTpz5v12Qz5nOYbeuJfucvy
	 LoQ6bx4apSRRDqvI2wXvFZ7Jjek6xHGEMz+Jhmj/TlSntsYYDGmQJdW4VM/KTaEuMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549219;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tSZEsGT7HQvSIhpeOCsU/+2FlIHh8VlOvJasCAt5WII=;
	b=NokK578/VweqePj/lN4InyQZr6VeK9wQZF1DIH14ESf6NH/nzxMNVAJ44dUIm1g0MGzH
	 HxM1chngmpLlzFGuoY9WxOY6pnTNzHmGgq8tRqomZ2KZ+B7fF6lY4fTLN7RK6F5d6ROR6
	 Rlkfd9pw49IOQjgXI9YLUMxxI1Qmqo+mbP2fpK4gkpPkO9WIljpKDd3KhIdsfaWClV9HS
	 6Vp4+CQeQ1bVRDFQ/Y0qUQwdciLNisdCl6/oBbpvcubQCuL8iKk7y7hX6O3kB19XHk/v3
	 OjYxk3uR72kmtMirVXHKZPzxbIC2P3Ol2qPXRuD0i8rMfLiX21Y0pL2TObtQWMWQXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWTAoNJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F9606A31F;
	Wed, 21 Oct 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWTAoNJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FEF1F000CF;
	Wed, 21 Oct 2026 02:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549214;
	bh=tSZEsGT7HQvSIhpeOCsU/+2FlIHh8VlOvJasCAt5WII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NWTAoNJPjrljQgpmbFq8a/G0bCdGDrb5yTNjgl80ua2w1WldiHc9ON9SgWQdN9J+b
	 JaBOxy5i3Piui61LVSLNc1HLWOOPUWMj2m4lBixhZyR9Ucs2+f0+9qPvRoN1r7AS5v
	 4H45S3MlgS62jJyE/7JVTMdFTmeeQbDFneMhogfLhrOu9HgGvQWTSF00Z6dkakKdg1
	 iGUvXTdnqLljjOOS0W733YiN0eCeYhFnlGeXTwXX58ZuHzN6n8d2mcgN93lv2ohKD+
	 uMPs3+apOGV15JqDT+1MGYJttN8s9uFeEFCUOwv6r1GbK3b6H17hM6/Jqh5nFEhTZF
	 ZCCm8qkEaF87w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13713809A0D;
	Wed, 21 Oct 2026 02:20:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the
 controller
 notifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254921255.330607.5425473501621725490.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:20:12 +0000
References: <20261018081853.47484-1-github@szelinsky.de>
In-Reply-To: <20261018081853.47484-1-github@szelinsky.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 broonie@kernel.org, lgirdwood@gmail.com, corey@leavitt.info,
 kyle.swenson@est.tech, horms@kernel.org, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Oct 2026 10:18:49 +0200 you wrote:
> These four PSE core fixes were part of the "decouple controller lookup
> from MDIO probe" series [1]; Oleksij asked to split them out. They do
> not need phylib, and each one fixes a problem on its own:
> 
>  1. Unregister frees the PI data while the controller can still be
>     found. Take it off the list and stop the IRQ and the worker first.
>  2. A failed registration leaks memory, and can leave freed power
>     domains in the global map. Clean up on the error paths.
>  3. si3474: use dev_err_probe(), so the deferral from 4 is not logged
>     as an error.
>  4. Defer the PSE driver's probe until every PI's vpwr supply is there.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: pse-pd: unlink the controller before freeing its PI data
    (no matching commit)
  - [net-next,2/4] net: pse-pd: unwind allocations when controller registration fails
    (no matching commit)
  - [net-next,3/4] net: pse-pd: si3474: use dev_err_probe() for controller registration
    https://git.kernel.org/netdev/net-next/c/569b57762694
  - [net-next,4/4] net: pse-pd: check the PI vpwr supply before registering the controller
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


