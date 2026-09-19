Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9007B67E
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776684; cv=none; b=WGiF1zwPpQ1OVmNbCUPY10R/L4EpAm9Q298n0w6zxM1PZ0npHnlSVuP+AQeiX0CT7/NJ64MKSl0Hmy1tQHqOUXu+iperopziNSFboNxslW68JDazY6qV4dcJ8KCPTJLaWx1QtT5HXwBq9Rb6xQdjahmmardHnnNJPl6fg2zESQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776684; c=relaxed/simple;
	bh=nMEYTJZnPUVigSxv7uk45ibDJCeAV1ZRmj2LcaXmw6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+8SZA2Ba3tOln55X9jBJCwUdUJVcn3gZLdtcTRqEELu0q6KPo4D5e4trneB8qRB7MAErXA4/XFchXAd4MN7l9JtIZ+Jj9myZFBmtx7/aGWOYeP1sjLVeFuUr/ZXdhG4VuIbR0VB3emr4uX2S8be7o+ENrJ1/jEpkHT7jRyZb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e60SuyWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e60SuyWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE901F000FF;
	Sat, 19 Sep 2026 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776683;
	bh=/mNgpzfDsj+aQq78buqlirbElosdy06/mfE5sqrJcPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e60SuyWHZjUoGjKxi1GoIJ5mA4Wa9FPUA9WbFc53ozKh4SWqhJdIYKeWXwdTREF4L
	 2qhf/HlYiNKIKAAgm9diDGbUR1NUPw7W5QabzpyKthFeVbOapSerKmjdmb+4xtkHz3
	 3HiQL+lXCEPl3CjNSnw3H65PL3ItpayvhI/Li2fODLWeW4bq04t0Y2PhcNZuk7ng7l
	 oz2UNMM8FcZD4Y3wmqtCWXn26BzY6KUyspvXk2Nb9J0Icn69ccLPZCr8OnfGnLEepn
	 kz2sX0DcmtAegCY3VW8Z5K3+HzGh9ez5/2uI6v5JdA1ogNrnpLnSdnlDexAUcWzsO8
	 +myciuKoNyFbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939033811977;
	Sat, 19 Sep 2026 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] hsr: lockless hsr_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977661613.1197442.5280832257606074749.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:16 +0000
References: <20260916132822.1791040-1-edumazet@google.com>
In-Reply-To: <20260916132822.1791040-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 13:28:20 +0000 you wrote:
> hsr_fill_info() currently relies on RTNL being held, because
> hsr_port_get_hsr() walks hsr->ports with hsr_for_each_port_rtnl().
> 
> - Patch 1 annotates the data-race around hsr->sequence_nr, which
>   is incremented from the transmit paths under hsr->seqnr_lock but
>   read without it.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] hsr: annotate data-race around hsr->sequence_nr
    https://git.kernel.org/netdev/net-next/c/41c57cf05068
  - [net-next,2/2] hsr: no longer rely on RTNL in hsr_fill_info()
    https://git.kernel.org/netdev/net-next/c/9f8b888ced9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


