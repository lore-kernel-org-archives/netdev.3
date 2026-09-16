Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C23220F2A;
	Wed, 16 Sep 2026 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517482; cv=none; b=O6ak7xSSJEA21+dfz+lLUQqeahohgD85ceJBqk8Q5Z9MeICaR6p173USDDQ4ViQHUlgtwGqT5sHLE7o+moi/Rw9GSkJOyRAIfNRBtnyxb8wmmjjjbqJyxEfNhMeKJdGVWtQeLH1XZ9rrs0rHhFz8Eugpm7Hh8bqtgZqcaO4/Mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517482; c=relaxed/simple;
	bh=zlkUlxJKCTkpP8QhnzcFpLANTeTd9OEttN67+21zJBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCwJkMxHtpLtyFxIQalD99bqaylGzp5fmOkXzybg/f8weFr/x/wwlmWA7X9sMKW8DHMuyl1G8cv6sl3Tsp6O8lyUFBJW/5a0m3RiuLMKcH09a7BJV/NRZaFLbhM8nkajiLoOFgAmvcmG5mY+O4OkC/9tlCtHwJEsAtnRYK7XVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdbaMBBV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdbaMBBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A471F000FF;
	Wed, 16 Sep 2026 00:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517481;
	bh=zBi+8VflY6U1hsAkYpIZ7xAekYpbED/eSp4GBepulgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SdbaMBBVfJci6+ntEmacmm2TB75VCvN6sjAuTx06YdQUBOgUfaEli0d17CX5JCxiF
	 Lyv7XiTWFsHn/fjlaX5xAVCsKW/WEz8QcLlH1yJOk8EKSIOkzY6g1RAyLpANCz+clN
	 KoL1MEttEzRIcf3r0H4wKBVdFEoYgfTRipn5dv63z9GzwIVKm0Qj/4HGOBEND5/vDk
	 0bw/+kPmLDDGVI2meIZlbl+PsDMl2YANSrzoRb+fUIxmq1JZzkCdmgs3OtEZ8p7mWz
	 6e/GuJS+bbK1LT7Y7YaVRUrM+u/W86H8w3SVHw6mJV8FAExlkOqhpwCrf3z8e036ep
	 vjh4/WDOAeomA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198CB392706C;
	Wed, 16 Sep 2026 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951741563.2328807.18203609526787283104.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:10:15 +0000
References: <20260913204104.53408-1-mhun512@gmail.com>
In-Reply-To: <20260913204104.53408-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: linux@dominikbrodowski.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 ae878000@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 16:41:04 -0400 you wrote:
> setup_shmem_window() acquires a PCMCIA memory window using
> pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
> ioremap() fails, the function returns without releasing the requested
> window.
> 
> pcnet_config() treats shared-memory setup failure as non-fatal and falls
> back to setup_dma_config(). Probe can therefore continue while socket
> window 3 and its reserved iomem range remain unnecessarily held for the
> rest of the bound lifetime of the device. pcmcia_disable_device()
> eventually releases the window during teardown.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error
    https://git.kernel.org/netdev/net-next/c/30da1c2a4150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


