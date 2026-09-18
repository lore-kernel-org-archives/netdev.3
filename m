Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910910F2;
	Fri, 18 Sep 2026 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775473; cv=none; b=piczrdecXglPWOIn2W2M4OUPlhs3oIiJNxd4pF02gPGCphD9Nc/SqovAg3D11lEQFvkh6sz+d0UIKLYbGfe2GBJ0dwDCkI/RvXnUJJux7JoINw+gbXOMP2fHXtvi7qE3jK7JFnJerkVUy0QXsT0YKKuG7qNfA1JYR2f4q5Wq7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775473; c=relaxed/simple;
	bh=9mPX3KibE+BrcmzT1iwiIt8f/e6uOWS98cjvwnGuls0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ijhAMoPfdmrfmb7u09/0/9NSWwz1LQLfNVPysJ9MSA0/GcbLzz/F2cMqbX2LuVzzqY754l2ct6TT8mb5oFPgB6hijk2OMWdoRboYB1zrzFmhxnGPTVlMKphKvIS43XCCIFoCiDFNEue7O9ZodXD66NpF8VIbd+CWlyvQp5qE1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKkSzwX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKkSzwX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A41F000FF;
	Fri, 18 Sep 2026 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789775472;
	bh=WDfKQZwBYKGe9oAoN+l+jG3g3NMcVXfQlyqq5UDWrns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TKkSzwX6GPouZZE8hZZtR8OSXn6Rzz8OpRAmhsLDxey+Bow40PJIjKkqcj9qhAw2e
	 4MCtt8UjANbMXHZoog61cwDk6uic+eL/xOCsugT3nyi7jHK0qLv9IDM3N29nSow+Ov
	 GFnT46crf5KRKZnrVQUzi78d5xLNCrVB6WpWa9LDNL33QvP/5SYqLHkURI3MqdoCZo
	 BQIFo0mFdPzBK/3U9YP+cO7I6p58YyX9ei96g2h+JPFP76kojEazf1hrkrQJ3W2jEY
	 uPGlxhK/RFecbwo9cLCJmnNDwfHIHNxmfnEPbrhYwZVAMSW1e3olwhEPts7M3oGw83
	 Iq0k9fsk0UgkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938CF3811977;
	Fri, 18 Sep 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: gue: reject invalid REMCSUM offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977540515.1192795.1118841179305795180.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 23:50:05 +0000
References: <20260915124806.2852293-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260915124806.2852293-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 12:48:07 +0000 you wrote:
> Hello,
> 
> On Eric's suggestion (2026-08-24 13:38 UTC), I rewrote the v1 of the patch
> to move the check into validate_gue_flags(). There is now a single check.
> 
> In case of backports, note that this fix depends on commit
> d335dcc6f521 ("gue: validate REMCSUM private option length").
> 
> [...]

Here is the summary with links:
  - [net,v2] net: gue: reject invalid REMCSUM offsets
    https://git.kernel.org/netdev/net/c/2566866fc309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


