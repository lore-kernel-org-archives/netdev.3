Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B673C062C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032672; cv=none; b=Dv6qInq5iuwhTCY/38aNolGiy+mx0BaL2P546/XZA0qTd2YJyagu1wcTJEWwlIk1PbmJFCepKmOQaSwaqZzBoTLR9gEH36Mxq01/rS7FtsAI8ahQzyDtTZCJVK7HoIAaHPcXcLQD4fctuhfwBIXZBOyoexgVGAh5yEQhyz9Zddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032672; c=relaxed/simple;
	bh=A9cjco/C90QhezIetenvoUprZH47whuZE0ukFXI4sqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D94C8WjvryTZ0yi7n2J/6BmNAQt3rrcGJKk4uRaSRQGotg8TanGeCCsLW0GAJtNGuCqVcMzLmRlqRh/6eQKfE7WyU4WroG+rHLH/X8RZAveia9S4jV73FQ+lqKuopQfuc0uClt/ogaCvkKqTN15lDkJTMtGK/Q7u0p4rqtAHrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZV4w61w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZV4w61w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB351F00893;
	Thu, 10 Sep 2026 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032668;
	bh=8njf+L9lVH6bH13W34aJIn09DlZ1MOvyB504VfiFMCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cZV4w61w9qxfZlk5CzmL2Y57RBg8WK/79WkXoTxgrMlOUoycs29N5KRCVYfBY9A28
	 VsSgqHj9S4PZFX75Csvk1uXt2WKwy6ym0qQlHkf13MroHyc/u+DdNQ+4Qadb6F2yT3
	 dR9ue+jbiRtIc/agb4cd6akXfs3cqyFWtAC2I1ZgAHtRvKNTvEij7mU3h6oD7cLhYJ
	 ujNGmYUGUtM3r8K9sd02lpwwBnBCGETNl+MX3EUb0aLUmIaoXvkQB/UNtKmreKBQFN
	 zempNWZlyvjfj/96wVmfbGlNzJKjYRoUInr8d5GjgXVUJkCIFfxhl0SKjYVg9xsChy
	 L4PSwT+yC/TWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D095F380CEFB;
	Thu, 10 Sep 2026 09:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net/sched: cls_route: fix bucket retention and
 handle recomputation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903260563.1313352.1176366413751818687.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 09:30:05 +0000
References: <20260907192133.2639067-1-victor@mojatatu.com>
In-Reply-To: <20260907192133.2639067-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 16:21:29 -0300 you wrote:
> Patch 1 is the v1 patch, unchanged. route4_change() can move an existing
> filter to a different top-level bucket, since route4_set_parms()
> recomputes the handle from TCA_ROUTE4_TO/FROM/IIF. The filter is
> unlinked from the old bucket, but the bucket itself is never freed once
> it goes empty, so route4_delete() keeps reporting *last=false after the
> last live filter is gone. That pins the empty tcf_proto and leaks it.
> The filters linked to a bucket are refcounted now, and the bucket is
> dropped from head->table[] as soon as the count reaches zero.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net/sched: cls_route: free emptied bucket on filter move
    https://git.kernel.org/netdev/net/c/1853f30cf5c8
  - [net,v2,2/4] net/sched: cls_route: Reject handle aliasing
    https://git.kernel.org/netdev/net/c/b74a8455a2f2
  - [net,v2,3/4] net/sched: cls_route: Fix in-place replace
    https://git.kernel.org/netdev/net/c/41e85e54e564
  - [net,v2,4/4] selftests/tc-testing: Add cls_route bucket move and change tests
    https://git.kernel.org/netdev/net/c/e190a7aabbea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


