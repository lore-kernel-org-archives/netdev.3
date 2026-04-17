Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAB1C8603
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391843; cv=none; b=pkHogH+DUV8VgWXPlk4+mbfjTTmfuDsXiAlAbW71pTJEPmnXznA9dGKUUThkAkczDFwFCCrRWZqCZNknJM5vcsLIkdE04Wn2i6GRMus6ZbysiYGZSbPAw4qljlwK34tRJzTdNMupYaVwAkk89g8iuz2wh+qDn4seL3kur4AynW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391843; c=relaxed/simple;
	bh=/bgy00+4dQ+qdVqSAhqIMgVG2c+nPIoBLaK7Cx2GAZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ByAPWkqT3hiGtFEZPEB7hyDaSwuIXvZolCev1/BqC4+0F/nunvwAmhJ/Vgn4jvNaoXoZw3ehfYb42VjsY/omZTZIr2AEz/wLWvDApENJ5v7rk3zDy160dO9TipsSUfVK3GK00Zov9uf5SH15C94mqVVuJ3SiZApQ0fD5B3wCgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE1Vv+EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE1Vv+EV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78A7C2BCB3;
	Fri, 17 Apr 2026 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776391842;
	bh=/bgy00+4dQ+qdVqSAhqIMgVG2c+nPIoBLaK7Cx2GAZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qE1Vv+EVo5h4eXbn8veFGVomCLLA1gDOOcpiaeHoxK0sNI2x8YDPlhvRIYUehdM/u
	 RDgpzqs9eZn8UMSkCXZAU1DxAHDDPyVqugxfRJIgdj/vGS8UQDMoL74HiJPSKPUoLy
	 7ecnGFwge0/zDdR2uom1oa1rNm3NiJCoDuiE54RS80VNUXTh8Wye7RlR6bR6jURZhP
	 jbMektIYQxKzfRBvuRga3lLIqvaxtIh8ZQV2312YwOyTbIA/KIb2+OakRvY46fJ2fQ
	 RsI8kkMLXlFK9TfV0wPwGx+ner4mpGwFkBgTLARbgKzSAO8fR7nCQRF2TwkM2GtA3k
	 Onhr/3VQnHA1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD38380AA76;
	Fri, 17 Apr 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Wait for NPU PPE configuration to
 complete in airoha_ppe_offload_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639181104.3482475.13335009889872843570.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:10:11 +0000
References: 
 <20260414-airoha-wait-for-npu-config-offload-setup-v2-1-5a9bf6d43aee@kernel.org>
In-Reply-To: 
 <20260414-airoha-wait-for-npu-config-offload-setup-v2-1-5a9bf6d43aee@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 16:08:52 +0200 you wrote:
> In order to properly enable flowtable hw offloading, poll
> REG_PPE_FLOW_CFG register in airoha_ppe_offload_setup routine and
> wait for NPU PPE configuration triggered by ppe_init callback to complete
> before running airoha_ppe_hw_init().
> 
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()
    https://git.kernel.org/netdev/net/c/f3206328bb52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


