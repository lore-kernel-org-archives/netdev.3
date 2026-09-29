Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0E51598D
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681462; cv=none; b=pnWoweqjeWhuIwHmv266tubcq2B1/yXvtpI6L0yPMlYM19Lzy9rHGGkFi4Lck4k6O4ZRuNDcHg5duYupX1QzJ5MODKkc1bjC8X56I0h/RahMqpYj6CbT91grFG8yrKOgvJ9TCcWf9G1cM3hQrYkyYMRe85MbuUKBaHPeWraBNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681462; c=relaxed/simple;
	bh=rGa4Yu9mr0HifvvD+vQvlZGqdcEfkQzxAoGZ5wTvD4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P3Rgqw/Q8QfJH4jG0eASqb8Q4UYD43xmoxmxvhKYLLMsg4v+xg87hyagnelDF41fMKJeJGsAYv3CBFpvB08mgpfMQIonXSq4XuTfFs+lIW0xMDxsfopo1uKyylSDORBAo/pD/xmITabMdxr37PbyjgjBHD2yk91k7pP603b/x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhoww8by; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhoww8by"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058CE1F00893;
	Tue, 29 Sep 2026 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681461;
	bh=DgoyvaSfw1xKqYhfeRahhmtGg/8Waxcw079uj31iibY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lhoww8byqd0vLxOLtr09iJXOPdUspF8ce9J4hZjeY4jyIqwAShDocfS151W/2FgMe
	 AoU+hnOUy4UNOkCR3m6CKq9O1C8ksGlp+yYxkXdwZID+I6xveWpJxhZnurtr4Ay66j
	 eOed/pEaYOhYQ29rTQtT50R9wtqqwPfnAEA8KLyuUFqafPys5txvco0uqagN37aKgz
	 +hrHK8dyLI6fvJhqDfptXBhWHIMuYhJD7n0GHTrRPdxU5sCJleDEXyVBuQO/I365qE
	 BUR3ZuoTNJQpJA4xYRqihb3qD6ZE9iIzqkJO1KD91b9+79ffypSZyfEyxSS2XOnOBz
	 XwP2ZCJte+30w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16F139263B1;
	Tue, 29 Sep 2026 11:31:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: use two lockdep classes for the
 netdev
 instance lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179068145953.441753.11648229589931188230.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 11:30:59 +0000
References: <20260926041832.1649675-1-kuba@kernel.org>
In-Reply-To: <20260926041832.1649675-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sdf.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 21:18:31 -0700 you wrote:
> netdev_lockdep_set_classes() puts dev->lock in a separate lockdep class,
> by type (netkit vs dummy etc), with the intent of keeping the instance
> locks of individual devices as independent from each other as possible.
> In practice it does the opposite. lockdep only calls the cmp_fn for locks
> of the same class, so netdev_lock_cmp_fn() never gets a say when devices
> from different classes are nested. Instead lockdep records a dependency
> between the classes, and reports a circular locking problem as soon as
> the nesting happens the other way round, e.g. when devices are unregistered
> in a batch.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: use two lockdep classes for the netdev instance lock
    https://git.kernel.org/netdev/net-next/c/b6f74dff6d26
  - [net-next,v2,2/2] selftests: net: add test for netdev instance lock ordering on unregister
    https://git.kernel.org/netdev/net-next/c/e542bad8d52e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


