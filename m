Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B7480953;
	Tue, 18 Aug 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071863; cv=none; b=Vtg4A/4oZjekkkWg9JxcorylUb/pjHPjDu/1kIwkqEet4PXwZX0lT0TKzZfbUQ79Fkw5YtRsc6ta+WSmaqBU3+nTH7q7ifTnpDj0Hx7RQgYIlqVMXABbwhGRUQo5SlRqjnI0Yk9qO9AqzC+wa9tEzudbU3m0B0+u+tBvgtDh/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071863; c=relaxed/simple;
	bh=XkhC9fZ3rGmN2xJzbIpVb4G8uj+SsRGf0ts+qmSNKrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hD3L1R6ESgiWpE9ymIj/7erUEj+vi4sFKNX73mToyK2q4rR1mo1MtkM1/aWWOV0vXamxrw5TiNFVAZhfkVsfCrrPezjC8UsNdUkw7NBqKqXNEqrar3sVqkawdCiiVRXHCVbRpXrl+9M1uofuW7VxQoDAlpN1lv2nUKnQxEMpzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0R3Uz+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0R3Uz+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E81F00A3D;
	Tue, 18 Aug 2026 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071861;
	bh=wvofqOkwTaNyhQJu4ZPtaN9R8EsbejcXCXj1njecaWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W0R3Uz+5/B3QxhCe+ju5Yr9HYpPKjVRgirQYCBYc7rbkbnRK28IvxOh4UKPtnK1aX
	 hoAJbXgmYv42HDAJmguZBoesS3N0CKaUZhrbC1WvV+C6CFW75khUsmygV1+Fb4HJCi
	 pTBTBnQBHC2PO4y6x1xco8JlAZFZLpXWJSmIGIW+Cqyrsr61W84r/S7iHm8P08ME1r
	 MefgcmKewM9abgAwhY5Q5xXJEFr428qKrMFyifIo4AlAyFaWRACzwNTohfI0fZIhaZ
	 pMpeRGwtlvWPTsHiNh+F9aqeu4Mco9VG6EXWE9jtQb7d4kQtkj5kUh8evriSkEWe2i
	 RN1jJENjHFHIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567FA3927043;
	Tue, 18 Aug 2026 16:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707181295.2177226.1948973853593102909.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 16:50:12 +0000
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
In-Reply-To: <20260813153126.3952893-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 23:31:26 +0800 you wrote:
> Empty NLA_NESTED attributes are valid, and bonding uses them to clear
> the ARP and NS target lists. When either target attribute is empty,
> nla_for_each_nested() does not execute, so err retains an uninitialized
> value before it is tested. The request can consequently return an
> unpredictable error after clearing the targets.
> 
> Initialize err to zero so an empty target list completes successfully.
> Non-empty lists still propagate errors from __bond_opt_set() unchanged.
> 
> [...]

Here is the summary with links:
  - [net] bonding: initialize err for empty target lists
    https://git.kernel.org/netdev/net/c/8ccc9bf9afee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


