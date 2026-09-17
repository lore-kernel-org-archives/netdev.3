Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9F5476C5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652480; cv=none; b=hPfCEMZ1gIMmysSgBG7nHBYx5v69fAy4Sy8vzlZhwd1fZ+eE6+NHtd8FySKktSqpMBoXve0Lh3bzoKxtTOb8OP4Kdxm4RJe1R/VgU2Upclp3Ifg9QitYsnMR3fuFNxodehY9ST+x4+C/MF41vmp/Q3PFHHxWHANnEGaxClNsYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652480; c=relaxed/simple;
	bh=Xy/tqvIdI+6n/j3nA7Vng52h9BXIm39OBwM0hIYAEXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXG9bNgjMvDSQYTeAWFterobh6utXO3vJEkOlcQfLVMOBeN91Pw4A+fXQFITRERSr9NK2UfZPLGialLNO+a7SAFFjk2tiin806Jbjq2NwrBpkbh/dgNMlwy/gocLHAF+J6UyOCrJZNWguYmiQjgkgwtdxnnJYJc16ZEn+9Tn2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xoo7GlOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xoo7GlOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AF1F000FF;
	Thu, 17 Sep 2026 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652471;
	bh=9irFOePy0fPDMXRnTeU8mfjx3ZiHKUWqHb40fQox8y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xoo7GlOlL5Qv7oG30Ht8G9XdiamDkEDBXScKWw2Toeg+pfJY/uGJ0LakS7Jw1ZtAb
	 RNbt+jdZ475ei8zmnwqc7PljDagKlvnamPr9uKRszsqbBVFHuUEyeISvOklwJWOUQ9
	 vIkj7hhMgNALeJd1pS2LSXaCtiKbM5vgJYBpMT0m10MpP1tix/c+uCs6+P2hqRouaJ
	 wGM4iGsDoSnqjbu5Pia23v9JAgtCZGRy4A9QxucP67WL6Lwe3yGQTGWprRstO/J58/
	 bBmMowfXMYIZE6jWePs+rzju4nJ0F9kK6Kjw+JB5Y8GTGOfkiUa88YmWNGBrowqm4M
	 auNvvkPyPCj5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199933811958;
	Thu, 17 Sep 2026 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: add IPv4 and IPv6 address
 order
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965240488.3650140.11503348888989636421.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 13:40:04 +0000
References: <20260914065848.10518-1-martin.jaburek@suse.com>
In-Reply-To: <20260914065848.10518-1-martin.jaburek@suse.com>
To: =?utf-8?q?Martin_Jab=C5=AFrek_=3Cmartin=2Ejaburek=40suse=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fmancera@suse.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Sep 2026 08:58:48 +0200 you wrote:
> Introduce the following new tests: `ipv4_verify_same_scope_addr_order`,
> `ipv4_verify_inter_scope_addr_order`, `ipv6_verify_same_scope_addr_order`,
> `ipv6_verify_inter_scope_addr_order` to check the ordering of a
> set of IP addresses after being inserted.
> 
> The implementations of these protocols are inconsistent
> in regard to address ordering. IPv4 addresses stay in the
> same order as inserted while IPv6 addresses appear in
> reverse order. This inconsistency has prompted attempts
> to unify the ordering, so both protocols act the same
> (as IPv4). This however caused user-space regressions in
> certain applications, which relied on the order as it
> was prior to the change (particularly NetworkManager).
> A similar inconsistency occurs when inserting different
> scope addresses, where IPv4 puts link local ones before global
> and IPv6 does the opposite. Attempts were already made
> to unify this also, risking further regressions.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: add IPv4 and IPv6 address order check
    https://git.kernel.org/netdev/net-next/c/b8a6f2340999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


