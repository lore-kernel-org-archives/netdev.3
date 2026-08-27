Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC234DCD6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860875; cv=none; b=Q62hNTLWXOhtQcAP07c11tZoZ1Xn+i2DqsofMUfjwV8cnGGu6UvjqeD3BncvirONx5vWtYQ5Ax2jr4gx0TX1YBCTTcNUryuWEdfYLXr5ds1QsO8PzzanP66DkpINihsOZhmt6xoluKsGB39Wbq1C0Suvnq4047xRuZ4lgDsLbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860875; c=relaxed/simple;
	bh=w8etpI+fi8QjNcBJ6zpDRLPcvm1NtG7l5nq7Xx0tuu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ffY6E8mlsYvoERroa1GZ/zENulbE6/8xJIcroH39/2vsdaKR6UdL5ZnUiLUXZP4NMhrONbmmOtVpe+xl9JjzWH/ay4R9beZ7ZxX3R+nv7y1pTr8rkkGZtYq9iVROVwxfR3PKUs9REjDl1z38NepuILs3DnLq9Q7Fm7eMxkbey30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hflruq4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hflruq4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596E1F000E9;
	Thu, 27 Aug 2026 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787860871;
	bh=FnuRgtZKBe1bGu+0f9bgtpxX7cDVBFO52LLN7qA+nSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hflruq4XXX0TiUfGvnyd12/08jXV5h08aA4IddTHPirVHJNk5yg2HIJiPkhjffbiy
	 xV6o+sTA682khx+9Om2xlV8D/pIMb4UyMhdTauZj3K3NwG136mLTaPjHLI7mt/eStv
	 04oIwk+6hNRTAQKipNKHBmMJudYMzj8lpXVCov4opxwWaK+Y+R7789vWw9e4+Ec33N
	 QCXMICnUAESJsAKo0EyFfXTGK9/UyZIM1fN8fZc3/YolUDK++7eHqjvkOPahnv4PmT
	 VUD0xlvxm/8oFFPnsvKKmlUTwrOvR6yHvZ0sbzE2jwMnhuD9pANp8mmcT+rAZ+wk4y
	 MdCrjP0qNSVeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567653809A8D;
	Thu, 27 Aug 2026 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: sch_htb: limit htb_classify inner-class
 filter hops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178786081689.1822702.7289627258613833642.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 20:00:16 +0000
References: <20260826143339.271935-1-victor@mojatatu.com>
In-Reply-To: <20260826143339.271935-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 11:33:39 -0300 you wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> htb_classify() follows each filter-selected inner class by switching
> to cl->filter_list, but never bounds the number of hops. A filter on
> an inner class can point back to itself or to another inner class that
> points back, creating an infinite loop in the packet classification
> path with the qdisc lock held and BH disabled — a soft lockup / panic
> from a single packet.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: sch_htb: limit htb_classify inner-class filter hops
    https://git.kernel.org/netdev/net/c/729c4896ab82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


