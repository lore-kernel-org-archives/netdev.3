Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C591352F86
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522828; cv=none; b=AELUHy0IBQtLjrHHKpxExzOa2AeoObqQEphSt0nOZiZDNPpXMx5Nhb35kG8F3Yggrbf3Y9c8cGM9PEUGYoUoGeaYWQeZicuej76MhEvWwmI043i0q9FtiqHpy35FE1IS1EsshHDydWyz6eLeHygN/SmP5YGntLnIxJL6xFSZnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522828; c=relaxed/simple;
	bh=kLv3cOFAyybWZjeulM8XaRW1hajDsixJzu118FD9IM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TXXIDjaRHQYRQovFH0i2oOrFCmMBBov8UTaQPQoEBnVL83w4AotpnXTJD4jePdKNAupQal5TAZ6aFfaIFIPRGTXikBFphomnFnfYHmi2gQBhIYT9sdbjkpVmTW2fofnhoW1xSR4XfCpSQJgOD4t0PaTHyZgTkfY4mgsX6xtOcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy3ax+b7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy3ax+b7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB89C116D0;
	Thu, 19 Feb 2026 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522828;
	bh=kLv3cOFAyybWZjeulM8XaRW1hajDsixJzu118FD9IM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sy3ax+b7igsTgkxoroW4gFDsCqcFKx0gdD6+bBOgxrxDDJSwTvaxCHDwsRJJHtCop
	 I6d0RTgRfFTgCr6x89tjMDQGTXgQqN82noHb0c0tcuvG/NZDQsP0rjlPHKHDidOXxh
	 WjO0mbZMQJtg/Q1VDpeFaLhUWbtNNAsBknufdVGcFxRUqoNVkAuH5SjYPMobq8nCUR
	 LrwhXHv3Rzlpx74mtAb6QavnP+8POtGL6uOpgJsdbn8j/4uxzNoWNsAxkOeHIdpj8s
	 xnCBRkjKX/rlq5dRSCUme23C6u2YH+/Dh659hioZ1freMY8R/Zqg2n0KGWDhj+SWaS
	 zFLGEhNFyz/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85114380CEF3;
	Thu, 19 Feb 2026 17:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152281932.2317554.10314351158058366717.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:40:19 +0000
References: <20260218060919.101574-1-liuhangbin@gmail.com>
In-Reply-To: <20260218060919.101574-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jbohac@suse.cz, liali@redhat.com, nikolay@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 06:09:19 +0000 you wrote:
> The ALB RX path may access rx_hashtbl concurrently with bond
> teardown. During rapid bond up/down cycles, rlb_deinitialize()
> frees rx_hashtbl while RX handlers are still running, leading
> to a null pointer dereference detected by KASAN.
> 
> However, the root cause is that rlb_arp_recv() can still be accessed
> after setting recv_probe to NULL, which is actually a use-after-free
> (UAF) issue. That is the reason for using the referenced commit in the
> Fixes tag.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net] bonding: alb: fix UAF in rlb_arp_recv during bond up/down
    https://git.kernel.org/netdev/net/c/e6834a4c4746

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


