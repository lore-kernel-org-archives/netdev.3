Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DF311958
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861874; cv=none; b=rIUBNj4lvQkQst4Li8m0jagb7yBCaIwN0FbtmhihhRqCqPxlHYAE4EVPFJwSIGVjkFYw3Amk0cGaaDp/Wo9EQKEuvemF2CsNgzWYyuGXWLp8vUOXUsftndNFIe/3t6issyqia6utC6YxIaLixQVIrNGCvKVKkaR2fpQtTWOVrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861874; c=relaxed/simple;
	bh=SPi+Qvnw+li5cqqkRuQeqB6TXsaLtISSABWhXTVITZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DvbROSSCMLfT4l4kMpJJdOWwKXlTPlX1AZzfnYPGslzpbO4XvoBiOC106ghT9L6GH/CypiNs+TyAsnwmQokr0CjYeyP6mwbFLkd3poUH3ugR8N13z4NBegDw+Z1Iw49eTVct4KRRO4P1lnnIAOxCTIc0I5HOCr2h0312CplCYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgBWElNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgBWElNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD51F000FF;
	Sat, 19 Sep 2026 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789861872;
	bh=/ev4jXxFTkiXpzfH4URbgcWSUf8fd3jKTLX/kzqjrd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HgBWElNHPOkRN/PSXnMIZwrlNDIqU5utM7Wyvm8w97smfeBlA2faZI/3+XVNItbML
	 t3xXWO0jkQHky7BiySDiCel8Py2RaQJ1KD1+vSv0dxM5aS5YqA+XqhhxsyxTfiFTOI
	 6RYrKEBmex/yErP6Zu0RlMp1XCu9N4r0VUnGXK75zxnoFu/zKCZf422hya5dO1svrJ
	 EsEZ2/m3okei/qSmxTh6wxtHcHc3V1XXzVcneHktJBdIDNeLchy+U5RvuD8LTbWkGL
	 /mtvo3jIRRe4LZkylyG2ceqWX/Sz4NehqxvWDOpXxY5lA88YxDR/AERJ3saDOMMkhT
	 ifrGoiRaTFGyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B8392447F;
	Sat, 19 Sep 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net/sched: sch_hfsc: bound the classify
 inner-filter walk with a drift budget
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986180515.1496100.14100930465908315089.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 23:50:05 +0000
References: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
In-Reply-To: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 06:57:32 -0400 you wrote:
> hfsc_classify() applies the "filter may only point downwards" level check
> only when the filter result carries no bound class. A filter created with
> a flowid gets res.class set once at bind time, so the check never runs for
> it during classification. hfsc_adjust_levels() can later raise a class's
> level without revalidating existing bindings, leaving two binds that were
> each legal at bind time pointing at each other; the classify walk then
> bounces between two interior classes forever with the qdisc lock held and
> BH disabled — a soft lockup from a single packet. The stuck walk trips
> the watchdog:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget
    https://git.kernel.org/netdev/net/c/8a60ade2277e
  - [net,v3,2/2] selftests: tc-testing: add a lateral-drift hfsc classify-walk test
    https://git.kernel.org/netdev/net/c/1e24c4f2ee44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


