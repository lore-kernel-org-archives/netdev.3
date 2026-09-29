Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281950E58F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679612; cv=none; b=d1ICmMsKfq3k7W2k//Uam2bp3FyMIeemCRHDK8Ay050nAtVXlE7l2x7aeeIAOsvj6+BlAVYEyav8E1aH2dM8Ica8cXReF8yjnGumNhBx+1R1XcPKuZnEH7b5MPeQIObH8fv+iriu9V1v7rYXPpfOK8+7IEB3Y0us+fjHGgFa+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679612; c=relaxed/simple;
	bh=5efsZJZ+M2WSLihtpZq/EqcYIiSRUJlWq9fRWp7ESyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r2/Kk97spzshnmjdorWQtr0c5cFFUKxUX2q7IqV3sK9y2vYAsfcG8KR5vPBvu1ngdnHKPy9yXpfdVmJ1cWzUtJTAs85/nlOrS6ddy2YWF3OqHBa4BpqnlMWK/rB/Huj7PZacxSsq+QrppJVhQGDFFnJriDznFgX4Jjh8nWWbLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXWVepKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXWVepKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB71F000FF;
	Tue, 29 Sep 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679606;
	bh=6T9Di3cEZaIrPhmPxW0EhikD8n6QpoOJonZVDzGP4gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dXWVepKDU0MYaml9aY4tb8tNXzP4G3viovXY1wZp62PgiVITX9ILtsKfjiaTRiEHw
	 V4pIsIRupKxQ5ReGjbIltfedcwjpcmnRGvPTUQO+CmteXG/VEdKI7JVbY1Lr1O3SDd
	 Ng/I+X9e9qsCG82vk5KIiz1hRJpc97kzUSsjG8B5LPbPmx5C0veAuwv44rxQ8PVHro
	 iHhLHvrjjZK7/g/yfWJPx5SA8onLG12tVSqT7qNDW7WGWHhDr0FNof0qDpI3OGxvi4
	 GseX1jpU4fDRBMBfUIuBpD3Q4IZW5SEdB3nTcL0VUnnDEo1P22ODBm+tIDTNbJT2//
	 RwabnPpP/lV9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A29739263B1;
	Tue, 29 Sep 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: fq_codel: match the no-drop threshold
 to
 the packet size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067960478.430916.14919565233820396894.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 11:00:04 +0000
References: <QDISC-34MS.v1.20260925165535@mojatatu.com>
In-Reply-To: <QDISC-34MS.v1.20260925165535@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 26 Sep 2026 14:03:27 -0400 you wrote:
> commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and mtu")
> clamped both q->quantum and q->cparams.mtu to [256, FQ_CODEL_QUANTUM_MAX].
> The two fields mean different things: quantum is a DRR credit that wants
> the 256 floor, but cparams.mtu is the CoDel no-drop threshold
> (codel_impl.h "*backlog <= params->mtu"). On a link whose maximum
> transmitted packet size is below 256, the floor extends CoDel's
> minimum-backlog exemption beyond one packet and delays drop or mark
> eligibility by several small packets.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: fq_codel: match the no-drop threshold to the packet size
    https://git.kernel.org/netdev/net/c/d031465acc36
  - [net,2/2] net/sched: sch_codel: match the no-drop threshold to the packet size
    https://git.kernel.org/netdev/net/c/54518e0e827f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


