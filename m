Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BF246BD5
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290263; cv=none; b=jiEFesQ8Oyf4T8O2g7zs3oDQKcWxM1EmeHx8xjVrizqAAioLWk+8mwkhslHrUXCWwUMRwlPGTzZX/AJ+zdVfAELH9S19ChPm3joxzJuHGjt/ZzxEty9Qf4CisZBBMhE+V1Im0u6KJ4wf90NkI+16uIaqjsXCMF2AgFpdVPHSFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290263; c=relaxed/simple;
	bh=5X+5ghZL4bTCAL4coxbSAz/EmB9QTuyKSKOn8iLsgBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSxv0QXuVIZA5i/JuFdTAjf/V6UZM6M8ejfeK3TAOmoyMHyJ6uaHDyAhamkFebodmHnPJZvOplDWa5uDTellL7s/CBL2gP5vDmopTIJxuDCPIpAIbJFUcJTf/GwLqGfzE+Bc2uQ5U9+NHX+XxTFEOn4r6DGT/I7ge0R9kjHDC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqCh/8ye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqCh/8ye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4030C2BCF4;
	Sat,  9 May 2026 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290263;
	bh=5X+5ghZL4bTCAL4coxbSAz/EmB9QTuyKSKOn8iLsgBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HqCh/8yeiRHn6osUcLVTghzXCkPiORXjVK7yt6l1oQ/7zgugE2oRCrVgQRCN/FcOi
	 kuwoMxwYp9/CwzfkluMt7igQZzMhAbnXFj7Gl1K0hDRdL5Y2Bda9xT+fgyuyo1cdrV
	 JqgpHqTD7gVU7gq0hxURCvEjSCBMAQn/vNXCd5DSrdv8CRm9rsantbxhGC1zHcsRKL
	 +osaPdBZh3piINsxCgrlmh53Tikd8kPJfBVfbBqTbf/u73N9YO6SeVskURUF4gxzEt
	 NK2GMW+1ZHH0BRaGmmue8rujxxU9KxDALfGXD/ub2OhldC+n32AOHkA4deQ7gliqbq
	 elYXcHncylzSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD3438119E4;
	Sat,  9 May 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ixgbe: E610: do not fill EEE lp_advertised from
 local PHY caps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829021179.925974.10216996772883040498.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 01:30:11 +0000
References: <20260507-jk-iwl-next-fix-eee-ixgbe-v1-1-62bc1d197d1d@intel.com>
In-Reply-To: <20260507-jk-iwl-next-fix-eee-ixgbe-v1-1-62bc1d197d1d@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jedrzej.jagielski@intel.com,
 netdev@vger.kernel.org, devnexen@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 07 May 2026 16:42:42 -0700 you wrote:
> From: David Carlier <devnexen@gmail.com>
> 
> ixgbe_get_eee_e610() fills kedata->lp_advertised from pcaps.eee_cap
> returned by ixgbe_aci_get_phy_caps() with IXGBE_ACI_REPORT_ACTIVE_CFG.
> That report mode (and the other IXGBE_ACI_REPORT_* modes) describe the
> local PHY only, not the link partner. The X550 path uses a separate
> FW_PHY_ACT_UD_2 activity for partner data; the E610 ACI has no
> equivalent.
> 
> [...]

Here is the summary with links:
  - [net-next] ixgbe: E610: do not fill EEE lp_advertised from local PHY caps
    https://git.kernel.org/netdev/net-next/c/1160428a8b64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


