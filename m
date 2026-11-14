Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616811;
	b=MS9h3Pjh+/DShRy3Zz1+uOvO+nfS98KJWNphQddR+WHZEhmXdN+DKe1ZMRr4Hvm+Lmp6
	 XCttBWKVRJAsKo5M5/B9q3AKqCGubXqfMBwIqySeUJ5uZ9YIDjPUGswb+RRfn5LPrIJ1I
	 JnJE/bxc54I0ZtLBZTCQq/p5E2WPpGmQqAU7mAsMyh0vVHf3DkTo6UefiygaUZb5r/BpF
	 hsCiRnwwNjNwT+ZucNsA2RgmeETUToflaaNfNLCNkN5+igttaLwMDLsIGR9EEZT2qmm8T
	 +hhKBVRWKqsH7GGVzL1DPlYCA7xp9PZtgYSTmyY5D18+d6yZFaaha6ZCRarymnhqwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=av1K61twRr3YmYkxqE3loSPySCWqt28yd74ZsgUfme4=;
	b=jfm2gJCdy2D61W2+G1kWxtHAn4ednnqiCAP9Fw2nRMxDYfkNQSowQveQPbha4AbwdEK3
	 +R/tYHstvPVU7dlmmirljnkMf7FZAY0ydof/RpOGcpSJxMtrvaw97h+C2PHRQj8eBiKLb
	 tpcYvHKUup+xP51FESPC1UAyJBZ2KN97aUr2V0/y5TFj9B4jqETD60gdfYgxtyjVNpPss
	 BcCBgYyYGNd9HfKf81dzpU4828AqcZ4kpPLT+W/IGBFIDBTLDbiXgDZA41/D2L+xp+ikl
	 KWfch/rb66ZjswEtT6qSxO0t5Kh6tLzPrxzcApUlfVPeXJcBpm4wBba/r37U6nPKtjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlDq+DeU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861F606A327;
	Sat, 14 Nov 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlDq+DeU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437141F000C5;
	Sat, 14 Nov 2026 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616811;
	bh=av1K61twRr3YmYkxqE3loSPySCWqt28yd74ZsgUfme4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LlDq+DeUZiAI+BHUrcyL5l3n7ruZ86Zv03rxJbgLG7XNgBHwZaozunN4+zeWWv38y
	 uFk4AH2sjXAfrI8zYqTFEmHM0U/YbABuHOWvaf/7M2HLE5vCm0rqMkxVa+Iv5Vzxp6
	 H0crPCraQw1k4V5a16UHmh48Y7GzAJwWheOxq0Kz9sj5rzK5VuJiqjQDZ2YddKFvpm
	 RlLHmHiviI2QOyURRZLQHlLqvObxjwisjNgNnAzJINnxFDFr+5Fa7jemjyKMoytIzz
	 xzIm6/QNU99fHuRqqM4JtqqbxjEu2lptaiMSTdqJgEHc3XbAWidNr/0EfnmIW0VZPu
	 SQeP1uctW2XIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3CB380821F;
	Sat, 14 Nov 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwmac-rk: only read the delays the
 MAC applies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461680977.1918448.16146594996456604743.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:40:09 +0000
References: <20261110-stmmac-dwmac-rk-delays-v1-1-87abb6592921@gmail.com>
In-Reply-To: <20261110-stmmac-dwmac-rk-delays-v1-1-87abb6592921@gmail.com>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: heiko@sntech.de, maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 07:13:55 +0000 you wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The tx_delay and rx_delay properties are only used for the directions in
> which the MAC inserts the RGMII clock delay itself: both for "rgmii",
> TX for "rgmii-rxid" and RX for "rgmii-txid". For "rgmii-id" (the PHY
> adds both delays, the recommended setup) and for RMII they are ignored
> by rk_gmac_powerup().
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac-rk: only read the delays the MAC applies
    https://git.kernel.org/netdev/net-next/c/6b8e9712d031

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


