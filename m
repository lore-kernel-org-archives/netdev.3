Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9923EA84
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564429; cv=none; b=Dr2+bEbtDnm5kXx+oBFqBUG83WicbH7c3r4OsYfioBzfoSDqivVR5sqrhKtfXI9tHTB4q3FGTrgLavt9rEe4yVJi3Q0ssJFiQdf6+PjJuQHH+guBDS1uSmTaa76u2c475ES/n2mBeCGRyTKAb+Mw6flazI6iPTDOs8QCRrrCnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564429; c=relaxed/simple;
	bh=LPslhGPnfa0A81YmTeiwxM49i2KXK5naB5/svpVhjrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u1XAiyhclDsj8pbreh6t2uxqAjBzdNWAgr+HyLRL/KLJWFQfLYycAzDcoIcXusul1wRnV9E+CcXPpUfGsFLs7F+o5FWDzoLxKYlIx9Q52aUFUeZ8HCk/bFhbi4fp4HDyNX+Rp4O2BJc3hCTVya9mKeO9fYKnRWGAShI/GEdoNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3rDPFyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3rDPFyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C0C116C6;
	Wed, 28 Jan 2026 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769564429;
	bh=LPslhGPnfa0A81YmTeiwxM49i2KXK5naB5/svpVhjrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d3rDPFyYA9vtlUlI+jiPr1U7h7NDnGL7/gNb7Vw4XWU3OrCEDYYsQvyMoKreU61xo
	 50xTDJPsQjRusLOZ4X/MD5WeU/hwN4aL/XsImE464COVdYwdTI8OG/I6cnQTHd0yhK
	 Ca5A7e1PRuddqKytg0n7alhV3m4fquaJQY7Zjmsp4g61AGiPkDukNDpF7P8xZ10x1t
	 D5iPMYUE55ykPv4WVoljQ0zg9kW1gCmAJ/YbElHSWEic2cFgnmMPDKk0cCE6RbK8Hv
	 fG+HAMjlkjV90IpHbfaD5oICQTYYbrYjp6ZRijRd7Fg4nKlW6+mQYEbNJO1q50Mr7L
	 OVqpWadcjRs0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBF6380AA76;
	Wed, 28 Jan 2026 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates
 2026-01-26 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956442310.1470424.275510766558501876.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 01:40:23 +0000
References: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260126224313.3847849-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 26 Jan 2026 14:43:04 -0800 you wrote:
> For ice:
> Jake converts ring stats to utilize u64_stats APIs and performs some
> cleanups along the way.
> 
> Alexander reorganizes layout of Tx and Rx rings for cacheline
> locality and utilizes __cacheline_group* macros on the new layouts.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: pass pointer to ice_fetch_u64_stats_per_ring
    https://git.kernel.org/netdev/net-next/c/fb5b8f3c8870
  - [net-next,2/7] ice: remove ice_q_stats struct and use struct_group
    https://git.kernel.org/netdev/net-next/c/b470944ee6e8
  - [net-next,3/7] ice: use u64_stats API to access pkts/bytes in dim sample
    https://git.kernel.org/netdev/net-next/c/b1c16d9cb21e
  - [net-next,4/7] ice: shorten ring stat names and add accessors
    https://git.kernel.org/netdev/net-next/c/4c58c7152c09
  - [net-next,5/7] ice: convert all ring stats to u64_stats_t
    https://git.kernel.org/netdev/net-next/c/b38a418db366
  - [net-next,6/7] ice: reshuffle and group Rx and Tx queue fields by cachelines
    https://git.kernel.org/netdev/net-next/c/24f90786efaf
  - [net-next,7/7] idpf: export RX hardware timestamping information to XDP
    https://git.kernel.org/netdev/net-next/c/13a4be41261f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


