Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD437A490;
	Tue, 10 Mar 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109218; cv=none; b=cfD+XoyHg7h2QP1Rf/htuhheIVGPRUzS9CZChSBvBl74bFAKMfXO5N36Pzao8YonM0ll1PUePJWmfAlUGFCTxEHhx1rJEe7PUvzqOiTsln/AnI0zFu7zRim7t9uiFHPaisKlWMuXlnAbxLU6ziATf/vCKiYhx6gXJ9Ov/VVZQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109218; c=relaxed/simple;
	bh=+Ef/bFPooCB7v7OTPo0B2SvGWKKa3ASfNvgFzMW4b3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pskXGplTzhlS1qcVcnTc9JuWHy+DuT6wFfyEePFPO0FTYc1/UhBDMbC+LpSqhm+zItHzhnW5jIpc4nb4VFiM3vWR2K3TWML0fLcJSv8Jkoo/ENbzA1k3mVzxERD93kxdW5jQvUDa4T0QSDYlWE9mt5dFfEE8iX/e5xctejqXUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0INe24Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0INe24Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70C4C4CEF7;
	Tue, 10 Mar 2026 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773109217;
	bh=+Ef/bFPooCB7v7OTPo0B2SvGWKKa3ASfNvgFzMW4b3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0INe24Yo7Mpz1/ekg37jPAqYkmJKAZDgA7WzIPZBNnfz7/ILERJlB5DW6SjfpiIh
	 mD57c27b14B8aTAIAYb4jDww9N59t1NU75bIdGMcArfpWW3N4rzAc/zQYfW0uiD5aB
	 18kCfPWJWtX5CjLww4oOjgYxw+8I//MUV5fFBW4X/IdB+aY0z5ZMK64H0dC4FVY78K
	 iIJdIkVtrY2zWi7wqwg/QkI7mH/JiQsD5BKTeoo5g3OiAoQjjwCNCO0mLatcMElCY1
	 bJGtFthOWdm0PQt3FEmxA88CAOdsJ6sDWADz4imOFmIshSBi+tJpGRIXRB1q9vuIfR
	 z47l+MXiu0hTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA13808200;
	Tue, 10 Mar 2026 02:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ppp: simplify input error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310921454.2028885.14368988773145653916.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:20:14 +0000
References: <20260306093649.1048232-1-dqfext@gmail.com>
In-Reply-To: <20260306093649.1048232-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mitch@sfgoth.com, horms@kernel.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 17:36:49 +0800 you wrote:
> Currently, ppp_input_error() indicates an error by allocating a 0-length
> skb and calling ppp_do_recv(). It takes an error code argument, which is
> stored in skb->cb, but not used by ppp_receive_frame().
> 
> Simplify the error handling by removing the unused parameter and the
> unnecessary skb allocation. Instead, call ppp_receive_error() directly
> from ppp_input_error() under the recv lock, and the length check in
> ppp_receive_frame() can be removed.
> 
> [...]

Here is the summary with links:
  - [net-next] ppp: simplify input error handling
    https://git.kernel.org/netdev/net-next/c/abb0eb0b033a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


