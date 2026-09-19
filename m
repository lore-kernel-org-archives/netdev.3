Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEA175A62
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776676; cv=none; b=iHWR0gPiCYqhYV8VKHp0KXBydN17qlzMmo2aE/ObzsD5vXNSkqBzJdfaaHm0O4b4molH6OASuGDkRw8ca4SneZQXej/42+XPQwsVz5BJTqBoilmKsj1uISgthCI/GGsE4rmio2dbRmmsy3gdSGklRRwqGc9bq/GA7sQ/pi7hdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776676; c=relaxed/simple;
	bh=XaARnh7sMZwmP+BV7XdWpC005rK+AoRBFmtuencUSvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmrlzdOpsGKVzeYrHTTYA3iSpSR1nod8rmMv0VzrIAUCEFiM9oovgJe01uvGoODGLig/3HwBKYb9zA7H6RUNNXF4jPt+McYJyMsiyA0uDioMYlym7KLjVv1hAaHVsGoijheQp2uJ0Yz+DOOynb8QuDfo5R19QzrpwMuAUySJgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHVwhOt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHVwhOt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA6C1F00898;
	Sat, 19 Sep 2026 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776674;
	bh=oNsC/tQeO4Z2q9Gr+EzNpNBfohb764BQYC5T8GbHjuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZHVwhOt4T/8yFYuI/TFbaANyEu03xeeoqWrPtrCZShwzKOaWoS7onZ5GfFlIDwqMt
	 hkQ/TFweqS4kdi6GKE6v0yMPSV5YqUp5VRmBQNSw4fd2X+AKJm03UR2SkFTs/xw4j/
	 Ke8r6DdTE6fyd8I5wivJzQU7thDOuGrH/caxxpxfF3Y3t+nBsD0Vh+VblXhc90kYqb
	 Gw1NtUVLil3s+ozCbTlEGJ4jpsyg+WRN76qIOvMRwfbQRmNhXWFyAEIlGnXmpYeyiS
	 stsV2nFA1a4T2gQnDwnbc68crROur7Iu4OfPYshBuamZ3IV1JHLQsTbrHMHThuaGKo
	 52P15XOhDOo4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A423811977;
	Sat, 19 Sep 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: unregister net_devices in
 case of probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977660689.1197442.4867572793099583443.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:06 +0000
References: 
 <20260916-mtk_eth_soc-netdev-fix-v1-1-5dac50eb65b1@oss.qualcomm.com>
In-Reply-To: 
 <20260916-mtk_eth_soc-netdev-fix-v1-1-5dac50eb65b1@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sean.wang@mediatek.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 15:30:13 +0200 you wrote:
> If register_netdev() fails for one of the MTK_MAX_DEVS devices in
> mtk_probe(), the error path jumps to err_deinit_ppe, skipping
> mtk_unreg_dev(). The previously registered net_devices are then freed by
> mtk_free_dev() while still in NETREG_REGISTERED state, hitting the
> BUG_ON(dev->reg_state != NETREG_UNREGISTERED).
> 
> Route the register_netdev() failure to err_unreg_netdev so the net_devices
> registered so far are properly unregistered before being freed.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure
    https://git.kernel.org/netdev/net/c/310d1ac61a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


