Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580409;
	b=yzxsagOp8FHLG0RyJGcmyMW8wuEohuA0DQ9zIoVuKfO4Mm/gNwtBXLq/IdyOXR4cn6H5
	 pirtkzMH1i3N1kvRUbbncIlJjAmY6WG5UrAuxjh+tG6LlcLCUAyXfuHLPLyjvxM7UFvZt
	 87f8XyCneBBfxUy2+B+luYHpEhAWoWLXk3heU1Oa5uovmNZ01jY1jAZVLdMNAXS4ppF+B
	 8hz423nN0Zzh0wpAuk5+MlZiazn5UGqINlgrvlpvwISbCzYrTdQhC3hRspiBntbeSqnk3
	 Uv/PjicqmMm7Mo5V8FFAVckPUsGPSBHCYTmgP81GCB5wp6KMZH9PN5TEaj+86kBYUJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RuIi2hSm+hm9id2MhJ3VFVCMeOX+Aps+wpE3vy9VVeQ=;
	b=Uz+6L3gp/suUS2XJums5F8TYphJNJ7C+BlXGSHw27XGXKsP0l3Ph/IyemMy67I2996se
	 VgExIz25bWAgp9OcLaopI+hm00tByXFT5GvUTKdnutWrFzNlCMzvKdlAeoJ8qUwlb2O8c
	 9F52W2wYSpDMYGvaAuuiwagHJThSxL0IvVwjUqNO6dWYqrI9jNCBRTkGFIhz2jtUumD0U
	 ajoe5umIefo6ktREuII0cXgXdUJFL6W/1dxSQGlX0XSrM0L5O+TnBUVbrP365AZGazQFs
	 BnPP5o9JFXT993USYMjmRF7L+LdLCmvlXAYalL3RASSUg25kFoNEryCoTSLfYWVWVTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNta1p9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90777606A32F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNta1p9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA5A1F000CD;
	Wed, 21 Oct 2026 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580408;
	bh=RuIi2hSm+hm9id2MhJ3VFVCMeOX+Aps+wpE3vy9VVeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dNta1p9VcPVSLbEJOyXLZ0DkZBgJZEmYM4XCCUvv3sGmgilaPgWcsiYs82wJht3ej
	 bBlam1wXbHMgiDpuPSN0Gjeo1tG8iQcVcWBe3mHOhjH9xPRIZ3q4RQNh89Ya5Mnv1R
	 N2hBJ5zSL5nnyqNdXfvFGTHV5QEMj9mwCX6TS8+DWL0XwJuzxzJ4q2MA9reFi9euEj
	 gqlgB4lLToGfwxmFVLT2cex9gsys/TpDfPiRBMPXLhv4zIhAIH/h/tVbWg3gsRJRch
	 8TE9vBt7cscURaApT+cxGbA+6aaAhZM0cL7aimIbFCoFzwj3HBINfWsM6TELVc7zA7
	 1wBj21GcIzNyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B443C3809A29;
	Wed, 21 Oct 2026 11:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH] net/fsl: xgmac_mdio: Add missing newlines to
 error
 prints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179258040719.556407.10608057996390058225.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 11:00:07 +0000
References: <20261016183804.39217-1-marex@nabladev.com>
In-Reply-To: <20261016183804.39217-1-marex@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, wei.fang@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Oct 2026 20:37:42 +0200 you wrote:
> Add missing newlines at the end of debug prints.
> 
> Fixes: dd8f467eda72 ("net/fsl: xgmac_mdio: Support setting the MDC frequency")
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] net/fsl: xgmac_mdio: Add missing newlines to error prints
    https://git.kernel.org/netdev/net-next/c/39e24cf5e29a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


