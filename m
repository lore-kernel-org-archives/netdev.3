Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC512D5C8E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717625; cv=none; b=Gx5eX9Jid/evEU/+wx3oChfDdgYidYB1Vaw38ZWsQQlpxs92EXN0n3iZnGmAjyAnI7O2eH2V1ssn0eAejqLQGtkBCcH0mDCGsmvKyytLu+ICOXF0ZZT8g1a6HQ8TfkJ9xplqwvc5cFiJEdWXTzkol4IksuglX4icO2kN+H7rRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717625; c=relaxed/simple;
	bh=HGiLTD0IeBPs0tWAtHglH17Tdic1dLc2oqzeom/AURQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VFLA0FlDtBmsPxzioCRJuRuOyk9inonIgsO6BTEBkPrkjaYz4cNSEigcsbprE2cybMChkZE2Zd1N+uLLfz+PBkzK8Hmv3mLRAs43rYIRvSsqV89Vnt42eTIVj4B0hg5E2Jv5rYo0MmwKcQk0lFdgpLCcZFpkWo34sBGPfpbT+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuZv209Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuZv209Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB65C19421;
	Tue, 17 Mar 2026 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773717624;
	bh=HGiLTD0IeBPs0tWAtHglH17Tdic1dLc2oqzeom/AURQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SuZv209ZVlDuxDPx7JRpTJQ9Z+mn4yLC6g+8JBLV97Qx0eubrM0mAMdg1/kVlBs0D
	 dHikerAzRJ+wjcb4ySwWqT0clD5M4QDzTr5oHZDe6hnpQFrCgElNVdR7o5QWmdtzlv
	 t4sCkCzyooP5z7dwaZhfuGv9NEil1uUAYtUR8SCBo9SW+e2Z/l2+LoQofgpLc7hqk+
	 Db8KoJG9Lr9ZJBEhHlPiXD8JbtUQGmGUF+DZu0On5gT8QKdMkpZuIaZVIxd3PDi3F2
	 Fk5MTTwp9KkjOekSekBom03/xjb9idNP2JSIWrFrYZFblLAAOQL+2APUHRAAQ1pAWG
	 /bGWCbr1oXl+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD7E3808200;
	Tue, 17 Mar 2026 03:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: move MSI data out of struct
 stmmac_priv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371761729.3410412.18078716874517842825.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 03:20:17 +0000
References: <E1w113e-0000000DDwc-2oRv@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w113e-0000000DDwc-2oRv@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 11:51:58 +0000 you wrote:
> Only three platforms supprt MSIs, which means having all the strings
> and interrupt arrays always allocated wastes space. None of this data
> is performance critical - this data is only used when requesting and
> releasing the MSI interrupts.
> 
> Move the MSI data out of struct stmmac_priv into its own separately
> allocated structure, and move its initialisation to a separate
> function.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: move MSI data out of struct stmmac_priv
    https://git.kernel.org/netdev/net-next/c/dab177cbea34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


