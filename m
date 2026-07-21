Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D37481A9D;
	Tue, 21 Jul 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629843; cv=none; b=W20YbQvMgeDMjTJoNfJrDbubT6EEFuEDOmHEUP5KuTpK8libGtvRwmOKWk8SlaaM+63yit0XR4eedxFeuSRv4OKWwPc44p7m4PV3GgARofhDpGH5JM7FP7CJooGs8FMG0v1q5uPRt/OvQaRMcygTo+G3bqQU03afn0+hv+BWBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629843; c=relaxed/simple;
	bh=nSwnXGt5tfQ1iv031q3NYnVBLfc5nkML+XeRKWoTjrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pV6duva6hKtBcaQKqKVx00TiBxs5sISX1yV23hi3Qe2x4JyI4dFqXvIdl4d1hfDFquDKdnUbTtPcSE5Ii2mF/G8+ZVM4yEP+BfOSgNbbdC/7/S2SrWsHTBDW0EQENaCf0JKpJxBp0VZRWQOZjhyrWUZyQr5lGslSqZmrRr7Sg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLjbglnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLjbglnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985011F00A3A;
	Tue, 21 Jul 2026 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629841;
	bh=/kCpGbBQOsIFYhL9J0jGNBRq7TslxJN6dK8XcAFZzEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mLjbglnOVm8GIMZ/r2nRgOAUMuj7wgujGpS5RJ88JI871uvM+wQsrWlNcSUO9LT/E
	 JANZND8tsxUIr0lgpDridzUxP3YR7Z9gZ9gHYUhfYjivpA/PzzuAub5RztYBMX8Egm
	 GaOwyPn4zBU5zN4uL1e2MlvjMFOEEnwjV5JA1cKz+A9BgB/pCyMhhpG76b0lm+ImhC
	 6/zeeAOsGHzNribtWIFAhfl5yVJ6klXtxgkMxO1n5sv/h9QXKtNON0ooaZLggR0MgB
	 opkqPINSAJXP4KoJk4M1OMCl6V1xfcBVG/MgChxYMPK6rpk8hWOvHy+H8CABo9p9+A
	 KOip16TefOkrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CD3924A64;
	Tue, 21 Jul 2026 10:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-eth: put MAC endpoint device on disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462981114.215603.4041945326382461837.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:30:11 +0000
References: <20260708111738.750391-1-lgs201920130244@gmail.com>
In-Reply-To: <20260708111738.750391-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 19:17:37 +0800 you wrote:
> fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
> taken through device_find_child(). The Ethernet connect path stores that
> device in mac->mc_dev and keeps it for the lifetime of the connected MAC
> object.
> 
> However, the disconnect path only disconnects and closes the MAC before
> freeing the dpaa2_mac object. It does not drop the endpoint device
> reference stored in mac->mc_dev, so every successful connect leaks that
> device reference when the MAC is later disconnected.
> 
> [...]

Here is the summary with links:
  - dpaa2-eth: put MAC endpoint device on disconnect
    https://git.kernel.org/netdev/net/c/b4b201cc93ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


