Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878929B228;
	Fri, 13 Feb 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014619; cv=none; b=AKzWuVEO2P/6jdDMhboCZ1uG84poz4KS6RZgvdNcKxjVY8iOwVY/3yJRX8XyVtD9KbKz2WcD+2fJnmLypodqMZ793onit0V6hWjOdcRM7frsFzLWzy5WSiK/Sysfjsf1GXk3y/Tl4pvkNO1p3qqPWxrKi2n2nYS7A4K4QQfdeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014619; c=relaxed/simple;
	bh=5Kt/TKVWBsSUqUTIqLI1iXg/DdngCWvR0T0lEzWHZaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3mw/H9/bOCq5uGstQ9D4rKb3CxYlqwss/8eSGdf8jb4WVxOD7nfmfiJecuVFNpiDB5obI1FGHmA3k+5En9D4wFzURZ5QKPQ5S3TFMGN/qPd6nnB2+L+nxSFG8gZQCKku/g1ssSQB6i0cjRwcgZy2lVdn6fmAHfm5na3H7/Zm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8X8TZWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8X8TZWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F365C116C6;
	Fri, 13 Feb 2026 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014619;
	bh=5Kt/TKVWBsSUqUTIqLI1iXg/DdngCWvR0T0lEzWHZaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8X8TZWPP8U9DqfALFNzdqFyTEpBxb10+urNwyCc0BN4oIuknrcTkx8k9srjaD9jb
	 jw3CIsP5jD81VrAQeeRZsiJMQuadq73wQ2SG+EExyIpegGmAaG/yFSC3ZsRRof1O+9
	 h5IytQokhVQzsaqEVjCz/T0lWtdVTXU0xggrnBiAhNchpV+1Mp/RjfhDi6OmOR9nDB
	 wK9ib83/OMQSfHweN1oqM3k8VTjlTY8NrG1rjfZ2ePzgHe7eQCnboaAcBin37CVZ9q
	 J9juAVa6Vp3Lf6TsAHzLrV4B/usTPAC4tan7jUWsTJqC6kTbQUTZwX1DbtnC1K8dgh
	 foJTi+u7pEROQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B18D3811A44;
	Fri, 13 Feb 2026 20:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5/lan969x: fix PTP clock max_adj value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101461282.2548179.9241300584725576319.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:30:12 +0000
References: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
In-Reply-To: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 12:02:30 +0100 you wrote:
> The max_adj field in ptp_clock_info tells userspace how much the PHC
> clock frequency can be adjusted. ptp4l reads this and will never request
> a correction larger than max_adj.
> 
> On both sparx5 and lan969x the clock offset may never converge because
> the servo needs a frequency correction larger than the current max_adj
> of 200000 (200 ppm) allows. The servo rails at the max and the offset
> stays in the tens of microseconds.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: fix PTP clock max_adj value
    https://git.kernel.org/netdev/net/c/a49d2a2c37a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


