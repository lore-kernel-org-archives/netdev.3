Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACD29B20A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874880; cv=none; b=kvyK3/81dzap0E0Y8LTMWh6qBbBwJjLh2Mrw9LAdtoKAd2FNnFmjXRkSukdRc8C73Y0Etye7w9wgTUoFuevJT5mjBWvUWNwA1iT78LtfrY8uvjR76Hd41QT+3QyOtOamJcHLgSjVhIEY4olrNqKuLWJiLaBn0E/pR9JzXaL8yPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874880; c=relaxed/simple;
	bh=x93QRDjIqbA7uDpumln7d1KCUSvKI4g02T3B3OgJMD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g4j6GAygLzJ63Ca+phiGpjOj71vtVKbxwtH/quMu5nY1Bu+Ykm7tk90Vmweyl+GtmrWf9KM9yHyFtMxpQyNW6v4/6jUV3QTD/WUnLD2Btqe5o6AouWZ8etJhJJxqy2IXsTSzfZPpgP5Wfq4u9smHxa244ej+Oxm9ZNsgOAd2s8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3VqEvCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VqEvCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706431F00A3A;
	Tue,  8 Sep 2026 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874870;
	bh=s0L3qxzaymUU6nRBWRTyyyVApVjf0UoXJ+M0U8UCdSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G3VqEvCHNv6UIeEssL3gy4/CrVGhmk/yVqhxYniJi81xbPZQzFpNDTynFMdcZYCOU
	 9Hs6AAc5HBK9l8DU3oCsvJCXzCV1ssBVIo0+13g/Yb50FnplGthf7Pjd9kmD5JZ1Ne
	 4SxcacYJCExZOOzR3x3IQlkeQ0Hc6M20Krec+3F9gaIgFXQqRFNkGu+UirULW0Aibu
	 moYZxA9R76AhyQajvDtevF8xS43Dm/b94ws85bLcV0Dp2cs0+nIkX+svDudnO9fdTR
	 4SDnyIdJDeSopPNz+ciZWbsp8J6CN5H3jr97Mpsl08cBT0YVdgqUuWGpprM71ZnUxD
	 N1eXiLAJtHsvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5694B39EAF45;
	Tue,  8 Sep 2026 13:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: sysfs: use ops lock for speed and
 duplex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178887480914.3534869.13453609743422351581.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 13:40:09 +0000
References: <20260903133314.3703381-1-wang.zhan@smartx.com>
In-Reply-To: <20260903133314.3703381-1-wang.zhan@smartx.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Sep 2026 21:33:12 +0800 you wrote:
> Reading speed and duplex from sysfs currently holds RTNL across the
> get_link_ksettings callback. This unnecessarily serializes monitoring
> reads with unrelated rtnetlink operations.
> 
> On CPU-throttled hosts, a periodic reader such as node-exporter can hold
> RTNL for hundreds of milliseconds while an mlx5 callback runs, delaying
> unrelated rtnetlink operations.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: sysfs: factor out link settings read
    https://git.kernel.org/netdev/net-next/c/fc73b71c1bdb
  - [net-next,v2,2/2] net: sysfs: use ops lock for speed and duplex
    https://git.kernel.org/netdev/net-next/c/5d074ded6714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


