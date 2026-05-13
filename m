Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743F395AD5;
	Wed, 13 May 2026 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643967; cv=none; b=C8nEI9TVj8ski6BxeH8wOzWiFeuPgI0AlhpbPa/YlMQFfaqHkiZ0cRtDl8to3/AZcTF3drCao77t7Jln6eB0H1zOALOoTY3LQALga937dflDpRfMHoSY8JRWwvwQMk9q1kb/BZwlP1fYucKsI2L7IdLCNom/jjwZ5nF4w2AaAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643967; c=relaxed/simple;
	bh=iZVh9KPnMiR8exSsOFVprvss4chz1VIMZa7sqVbAAqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ioimu2GEXH6qv4ZFn+Cnm/Yq9T4h0odIAxTvc5J36Zpy+zDGhKaZ8eoXhotxFPLTjbPqI8Bqbh2A+hMST5qEswwzTPhPRQTepp18BPCwqEmmjYfwALrbSYswLW/ZSvvloc0TtIqgizxEeMgi3KaN1um6uVFBjcmbwaDws1SKacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl+JW6Ip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl+JW6Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0637BC2BCC7;
	Wed, 13 May 2026 03:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643967;
	bh=iZVh9KPnMiR8exSsOFVprvss4chz1VIMZa7sqVbAAqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nl+JW6IpOf3dhyTXX0adLFHookILIElqpUdnnioZoHFtuNjpwgjdb3nSNEanpdFY0
	 ZfCC6zZlW4I7YdVNuwYR/M/+KYvPmAqCCItSOovSfkYmUoftdijd9ioET/c6w7qhXC
	 svmEXoMV3CtqtJMLnjHh/fjvNuLRzb/R/RvRYerUIT3m1HJLfJVaq9t+n0sHl8gseP
	 vnqSdRmaNj4W5cHotSR8bqfcViDaQCCMoG2eYJgcRtHeCrV+8O/61YqdtYXXYvMM+y
	 NRYYvN52IKgR4s2A5iBY67C1C6FjnuTeaLIN7Vbz8PRYoGC0JEqpkMUN1Uz4SyD2Bb
	 by9nQ8nqrYe0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CFB3822D60;
	Wed, 13 May 2026 03:45:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: atlantic: preserve PCI wake-from-D3 on
 shutdown
 when WOL enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864391254.3173643.14180914771474324988.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:12 +0000
References: <20260511064002.1857-1-goodboy@rexbytes.com>
In-Reply-To: <20260511064002.1857-1-goodboy@rexbytes.com>
To: Zoran Ilievski <goodboy@rexbytes.com>
Cc: irusskikh@marvell.com, sukhdeeps@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 08:40:02 +0200 you wrote:
> The shutdown handler aq_pci_shutdown() unconditionally calls
> pci_wake_from_d3(pdev, false), clearing the PCI PME_En bit even when
> wake-on-LAN has been configured. While aq_nic_shutdown() correctly
> programs the NIC firmware via aq_nic_set_power() to listen for magic
> packets, the PCI subsystem will not propagate the resulting PME wake
> event from D3, so the system never wakes after poweroff.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled
    https://git.kernel.org/netdev/net/c/2c308cf34284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


