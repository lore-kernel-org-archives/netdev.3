Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290809;
	b=wZ9IDakaTLgKgSj+yqQbZSRWlUP4T1CQeK9sHn575W/vdoFnSX0OLdVP7bEtQnaN1iV2
	 wV2OYTcvQF0HWsBWmQRtVuKyls0WzZt4d6shL6LtqzfALs9bN8j1/lRuj9Gkw7OJi7BJg
	 LTf//k73TZ5INbqkzqvy3Myz8CIBt63ond8mm2IyVpTqqQOwzb4kJ1dEjZ4B6Xwd7e2o4
	 zfo6GnbBLiRVX3cB4eYHGpbwC+izP5LA8azUmTv8QO9O80H16xS0PHhmWi0uWI7n0x6hZ
	 w3GxZpvrIBgYGUpHhbzWwhvzMtcN3kD4/8jHc8SL5edMqGjQBWf25fTyUEGtPsLCEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hKYbUX0m3eC9JH25HJcu05nZz+GxdZO7J7DWby07hG8=;
	b=jxl2YoxoAVBY4TDb3wZBN11RwmrhnWstSbfJZK0oQa+iLB4BgKVP0EY9WB7H6e//CTfM
	 Pd83mKOZwcbaWfvvEthnDLcFoBVhr6mAtsle496+AYhfIKhWJK3FaB9BBgR81grxYHldo
	 RnczRmnBeZZ2EE8AxVODgiqIqJLI0akEbhCY3X+TWlsRoR2u4izfTLu0IWxem0+ho6bID
	 hc30+KoafQ4OYSPz3TnUwhIv+QfgIPMYmZBKsQms4GCEjs4eu9CLpx3fqWH2Tyt5SaoPR
	 6hgKXrUkWpsowDgdyRmm0+iHNf6hA+KT5xer5yaPFaNzMV5o6D7vW3b6o9WF2eZ8MWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg+3MJDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35899606A32A;
	Thu, 29 Oct 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg+3MJDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41721F01824;
	Thu, 29 Oct 2026 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290808;
	bh=hKYbUX0m3eC9JH25HJcu05nZz+GxdZO7J7DWby07hG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kg+3MJDyS0tZPESfY4OqGHmKXizUIxNCz4FEGcfH/fQgES5Bv+RImq5OmGdd0NI9l
	 RlN+9qizMApN8RhCLgdlA0/Gsv/LWUhgo/WwFbmje7QzK2mdTs8gpGpOA/x84moGpj
	 lkoE6L8geXfJtnFvvk5T8jJKvK8rHof4mXcLbiDaUMLO4v/ZoQhxAq2aLwuik2etla
	 e0vP9lntqeRi9tFTEjwY/gGZH1M3tlvAK/MlX/5n9PMBoI9sxRQjl4Esep9w1cKyh2
	 sXuEZ81gppmw3YNYO0uQG6xOb5nd2LFfFINElJYsVBwSZKDxQKN0qKITiBdL6FIine
	 3QWh3we+tvVVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2C53808221;
	Thu, 29 Oct 2026 16:20:08 +0000 (UTC)
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
Subject: Re: [PATCH v4] net: bgmac: fix TX DMA unmapping and slot cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329080729.553408.1898969797486604719.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:20:07 +0000
References: <20261028164839.28605-1-rosenp@gmail.com>
In-Reply-To: <20261028164839.28605-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 nbd@openwrt.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 09:48:39 -0700 you wrote:
> When mapping a fragment fails, bgmac_dma_tx_add() unwinds with the
> wrong slots. It passes the failed fragment's slot->dma_addr, which
> holds the mapping error, to dma_unmap_single() for the head. The
> fragment loop indexes from ring->end instead of ring->end + 1, so it
> unmaps the head a second time as a page and leaves the last mapped
> fragment mapped. None of the affected slots get their dma_addr cleared
> either, which includes the head slot when mapping the head fails.
> 
> [...]

Here is the summary with links:
  - [v4] net: bgmac: fix TX DMA unmapping and slot cleanup
    https://git.kernel.org/netdev/net/c/4f45e97b3aac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


