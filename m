Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF12931FF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421210; cv=none; b=UJz7dNpPSF5aB4pMeJ8JmdCiKLQftRLimL8RBUf2GKE8DGWXQ5DVrjgxGEMvLBfzIfPolLqFRKcmXFabcgkSzbwZSltIYNUUGHe3r9vZj/nqoo2F0Griymyfq+r/5dtK/J+2N6kBi6mMxrQrF6vhgkBwYtupXZV9ww9a25JrpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421210; c=relaxed/simple;
	bh=ZPOczi2TWcglizaYjd56JiMoLrZy872v3QLAn1Xw6K8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vv37Z6zQlyTSui4PAKX7+uKVqfx6tUowFxeuFksJEaj68Hur5IGrswj8V2AqwgxWYAjdgBDuN4FxEKUZn3nuPTxaVqR23YUCqONR3il6YWAcD5hLpuh0Y/H0k0PiyK8qUfF8FAOQUtdn+Q6yEraqtTBq1gzShFjAjGhOo9kncfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8fuq8JA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8fuq8JA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AAB1F00893;
	Thu,  8 Oct 2026 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791421208;
	bh=xTqW4wcVkTkvLB1gx9UooF3TLruaDoCHRgI8Y94AjAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R8fuq8JAy6Z3f1kOc4Pms3Zl8fpwwReIvFLKhw3sryOnXgXzoNdJ5Ha6BvhCyvlfL
	 fYCZTCPgZ2wbiUrOJz+v2VZ9O6ffeuIvGsHt/Wnuvin/YsT/4Qrg85edsWww5WHw2h
	 JDcKGUjRwUWtb36sLKp34Wi1XaqvSiHRXj/pL0dii9Lhj8rASvX+CMjC7NeycQdi/O
	 8W3wi/rvv+ccky1gjGBrpBKsftNwwPeV/hQzHYmUTdYb1Y/dIXZV45/WuNLUds0RdW
	 EVLFLq3wfYFRR9si38NIJ3cpG1ZiHMtnSU2g2uMVgPeNEBeq4LVZcsuM6Nj16nfl48
	 JuSkPYZTReq9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43DA3809A08;
	Thu,  8 Oct 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] bnxt_en: PCIe FLR/AER fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142120734.3755089.17211132797892380452.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 01:00:07 +0000
References: <20261005204246.3822563-1-michael.chan@broadcom.com>
In-Reply-To: <20261005204246.3822563-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 13:42:43 -0700 you wrote:
> This patchset is split from the earlier 9-patch series to limit the
> fixes to the PCIe FLR/AER issues only (patches 7 to 9).  The other
> fixes (patches 1 to 6) will be sent to net-next separately.
> 
> The 1st patch is unchanged since v1.  It refactors a bnxt_clear_bars()
> helper needed by patch 2 and 3.  Patch 2 fixes an issue during driver
> init.  in the kdump kernel on a Dell system with a smart PCIe switch
> upstream from the NIC.  Patch 3 fixes an issue in the AER code path for
> non-fatal errors found by a partner.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] bnxt_en: Add bnxt_clear_bars() helper
    https://git.kernel.org/netdev/net/c/8f5d59b9cfa6
  - [net,v3,2/3] bnxt_en: Fix driver init in kdump kernel
    https://git.kernel.org/netdev/net/c/386f887c8290
  - [net,v3,3/3] bnxt_en: Re-write the BARs following any type of PCIe errors
    https://git.kernel.org/netdev/net/c/2e52da27096d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


