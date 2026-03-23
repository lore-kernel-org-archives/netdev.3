Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A740DFBE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225218; cv=none; b=sbWyV3yxM4oVWZl0FRt9N19OWvVbjYFC5IqfsSFL9DYVWambcsX5hDKm6n1OnWhvJd5nd7WPE21iIHcX4/QzeiqPh/yNa9ZuqI4kk+xzVfhBwAhCnB+02cpqvMBCN8iVku30KJBe2Z/oPgYfFXCPf4/1dFbEybkT/o6ZzPCI8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225218; c=relaxed/simple;
	bh=FddenOTFioJHYwodYeb1Qzvx5jpTbT4vC8qg2toYa6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PFNLkEq9Ri65DeyVG8mtOX1qp4c+uaT/R+12FnjKuJ94XMvybNkfXIcqJx7Fl8GQBKmCPmv7Qp4S4kd5jD5MmP4aGykRTjOyOkb2ZLaFboKe7OnkvqxpA9niOUJo/k+8PbdRjwl/cz267tCAGUVd93hzIvUnvlIXHq5u7FHI5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6YFTbWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6YFTbWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC130C19424;
	Mon, 23 Mar 2026 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774225218;
	bh=FddenOTFioJHYwodYeb1Qzvx5jpTbT4vC8qg2toYa6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W6YFTbWGvms0Ml3QwmNlpdoTBQh6ef13BfdrAfaTn0cVkmJIDWtisKd79CSVYBlNO
	 W53BjAXkuosUG2PQJDnL7x9hFRfTmbwdckRGwTA6ZX38om20KPWEt0OSIR9g2/p2sn
	 obwwvysJ0WtvR9ssZ+RJ4iiUpLkmFypm2EBfVCe8iyy+xXqC1V9xY/fiJM9gqFxhpP
	 j9inOHbx/M7ve95wP2LtMNBWZNJPFf4DQG6lu3+nxqHEjSOrFHVJcPj9DSYrHa7rt1
	 ty+vx5vvKs2l4gAW9hNIGI7JkKph6d6lCq4hVVhks6IlIuPxkYg3caaUT7cda9o8da
	 CDb42Jd9UgxTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9B3808200;
	Mon, 23 Mar 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/3] devlink: show devlink instance index in
 dev
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177422520679.3639702.9032336969676090718.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 00:20:06 +0000
References: <20260316154418.625026-1-jiri@resnulli.us>
In-Reply-To: <20260316154418.625026-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 16 Mar 2026 16:44:15 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Support for identifying devlink instances by a unique index was recently
> added on the kernel side:
> https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us/
> 
> This patchset adds the necessary userspace support.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/3] update kernel headers
    (no matching commit)
  - [iproute2-next,2/3] mnl: add fallback implementation for mnl_attr_get_uint()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bef61beb2edf
  - [iproute2-next,3/3] devlink: show devlink instance index in dev output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=36252727bfc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


