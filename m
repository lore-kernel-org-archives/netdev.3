Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D9466B58;
	Tue, 13 Oct 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888009; cv=none; b=EK61+vMNq0XUXw5IFLBoEFUIFGgeN6+kt2lZi4fwPHgkMCYA/3clUe5NUH5Kizo+1z4S4wp3KYGtQVDC7N1yWx2qA5OjTvkvKk8lNtEaH3qMcSBjBYmsaF9s/U5toWwPVMiB5lDflCzssltZWuDQOdWTM7p7PPeihsPTNBd1xMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888009; c=relaxed/simple;
	bh=WzHCFnySFrfKQa7NS+utckC/w1iB2N5efjGQYSLmkA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgRlgArkqW+ER/+YuBvCwmxRbwRkrjyop/bsogdq62DetVp6rgGRCLMUrl6k0gfva+mizw6f2GKuAqw3LTyRxvMy3pNSRpoeSp3qU8PXx+cZVpAkdyycuvovDMGocZ3f5X+x5eYA34lnExVs23k1A9mDxh6+k/E7plgCVys2mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxRlpsBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxRlpsBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813001F000FF;
	Tue, 13 Oct 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888008;
	bh=pYV1zDiUo6CWbigwZQNtwFsu5NziXAqj/fk4Tq8niJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NxRlpsBqxcB+MW0Mf3C8DTI539d+JD0JLWMlnebE7+4KS+AzazOvnp7jb701TC7gr
	 VRKaUDO3WtGFxaXsqm997/Ow/5A8yzerWs2SjpMRlXSXCBAqi48s/MeYdaAOTW5GBB
	 mlqrvcr2L4K/DXpA/bojXTp5zmQPjHGMusL+/rMAGjVh0wj0x69/A9eOOs/BSVT9ks
	 XhhXBk3sAoY0kEVuO9hcTncJ5/2sWtUC18fB3XvD49M/MZXO+qNfHZGSP5oMlzTkle
	 js4ZFyCzje+tjjYwZ5cJbB2Yka85ImPNZMASK0VsHU1O15Xq1gT3A9I9R0zlep3hJj
	 l1g5B+4bhqfjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774563927046;
	Tue, 13 Oct 2026 10:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ag71xx: Use default NAPI weight
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188800703.210833.12341187585821147473.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 10:40:07 +0000
References: <20261007173628.657527-1-rosenp@gmail.com>
In-Reply-To: <20261007173628.657527-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Oct 2026 10:36:28 -0700 you wrote:
> Drop the custom NAPI weight and let netif_napi_add() use the core
> default.
> 
> The old comment claimed larger weights wasted cycles and cache, but
> recent RX and TX path changes altered those tradeoffs. Keep the driver
> on the standard default unless measurements show a device-specific value
> is needed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ag71xx: Use default NAPI weight
    https://git.kernel.org/netdev/net-next/c/0063f777b58d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


