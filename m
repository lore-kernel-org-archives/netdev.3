Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822591EF39E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281429; cv=none; b=mg2KMoylvTgMInLGYTQU6NCRXQiRfgEuQQgE4lShSRYx9HADbDA+Wd/4dlQC41bo0mrLju6v9qQ3wGC315FX0HiBBEPBOFVcZXouJ/cAJ6rMyHptE2oPSqkIGtRkjMz6CYqdTbN+8Y2A02viXlJq4UlwRQV/P4ghKKV7at9DzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281429; c=relaxed/simple;
	bh=cHiqbX5cALQXQYhMjNpxGpo74yKGw3xLdqNRrP9GLLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HLIh4Z8vcbjYA3aL6ZwSVytlBCYC2rca1QX0RFLRBtKjKNh+Ieq7+RY8TihveIiEUAPM/vnMOSV5Hs+uMai588qL/6IRMACpGbrhfqz5+cA85PsJdNcGCYf6+yuBrJNTKwNQeXC3vOuRF8kmTJs75f8/mlQUEw6dq+uq5D5g1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9QRlt08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9QRlt08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63168C4CEF7;
	Thu, 12 Mar 2026 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281429;
	bh=cHiqbX5cALQXQYhMjNpxGpo74yKGw3xLdqNRrP9GLLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z9QRlt08+4saGbCWyXyDvoqdCnCFmcnT+lYSGTwNn+1jqr/3ENa6pxtcZydqmb/jk
	 eh+n9Se216GU7DMOoH2UzCpghvA5HKmlaTMUakTrZTavoGwzUh1OyhOaqdqxDWKlc+
	 smdqY1X3XsJTmcrE2nr7+yVLqLcqRP6IsBQmhN2tQs3WUt0QQpIa3sGWzgvPfTZWxR
	 vlO4iOe/18wK1BDDnqDQcy4Z+yf8WPPThVkJnbw5Ftd5wu/9IUb8tXU1As4lQV2WxA
	 P4zc7zAeVHb14yKeinRaYCfv76qYtw/YANyAhJgrO9EdASwzUyBtGMpG/qSrVlxlCJ
	 ICXpONEuWzBpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDCC3808200;
	Thu, 12 Mar 2026 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add sysctl_tcp_shrink_window to
 netns_ipv4_sysctl.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328142504.3905617.6101864313089885036.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:25 +0000
References: <20260310073855.564927-1-edumazet@google.com>
In-Reply-To: <20260310073855.564927-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 07:38:55 +0000 you wrote:
> Add missing entry for sysctl_tcp_shrink_window.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] tcp: add sysctl_tcp_shrink_window to netns_ipv4_sysctl.rst
    https://git.kernel.org/netdev/net-next/c/410593fec752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


