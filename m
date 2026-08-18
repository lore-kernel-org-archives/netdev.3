Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07773E0C46
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050260; cv=none; b=utAjXpQMdHLf4CJH5eVEHBhg42HSe3jz5BmXKh3PJsFpBfMlxo4roMyY3r6npwUANenCF6cSfeAnWD1l1OKhPCE1wTwbCbqjgfDFTChLOjgo0DvB2djEKI0t8U0O9ZUK8QYZ1IfwR6Fx9bYUUyLiEg+v0YRsTGnq0+wKmpM6BDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050260; c=relaxed/simple;
	bh=JY8SLH52Dh4STPq3TJoNvtGSDgXdzQXk77zrsghvIyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sv2XRW5Z6qvGL1kpQeL8D1zdHr0svqTFakFVwM8J2HHdizOjfQh59Ro2++OfRt8JkSDOfWwSaIfHu8G7ato3AYluwVP+VIUui7o4WW7aU/6yFrLefCynpuyafmwekgrjwnueLsswcwfwEh1WcrQjyBLp8+4qttmjPwcXKcFurIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeIraS45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeIraS45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E48C1F000E9;
	Tue, 18 Aug 2026 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050259;
	bh=9kdz9vc2telxKS25pTNdXIXT0OxddMyacRapKNERiDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VeIraS45j+c33FAkOFqBTx5KXCQTbSz1Y/C5R2NaWLaHiXAYc+d0NuQQY9FRPnshc
	 tJeZlAina6bq06mrvv/FA3X1hQyTckVncdHjd8XQjujoCjR9hH8KsXrSECyngTCYPo
	 jiCz0myfYGSp4rw72ZP03LE/jUUEv091gbN+0URaNJvsJ7IpVNvlVkgdgSN7ymX94Y
	 Xoc7MhPRoXq9jljQfHYSPQ6gaHstRr7tvxmRtCfAmlrLSGOJ/GKDyzkZa+/GMDSk/4
	 /cxiSOYPn7Omd6rEVflW/il9etizDj9h0Ej8cnfUk8XGl7mxazIQlTgxeuBsf30uuu
	 1LSPYHPUXnL7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687F3926657;
	Tue, 18 Aug 2026 10:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: fix IP6GRE header length before capping
 tunnel headroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705021089.2020113.16435275301653791190.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 10:50:10 +0000
References: <cover.1786542637.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1786542637.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, atenart@kernel.org, yuehaibing@huawei.com,
 kuniyu@google.com, kees@kernel.org, kylebot@openai.com,
 thorsten.blum@linux.dev, maoyixie.tju@gmail.com, vega@nebusec.ai

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 00:22:33 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in IP tunnel headroom accounting. The bug is
> reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] ip6_gre: fix hardware header length for NBMA tunnels
    https://git.kernel.org/netdev/net/c/505b6d296c48
  - [net,v4,2/2] net: cap advertised IP tunnel headroom
    https://git.kernel.org/netdev/net/c/6b222adeb934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


