Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA922ACEB;
	Thu, 18 Jun 2026 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742055; cv=none; b=A2nfM+eCeYyFH/wK5iG15riR9W47/X8qNLWxjzpNZ+drtTjJ72xdB8j/BHudzCQS5IDRwaPS3rpFk+QOCSEUiDsCCZS5baYTeGeZYaY+gxAOJXmNsSKlL4uXtySn3goJPwG/Fjhfhvr+6BVc3xrTp8UNCwATtrYu7T59dBrg2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742055; c=relaxed/simple;
	bh=WBDTQS/ptLPageZ+B4NMSTiHVU9wKCIoaighbiOcScE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OuIGd9OgBJ3P8SlUMyfqL/7WNqwF1dd79QnJJ1JuL+lGruBAJKAoDOL9yD6rXBzwti6bpl9TApT5HP/35Ed1ga5QMgfKLBdTSWBxogA3KCJtLUwkmZ5WAFYfjNgxXSlJEB5fhor/MhxSByTWJfib0SBGVSFrH02vj+p1xEnBrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0tqK7LW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0tqK7LW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047EC1F000E9;
	Thu, 18 Jun 2026 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742054;
	bh=CFHrLycV7jXgTlEeEzhUqbd5XJrjGLt9ot4JAfXSO8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n0tqK7LWLkTNMLjD+Ai5qvNWOuYjAyN410CWTgOUOUt9K38NWMI6PcJ3VV2Lua/QT
	 hWjKjvF1jVSS4Xhho5YypMNDyIYhZEJX76ykygybmd6lGNQ1v8G5jrUBqJFqtxdpfk
	 rNJyIrGQoYOISzKZ62oPSg6BvBq3N139MrAnL2zzLsUW8Fn71OLhMYo99AutGIauZe
	 mgmQH8UF2b/2slYmOJujFvlVt2Y2saaVwDR1W/qzqIz8JzE+U6ux7qW4zxuEMie9ol
	 YQdnmbv2FUcaAPMhjfIcUQVgy1sA+kvJXBAktX9XM19lAgXz/n+SINLit4ZfFjNAut
	 0dalH/7DmfYmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199BD393102B;
	Thu, 18 Jun 2026 00:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: npc: Log successful MCAM
 drop-on-non-hit
 install at debug level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174204763.1875263.13516864349526694782.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:47 +0000
References: <20260615033157.535237-1-rkannoth@marvell.com>
In-Reply-To: <20260615033157.535237-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 09:01:57 +0530 you wrote:
> npc_install_mcam_drop_rule() used dev_err() after a successful
> rvu_mbox_handler_npc_mcam_write_entry() call, so normal installs appeared
> as errors in dmesg.  Use dev_dbg() for the success path and keep dev_err()
> for real failures.
> 
> Fixes: 3571fe07a090 ("octeontx2-af: Drop rules for NPC MCAM")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: npc: Log successful MCAM drop-on-non-hit install at debug level
    https://git.kernel.org/netdev/net/c/4f6ac65e8162

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


