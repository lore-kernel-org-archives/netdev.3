Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7D2CCB9
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774669821; cv=none; b=Rau/N4CpumTs/4rvxeKsh5RvUqr1SuaXiVPAtM87I8HcW7uKPDHPvusLa7TWAeim7g58la2XB7WFZBuZf0BmiFC+WNKbAqu97n1svVlqx8jMG2owukd/0SrjglLls2AOvIwhdF1kmNHCEaRrxJTBmZeaayeRgzOO25BLeV9F5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774669821; c=relaxed/simple;
	bh=yR/FuOVGKgBchVOsZEHqaKySh+BfBESsojYajZms+zM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OeeqyARB6O8X88VWEJNv6dlP06hxKvvfjvmm/1AsQUxTNrHg1Hq9XZG83A5UYeT1ox8qSvFI5hX/W9SJeDnErdjtTF7PJXGJjQ8Fz287Dp7fbY51Ray3l+SvZBKftGXZVkFE/EdhYF+JsMt0UunRxk7xYupqDeiAwrP8k+bHagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEK40ha/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEK40ha/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E53C4CEF7;
	Sat, 28 Mar 2026 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774669820;
	bh=yR/FuOVGKgBchVOsZEHqaKySh+BfBESsojYajZms+zM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AEK40ha/Lm+CN84wyuYJ8YQFpt289IhsX+mhYV6Si3O1Ngb4DfQFOLotJ1Q10MZCP
	 axN4s2gD/Wg7/C/jHyHk8OxqAYsBgjbL/8GLhez/F1xljVAyzO5jUSqUu2AGeyYHld
	 dTdZECDeFCCGCNJhBHsQEnegf6mHhTPSurg48p1OBb7mBx/dZul/ODqJAbJulJUZJ/
	 QHUV/bGiR9cD5QBjBRZ+92Nt1YtbAMFkceAbneDPVgvDvDTGfKrf6PEXPcqVSsinhm
	 hKbZJzAAOyAtXzpPmNGboCPD0P5LFMnRTiaUt5zMDdz5eRkFl3wFbCoMOTiwGj4btr
	 7Ovkg4fHZKvDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E393930181;
	Sat, 28 Mar 2026 03:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466980654.4171339.9896790329642244763.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:50:06 +0000
References: <20260326204310.1549327-1-xmei5@asu.edu>
In-Reply-To: <20260326204310.1549327-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, bestswngs@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 13:43:09 -0700 you wrote:
> m2sm() converts a u32 slope to a u64 scaled value.  For large inputs
> (e.g. m1=4000000000), the result can reach 2^32.  rtsc_min() stores
> the difference of two such u64 values in a u32 variable `dsm` and
> uses it as a divisor.  When the difference is exactly 2^32 the
> truncation yields zero, causing a divide-by-zero oops in the
> concave-curve intersection path:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
    https://git.kernel.org/netdev/net/c/4576100b8cd0
  - [net,v3,2/2] selftests/tc-testing: add test for HFSC divide-by-zero in rtsc_min()
    https://git.kernel.org/netdev/net/c/5d17af9eb2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


