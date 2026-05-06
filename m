Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89C257423
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028065; cv=none; b=nShAXK/Mds4/VpqL2RmnM282b+C4eQYQzBYejVFnjXjTPXdpbivDYqCNpD8GBQCFIfMrFh9rxWgn9XDTWxKWGV4oRPfy6qdmCctTOkoSwC9T91EdyEgT9yZuneCoInYnUGFTgCCqtj0Qy0pp9gp8J93aXlrmqFaHThjF97WAcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028065; c=relaxed/simple;
	bh=uOroPzN91PWHXEEoI0llI4JD9qb0HopN5/+RP7ReBIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gt7ba0QSz507lT71o+Bujnf94LU4ZdCjvjGDIIuC1vDHUVVcPivXB1rHSlIHmreoH5k7nDIGVtUOonuuj0/oC9OxlavZGdsevxElEcTZYzX1c2TmGWVDaOS/Y0d0iYWl492fVd+ps9eameDTf/wrp1TxppFiOqtFkq/zB5sGmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLORbCW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLORbCW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4F1C2BCF6;
	Wed,  6 May 2026 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778028065;
	bh=uOroPzN91PWHXEEoI0llI4JD9qb0HopN5/+RP7ReBIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLORbCW1gqAW+yOCbDNFiZUSQIWQjdHDmKPeyYRGI54ARU3q9Xx9eCo9z/7kZdFUK
	 A39mL3D3bdtF96GIiIPtfEXdvYWXR4DiHCRN6m+/+kO52UxQ886xgYAovqlOf/+hHC
	 Wlyv8P87//nTLkL6vVjijs3uIHbSbHFIJf3SXLJRuRyJMv6Vd2DrZOykaMbkl6dGhV
	 uovcLQuZWTDw+ypIvqlGmtInG3Aa1DNLIS5zf43SQ/Uo5oPF3g3Eig2N4/mOlXr9DB
	 YrzkPG1CLBjOcvDpBVbRklzfYWeArzGqiME2LFgU5eJgSFd3yqSMibmrTHnfzZHeiv
	 SCl3gLAZGHeNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDF53930780;
	Wed,  6 May 2026 00:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177802801504.2324972.4933700936796291945.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 00:40:15 +0000
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 14:06:07 +0530 you wrote:
> This patchset adds the following fixes for bnxt:
> 
> Patch #1 fixes DPC AER handling to make it more reliable
> 
> Patch #2 fixes incorrect capping bp->max_tpa based on what the FW
> supports
> 
> [...]

Here is the summary with links:
  - [net,1/4] bnxt_en: Delay for 5 seconds after AER DPC for all chips
    https://git.kernel.org/netdev/net/c/07f44433355f
  - [net,2/4] bnxt_en: Set bp->max_tpa according to what the FW supports
    https://git.kernel.org/netdev/net/c/54c28fab2fa5
  - [net,3/4] bnxt_en: Check return value of bnxt_hwrm_vnic_cfg
    https://git.kernel.org/netdev/net/c/16517bc98a56
  - [net,4/4] bnxt_en: Use absolute target ns from ptp_clock_request
    https://git.kernel.org/netdev/net/c/bd279e104e5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


