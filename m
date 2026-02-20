Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A7307AF0;
	Fri, 20 Feb 2026 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560660; cv=none; b=F4L3vOoRwN88jvtFrCSs27H1l3vmDh3irGn7E8G+OK9ZrZ3s36bb9+YsdcFHBbVNUpcReVZ36rVx593S7zOg1+wS8bnCEXmUGp/XFNEKEApYZy5tuskFKklGQt/HZ3BvTgajh8Mw52PIXkhkm6oOftkGNFE/9hkvoPxrxe1E+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560660; c=relaxed/simple;
	bh=efjNDJhM9/0diWvBdyGOzP+K21cHz4kM08BrUOfEDRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWO6dQF+zx6LeNT0z9NE/vTxWFxLNOhuBzhICPJqISUjNgGDaTquO9+GJO2GQ1k7J3bSZzLIPOgxWwkf+1Hbxnsx65lFBWKs0ec+UeIEsLWxPC/Nfl5Z8uxM7+yAfk1ayT362r+/oygCJUQdUPBVYIgFmpppfunqY6qv3DUneQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0PWe5C5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0PWe5C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98269C116D0;
	Fri, 20 Feb 2026 04:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560660;
	bh=efjNDJhM9/0diWvBdyGOzP+K21cHz4kM08BrUOfEDRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0PWe5C5DfEFXvhOpNI7PD7CfmjfKkPnl3Er379KNRdps2JQFPoznWKtIkmcobcVj
	 nQGi5AvNQIMtqm29dzcR5JBEXVOZSjC7/ZSGvbUqAjqj6fjih/3Cdnzx4k5/VQHovv
	 ECXpPMVdp67gRv7WTlabd5cKSHZtj0ctTJFvMgi61cM01rTpuh1Is+QEtCJGhUE663
	 9hoUXMixh3D7BmD//K3rb0GT9JknVLzSS86miuq3vnneDb0PWVddPNyTDKBWT/Z6D+
	 gOTX9B5N+2k/Cw40A/fepclZYN9UHV/XHkBeirJhkb+CduzAOhngVE89qjJeVFNg1n
	 beYdy47j4zHmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE9B3809A88;
	Fri, 20 Feb 2026 04:11:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156066878.189817.17095459510292198861.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:11:08 +0000
References: <20260130102301.477514-1-tmshlvck@gmail.com>
In-Reply-To: <20260130102301.477514-1-tmshlvck@gmail.com>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 11:23:01 +0100 you wrote:
> The driver never programs the MAC frame size and jabber registers,
> causing the hardware to reject frames larger than the default 1518
> bytes even when larger DMA buffers are allocated.
> 
> Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
> MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
> maximum buffer size from 4096 to 4095, since the descriptor buffer
> size field is only 12 bits. Account for double VLAN tags in frame
> size calculations.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: spacemit: k1-emac: fix jumbo frame support
    https://git.kernel.org/riscv/c/3125fc170169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


