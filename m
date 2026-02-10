Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D67319859
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725409; cv=none; b=pJ5zue+2TLQl6GcMAeTgIa8EdPdVte9EOM9jualT4RYKw6CkxfQVxWZOE8F6UN8aIrMxCb9TlYdS/Cd4VpUFBP7zYYCT8TOLvvj643K8gEioVhNwPghLj2i+PKn6bya4ybgQZIL7wSt10DZfKs9RYUrx6oVf1IShqOx65iDXN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725409; c=relaxed/simple;
	bh=W0lRLv3dgLpBNbvyHZlCcCL5DZpH5OLD7mZTWrJ8GP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZMXWrxYMxBW3t9eNroEP4U1zZj6O9vemeGsZ0IKTjguAGLNo8RbwMQJsgjlXgLrEcNiPzuQ0E36e88Ye9yZMlcgty1JsLGBarqC1MO99dUv3Fqnbo6DBNgwaMaiQmBByJVeS5eeBzYHxv+JIdJIh4LdtSjQ+9yU5hYNR9MnxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2Len3Xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2Len3Xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB38C116C6;
	Tue, 10 Feb 2026 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770725409;
	bh=W0lRLv3dgLpBNbvyHZlCcCL5DZpH5OLD7mZTWrJ8GP0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c2Len3XbppKGqxOnn2clnOQVaxjfv0Fa6l+nECPl9geexcPveWwRFiSjqilGsakkg
	 R19s+dACv9I31i2/cqpL9EMr2fGEwmTv+gTAFf/X4eRr8Ch/dK8G48B/Gm6wcgNybG
	 V7QzLn1+Stwg9W1n3ugcBQ4fFmKat9X+hjH+CI7Em6g4GuKZ/yht3woVkpRzKbpkwV
	 GcpuxxW80wO4gRRQ2oFvdpsvNHYXxHP/W3jm/MkaKj31Nj/IpetCx8zpD9jRw+BPVa
	 VYa4FPYBNUswSj92daxpHDnUwz9ldYwyGebesLhtbg3oqA/uTGM/LOoDubs890IKDe
	 U0rYpW9/FobJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C235A39B167B;
	Tue, 10 Feb 2026 12:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sunhme: Fix sbus regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177072540458.3487138.5351759477423408920.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 12:10:04 +0000
References: <20260205.170959.89574674688839340.rene@exactco.de>
In-Reply-To: <20260205.170959.89574674688839340.rene@exactco.de>
To: =?utf-8?q?Ren=C3=A9_Rebe_=3Crene=40exactco=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: seanga2@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 05 Feb 2026 17:09:59 +0100 (CET) you wrote:
> Commit cc216e4b44ce ("net: sunhme: Switch SBUS to devres") changed
> explicit sized of_ioremap with BMAC_REG_SIZEs to
> devm_platform_ioremap_resource mapping all the resource. However,
> this does not work on my Sun Ultra 2 with SBUS HMEs:
> 
> hme f0072f38: error -EBUSY: can't request region for resource [mem 0x1ffe8c07000-0x1ffe8c0701f]
> hme f0072f38: Cannot map TCVR registers.
> hme f0072f38: probe with driver hme failed with error -16
> hme f007ab44: error -EBUSY: can't request region for resource [mem 0x1ff28c07000-0x1ff28c0701f]
> hme f007ab44: Cannot map TCVR registers.
> hme f007ab44: probe with driver hme failed with error -16
> 
> [...]

Here is the summary with links:
  - net: sunhme: Fix sbus regression
    https://git.kernel.org/netdev/net/c/8c5d17834ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


