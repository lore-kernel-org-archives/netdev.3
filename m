Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274A23183F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356618; cv=none; b=RkBSuhHoHPIuhOWZXgngexNcCkjvWqLuvvvNxNNRFeKsJmFJwVWIzPHlD33mvZSl9fYejOSsvMY/08AoZdePTBh/bTUK3ub5GYKyTeFe0V8W3Zmage3MtoDeRJeWSaN6TgiMWDT7MYiWa8AKY20a97HxWdCm6ESyuXY65n6hdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356618; c=relaxed/simple;
	bh=Io+E9/jACh42NofLlkmVJ4EWwPjlsEobWJiByzv1PoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trQBvGdwvLPbCv0MUmsC+kQL9lHgpmrIJtZJwVlNai54hKnLUWKE5X33M5n4FseBtXcnteTFwtFjyUUzPFjrvfNAW7aTt4hnwoZVNuS0xrEhfFwVYLLZPsju1yxbYWB2ASVrN73i6maxsbTFlj8OXYnuejykLKSuzD3cfLz8r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb5e2AzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb5e2AzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16084C19424;
	Tue, 24 Mar 2026 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356618;
	bh=Io+E9/jACh42NofLlkmVJ4EWwPjlsEobWJiByzv1PoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pb5e2AzGgL02ulaKN7mkzxqHz4t2UIdM3V2Y+M5duNJ4gTTUiVDoQ6ywCxSp+lcTk
	 PkXOC0p7Bwf3gdIa3IzgOKNZod8LrccQ82ZpZXFf3fXyzeFbGsNqCYxX7LeSblUGxP
	 mVDGy4skq1xssv595CRUTEHyNSzvlbLm74Apag4jPEsM5BSykePI5fdOFCPOHLjDdX
	 TN27nlX6mWS33rJ8JqeqcCyNLBBBy7dvZ/s1+NpzoXNyJyS9i8JY+4LC+F4EC+jleI
	 vSPTo4U/+o6+IEXT9lb5Lxjzgp/PV4mszsDgfEOD3PvPms4srtxjnD6lDCKfipq+j9
	 NxBtV8wbuZJXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1F3808200;
	Tue, 24 Mar 2026 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435660604.669121.2908279813353897699.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 12:50:06 +0000
References: <20260321-airoha-remove-rework-v2-1-16c7bade5fe5@kernel.org>
In-Reply-To: <20260321-airoha-remove-rework-v2-1-16c7bade5fe5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Mar 2026 15:41:44 +0100 you wrote:
> As suggested by Simon in [0], rework the code flow in airoha_remove()
> and in the airoha_probe() error path in order to rely on a more common
> approach un-registering configured net-devices first and destroying the
> hw resources at the end of the code.
> Introduce airoha_qdma_cleanup routine to release QDMA resources.
> 
> [0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Rework the code flow in airoha_remove() and in airoha_probe() error path
    https://git.kernel.org/netdev/net-next/c/b1c803d5c816

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


