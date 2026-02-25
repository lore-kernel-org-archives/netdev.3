Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54882BE7D1;
	Wed, 25 Feb 2026 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992590; cv=none; b=sYAEmAhiU6oA32s3GAuMGPtXnTfF+sdCDH1k+GZuIrwq1DT+ZYU3nAkczItDCS756J5wmDBHQNIQID6+IKbjKmFzQmMX3IKGiYW9wwq7WokrppTMMqVYEaYyGjOGLf3XtLGiw5Y/+wrq87SGGeEF3KMJzwZSzRFN8UXuQ1q8Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992590; c=relaxed/simple;
	bh=RMBa7D5h1ftTyJLqLsVXguQywkNV8bB5KmFCiALLmb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EdsihMek9KCnOTm9x+FgDu9X3Ku6atoYnK3sI1wD2FxULWjQPVxy/+c06IeMhwS/hkAOW1kXCZDjVK8GqG5hAtAA554rGGUjY1KYvGY+qSjCJ4MDbcYizhhYlOgoDehj3Qo6Cw7mDpwz2NPE7tu+3F2xaOcnPOdIdQFhPWkGy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4qMn5fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4qMn5fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DABFC19421;
	Wed, 25 Feb 2026 04:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771992590;
	bh=RMBa7D5h1ftTyJLqLsVXguQywkNV8bB5KmFCiALLmb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j4qMn5fkOWnB51e4SWEPKt93KmLZDxhqfqpHx2JfHvYVDaVk6RLYVTbCr5neoT4KN
	 r9fV61B4zbHbBzP1IcU9AZDb6CNQgOjUgXPSu5HWDPswj5MRaqDBRpwxOLTWOqyWkX
	 8I0mgE2b/pC26he+c8p7ynX//SCQBO+sAs9p0NTOgvWKuVU8ttkouXKtAZ0j/5ViHW
	 Gvp5BuWQ3zNFZOmpTJqx8kETj+n+NL39L8QOCzg96RVxabprlBhR1youPJ7DfGeaDP
	 KXduCoePFrtmoujrAjc3M0rPJqdrF/pJHGbr4s7R9qeg/3DCDheDsNKvkML0xXqLvQ
	 C8O1vFIwd94Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB8380820E;
	Wed, 25 Feb 2026 04:09:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: freescale: ucc_geth: call of_node_put once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177199259529.36698.15027911300492192448.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 04:09:55 +0000
References: <20260224014141.352642-1-rosenp@gmail.com>
In-Reply-To: <20260224014141.352642-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 17:41:41 -0800 you wrote:
> Move it up to avoid placing it in both the error and success paths.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: freescale: ucc_geth: call of_node_put once
    https://git.kernel.org/netdev/net-next/c/d2adf01780b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


