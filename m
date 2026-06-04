Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F9480946
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590023; cv=none; b=PVEVZNSCArZpB67NVKY97xaVTcqqt/VEkDQRNo6r1lgTNqoL6HNYudZQ6dMqLCKf00woKQnT/VZ1P9f1cLd0PFtaZ3pJDZu499+A1kJtvUWAwcsrlmTMXhg3a/1Fus8bHrRVorWL8ljL/YT4sr5mxMruxep11W1DdeXerNiDAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590023; c=relaxed/simple;
	bh=NhOYS5M9wbprkqVwoAauvCLAFAciNkwuDezF8z9wcXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNI13alFRIYac755E0xLfuJDpIrhHAbUSvw71rmHsEJUQydMxHoX2jGyI294aqXwxUwjO1yVq2kfmxPiHuXmQC+4g96XFLPHw145T7Js5XKb0TtQFkz3NVNiGFtXIuJgRVJ4T8C9ntOBakLQ5pbIWdp9PiCX9JRRpa8kz6pElo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccEOlVZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccEOlVZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFEE1F00893;
	Thu,  4 Jun 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590020;
	bh=ZsmWTSXFoK1uQJIVgzeXjGea6fgt/mfuQncsTENa+1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ccEOlVZ6BbXudgVtIEo6Ivp8d7DAuQJ9zikzB/NPU2K/fAH8c3zi8ZquuiAznRnw/
	 nZMLRfdhIrF+WHlRfBhzR0q8P2qGlES69+RlnBdbsqqcWbqVdRacyvaOKCt1FA3uGm
	 ZTQrQaIBg5Ik3pdZ03/ZK7sqT9V8/0diOiBdMd6V5aakyD2HvJ7HP9W5FSJFha0ra6
	 zb0zpzq4+a2MYbnPLH9GeHSlR1+nGqPWMkP/CHXXVwPrMNZLMiq63AtqB68n/fEGTs
	 D2QcYAK4z4CuVOQmukvMCSxRVBVh/VFSP+GwshFPMvi6VsypigifkCCHIiHhgOL13D
	 USExLGGbX4YRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E039309B7;
	Thu,  4 Jun 2026 16:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: annotate data-races arcound churn variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059002089.2502005.2403817673330222849.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:20:20 +0000
References: <20260603123514.388226-1-edumazet@google.com>
In-Reply-To: <20260603123514.388226-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, liuhangbin@gmail.com,
 jv@jvosburgh.net, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:35:14 +0000 you wrote:
> These fields are updated asynchronously by the bonding state machine
> in ad_churn_machine() while holding bond->mode_lock.
> 
> bond_info_show_slave() and bond_fill_slave_info() read them without
> bond->mode_lock being held, we need to add READ_ONCE() and
> WRITE_ONCE() annotations.
> 
> [...]

Here is the summary with links:
  - [net] bonding: annotate data-races arcound churn variables
    https://git.kernel.org/netdev/net/c/b47ff80f280e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


