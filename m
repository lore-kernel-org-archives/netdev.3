Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509416;
	b=UJej0S46aXvHp6OM71b7f58U/d/tXnBOCEALRsEEWNr/1XJLxzQK4M2aFBowVAczjWsJ
	 1XlMoHP9bcsBtZfF7mqTDSitRiQtUSQUZmS9K1tGoPdrt0qKrKF8HEzQP6qLJS/5YQTPG
	 yGSkgVZw0Jjx3myXtS/5U3bPH2l4UvohQNXdjEqSAhKDUKdy5XDgUAR08XXDHF3QFB44Q
	 ztJ0OSFR/pPrC471gyA1FbzQFFcBGp9eMmJGRKolh171lfeuohRAisccURCJI3u/0Cjrh
	 0e+0UWuiUjnSq+0Bdw7TbTzIsUFRwyQFQNt1nV6Mjh+5GWK6bzzZ3fYi2qeV2lvE0gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509416;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=80vv3cqlfBIXG1D9OPEkKjMVllOZGi6B8vewKrw0OGE=;
	b=VgOxNHQNZzpSqf8GjcmEoLtClBFvluntUzZKbe/9ukjQcL3kh4WXAiZupaZGYMmzDqaF
	 q29DqmDp6hFoTBCExRHrUL864PrleEjLyYME8r4Cw0SbduKRUwbvIOj+WMQyb0XQSesq4
	 VKExnZJ7o/UPhFI32/4NBYKTLDTujT+EEpxMjJd5kri8jxDxhtogYk079LWVLrAMJK/sy
	 alzQR4HmN58IejpeI3Wyev541Q4LQQEO7FzwDxBCsDiGRv5vB+i21ZlN9EeAjUmF5+UFI
	 0wk3JNhMcRLYG014n4S8HupBAR5calLpW0xHKaqaywhlttByKV0QRl2ISjpxP0LOy7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2BLGzym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609460A262E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2BLGzym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456161F000D0;
	Thu, 12 Nov 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509416;
	bh=80vv3cqlfBIXG1D9OPEkKjMVllOZGi6B8vewKrw0OGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l2BLGzympnbZv2bFSCCW2uWPfCYkYe5CaINg20tztxBMMsuvEcHxPbG8GZgpANOWR
	 4UNkad01F7mSJLeAX2hcuiKhK5NTjH2ZI2zfdVeGv86FRSxdvOfNiIWu6RYNDXeLM0
	 9PAIWxkzE6HH1CKi3mLZG2giY9vMigHpSXdveH6jTwMuAkKinSf1fLBK0Q+2nADsQD
	 2akz2Cq87PO3cNTBQrK26sa7ZDyXs9z0vjAr1C716LOrVDZ/0qg69spP6qfzVKR1n2
	 e948qLnf3qAiBMDMiiNPA9cTTIjhFgK8AeMsFANzljk6oMbqKfask0sudUXkcU3jW2
	 0/vnrXPBVskKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A36B391AF9C;
	Thu, 12 Nov 2026 18:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Pass req->rsk_listener to
 inet_csk_reqsk_queue_drop()
 in tcp_check_req().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450941477.590019.3909326510994377779.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:14 +0000
References: <20261111020304.1532064-2-kuniyu@google.com>
In-Reply-To: <20261111020304.1532064-2-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 daniel@iogearbox.net, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 02:03:00 +0000 you wrote:
> When connection migration happens in tcp_v[46]_rcv(), a new
> listener is passed to tcp_check_req().
> 
> When either of the following is true,
> 
>   * the new listener queue is full and
>     net.ipv4.tcp_abort_on_overflow is set
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Pass req->rsk_listener to inet_csk_reqsk_queue_drop() in tcp_check_req().
    https://git.kernel.org/netdev/net/c/a9782a6f2bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


