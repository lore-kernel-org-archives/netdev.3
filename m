Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057409;
	b=bdWAKTdkDvpuc4xrIHcAJ+keBucN3qpZ4WENN+gLmB0zCkT/uKzhPD4l8XPBmCSwbKA3
	 h7lh7NezVkJw/hpWYSRkSNzFTA4a3JByPtYXVenNDhdNd8JPw+5IX77oNZhQ0ZGyiVXhu
	 SZZCSNqRvsdvPRFZyPxLtX+Bcf5udUdSkNATNZTOtGjqB43yQJ5hGauqZNRw3KAz9lwyv
	 Fuxw5ND3Y4xr0aaeYJqMmLRtmyj8GIVtOhbTVnNXgYiHxCbCdgcd1+WkGf2d5p7JgVMFv
	 803EXbdRqfcXr6slMnUWiZ6fNK9O0EFR1H1QW5xFFC7dp8Yq/qJNEEhQDZJq2cw1Z0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=B4X6R6clBD6tXnVEq+6/Y8yIwCW7vHn+gYyLWLvCsUw=;
	b=GUdeysdH8IcoYd6lgrS80cG33YWlu1XYqP2X5WqdG2dZH/GeN7FypwR2UPlHG/ILnoao
	 kPSJkfI56a5tHsLATF4K6XabQ3QdfP3Q3zMII+werot8XV1fOq1pYa6mf/JmwHQbX0pay
	 uj2m3Vx9MY2am8gHzpFTLxzDrq5d/yhVJbtp2UzIUuFnaXZJncXx8/hvvUJ6Lk8WyL0qg
	 3hEaCQcfRlG4dhbPauaOX7JJs4PJLHPS5V4dcr94xsA7Dk6dewXiprKngGXPqpeGBvk8Z
	 5bLOk0c+QDURNQDbPyy1clEK78nZIEUFBd3OqUUgU4fzoO8sN/XBWcNQAyInu7fU0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irnYylYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E4606A322;
	Mon, 26 Oct 2026 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irnYylYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD61F031E0;
	Mon, 26 Oct 2026 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057409;
	bh=B4X6R6clBD6tXnVEq+6/Y8yIwCW7vHn+gYyLWLvCsUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=irnYylYBh2P5GdWXfWXL4A1zTWCO/1lWXxkOxsXB8j9CCgThrhA7C06HYWdE8grsG
	 /92hwzF67mDpJl0UhJEydDheA0Ac25qOGYpc6c3K6OaXq2ExwNGO7juyv9CCFNtBCv
	 fqKE0ULcLVWl/yFjvOrtB1RZel2a3qLWT7AajEPzEnOGC2HamKbfWrdt/Xq9S2P5TF
	 zLHf+CkQKIxcbyQWRNo1A6+gKFRH8p9j7ixSbKFhc7ijHOyBQwXSobsp2Gm4EfL3VE
	 vdWqFb81ZYwTDSB5bPu8GY8g5BG0c6kAFitrQJ6EfFYIgUFmYj3S4iiFfAwF6s2AQA
	 d+0EHXHa/e5Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 075573AA80F0;
	Mon, 26 Oct 2026 23:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: stmmac: fix rx checksum offload with extended
 descriptors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305740777.3456332.8291409987867601935.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:30:07 +0000
References: <20261020-stmmac-rx-csum-v2-1-330c8d0951ea@proton.me>
In-Reply-To: <20261020-stmmac-rx-csum-v2-1-330c8d0951ea@proton.me>
To: alex todadze <todadzealexi19@proton.me>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 22:42:24 +0000 you wrote:
> From: alex todadze <todadzealexi19@proton.me>
> 
> With extended descriptors, bit 0 of RDES0 is the Extended Status
> Available flag. enh_desc_get_rx_status() still reads it as the payload
> checksum error bit of the checksum offload table, so every IP frame that
> has extended status is reported as csum_none and its checksum is
> verified again in software.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: fix rx checksum offload with extended descriptors
    https://git.kernel.org/netdev/net/c/72ee27b97986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


