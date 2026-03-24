Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236E3750DB;
	Tue, 24 Mar 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317627; cv=none; b=FPRt8HJfrPIGtv8jeOA5OBwmcT1cgbMpkaeErMVO2MhDXvqoMA4+TJW4ImWRd+c70KZchaIOmHaoS7zZ3oy8POeupMHmR5xpe1SChePSkzqSPsfkIUc6joujFywNwAXUlexipCj7AbWzgzOPwYxuIfl5gVXrJZULO5UD7/pe9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317627; c=relaxed/simple;
	bh=OQBHCpeoAQl8Q43gPPj95/3f1ivf1MG8opvYBnlI+Nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QQBXjBm0pVff13EzsJAwpLtiaZPJ2HpaAZkJVFwvWiXF9KG9YWKcrT2I6bc8+nH5/YoEr9HGxwk24QSMxmWYu39QboBYntxy4Vmk8TN0SsmhtqGXSPd76kualE5ctrdS7HN3OyQGo9m+Kn8mswq7yMCIn8FwN2iyQYB2iB2IvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/ZFIyu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/ZFIyu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CF0C2BCB1;
	Tue, 24 Mar 2026 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317627;
	bh=OQBHCpeoAQl8Q43gPPj95/3f1ivf1MG8opvYBnlI+Nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T/ZFIyu42eEZma3Pd1T8V1Wm+Vj4EXiR40DzxRmo6QG5qr1bGuj5ehDrdRB38nHTB
	 p3eudLnESOiwx8MicG9SF0HQc2a8SXdLU0eo7T9Zng1arxS7f7DOtYbD3sC3x9SmQ2
	 8sTjOk7PSeM/PD/ehgvq/KwT+eKA1pqUSlHRbfwE5JlS4Y9j4Ftyivhnk2x9xsrto9
	 6UgG50wVE7KTFXcttdgmAtDWjP1TMcMSP0nrHLPlpXRpLMOP90Zc1cMVVg4qfj/3NR
	 8oUfbe2mXtzD0Uf4Ew+bmUfCmdmKeZU6d5k9jNzng2JWysIDcj0zs5/8GeePKq+0Yo
	 b5g5jM8O0swow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB93808200;
	Tue, 24 Mar 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: enetc: fix the output issue of 'ethtool
 --show-ring'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431761528.416781.4424699978876869702.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 02:00:15 +0000
References: <20260320094222.706339-1-wei.fang@nxp.com>
In-Reply-To: <20260320094222.706339-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mkubecek@suse.cz, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 17:42:22 +0800 you wrote:
> Currently, enetc_get_ringparam() only provides rx_pending and tx_pending,
> but 'ethtool --show-ring' no longer displays these fields. Because the
> ringparam retrieval path has moved to the new netlink interface, where
> rings_fill_reply() emits the *x_pending only if the *x_max_pending values
> are non-zero. So rx_max_pending and tx_max_pending to are added to
> enetc_get_ringparam() to fix the issue.
> 
> [...]

Here is the summary with links:
  - [v2] net: enetc: fix the output issue of 'ethtool --show-ring'
    https://git.kernel.org/netdev/net/c/70b439bf06f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


