Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B331F99A;
	Tue, 29 Sep 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649009; cv=none; b=Vwo6E++G7bpQQJr6mbYC6UNf+yV9LBjQyzQn4vQ8CuceM8nqK12EfX4kXI1oKBma9ncotB84db/NwNx8Y+Pju9yVHC/4k6Jr/qW71Po+y+jcSL2G9ufazJuVV2y8Hajh/c4xkAXtYIJXLPflF0WVUCkQZtrke5O7VU0vL+zr4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649009; c=relaxed/simple;
	bh=fEbfZGVGWOij+xYxDFLGgs42sAkndtV6HoFl8oECxF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gW+Q4JsNDGUe4jfORzUID0cZkSYfr29oz+KVIZC8Pg66F/ychJHGudq5/5s3oDeqzkRqACCRAqt01TmtBLvIcggiVkylBKVnmbuiW3oAvp+dlE1krB0lvgcf1lWSpc9qIXCCjqhdzoSMWICWrDaRyhMaZS4MVgT2F1X/SxQ2gcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbTYu/ZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbTYu/ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448751F00893;
	Tue, 29 Sep 2026 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649008;
	bh=b6w7zFMeiJz+ojzh7XjeMhVPcnjyTUiTQ1MePp/HWGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KbTYu/ZIhNEzck3rl5RRM7F0fvqNvmmmCZaj/iMYsa0nJ/Ac2yQ8tZvuThZegNn0M
	 6sanfHzxhoxX25NenKBUiMIKXaCwrQdVv9ASKSE0/GMoUnWBrrcfr8EB4+Sev/iHcd
	 tp/8iKRHq+hZXKfciHxYEXeXGXpDQTlpTwcC+1UmguB4T9L6b6RMNlJKGNk4YlP7v9
	 2iGxjP05R6cYHQFom1ruNxUFVglJaqphdQ3kvmksUFHRkYJFXVqRzNNrsExUaICogH
	 8DtkhUbybExHG9jdZEVs8h/0UBi/jyn+KH0/7y2PXAUTAsWTBLQaiBeTfNsvfIBqXe
	 3fc8ktvHPCMbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2E03924FF2;
	Tue, 29 Sep 2026 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp
 provider index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064900677.226715.13770659293828903015.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 02:30:06 +0000
References: <20260925135237.3432266-2-nb@tipi-net.de>
In-Reply-To: <20260925135237.3432266-2-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:52:35 +0200 you wrote:
> A provider index of 0xFFFFFFFF picks a provider on hardware that has
> none. phc_index is an int where -1 means no PHC, and the u32 from user
> space ends up as -1, so the two match.
> 
> TSINFO_GET uses -1 for "no provider requested" and answers with the
> default provider instead of an error.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethtool: reject an out of range hwtstamp provider index
    (no matching commit)
  - [net,v3,2/2] net: ethtool: let tsconfig reach a PHY-only timestamp provider
    https://git.kernel.org/netdev/net/c/036778a4fad1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


