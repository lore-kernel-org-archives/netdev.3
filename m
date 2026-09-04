Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337918BC3B;
	Fri,  4 Sep 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483076; cv=none; b=I0uvHjX/yTyVNN45FeFEtZ3Odcfw/OIHymTeHkanyCLxLn7xdDpl2NArvnyQlefAsnKnnc8ZE6a9qIhqF327vv7yZZdNwhW2WA9rnSCbvqrrGXmp8meqbgyFV7V/iFxhppysvf7Mvzsku5Le1hbEFgszjHlpUq8uctoMEVv7h5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483076; c=relaxed/simple;
	bh=GHwd9FNr/5zAAF8/XIfM2hC1MiXYNC8y4e599Yppr8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=upqTHrp6XodCs5nJJsp0ZflF8pNDeIYoXccEzYKGx5y0YCLX3wKDtsOPBXtJlGufypnp0vVr2IySB5P125qj49SmapUTj7v2w8fC+nUvJ4ZE4oNZNnAENy/CcpwRPnHu5PTFnaOIoDxCPc/pJBON+GH4wiecj5aUqEl4fpia4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9ViBNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9ViBNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD63E1F00A3D;
	Fri,  4 Sep 2026 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788483074;
	bh=A1tn9tCG8b2zXx+4CLQfoRK/XdzrLaCJyKbrN2e5OXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ax9ViBNA6Ar7XTnhk4bXi3MS98KaXekFSCjFZ7Fw+SaQZASueHBr75AoAK296lSZp
	 34e4f7A8/q3rNZAiD5MJP3UmAMk5sWRaaNBQghUCaS7zwzDxxVDMja4OvRgGvPLWVk
	 AGm5N10OuRH3XeXi3uHLGVOVt2z7gtao/eQAOu5a+XAVK4FzIgs7Y3u5JaVHueXH3X
	 xrPON6e1wVEaoOPp3o+yLw8dTSBeBBclsTw5/pxoXzuCgeG09mk03KA+HX8mQbgsrf
	 NzJFdbsvos0/d++rhlrKK6B33JtJlIcTyxVEtRFKRtFiBSE8IZYcbGf8hVXdDSb4Cc
	 rUvb8zjqLq1CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2D4F938119E3;
	Fri,  4 Sep 2026 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: airoha: handle RX_NO_CPU_DSCP interrupt,
 not just RX_DONE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848301589.4094353.8627471932045802930.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:50:15 +0000
References: 
 <17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com>
In-Reply-To: 
 <17f1beec505b87a4acf16557386a978c98f94b97.1788286284.git.sochnev.v.74@gmail.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: lorenzo@kernel.org, netdev@vger.kernel.org, upstream@airoha.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 19:32:53 +0100 you wrote:
> airoha_qdma_hw_init() unmasks the per-ring NO_CPU_DSCP interrupt, which
> fires when an RX ring runs out of free CPU descriptors, but
> airoha_irq_handler() only extracts the RX_DONE bits from the same status
> word. The NO_CPU_DSCP bits are acknowledged and dropped.
> 
> Once a ring is drained to zero posted descriptors no further RX_DONE can
> fire for it - nothing is left for hw to receive into - so NAPI is never
> rescheduled, airoha_qdma_fill_rx_queue() is never called again, and the
> ring stays dead until the interface is reconfigured.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: airoha: handle RX_NO_CPU_DSCP interrupt, not just RX_DONE
    (no matching commit)
  - [net,v3,2/2] net: airoha: grow the small RX rings
    https://git.kernel.org/netdev/net-next/c/e84b89f17a12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


