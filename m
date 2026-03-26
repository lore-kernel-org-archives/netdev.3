Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF0372B30
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534220; cv=none; b=anxCHnCunnjCjp2vrxkxUzMaeiuEHaz/msHOo/kERGqgJyQTSE5IDGXPEh/w/k/rCHBpgXX5zA2htcAdSpdx6nWDyGHspGRSMAW1LmwrHAbKHkN6713rfD3h2Ccmm76yhmXbwhPAIrIs0CA9IJpZdc4GcNRC7ebNd0Jb5NhL3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534220; c=relaxed/simple;
	bh=VTedjxHjhsQ7TwiqY1zRg3/Pw8EEqi2vQpab9pyqU20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UXvCkATJTfp2o6dKWa4rD9k6EaO5BymONQ/qU58q/La1Ju6xXoQJoliNP3efQyYaHvrOw23sUr14Ks0F2a1LTrU2aXCocFvXIrxbpxRS0o1TuEMdW+GsS74z4ySmBxr3KcrRs8UIvDYdryDT4cRpxJIuMZwoozMVnq8370CC1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjOz+fQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjOz+fQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650B8C116C6;
	Thu, 26 Mar 2026 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534218;
	bh=VTedjxHjhsQ7TwiqY1zRg3/Pw8EEqi2vQpab9pyqU20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EjOz+fQgBA7KNeY0TwIEg/dxIwNdN3xfzqOqsneCzWEjTcYg6+NWmB/LVfcE5ZZvw
	 GbOFJHeJ8D9TTTNIiMwCd+Jz1OfMUfLMc0VFudLvQ4jroMzR/eOokkBzqcuqPMpqEK
	 XwoDqtzv+RnLRH7XwHPedyMqfgo6Pau3La2mquT6jAhLVISykK77lLvWmahk64j8Qs
	 paI68Co+0hgk/aXUtBjrRO/8R3B+ybfZqVhVG6z/EnwcGVyHxCmdG03mtBEzL2QC5g
	 Ia6LN+vCbySvGSvRmN6YCzLzwoN9quigOHSK+IBwWgIC4hbR3TaCuPlB05hlARQu4p
	 HRwZL9yP+fEkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6739EFA69;
	Thu, 26 Mar 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: use the current queue number for stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177453420504.2572343.12776875958480966196.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 14:10:05 +0000
References: <20260323191634.2185840-1-pvalerio@redhat.com>
In-Reply-To: <20260323191634.2185840-1-pvalerio@redhat.com>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nb@tipi-net.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Mar 2026 20:16:34 +0100 you wrote:
> There's a potential mismatch between the memory reserved for statistics
> and the amount of memory written.
> 
> gem_get_sset_count() correctly computes the number of stats based on the
> active queues, whereas gem_get_ethtool_stats() indiscriminately copies
> data using the maximum number of queues, and in the case the number of
> active queues is less than MACB_MAX_QUEUES, this results in a OOB write
> as observed in the KASAN splat.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: use the current queue number for stats
    https://git.kernel.org/netdev/net/c/72d96e4e24bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


