Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFA357739;
	Thu,  4 Jun 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587612; cv=none; b=f0ciM9GI1SaJsZRMQ/hsTv7HiKUg0pQQW1MSKO9PG0AmWhyTTMeEUxRRqvQlg7mVmCjDcjvN5Dyat0yj+fakul6gyDx1sNrFN/AtDBZuygQiVPf/fUHcIn4NWFb2GDDSnkZvP4FcuyEcUFVDYmzy8IC8gYGl0QatXgV0ff+C8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587612; c=relaxed/simple;
	bh=/rUGej2MGP84f27RNUwztKF7h5FO+yM4OYc+4cewIGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=raM+KOoFOt+KpOiFj851XFOCiK0KRHRkCz92Cl+E/D3hUF3t/243UKkjLvru6hCa5CO2bN1VQQe2YvaxxdWgoczDpl2/hjcyUoKPymHaBs8noCyUScC5xXXDoyB2nJHh3InQ5K8U4wfIuxXdoWiuKu0tg9SOUJ0+mXSE/Hnkg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9BmWkXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9BmWkXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F1B1F00899;
	Thu,  4 Jun 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587610;
	bh=g44vb4cJNxzPYADdsaz0IhyAXPgMs52PGjXM19UfY+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H9BmWkXYU79MQLqJUmBahWy2mF/xTR4uY/Fsw1viXuZZ0btARrNUDSu6kl4fIiN3/
	 5ciEZqTt/JSgGmPJ9AxibC5Rtkrd1useIvPf3qSOFRNbZpPlo8f2Atrng0NNariJ4r
	 dL7iSmGFWg2Jx9cZVjqI+rF0ViBcJIJF7E/AIvAGRVSdFLz/GA9XAzzll8LE/7fOKL
	 lTc8TeW7vaoxnykBFbTLw48ArvHDn9RKVtF5r48W+9Xzm3Hp7DqvlnEHu5ioV5TwxT
	 FjDCHqjVBfPhpALPqm1hBRAb8mAC0sJ4zN/vlm7W6k3nS3uSfubFs4Ht88cZJPBfiD
	 DibgPgdVKfxew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E239309B7;
	Thu,  4 Jun 2026 15:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-af: npc: Fix CPT channel mask in
 npc_install_flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058761114.2484354.3159760124892673965.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:40:11 +0000
References: <20260602045853.1558530-1-rkannoth@marvell.com>
In-Reply-To: <20260602045853.1558530-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 ndabilpuram@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Jun 2026 10:28:53 +0530 you wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> Use the CPT-aware NIX channel mask in the npc_install_flow path so that
> when the host PF installs steering rules in kernel for a VF used from
> userspace (e.g. DPDK), MCAM entries see the same channel mask semantics as
> other RX paths.
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-af: npc: Fix CPT channel mask in npc_install_flow
    https://git.kernel.org/netdev/net/c/1d31eb27e570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


