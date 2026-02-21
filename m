Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14343FFD
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632599; cv=none; b=U9r+0ylyd3oszpBKXTPkSdiHtvlTTZeTHXzcTBjiHifqhPDKkPrSfrMQAN1nJ0hQpgPLYGXsKRLCl7Q36TpSf0ggxQo+XvHhBZ0sPgOpMB2AaZj6gWCcI2HPq3FGdtVhX2BWT5Q9DKkJT9lIFNRVcLp8NzSePI+S6l4P9MnPAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632599; c=relaxed/simple;
	bh=VSZSBLRCeMvnYLETY5dGLz9iKlp4qm6f/vbyUX7NbjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iziVXfF+duELl5t3S4j4OZRoezWBo4ZPJOHuX0dCDmyfkh7qn+WeCgyV/K4/leW8S8DbKDWAdMNA5aoH8i2mHDfN2OGWZBlPqh+k+7vSr5udnr31/AA0Y/QzTfvoEzhb/VQqo919dbY+GYs70+6sY1WwNlt3Sw/82U8b7HoT+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQMiomrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQMiomrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A4C116C6;
	Sat, 21 Feb 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771632599;
	bh=VSZSBLRCeMvnYLETY5dGLz9iKlp4qm6f/vbyUX7NbjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kQMiomrqO/2nJsCDtGwjZyuj2JyzLVkdk8/epHJrw7l7KcMhFzohdwXYGFwIGIk+h
	 3ovTir2L/aQptXr1XSeRLv/2s6qGpGuSr6LrNtMr6uyx8wLWnpTlgmmikAbm0FZAdU
	 aVgOMCSqoNvRwUtYRXU+w4MNUxqWc9TKw5p/heWd2vI0nnXPOwg4gVQtDt9iGqKqKW
	 nsKpEwecvFJoGLU1AKElVscdbPsgGfSDLZhrArQP+qsmB+9JbQvgWx76UxTaynFRxx
	 8cX0flUrfSLcWQ3zKJ/cyOryBSygv+GNd69l2LWGAQLZ27Vd/jogG+lWmvqXDqFJZ2
	 9rJAn2lLoLW0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFCF3808200;
	Sat, 21 Feb 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163260730.953043.10079455494727515357.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:10:07 +0000
References: <20260220094133.14219-2-steffen.klassert@secunet.com>
In-Reply-To: <20260220094133.14219-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 20 Feb 2026 10:41:15 +0100 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> xfrm6_get_saddr() does not check the return value of
> ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
> source address (returns -EADDRNOTAVAIL), saddr->in6 is left
> uninitialized, but xfrm6_get_saddr() still returns 0 (success).
> 
> [...]

Here is the summary with links:
  - [1/3] xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
    https://git.kernel.org/netdev/net/c/1799d8abeabc
  - [2/3] xfrm: skip templates check for packet offload tunnel mode
    https://git.kernel.org/netdev/net/c/0a4524bc6988
  - [3/3] xfrm: always flush state and policy upon NETDEV_UNREGISTER event
    https://git.kernel.org/netdev/net/c/4efa91a28576

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


