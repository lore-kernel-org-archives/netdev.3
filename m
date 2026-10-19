Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F63F8891;
	Mon, 19 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419607; cv=none; b=mXot/C8xjtfWuoZb26E7WfM72LN/hRut2zcKJ6lI2wOrgZwl/HVvnXlok4JXQXMxiVTlXOStdVaNAQdy8Fmna1aS15njCYXketbkPy8/OWJKJG1HwLAOHwYpujCImOns25tfV4nr0HVstdQCzmnFRJoOBRNg3ZLt522vDlyefi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419607; c=relaxed/simple;
	bh=GTyeng0+AYf24zx2tDZm9Txn6o+cTNrU7ZuEVNz98e8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdu2nrnenRlylzoEMGxpWYwVkOQJ5JfOvO+FhFNgCjvdzfXpKpRrdUvSssbG/E5DoD99Bjkp7yWMeOLL6+bp0g+mUOpo+eMF1w8yYDSH2m3KQdquBEz+BA8xRKBBocNalIjtqH7n2PbN4BjpvECbnY1wR2bRfufZZtj6MbFPzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ7SL1lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ7SL1lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F71F000C4;
	Mon, 19 Oct 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419606;
	bh=KInJ3paQXH/r/eztgkZasWopqYMEIr3EbinIXUkboXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IQ7SL1lwHa1IZkrRErSk20R0UtIQye5spFJXkJZdLigMmWPaBgTteNgv7G+cFh5Bm
	 EkM0Ep1MFGGWZ0JQQJ+64Lr+jrjQ6yg9dgtil9d0uSweamw4biWaUhzJqzEzBEe1Bn
	 VPhzwtag6DjmIbp85Jk9Qmp0PvSnhkZibsTiLoKfBg+vPkeTs1Mw+90pvbGSZFn1KT
	 3Uzn1uH/Isa5ntxsb8sz2pJE4NLMbmS0ND4OQePeY58vIIN/8hCTicFicUF5rwsafA
	 jKgvME0ns+VuP70zgAwOFlgl48irvHYBPitzjRgSpLMKo6inaUecAeGRkSplDoZa5s
	 iTMBsCsBUrIOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F152C3811A60;
	Mon, 19 Oct 2026 14:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: leave the datapath running for
 normal-size MTU changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179241960478.2682066.13061031646169111370.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 14:20:04 +0000
References: <20261013-stmmac-mtu-fastpath-v2-1-1e4ce8137689@gmail.com>
In-Reply-To: <20261013-stmmac-mtu-fastpath-v2-1-1e4ce8137689@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 ansuelsmth@gmail.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nb@tipi-net.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 11:54:13 -0600 you wrote:
> When both MTUs are at most ETH_DATA_LEN, the receive buffer size and MAC
> receive limit do not change. Update the MTU without restarting the
> datapath.
> 
> This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
> rejects jumbo MTUs, so all supported XDP MTU changes take this path.
> Jumbo transitions still use the existing reopen path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: leave the datapath running for normal-size MTU changes
    https://git.kernel.org/netdev/net-next/c/d1241cdbbcf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


