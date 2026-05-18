Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC63382C7
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147615; cv=none; b=ZHWG8GyN7X+qlAMJEpMtgD0HzrDodchZPDsie1fzOwoTJdj51205u1nBCKeVATHHZ8j7RjYQhehDx+pEs40IvWgduA7F9haK3d9t6fy5D2PfNwKYVLdQAWCLwTOyDh/iZEawWWztgLgrMAWiFbhhhhdw1UJ+27B+DLt0RApPvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147615; c=relaxed/simple;
	bh=f5T/RZ8Kfgw1IL3MycKeHgVh5NcthDi0AkWE4IUqMjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCCMba6ThJ5ceT5sv8MKuWYf62y0NHKIt7P9xNa1W3oN1P7M2RSdMpzMVIRIG1vJHQHhCzv9kIktxt5Qm5g9IbkVtf7XWqncA0EXDF7rKpEtkuYhuk1cSKkuy3QwHnS8Dw5qIJgK2mUAJg6OI9vkirBzNPH5/pKgrdiMd+OI+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE4rxdd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE4rxdd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9AEC2BCB7;
	Mon, 18 May 2026 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147615;
	bh=f5T/RZ8Kfgw1IL3MycKeHgVh5NcthDi0AkWE4IUqMjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IE4rxdd6i3TPWpgOFj6LksJC+xq+1FSAF4vPS1mKTZ6hwWgV3JQnGrMF+REQaMXNo
	 yMjLM7yIsc2V5CUCFacq4wJgDF0i86XAxWAcH1W8+eZj7nYj+PkAu3I+yfBuhptKYq
	 88raHfweHC6gBUglCIPQiYgv4rwLsBxpJ822SClEW8NqXwJ4oO3eK3FpIxZn6tq28L
	 iY9IOG6ZpOeSMdHvablku92RIHgV0UmqFDAnyy7rLyloVTlYov0co5o6GdU/QPLp0v
	 wjeycXIL9PYoKUeARspNsluagNAxOAXWX7AD8txYyFz7LcYl91w5Gbo6mvCHsdew/0
	 HT0W7EenyijxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09813930CBF;
	Mon, 18 May 2026 23:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: fix endpoint use-after-free
 in
 rmnet_dellink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914762638.2012201.16160511125102291139.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 23:40:26 +0000
References: <20260514122511.3083479-2-bestswngs@gmail.com>
In-Reply-To: <20260514122511.3083479-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 05:25:12 -0700 you wrote:
> rmnet_dellink() removes the endpoint from the hash table with
> hlist_del_init_rcu() and then immediately frees it with kfree(). However,
> RCU readers on the receive path (rmnet_rx_handler ->
> __rmnet_map_ingress_handler) may still hold a reference to the endpoint and
> dereference ep->egress_dev after the memory has been freed. The endpoint is
> a kmalloc-32 object, and the stale read at offset 8 corresponds to the
> egress_dev pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
    https://git.kernel.org/netdev/net/c/d00c953a8f69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


