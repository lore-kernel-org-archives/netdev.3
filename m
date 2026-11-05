Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874008;
	b=nOtVK2FGqmYhpr3w8wFORqePO+ug92TANeGPHWjTgW/4yK+jfX6qpZ2VPcuwrFDNPlnN
	 b0uzTPaxuN7NwfFY107r+ZabEKS2JmqIobY8+fiqYRSDKAqbwoVtSycrAD0KHkp+CBahi
	 4P/NJl8hWes3SiEUPMvj7any/ExpZcMqqgQW4Fkw8kjGkziG5LiaEyr2pjdGV3l7ylZIE
	 9o00MaNpEMpXZBoYE/je7kRl/kyM2LBfQ+/bqP69yP6Q5SsrihiI3asBUPPdSpM/jHGMl
	 J9OX5qZi61vZt/5EGp5HjLcylJY9j3cNFuU93apnyOI0DOmcRECDfZBsBGPIe4lowfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/fjsOUXK6gh9UjxEanyLWiGOHJ5mrZq8jXGDtiDFfF8=;
	b=Lgu99eXflOoomg+75RCnSiVQtUGKv5BWAxj5xkX91ceD/MuB0UXD4k+Oum+Kx0lajbGM
	 pwmBw1MaLxbB3IluYLsrkjbRFzt9CI9wp5GT36yBkeSXNrDlKb2+hmVLUHamrtty3sDOx
	 KfuZndDdOPYxvTSN2Eb3g3Qo5JIkoSlt22koeK7+4rEaBTEHd1bqjgQ0PtYJzrkqvINi3
	 cfU1iNemjJ7vahVYQsNibWrgeR2f+htD7jey3R8qNYBzYwShYws1vvOTQD28GourrQX3E
	 u4BZ4mVa73yOcNeh0sHK/iA4bcltYlmniFzOvFSKtW9IG+h0D2ca8NojGqzQySmPgfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZGkEUCy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FD606D815;
	Thu,  5 Nov 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZGkEUCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45161F00A2B;
	Thu,  5 Nov 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874007;
	bh=/fjsOUXK6gh9UjxEanyLWiGOHJ5mrZq8jXGDtiDFfF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NZGkEUCy+Pi34O+oMFhH4oLsN4lAvstK0UVU9uJVnhje2A2eji/KX2Nuch8ODOsHH
	 673hokhZhzxmlixstYxXS68kWu49o3fr7EIwmxlfBUQC5BuzHr8IXw4ATmPVrOtfHg
	 wfFr730u4yzKdyPAPCT7IGPzwt/UGc5BG3yslc0ho1Epc32BWng1CAEA4YPPEKg93a
	 3xP+7QYJnOIRb1mYdba8gU3BDLq5tLvzg1IlYtFkcCOQOe8f7nfVV9DpexsdexhDv7
	 W9/S3fwa0SSx0iywceWqOpHE4n/9VZ4EDuaeGixmCQxdijNkFdekRhj+7db/L2sU6h
	 MxPts7dwRYHCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA421391AFB3;
	Thu,  5 Nov 2026 10:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: 8139cp: keep Rx masked while NAPI is
 scheduled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387400626.3571518.6125898624149671767.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 10:20:06 +0000
References: <20261031-b4-8139cp-napi-v2-1-5824797c0fe6@gmail.com>
In-Reply-To: <20261031-b4-8139cp-napi-v2-1-5824797c0fe6@gmail.com>
To: Colton Pawielski <colton.pawielski@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@0x0f.com, geert@linux-m68k.org,
 kmehltretter@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Oct 2026 11:47:23 -0500 you wrote:
> From: Colton Pawielski <colton.pawielski@gmail.com>
> 
> cp_rx_poll() calls napi_complete_done() and only then takes cp->lock
> with interrupts disabled to unmask the Rx interrupts. An interrupt
> that is not masked while polling (TxOK, TxErr, ...) can arrive in
> between. cp_interrupt() then sees the Rx status bits, which are still
> set, finds NAPI no longer scheduled, masks Rx and schedules NAPI again.
> cp_rx_poll() then carries on and unmasks Rx anyway.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: 8139cp: keep Rx masked while NAPI is scheduled
    https://git.kernel.org/netdev/net/c/547b1ae5ec50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


