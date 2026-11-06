Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999410;
	b=QKDFQADOKCJHXD5tTZ69tsvc0UNZFVwbbA7IuVbmYdu4ydrDfajDIwEHsgjsQt8r7NjI
	 TnQ5OzvwzLH99rJMlD61OJ0l8e768SEwQymT6DVJAFxb1rDNVyjstZGk3RwNeJIGRFnqG
	 93oYpyrKquIwXEs8SlG7vZosedS9tuDF50j+R7Um/rDlKvG7sGFddyW6uowZYU7SnXkdk
	 qU04d/H2bNAgCpyrMyQ7yL13+h+8DZb4qDLRUJOKhhzMOSlnROsBrL8M5hfF1V391Dov0
	 xulxkXOaPffzBWmo2Bkezge5zyukBfaXbEymGVXt/jk77vhGTM8Gn3uQw8S80j7B3Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IFK4FXq5iIDucyTZ9nFE39jAX34L/Yd55I3Iep0xFMQ=;
	b=Zde+aM5FTHUT2XVbRy2OdPyIMWcsubAELSm3Flf/nmIcJ2WuDzwA8CYm168eFtfSDgGK
	 GUkwu4keAZpLeVcMStfrU3lvRlVlfRUIPlL3d++F28HIdLsCv5bqbAynrW52guCWcTy+F
	 cTRUNUinmc/XJKTZZyR3/eAIkrT2o0VurjdOi/ZCYzyDugpSuUcf7cNX7nKgEZcWuBgRv
	 geh9mBjNZ1kf+1ypyAcnzp3XthhQFgKFqqlsDDQTHMpygJufkn0HgVCRl6yj9kw2kJH4S
	 vgLQs2dCCPclrqwwddQXxzNYdUuR9Vv02gGO3wVU0pdFe2BuQ8CPvBFlCEca+klm32Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFOvDEyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B0606A32D;
	Fri,  6 Nov 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFOvDEyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B77B1F008A2;
	Fri,  6 Nov 2026 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999409;
	bh=IFK4FXq5iIDucyTZ9nFE39jAX34L/Yd55I3Iep0xFMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MFOvDEyI8L73AgWZxSm+fMJhFYIuTCxGs8PjZd+4yJScWS0RN1gpkbRCWGEIYqqtC
	 fCxHJKn4jlWmTJMYgJQsjMMF8gYXO2sPRyQ+eF8jl1DnSoG2/GuOAOXcYWq3/F3PRs
	 2ucBw5+RnN9JT3c3nR9ix4o0w0Tmhxd02EgL8oMXEYwgIPZIzv9FSOkOpYkCewxHKO
	 NU9zS8D1f2Q1qbdWcdCmyI7pnKAjfB+ML6AGCWtJVUxL63Q9I/Wxr8kQpMAEuld7wf
	 EehN3j0fZm5595Qk3zCBMy/wIH7ZB/WnsbT9Yxrn3bJUq4DkaF4pqChSjtwiuIV9Rz
	 iIpDoYGD13zrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210D33A549A5;
	Fri,  6 Nov 2026 21:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5 0/6] net: Move system_long_wq to
 system_dfl_long_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399940792.873414.7235430116859175660.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 21:10:07 +0000
References: <20261102105703.111844-1-marco.crivellari@suse.com>
In-Reply-To: <20261102105703.111844-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org,
 enelsonmoore@gmail.com, haren@linux.ibm.com, maddy@linux.ibm.com,
 danishanwar@ti.com, mpe@ellerman.id.au, westeri@kernel.org,
 mmc@linux.ibm.com, npiggin@gmail.com, nnac123@linux.ibm.com,
 petkan@nucleusys.com, icheng@nvidia.com, ricklind@linux.ibm.com,
 rogerq@kernel.org, YehezkelShB@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 11:56:50 +0100 you wrote:
> Hello,
> 
> Currently the code uses the per-cpu workqueue system_long_wq to schedule
> long running works.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Another good reason to have this unbound,
> is the "queue_delayed_work()" function, used to enqueue the work item.
> More details on this will follow in the next section.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] ibmvnic: Change system_long_wq with system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/fc0f285bc191
  - [net-next,v5,2/6] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/d2ed709ff1e5
  - [net-next,v5,3/6] net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/12e337d448d1
  - [net-next,v5,4/6] net: thunderbolt: Move long delayed work on system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/2adb5e4c7b40
  - [net-next,v5,5/6] net: usb: pegasus: Move long delayed work on system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/733d1775cab0
  - [net-next,v5,6/6] net: usb: r8152: Move long delayed work on system_dfl_long_wq
    https://git.kernel.org/netdev/net-next/c/b3fcb84fdba4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


