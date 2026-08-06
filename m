Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F63D966A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043448; cv=none; b=tg4Jz8OfaTiCVua77B+B9gebgw5efXBmenC6VA7dYxvNP8FUtKDAVTCpqTJ9JWkjLLnLSyPIOHw2qQWhivturTSJ2/OZYr143wFcco2v6lBKWNDLz/BWSbHZBsfBZypSBnsFGNkoFHW9pWVGcbi/IboxScQ/T+Dylz+6S5HYA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043448; c=relaxed/simple;
	bh=nggX8lClYFGDIMQApqwIhrx5vQ0FLLeK5EKymZS9LUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6v2gW7AIuY3PkHyuPtP8fWHq0HIeBUtIRma1btAsXTXPTJ5yAl+MbhR8fBMPo3bJA4dcxUC3Nf8nNdOLlMfgxRZ0M84L6wC9chH8B++dOXgIqiQoB6sVG9Sw+ikquvvhvvIko6MQ6ew9ZsMRHTdU/rvaMUhAHqop3h++kwcwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLKr+2Vz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLKr+2Vz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B31F000E9;
	Thu,  6 Aug 2026 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786043446;
	bh=8WgC45sf8MsHgL9P/VikFL3b4KD5FJ1mJofrv06XXzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZLKr+2VzAqV0b6aCdhklkHOjiTSFJl4IuCnoPH/VPehyq7lc6ujaEIr4JVJyEvCPF
	 JDQBR1NqQFcayf3DpgAUF7bcGD/jm0JXjxpXT54UNl3YUh/Z/OQp5VUgJi/0CT+ROf
	 GH+ZegCYUef9xsU+cn7Zqa3VNxK7atKKIIv+pxXkU5WFoh8b5itzrATjqVIcbXfgUr
	 RKpsXzBxh7c8dYGbu+EkKyRgM+i3WEFK2wRNVrc2QxnH9bc8FEfrX+oEOBD53DYlzl
	 6SeiaShwp5wcLMTRVNSmtY5r27ASnJM92S0xpOrNq0Q9HI2p9Yz5wVqCJHXe4JmaL3
	 tbn2vN41t2J3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568313809A29;
	Thu,  6 Aug 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178604340589.1436116.16725373625150986968.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:10:05 +0000
References: <20260804002155.2233594-1-kuniyu@google.com>
In-Reply-To: <20260804002155.2233594-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 00:21:54 +0000 you wrote:
> Kyle Zeng reported that GC could free a dead SCC partially.
> 
> The scenario is as follows:
> 
>    1) Create two SCCs:
> 
>        X -.   A <-> B
>        ^--'
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Unlink scc_entry in unix_del_edge().
    https://git.kernel.org/netdev/net/c/594d90519502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


