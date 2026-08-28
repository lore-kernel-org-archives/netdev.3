Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AD3B38B9
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958075; cv=none; b=kjrkZhCS6VH/BXdVlfcFIjEMdrD1NpJ45Dacm9NrRF2tA2Nkc/ZUmfOGxNaD3iJDAYefhzL8guX300F9bd/Tcmn4aWP+9+Of6yU9+GoE4MD845zuiyeAXmiNyeSV6u1EOICZ1CFemaxB3A/cI6wlqs/TrkplmOuVtdlKOxeRF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958075; c=relaxed/simple;
	bh=3mtJB+vN9frpX0EF9Mn30sln+jEYP1VU52bHG/PRUW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYp0R4aQbAGksoDna3sMLvGwyjqPBUUiaS2rfy8VFBgiSgeThpFQRJisEBaE/psg5E/IFTH+j2woBTp9D6VPE8dcMjBqlk3Bq5vSfdO/uSsHuodo+KoCkW1D0tnbM3Ps2NL6Xl5PTE+VmK4cpoMNCXAvqMWaK9U8Tk4q9Q2bMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDCcBG36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDCcBG36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696051F00ACA;
	Fri, 28 Aug 2026 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958074;
	bh=xFstvIMs/UFjtgJYo5bu/dWM6Jmn4cmpf1U+qSmRq6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dDCcBG36VRwyA0V/ovYTbGuuc73BvjEP3E0aplIrPASaQA7+Bu01n9XsGIZCqBHGl
	 H4Ut9j8joQ/2htbX3XeZ9JE++TKFwD7LkgVMrIhgAeG5TJBUdc/bsT0VWOhVYk4+Qj
	 Yz0/kkOCZnfIjobbWQESdec4YZtAh8sPHrt2pgl2DA78AFQuIbQLRfxeK/PbyeyO8E
	 X4DgQoscxatiSzQ64v7pbWuthITIm870X9faKrs9c7nnRskQKXx5ssE0XJDHBoziOL
	 dyJ1J6JBflIiFfoBvysqdc/x+Pp6u24r8zKqiog3M+n2RDkm5VANXHxEkBlnYIBQrJ
	 s601fNC1VNqBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BE7380AA69;
	Fri, 28 Aug 2026 23:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix dma mapping leak in
 stmmac_tso_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795801914.2832451.15311149426122781543.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 23:00:19 +0000
References: <20260826-stmmac_dma_unmap_tso-v1-1-a2753d1576ba@oss.qualcomm.com>
In-Reply-To: 
 <20260826-stmmac_dma_unmap_tso-v1-1-a2753d1576ba@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, hkelam@marvell.com,
 0x1207@gmail.com, horms@kernel.org, peppe.cavallaro@st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 15:03:15 +0200 you wrote:
> In stmmac_tso_xmit(), if the DMA mapping of an skb fragment fails, the
> frame is dropped but the DMA mappings already created for the linear
> part and for the fragments mapped before the failure are never
> unmapped, leaking DMA mappings.
> 
> Fix the leak by walking back over the descriptors used by the frame and
> releasing each of them with stmmac_free_tx_buffer(). Moreover, release
> the descriptors with stmmac_release_tx_desc() unmapping the DMA buffers.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix dma mapping leak in stmmac_tso_xmit()
    https://git.kernel.org/netdev/net/c/a5d946466a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


