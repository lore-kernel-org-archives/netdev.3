Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB740DFA4;
	Tue, 28 Apr 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337972; cv=none; b=deZfe1mwacSCWVOU05JbxZlfjWQGza9rm9Ltxn2gaHxdTVA9iKNfzv1uX4QXmiE9GcxchCMvXWCc31MfYPzS+7WBkhjwiAvgz85YVzHdN9sj+oqJiCNd4CiyVycfxWCcssrZr2ZQ3sDJTe5GWZ1D++HgGEQ1aPCmry1lUPP4KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337972; c=relaxed/simple;
	bh=mjRXv6kzYdkDfMJMvOHLBH0FA+3MSBtmLLNASDy8OYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4hLiWvKDWWfNUxlRLHjcbxjOQmu30D2oSqntiLU9yayu5KkJRwCAg1oVWExj/6Y8LkszZVVKRrnavTKMv6dQxljpdP32RcCJFz2cHgPvOg+xijdGVtMrJiFfKWOjC5mGmApVYMk1ox1jXS7HG2Ahb2wQQ0Ns/JdxxmUbT6Xm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+vEgr6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+vEgr6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0676C19425;
	Tue, 28 Apr 2026 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337972;
	bh=mjRXv6kzYdkDfMJMvOHLBH0FA+3MSBtmLLNASDy8OYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+vEgr6juGMgK25uV+gj3S22n3/1z61h32JhRewTolBQBBjgwC5hMsF/BLhxVEvG3
	 d5Hpnc1jVqnmTQK1wQK8vD77DNG34M75UMw3OMO5MdfTab51DynjPbJjWV1EMj4zkf
	 lUKRKvbYkDQisr3nwjdK5qOpalNLiK9XjI27OB9HO5n9hxePCE9sZmNzQKjas2TP2D
	 uobGLYGSQtDPc/gBCJCTnTi8tuCK9lEQMqbHoSYB1oVW9TrVh2vCgetkAO6Tlt2MFq
	 W8o1pjIXVwGAuBGvyuHlp0jxmItjO+3NUCsU5QDiYSC+vM4WQp9zfR5rtwJgK2ZQQA
	 WoB2jNj42AJdQ==
Date: Mon, 27 Apr 2026 17:59:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
Subject: Re: [PATCH] net: atheros: atl1e: use atomic functions with memory
 barriers for next_to_clean
Message-ID: <20260427175930.3c170c98@kernel.org>
In-Reply-To: <20260422093717.893646-1-hanguidong02@gmail.com>
References: <20260422093717.893646-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 17:37:17 +0800 Gui-Dong Han wrote:
> Found by auditing atomic operations used for synchronization.
> A similar fix can be found in 6df8e84aa6b5.
> 
> Do not change atl1e_init_ring_ptrs(). Its atomic_set() runs during
> bring-up before NAPI and interrupts are enabled, so it is not a runtime
> publication point between Tx cleanup and Tx submission.
> 
> In my opinion, implementing ad-hoc lockless algorithms directly within
> individual drivers is highly error-prone. To avoid these subtle memory
> ordering and barrier bugs, drivers should rely on established, well-tested
> kernel libraries like kfifo to handle this type of concurrency.

I don't think this is sufficient, we can still race stop vs wake. 
Please convert the driver to use netif_txq_maybe_stop() and friends.
-- 
pw-bot: cr
