Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527018;
	b=U7W3ZAJOjfgeNQoA3k5EEv8+5x1pTs2gJeFbce6C//cehssWF7Etjg8SrZqiA+WR0IYG
	 VGQmgPiyucnEV0MnWxSM0i6BkY++uX760g+sw3DjnTQBq+Liql1rLqfXBvvmwsH0ZNqfs
	 o2TZy/sJNApspop7q3m4tn6xp4ctADgAw2OEWV5tVvZD35GB8DoGbe2U4Lb54TnWfPSSb
	 m3j/REYaPHHogeXgHzHv2oBsnxdIFVo32cd9ZDHPCNmF9VMDyvZn59wDNsywYbqZhssXz
	 mE//G1ggpelgqAn7IQh6Kv7+L7YftHBRD/AsLRsIjaEeEJwUrJg9KIFYzihIAjpw5Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=MPEk93LBm0iJwBdLoARQ321u5Nm45b1//8fq9Tdp1+g=;
	b=h8WwPmcTvao22VyGRPJa8roYk19L036ECu1SJ8E3m8+M47v/3RpXQFovQOTEZinpcikg
	 6MKoVm4SlbYMzsTEGXD1iyTO9bTzXpxjeObZBtZpV+rcrLqXktSJECs3Ng3ZYHERRe49K
	 C5y1mWmHRFtowPVvxhoamNjhVEF1B0rORPoPtbNQKqU3Wh2eL/O2HSzidWUdFL2bSh76T
	 Soaoh5AFQH2VoEBfDqJC4ZGPk7umTScATxoNpkc+lYMQm6dyfM9Ohh83I6BNjiYRz+ow+
	 Ib/cNomh2fU2Wp+4hpwEMylXvvJ0FdUCYKezQiCgVrEs57J2zvj+qLkvMaxvx6L0wVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yvd0Ea2G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEE606A32C;
	Tue, 20 Oct 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yvd0Ea2G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F081F000CF;
	Tue, 20 Oct 2026 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527017;
	bh=MPEk93LBm0iJwBdLoARQ321u5Nm45b1//8fq9Tdp1+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yvd0Ea2GsHae7Xg3sIlLy+ORGSIpNtGoeIaVd0H/+iECaWBOJm7R7IWIx9mNdbDq+
	 T9+iRcWzBTxRhBaOSs0npGO+dTc5B4TWeiN7DGPcVZ/yfpupA6LETsUcMw6iPi1nKR
	 bf3XghXyip7qxudbKtxu7lPyl6LkwPzIzqb+jjxTV1gof92vHHyNi/jOFUEkeC9prh
	 J1djmD3a4b+ft+9CoE8MvcKHZFrdMHAsY3OeiDFQ2hZno7d0BWo8aYhl9IAMsvhnfK
	 huLPkHLR21J9aLjgzI+CM34Q/g5UfEXBH2DY7VcuG+2WQhOAQYnXnUEMrDd2Y/L9yD
	 eq2ITX4QJy8qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774023809A09;
	Tue, 20 Oct 2026 20:10:17 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: phy: realtek: restore RTL8211F RGMII delays
 on
 resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252701602.186787.14998467033083522856.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:10:16 +0000
References: <20261015045001.83986-1-kmehltretter@gmail.com>
In-Reply-To: <20261015045001.83986-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 06:50:01 +0200 you wrote:
> RTL8211F and RTL8211F-VD both use rtl8211f_config_rgmii_delay() during
> initialization and share rtl821x_resume(). The RTL8211F-VD loses its
> RGMII TX and RX delay enable bits across a software power-down, but the
> shared resume path only clears BMCR_PDOWN and waits for the receive clock
> to stabilize.
> 
> On a BeagleV Ahead configured for rgmii-id, carrier and the negotiated
> speed return after an interface close/open, but the receive path does not
> work. At 100 Mbit/s no frames were received. At 1000 Mbit/s all 11
> observed frames had CRC errors.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: realtek: restore RTL8211F RGMII delays on resume
    https://git.kernel.org/netdev/net-next/c/20c0c6773624

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


