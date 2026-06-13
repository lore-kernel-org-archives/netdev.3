Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60138F230;
	Sat, 13 Jun 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388621; cv=none; b=PB2EizcIPVbnI0ofbZaSSvl3EturIFjGBemxsLqfGxb93WLEOxgFV19UlqG4ILmzo9iAotTjcvQmixXtENJDSsrZISL5k3ZUOaBGsQdYEfL12iTVGNSfncYrE6Kz9WsQ1jw4vChhJKFhAWuS3UkydWXVxpTeXnM5aRLUH0Fg53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388621; c=relaxed/simple;
	bh=/Oug/pNRXHJGqPFlgsTw+e5WB3xuejV59RapfFu36ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LOybYTXbZRNRVi9nnRR55j7ahxpqtHn5WVBFZPkXySUmYiv5dQqtwtCF1Gu0aU1LsJxmFXENWhAukYIs3geG+189aTqCjbFIvQ8G+UHGpMfdEsBkJmwgndGOrAIEgoEQvNEgcC3tIdgk7t0ZJj2PoLXQdH2NyryCd/yu7RQexHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiXdqZFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiXdqZFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C2D1F000E9;
	Sat, 13 Jun 2026 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388620;
	bh=19FBxUswghHTWUIHNlxI5Z7SJfZmwx46hU+hD6shOCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WiXdqZFzujXWvi0QCgOnoZUx+V0Uyk9bvGePPdtmyQuslJKfRRgEpV2EhxFD9W5sJ
	 U9r5a8B/DLYXMzGO3+acTm9BZN58ho4knkKzSh8DDQM2bFY9DopLk9+B5HHqw52K2+
	 plOLigV+kAYHtC7a+n5/DKqTHVrgIrHwRBb2Gzz8aaGy6j1U+3Zksqu/+i/DCs3dQt
	 kajCrbWGTPCIfBH4NfSxwwQr7Y5mdjU0f9TDwwpVGyazW+ePNp3mB8zyGeuqE+Ejyt
	 bxPLTtwHeHeRKmksviMfulo0RvywHfFnLebhi9QB4KigILWggHAVp2Og/FwVew8/8q
	 o9tRREtTAgfyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567F13A54A32;
	Sat, 13 Jun 2026 22:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] ethernet: 3c509: Improve style of
 pnp_device_id
 array terminator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138861588.1607522.16950074806423599930.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:15 +0000
References: 
 <a0cd057e6a24b9d355b5e4bdfcdb812cdd1e4652.1781082923.git.u.kleine-koenig@baylibre.com>
In-Reply-To: 
 <a0cd057e6a24b9d355b5e4bdfcdb812cdd1e4652.1781082923.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: macro@orcam.me.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 11:46:53 +0200 you wrote:
> To match how device-id array terminators look like for other device
> types drop `.id = ""` from it and let the compiler care for zeroing the
> entry.
> 
> There are no changes in the compiled drivers, only the source looks
> nicer.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] ethernet: 3c509: Improve style of pnp_device_id array terminator
    https://git.kernel.org/netdev/net-next/c/43746895a5a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


