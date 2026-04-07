Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610C128816
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523776; cv=none; b=aMZ15mCRyylTH/B2YDiKW5YQV1UzTzPodzKYNzeHFKRB/fJvwNpK+axQ3MtEJJSvSAKf5HPmDaeeGupe4SgIsp9s9UxyfBVG/HqfSaNqGuMGJRmRmP4Q6n5GxHH7k4jmb5G3dXxwNk26GavokKTEDIwp9M6mJYNCwu9JwkCM4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523776; c=relaxed/simple;
	bh=rkf0fgbTP7bgYADgMKfIsWZ63L7EVhjot6xCBdGd17g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bndC7rAc6IX+MsqlvR2VqAt3/hAMQGwDwn+nvX06WIrl/DxPlyqbjgcAus2pOFLjouz7dcO3dB12vMdGboiphof74QJw6scyi0/eLMELiNsok3nyEvjVZLIIw35MGLQXhsjN6R32HEC/Vk9qkcjlJjoikGIWWCCseXM0NYbiNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1f/mxHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1f/mxHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5559DC19421;
	Tue,  7 Apr 2026 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523775;
	bh=rkf0fgbTP7bgYADgMKfIsWZ63L7EVhjot6xCBdGd17g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c1f/mxHgMMV8capHdWsx3RFa1pNViQyzLmqloxnDAM34uFHziSyNYct1dYwWZA4Rx
	 sQfsskkrBDrOT4Upfc3zZDzLW9V7dCZ33h9B2tyIp+Gj/gN11pK/FwfervRn1AScNl
	 0O4UItlMpe1H15rhjI6WIz4vLE6PRMKwlxRy5RoKCb+EaqcmD8hKEGLYJz8+YGx+QG
	 2CUia0n5knkb3SptdE+Z+DX82eAwzd0l0iHVaZlg588PsqYSUh5ElBgorU49TvgCCc
	 TeT6vVw1M4/VcvCywcKdLho5XVbcLI/8gzeIncUiIGPNolqcaGgzvWYgEnoILOILp/
	 2VfX9BEr6auJA==
Date: Mon, 6 Apr 2026 18:02:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: dropreason: add
 SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
Message-ID: <20260406180254.5221a267@kernel.org>
In-Reply-To: <20260403022443.3480770-1-edumazet@google.com>
References: <20260403022443.3480770-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Apr 2026 02:24:43 +0000 Eric Dumazet wrote:
> ipvlan and macvlan use queues to process broadcast or multicast packets
> from a work queue.
> 
> Under attack these queues can drop packets.
> 
> Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> 
> Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.

What distinction are you trying to communicate by using BROADCAST 
vs MULTICAST? Funny naming of the functions aside I believe that
in both cases we're basically dealing with multicast traffic.
Reading the code it seems like macvlan has some optimization where
it delivers the frame inline if the multicast group is not very
popular. And if it is popular it schedules a work (and calls that
broadcast). ipvlan doesn't have the inline filter and calls the
deliver via work multicast.

tl;dr I think the drivers do the same thing just call their functions
broadcast vs multicast. Having two drop reasons here is actively
misleading?
-- 
pw-bot: cr
