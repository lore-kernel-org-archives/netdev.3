Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1B324716;
	Fri, 12 Jun 2026 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305213; cv=none; b=epK5GH9HOR7RrUzf3rqIJA+64OIP4pydrzA7qy7i8AvvHXIfb/je0/fhBKUT2QtiDrYNkH3QeEG4LI62XbmV8FLmaEvW2Zhh8HwbFCz2ChaRRv75+DuTtyxt7ikhtjbT8Tul2ymrTc+nkaTQKxGtfL8x79RhPRqWpOaosqKq/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305213; c=relaxed/simple;
	bh=ckIpLdfffslJHpLZX9WpHTw7HmvnQKTHrWp+Cw0oqaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nQYADd00PdsC/oMIIGOeBJByouWuGPzcUUxZykabacZVZsjeRQoZXrfPsocic8zGBGODvR0UhRvKJf/Msocpsx7nKPYFckh8N9K94/U1fv4ejIlz2nVOyGkqBdh62shSEDxiD23mZi0AwWtK3mhdEt6tPkFQq9vt3FwU8LHw2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJPgxl8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJPgxl8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B329F1F000E9;
	Fri, 12 Jun 2026 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305211;
	bh=KPPsE6Mq7X7Jv8wcIcvGg54GWecAH3/fdAe6Pu+nlOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nJPgxl8FGa1RL+UydA4NG2Qxgq6ZEgO7UU1u3BgFBkMPOFyQHgDjWD+K8Bwv7JsON
	 kpyHFg1GLaG9Sf/4NN0zHjkqwfHrXbpS6eVM4EJecqsXKaeDSax2Tkh2QYjEkbGowo
	 bIcoYkKmr7tKKyJOTDHwNHESSdaf84eIjqRM1HwqX0pOz2T2DQolb57I+piLbLtrD8
	 IKXZSbDq9M4jiILMPF3hoHk2vhhNDgePc8a7gfajML13YvltyvBpm/9ahru5VdXRCa
	 PqfMWzwW6dZ1HuAE3M85XoOqVSSgvUZlSK+M+Xw6m10WjtZOPEFE6tcHJhHSx85ncK
	 CvjE2RN4ZMvRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939ED39E9600;
	Fri, 12 Jun 2026 23:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt
 mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130520813.1282281.6129214120774000716.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:00:08 +0000
References: 
 <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 05:17:03 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
> and can trigger a MAC interrupt storm under heavy RX pressure. When the
> DMA runs out of RX descriptors it fires RBUE continuously until software
> refills the ring.
> 
> [...]

Here is the summary with links:
  - [v3] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
    https://git.kernel.org/netdev/net-next/c/d3265c19b35d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


