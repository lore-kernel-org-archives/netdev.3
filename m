Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CA33123D;
	Wed, 29 Jul 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290445; cv=none; b=oBB4rwZnFEvuqhanFeIjDj9v37mSWuHh6LnDfXp0c5SmO9U1D991XCMgwZ2kq0fMzIKGRb3+wi59YTNVobo0XbC0BlyQGg+nA2vQyaAaNQr+vE23EGX+YPl0GPBxNid/2+eK+gV4y7cz3RoF/96YY4wcAT5RAclEiD3agOVMUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290445; c=relaxed/simple;
	bh=J6bFhGBxGiH7FmfXzOdH6+Da/GvtqvDGRo5sIMHX5hY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERsX2zYBRss5+ofxKc1Ih5APKnlaJTJRu7sKMEBQe08uaNpIXR/4mxIddVemsNCpXw1taxjZjvcQsCwheRgyUT7CFSzuK9cSdfHNi5uN8CA06u6A6i3qeenF9cwAy3uIjBu72BfHTpOWfyPXQPfJAzzyBhX2ABTfc92fu21Qj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4qX39qO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4qX39qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9023D1F00A3A;
	Wed, 29 Jul 2026 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290444;
	bh=Ha0OD08wkoWj5BNt1xQa7dD0n2/rEZ7jiraEBW6xa0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m4qX39qOF25c/8/KM903U9EXPQzOvOrXouY9qOCq7n2rzOMTeMW1xvNROaC6ZGEXU
	 Iz232xTdeKjSqCOS92MUhf1dgkSzX11u2Mf9dUIpitTObdc6UfQuliEsNyIFHq92hK
	 y8iFMG2gjSaWIuLyg4h3vnXFBz1VBlsB9I5QxAk8RpUi9p+XnlokWjodJbzesNjzGL
	 WZn5v5KG5T9wCoBM3dBIUVECz0HpTJFex1DDmGsLUhkQPObyDWatJ7K77Mqo3vAuys
	 SxEluNqeAko7ePu8qNPZFNxSaco/SpMl6/qznwUKBsY+WClgLyXvDos6XfNdznCdIs
	 uU0ACSIAWymNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B443924A60;
	Wed, 29 Jul 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net] octeontx2-af: Block VFs from clobbering special
 CGX
 PKIND state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178529040888.2407687.14816470254096794560.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 02:00:08 +0000
References: <20260722081229.1653619-1-rkannoth@marvell.com>
In-Reply-To: <20260722081229.1653619-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 13:42:29 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
> programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
> not reset the LMAC RX PKIND or default TX parse config over the PF setup.
> 
> Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
> cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
> when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.
> 
> [...]

Here is the summary with links:
  - [v5,net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
    https://git.kernel.org/netdev/net/c/3bd438a58e91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


