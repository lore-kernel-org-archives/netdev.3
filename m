Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536040DFBB;
	Fri,  1 May 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600866; cv=none; b=epcjtalgDIaAQirGOAtM2I7bomodLkKBf0QPgfuhEzOlUEKogQxAdT/BckiQIRV/z3lIOx/zDaohivBrBSloV1gKAY4f11Z2CdipE5CdHKY6oNBdlaQfNxUVcXQASB1EqIQ/lFrDeYTrd08Zn7vf6cWMksmTTWK0yJbKI4zP3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600866; c=relaxed/simple;
	bh=JimsdGqvPa70DijOJ8MMyaaBAnT7TgyYG2+gAKF47v4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZFxV6fHp8+eRoZSFkGfVua2zTkbCuIFZr2sykXq0P2Mxt6aJi19mG6aqxoAp2R77lFCe/LEMrno0qo6xyXt9hfomAhBbwEefBCVw66Zj/6T3CuW+WthlxxA2l1Z86C0dC6E/UMVZkxl96Rl5b7NZshjfaXozIrnZVlBcilDraiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Mm86gZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Mm86gZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A006C2BCB3;
	Fri,  1 May 2026 02:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600866;
	bh=JimsdGqvPa70DijOJ8MMyaaBAnT7TgyYG2+gAKF47v4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s1Mm86gZpj8X1tY4xNMINEKxhQixc2qZwR5RHG5rIINeLa0YDo7KY4Yoeq33YPAS3
	 qUd70zcXjp3nx2TrjVUBFntkRo5vscO+/kWYFtPDcnonptpCp0gwDXgvm6oOh3QGk9
	 W6V0vpKx2FzDV0ZM7aJGJoQBSn6A3nlFz4Yv4yKnW4BbHQRkwn/Cw8bkbzbLSuIice
	 R/hajT/NKUGx89wWxpCMP0kJjXFfZnCPzOe/gOwaZ/VLaLEK1HUDOq1WE9kvrOqfWX
	 1GnB/ywFqGOLtLvraVMAcOWAEoN8dSRD+fm2lowDFUZCjaG2I2c7AQN2bRV0jkD1Eu
	 qzKf5x3I/0oZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E98380AA63;
	Fri,  1 May 2026 02:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 00/10] octeontx2-af: npc: cn20k: MCAM fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177760082033.3289564.15765293779579812348.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 02:00:20 +0000
References: <20260429022722.1110289-1-rkannoth@marvell.com>
In-Reply-To: <20260429022722.1110289-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 07:57:12 +0530 you wrote:
> This series tightens Marvell OcteonTX2 AF NPC support for CN20K silicon
> around MCAM key typing, optional debugfs setup, defrag allocation rollback,
> defrag entry relocation bookkeeping, logical MCAM clear and programming,
> default-rule index handling with explicit teardown, and NIXLF reserved-slot
> lookup when default rules are missing.
> 
> Patches 1 through 3 focus on AF error handling: propagate
> npc_mcam_idx_2_key_type() failures through cn20k MCAM enable, config, copy,
> and read paths; treat cn20k NPC debugfs nodes as optional so probe does not
> fail when debugfs is unavailable; and fix defrag MCAM allocation rollback
> so allocation errno is not overwritten during subbank index resolution.
> 
> [...]

Here is the summary with links:
  - [v5,net,01/10] octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
    https://git.kernel.org/netdev/net/c/aaadccde312f
  - [v5,net,02/10] octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
    https://git.kernel.org/netdev/net/c/1100af13fd14
  - [v5,net,03/10] octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
    https://git.kernel.org/netdev/net/c/adb5ff41efbc
  - [v5,net,04/10] octeontx2-af: npc: cn20k: Fix target map and rule
    https://git.kernel.org/netdev/net/c/d7e5940c4c50
  - [v5,net,05/10] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
    https://git.kernel.org/netdev/net/c/d2dabf09632c
  - [v5,net,06/10] octeontx2-af: npc: cn20k: Fix bank value
    https://git.kernel.org/netdev/net/c/2b6d6bb7282c
  - [v5,net,07/10] octeontx2-af: npc: cn20k: Fix MCAM actions read
    https://git.kernel.org/netdev/net/c/f6803eb070bf
  - [v5,net,08/10] octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
    https://git.kernel.org/netdev/net/c/afb474bd4ffc
  - [v5,net,09/10] octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
    https://git.kernel.org/netdev/net/c/013717353c03
  - [v5,net,10/10] octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices
    https://git.kernel.org/netdev/net/c/bc968f61bf0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


