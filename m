Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EA22DF88;
	Wed, 15 Jan 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905824; cv=none; b=RAjgPAC1f3bM6dDXq3lUbUZa58w7R6LUTe5Vx64SdZ24kzBOCMzM+Y0G/JR2mpK7uVFxWwvTgcrAlVfLLVeFFu6OllPTgXeYtSOYhzPgvr7KTP0rmzx3YB/ToqXaH5ROAZ0hRAiPhkMvIEvp6ExtEsw9mMCIbIJ6EwpwmKxW48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905824; c=relaxed/simple;
	bh=UuQmuPfjCuRFZaz4HYBiDUArpLCNgpzotyC9nXsE1P4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b5zOFNcurzkw0AjonHN14Kvdtw58+66ZwD1sruLWwGVmk33ZHO0XA4Xqrtznlaz/M5z5+4rPpImPs44g4/x8sRgifVy2lqlq2Oy6aBvj+rAi0Dy/JwDnMjt+cNtsJFsOJWERgsU1gb9sEU51bYpkhxEp+3rq1Uzsb0/Hhvl1WV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHmUozRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHmUozRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C11C4CEE3;
	Wed, 15 Jan 2025 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905823;
	bh=UuQmuPfjCuRFZaz4HYBiDUArpLCNgpzotyC9nXsE1P4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZHmUozRUISg8US3kvcgLuJlql9M/j/4gewTzRVm5NBHQplL883QTvRfNhrqTAh2OC
	 ERD009vMzZpGY9Sl5jE/obyZyi05YBP1Mb+lYghEbkhk6HdlBeTG7mCnHzF88azUbc
	 fqvDm0HLmCooVzaOzr971nBrd2iKDRvRpNN88+fOGrmS66PEWjpj52A3KpNnkIeiOP
	 dtJezG4A/GkfsgVMS2t5dRiR3h8Vy1/Jz476E1o5QCD0Q/YVLqFJuEc1tfjF3F/o+k
	 Km92Y6U6kA61DUUGkbHKs21ka8EVCrrl4BrTkfhvQrmsDCLVrwuvXQnJoo7vjmNJQY
	 XMQpgy7z95WXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB437380AA5F;
	Wed, 15 Jan 2025 01:50:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: netpoll: ensure skb_pool list is always
 initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690584676.216599.16130050687558507051.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 01:50:46 +0000
References: <20250114011354.2096812-1-jsperbeck@google.com>
In-Reply-To: <20250114011354.2096812-1-jsperbeck@google.com>
To: John Sperbeck <jsperbeck@google.com>
Cc: leitao@debian.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 17:13:54 -0800 you wrote:
> When __netpoll_setup() is called directly, instead of through
> netpoll_setup(), the np->skb_pool list head isn't initialized.
> If skb_pool_flush() is later called, then we hit a NULL pointer
> in skb_queue_purge_reason().  This can be seen with this repro,
> when CONFIG_NETCONSOLE is enabled as a module:
> 
>     ip tuntap add mode tap tap0
>     ip link add name br0 type bridge
>     ip link set dev tap0 master br0
>     modprobe netconsole netconsole=4444@10.0.0.1/br0,9353@10.0.0.2/
>     rmmod netconsole
> 
> [...]

Here is the summary with links:
  - [net,v3] net: netpoll: ensure skb_pool list is always initialized
    https://git.kernel.org/netdev/net/c/f0d0277796db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


