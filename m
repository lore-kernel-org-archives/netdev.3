Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE270535FC9;
	Tue, 22 Sep 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076078; cv=none; b=iwhayli+VyohQcFZL8KgcDZOZdT+xHfp8wExgtqA9a9ZP4JjW+vn/w+3rOtOJ+lfOOReKO8xurgi+SCDsYWp6hW3wVsWW4puzRkSTwlX/lTq6Q2QUzO8YCtqOiPqC1zQO0njx8Dv9sLh0cPyOCS5rypcKiLXoURJIn4Bkd0ZC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076078; c=relaxed/simple;
	bh=+4tCfTDfRwAQ8RuZ/8lIKsOvWrG3/PFfxjfLSttZ/pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PxZCgaaeYt5K7l1IGMMmkpR3LTR4ahgPxekOElERK6//R3fxT2Kb+CIcq0CFMwfJXNS6eBfhxL19Mh4BG3uf1HIi9YI0isyc6O4sBjyt86clCS3O+xJJWWCVqpUBEHvBUe3IQcSN4Dzll982m3F8BUR9EN9dGetk98oll/rP6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPlbKs39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPlbKs39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F155A1F000FF;
	Tue, 22 Sep 2026 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076074;
	bh=BGzoa3tYX0WloKEZ5QWmp+UpSqkBEQ3x5uGZEDcJ0D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dPlbKs39RR9L9TRe4XrMmV4qzTh45iOVDcu9LeYJxU0nVZ7wmhWBT8cupDlABF7Du
	 Lz0LR0PA2cSqrfaYduoJHiwXIu/et7SdRm41XYz17nbnlZ+QOBRpbLWEJfy4EDZj1V
	 /e5iiYpYqmr1JbGfUGTsMpK7+Tb21fzQwI0kEZINqxzTGgHEf4vpcXlYDDBoZqHL0a
	 dhh5fPZIg7+VnCRMv+umis3vunmfZkE3zYw1nTbJTOmXaBwoL4rwi3fX9ncLDZgirA
	 NaGzpJEoqOPmOo6yaHmXsM7I//wkPOcqcEt6ZKpKcdJVFDeLExTq+a6gx7Q/nGhX4+
	 DblAhPmuaBOGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695638119DF;
	Tue, 22 Sep 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: netcp: fix pm_runtime usage
 counter
 leak on error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007600515.3566792.15569021435495117440.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:20:05 +0000
References: <20260918042804.13101-1-phucduc.bui@gmail.com>
In-Reply-To: <20260918042804.13101-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 mmyangfl@gmail.com, vadim.fedorenko@linux.dev, nm@ti.com, w-kwok2@ti.com,
 m-karicheri2@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 11:28:04 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> pm_runtime_get_sync() leaves the runtime PM usage counter incremented even
> when it fails, but the error path in netcp_probe() does not call
> pm_runtime_put_noidle() to balance it, leaking a reference each time
> resume fails.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error
    https://git.kernel.org/netdev/net/c/ac4334522e4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


