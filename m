Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674433F8BE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371458; cv=none; b=kXSgV8FrQRnNqWm3QfJoei+eIa4O8OODFYW1wJRse7BT7K6SNogDsAZzq+h9lN7GVxgqx3IEHTI7j8Dj/1qvAu0oDI8dyW4riuG7+nNV5+wRgTjvQRsM0WBg7Kof81e3ii1OZVnFek6IpxA9ASmVpwbVsVbCDP8boAt8Y2/aliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371458; c=relaxed/simple;
	bh=9LywR6m8fABJtLd5Fse9TODCDuL0dQFJlfcluqTAlps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rzXK5drmSqQpYtsIFzWjGGurzJ1mGAN9okT5cn0T2+VPeRn9OkJ8M27dFLMyi6Gzl2gaOp1yjhQERQOJb+gPAtmXnsdcCokDsFNzdy+hcw7OKYdCWykvelP64b/5lj8Rx/xaV7aDXjskPn0tZ/JxdeEeIrqIWSPC6sYUoJM55Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW0KQ2wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW0KQ2wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A851F000E9;
	Thu, 30 Jul 2026 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785371455;
	bh=NlloNg5mOpQXimdtQrrQhacwoGzu1dpc6btZHva9d70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mW0KQ2wYm6uxE5RN9m5bUgm/xhza34Rxrug7iUZxUflZv1bbOV0Z9X0yLlQyQ95mf
	 V1iuv61iaCE9s0A1poHCPzw8LOqirM/kwaJ2KmBzFdD0CHWIvJ2lDxSH53QU8PjrKL
	 ytLidV0kHjH4smbficUK6n5LqWlkroI5S2wAQuiTX8Ew+VdJirqifqfqS/70FNcga+
	 q2WLVehszo3lLNdZEYjvffuhfhLUsl0wms3JWkmE9C01Rxgex0NIJJQRgAYrY4ahfy
	 /NX4peRvJF9EE7H1kTA3EuHyG7DEclV30dxwcVrmlYzJo3Auf8/m1n/MMbHMGCD1zF
	 eW81XbaaIvwEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FC3926251;
	Thu, 30 Jul 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates
 2026-07-28 (idpf, ice, igc, igbvf, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537141964.3296803.9033446911621307576.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:30:19 +0000
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 28 Jul 2026 14:08:57 -0700 you wrote:
> Michael Bommarito adds bounds checking to ensure interrupt vector array
> stays in-bounds on idpf.
> 
> Josh adjusts minimum value for Tx ring descriptors to prevent Tx
> timeouts in flow based scheduling mode in idpf.
> 
> Yuho Choi frees IRQ name in error path to prevent memory leak for idpf.
> 
> [...]

Here is the summary with links:
  - [net,01/10] idpf: bound interrupt-vector register fill to the allocated array
    https://git.kernel.org/netdev/net/c/9f7007ee9858
  - [net,02/10] idpf: adjust TxQ ring count minimum
    https://git.kernel.org/netdev/net/c/bef152db47de
  - [net,03/10] idpf: Fix mailbox IRQ name leak on request failure
    https://git.kernel.org/netdev/net/c/9bff30482c10
  - [net,04/10] ice: wait for reset completion in ice_resume()
    https://git.kernel.org/netdev/net/c/c2816d613f38
  - [net,05/10] ice: fix VF interrupts cleanup
    https://git.kernel.org/netdev/net/c/fb096882095e
  - [net,06/10] ice: fix memory leak in ice_lbtest_prepare_rings()
    https://git.kernel.org/netdev/net/c/3a9de5590da4
  - [net,07/10] ice: suppress DPLL errors during reset recovery
    https://git.kernel.org/netdev/net/c/b00be7c6b4bd
  - [net,08/10] igc: remove napi_synchronize() in igc_down()
    https://git.kernel.org/netdev/net/c/5ffab5b9589c
  - [net,09/10] igbvf: Fix leak in TX DMA error cleanup
    https://git.kernel.org/netdev/net/c/0565052b7e2f
  - [net,10/10] e1000: fix memory leak in e1000_probe()
    https://git.kernel.org/netdev/net/c/816419dfea5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


