Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C828E0
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410226; cv=none; b=lQhRdC9Hiqz70KMdCqpQSnHs97MvxDVY6brXHk8KvJpJ0VcJi+7T+O74V7aOXOhZfs4Qyc1JX6BZU7PEIb9xSHZMIcVRiQ883b/DYj2hlKeFz8gOctwHMNt2QbTm0JbRLPyYgsvHrSljmAB4pmASFcKsNqGa+oA+xDMW9lCr1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410226; c=relaxed/simple;
	bh=oGX8zI4hsebQkhaHqFyLO/l7T0imWZXOM6cVBFNryks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jeFhrd7vr0yrjbSXpkIi3CJcEg5y4yssTOW+LhadQgqoui+45g/GxTBEuKpb8vVv+O6hXcu2r3fiJKz1Pa7dIDo+5J9DEcdm8TaWk3MiJmegdsYZh9yxGZatrSdLGNUyW7KeWaSMPeyb7z1NsLHgf06tBNlmwzH9XJUhNjF8Q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9UmnzPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9UmnzPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B4AC116C6;
	Sun,  5 Apr 2026 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775410225;
	bh=oGX8zI4hsebQkhaHqFyLO/l7T0imWZXOM6cVBFNryks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r9UmnzPKKFVm5JRbzQIMSHXB3yB5tf4l0ip0FBnFCB78m2j6R7t5kHIxZ02fXJnY6
	 aAxhRE8kV3MtyrEIaclE1876PKc0iptv2oVE7U0I0tZW9xFREaEyc0LlP6M1MwCnAM
	 exU5fNWGEKGzpAyfSa9d1jGbU0c69zHwT4PzCD9pOr6qE8oDsotxzXa0HAWtwykqIi
	 suxBAyeV5DwnJlbOYPz452NVqOkCXjZJmry577S2DUqfpI21Np1ub00zYVjwvMC6GH
	 VWzyT2wF2z5jXyg6Yr5rtlFuk7gUK5HM3wBpkxMBE/7U1dlCz/r3z+qatimssXC/kP
	 IlwKyFTht70TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0D3809A22;
	Sun,  5 Apr 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] dpll: Send object per event in JSON
 monitor mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177541020529.2002766.11711932063195027157.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 17:30:05 +0000
References: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
In-Reply-To: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
To: Vitaly Grinberg <vgrinber@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 29 Mar 2026 10:51:01 +0300 you wrote:
> Previously, monitor mode wrapped all events in a single JSON array
> inside a top-level object, which made piping the output to external
> tools (such as `jq`) impossible.
> Send a separate JSON object for each event in monitor mode,
> making the output suitable for line-by-line consumers. Skip the
> global JSON wrapper for monitor mode.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] dpll: Send object per event in JSON monitor mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=52204702bde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


