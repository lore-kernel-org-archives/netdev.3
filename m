Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95335342151;
	Fri, 18 Sep 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771273; cv=none; b=KOyMa3EW9t7C/MzZfsktUEt4q1llHoS2y0MhKv/Pw7ONLOCIXiZY6mAdf1ZuQS/WiOwTtskcKkgUfoQsVsoaVKztUJJkjhKKdKvZu5nNy8OEfkuE2v2fLtfx8ng41hx5y37TbjTYA9kjV+I5bgxkp6Gfwh/CUMxf9nDjBwIX9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771273; c=relaxed/simple;
	bh=T38oF5WZpw2mtVb/oW4NngMiV1ZoKhAdRdeRgrbG/0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HoGJQtBFMSXO1M4U13USbof7DeMGF08TlOvKZ+EQaUpZ9rVcTfy5lx54jhPIUp/xvgtmo9cCvP/52k8RPSMd3S5E8xtigd0NvalLNR7opSK2jDVbpojlE3iyta70qaBA8VbLI6ofKUVhtoURLRAXxUoOLRaPeiywG71CCQs3vZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opI3mdhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opI3mdhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6F1F00899;
	Fri, 18 Sep 2026 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771272;
	bh=PZzHub50NUiUKPaVsrqQyrqXavK1MTD7GO/OVlppjGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=opI3mdhzaGjrf9VR0oq+Vweg5Pg+4c+lpro4Ht+uFlMiTu55lBYVKfl2V3KQtRlo+
	 +iapi8VMzr3Ob33vPU2Uw8ylYXQGtlxgd7/qBKQlOlT9ms5+UAeiaeD4Yq96GhNkUM
	 PTCBu42UPxZkHAnSjhSD4UNeHhZcNi4MWX92evja+kn40Tjaogf0o1IPONXDVF/4JQ
	 R7O+Ntv4xWDtTGo9h8yoWFTl9THc3y//VrIOgBf+zduJ7J7GmSIvkNXF8l0/LWgXnB
	 a9Aw3WT+quSoMTeOiybV0/p/yxBYOc+yFijPK/c0cEg+twpgr0eG0sO9pVW/aTHfY1
	 xV5RSWtJRQt3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A70381196A;
	Fri, 18 Sep 2026 22:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset
 name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977120515.1175834.1142348377403795349.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 22:40:05 +0000
References: 
 <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, dinguyen@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 01:05:59 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Arria10 SoCFPGA DWMAC nodes use reset-names = "stmmaceth",
> "stmmaceth-ocp", which matches what dwmac-socfpga looks up for the
> OCP reset. The generic snps,dwmac binding only allowed "ahb" as the
> second reset name, so Arria10 DTS failed schema validation.
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset name
    https://git.kernel.org/netdev/net-next/c/0a9b6e9385dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


