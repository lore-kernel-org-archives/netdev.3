Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972129;
	b=rm1ce9UoAZr+6GniUExHDDKn7g55122u249hSz8jbPOPLkHzaud7PUeip2H84eDApFV/
	 wqGWy4RrP1iWp4nGvowfJX2bibQko+q64ZYuQMxEYrYiAshuDcYyFipLfzpabwYxFrrs/
	 PBmYc2VA/i7mcbCsuGyPztbgnNiqw5O9IsUE3NFEtlaK1sphR1V9QTV0yH4Vq6qwnsQKA
	 iWhy/74hH3vAOGu/OHvCObl0o9iIi9H80iY3NygPuHavQFYmCTHSq+3IutJcyK/N+vrPa
	 LZxdqpDVQ4dhXGucULdMjXbwgUiT7wtn5c4TB5q1saCySryQ8iGOdbb30Buazbdq8wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972129;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fohuWXyq77Ss8QYfh4jv6v7E27bHAfRVMXpFhoQ08go=;
	b=Ae9CG3n2qH9FGzOanc1PEfxUry5sXD/dpmPeC/zHHWo3gTsmo96Orbh49sy2ZCtkauCx
	 tZrShhz2cSyVweRErLXXM96QR2nukFclTRSRkRZQ99cY4GyMi2ZEYH4cUDBBlyY3613hi
	 w1gNLUeHl1GVZy+lKntdZ/Jk/hfWPs4tlEUl4zkzTZR6Vrpzr4coFrL+AkSoo6YSwQyph
	 3v/vt1vVGHa/EOipHvAuarM8tDlAE5SNOXgScyhS/n0uOEn/O+kYoAUHjIYYC2tAm2g+q
	 7w+836OGpauqU5EVwOSmREaw9cNLNExO4FqD/Qm5yyP85EopNkY/0jm5JDNs9N/OQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKX+LDI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD5606A326;
	Fri,  6 Nov 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKX+LDI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442C01F008A1;
	Fri,  6 Nov 2026 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972128;
	bh=fohuWXyq77Ss8QYfh4jv6v7E27bHAfRVMXpFhoQ08go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PKX+LDI2y+5KgLQ/KPBy9kZygwh6GOdQyFOlpdYq7Pim3zDIR2xznEwuhs/0Xt8kN
	 sjVtgXnnYyQdmxWmDzMMODK/4VEMqAs0A6KemFFmChFNCQNnfXXYuhS31bydfuDp56
	 0fGnpGftOnXX9FWzeNKuyUvm19AnVorQ67WHEOrrIPxMesK96LcqgABpcJZOfu8M4q
	 7JUV1b6udqO8uhx+0ZcmSBNDqDA78Hbbum5//zDixYEKNt8sCx94QAAe8+2XI38f5n
	 y6Ud1LvJJDD3TdC9J26wtmDIa4rqDTROzqN9WTHUQHU08BX+pKzT1aAKoYFdLzBMIe
	 7fcVd5kuvic0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2663930E6D;
	Fri,  6 Nov 2026 12:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/5] net: fix misc signed overflows caused by bad
 sysctl values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179396760723.585103.10973765623205620658.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 12:20:07 +0000
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261101061331.286404-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, dsahern@kernel.org,
 idosch@nvidia.com, tglx@kernel.org, joel.granados@kernel.org,
 fmancera@suse.de, petr.pavlu@suse.com, kuniyu@google.com, willemb@google.com,
 maoyi.xie@ntu.edu.sg, oleg@redhat.com, zhanxusheng1024@gmail.com,
 gerd.rausch@oracle.com, razor@blackwall.org,
 chia-yu.chang@nokia-bell-labs.com, bronzed_45_vested@icloud.com,
 hannes@stressinduktion.org, fbl@redhat.com, pmladek@suse.com,
 paulmck@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 14:11:58 +0800 you wrote:
> Recently I have reviewed quite a few fixes for variable overflows caused
> by config values, i.e. a value set from sysctl, module params or netlink
> that is accepted as valid but later overflows when it is used in a
> calculation. I believe there are more of these still out there, so I
> used an LLM to dig through the code and it found the issues fixed in
> this series.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/5] ipv6: restrict gc_elasticity to 31
    https://git.kernel.org/netdev/net-next/c/3ff59dd75d71
  - [net,v3,2/5] ipv4: fix shift-out-of-bounds in ip_rt_send_redirect()
    https://git.kernel.org/netdev/net-next/c/26627b7bf8cd
  - [net,v3,3/5] ipv6: restrict mld_qrv to 255
    https://git.kernel.org/netdev/net-next/c/6d6bdc1b943c
  - [net,v3,4/5] ipv4: restrict igmp_qrv to 255
    https://git.kernel.org/netdev/net-next/c/0bc7b5b2985f
  - [net,v3,5/5] net: restrict message_cost and message_burst to non-negative values
    https://git.kernel.org/netdev/net-next/c/75f5722df2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


