Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA92FBDFD
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085813; cv=none; b=W+sB+g4T3M0UaF1jX2OdBv1r07Di51AXCSnPlNsp3Bo0ZQqBi0URIDJzu/aM9RaDEnOvMioUiOq4aE/xk7d/DGNbd0je+HydzrE91nGAk8f4oodaL5dq5mfaKZpCZ6E02/aPmRn6VHbZRtX3VtndsoiBkS3QYx5W8AWqkeViH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085813; c=relaxed/simple;
	bh=cYG17tl28+c2incbI2MMiFCBSxoya/EYTCbJ9IG+jWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kB+1KJmL6ki4wgNWTxsBD4vieqHkACUc+qyj7xS96hfRlbwz/wPmiFYGe1Kh4CZH2VwL3GmDP2ruKSDczGcotOo/tqPadeticWwyMPPi34QRvOgaVvA5CpIAwapRdOAfXNCVbQfgyD3EBOLn24HQlcy/OHwk8xWlK03NudDObAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPuIsDW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPuIsDW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5ADC116C6;
	Tue,  3 Feb 2026 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085813;
	bh=cYG17tl28+c2incbI2MMiFCBSxoya/EYTCbJ9IG+jWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HPuIsDW1yLDV7x2QeOPED3LwDsFKFaA9SXHbHNilwW9hwEiMVqjRkIha70/ZN/YWb
	 fMMHBdTDvQk6K7IrJgELlGES7QWgBhDb/8GnZwMW6CJmSYUjEktVqA75OESDL/nsmm
	 tbFtE60AQc6UaoI3IVSBvdN89ONGtcbicHQb1QFOi0O2rdAkqMnUBE6IfNiOJAJs2X
	 hiXsScSvvThTu3uIbRwTaWwTSI1cSX4dZa6YeJQbypSxhpaPK/fbOwJokECjSK/3GQ
	 lXAIHvdXvQe08B7ECE6CbX8XgpJUkrQicyle3koo9AaQBk8oRm6nVaYbns+w97inso
	 TK813/Vm6MjJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90F573808200;
	Tue,  3 Feb 2026 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2026-01-30 (ice, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008581037.1282989.17724890649337308112.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:30:10 +0000
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 30 Jan 2026 10:53:53 -0800 you wrote:
> This series contains updates to ice and i40e drivers.
> 
> Grzegorz and Jake resolve issues around timing for E825 that can cause Tx
> timestamps to be missed/interrupts not generated on ice.
> 
> Aaron Ma defers restart of PTP work until after after VSIs are rebuilt
> to prevent NULL pointer dereference for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: fix missing TX timestamps interrupts on E825 devices
    https://git.kernel.org/netdev/net/c/99854c167cfc
  - [net,2/5] ice: PTP: fix missing timestamps on E825 hardware
    https://git.kernel.org/netdev/net/c/88b68f35eb43
  - [net,3/5] ice: Fix PTP NULL pointer dereference during VSI rebuild
    https://git.kernel.org/netdev/net/c/fc6f36eaaedc
  - [net,4/5] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
    https://git.kernel.org/netdev/net/c/234e615bfece
  - [net,5/5] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
    https://git.kernel.org/netdev/net/c/40857194956d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


