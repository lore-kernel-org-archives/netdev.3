Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0C400974
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429069; cv=none; b=pECCDmj2Iai3n/WIdcMpSyie8M+9mypn5i1DDvwyo5mDCMBL/oqaW53eGdM8ETny9D650ub/9JIupCedvMuo8g2xikh6pm3wcO/8K1AWm7WOQ88UNt7RLPFTD9XNcf1MKXXB8qk3ZByZfiFVE3+aJl6384wQTaYE23YX4YnXRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429069; c=relaxed/simple;
	bh=4qKhdRjFHRPBLRq4S3p85DzX1PI3SDtRZmtlrTHIGT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CE/drgMnKW5/Tig3vhSehTJQEdmuXvo0v7icScyMWcgx9pYNlE6tz2kWlXm+MBsa6tAzbFapNjqFlmfdw0KEtC21ltz6dI0H+pxUnhkjqzRZQsJ7Gv4SSxdCZHri/4JuxFIr6SUriDgIC+lWKcBLGbie6+WV6Bkp5SjODxCZG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZnupfLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZnupfLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8011F000E9;
	Thu,  3 Sep 2026 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788429067;
	bh=ksZUcQBRxfvrV0GF/ZsHrJNnDemhmoO3mBUTr3d4ttw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IZnupfLnB5NnabUmmPHFLLqcj0tLvoXZG6m8JXAQlJJVY9D4wNgLickloA6RWq58R
	 QxNe2kdGnUVkMDcs7O2IcEdx0yRn2WWY6dkzbMZYp0ucDLNnQdKNvGyhV9TlWGs8lA
	 BUl0a3VKoQVvYGnvnjuqDADX8gaqpjYbsvt/I3DtLtsxmiOHSJqwZGLRgb/kLuhzo9
	 GY34XWD/lsXHu8QErIh0ehSTsk5tC3Vsu2SuZHZsxseSe2lRYa1aBafmFcbAuaub/g
	 6XGyYIUTYwP6GtG8Jso9AXOsxkyrT62ef4xVkolMo2I+nI42g+6c5IkERsd0R/zGFh
	 dLhW34Q8JO/IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ABD3811965;
	Thu,  3 Sep 2026 09:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: reconfigure RX packet parser table in
 stmmac_hw_setup() after reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178842900914.3234406.11176564790633654802.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 09:50:09 +0000
References: 
 <20260831-stmmac_tc_cls32_reconfigure-v1-1-21cb459e64ae@oss.qualcomm.com>
In-Reply-To: 
 <20260831-stmmac_tc_cls32_reconfigure-v1-1-21cb459e64ae@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 19:06:38 +0200 you wrote:
> The core software reset issued in stmmac_init_dma_engine() during
> ndo_open() callback clears the MTL RX packet parser registers, but
> stmmac_rxp_config() is only invoked from the cls_u32 add/delete paths.
> After an ifdown/ifup cycle the hardware therefore runs with the default
> all-pass table while priv->tc_entries still reports the filters as
> installed. Re-apply the RX packet parser table from priv->tc_entries in
> stmmac_hw_setup(), right after the software reset, so the filters are
> restored when the interface is brought up again.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset
    https://git.kernel.org/netdev/net/c/6b8fed2675fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


