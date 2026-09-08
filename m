Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03F5111A2
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864075; cv=none; b=AD2Kau4RobEzS6eQjY5eA+Pwnxb0ej49IZHffVfdJjr0g6061HckJwyMnAFE+eOeZH6NPaiElPa6LYPVGtIgRifr3bf2HlUEt7MS9w7XwgXu+vnIends0t5m53l16wBZGZZt28F27WofEpHM6kpFfKZ9n20L4dvj6DBMVskbRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864075; c=relaxed/simple;
	bh=6qACb54bAslVMl5r4lcIkDbpw2OBqwpC2H6o0ifKjDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JOzd1GAd0mHUF2WW9g5gM+MlvgSznsDZQ2osEiZqBGdloRzxs0QOfj7TpJXSHqNzGbp5Y3fhHAn7ds65s+DPUN0T2vjnDYipnR3BmIwS9DqRxW0uEaoRpHmyR1zw++95bboIp+hMvl6Wz8VktW0zRIFmZOhOYw+zVLkQHvsEdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8HvdGGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8HvdGGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E91F00A3A;
	Tue,  8 Sep 2026 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864074;
	bh=RHD8IrQl5u0Gqs6/xj9K+JUgs0zZxr9nHXnSun9KqFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A8HvdGGPXHHNMwMqtnt0UiZWgEczPKrBUBoeVsDMicADtRZzLnmMauXg/sKBb18Hg
	 CO4kCDtaIlgUKXoneEyLh3F8yPICNbFGFxjn1KSYXe+BRrnuX+l3YBJNPh5L4YVWKU
	 ll5wKqzY4NF+UUrEwXVoPRE1jS2CUiFMNrfTIrQYc7Gc2I0UKfobbJ7WZ9RXloZ/HI
	 7TwWclF/+x9TcuXfQr76mGut9E19q19ZJOuMFZVHFR17haG7+DbYtoKeCloDbLkuhA
	 i7ftyqWs14yD5Vgov4aMwgNuayBuSrd6HinSkFvBxtZtDcoqsvrHnjufL0UzNFCRG/
	 OfpoKbRIlziXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987939E960A;
	Tue,  8 Sep 2026 10:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] net: ethernet: cortina: Fix RX budget accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178886401289.3456676.16492072909893276734.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 10:40:12 +0000
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org, joe@dama.to

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 03 Sep 2026 23:45:28 +0200 you wrote:
> Finish RX updates before releasing NAPI ownership, report actual NAPI
> work, charge dropped frames to the poll budget, and drive free-queue
> refills from consumed RX descriptors.
> 
> Track RX drop state across descriptor chains so discarded frames are
> counted exactly once.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] net: ethernet: cortina: Fix budget accounting
    https://git.kernel.org/netdev/net/c/a0de06d0da78
  - [v2,2/5] net: ethernet: cortina: Finish RX updates before NAPI completion
    https://git.kernel.org/netdev/net/c/baa26841cb9a
  - [v2,3/5] net: ethernet: cortina: Count dropped frames as NAPI work
    https://git.kernel.org/netdev/net/c/b856c552f556
  - [v2,4/5] net: ethernet: cortina: Count RX drops once per frame
    https://git.kernel.org/netdev/net/c/6520198c430c
  - [v2,5/5] net: ethernet: cortina: Count RX descriptors for freeq refill
    https://git.kernel.org/netdev/net/c/e89e88ad41d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


