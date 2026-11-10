Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346811;
	b=PckV/Vr4KPqltHQlgisa6YDTZJx09QTr3U3JRb4pjCVt+y13XmN6BdA0y2xjFFiRdVTr
	 LCTNSwlB5lH2HHzeDDp4VFaD6KyotaopL6yzIva90eiZtwj6/BYk19j3iNIrLP88iV1uq
	 kDXPKUerDvkQYx/Ogkt9bRDAtn1ctm38Fict5fSknpi8z3nyBvd32faunSH5C/fN7UBha
	 0AyWu/OGkFT31zobhLhmjWb2HfNEyzWy6wvKD53G3iMGBMKwc2P0Z6GwYVQWwPhUXm0vW
	 QHFSYzR+cJ5L2yhdVQiYIN2D9ygJmTNBH746uzF4BBtyC2Ao7w4XckHIgrfH5i5rgcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=H2zQQpARwnq+vf+Mp/QmtkzAppeZMOu3L3E13bjdY2s=;
	b=e62I0YKLUUXQ5MQGw+PANRz+xKeI+aQPosU68yM4spsXRTRiBYT2n9TscWjHcVsg3pHD
	 Bxvb5qtngtUomTVbE1KVaX2FkrpdHbkumgI1HNuoxht+XVKLi+JZanwU8pFADPzrv+gb9
	 U0VJNlFGOD1dQbkn+01Si4Dkp0ftGXczH/vM2g4+X9JNXACCL3M8zeXXiyuK8Jj2kRW24
	 kCjKgFnCDiAwbC5OvySoj9nkiNrPWXl7ixcdlJgWZzC6DkbBLEZicVS5bit4itP1FvsYE
	 8Jqy0o+wafL1lsX+g6MoV8JhHFRI30DgnFEwV27v9/PeaXEj2eG7RDZzpzkro7uwmYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhkHfCvf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8F606A332;
	Tue, 10 Nov 2026 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhkHfCvf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6D91F008A2;
	Tue, 10 Nov 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346811;
	bh=H2zQQpARwnq+vf+Mp/QmtkzAppeZMOu3L3E13bjdY2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BhkHfCvfglc88Qqknr2GUZoSd5jv5susrcb7l38IO2bokVDGoppYczf/JdDgJjxR4
	 q+xalbY2wRfo6Yd9LI9PKWjapVtcO2Lx7Y5Fo4XYHK5CNM2Zwa20QZ9nJOtNWAMMyW
	 uuRsM+/RVWDlClNbzqlxDQAlRg1ufIpCdA1qBwaX0q8VZ3BD0fWnSTebvGvCZLVxAU
	 fNgRIPwB6wK2yWHN8oqp0vh56yj+I/nziHGIEuDK1weCmcWWAJ8v1PVyVELkvd58Kb
	 hDns6136/i7IWM9+qY95EVK6JwwuV0KoCRmFHyb617kHVtnEqnve41M88AcfMXYHmT
	 CmYr0onmNL0qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210D439E8A40;
	Tue, 10 Nov 2026 21:40:11 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: stmmac: rebuild VLAN priority steering when
 filters change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434680967.71955.2289215330785245096.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 21:40:09 +0000
References: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com>
In-Reply-To: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 piotrwejman90@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Nov 2026 11:51:41 -0700 you wrote:
> The RX queue priority callbacks preserve previously assigned priorities.
> Passing zero from tc_del_vlan_flow() therefore leaves the deleted rule's
> priority mapped to its RX queue. Clearing the whole queue instead would
> also remove priorities belonging to other installed rules.
> 
> Save each VLAN rule's priority and rebuild the complete per-queue masks
> after insertion and deletion, starting from the platform assignments.
> Resolve overlapping platform masks with the same last-queue-wins ordering
> used during initialization.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: rebuild VLAN priority steering when filters change
    https://git.kernel.org/netdev/net-next/c/edf10f5c2513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


