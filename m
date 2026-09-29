Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96D2C15AB;
	Tue, 29 Sep 2026 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640696; cv=none; b=COJHCj24+hiwmJPXfs+cVobjrEM813WM5q4w5yx7Bx4Pn+f0esEzSkHd+uxAVN9cSpXMaYAddJDXRysljJ+4+b4g7eDX9kWHaawB/mB9JUoFBjJ9xJERWWVqfdnoPaur9a6MaIwIHoKxUHGNMwhb1YM0sT5xWnPXwrLN7cC59gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640696; c=relaxed/simple;
	bh=s0e4w2Hdk86sdhZAUNnCLO8N0O+f/sjUXv0ckyb83PY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foXcUdcn3LtDZznz/Z8DYMT3wihW4gZ05gKlJA1ECAKlt7p1Y4lEb7RVYQusehKu+jkxpOTtr9+utjzmTfgYuvXS9VJZLhT88k55S7XltMBYFpnx4dViMr2mqKlM6MATF/C34kKtGeTu6xt9lRmYxlXR4CZHmN6E5U0W83wN3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqT/f//3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqT/f//3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B561F000FF;
	Tue, 29 Sep 2026 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640695;
	bh=d80TNrUfgSPAyIB5Mtr+jrZAIRrxCj0FHcj+4mtp6aE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mqT/f//3OFzqWOdaWA8Z13huZLCc9on0SSoQ/R8K9SGwRplFNTmKjIi2b8jltaJ14
	 70y4w01t7h/kLexHK/PyVgyMj113WmFdcWOmgmEdHiwAN/V9U1fG/AuhhlHh2ReM5B
	 SxXl4hBSDKSOvBCj96aBGNy8C8TOGCjWBCruDTd/q4w3Yz8Bk7ixQbW5l8O/IOrjw0
	 PKhlMqkLJIifJLPhb5V7VoI36MhrO1eC9lIvrK5APhqM1vnb/yD+QECJxnMjblo5Jf
	 PWyb95u1GgrxzUqnuf07KqANUQ6q6J1cpAxFDVwHf+js15cF62DKZKftY5bmDVNdUl
	 0qeklvyzbrDBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199AE3924FE4;
	Tue, 29 Sep 2026 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/10] net: systemport: Collection of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064061963.185826.10099751238201062353.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:10:19 +0000
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 16:24:30 -0700 you wrote:
> Changes in v2:
> 
> - dropped patch 4 and target it at net-next
> - dropped patch 11 which needs more thinking as to what is the
>   appropriate DMA teardown sequence wrt. topctrl_flush
> - addressed Nicolai's feedback
> - added Nicolai's Reviewed-by tags where provided
> 
> [...]

Here is the summary with links:
  - [net,v2,01/10] net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
    (no matching commit)
  - [net,v2,02/10] net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()
    (no matching commit)
  - [net,v2,03/10] net: systemport: Fix NULL pointer dereference in bcm_sysport_fini_rx_ring()
    https://git.kernel.org/netdev/net-next/c/96c201a2f43e
  - [net,v2,04/10] net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
    https://git.kernel.org/netdev/net-next/c/1b94a9b462d8
  - [net,v2,05/10] net: systemport: Fix RUNT MIB counter register offset calculation
    (no matching commit)
  - [net,v2,06/10] net: systemport: Fix potential packet length underflow in bcm_sysport_desc_rx()
    (no matching commit)
  - [net,v2,07/10] net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
    (no matching commit)
  - [net,v2,08/10] net: systemport: Fix inverted error messages in bcm_sysport_stop()
    https://git.kernel.org/netdev/net-next/c/1c6214e6daf6
  - [net,v2,09/10] net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
    (no matching commit)
  - [net,v2,10/10] net: systemport: Update TDMA queue mapping dynamically on changeupper
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


