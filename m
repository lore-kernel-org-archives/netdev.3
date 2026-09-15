Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415C2AE76
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461071; cv=none; b=XuvCWrBGZinq1iKiOBE4AD8ZfnNDtKzFEY9mUaSPeMoN30u2CpmqyYOUCjebrtkw5MJA7QcU+rgDBpuctZdtGs7+pvFmQgTVoPTCZkkipZ1LzfOOCqN2ucdXefZDBT2Y3YV/CbEG11atq1phnOIm1odG58RtrMsNI+xM+xnN0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461071; c=relaxed/simple;
	bh=682hzvTdRatTwJU76t9+EfdPBRFMlzklP87Rv+8p1PU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aSdR0G3Ga57ANFSaelEeX0gYG2i9WvMlRBZ8iOAT+GcFMAFPfRT7bp1Ku4AkvibpeIaBfiDhBZ8U9b+2lxCKBUPX5XLJi18ygHfWuN/gPBBnNE2eYbuK0ogpD3xoyObOsV+LLXlBi8XN8b+KojPl6HTOvPsOjvyeqWC3op80O2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlHiySV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlHiySV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40831F000FF;
	Tue, 15 Sep 2026 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461069;
	bh=31iIRZZbvy9G2DGvv+t21Gd2CvCtye1W5fHP9tKQC8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jlHiySV0U+V+tPhi35OcWowrWexN8G+ulpqx/qRT/1BDNj+yzB8da3BbIgFCn6jCZ
	 3RbQwSH6yNkAnS5cVuw4GoJMCboT8HMqQyshv3jzePjRid+msH8YPf43j7MPi7tfCI
	 hLTNaRYt7QxQP67amzBaPcCat12eQBUcdrK/ihuedk78ytszy0w0mljL7LwP15AlnY
	 vIoCircKG+O43TEcOg4ceueWILZwj6fRyVlU9GrRv50n1IVFcjzsgYvmC8Qyma/+dw
	 rG/V7tDqRp5L+NQvC5VDzK25Bcd5AsvBllWB+oSYTAAEo7aS9vrpaKc8KMs9yD/9SX
	 jU+Nr6a1im++w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D539253F3;
	Tue, 15 Sep 2026 08:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ipv4: icmp: reject RTN_UNREACHABLE input routes in
 icmp_route_lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178946100463.1445535.3847929510041961174.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 08:30:04 +0000
References: <20260910140042.1880242-1-dongchenchen2@huawei.com>
In-Reply-To: <20260910140042.1880242-1-dongchenchen2@huawei.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 herbert@gondor.apana.org.au, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Sep 2026 22:00:42 +0800 you wrote:
> When the forward output route cannot be used in icmp_route_lookup(),
> it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
> the original packet's source address.
> 
> ip_route_input() only returns an error for truly invalid packets. For
> unreachable addresses it will succeed and return an input route whose
> dst.output is set to ip_rt_bug(). The existing check only rejects
> RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
> and later used for output, syzkaller triggering a WARN_ON_ONCE()
> in ip_rt_bug() as bellow:
> 
> [...]

Here is the summary with links:
  - [net,v5] ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
    https://git.kernel.org/netdev/net/c/2998147b59c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


