Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DC3BB689;
	Mon, 10 Aug 2026 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405260; cv=none; b=Cx1fIbZyZSVHook1tGH1+vIw5Yjn1NawXaqb4yIO8q/irSDO8P+01glPm/dnz6JCGDzKhkvmvwyUx1b7ipRwoG8EzBy8c5AkWfseTnN4RQ9E0uZbJTRhOIVkX85yMJtAFodPqf2xWA5VyDhRpTvOck73Pg3GYmNF/1/SUL0QWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405260; c=relaxed/simple;
	bh=qiRD28XAgYuyokC9+FAgdW6ToBBiyy5df1hE/g1To+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2+eaNDHgIDDKqWNyx1+e2VouarKdJ2hSNeKxaWZAFTtWk/HAwZ647PlhjeFwkfoq4wHoKr+eAhPv+eI6JTShrjlo4XEQdtQcPp4oFfQ4vMw7nrRPAlZYAAO2UM38FOA9TIY5DOUZfX77tfTwSGkQ/2HcxhrigUTaOgyBSNEVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PObbHsAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PObbHsAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939111F00A3A;
	Mon, 10 Aug 2026 23:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405258;
	bh=dgqDCE+7+AcH13tJ/UostL112UtPgrLsavA7ybpA86I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PObbHsAmkt2YRRrhgCkmb2SwArPm8K0/x6vNmimr404PDGMdsXxV1LG2Au5Zez7HS
	 6XnZ7p2y+GFcheFi/tgXZC+VxB8KfaoREB2V8TdJ4I6DjN93pzvSP6sZKaGQ9D7skV
	 pBAcujLS1lGokzsQV5T5XEPWbMRQAGhcAqKp2p0MJ7FKZTltZXwU834V4gLEKYT4ql
	 teypvubYzUParDBf7zGuUuuLnUCXaBZwxXSuYt+bgF9fzgkQxY4iYrkrU6AAftCR3B
	 nufk53iIsSoqIoqjTa2yTx522Gpe9B7KkGDN0ShxhVWSj3a7t0HKjcAnQg53GTLWiZ
	 fHkrIY9nLrzDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F4392626C;
	Mon, 10 Aug 2026 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: xilinx: axienet: Treat xlnx,rxmem as a
 required
 property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640521488.254991.791827397813626825.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:40:14 +0000
References: <20260806170253.1199749-1-suraj.gupta2@amd.com>
In-Reply-To: <20260806170253.1199749-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Aug 2026 22:32:53 +0530 you wrote:
> "xlnx,rxmem" device-tree property is used to learn the size of the Rx/Tx
> packet buffer built into the ethernet IP, but return value of
> of_property_read_u32() is ignored. When the property is absent lp->rxmem is
> left at 0, which silently limits the interface to the default MTU and
> disables jumbo frames with no indication of the misconfiguration.
> 
> "xlnx,rxmem" has been documented as a required property since the binding
> was introduced. Check the return value of of_property_read_u32() and fail
> probe when the property is missing, so a misconfigured device tree is
> reported rather than silently degrading functionality.
> 
> [...]

Here is the summary with links:
  - [net-next] net: xilinx: axienet: Treat xlnx,rxmem as a required property
    https://git.kernel.org/netdev/net-next/c/34b270e7893f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


