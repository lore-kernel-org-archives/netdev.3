Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A02309EF2;
	Fri, 31 Jul 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456050; cv=none; b=oqy9VMY1q5njaLc3rzFG79dWq3igBsfc4vH4WrYR1/MKY9uFOlLnwOlN2V5oEWU0HawY65QTmkqQMOMbv6noiuFp2Z9mrDxV73LbC5xtdYa9WWouIlRSNiHUmbbivg9LBtpVmUIxd7XH1q1BI53+kRxCw5pw+CdlyMrXswzaLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456050; c=relaxed/simple;
	bh=2kUZ5nUYQBXCP5sF/9YEUVaULMhr158ZANNPTM/kPrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sKPVDJ99Azo6M5hNUgdhppRC24qaBnCVxXsIg/Ip+oFTYGxrTdbstaSKXkYrDrwvyZqF23qJCg2CFd8gDGBIUOrM+cu4OX55KjBJL0I25zF6gVKknoQghJrFqM+SEcjVWYP5+Aur5TmLoHJNYv1bqorbScQ6d6hEwO5Z1rZLvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSG77XMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSG77XMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AAF1F000E9;
	Fri, 31 Jul 2026 00:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456048;
	bh=2e3ByP2E45oxnp4h4bvyuG5NWNhlWARWtcghFD8nb7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jSG77XMoxpoDDuDgvuRPoqFj+de3j1hWvP4uCDOXz0kEYIRkdj3xqR9u+OiWmuXjE
	 9IVwrnpggNBvJhMd+EDBWap6G4mYZidn7XeN8zqBkw24KdOv0orQUDX+2kTR6IUsCp
	 klJdiPoXyHRfmpOBhnR1ViDegQr+DlcU3zu+1DUjcusbA4FRowJ5+Fh7tD+jDAA6+T
	 4/ChQdTaUEKF5D9y4YKHfc/uvtfBfN6O629UDxyHzr5HDBMVfPEfhwGj3AjzLnehMT
	 u2Qs2+QmLyOUy7J9mGSzCneYTYpZRgqseMp02ZMT09zwglKpQFtLS6Z1O4jf9jxwsP
	 G65r6zkBjSF0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B893924472;
	Fri, 31 Jul 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] enic: fix tx_hang_reset use-after-free on device
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545601163.49120.14528411223572589107.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 00:00:11 +0000
References: <20260728062730.2394873-1-satishkh@cisco.com>
In-Reply-To: <20260728062730.2394873-1-satishkh@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sebaddel@cisco.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 23:26:30 -0700 you wrote:
> enic_remove() cancels the reset and change_mtu_work items but does not
> cancel tx_hang_reset. A TX timeout that fires while the device is being
> removed can schedule enic_tx_hang_reset() so that it runs after
> free_netdev(), resulting in a use-after-free.
> 
> cancel_work_sync() alone is not sufficient here: the still-live watchdog
> and notify paths can re-schedule these work items in the window between
> the cancel and unregister_netdev(). Use disable_work_sync(), which
> cancels the work and blocks any subsequent schedule_work() from
> requeuing it, and apply it to the reset and change_mtu_work items as
> well so the same requeue race is closed for all teardown work.
> 
> [...]

Here is the summary with links:
  - [net] enic: fix tx_hang_reset use-after-free on device removal
    https://git.kernel.org/netdev/net/c/ec680ea4ba1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


