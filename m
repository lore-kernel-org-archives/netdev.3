Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402420;
	b=qCU4lvKy4rbaqztTP3MWA2G6K5cPxcrI9d4YKhNZiVrRt1MA2ooerUUQAgZxnOm2E6M2
	 4y479rQhsnQzq6/1KozsI4uCA6S2IiiAEhOerJqir2c2BG4Q798Ib0N6GQmN8/LF2VdvK
	 sn7Hq4OX5ki7QiUdMk5vIi6Pvqp0P4Qkffn/KtYBWeTaaDQY7e5IcDHiWmxC7yxNobmhf
	 auQzI3iSfSQNt0FsF4DIWlejYQWxey5FvL3WpZ6IFZ8UnEblM5ypSw41vxhZacFlEEHlc
	 /ILx18TPFTMsT53cw9LNj/uWha4uPWq59msr+/iWZPgNiriZXA+Bu6UPVmSI7uvtStQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402420;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YquaAYk5D/ZosrhPBkdkrqLrp23/+y9lm6zoH1BKULs=;
	b=Ixr+E7/8FBTdu6cy/Qm4flKeJe59xPynD/PPpY+XtEHRchZMSkLRNa9s1SoWX0CbVyhD
	 Pdb0ewLFXp4Jpu6MoTqNqAjPTNsoIjtcAhs/8UxV7mpOcIoykDPBLRmDbDoVQ2G1lBu77
	 Pxrr8VSl7I+XYhgfDXrRNqHK+c4U8oMF4AFY3jcLE8JvLjmI0C8q55ZPbXlyxtfWsbPMp
	 qMmT9Uh++efX4Fx0xTzc1pYODYV2hzFucXJRZ0avbneJ2F2yChfevWsdeS2fQ79Fd1yxu
	 dHEZXte+/jSOP1bzCeUd6g/hxFmWuxkxAx7b4Z9lK0lrBpEP8g94kHBMCsjijaBi49A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYhDfDdT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15E606A323;
	Fri, 30 Oct 2026 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYhDfDdT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54021F00A02;
	Fri, 30 Oct 2026 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793402419;
	bh=YquaAYk5D/ZosrhPBkdkrqLrp23/+y9lm6zoH1BKULs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JYhDfDdTorJRcAHfHgN/bI6zq5Ow7Z8+QQah+IUfbz0iPAbOqW9XES4nnoSzH9Bdz
	 4tXTmHDCOJLoTsTwJg68lAYvRD0aEbuACw2Csuau4cPxaaZ4W5ts+zO47eqsbQTfCk
	 F178bqwtLIQmbdvaoCpYu8tJOb+2Qkhwp7bdT9vywyn1xfnDmC+ZTGAU8AC6H37v+E
	 dWludCJNJdvquOzWv7ROyU8DI1Ou5nz2EggV6XJlr/4jVXZA3YBiOk3U486lpk5gmO
	 nadVLfvd//k5ArMm5F1W+30wcxciktIFwbDTrN1TaOTzlGeVXuoXh44kfJqIy3I2QW
	 Km8My2z68a34g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA34A3800478;
	Fri, 30 Oct 2026 23:20:19 +0000 (UTC)
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
Subject: Re: [PATCH net v6 0/4] net: ethernet: mtk_wed: misc fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340241829.1826218.13676561512081686871.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 23:20:18 +0000
References: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
In-Reply-To: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
To: Zhi-Jun You <hujy652@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 17:57:27 +0800 you wrote:
> Ths patch series includes some fixes for issues that were discovered
> by Sashiko and one original patch fixing issue I encountered.
> 
> Patch 1,2,3 fix issues that were found by Sashiko.
> Patch 1 was compiled test only.
> Patch 2,3,4 were tested on a mt7986.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/4] net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
    https://git.kernel.org/netdev/net/c/cb50f16f37fc
  - [net,v6,2/4] net: ethernet: mtk_wed: fix reset condition for rx wdma
    https://git.kernel.org/netdev/net/c/7180a42d8e61
  - [net,v6,3/4] net: ethernet: mtk_wed: free up rings during detach
    https://git.kernel.org/netdev/net/c/5b8d12512cbd
  - [net,v6,4/4] net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
    https://git.kernel.org/netdev/net/c/dd6efae55291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


