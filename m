Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AA3B27F7;
	Mon, 17 Aug 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995993; cv=none; b=JxletXk6MnrF5mPCWt6Oex9jaCsaELTayqQ/XFfmcE08/OuQYKSYrjp4B7uOTIX1Vts8GWQIadDRlGihfaIDxWZjZBCE1+DIu2vH6U1XMp8ONmMYsabLZBs62YiXKhXN/FvTPvqdYmOs23xGHLO8SJJMN/f4hP5DihvNL+vLfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995993; c=relaxed/simple;
	bh=k2EV+aXa1C2w8pu4WtNf2yIXwyVOwTC2dHimPLzGl5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rcaGPrw64JxWeQ0mwomHCDnwhed/fSxip1fjhcIh5doJj4sAVR5Vav5qOknKDhlYZTqu3cpnHeJPaox9I+cVlNLp5N5lf8BywwP+qPNgAQIaZiiVOSWShl/OeDdQgSciFnCc9aZKKFzv2ZEeXMo8W0jZOURZkMzXU1fcG5qBLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zll/YueN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zll/YueN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB131F000E9;
	Mon, 17 Aug 2026 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995991;
	bh=S0l/ndO/VYAORMAtNkSX1tYxaqQIs5GadFL6w9bnclY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zll/YueNPB0JNJpPWroXOsr+hmaJobuMEdN4moH9OJmziQcFJoTKAAbkrQglhllOy
	 p6I7rA00H3hUYQ+QQjr0zCXAClD7ajRfqtDeXkzEL9/sQTrv3YySCKDmkYOb1qBDso
	 E6spdpEJ4Sbh68/KAQs2iulAhVwo9gU+XRdJKrjJ3eywxA21B22LEZDegVUvqKXfz8
	 A1XHV44Kw+FEKIeSy+hmRuvKZmhfPximYw1eeqNMRyFWOvhgXa4cpchAGgs8/yTwnM
	 KOan9fNWp6xJAFMv6fFirIKfWNKltQgAHu90Ph3xXHSst+e8dDmxJboANu7+b6hFbv
	 qLGvVe6YeZLuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E43926262;
	Mon, 17 Aug 2026 19:45:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: DMA address handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699594363.1691257.7676082110902844173.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:43 +0000
References: <20260812163832.271742-1-elder@riscstar.com>
In-Reply-To: <20260812163832.271742-1-elder@riscstar.com>
To: Alex Elder <elder@riscstar.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sashiko-bot@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 11:38:29 -0500 you wrote:
> Update jumbo_frm() (implemented in both "chain_mode.c" and "ring_mode.c")
> to ensure DMA errors don't get lost due to casting the result to an
> integer of the wrong size.  This was a Sashiko suggestion.
> 
> In addition, add explicit calls to lower_32_bits() to DMA addresses
> before they are passed to cpu_to_le32(), to guarantee the type of
> the converted value is u32.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: use dma_addr_t for DMA addresses
    https://git.kernel.org/netdev/net-next/c/0c1f9020d2ad
  - [net-next,v2,2/2] net: stmmac: convert DMA address to lower 32 before assignment
    https://git.kernel.org/netdev/net-next/c/c11c497af866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


