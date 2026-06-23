Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B9286A7;
	Tue, 23 Jun 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173418; cv=none; b=lu4EgdbhMi+PdGZ1CH5VdhOws922d10PpbAm7aRLCTH5qP54LG0PW7zRz/FzPLm0+Do/OkuTrpxWa8NeelaXvMm6ztTVCnZmYTg83pujBZ18Yi3jvLCgYhGsNul62KneVoBrpW+x8d2TQNsr9cTQBPXSSLQ6NBf/8yJ6nXm/Yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173418; c=relaxed/simple;
	bh=SPKqpafvl4lg1C7w4OeX4WsmN0XrAEsa9qDJNzz34HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jea4oBiAwMwJ89gVzFibDfPGxaNMqrQeJv1K9CFSHF5elLonNOPux9s/vk+NX8/D5GOQD+Y+A3QBCuRZp8HgXaU58ocrEYPrGd/q608Xj+pzdJ/Z/I+Es5LAvGcRNwzsNSEAkhx1Cc7HDciA32gTt1Ku1KWTqoexDxkYZ5/wUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/I1tGxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/I1tGxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39D41F000E9;
	Tue, 23 Jun 2026 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782173416;
	bh=ekQYUcQ8Pi75poqFdcSoDk6fO3ukIxjdl0REmsbtqCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m/I1tGxCCM45zbQwIeHOkh+0Afkm0hxLMeGOzPwCA5hxYr+FeqWwQHPuHR8K9VlS+
	 D8OwUa7pTSYCdcQ/DRbcrS1+09O1RMfomFkEqeUYSfB0STKP8j0doxkPpHiHCOsw+5
	 1Ua1epKwKD/YNIMx8FYfJ6W4KX2Z1Eo4g1VcDci2VjsD/eJGm9FeTJ7dQ13SJkUjvG
	 NC8ibu3wl2SjyTEMYxpbdfEmDmQvNT8hVSfjZjRgU4bOdHM3OtTckeczV52i8uIUOU
	 Upobg4aAq23DhFD173xehE3dgxNhyLVkV0yMXEaaRF7pdyqodB+aWys4dfck8S2L+5
	 41mGNipVODj5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56933393098A;
	Tue, 23 Jun 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217340704.1469780.5855501980510259693.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 00:10:07 +0000
References: <20260616013245.7098-1-zhangcoder@yeah.net>
In-Reply-To: <20260616013245.7098-1-zhangcoder@yeah.net>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 09:32:45 +0800 you wrote:
> In ofdpa_port_fdb(), the hash_del() only unlinks the node from
> hash table, but does not free it.
> 
> Fix this by adding kfree(found) after the !found == removing check,
> where the pointer value is no longer needed.
> 
> Found by Coccinelle kfree script.
> 
> [...]

Here is the summary with links:
  - rocker: Fix memory leak in ofdpa_port_fdb()
    https://git.kernel.org/netdev/net/c/53442aad1d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


