Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6A314D15;
	Sat, 21 Mar 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057228; cv=none; b=IjnEpC8vbh1IrivNNB1IMwkFniO9CzRZV6rEhCJvF/lwimU3ql8WQYwssS/AgU3khDICef4NeTlg7oDmTesosiW+do0h5Ah9KcYDoPOzW1+TSDvS+WLS5R7u4FUrl6pW0MpO9z2qohCjcHflMLvtgDLi3c970LuBSYBle9XVBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057228; c=relaxed/simple;
	bh=pilf2wWbPay2U3RKocGm/7mXlIEA3XjpKnj/M9yPF9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRlcxUQEyur+1kc3TSRJHKGmGrcfxail/3yZG8Fe42umsP5bOFr/tiNUwrJB0ncpF4bAGTjzzzfMoCV3Nkby3TkaFb2GhsDku+bl0GUVOogdjCWC1SFz4JSJDyz7hULC2ecCLUVjMD2NRymWD/U1btLvCvbZdZl4buf2RFsyzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwJEQr9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwJEQr9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9BC4CEF7;
	Sat, 21 Mar 2026 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057228;
	bh=pilf2wWbPay2U3RKocGm/7mXlIEA3XjpKnj/M9yPF9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iwJEQr9oww0qJB0G97Ocpz6MHItKV1gTwTri9hQmqyl2ysXSWsH/7eOY6ikeTKIsp
	 yuASJsiKiPVNa8h6CsYOki+lhUDeg7ZX90ujDom6bK2uHUQn25CmW0gmYWnYMqmwXC
	 gpOk8jV77USk1PzTJAVzJeoe9mtZrE5Vw/zCRSONgGkxS/T9Wk+PKP1VKUJw+yfrhh
	 mWK3tmjqqMAdPZ54fZIcUPsklCA4DTg3VI9k0XdRHppykGuY8O3f3OFAlvPcx0xKJs
	 u0JG5fj7u5lSOtZMTWs80NxIbO7jna0zvckubCs251RkTenHhR71jLRFqurftqn0Jz
	 aalsWiXmsVo+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD03808200;
	Sat, 21 Mar 2026 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bonding: remove bonding_priv.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405721878.2718727.5327028825935996724.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:18 +0000
References: <20260318-bond_uts-v2-1-033fe0d4e903@debian.org>
In-Reply-To: <20260318-bond_uts-v2-1-033fe0d4e903@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 05:22:48 -0700 you wrote:
> bonding_priv.h only defined DRV_NAME and DRV_DESCRIPTION, but caused
> unnecessary recompilation: it included <generated/utsrelease.h> to
> define bond_version, which is used solely in bond_procfs.c. With
> CONFIG_LOCALVERSION_AUTO=y, utsrelease.h is regenerated on every git
> commit, so any git operation triggered recompilation of bond_main.c
> which also included bonding_priv.h.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bonding: remove bonding_priv.h
    https://git.kernel.org/netdev/net-next/c/79cfb2d1f25a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


