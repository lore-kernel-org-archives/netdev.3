Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345D256C9E;
	Thu,  5 Mar 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676011; cv=none; b=jEPzcnwvvFJxSIuCY7iDojn2PVl2IkMWY3N0H5RZPD9ZZBjY3qmG0fBv3JcUgxBKuLhLAmaWMhL88Cl3Ky1RlKhoLwFe70DiV6fji2xolAplz85tZo+PXlWIkMUEBx6uKOsZEv3g1oe29cLZUM0W0vHlXD/Mo/1RcW4RXWZxyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676011; c=relaxed/simple;
	bh=oHwBeEG7hi2UYyT5X2j2MKbyCbmqh2978pXvqg/fwqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcPJSGnda1KnktbeofZJGSD7D5i/sWoki1sdAR6Yz3yoW0Xep8cjsJhfM2iD7Hme9rgNKG0Tr8iirYcasZn+WBdfA+Q7rg1DTmfUexxsYY08N1Y+IjQO/3TN/YnRqo8bVwyB6nw8utiLEyJMXJbLokQCIvX00Hzrg5fjMBW0kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq7iSfE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq7iSfE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2727C4CEF7;
	Thu,  5 Mar 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676010;
	bh=oHwBeEG7hi2UYyT5X2j2MKbyCbmqh2978pXvqg/fwqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bq7iSfE50k3cIEjFFUst1lcCB003tyV8nrPwBaP+2VVDZJRfmfJXvbYIbAUVN9h+L
	 u4weH+mGtSu7sW68CikJpqgJGLSGGY+N6DJsp6DDDpdI3afZLtC/SW2T4iLuB/gCdo
	 WBDRdDOH86Oe03WeLGtDAyXeGG6bMevaWo9qp1fFpqMUQq5VEs6yDjgrfBhNUP4DeO
	 GakwN0hcTZBboukJZ1fK5SC373V0S//+PoJW2JLTLtvOrwi89ihDcVwvwCxe4cnKA+
	 99ycImx0kbd6gloh9wyE08oN4ptPDA6L2QfvQsk+Z74zycT2TYDVeljOJGKqGSEqxm
	 7fYrCN0BWWPIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC53808200;
	Thu,  5 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race
 for
 lockless qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267601079.2478763.11827132188689746208.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:00:10 +0000
References: <20260228145307.3955532-1-den@valinux.co.jp>
In-Reply-To: <20260228145307.3955532-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 23:53:07 +0900 you wrote:
> When shrinking the number of real tx queues,
> netif_set_real_num_tx_queues() calls qdisc_reset_all_tx_gt() to flush
> qdiscs for queues which will no longer be used.
> 
> qdisc_reset_all_tx_gt() currently serializes qdisc_reset() with
> qdisc_lock(). However, for lockless qdiscs, the dequeue path is
> serialized by qdisc_run_begin/end() using qdisc->seqlock instead, so
> qdisc_reset() can run concurrently with __qdisc_run() and free skbs
> while they are still being dequeued, leading to UAF.
> 
> [...]

Here is the summary with links:
  - net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
    https://git.kernel.org/netdev/net/c/7f083faf59d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


