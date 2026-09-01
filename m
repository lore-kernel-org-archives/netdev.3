Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E243CEDF
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232278; cv=none; b=hkOTi3TCoBvsB3d6vuseudFTnwFvI8JQ/cdVxS1U820eYmohWoQZJpnGj+1Xx9Itxv7El4GS6dQIWii3ovmg+HYzSOHYP/QIlKwQRasZTw5p7GimSLyd37jUpYlUevAllj2Vijqn5mIdBe9GWtL6P+pVOVZ/Nh+WhbR+uJzgad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232278; c=relaxed/simple;
	bh=2yewiut/0E/odjelQBs0YxDpUj5bb5AdbfsowasMFb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ql9suxroBbViFOPR7O+DTlVWBHgOavlSdU/WcyJTfOQCsoq6/E9cWKRemmBMYm3EW+S0o+nwT9chRbYZ016pPgHHnowykR7LINalw92ivGLJLbmaa6AlRtwoRvpQA2y1u3e6sPZ+fu98ePmqAyUqe5Hwu0aUW5xzp55LT5tVyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmCWqGjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmCWqGjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F061F000E9;
	Tue,  1 Sep 2026 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232277;
	bh=StPKwAlHcoJHQR+1ozDZnuPkP7m04+q7radmCnEhBmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LmCWqGjnrYdHmGNIZXKJ7GnXTmoC0zeXsxJyTR7zmD9nDPEFS35SJKc77RfMZ16x2
	 imAB9qNw/tCoMzuVTmbJg+NVMKGZgOHRRwO4hzsAz2Ct4kD+GhxfzsEmmU2lpkbNfI
	 3Xd/z92kQi9pxbKfYuVZ2cMTTI1pF9Qh1Mrvlx5RzLOlPD3phZDQGFUjPN9W02dMov
	 PgusXT2NbD/LjKB85A9bFghyLgBclqURoCqAmJFcDYUbgcgxm3sHx5QCrW8f0PNLm6
	 2MAfW920keLM/jkavIymNO+XGCppIer1g68I7iTIo7n1ag4qsRJvqy00MnyeUwlUV0
	 4p3rXsk7yBZ2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 533353924A51;
	Tue,  1 Sep 2026 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: sr: restore network header before routing and
 forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178823222014.912076.17838683829701576647.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 03:10:20 +0000
References: <20260828141727.2372570-1-edumazet@google.com>
In-Reply-To: <20260828141727.2372570-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, corvus@tencent.com,
 junvyyang@tencent.com, fouriezhang@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 14:17:27 +0000 you wrote:
> ipv6_srh_rcv() runs with skb->data at the Segment Routing Header (SRH)
> while skb_network_header() points at the IPv6 header.
> 
> When segments_left > 0, ipv6_srh_rcv() previously restored the skb->data
> position by pushing sizeof(struct ipv6hdr), assuming the SRH immediately
> followed the fixed IPv6 header. If another extension header (such as a
> Hop-by-Hop options header) precedes the SRH, skb_network_offset()
> remained negative.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: sr: restore network header before routing and forwarding
    https://git.kernel.org/netdev/net/c/975b5b067f52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


