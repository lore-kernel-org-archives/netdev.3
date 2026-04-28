Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D13194C98
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337461; cv=none; b=cLYCc8QOq34ciMb5TIUAu99x+0uTRcf63XVhuLdreofr2RYEwWVL1PyBO6jfYzuEZNOkjZrJLSYprH6a5pUmujDeDLn4u0ryV24hP7GdlpqgdKoKQTknoXYflSB47f2n97qlFa/3LZj9Q+N9XgSkS2ki/z8ErUUprwfJyLVFUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337461; c=relaxed/simple;
	bh=5Ri8joccBWwhmyuhXiC1KxUz9bPRfRNan1t6eJUwBF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZdPYrb//6/SmL6oE3aafQKX4bLYJL/NarVAHcnbbv5GR11i5KilPSp3UTpMvA/NdxWkZheYtdD3TAfDG36rohvBmcJ5ecpt9691ZjvfKzjr9eOSJYie3rZIXmtknNE4fbfNtRLoOcH3Tp1Neo7KFzZZbIwwA7SDCKzOfrrVcgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/aPE3Ni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/aPE3Ni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442DAC2BCB4;
	Tue, 28 Apr 2026 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337461;
	bh=5Ri8joccBWwhmyuhXiC1KxUz9bPRfRNan1t6eJUwBF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/aPE3NirdiDQEeSxlWHEYdYma2Gt4QD1ICwCL3RppzMGrxq4x5PPRsdu1O5O3vcT
	 HRyB4Pj8E8O3od1jV6iC+qskIf4y0Nn5qgNuYlCkz86B9z4UhjXzafXqDgJn09da2q
	 Jw3BSmi+p0UMVPNEZmpnJ0GJnMYsbFk5RN8wApJp8ToBQ9gl2NutZ0AnBgej8dFvRu
	 5ph/tP2NSdDUw6y6gawin3dyCEYam3PDkQp6cuyrugSitv7iI151oV37TyZEnpnSPS
	 aXNEApI3//fwf8tW7kldmzAaxvuqQhtohcSf7IdjqvkufqT8cLqCo4ihLssvPDhNeO
	 q6xVIv2b3lneg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D0838119DB;
	Tue, 28 Apr 2026 00:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: stop net_device TX queue before updating
 CPU index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741829.177472.11417413578434219767.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:18 +0000
References: <20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org>
In-Reply-To: 
 <20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 08:43:07 +0200 you wrote:
> Currently, airoha_eth driver updates the CPU index register prior of
> verifying whether the number of free descriptors has fallen below the
> threshold.
> Move net_device TX queue length check before updating the TX CPU index
> in order to update TX CPU index even if there are more packets to be
> transmitted but the net_device TX queue is going to be stopped
> accounting the inflight packets.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: stop net_device TX queue before updating CPU index
    https://git.kernel.org/netdev/net/c/3854de7b38be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


