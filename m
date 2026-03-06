Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2433F581
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767981; cv=none; b=HW1Vfa4fapohYG2w8XC7QMnVwMSqX43gxj5yP9EZ9S4EyjGtVuUsrqHcd2tglsngIXgGuipTmk+aVOQ6DWddeokYlRUIAwvAj+2T9GYQscInIxNlFpcAqDztfOsSLXMAFUZzKONa1uS3KiEGTe31tdNDctxeGuwTOoCh2zuE9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767981; c=relaxed/simple;
	bh=SrYBJjBXm84PQmx0JBKG/XWwbzot/xEgfDeTfStXijU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcWAEmdec8tEHrUjh8ptDDuhB+yWSa3Vs8ENPiqm4v6uY7mFkVAnoqqwiahboaChazplV/sG4bvKcWfKg+N7zjKy+4qrYfD1gLDqPZq/A+vc1GRWp+315MlMV9wlN5V3MguGkX0qGxZ/qrMC7Ajl8ydhSkKxDma/ZN2g/xCkHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo8lMYi2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo8lMYi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B36C116C6;
	Fri,  6 Mar 2026 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767980;
	bh=SrYBJjBXm84PQmx0JBKG/XWwbzot/xEgfDeTfStXijU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eo8lMYi2orz47goDwWQML0cE9dnvWzKaLtZO4da6KM/97vagDihPJTsGUkCJwTsi5
	 RMLJPLsOU1H/RyCZmaaQfk8wa59qX6HLuzhHoY58KWHu+RjzVov7C6Pp/reW/i1GVP
	 imTxC+vjDyhML0sNn2y/7d2qjPEYHTZuK9CNqO8t92P6EA/kelmbudd/KO5ePpfNPG
	 tT+rNQD7YaskrNivRthEDYTxZNY8w4KjOUVvQ4NTj55Btm6QOQESF31j30f4lPmA24
	 /yBFIkj8r+cUKYN7is1fJ7md2gVfRcZgbfQcDLZLAVySaPmjVkV/v55DP2oGS1hNT3
	 4rlkEpnL8GnKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F043808200;
	Fri,  6 Mar 2026 03:33:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] net: cadence: macb: add IEEE 802.3az EEE
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276798054.3348267.8349678180512158704.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:33:00 +0000
References: <20260304105432.631186-1-nb@tipi-net.de>
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 theo.lebrun@bootlin.com, phil@raspberrypi.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 11:54:27 +0100 you wrote:
> Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
> (macb) driver using phylink's managed EEE framework. The GEM MAC has
> hardware LPI registers but no built-in idle timer, so the driver
> implements software-managed TX LPI using a delayed_work timer while
> delegating EEE negotiation and ethtool state to phylink.
> 
> Changes from v5:
>   - macb_tx_lpi_set() no longer manages its own spinlock; it now
>     requires bp->lock to be held by the caller and asserts this with
>     lockdep_assert_held(). All callers (macb_tx_lpi_work_fn,
>     macb_mac_enable_tx_lpi, macb_mac_disable_tx_lpi) take bp->lock
>     explicitly. Based on feedback from Jakub Kicinski.
>   - macb_tx_lpi_wake() is now called under the existing bp->lock in
>     macb_start_xmit(), eliminating the redundant lock acquire/release.
>     An eee_active check at the top of macb_tx_lpi_wake() short-circuits
>     the register read on the common (EEE-disabled) path. Based on
>     feedback from Jakub Kicinski.
>   - macb_tx_all_queues_idle() uses READ_ONCE for tx_head/tx_tail
>     (called under bp->lock; taking tx_ptr_lock here would invert the
>     established lock order). Loop rewritten to match the driver
>     convention: for (q = 0, queue = bp->queues; ...; ++q, ++queue).
>     Based on feedback from Jakub Kicinski and Claudiu Beznea.
>   - Added Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev> to
>     patches 1-4.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] net: cadence: macb: add EEE LPI statistics counters
    https://git.kernel.org/netdev/net-next/c/237577e603ce
  - [net-next,v6,2/5] net: cadence: macb: implement EEE TX LPI support
    https://git.kernel.org/netdev/net-next/c/0cc425f18f59
  - [net-next,v6,3/5] net: cadence: macb: add ethtool EEE support
    https://git.kernel.org/netdev/net-next/c/61332b78761c
  - [net-next,v6,4/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
    https://git.kernel.org/netdev/net-next/c/92ba3307431a
  - [net-next,v6,5/5] net: cadence: macb: enable EEE for Mobileye EyeQ5
    https://git.kernel.org/netdev/net-next/c/48575b6e16d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


