Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6E345CCD;
	Thu,  3 Sep 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402088; cv=none; b=dhJ3o2zI364w3EFn5XF6lbeSMgxbGHs2+34k1UxqUmTAw0KRTyU3f8SKjxpYJHTWqbtpFqcSe94dL59PcPinOoym3qeogz8mWkknXy0ST8SjA4yAAA9lcJluZiFlx7IwDkKiy/Aja4ce75LQtyYU/5xykC0k6/biVvrjNceE/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402088; c=relaxed/simple;
	bh=W1CyBJT4x/ge45a1DSSotwyY+CjI2YFlloBO0wdfHmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6uOCebJq6GDtWcB1k5xbfk7I3MTfukeYc3uZBtV39iEtF7rhCAx+t3IuAVod9SgsF98dqS21fM5sm/BGjoYt8dexheF/qnhXoiSmp7M3ExVrOuEmm7K5PDc1R349YizGgyCwQbwBF7HMVcHYKIBDmr+ICB1IdyVfUx2Vc9IeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNz6mjKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNz6mjKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8081F00A3D;
	Thu,  3 Sep 2026 02:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402087;
	bh=B4aCo3Kxkdthg2KHpzB0711oeoERPdYQlmTsNKRHWDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oNz6mjKPPy4gGWJaaiKTyH3qn+SnSXvmRm9aVe8qk2uur4xBfJVSNrJD3zeea1q2l
	 ayPxjuDx/MlkI1gOFk4kCkeo4j5+8SkiHz42WIhF+IhETU7FdTlClPSdYz9Kfhkl4H
	 Ak1W6nCopMBMjRh1B7v+oWNS1ai1dwQB9ykjAF36/naPDl9blDljnsXgCicz2p42LV
	 +3giX4XjcKxnlwFhEnllmIvx6zAE/3slEVX8maJ8TgHb4WydhhZwo0w9ecYgYwH/fd
	 lj9yb2rSjilS4j9HoAms8UXccy0ggasAtZOnTNDlJO0wF1nKIQbfMZr6dNmDl/tCNJ
	 fXAYMmQ123zBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0E3927056;
	Thu,  3 Sep 2026 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: pcs: lynx: add support for 25GBASE-R
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840202893.3047971.11842592730625729019.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:20:28 +0000
References: <20260922-for-upstream-lynx-25gbaser-v1-v2-1-1e6cf79c7b52@free.fr>
In-Reply-To: 
 <20260922-for-upstream-lynx-25gbaser-v1-v2-1-1e6cf79c7b52@free.fr>
To: Vincent Jardin <vjardin@free.fr>
Cc: ioana.ciornei@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 21:40:33 +0200 you wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The Lynx PCS never supported 25GBASE-R. Add it, so that a 25G DPMAC on
> LX2160A can be driven by phylink.
> 
> The SerDes side had the mode since the commit
>   1cab8fba5073 ("phy: lynx-28g: add support for 25GBASER")
> and dpaa2-mac maps DPMAC_ETH_IF_CAUI to PHY_INTERFACE_MODE_25GBASER,
> but the PCS never handled it, so phylink_validate() failed with the
> interface.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: pcs: lynx: add support for 25GBASE-R
    https://git.kernel.org/netdev/net-next/c/e8965b0523f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


