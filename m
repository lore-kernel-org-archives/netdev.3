Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CE1C3BFC;
	Fri, 16 Oct 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109413; cv=none; b=cRxvLfoUsY/7woarE1OACJHXjUdu5hD/+M1Bi6kMIxAy5GP5V2PW4OvyD+jXuLqb+H7B90mBLkbp4b7hhf3LJbLwz3ecIxYVPsqz6NBjqB9b+rknPSNvlEIsWTosiu59tnDr+/5es9PRRaVJ4sdAYe7T2ke/Ar40pfApCRgtK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109413; c=relaxed/simple;
	bh=sRTcmpVE//K1P/EDc6EXngl3uTwQaBfZGtGI+uJ7e7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKmJUu99MgUsSp8Uzz4oOnBjdfTNa3lSHMGkTfQr5dDbFPwkXuxzEEcO2OE+GU2AnZziUkYKtKuMPHXaZ6h9fO7B2tXDU7HUJJgMUV0hvOL6ra7aIma9FKQSs8yIt4UaiLb4PBYUYNTZfazM1QmxX3/JMHK7EYcwdJx5RwdWDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpPWMToI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpPWMToI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491541F000C4;
	Fri, 16 Oct 2026 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109412;
	bh=6PpQ5Q+/WxFamVACCCDqheZwVbws4LyRysJ9ya2PJsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BpPWMToIJxGTNSyNy0PntXZyirvyKv8vkL8kZvsuqjk4g+BsfmMsCSs3LzmsNUjHC
	 VP3afeJWfHMnNAAUUMLEd4gd7W9GmP6x89ebLe25KXv5hzotgOUdCr49W1t2p/9Grv
	 sjryzU090Sps2I62emvhkzPlxmaMht6cN9PqQir/ubaYEx30XHikyUpnpdWu9HA1yK
	 Fih8nggUdAlM+LcmHsy/LsiJKaKmOEcc/dBY6Pcsd+m5ZeXAK1HyfEOIvCsunVMuRu
	 +BhG28h1/QOb3MtKxjsucPclVpScUF8MVZI2lRK8n8RyBI4taAqFBTPE8ljYYXnzYF
	 YInwJg9B+MaRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3ABC53808209;
	Fri, 16 Oct 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix RX coalesce frames counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179210941077.4168191.1895696190084335171.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:10:10 +0000
References: <20261009111138.320089-1-zhangfeionline@gmail.com>
In-Reply-To: <20261009111138.320089-1-zhangfeionline@gmail.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, zhangpengfei16@xiaomi.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Oct 2026 19:11:37 +0800 you wrote:
> The RX refill path should set the IC bit once every rx_coal_frames
> descriptors and leave the rest to the RX watchdog (RIWT), as done by
> commit d429b66e2ebc ("net: stmmac: Implement RX Coalesce Frames
> setting").
> 
> Since commit 6fa9d691b91a ("net: stmmac: Prevent divide-by-zero") the
> counter is increased by N+1 for each descriptor and then compared
> against N, so it is always reset to 0. With a non-zero rx-frames, IC is
> therefore set on every descriptor and every frame raises an interrupt.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix RX coalesce frames counter
    https://git.kernel.org/netdev/net-next/c/0d20963e0aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


