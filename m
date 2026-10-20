Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495208;
	b=U+lENLgxP66N/aB+hGVkkPK+Fs0KJ03p5uZH+Kzb9M6Nxk9VZXGpL2RmUNrbGYUQ6uUm
	 p0SNeBjLqqdIgYfWVIKVhJhqCOLf5sXXBgf5rqyPZ3L/Qv+CM5eNkJ08BCiFSFGwqoMRw
	 nelhRibeU7YAmWpJ9UYf+TymIgiXa2nmKp1GIO12JJIe+OM97HotQNr1wcKY89KbNbHsD
	 Q3xMKW1ojrKV+45q5igyxeV/IZr2KSpkcTCvXkejrY45Obq6IMw8uBquQWQ6W2zdlRXxV
	 TYnjDcdVZPFVzoSZypaaS3xgy8aRgYcnhru1teff6U8ObcM1zzEBA07uOBpcqPqDllw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PStXvf3iUmXPcABgpAYzb33URw4ffKrt5L254s0zmQA=;
	b=zjf1C+O581GsBMZy8NV0a4fgGm25eKE3Mph5vne3x7/2U9tnICH4G5BTrzqctMwOtysX
	 6MqljmOhngclbREG8oaugEm1mzYeAGnnzQ1GKQmWpPUJPqDlgtriSCGN2z2WHmXNv3M59
	 jYxeUo0M+KJLnSBORfPSM5+bxVDGVwMqPTzTCTydkkfblE5jD5X6sR/ubnarfBOneclE6
	 SaRrUFpWAmMMioWJjWclt7KQnMvZitZU6h1r6yxg6NWSmimrUkypoiWfx7yfnYZgTJNVB
	 ltVvOfG0LaYkNSleXMyhu9fWes7WLOP3Qhjxk+LpA3GTS51sM5Tm+sH+Ruyhgr4fbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAHXjRzz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85700606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAHXjRzz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5B1F000C6;
	Tue, 20 Oct 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792495208;
	bh=PStXvf3iUmXPcABgpAYzb33URw4ffKrt5L254s0zmQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UAHXjRzzdxfR/ULHHEnHgMSTlKsDykG/sG+9eG+RIaMqPw6SDTn64CI6BZt1bQIef
	 qAnBs8eF3Ox+C8rM/Tia1qaJ6M/o4bgYikKm55IDQmFJoc4dd0J25dZwG39lbhWG3o
	 5i1kDgPUTig5tdUf4xg1+uByBg7j1YKcyDmJs95NNhPaY7FTHeMSR93/slISOP1rGc
	 dm+ScO9L+/l4PvZ/ATjldNGPBB7D2SkJ7T81PqAB+iqcAYvMHgfHS2E3fIBfIIp+hL
	 qedrcdBIDA+fqTaaS+kGgLCFC65tFeNW0F496ea8Hs92O5wQGB6PinwraddOqcL+qq
	 ZXvPjIAdMG+Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F149E3808209;
	Tue, 20 Oct 2026 11:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: stmmac: fix mqprio and cbs combination
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249520652.3674783.16445702452498504687.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:20:06 +0000
References: 
 <20261014-stmmac-mqprio-cbs-combo-v2-1-372249daa81a@oss.qualcomm.com>
In-Reply-To: 
 <20261014-stmmac-mqprio-cbs-combo-v2-1-372249daa81a@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, dcaratti@redhat.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 daniel@riscstar.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Oct 2026 11:05:25 +0200 you wrote:
> The channel-mode mqprio offload and the CBS offload can currently not be
> enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> mqprio offload as soon as any TX queue is configured in AVB mode, and
> tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> is active. As a result the combination is rejected whichever order the
> two are configured in.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: fix mqprio and cbs combination
    https://git.kernel.org/netdev/net-next/c/643f9c0bd877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


