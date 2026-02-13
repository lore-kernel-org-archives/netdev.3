Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CE27453
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951024; cv=none; b=OcIBLpbST+drWyq43iaSYxIMoMYhfe/ncd+yDdJpiKp24xW2jAXHl6LPfRK4MjR7ugZgtifL/tD0AHmqCPh8s1HgD/UIyqxedC/EyNZ8E5HGSOMIKCkcOeihrJA/hPFeC3+3u7R5AJidCyqScpMq8UnfQCBaicX90iZk8QKu7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951024; c=relaxed/simple;
	bh=WxTSb85yViXicohYVEp9C15lhjKg6NznnwUAYus+dTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSm+r4ShfCZefysWQB5/N1nYhc232XYxp4G0WS33cLr5m0T/6wkBP5sIhfFWvJEBzg0g6r7biEFLOsOTxinlt5UNkmK5fp9c0QRfaiDbR7sjcGTiBkk9uBzTfu0MFZtVuMimqqYc5hMOKmQ4whbtGo6TuKXrZ5AzpMB7nUQzzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6QOYyVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6QOYyVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E281C19422;
	Fri, 13 Feb 2026 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951024;
	bh=WxTSb85yViXicohYVEp9C15lhjKg6NznnwUAYus+dTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r6QOYyVr8XHpEQgXJIGfvy44Lys/2SysReL5XmJSqVbjB2jenkpMKwQCppgN1+UQl
	 XkMrAu1evfrHb1gvdzFmkEn3awB6pLVY2iMkfZS2FQACZ9ev1I5++cBucgtlmBNbsS
	 MS0SOzwx6FyDvdN/6agFu++lf4K72KsqQ35FK77PEReK/FZOV/EsvOxx1SBFvERv50
	 pBI+qsLFNGrsRmzWZON0JDyhbP48QS0mWxf5DMjQ7OgTL+210Fo5tb5KVfY5oxL1xj
	 A4BpJRJObdsDAi9tXcJGYqFCWmi4+Kt5mAAEiLymZLOey7Nrs0jpoDGUVNUB/iYXmq
	 m5VzkOzSr3Zjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851653931093;
	Fri, 13 Feb 2026 02:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: ensure our nlmsg responses are initialised
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101807.1819996.11269616219568842622.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:18 +0000
References: <20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au>
In-Reply-To: <20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matt@codeconstruct.com.au,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Feb 2026 15:27:33 +0800 you wrote:
> Syed Faraz Abrar (@farazsth98) from Zellic, and Pumpkin (@u1f383) from
> DEVCORE Research Team working with Trend Micro Zero Day Initiative
> report that a RTM_GETNEIGH will return uninitalised data in the pad
> bytes of the ndmsg data.
> 
> Ensure we're initialising the netlink data to zero, in the link, addr
> and neigh response messages.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: ensure our nlmsg responses are initialised
    https://git.kernel.org/netdev/net/c/a6a9bc544b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


