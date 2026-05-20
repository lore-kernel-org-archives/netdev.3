Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADA3BB9F8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315598; cv=none; b=Rlb9AAyhbxEVgmnwm18mZsRSGRaNlJbivGqLMpnk22h7x5hgsJPWDaONSZhuQZuWRpQtR7mBXduI87EH5IOLiejPeLtRYqzXv/1yCZFi3p+FE0xw7R1wMWeEzTyAV8G9Kjupn10q7qFt1ZPX+3Keo32Q1e1Px4zLmDERDwV5has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315598; c=relaxed/simple;
	bh=cU+6i/NmsglUz8FvcHy9PZ8tsOMCsIN7naR06KS9IZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jqd3Y/O23Ylm+hYO+VmwAcYdECiCS8dfrEc254uM80F5OQSKEGPEjv2TisV5MLupoOZ7EH5PbEB/ZxQuj/XWhD/IMuIcv45bxNvdZ28DAm9geUU+8bHlgMGk9uIj/eKI6+uCKw9C1GUb3cq6xwgodj06VAeuelTjRwwb6pY28uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhD4rxvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhD4rxvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F95A1F000E9;
	Wed, 20 May 2026 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315597;
	bh=5sXdvxUFoXEr+T9NBGv6/22RfDQBPHQ3AmXdLezYj4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IhD4rxvhfeO/8WX4fBmIleI4LH/PXS7s3DVx/me4T5ccGMTWAYTZPin2K56DzlOgT
	 Q3hDx84dVUJBCz4ABQG8R7DWJgEFtGD3/pDeHi0jo4P+1oKdE0YgTmGiprI7wfaNhy
	 a5AnX1V+f8OeVHAen7A2RVFrcOoe01UOolmqY5Q3Mpu/a1kIwLu1ZchrHE5rpRhmRi
	 3dS7C8u7SWidfUnCFeUkFDV8WCt2/hVDJCJsCpW/dDu0BDo8GQ4Bkjc6lCSansFAEr
	 BOcxMtXvQYcdSmtW/UW/TblWzRENXWRaodW7af0aSgk9f4mAUhHB0CfTC9Rwi4ZRoq
	 Kw/DOd/xy68ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997D3930BB9;
	Wed, 20 May 2026 22:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] udp: gso: Fix __udp_gso_segment() after
 GSO_PARTIAL UDP length change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177931560764.3775142.17228942872118757951.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 22:20:07 +0000
References: <20260518062250.3019914-1-gal@nvidia.com>
In-Reply-To: <20260518062250.3019914-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, willemb@google.com, dtatulea@nvidia.com,
 alice@isovalent.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 09:22:48 +0300 you wrote:
> This series fixes two issues introduced by commit b10b446ce7ad ("udp:
> gso: Use single MSS length in UDP header for GSO_PARTIAL"), which
> switched __udp_gso_segment() to write the single MSS length into the UDP
> header for GSO_PARTIAL skbs.
> 
> Patch 1 (from Alice) fixes the UDP checksum adjustment in
> __udp_gso_segment().
> The patch adjusts the checksum by the correct delta, and since msslen
> and newlen become equivalent before the loop, drops one of the two
> variables to simplify the code.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] udp: gso: Fix handling checksum in __udp_gso_segment
    https://git.kernel.org/netdev/net/c/5f17ae0f595a
  - [net,v2,2/2] udp: Fix UDP length on last GSO_PARTIAL segment
    https://git.kernel.org/netdev/net/c/78effd896eee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


