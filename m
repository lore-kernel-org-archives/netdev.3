Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB29443A87
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758257; cv=none; b=Rs7+EFWUBPiFo46+ZIP/iGVDLyJunrliLFNACsyZleMflfGeriLdQWOGLHOe1Ia7ra8ukSMOJTjWANhGgxSU0Mjqmjsb12pOmrIjA8E3PthJSDVdRJt4TEEIx6u86t+t6K+aBZekdwJlHSZgU44PLCb3FMq2NI4cR3+9URfqOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758257; c=relaxed/simple;
	bh=UUQLxUTxaXR+kc3krkJMYfT9XbFJo16QziLLcIWSt/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tt4+tDiuE5TCvSpFMehmCcnF54aP+JI79ectFPgHlutI8FPa0xJMqzpI6rioPKPjEs9boKjYLHGBoUm8DC51xUYDTIishmhOSWyqkRuW1Mj+voXF6Htl6sGD1nzajqFUoNwigb8JhzU2kLmj0cRiwUaXWr5VuJuCn9HBWR94qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3KhiF6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3KhiF6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8911F00A3A;
	Wed, 22 Jul 2026 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758251;
	bh=8dLlUlSczsrnuq04Zv1RObdV6pNDxOHdu7UYYfjIYP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C3KhiF6SA8MLnGW2ojQZtlXEpv8y9vmWUyTEkA+hGzj0NxJQxOTszkvAEEAM/8VOm
	 x6BJOrU4Goqj7HIba1XmDBHX76fXsj4cjUyrvZgeEQo6mZCL2naMXxrTdPwKQgqNJn
	 snjGhJGnnGm6hh6RBkZ1WrrHU0AZrN0zWpAAsuw4EikRCvGpr2ueerSM4yC/5YIb4Z
	 pB6EGN+LCoQVOZfn1ml095ri6wIMCQ0zWRg0nxDxbEeZ66oJSShVsGS014JBiMyijq
	 Lwl3NZRiHBP2k+KUVES9p8uMpChymS0ruzILQgrApMSet44rFjcKPpHjr4NMyay1tC
	 cuxVeNtvB5RZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93954380CED7;
	Wed, 22 Jul 2026 22:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sxgbe: fix null pointer dereference in probe
 error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475822014.2043959.159872199675811093.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 22:10:20 +0000
References: <20260717091423.1557737-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260717091423.1557737-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, zhaochenguang@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 17:14:23 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> The platform drvdata is not set until all IRQs have been mapped, so the
> local net_device pointer is NULL when IRQ mapping fails. Remove the device
> allocated by sxgbe_drv_probe() through priv instead.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: sxgbe: fix null pointer dereference in probe error path
    https://git.kernel.org/netdev/net-next/c/1df10cef2d1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


