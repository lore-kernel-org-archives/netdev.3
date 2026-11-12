Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483012;
	b=L1sJFyVRhWA+ksXq4NYadzzsdnjEUM8oNpbAhzcZpbviQLy+jLNNn7MQYTPSU1yQRDtY
	 KAlrWwiSpno4jghfLKQsSFCGJURkWbjfvjsXijS0bZCCpbHyVTVSvqL593rlCwqvwZHVB
	 5I8JokhgFiUj3p9BVov0JIrRSZzf05dLNvPikHLmu81F5G+/qs4rEKq3taS1jyk0gj87J
	 QML5iUA9wPHahvlIQYwHqcuD+EQjqQaisQ1QB5ekeF3UFyIonPOmhq5oV7QxvzQW7pZJU
	 /G3c7GBxu59b9aSmX1W8QFQWgCiacK0KLskito73/M1Pd1tXarZ9jBzvQdtxq2oYveQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=71eXGQdP5orJZyLCzWbG5FrSvWsmlQU9DIpmcnIuT1I=;
	b=hIy3gWDIrA3TxmP3UWellvR/nHrSKCTf3FPZpJmhC4W6Knir2XUx0S8r6c4/ZL7LPbqy
	 r9XGmFoM+zBDrUE7wfhxMHSECFRp6e8LW/91bT7JakWbFqBOjVQpAzE5uCWY+hwCBp/01
	 Ct0AAQse/IFCpNodz9HOadtdb+4hpseOFomoH2+rSF0YKm2naJah3Rt1OGKBfChvCpzXY
	 3/9IDvRrKYZuijt7IntzsrZM+r/oZzwnHIqcnwtHPYx+KJN5AUJ8wnpQYDNH84f4/W5Fv
	 5gsstE3vCNIln+thpCwDW5e8qb01R9lcLauONttdPmot3pBqxpk3rpIFTeGcuFg22SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaWgKLUk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3324606A895;
	Thu, 12 Nov 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaWgKLUk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201871F00A05;
	Thu, 12 Nov 2026 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483012;
	bh=71eXGQdP5orJZyLCzWbG5FrSvWsmlQU9DIpmcnIuT1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TaWgKLUkHNHi5N1Egi50k6plrFr+ducVKv1DY5+VQJFIWTAaa7vFpDqClSsKs4hAp
	 H0+BMeYUvayjR3hGtq7saJUyYo8a0b7koTHyJXkoiMfJVeMNhYyyYnEw9Z1aE9UGnX
	 OtFEqTIvnILejIeU8vkKe8d09bNktmcLwtnz+LF/P0MhgVfUjxmVDRvU5x7U9/wNoZ
	 r3wF6y8TCErWZ/ucAxJ+RTZPdGouYP7AgvrkDNCxhUwE+Rz5Qf/M3J2rzuRO528uJi
	 DX1O+2BHqt+M2fdatAXs15ml2J+GguKhvNh3XF3QHOJxESNxmqNW1dL80/Bte/6wQE
	 W9zrhtY7j277Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1483E3AA9F6B;
	Thu, 12 Nov 2026 11:30:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Fix phy_device
 leak in
 probe_netdevs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448301067.2033939.14773001196867592120.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 11:30:10 +0000
References: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
In-Reply-To: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 alexandru.tachici@analog.com, ciprian.regus@analog.com,
 linux-kernel@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 06 Nov 2026 15:23:03 +0800 you wrote:
> adin1110_probe_netdevs() probes each port with get_phy_device(), which
> allocates a phy_device without registering it. The pointer's only use
> is phydev_name() for the phy_connect() call, and phy_connect() attaches
> the device the earlier bus scan registered, not the one allocated here.
> port_priv->phydev is then overwritten with the phy_connect() result and
> the allocated object is lost.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: adi: adin1110: Fix phy_device leak in probe_netdevs()
    https://git.kernel.org/netdev/net-next/c/acdf2d09fa18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


