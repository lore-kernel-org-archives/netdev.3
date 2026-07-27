Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF1422E2E
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177041; cv=none; b=WrWgtjQjg1ojmNbMK3Dqh3IgbvwxQUezWKhzw02ZOyzGLSR/tKI2EEAmhL9Dr12CK8O009OskP3iylsmskY47UJG8ndKSBAPs0naTH0ITwt+ap0ugMK/V2hXUCMU0aL3evkU66zIKYlWo6nGHqBgWClpzjD2E1/O3EOWSx/QIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177041; c=relaxed/simple;
	bh=g/1qYHzNy1Ze+aiwy+qlAJMvQCT06RuLaP2YxJ50lxE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NZUg0fGswgdHZcSPl32bOxQ0ZvPLwicRUxABe0PyBBEvX451Pq2qjr7sM3qGqk9Ptl83G0W/xYBR33G4JpXzQXqU+Azj5sqs2FAshqpaYExZm1vzJ5xY1efHMK/w22tQvj90qmXgNKoPrCh3lYB6JLrsJ/glot2dR+KEMjwcmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCZPqzg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCZPqzg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C81F000E9;
	Mon, 27 Jul 2026 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177040;
	bh=v84hRnJ2CdK3Rg5JmMHOaJbFO1Kq/dqn8uyVU+dT7t0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BCZPqzg07ZCvDAgZTx5a8ZoOZMt1G4rtC7wGSEdJ+L8zYpVYRxlm12u5HXvSKRjFG
	 VA8HNW0LGo6nlYEzXghyDbSAG5mhx0BkZwl0ZkV/BLJWuOg5FD4Mv9DbWGYAyeVGh0
	 IehlIFcX9pIKBUOBdTBl6m54HsCvCV2ayegXpopI6iFylTblTIHF02bv7FtpbF2Brm
	 uglwT19vkmJXKbf8OvDyKe+uH/PjOqcc0FVBMKRkeBvHfVh7/MTI+MIM/jSLppxGrO
	 o5qNLCjU4KfFgR7USh1cHDbplBVzUB5htDHFKLg2aodW6EzKuojL91DfZbJDCiCqV/
	 FHP4oqIiz+YHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D7380AA77;
	Mon, 27 Jul 2026 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v3] add print_hexstring helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178517700564.1360613.12711040299075285397.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 18:30:05 +0000
References: <20260726155004.75719-1-stephen@networkplumber.org>
In-Reply-To: <20260726155004.75719-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 26 Jul 2026 08:50:04 -0700 you wrote:
> hexstring_n2a() writes into a caller-supplied buffer and silently
> truncates when it is too small: the loop stops once fewer than three
> bytes remain and returns the partial string. Callers using a fixed
> SPRINT_BUF therefore drop trailing bytes for keys wider than 31 bytes.
> 
> Add a new function print_hexstring() that formats and prints a binary
> attribute in one call.
> 
> [...]

Here is the summary with links:
  - [iproute2,v3] add print_hexstring helper
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5696fee4c69f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


