Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7B2609E3
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891995; cv=none; b=sR7tKDO3jKLjxT8JlHEZVsUtrokB31o29RUarV+CVfNORfGfokGxiYjLT9k/E9VN1De3bC6Ojy+MungEo2afMXHPld9Jl4HuQKabTcSkyT84UmkUp+tQw4EPt1sDWcQccTwmNQyXDykxi++EUlk/BE62SOoBzuSwrzcDdk1FlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891995; c=relaxed/simple;
	bh=EOqSeO3QvugFD35kGK9YlzXpxedFTfucdlbbBqi9v00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4CgM61DQLyHOAs6hOpXtLg1aBS35JdtpKpa2nCscPv2gRSmJh4E0mmL/UzmMGe2Rsi8hi+eV28Hfc5LtP90kC+EjChhA1A0rkwb3j6qFIt6/x1xIRlnCUKuMTQtjbgFPKmNHBB9iFP2OgLHNyhxqgSR2B0ROwMN9hnfbtTJlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT257aCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT257aCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C469C2BCB0;
	Sat, 16 May 2026 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891995;
	bh=EOqSeO3QvugFD35kGK9YlzXpxedFTfucdlbbBqi9v00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GT257aCIPnxOifVWgExdG5ZNlkf80+Yihcq7oHyzknu2jZa2AIof5ooKmtEo7rnZU
	 /eyNzVcXs/64lEvSd2Bws4hjqpw3Mxt7Mqtz7omA7m0rVwiLbSOSHAQ6WViVqV1jf+
	 d9J3MhX0PkCHMjYcJFjerh/CKRLk5hVcnaSh4wvtJzXstCpE+i/aZOULqzeVrICsLO
	 NgBWi1U8pOltJ6e7QRG0U3kAVpTx0Y9MzBqoYsZtKcMAjh+IJ8uANKgRhIOY32iqk7
	 b0Lvz3duGkPhwvXkaZIDbXNb2EJDcBpr49P8eL8aPLlHQMx+q8eE9Zgl4iUoM2TEi6
	 80Ba9/MwoVuKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6B3930A23;
	Sat, 16 May 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: hsr: strict supervision TLV
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889200813.209257.3024065532842824125.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:40:08 +0000
References: <20260513182657.20346-1-luka.gejak@linux.dev>
In-Reply-To: <20260513182657.20346-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fmaurer@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 20:26:55 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Changes in v6:
>  - Dropped capitalization comment changes per request of Jakub Kicinski
> 
> Changes in v5:
>  - Reverted TLV loop in Patch 1 to strict sequential parsing per IEC
>    62439-3.
>  - Retained pskb_may_pull() logic to ensure memory safety for TLV
>    headers.
>  - Dropped Reviewed-by from Patch 1 due to the logic evolving since
>    original review.
>  - Added Assisted-by tag for AI-aided translation and formatting to
>    both patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: hsr: require valid EOT supervision TLV
    (no matching commit)
  - [net-next,v6,2/2] net: hsr: reject unresolved interlink ifindex
    https://git.kernel.org/netdev/net-next/c/85ee970039f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


