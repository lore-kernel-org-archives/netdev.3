Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3073128D7;
	Thu,  3 Sep 2026 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399711; cv=none; b=GHXHOFvfJcINjWBAsx9d08rNCb6GVypf61iCpNFRhvznANjZN7BNMEbbonDJE6xPJPAypOvl2/loO0eAJ62SQoH8myEZQ6897eJHQFdd0FHX48yLtc4oy8wSY6pNHb+Vj2BCVI82/loLzVbZbUQm67ZLOdqYdRtKsRNjc8tZ3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399711; c=relaxed/simple;
	bh=gTGTFtEjGigV+KMsPMepP8MaUMo5E8OEaMOlD8s5aC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4BnrJyAP8B44jeNRmUyvatQKySujaLP4LPHYPD0n2O6GJcynr2sFJJoNzEjnBANFzNI+7xsQpWgtHB/WJRbIboooYL2orkcET5uwM1Vixls+c0if9Ah5BxkooSjIvvtsvwUazk1ob0BGnOKd/8CYHE9pa7gxcQ72VAyWUUAGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/2Ctn1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/2Ctn1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7509C1F00A3A;
	Thu,  3 Sep 2026 01:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399709;
	bh=VNSGAeT7uciZm8ppAmkEOoK7AJCszK21UEURh1WyfTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N/2Ctn1xAAVZhStSoLplbj/rpFHKNVa54aYAustpG3KM0WyDe6vZ7+lilcjvoINIM
	 LZ95/Dr5tn42WIO5lXLUPPR0CIOZ/xdikBbcJauHazcWRIWnd2NGa8sQnxCCHmJQdC
	 IlE8AMrIBc5BVVH9mAMzGXMtNkzrOSCYOlkoUlTo279PmdaqiIF+buYtWbFz2BRxj6
	 MN7c+T3SZHN4LQZEEZ+0tYrHFEgEW8QBGj2qyY/trDwO9+07k0Mp5FRWOr9VJ1eJ3P
	 apaHCn4pbO0sm91Zp+DW2fkjUQZPS99WfAcDeGjXX9uRdtEG+P7aCC2Whqb/UZjMlQ
	 qVPa/v0t2rQyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CE3927054;
	Thu,  3 Sep 2026 01:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: dsa: realtek: enable RTL8365MB power
 supplies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839965088.3035212.12735726271200270390.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:40:50 +0000
References: <20260831123637.666457-1-o.rempel@pengutronix.de>
In-Reply-To: <20260831123637.666457-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, a.fatoum@pengutronix.de,
 alvin.sipraga@analog.com, netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 14:36:34 +0200 you wrote:
> The RTL8365MB family has several external power rails (analog, digital I/O
> and PLL supplies) that on some boards are gated by regulators. Until now the
> driver assumed they were always on, so it could not be used on designs that
> keep these rails software-controlled.
> 
> This series adds a device-tree description for those supplies and enables
> them in the driver before the chip is accessed:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: dsa: realtek: add RTL8365MB power supplies
    https://git.kernel.org/netdev/net-next/c/f4d025418721
  - [net-next,v3,2/3] net: dsa: realtek: rtl83xx: add support for enabling supplies
    https://git.kernel.org/netdev/net-next/c/f82364499682
  - [net-next,v3,3/3] net: dsa: realtek: rtl83xx: use dev_err_cast_probe() for reset GPIO
    https://git.kernel.org/netdev/net-next/c/bd6b764f08de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


