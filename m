Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7C345734;
	Wed,  1 Jul 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893428; cv=none; b=GZSrv4x2O/xyQ/0al7yP0eOYfgq82zTOvr/Hf5N+YBhnMQEw2hkbxcYWjHzXDdHt9vda4/p9qDOvhQTFE8eoL5hQzeVa+OnK7jwXcH5Y4/mI9r9MsEfL9BeDElNQ+tu+LPZXzRa+FxK4Dw9pp6JeXHYiZHYsM7hZPX053cRTUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893428; c=relaxed/simple;
	bh=rTElv/+AE8Zo6al1oaXlPKCsz1D1zConCYQsxQVQI14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QpuQjCQoYI3AmZvczPVKLEul7wRZj2lHzVV+Uhgzz3KpHN/DcIb8heRJpGcs75OFI70zf/DW8KK4vQV6ldfPjw9cxWVvPRyqPASDdYwcJf4KQx9A3XVYklUVpoCwt4eKflo6jKsQSDeuZ+9piB4JfyOrdbqw1wDpYL1l+aeXdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUGlxGfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUGlxGfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087741F000E9;
	Wed,  1 Jul 2026 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893427;
	bh=i/qpayHpx6Nm995n3pkT/f84KJO8U0DxMfINX7URDyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lUGlxGfA/keh9laXcSbKGbiNNmuQrru/qIQmYFLH0hk+w7YcUQlhcMO1e21xXVkTI
	 tbiRLcPWHxiCGUrnEbZcOoCwFkltA+MvWQZwVc6IucUlldGoSOyTmFI6Ir38dYdDGn
	 6qvwYX7R8r5+RVZPyDcPBn51uZeTiE+F4JhInIrB7GXJer8oRB35NkMRCHLWh6C7Bt
	 qg0XGavEVOunbaDeuPbQN0SsiYScnkqD0G9XfDvaPbUi50pEe4/pxaFAazXprP8Srp
	 3NZgMcb6mJj8ejMLGmr2/X7TYnRngueirwvvcbxm6WC1wE3hkj62kBTwULcDZ5sc13
	 975LLxF8azOLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ADA3926651;
	Wed,  1 Jul 2026 08:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: dualpi2: clear stale classification on
 filter
 miss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178289341039.500901.13486469205954390511.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 08:10:10 +0000
References: 
 <20260628134846.2211556.3eb480ed8de5.dualpi2-filter-no-match@trailofbits.com>
In-Reply-To: 
 <20260628134846.2211556.3eb480ed8de5.dualpi2-filter-no-match@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olga@albisser.org, koen.de_schepper@nokia-bell-labs.com, henrist@henrist.net,
 olivier.tilmans@nokia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 28 Jun 2026 13:48:47 +0000 you wrote:
> DualPI2 leaves previous classification state attached to an skb when
> filter classification returns no match.  The enqueue path can then act
> on stale state from an earlier classification attempt.
> 
> A filter miss should fall back to the default class without reusing old
> per-packet classification data.
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: dualpi2: clear stale classification on filter miss
    https://git.kernel.org/netdev/net/c/bf83ee45874e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


