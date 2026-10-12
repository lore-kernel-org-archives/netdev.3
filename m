Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F34B826D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825007; cv=none; b=Xl3xPTEsn7qVaRxNp/QhZtyydx7QY+Ej/kkPotDDYUDjVVLHFsCKhbYlJi1qdcjrsBBIYgBsR1udPA8exvMUwjPygUbXTDtl4n+si52cfwJ/tCfLckwh7y7Lthx7Vi/WNJS/AmSoQMdECLGczOMB0yTsVvvCkETsqjs/ZlGWACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825007; c=relaxed/simple;
	bh=i3W/qzv0tKaqh2XLk480DaW+TgrzoKWxokfDhA6aU1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vGpqgNmP1SITkveQ8JlGkjLrIwyQLFoyeQYgeRP3trf4yd3Cq0rkVWK8ngvUST09RwRKBHk7pm3jkXkopJrI8phSt4K93Ds6HGD8OyWE4nfUbvkT16nmO7Fl9fHXZ63NmyFGIfRdqY6Sx3P2GGVQTeIud90ZD6iwplcmxxon2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfSUaghC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfSUaghC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F631F0089C;
	Mon, 12 Oct 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825006;
	bh=hc/oIL8Ed/OJioHm81H3P3M65VQzRDdkE//KITJseZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GfSUaghCPh1Ns33aE1cAVACMlIu1Q5BVrR717Zdly6q5JrwNVHzWrUbHrwDSF63c6
	 HeTcp+9j7IboC85/01+1TdlZeKozIEU26n7IuyM7aCO/CXLXzi17GoN5GSHXl+HJFt
	 CY74rfhGvuLBBFC6kOLDSKAGlJwgxyFrWfG5mgBolrbRxbWentGyVyvdCKiG3D5q+M
	 zOMmELMldxVZ1+89tkuLeoZAVpkx+3guzUrrFmTMdVvwjeVK0khDMgoF+7icvoqoDl
	 zH4Up63wq8JsWo1XVf5B3XWc2TbkeeNAOvmx+CQnMXqiWk3KkJ0+Tn+CNTE3o1AjAt
	 BeQyw8agNa9RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774FF3924A64;
	Mon, 12 Oct 2026 17:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: Introduce hw queue priority
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179182500527.3547638.11327393351212473123.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 17:10:05 +0000
References: 
 <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
In-Reply-To: 
 <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, olteanv@gmail.com,
 0x1207@gmail.com, daniel@riscstar.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dcaratti@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 06 Oct 2026 12:46:24 +0200 you wrote:
> Implement the offload of the tc mqprio hw queue priority in the stmmac
> driver. This feature requires the mqprio to be configured in channel
> mode.
> Do not overwrite real_num_tx_queues configured by the qdisc in
> stmmac_hw_setup().
> 
> The misbehaviour has been reported by Shashank and the patch has been
> tested on a Qualcomm RB3-Gen2 board.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: stmmac: set real_num_tx_queues to max(offset + count)
    https://git.kernel.org/netdev/net-next/c/d12821266759
  - [net-next,v5,2/3] net: stmmac: align real_num_tx_queues to mqprio configuration
    https://git.kernel.org/netdev/net-next/c/ac1ca0c3e139
  - [net-next,v5,3/3] net: stmmac: add tc mqprio hw queue priority offload
    https://git.kernel.org/netdev/net-next/c/47891d501e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


