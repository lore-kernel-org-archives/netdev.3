Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4874848B5;
	Thu,  8 Oct 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502209; cv=none; b=oYbFpjGGvH+Ud3LygcTDExbLOyTmGyF/tKT2WyIOiEQWaaIfr10DoKViF4gXSiwq24wMSYBA98XU8PxvZ9a11je1GB5DJUa5IBaHnVJz0ixIclgzZwGil0TYGG6jjyaODuQ7XZ0HcYpnmwpIljEfNs4qujBtJ1i3xpqrjyompIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502209; c=relaxed/simple;
	bh=oKhGPLpbAVjWcMdRhONav7XenWzlwu7Xr/kwDfIY7/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/m/nAYNNHW98aieP5kTVxXY3kLdkzk2kOUL41/WCkVEXnjwjwYxiRa7dk/67qFlWB7fgCGK3LnXpAj77aZOKU8jqQlJxJOEU1d8tjdHYVUoBqBbV5NVOLWrzcY7OM74ukTUNMG6EP3aQhH1Wkx5SEfIcqBRa42KUu5acjRwkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loEcEAJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loEcEAJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BA91F000FF;
	Thu,  8 Oct 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502208;
	bh=N9zD5oYCy/QuoE88//pO2B/iPSwy+aCbiF0/VO1+CxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=loEcEAJhcrgIIt0ju1u8nn2M0eAWVReZDO9Z2AEaXplNM1uBLjBmLSuf2yO7//+ri
	 Fu4ZKQSbGsBz92upptsVYv/ncf0fmJnW7lA5nKlCzioPWHtIgpqWoKzhBrrPRjsTNi
	 NVdUrfKqmbjqx3HItNEU3oEnuXW3RF2/x1Kk0e2bmjj6NdNPLpgQXmkiyUtkptKYKi
	 A2D0AXNEl96fHH+ntXkuPe//1uZ/X7V8awntJpaY+PsZV/SXDCe7uO5kUATQK1Kfmf
	 B/YVphntKh5CjdjZMVutA7yKoIeSViSwjW4cmD2i1ZSzL/p5OJH0FJuOVlzXxaeZsI
	 CEx7sInSoNUBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16AE380AA60;
	Thu,  8 Oct 2026 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] net: dsa: motorcomm: MIB fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150220677.479117.15315604058094187791.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 23:30:06 +0000
References: <20261004160622.948037-1-mmyangfl@gmail.com>
In-Reply-To: <20261004160622.948037-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 00:06:14 +0800 you wrote:
> Fix (theoretical) MIB inconsistency and prepare for new devices. No new
> features are introduced.
> 
> v5:
>   - rebase
>   - hoist type casting helper into chip.h
>   - fix enable_delayed_work/disable_delayed_work pair
>   - remove counter reader in favor of an independent series
>   - reword commit messages
> v4: https://lore.kernel.org/r/20260921203040.1203911-1-mmyangfl@gmail.com
>   - reuse port_to_priv helper
>   - re-enable delayed_work on port_setup
>   - disable preemption for u64_stats_set
> v3: https://lore.kernel.org/r/20260906131414.2683362-1-mmyangfl@gmail.com
>   - fix build errors
>   - fix logic error on MIB buffer creation
> v2: https://lore.kernel.org/r/20260904162952.709368-1-mmyangfl@gmail.com
>   - split patches
> v1: https://lore.kernel.org/r/20260903143514.532023-1-mmyangfl@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] net: dsa: motorcomm: Hoist type casting helper into chip.h
    https://git.kernel.org/netdev/net-next/c/cece0b573deb
  - [net-next,v5,2/6] net: dsa: motorcomm: Rename MIB stuff
    https://git.kernel.org/netdev/net-next/c/05a720732724
  - [net-next,v5,3/6] net: dsa: motorcomm: Split MIB buffers
    https://git.kernel.org/netdev/net-next/c/a219b5ea8bb2
  - [net-next,v5,4/6] net: dsa: motorcomm: Split MIB module
    https://git.kernel.org/netdev/net-next/c/25265e7ccdb5
  - [net-next,v5,5/6] net: dsa: motorcomm: Use u64_stats_t for MIB stats
    https://git.kernel.org/netdev/net-next/c/e7b23688d0d3
  - [net-next,v5,6/6] net: dsa: motorcomm: Fix MIB synchronization
    https://git.kernel.org/netdev/net-next/c/ed4453587dc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


