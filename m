Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB38383985
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425410; cv=none; b=hSKifI16puxb/dROv7wZyUAvFhp9lpBf8eLRnJZ0jHs47klevp9e17salf/mEyTFPwMM/s/i2BZXaeOtraEERGcH+Ea1MSdGykXbwZNAdIktgGJCIKtDqLLDmdQdAYejE3fuymDnIo4Ll0BQ/1CQWh6FkWxxSCqOl1xRm8t1jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425410; c=relaxed/simple;
	bh=xt+zIakBf1aibxAakPNj2DTEuExxBbGw6ijTVWJ+wXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MK340tQp/p2QEqbyY4YFbV58kqPU2BznE1V0Z8wHGp9EyyM7n+mQHS2r269WoPlTJ8//ECmSd43QKypMNaSRzfRD8BybVu29bjdAJAwn+halI4GxAHxXunks9AKpmqTOlQiuruLCPi+OsywcE44/0KH2G+lGXif8wfags4azQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgJcpI7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgJcpI7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444AD1F000FF;
	Thu,  8 Oct 2026 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791425409;
	bh=tt9UrD2QRR+BAxrZVtDIQWG+2bLsqZddWVIlY5YcMSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OgJcpI7OS7ooPG++NaQwg3y5ocs3huwQc3lAdF49DBbsmKfT39PnvnAH5MG34JuNS
	 JsNu+0+aaL5AQJSlPPW6d1bdnlke4bWHintou+m0mazbchE7dW7E+l88vqQ+GboLPn
	 lYQuSIYimrFadLJqlCKbJh5JWCEQN90qctGSf5Y1otjEZEg9614GcPMeRSJnDb1K8x
	 TSYGw7o0X0yQXlSTuAc/8IkR8Pm5SsU+CT5uMHyOdt1W+hMaM6NC3te1MBmRODS98z
	 xpnNUMyJsqDDbwymFcn6nTy2p28mIWKnqbZutkFT0x7+hX8CGvzOLXD1t693tOmRQ8
	 xBZHBdzyAEkWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A17F3809A09;
	Thu,  8 Oct 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-10-01 (igc, igb, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142540777.3771647.15868502335514803334.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:10:07 +0000
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 15:24:33 -0700 you wrote:
> For igc:
> Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disabled
> by populating the skb hardware timestamp from the NIC's Rx timestamp.
> 
> Paul Moses limits timestamp-header stripping to the first buffer of
> each packet, preventing continuation-buffer data from being truncated.
> 
> [...]

Here is the summary with links:
  - [net,1/6] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
    (no matching commit)
  - [net,2/6] igc: only strip RX timestamp header from first buffer
    (no matching commit)
  - [net,3/6] igb: only strip Rx timestamp header on the first buffer of a frame
    (no matching commit)
  - [net,4/6] e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()
    https://git.kernel.org/netdev/net-next/c/8c37b775c92e
  - [net,5/6] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
    https://git.kernel.org/netdev/net-next/c/e357e76b6ca5
  - [net,6/6] e1000e: add system to disable K1 list
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


