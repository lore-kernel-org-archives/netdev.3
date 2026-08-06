Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D3CF678;
	Thu,  6 Aug 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029647; cv=none; b=V7v35mIJjzdrmt4iqeOIF15Tgtrb+p4T+YuNBRrBV20vGevscULs7Sr4N/dO+1cThLds4T1s8jtYsmiQWpZB4y79RvdbrtgG/0EgZOtulkr2iyOEeKAAonFzNVeiKy+6vRz9byZROBn8YXyZJ5owr7Q6C0Rz+kW6I7HEA3+V54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029647; c=relaxed/simple;
	bh=w2GjoF3iCCNQ43O6VfUDKrRogsZV9LtBUn3to6+zRn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aWp2SFnAvPBYYwLquO2WyhtuHrdTAJ5azgfmem7x2tBAdocldMWmMkoS/R8uaIFLjBK+77pcqivBKdei0GBuVU7Ui2FxmhingT9SUiuuUZzloBfFnKgvhghGmWcxwW3KGTIvNGpFy4MoLj2/770TqYSGn3OfAbZFVmxSLrgafBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA1XF+dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA1XF+dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100591F000E9;
	Thu,  6 Aug 2026 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786029646;
	bh=ZyiWLfn4i9DJLzSB7Fnhkm+6sUdCLb6IzAwTp3gRFPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PA1XF+dkpreNIIGRIWSp/KiulwG4gs++STnV4H5ySRcK5oGnQOcLdM5rOh9igvCe9
	 qXAqwM/xUfYwR/GT9mlwQtxI9pQfwK3xPZVbrDUM3Zu2XIbbjUljfXZB7GNqn+fJgC
	 p5zVrTiJ9k7WiQ7bqEWaCbboSwkNRjqlIOQYHkHZLDwXh4ty9F1d2p34IquB4SBpAa
	 GNXTFpUueX33y5QT6WZdv+ni4Gv121FI+CXOvtij0UwJEu91VghwrJiywN6zg6uWSK
	 f7mmqCPMqh/KQahuNE8SpASr5T0p46RqznO1iosvW9Gf7/KIxP52Xlbajm1/dwmclN
	 noscNQnr2sKzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2C380820D;
	Thu,  6 Aug 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178602960514.1333975.17839022231659546848.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:20:05 +0000
References: <20260804201919.1148015-1-priv.luk@gmail.com>
In-Reply-To: <20260804201919.1148015-1-priv.luk@gmail.com>
To: =?utf-8?b?xYF1a2FzeiBQYXRyb24gPHByaXYubHVrQGdtYWlsLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 22:18:30 +0200 you wrote:
> Current limit of 64 is not enough for Sony Xperia 10 VII (SM6475).
> 
> Fixes: 5640227d9a21 ("net: qrtr: ns: Limit the maximum number of lookups")
> Signed-off-by: Łukasz Patron <priv.luk@gmail.com>
> ---
>  net/qrtr/ns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: qrtr: ns: Raise lookup limit to 128
    https://git.kernel.org/netdev/net/c/7fc1c937b6b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


