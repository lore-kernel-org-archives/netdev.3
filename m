Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F739389473;
	Tue, 24 Feb 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937399; cv=none; b=AxYublxmsPHxUbFVs/G7ocVmPidk40222N1klGVuIu8ItwlcNERwUJCRFvPx8/3efLp3xm1SZ8ZBaTCSECbcIL4yq0lITLY7HLokQGHTLKtRc/zJ8M5l/gWEXCqFnzZBTPblvikUC89yxq0QAn6NI8K9MrBQ72vLoy/Lti0wYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937399; c=relaxed/simple;
	bh=fiBYcVViEOVxt3UilGPojzDx8ijJs99SKMjsoBGwWKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XA9xa7BoJDuk/p6A+dQQVrT+gAbVARLoH2gcl/1mwN9XbLQK6KMBukv+mDAsquKyoYe0XabYqf71hg6ZPpMnUZkbD23OdNguWq3TviP2DTyEwH05RrKBj9rltQRXWWsi4kd2UdFH7VeCZ5QIIS9SalJCR528bNn+ihvwkMxiWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJOqkwpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJOqkwpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C78AC116D0;
	Tue, 24 Feb 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771937399;
	bh=fiBYcVViEOVxt3UilGPojzDx8ijJs99SKMjsoBGwWKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hJOqkwpQ6pT6LnWAZCQL5QrQvXifMtftnw9qjQXVv/svmQGIEm76Nt3Wq2oPcdscl
	 XYQp0pPgYoKiOnkF8RFqSuuz5J5BnTAINiZwYAAE5qBpLuTWX2lAOFb12XVyoYSxZ8
	 G26tV05StddpBtusEK+I2kCg5+6FFOAiZz4J2iveKWugr1zsTqxsz3kLkf9+IVQ7Y7
	 BI6aGDRy6NElbKVz3aCMCKWv79kTtfwAg16P1OsXgD8GOuYj8FjtHZy2+DacogAlrj
	 ENPoJEUQCMh/k6QzyxYuhktCtFyyIoQhGRc8Mx2XJvjvTcAX+/l+fBnHjCRF+Cwdz9
	 2PJGJJ4SOWQwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D743808200;
	Tue, 24 Feb 2026 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: l2tp_eth: Replace deprecated strcpy with
 strscpy in l2tp_eth_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193740480.3556455.11942601380923015598.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 12:50:04 +0000
References: <20260223074137.321862-1-thorsten.blum@linux.dev>
In-Reply-To: <20260223074137.321862-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 08:41:34 +0100 you wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  Use the two-argument version of strscpy()
> to copy 'cfg->ifname'.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: l2tp_eth: Replace deprecated strcpy with strscpy in l2tp_eth_create
    https://git.kernel.org/netdev/net-next/c/e5a80f5e67ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


