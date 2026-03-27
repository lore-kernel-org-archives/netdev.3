Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343823BF9F;
	Fri, 27 Mar 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583429; cv=none; b=cyzqYqFYYEbkvWodLnRm0iDfoQnZQ8DEm8ae0Ptn0vmVFW9Gx62GVVx20bEBqm7T3wN4D97IT3OZ5uifyJzjuhbKHx8soi5UK5XpWXx0DV97Brs3ZF5QPBUOhkmjLJcsYjz8tLFDzKeTSzr5Fk5gLrLDaUrYu5WHT7XkcQ42IlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583429; c=relaxed/simple;
	bh=PnEHeWbFVlolLNabOX9dBgcUyPXB6gpXLSwyCTFGe4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYPny5k4N/GLPENNdT7G+7ohfM+q50MKEUF93AWIvPpWghCuPHdpkHe9p1xtI1oh2byW8MT97XmcdeSKQJ81cm014ZPQOou14bLJcTnsXWEdbvpMmNu7CXWYqZY/CUl/6J0u3SS76bZb4V4tR7jARFd4fvtFkajE5JP8NBiHsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5kYy8aQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5kYy8aQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C90CC19423;
	Fri, 27 Mar 2026 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774583429;
	bh=PnEHeWbFVlolLNabOX9dBgcUyPXB6gpXLSwyCTFGe4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5kYy8aQQzggA9TNGClm5ujA2vbnRCuj0qx580ZtaGSlsk5qVJ/c+GaN5wYxI/XCY
	 VIwIvgTlCplzz/n/KrT6PNe3UidStrRt6KIUZgu11TAhjXlu4JlJqWRu8WtI2kqoCK
	 KzsRFg5faQXxpUz8WxSLNIzztQBiQeTUszi+FA5RjD8tIS62JcsUN0Kdswe8Qfa0fb
	 qwxa6aDV3+fHYMiAQverComMOpfYugqH4jMK3+e/7ge3h/Ky3R6zB09PKeJ6DVyV2x
	 YTvm7i80xbUSYUS+Xpf3Ti9V0k1E8ZsICskeg//L3C9Oy3tOSKgJeJmpg68n19tp67
	 fzUeZAM6hSdtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FED3809A0B;
	Fri, 27 Mar 2026 03:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: remove unused and unimplemented
 AXI properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458341528.3291104.15630228927960975815.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:50:15 +0000
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
In-Reply-To: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 edumazet@google.com, peppe.cavallaro@st.com, kuba@kernel.org,
 joabreu@synopsys.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, robh@kernel.org, me@ziyao.cc

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 10:05:23 +0000 you wrote:
> commit afea03656add ("stmmac: rework DMA bus setting and introduce new
> platform AXI structure") added support for parsing all the stmmac AXI
> attributes, and added code to set most of the appropriate register bits
> with three exceptions:
> 
> 	snps,kbbe
> 	snps,mb
> 	snps,rb
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: remove axi_kbbe, axi_mb and axi_rb members
    https://git.kernel.org/netdev/net-next/c/a800398e746f
  - [net-next,2/2] dt-bindings: remove unimplemented AXI snps,kbbe snps,mb and snps,rb
    https://git.kernel.org/netdev/net-next/c/af0331e1ac51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


