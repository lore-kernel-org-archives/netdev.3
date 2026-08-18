Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC23E025C;
	Tue, 18 Aug 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078286; cv=none; b=LRYuDWiUnIBnCG5hkJz/4wBXy5/p48Jx3mUua4in7R2sVLS1JsFy8FzWOBEf7Sny7cMgTRQv85uwIA3xnwX0saknPM8XMKwM+v2W03IV100yr2J6NHbUiB6HKyJDGodfusHG7zg214YpLxNoNveo91MduQ2DqroGiGOw1CnW0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078286; c=relaxed/simple;
	bh=hA0Yv+Nc+xtRxWxZEUetmdQsdo7a5FhBLBvOuZTdfYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/3MTdTVDPTWSkH+s7C9JWb6VawASZ2ZD/ptouDUUZQjHW8i4dNpjpVjX8cMMPq32KgZs4R/9QNPFatGaU1Dvawwz6Nnvi/txTw2ELmVPmkl8S6sa1yK1JiCEMX7VljyiHWPo9XaBqVvRsYEXk0XYijPChQZpDI38EZueXNh6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFOe729t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFOe729t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE91F000E9;
	Tue, 18 Aug 2026 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078284;
	bh=h8b580K3YAodwbm9llDb9hE3QcsY5Ub14/2Dy6qDhQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hFOe729tAlLaV1/ar+/hzaOVNgI3kDte8Ue1W0BTHIrOMwJQTIO1cmzsg5Kb6DFLY
	 JaIS4meueZJfoIfcH6TGPSzkMOvbJda1tESsvupnnmJco9UDYckWOfRKS2OVm7hk7F
	 OLnX7X59FoZZ8jbERBfqay/BI1fyenjBdP6RqAOmc/ZrS7e/9libOOUvHqled/5IZx
	 qOrhM7EfLdCNj7e42yCJ4+4naCOD8OUFAG7Spmj1GNU8rsVSkhJZc5FxZDxZnVxQMl
	 lNUGtDTCpBeYKyndc2abRjee8G6SrNsdxu6Zqw6/NrrvHQD+Grx2a/BTd7phBbtAKB
	 rn7wDVVM40xWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56882392704D;
	Tue, 18 Aug 2026 18:37:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] NFC updates for next-next 2026-08-17 (fixed)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707823584.2194892.2999815923161079008.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:15 +0000
References: <7fc49075-884e-4284-b742-7057cbba4b17@ixit.cz>
In-Reply-To: <7fc49075-884e-4284-b742-7057cbba4b17@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 22:13:52 +0200 you wrote:
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:
> 
>    Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-net-next-20260817
> 
> [...]

Here is the summary with links:
  - [pull-request] NFC updates for next-next 2026-08-17 (fixed)
    https://git.kernel.org/netdev/net-next/c/b4a8e1fae517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


