Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03472E542C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097434; cv=none; b=Ou/v4pk2WiPNrE11kDDO8JPhIIiJtOnrs76rtJMmLaHJlbIvI1W4I85uqxxvyRm1dKBIhMCwhB1Ey0WAn68wsKB/RuahuTzJFpo05fQM1m6a3+wZfeIbsVt/+rZ+ep3JqixKGVHz2jk8EB1XpuONuDF5nJ46s4XJUD0OB7dXbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097434; c=relaxed/simple;
	bh=JIQUjt3S7+YB0FzPt5VEq0f9aVEvS0xnobxdpTDN9bA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Frq+nx7Z8DWT7elSHyv/UIqHGuabJVl6T4ekaJoCZwwv/iZjyd9EYwxlA0BGwWWGN3LeIwhUwo3OIRErXO+jeCn91FWgh2aYMm5gH4KsnSw+AR3sOqNS5buCdoOOSHVux2T2xzgKgRly39ZB38Vy5FlIThQhM1WisLec/K6ki0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuF1S/Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuF1S/Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE91F000E9;
	Fri,  3 Jul 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783097431;
	bh=0qH8rEh+l3GjUTgMfTCZKgAE36ueMmwrHG2H14CpK1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZuF1S/NqVo5v4rt75MSOUDQXDGI7eHedaXmmdbqYfoD6krrrqn+D+RIAQpJVx7sfl
	 6PTTlleyYXlkCLw8D1LQFZPOIOYhpZXbkThzXWiNmVXjRdS2gBwBEdDUZrz/ID3XS7
	 CjEOx5T8lwZ/JNNvqKiLIdbVuqbNlsMI2qgcys2UM43DieNoabBA9oNDTFKQ3QJTC1
	 w+TqzSQPypDC6UMDCRACyi36d0GvCcaWU/txp+X5xGqqKAEFsac31s1wNwwQRTyRkV
	 /GmE0vvSEiq6bHYnP4yrVbRikQuCPCypVzbY7b7VuB0OcsqOTbyYc5Aappx62IhzTO
	 uM6nY+myqEt0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 312B23939356;
	Fri,  3 Jul 2026 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] macsec: no longer rely on RTNL in
 macsec_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178309741388.3239271.4567949142803609843.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 16:50:13 +0000
References: <20260701094341.3218199-1-edumazet@google.com>
In-Reply-To: <20260701094341.3218199-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 sd@queasysnail.net, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 09:43:41 +0000 you wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on fields that can be
> changed concurrently in macsec_changelink() and macsec_update_offload():
> 
> - secy->key_len
> - secy->xpn
> - tx_sc->encoding_sa
> - tx_sc->encrypt
> - secy->protect_frames
> - tx_sc->send_sci
> - tx_sc->end_station
> - tx_sc->scb
> - secy->replay_protect
> - secy->validate_frames
> - secy->replay_window
> - macsec->offload
> 
> [...]

Here is the summary with links:
  - [net-next] macsec: no longer rely on RTNL in macsec_fill_info()
    https://git.kernel.org/netdev/net-next/c/5a5ebefdab9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


