Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E573C4574;
	Wed,  5 Aug 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899456; cv=none; b=kAKV3ZgllQEIUyVPXxIWPV/DEoatrFM1rpD6kfXyNlADeK0bRjt3JxGD2C0u5HDdGLPRmlYQqCCGocf+j4S8inZRlmEK7Ur1rEVhJl7J5KUK+x7OeZMUGPnbeFKbBnOBX1XD8HNZ6a1heO5fhS926HpRdvnloRYD/pB+MJxRbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899456; c=relaxed/simple;
	bh=kR3HHDr90loeo14fJpLWqU1CJtQB/o6eJKKjantU5+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlxxA7ETcdIPna0ZgdElViE1LRUHb2FajfyiwvgllgIVmJhm0L9H2N8k6LC33RHdIc26OmndzR+gFEtiemGwxZAuLirZsVNL7Ri+Mis92aQ+jsHInZX/3Ntgi0vptgoROqZGXO6e6KyhCVTLyExcLgIy2REkACc//RGA8pKqu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk5H/I0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk5H/I0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAC21F000E9;
	Wed,  5 Aug 2026 03:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785899454;
	bh=DH6zesokt17TKeSvEGWwAA+Bj26TyUtlsaG77Qq37u4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bk5H/I0iH6D2Zw2pGq8OH2i1OfRT56uqOeslYPZATvJi7fLVbZjzFG43D+21XEMSV
	 cyhuyEJ9Y1WNgzCEyhxahB+U9/x46f3xgm12LILvUPR8w2PBH2rUcP1okuD6OVh+C4
	 d1sP3sHzvHcrapJNE+ptr3tLtyrHA92n6muI5QkZbqJs53Ug5w6jP4P0NX8UrcXmqh
	 /d7eMSH5hCfhqEF8cmp4H7Nh7mPybN/yCMf8HdNvtt0MvP2511O7CGgJaTgu34HVmA
	 3aM9GDifKCRJEujH4e5+Vd4E5USRYMRyDtwx3sOOJYqYuwcYOuAtRV8c6QBAXlEw06
	 SXo0VZavV1k9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AFD392666B;
	Wed,  5 Aug 2026 03:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next, v2 0/3] bnge: add more functionality
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589941438.3895134.10825455088962281630.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 03:10:14 +0000
References: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
In-Reply-To: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 22:07:09 +0530 you wrote:
> Hi,
> 
> This patch series adds a few functionality for bnge driver:
> 
> Patch 1-2: Implements ndo_set_rx_mode_async().
> 
> Patch 3: Adds a dedicated HWRM (Hardware Resource Management) command
>          sequence to handle explicit interface down and up transitions cleanly.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] bnge: refactor rx mode helpers to accept explicit address lists
    https://git.kernel.org/netdev/net-next/c/d5d7b17b3f9b
  - [net-next,v2,2/3] bnge: add ndo_set_rx_mode_async support
    https://git.kernel.org/netdev/net-next/c/fbe3647fd464
  - [net-next,v2,3/3] bnge: send hwrm for interface down/up transitions
    https://git.kernel.org/netdev/net-next/c/1b1e855e4306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


