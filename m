Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E074C6EF7;
	Thu, 27 Aug 2026 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859679; cv=none; b=C9dYaSUKWUkVGqzfZwfr3ZkQNpzne8qFVjmyb6/EnIG9y+6+OJ/vqqGtDQoEQ/qrIll8oUnpv4Nw0NrH7/1h4aLFXy5s0h9d0ZtOg3jF/EBWHfnRnPbJpEVFFuwJlX64YXtfgH3XY4tjSjAaNMsQHRF3zqIiFGbRp1f+1JE9bbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859679; c=relaxed/simple;
	bh=uugn2ai9HExjwBqEor/dmnJ6+Tr0faZfygGeTA2CFfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fvv7b4/H2OL3Yh9QoMv4W9tIfja8ETiK+TjG85UtFXxOnTana4+xXgc+ZsKVnXgfdA4deEvYtSKzLdYCmxm2FgNwSEbI1QQCyD9YEbgDjeVFs0HfTIkWMFxsiV2lz+jDEWnYilJI0HVHIQOJwx3ReAjG4h5JkC/0sbN5esG22I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsC/ztD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsC/ztD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D101F000E9;
	Thu, 27 Aug 2026 19:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859678;
	bh=4jIpGuvU/UsNaCaMDbLeLw5b82ZBqhbyFl1ubw748ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KsC/ztD0B+zlMuLKGcfxZNISNH2rF3UZjNVgTBjnnO3qc2vCaWnyY3wASrayAxOzE
	 F4JzolewCGvT6kZO3BB8GQRuxX3XrHwQsDk4Wnw3RB+IUeQW6ho89DpWkPRkAq2diD
	 JfK2yAsG9N6gZvUis/kSCnzurmz95tjAZhQ5NrYcC0KKbzUyHMiA76UQyNxzB1r3oX
	 iKznW8nCupvJaDHN45BUtMpswzvWidL0iqXCGOnosto66n+uQOOluNK72fkUglBNGS
	 6IP5MICqoLqRrXI/MjM6+68bwbjQjD50K0DQ/5HOMK3IX+pkJokBytD/Wma8k6kE6T
	 gNJ9KzgqiKdvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09663809A8D;
	Thu, 27 Aug 2026 19:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: restore NET_IP_ALIGN in the RX DMA
 offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178785962339.1816627.16266435775453733564.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 19:40:23 +0000
References: <20260824125014.47862-1-PKneuper@dspace.de>
In-Reply-To: <20260824125014.47862-1-PKneuper@dspace.de>
To: Pascal Kneuper <PKneuper@dspace.de>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, 0x1207@gmail.com, si.yanteng@linux.dev,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 DBaldin@dspace.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 14:50:14 +0200 (CEST) you wrote:
> Since the RX path was converted to zero-copy, the page pool page is handed
> to the stack directly as the skb head, and the offset the DMA engine writes
> at is what determines the alignment of the packet headers.
> 
> Before the conversion the payload was copied into an skb obtained from
> napi_alloc_skb(), which reserves NET_SKB_PAD + NET_IP_ALIGN. The
> conversion moved the headroom into stmmac_rx_offset() but did not carry
> over NET_IP_ALIGN, so on architectures where NET_IP_ALIGN is 2 the IP
> header now lands misaligned:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: restore NET_IP_ALIGN in the RX DMA offset
    https://git.kernel.org/netdev/net/c/23680bf5f8c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


