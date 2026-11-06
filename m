Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000606;
	b=XPo9hRPvHYpXkxcswbgrINyB6Q1g9+7UCufetlGTw05V8WuVF/ZBKoXwnXOKAt+aKoLp
	 3tIp9jzAwKAk55OwcrD7ISkdZFryToQqfJbVlyzr/B7QRFuqFFyeO8T6OY6MO88zYhp0A
	 GcTixzmkXBnVIYdJLtOz8yryspExb50w2LUrlqlTuQ47XaAoIhpKDZeE+pxM39IJarm21
	 6gYnZGQjk8N9t9u6agel1+kl/gQhVbjYcJo4lf5OMry56aK8NGINU522GGsPQ4gCv0X4P
	 OMyWxOxWvlrVmFTv/m9OKq5Tj2rys6ArfuN2cYuzyOrLUjy9bMy4Ku2phXWTFoPEAxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4CgnqH7ekGvYe+n0a5qLsnJYa7U8r8mohWy8/3bmXo0=;
	b=Xt7qvs5ilLqj1/Aa3iXAQJ9GdwRKUPgqn1K3zgu58Bbtc0+ZluKjOGeXkgYz8SRwX7/s
	 rN6ss6Jt/2h/mNB5jsEHLegDG8zlhOOUCcDCgX/t/w/sVFe//17CPHmfryPL0XD9VunHZ
	 Teby5lI2cFkWvPmS+HEBtIw+mLrDJfDcE3Rt59vTXsp0s6yjXU8TZK9HLLdG4LX6rpOyr
	 HpvnD+G0rQ6QAmLRPf7IYc/l2Y5ILTs5Tt+OrIdWjswfdIQJSVe0HvRF2270aaInHSD23
	 STWbZezfu0EPTgAksr++lYRV6ccu9QeJkjK1t9InJWg0ydeAptABQ/SvrAzV360Js1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANHrQy9M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6B606A333;
	Fri,  6 Nov 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANHrQy9M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48BF1F0089F;
	Fri,  6 Nov 2026 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000605;
	bh=4CgnqH7ekGvYe+n0a5qLsnJYa7U8r8mohWy8/3bmXo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ANHrQy9MNPemXQYEopKJNU5K6vnsnWbxyrbsAaFp5tS7/XZg8SJFrgpCvur1y9lax
	 bxOtPe65gaKTVK+hlMT25ZEZCHzHFGK0VMWLuNMyRree8FxI8H5UWdt1dndB6gBozJ
	 uhR0LsltZsIfB6CJvkEMbgYvZ2JJIaY3focq5GFhfcTgfLY1n3auyhRT20yWLrvXj5
	 Ygf479lNsyRVsS8F0a+H0s/gL3URGKW3dmNch7eFt2g/CE7whoAffsdkuxgL0G60gv
	 HccrYBzK+HmobvflCIhtPUd8LLidSEWj7kVV8t8VVMiocW+nY/A4GEBY8+qmTWkkC1
	 WAoCGQVPP14aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2CA3A4161B;
	Fri,  6 Nov 2026 21:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3] net: usb: lan78xx: fix error handling in
 lan78xx_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400060443.882790.16081277711944956747.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 21:30:04 +0000
References: <20261102211119.8738-1-stefanomunari.sm@gmail.com>
In-Reply-To: <20261102211119.8738-1-stefanomunari.sm@gmail.com>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, nb@tipi-net.de, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 22:11:19 +0100 you wrote:
> A failed interrupt URB submission leaves NAPI enabled and EVENT_DEV_OPEN
> set. A subsequent open enables NAPI again, triggering BUG_ON() in
> napi_enable().
> 
> Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.
> 
> Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
> With the fix, the injected allocation failure returns -ENOMEM and a
> subsequent open succeeds. Verified connectivity with ping and SSH.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: usb: lan78xx: fix error handling in lan78xx_open()
    https://git.kernel.org/netdev/net-next/c/1134247a3ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


