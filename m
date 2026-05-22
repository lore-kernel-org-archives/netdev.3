Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03E36402E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470405; cv=none; b=n+SDULcKw59O5dCKQD1MdT5T4eh89yQHFUKzqywm1RDUsU+mL8WboHvRRzzsIf77ozN/8y9dOmyuNQaN9V3juLAh/F/CLiFP/WEwfZZyHAX8LFZVcVEci1MgzfjG5DV5b3X5ZIRW5EItlZLLddGR8nMKgALHilF3VV5WWyqcRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470405; c=relaxed/simple;
	bh=UYCgxMMY2Ie0bY2Cw7nlIp/nuqT7iKufFYzzWnc29lM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTwEOl9DXhHWVD/2qQXWbzDD36R/a9/urw9C6xDZmaR2PJbfbz3XCtjVet7um2CPN2p6IMHYF3jr958hr+RUerVXH/AGfKToYfm41RWLNqYCGFf9lJfsbrG3Aua5AMXTv/ZLgswYF+Oz4HJdl2lHkqbbV3kocV1twKkMSYolp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD9KiI0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD9KiI0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726CF1F000E9;
	Fri, 22 May 2026 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470404;
	bh=tTVybEOb4+jE3mMmUfhWHRw2jI1ig1nfIwjviVUO66s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OD9KiI0xi/pL3VYBZeqaWzjYFyum3/uLEIm1dcfGmR5w3g/iTpqB88zk/EW1Nx6zE
	 KZQNRty8QDtZ/5bAZ+uCDWG4THeTDd1oB0QIyGi6GzwKL+EAr2jrxabxricIowwvPR
	 kAI6ETULYLQ7TWckPbbPW+OP33sxqJyhRnlNpFUwE6/p5BL+cRgi/Me+uxb8dyS+WR
	 gX9owvL9vGoHnu82iinaZp4czgUZaWgwOEjZh9CmZxsgcynYO5GHdTKkc3nOz49Tov
	 hpFArkGoACkT6tC3CYkvG9UrkEMMJalFe79enKJ2zc755tv0tb1iSUjmHVCJ1o0eHG
	 d/P+OoNGXjOLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BE43930FAE;
	Fri, 22 May 2026 17:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests/tc-testing: Add support for ifb
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947041338.1299893.14484408287750709366.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 17:20:13 +0000
References: <20260521150811.1896373-1-victor@mojatatu.com>
In-Reply-To: <20260521150811.1896373-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, pctammela@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 12:08:10 -0300 you wrote:
> Add support for ifb devices in tdc so that tests with the nsPlugin are
> able to use it when necessary.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  tools/testing/selftests/tc-testing/config                 | 1 +
>  tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 7 +++++++
>  tools/testing/selftests/tc-testing/tdc.py                 | 3 +++
>  tools/testing/selftests/tc-testing/tdc_config.py          | 1 +
>  4 files changed, 12 insertions(+)

Here is the summary with links:
  - [net-next,1/2] selftests/tc-testing: Add support for ifb devices
    https://git.kernel.org/netdev/net-next/c/4177fd446982
  - [net-next,2/2] selftests/tc-testing: Adapt idempotent qdisc notify callback tests to recent fq_codel changes
    https://git.kernel.org/netdev/net-next/c/bde2a04d9b6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


