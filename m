Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AF25BF13;
	Sat,  6 Jun 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710609; cv=none; b=M1j/Stv7vC0OjyYSKqS2aITT8VsHgeZaMHIIUslUHPWwWI+g7H/Ry2+MEJBuq4/IZzodrVeEjE3JIwb9+BBjj63g8UaF9jPmGfRYuKAEP98yFalvYvnqkuqTTxUIRmpFzpmk8kUfUl0YLv4bH35y2mvAZpZQIBTIvdhKhwrrtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710609; c=relaxed/simple;
	bh=Sw3V6Jz0wtZR30vbr0HoLwyM+JmpPpMwicQdaFWTMWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mWqEEsHLFdfmlGGc71GnyUb3ZArjdlQ7DEMggHsFlhz/iPfiEVR/Zs2+//2SqSI3z6d1cVIRFjC8dtpl4XUwZcxjs6WrTueeyVzWifyvktIvxa40pZRQGRVZ99LMx6Cfj7cF6MeSx5IX3nZOs5fAdmtRDt4LcaNr0/1AIJgrCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJezhLAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJezhLAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BD31F00893;
	Sat,  6 Jun 2026 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710608;
	bh=tAJ7WVX7mJQQiFf4U+sYINxy71ImxnceGJLdv7M8zNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lJezhLAKzd21A/MX43g5OVtZP7KYVgbwPyvD/QrXomNbNfZPaxlEJJzvT+0Vd7T86
	 /qxXtO7jJxf27knoueD+3QnME9FWtxwkB9u2KKo4kD9rBMVPbqwjFqPPYnJzssOT/p
	 w3oloxkemGyy3rjcR2/jRuNBLczWulQ00K/bMM2G1EjOs/5jiYUvTQTdn9gGDdDcBl
	 ajeToxdTORqgIukJ29302V1LfsKuMtIxP4yKQ3PpnhM9op05fj6x+AaPuZ3CURVtAL
	 O8S8ACDogrJdYnT1eaelt1oM0IH/IduK90B9U5yR5rq6RhGw8wYvFqmQRWJaRTkDs8
	 DwhdS9ItlEtvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B23930A9C;
	Sat,  6 Jun 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: fix context mem iteration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071060814.3989414.3144352465863361551.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:50:08 +0000
References: <20260604163709.497649-1-vikas.gupta@broadcom.com>
In-Reply-To: <20260604163709.497649-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vsrama-krishna.nemani@broadcom.com, bhargava.marreddy@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com,
 dharmender.garg@broadcom.com, rahul-rg.gupta@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 22:07:09 +0530 you wrote:
> The firmware advertises context memory (backing store) types
> through a linked list, with BNGE_CTX_INV serving as the
> end-of-list sentinel.
> However, the driver incorrectly assumes that the list is strictly
> ordered and prematurely terminates traversal when it encounters
> an unrecognized type (>=BNGE_CTX_V2_MAX). As a result, any valid
> context types that appear later in the chain are silently skipped,
> leading to incomplete memory configuration and eventual driver load
> failure.
> 
> [...]

Here is the summary with links:
  - [net] bnge: fix context mem iteration
    https://git.kernel.org/netdev/net/c/3847d94783c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


