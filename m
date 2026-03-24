Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2C1DF980;
	Tue, 24 Mar 2026 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355421; cv=none; b=q5jesKWZlrKpUw9SeIDaUEh3IzEmHgk0AxfbFo5STdf24mBVA5y3pk5PsZiVC2Sa3L4gsvwW19J3+lRFQ5fvOi0A7ZG0mcQudjGXHEimM/o550Pt8wqzucu4Qc8wXOdEhhIKs7HmMDk+qqPcXPX51HZyl7YhszxvZGmpkO6rW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355421; c=relaxed/simple;
	bh=GT5soVOliPqOg3cx6kyhTeUKxUhtxDz8EMzLqjWOrag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qSItjscTI51+oRRlb7uEC1OF3gLOa16FxX8sVS2MmK9HLhFVVHIWQV3Ut+utjlHeSi7GI54YSUu4IpviDHGepVDswVSHX86r/SOP888mJeLDKAeHZGt0Y5g3vZsCwXF3Uae37NA+IBGiXYVRH5ChK9w6FAn/Qt76S8Q5MTpPzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7jXGqcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7jXGqcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7FC19424;
	Tue, 24 Mar 2026 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774355420;
	bh=GT5soVOliPqOg3cx6kyhTeUKxUhtxDz8EMzLqjWOrag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j7jXGqcFy/zZb/SSRvqHR6JwwJux2eohWvuoZDzaH5RZSx+XQH3xoXI8L2uWgs8d5
	 oHiXSoneRsH60sOHM3PWl7DAbiLQcntOqdbvHk69EMZAONQjA4VBzLQQp89/lrpLRb
	 AlFSusbrqEtahYD1/ku+dOIlg18AIciPOrmyY8eehm5YBR/lxp6z8k1flJzBmIlEMn
	 pcUzQU49JmZDUgGNPr8ll0MvORD3BZS/xx+WWxoBodh5roCenJkdFBOneJdFMwKiKm
	 SnRmzzfScAapsR4rNESrAY1c4Q5FO15h2mNC4Gl3qohxWMAf3wKwidSY7F+S5Zm+0U
	 dhjTjdcqVnrKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D6D3808200;
	Tue, 24 Mar 2026 12:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: update outdated comment for removed
 phy_package_read/write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435540853.657925.6639945726748112146.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 12:30:08 +0000
References: <20260321105825.7221-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105825.7221-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
 xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Mar 2026 18:58:25 +0800 you wrote:
> The locked convenience functions phy_package_read() and
> phy_package_write() were removed (as they had no users) by commit
> e7f984e925d2 ("net: phy: move PHY package related code from phy.h
> to phy_package.c").  Update the comment to reference the existing
> unlocked counterparts __phy_package_read() and __phy_package_write().
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - net: phy: update outdated comment for removed phy_package_read/write()
    https://git.kernel.org/netdev/net-next/c/a4b908c89d88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


