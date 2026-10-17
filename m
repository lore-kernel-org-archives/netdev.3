Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50801DB92C
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197027; cv=none; b=agnF3pQgWRNE1QlZqn4g6JTRoqG6wYhWWETp/oAgoEJ/CV8Tu/DiKRf1UQYRUCWXGn1oRVlC0JLOUvf0NCWuVYSkct/AopHg0YcGClg/ZIHEv+xabKO4kw6CWGOv9fY3zkwrI5KZuOUpe7MX8dMRT3v/UefJeYoei9lONZ1fKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197027; c=relaxed/simple;
	bh=qZ4rNi3EB2EUq+CPJ3VnVYxfiJMTUK/Y6N/ciHQfFBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS83oL9M+evfez0P2hbNrK3/1Q6y9x4XBSDsDn978LxNvkEVsKN5j1lqAOLJn26VXUYP9DAGpHqGfJtM15D6q5WpnKCJ0IgElZGzOUdehvspxd8nw5tIVX79lyLq7v+su2d+9arZ/LRvdIKS/ZRhV+fAx7wcdFvA2A7qtpH61iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyCwFHRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyCwFHRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183581F000C4;
	Sat, 17 Oct 2026 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197026;
	bh=yZx8CSNPTeV2rc+ym2x3eDYhuk2gwtHv21YM9aWmZ/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FyCwFHRWE3FxqhHdJ+8e1Ts0KEeYVpzUYF0uX3PKJ3yJehfVJEjaD++Oqi1CuHKOf
	 eETBfGsvXwmIRA6TC775dgN2oul3a48R5viF1GQLYvM7I/6jQJKJ/rEMFNpZtE15tA
	 igqVdJwdYeL2ISgPh1rkYJg6Gn/5wX0i5wRNsCW4eJ5UBTPfdNX/US877NSWm3PcyQ
	 GQwop50LumyD8tW0U/+PAqzjNJSZBnAvIB3j0f4HLvrgnjF7i9X1N2xwwSDz9fcJzh
	 C2oQuKBlc7g648aWN1Pxyvx+bebMBCBbX3Bts01Qe6BUl0xhD2MsOQA370ddMKCjHx
	 MkJWBNz79akRA==
Date: Fri, 16 Oct 2026 17:30:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: acassen@corp.free.fr, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net/sched: act_tunnel_key: skip dst cache
 for skip_sw actions
Message-ID: <20261016173025.2a25da8e@kernel.org>
In-Reply-To: <179161061150.434549.17402573349623469379@kernel.org>
References: <20261009051930.3619697-3-acassen@corp.free.fr>
	<179161061150.434549.17402573349623469379@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 05:36:51 +0000 netdev-bot+sashiko@kernel.org wrote:
> Could the filter's skip_sw reach ->init()? One way would be to OR
> TCA_ACT_FLAGS_SKIP_SW into the flags given to tcf_action_init_1() when
> tc_skip_sw(fl_flags) is set. Otherwise, could the commit message mention
> this limit?
> 
> The commit message also doesn't say why the change is wanted (presumably
> to save per-CPU memory). Could that be added?

Both asks seem reasonable, and I think you fixed the issue from patch 1
already so a repost will also clear it up.
-- 
pw-bot: cr
