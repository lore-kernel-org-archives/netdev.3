Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177406;
	b=SjqIcqsGbMfYya6/uP7cWGlESE8CxBEbJ754vRvEJHivDlZhZ1Ss2cEJj3oH/vTIjV9V
	 r3XVZYbSvLMzbwwTPirjGfURTbyUr+MaBdYuEHqg/Oq0owH0jf+qtwWLvFnqMYkXrSzp7
	 lR4qxLljKjuxCP1J6t+pjg1+1ZcbZa6NtCQCx8zZwZUIlGRktBbka6OzAB8WskyheOXwv
	 7l/HcYN6ztrqp+QqEIFOq2cCjUEaqHbRWgVVLF2s6M1lqX0G7j6LKSZ2sgMFYnubYotzF
	 z4HxvTKTeVyvdseqQ/FIvix9j+QRA1a44RW6tyroRXyfe3GGsV93fZw0nAez4jKnZpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TnCmFNN61rfZljZyq8oIidethrdD8OTEnQRhzssrqzg=;
	b=EQkfxWAhH810ezFco7vfaxf+I2UYoNyRO/ItjxVXOdHaimI0a1JqcSW0UB9Mp9uxeuUP
	 Kh0cmVZglgKyztYVj6ElA/i08+oH5iZSYDI55CAq9+UwtDdHX/4ggpqGzUNVjENi97/aO
	 ndeGkVoRz366fOJ/py406AOWB7pFUPlfQkXN36GPv3laVKWvhq8fwTCeN7YX7CMu48CDI
	 Y6zbPpPUsf31SlVn5urQ2/fu5UIWCoG4Z5MT4nBJKX3PJtXpwRgzpNiXKxxFFWEjBgr3Z
	 G+Se8m2KDFlS0l/pd2rcCv1+OyODrYgz6YasxZpW4Sks4m6Mz5t+if1on2Aj1pg3j6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEqVgown;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28693606A325;
	Wed, 28 Oct 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEqVgown
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C689D1F031EF;
	Wed, 28 Oct 2026 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177405;
	bh=TnCmFNN61rfZljZyq8oIidethrdD8OTEnQRhzssrqzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iEqVgownJdHBb5bp9aNUipa5HALvAg9sgMnZoQt0xTfLYE/bLVKfjRkgT15aEGSd2
	 LJ7EYq5CivJqiWmN1csszprORDYeD2L3Bu6TgGsMbR4poJ+A0JxmAWrwktK54VrDP/
	 5L3wpXma6FCLtWNxURnpTuiYuWVycYnhkypZEoSsUt9yzz0LpEW0P+LE5uOWeK40ff
	 JSbc93MJU6ZWAP7DizzQO1HAC6oPL3/TDJLXmWwmeCYFHWmt+sKfqPrcuY0i8HrjRl
	 wGkwjmAkl7QnjFSWyfqPNt3a4XbKBYKvlLvCmyYX84njVsYDniZXgDW9w9Tw+VCS7N
	 o3mq7+BCCVn9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE7643AA9F7B;
	Wed, 28 Oct 2026 08:50:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tls: keep TX and RX hardware offload on the same
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179317740457.586826.13676893511407745921.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 08:50:04 +0000
References: <20261020214500.972308-1-rjethwani@purestorage.com>
In-Reply-To: <20261020214500.972308-1-rjethwani@purestorage.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, borisp@mellanox.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Tue, 20 Oct 2026 15:44:59 -0600 you wrote:
> After TX is offloaded on device A, a route change, or a change in the
> usable-slave set of an 802.3ad or balance-xor (layer3+4) bond, can make
> RX setup program device B. tls_device_attach() sees the existing TLS
> destructor and keeps ctx->netdev pointing at A. The RX driver state on B
> is then untracked: tls_dev_resync() and tls_dev_del() are invoked on A
> for a context it never created, and neither socket close nor
> NETDEV_DOWN on B calls tls_dev_del() for B, so the driver context leaks.
> The reverse setup order has the same problem.
> 
> [...]

Here is the summary with links:
  - [net,v2] tls: keep TX and RX hardware offload on the same device
    https://git.kernel.org/netdev/net/c/1c8a70075235

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


