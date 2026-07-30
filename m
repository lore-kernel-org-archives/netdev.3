Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9794052AA;
	Thu, 30 Jul 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409247; cv=none; b=lddThfsEMaSSLcKyDEfw2tpy3qzOVtiGvZjg0x42UKeWgpfIeBg3/Db3XC0rMs0j0fQOS9FO2RYCZLYqH3EON3d/t/1e3VCz8pznszhV/u1lWAlWWMuhIA6UEzrpGqsBMvvwqwYjTOeRTdU022dbjNJEWzo6Y0o7eUgxDSOu2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409247; c=relaxed/simple;
	bh=6SM8Z6zXmHIGgbBqeiem58WqkOC93tQmSnyulxKXjpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldNXnQeefrzwBmJyh8tlTbmLims+CQEut0hjw+UJgJsxiqbLbIRH5dDAPHkHEOBMBzLFB0QCAifyK3kPUtSo22ZF9ziREBunOQwSa3gtKmoo6FjJfTbXdfJ+32tvcDYzYcUmgTveUuOIeA8x03YwqfZR8GuI12fFXUKjhfqrE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKJw3b8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKJw3b8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0111F00A3A;
	Thu, 30 Jul 2026 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785409246;
	bh=CJ0gbAmcWU9wYF1uPObuNczTdEQtB5TOytHCXIGGQdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lKJw3b8Jdh9KhH//iskgp/Rr566vJKtVUlRa23/W9FzPeFByf2VIFBPAWm8mqqkQ3
	 S0Ll65aZh8Gi/P3g4+vt3XbNC8rhsx/4d2zgaQMb8a0jfqGthEQLuRSvQYK/2+Ed+P
	 0M/oku7oYBI2xGnwZBuyHd0zQV9cY3Q+JGsAl1VA40YCt8zH3/rIWS+BozGAkvsSPM
	 jsI629GflXG02iednbfVtY4G23xdae6a15+3RDqMqSmLIeUMDQz8Kavh8N4h6O3vXX
	 oAdOZM7LWAPqOqBWd1YGX9TnF9WYql7VJo5PPTdgP470KfVyqP04MPXj8yC6rIt/W2
	 x0LiXNbbffixA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 558A93811979;
	Thu, 30 Jul 2026 11:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Set correct sequence for carrier off
 and tx
 queue stop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540921003.3506370.18273111957564391972.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:00:10 +0000
References: <20260724072831.2415281-1-rkannoth@marvell.com>
In-Reply-To: <20260724072831.2415281-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, lcherian@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, tduszynski@marvell.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sumang@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jul 2026 12:58:31 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> During link down event, we were doing netif_tx_stop_all_queues() first
> and then netif_carrier_off(). This can cause a potential race since
> carrier is still on during down event. This patch reverse the calling
> order to fix the issue.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Set correct sequence for carrier off and tx queue stop
    https://git.kernel.org/netdev/net/c/16809472409d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


